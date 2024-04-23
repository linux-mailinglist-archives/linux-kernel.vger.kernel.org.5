Return-Path: <linux-kernel+bounces-155040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B68A8AE4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5167A28783D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5613D532;
	Tue, 23 Apr 2024 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="MDga8oGh"
Received: from out0-200.mail.aliyun.com (out0-200.mail.aliyun.com [140.205.0.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FF813CAA9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872451; cv=none; b=GQ5htI6h3fR2URUm1GIeBpwb61KywGIrTfUSTZx2+mWWJVE7oq9MUU8Gv9O7OXwJNjUdbVmcnfGeSLwfCPGfcAE2ZQE75CkDYB3xHFOYpR0wlu6wBs64H2upfdC342cDPJ75BP9AdiuxJzWqRlan2ig9BMuG3wcBW7zHxLB87jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872451; c=relaxed/simple;
	bh=9ZMqQqyu2e0uZqwNom9mTXgrUp5iks65fikGnwgJQtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ll/N6iCpFgEBlbMS3IO5hJsg4c5jY4yHQvu6xARgzIW0Vv2qM1vBX/ksvZ6gip34rrt5R9SEL0CmW5MrbnJW1kC376QL6Y804QtfzquG+iiLo251ZtD6CYxPNio5fpaJyPaeJLdKeS4xh4oJmhOtiRWwCv5XnN6+BvnFSGHPNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=MDga8oGh; arc=none smtp.client-ip=140.205.0.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713872446; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=gIvw0W9jwz4ek3Tvi63O6eytV7zW5ZlAtrTwF4fjS0o=;
	b=MDga8oGhwyrw1tJ0Gmx6FZaQvGnsdOnm1O9k4ikjLcYQEOKAIQPC9bL9+yHq9mPFEPXpC9JJONGPkXNj+GRKw+IAyZFgVZ/vdklzzQrhNxpDqu6utx99BdV7VK6FJcsUwdtLn/8DbQaq0A7HZR9HSfQXVfUj1pJRd35F2VNajjc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047193;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJTUYiD_1713871513;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJTUYiD_1713871513)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:25:13 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 6/7] um: Fix -Wmissing-prototypes warnings for __vdso_*
Date: Tue, 23 Apr 2024 19:24:56 +0800
Message-Id: <20240423112457.2409319-7-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The VDSO functions are defined as globals and intended to be called
from userspace. Let's just workaround the -Wmissing-prototypes warnings
by declaring them locally.

This will address below -Wmissing-prototypes warnings:

arch/x86/um/vdso/um_vdso.c:16:5: warning: no previous prototype for ‘__vdso_clock_gettime’ [-Wmissing-prototypes]
arch/x86/um/vdso/um_vdso.c:30:5: warning: no previous prototype for ‘__vdso_gettimeofday’ [-Wmissing-prototypes]
arch/x86/um/vdso/um_vdso.c:44:21: warning: no previous prototype for ‘__vdso_time’ [-Wmissing-prototypes]
arch/x86/um/vdso/um_vdso.c:57:1: warning: no previous prototype for ‘__vdso_getcpu’ [-Wmissing-prototypes]

Meanwhile, also fix the "WARNING: Prefer 'unsigned int *' to bare use
of 'unsigned *'" checkpatch warning.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/x86/um/vdso/um_vdso.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index ff0f3b4b6c45..cbae2584124f 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -13,6 +13,12 @@
 #include <linux/getcpu.h>
 #include <asm/unistd.h>
 
+/* workaround for -Wmissing-prototypes warnings */
+int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts);
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz);
+__kernel_old_time_t __vdso_time(__kernel_old_time_t *t);
+long __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused);
+
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
 {
 	long ret;
@@ -54,7 +60,7 @@ __kernel_old_time_t __vdso_time(__kernel_old_time_t *t)
 __kernel_old_time_t time(__kernel_old_time_t *t) __attribute__((weak, alias("__vdso_time")));
 
 long
-__vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
+__vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
 {
 	/*
 	 * UML does not support SMP, we can cheat here. :)
@@ -68,5 +74,5 @@ __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
 	return 0;
 }
 
-long getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
+long getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *tcache)
 	__attribute__((weak, alias("__vdso_getcpu")));
-- 
2.34.1


