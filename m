Return-Path: <linux-kernel+bounces-93773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCF2873460
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8CE1F2259C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2A360891;
	Wed,  6 Mar 2024 10:35:23 +0000 (UTC)
Received: from out0-208.mail.aliyun.com (out0-208.mail.aliyun.com [140.205.0.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF88605BD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721323; cv=none; b=PVbBdqt0e0eDHb1EIVrBk7fGmPMlUcVjiN9vi9l7eju7GcYLmF+ztOcjmrVXqUT1nHhxQu2/BxEiqZ7u9MDlcO1z9hj8eZFXYp9ZN5xYsT0meSDSBfkd3rRWgn79fKcxc48JpkjHYNs3dxx8PRSjwMKL1RKLnUDn2hDWCgYFYxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721323; c=relaxed/simple;
	bh=zBjAivud5mTNfsW4xRhvWvtLToxsTYEYwBbFkqAQ+MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5GqYu9yBqQcYElHzg5woCsuSwWikOosGot0t00zU2y6VVjvy9YDytA35mBEGZHW6fTYK29/hU/vetImVq9ZTD9XGChM5pTWl4bAW7rz6MYxKIMubS8WH4/eLRoRU4izNH4125LOLUOfoBhdqKqeHOExK4wDVEz2o6XRwpjHp2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047205;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.Wgbn-K9_1709720384;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Wgbn-K9_1709720384)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 18:19:44 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <jani.nikula@intel.com>,
   <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <intel-xe@lists.freedesktop.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 9/9] um: Fix -Wmissing-prototypes warnings for __warp_* and foo
Date: Wed, 06 Mar 2024 18:19:25 +0800
Message-Id: <20240306101925.1088870-10-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These functions are not called explicitly. Let's just workaround
the -Wmissing-prototypes warnings by declaring them locally similar
to what was done in arch/x86/kernel/asm-offsets_32.c.

This will address below -Wmissing-prototypes warnings:

/arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for ‘foo’ [-Wmissing-prototypes]
arch/um/os-Linux/main.c:187:7: warning: no previous prototype for ‘__wrap_malloc’ [-Wmissing-prototypes]
arch/um/os-Linux/main.c:208:7: warning: no previous prototype for ‘__wrap_calloc’ [-Wmissing-prototypes]
arch/um/os-Linux/main.c:222:6: warning: no previous prototype for ‘__wrap_free’ [-Wmissing-prototypes]
arch/x86/um/user-offsets.c:17:6: warning: no previous prototype for ‘foo’ [-Wmissing-prototypes]

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/main.c                    | 5 +++++
 arch/x86/um/shared/sysdep/kernel-offsets.h | 3 +++
 arch/x86/um/user-offsets.c                 | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index c8a42ecbd7a2..e82164f90288 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -184,6 +184,11 @@ int __init main(int argc, char **argv, char **envp)
 
 extern void *__real_malloc(int);
 
+/* workaround for -Wmissing-prototypes warnings */
+void *__wrap_malloc(int size);
+void *__wrap_calloc(int n, int size);
+void __wrap_free(void *ptr);
+
 void *__wrap_malloc(int size)
 {
 	void *ret;
diff --git a/arch/x86/um/shared/sysdep/kernel-offsets.h b/arch/x86/um/shared/sysdep/kernel-offsets.h
index a004bffb7b8d..48de3a71f845 100644
--- a/arch/x86/um/shared/sysdep/kernel-offsets.h
+++ b/arch/x86/um/shared/sysdep/kernel-offsets.h
@@ -6,6 +6,9 @@
 #include <linux/kbuild.h>
 #include <asm/mman.h>
 
+/* workaround for a warning with -Wmissing-prototypes */
+void foo(void);
+
 void foo(void)
 {
 #include <common-offsets.h>
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index e54a9814ccf1..1c77d9946199 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -14,6 +14,9 @@
 	COMMENT(#val " / sizeof(unsigned long)");	\
 	DEFINE(sym, val / sizeof(unsigned long))
 
+/* workaround for a warning with -Wmissing-prototypes */
+void foo(void);
+
 void foo(void)
 {
 #ifdef __i386__
-- 
2.34.1


