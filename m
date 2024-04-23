Return-Path: <linux-kernel+bounces-155231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E31208AE72E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994DB1F26364
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9C712E1DB;
	Tue, 23 Apr 2024 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="WnMVVh/D"
Received: from out0-198.mail.aliyun.com (out0-198.mail.aliyun.com [140.205.0.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A198B7E79F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877152; cv=none; b=RDMqvfIIQigfACLN9Iq/dHRUkmV6D056T9gnt9WCyAeJIX1gD0oCg4XIIpr9SLmnY1bnV9CdhQX8Bs5dgl97ykmzKL55/SCRM0i1xggH0kvYXqHQfsvb7YRpQ4+3hYedf8REp44D9Kc8VZKxFFJufH0K8121OOYcq5JoEsqojtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877152; c=relaxed/simple;
	bh=RZQ4OaKt5l6WjLn4N/d2lAFpl8VZsWoGuYt7dpHlpMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q6hNz6i3T1O9RKsLJwPliSUcqS/fzvsEwlaMuM7wtJbEb9sgfLDT/BtixP19VIj3ly8SsAYcrWjopLWlzByIkq5gJ++qRR18vXyW4r5qLxf6F7UErpHUILYoDdxiDluudjIqhilxYrsIlgpxsJUOeg1EZ5gKqEkm3zZDw7swX2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=WnMVVh/D; arc=none smtp.client-ip=140.205.0.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713877148; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+BtmDxLOgobbye+TMx6cN7HTHoKqXF713ZEoIat3sOs=;
	b=WnMVVh/DCvBEEJ4HNYmNDtyzn7OxvAVJnkQF+U7kl2EEMnNDX+ulJZN5OBmIuBzq0O4J5LyA/GdaUCDVg4GYdGBEyprKQTcHbBT9pVb3GTNl3LaYDkZ44U9gDtYE4Y4eVeL+B8QFA3TQrJL2JPmrYMWpy/ialH7RdNkcuItWYH0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047206;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJXNjSc_1713877147;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJXNjSc_1713877147)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:59:07 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 4/7] um: Fix the declaration of kasan_map_memory
Date: Tue, 23 Apr 2024 20:58:55 +0800
Message-Id: <20240423125858.137709-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423125858.137709-1-tiwei.btw@antgroup.com>
References: <20240423125858.137709-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it match its definition (size_t vs unsigned long). And declare
it in a shared header to fix the -Wmissing-prototypes warning, as it
is defined in the user code and called in the kernel code.

Fixes: 5b301409e8bc ("UML: add support for KASAN under x86_64")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/kasan.h        | 1 -
 arch/um/include/shared/kern_util.h | 2 ++
 arch/um/os-Linux/mem.c             | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
index 0d6547f4ec85..f97bb1f7b851 100644
--- a/arch/um/include/asm/kasan.h
+++ b/arch/um/include/asm/kasan.h
@@ -24,7 +24,6 @@
 
 #ifdef CONFIG_KASAN
 void kasan_init(void);
-void kasan_map_memory(void *start, unsigned long len);
 extern int kasan_um_is_ready;
 
 #ifdef CONFIG_STATIC_LINK
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 81bc38a2e3fc..95521b1f5b20 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -67,4 +67,6 @@ extern void fatal_sigsegv(void) __attribute__ ((noreturn));
 
 void um_idle_sleep(void);
 
+void kasan_map_memory(void *start, size_t len);
+
 #endif
diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 8530b2e08604..c6c9495b1432 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -15,6 +15,7 @@
 #include <sys/vfs.h>
 #include <linux/magic.h>
 #include <init.h>
+#include <kern_util.h>
 #include <os.h>
 
 /*
-- 
2.34.1


