Return-Path: <linux-kernel+bounces-155230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719388AE72F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125101F262B3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA0512E1E8;
	Tue, 23 Apr 2024 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="BIeHsS2U"
Received: from out0-212.mail.aliyun.com (out0-212.mail.aliyun.com [140.205.0.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760F86AE6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877152; cv=none; b=qyz42/Zty+SMsQJ/w/2aSZAU72o8Wsok8SB1ymS2xhjTNI4lazfHuJJYZJNtlPGzx6j731q9kyDFBV8jIwQ4EqqWAlVuArI4FI0CfNAmsRMvWQH7gRPTO1N8HdnVeL4dosUUaiRUdrpGYMSrSl8k0oKYHbwcN+JgEERPS/smYNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877152; c=relaxed/simple;
	bh=Ghj0/V/dH76APPyaKDAlG7P8Sbut9JOjTVMQKESCzlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q90rEB9DafAFS2XDK7hHQ77lL8XYJ+wQppW/zTGtgnBDBiNWMq/BWk+vtE5x4E2Kr4o1dm6bu26Ek4xGiDqAvrH0v8XoOyce0Io40wb9klvifkWjMyFXRUg2qA8g6+1pBPy1E+bN+gSiwcl3J1FvyB0db3iU1Ltc0wVzSxW2yyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=BIeHsS2U; arc=none smtp.client-ip=140.205.0.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713877147; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=35K+byay5rbsmnKXw4pAmKxWNtRGPhfuJu7mpbXe+7w=;
	b=BIeHsS2Uzj/6qCjaRZAhRQT3+R66E/p1pDrrEDbWGyfim4p7fklOptIT9Ghh4xgnahizd1S+rfM2ji2B+vcq3bef3/Uu29hnU+frNMvOxHE+Mac4Zh/ho1PQaaZg9iCOk3f9jBoCouEbSCJYgamfxVF11CZtGGRzGfOR1BHYcDI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047208;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJXNjSF_1713877146;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJXNjSF_1713877146)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:59:07 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 1/7] um: Fix -Wmissing-prototypes warnings for (rt_)sigreturn
Date: Tue, 23 Apr 2024 20:58:52 +0800
Message-Id: <20240423125858.137709-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423125858.137709-1-tiwei.btw@antgroup.com>
References: <20240423125858.137709-1-tiwei.btw@antgroup.com>
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


