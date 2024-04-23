Return-Path: <linux-kernel+bounces-154975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B046A8AE3C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D101C22A59
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D6B7C6DF;
	Tue, 23 Apr 2024 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="zpOORgxm"
Received: from out0-219.mail.aliyun.com (out0-219.mail.aliyun.com [140.205.0.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87A47E59F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871523; cv=none; b=kqBrhPJt0A3k6KlZPtzBwdWp5w5ml0d1So8SGCwCjMv4MEKYPYZeDS5d3L5iYMb/LZ2GNWOKC+FmfK62guvFpfqau+4irtRLqlAtGyK62KFy1JbngecJG93zzNuNvNOK10Kwa/9NVHR9rZKl+4hS9oAoPLwAbwdFbXlQvmtTYhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871523; c=relaxed/simple;
	bh=Ghj0/V/dH76APPyaKDAlG7P8Sbut9JOjTVMQKESCzlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjHRDr9viNPBPKPv04gw7gvk+YZKRRolT3cPlCdWSFcAIEq+6dVeITPFumr1APERgNRQnvrv3Nzx0CahqvXR/kDyM75TirvXkfMX9vLZvZ4Nzhzl+Ve+Ut2F5Bin5wNHhw9QZyDHKvvCnOCCa8qH6L5b6yi+T79qqLWIpFh0S9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=zpOORgxm; arc=none smtp.client-ip=140.205.0.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713871513; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=35K+byay5rbsmnKXw4pAmKxWNtRGPhfuJu7mpbXe+7w=;
	b=zpOORgxm7y4rkGhVbqR04m2MFyKaDYASe2TUzeKv1mXU2S4H/xiRBR/iDPWdwYJQLJPGZMHKOZ5+q/CVn7q8e1PUDhYVU2OAdxGDX3+rlqE8JO1yEgssL7h4kzqiPK2YsW0Me4MDZKNDD0bb3Qp/24diOQW1WKS/lZK8VEi+K0w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047212;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJTUYhj_1713871512;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJTUYhj_1713871512)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:25:12 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 1/7] um: Fix -Wmissing-prototypes warnings for (rt_)sigreturn
Date: Tue, 23 Apr 2024 19:24:51 +0800
Message-Id: <20240423112457.2409319-2-tiwei.btw@antgroup.com>
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

Use SYSCALL_DEFINE0 to define (rt_)sigreturn. This will address
below -Wmissing-prototypes warnings:

arch/x86/um/signal.c:453:6: warning: no previous prototype for ‘sys_sigreturn’ [-Wmissing-prototypes]
arch/x86/um/signal.c:560:6: warning: no previous prototype for ‘sys_rt_sigreturn’ [-Wmissing-prototypes]

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/x86/um/signal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
index 263e1d08f216..48e87b45adba 100644
--- a/arch/x86/um/signal.c
+++ b/arch/x86/um/signal.c
@@ -8,6 +8,7 @@
 #include <linux/personality.h>
 #include <linux/ptrace.h>
 #include <linux/kernel.h>
+#include <linux/syscalls.h>
 #include <asm/unistd.h>
 #include <linux/uaccess.h>
 #include <asm/ucontext.h>
@@ -450,7 +451,7 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 	return 0;
 }
 
-long sys_sigreturn(void)
+SYSCALL_DEFINE0(sigreturn)
 {
 	unsigned long sp = PT_REGS_SP(&current->thread.regs);
 	struct sigframe __user *frame = (struct sigframe __user *)(sp - 8);
@@ -557,7 +558,7 @@ int setup_signal_stack_si(unsigned long stack_top, struct ksignal *ksig,
 }
 #endif
 
-long sys_rt_sigreturn(void)
+SYSCALL_DEFINE0(rt_sigreturn)
 {
 	unsigned long sp = PT_REGS_SP(&current->thread.regs);
 	struct rt_sigframe __user *frame =
-- 
2.34.1


