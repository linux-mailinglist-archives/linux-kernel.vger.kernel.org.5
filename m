Return-Path: <linux-kernel+bounces-76850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5C785FD94
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C34B286EE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A103153514;
	Thu, 22 Feb 2024 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="C2pw+fnC"
Received: from out162-62-63-194.mail.qq.com (out162-62-63-194.mail.qq.com [162.62.63.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D115098A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.63.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617917; cv=none; b=KOE6taDZWH9Bs5A+LylBPvONBbWj+51frCwD3Z4pQ5uAXCrT7qlmTEM+cM/uhH7y19qZT4Nklpd+2wz1pmNnpUDbc81tC5cRmSa3N+BxfML7WrJfl/5910FkZ9AvFx/1Qk4kQQ0+tDpNlxTZwAqpLskAmuLJOYLwf7ut07EuLtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617917; c=relaxed/simple;
	bh=ae7acFbeFbOsSBOJq7Wm0wlb7xN42xulyX2kNqEdUOo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=lBS0DJk/SXnOQdnxV8LMt90hy/l5/sgfkYa8WsN/jKsyDg5JakymrmeknuHdw5ib1CS3u4tHoVGKw8KHUtuq8MvT+vuvYpTtHjTnZS+yncTGmErQY3B+Ft2eY8sQDsEBOqbIqyVbT2SRcxx1v1t/LimfkR3OLiap5JQ4ruXAeDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=C2pw+fnC; arc=none smtp.client-ip=162.62.63.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708617904;
	bh=zZh0WkZk+9GyZffXATDDdHfCvt2/6IAILrMFkC15vkQ=;
	h=From:To:Cc:Subject:Date;
	b=C2pw+fnCMVx8xK7NaPwqIQvCS5H+DCeMsCVWLdIfq1pUbLfSwHgqhN9aCTE1BwmUF
	 KjW7TwYEwmy4zckquuYDk8Gb3MOwsNzYb6yrHo0ZIIzyBZMb7R+pMUp4T/8SFy1uer
	 1DfMbu3vC8ujcyPKSrY++iTomni9wYJvUJm6oCX4=
Received: from localhost.localdomain ([2409:8a60:2a61:ef40:7404:388f:486a:7747])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 1408404F; Fri, 23 Feb 2024 00:05:00 +0800
X-QQ-mid: xmsmtpt1708617900tg2p8wddx
Message-ID: <tencent_195B55A5521705954D5EA4873327F8E53D0A@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeh1aHFKTXeWUiHFboQXSuYm5LrX/xH4fLMw9Q+j0Ri7J8xBBS81
	 cdb2yPrpXqYl8cgzWpPku3vaZxed8meca1uKKX8GclfTeXPJFW3nyaCO0lkSmNmV2r7VUB2H7aMa
	 8yaZW1rrGfAgPzgFhN2B+VI847J6ffgNaMtIPiDhUIYNWDBk83ENZkGm7jMWDiedWQNAz/n074Af
	 5TC69wlb1vjsBb6yQeHFmOT6JStU8f7GaM62JlMX/vQnXJwLkqInfHYXXPwZhq3SdhfuqBYKz0j9
	 lGcs3R5qGsRB/+SgmMqy9T6++d/ZTfx9NSiKEGFwMa1uBkVnbCKzHo5y8SJItwHgJWbjwQ5XD1lM
	 H/WD7qFtP4tm3l5kM1qKIxLKYJl9wUtqi90Ql6v76XZ1k3e4ndHI9LGTi/3IHgWmp1+GWAvBVAqD
	 iEmLmbds/ScTO6QqtOvu6yrCswhBzxuOZaRRTL27Y2MA58lS34CDAW8uEl/UI5Tatq2BByOcFXXE
	 Q4kHLIARxKJaMea1I65iLVzC39kNzGJ8p7dZrgXKcpn+/yKPgopSb+tiukSKyx/KnFx9tCnxJjt3
	 QMjlOOjSMlaTEQ8r5ryc9DkyiYFw7DGOVliMm21pAkfIk99VnfgqGvibTYLvZ7WO5iITi04127lY
	 ywL/M7qMS2SWASILuM87q2liLUNh29qi+YokL4w4PxiRx/M9tKn+IXnLx86D/Z3iLslyGqFyzeLC
	 s5OR7Wbjk71WGttqOSUYlFf13x5H2kXug8+ExfDFUyy/ODUGPAbs++43vSRrbItdC+SUnpHNbJqC
	 TkimoG32NdmYQ/uhns87Te2MCn5JieOjyC/y2+RjTRBwBcLrf68PqAnAe0PhGcXx9+bDAcagNfFc
	 onKhXrlNiRQOKrEfgLYTdZS2z7MJ4Lu2ZhaBSQD5/bo1SyZl4+NjXGUdkxN9kHX9ejSuaeGXABrf
	 NJh87dILEQvfUXEMjYJsbmGVwXSm8nNms7kqt1QJ4ukiVndKvaatqqZfbVEn29bF0Fxk6tYToORU
	 qGRjLhS8IKVu9tB2lRqgp0tcz6rOXCieF9v97M09bBg/TzssZERY1gQ4FHg0bNFOWD9y3sgQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: wenyang.linux@foxmail.com
To: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mike Christie <michael.christie@oracle.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kernel/signal.c: explicitly initialize si_code and use ksig->info uniformly
Date: Fri, 23 Feb 2024 00:04:57 +0800
X-OQ-MSGID: <20240222160457.350657-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

By explicitly initializing ksig->info.si_code and uniformly using ksig->info,
get_signal() function could be slightly optimized, as folowes:

	clear_siginfo(&ksig->info);
	ksig->info.si_signo = signr = SIGKILL;          --> missed si_code
	sigdelset(&current->pending.signal, SIGKILL);
	trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,  --> unnecessary SEND_SIG_NOINFO
 			&sighand->action[SIGKILL - 1]);
			recalc_sigpending();
	goto fatal;
..

        fatal:
..
                  if (sig_kernel_coredump(signr)) {
..
                          do_coredump(&ksig->info);    --> contains si_code
                }

No functional change intended.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/signal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9b40109f0c56..8cab55bbec2f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2732,8 +2732,9 @@ bool get_signal(struct ksignal *ksig)
 		     signal->group_exec_task) {
 			clear_siginfo(&ksig->info);
 			ksig->info.si_signo = signr = SIGKILL;
+			ksig->info.si_code = SI_USER;
 			sigdelset(&current->pending.signal, SIGKILL);
-			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
+			trace_signal_deliver(SIGKILL, &ksig->info,
 				&sighand->action[SIGKILL - 1]);
 			recalc_sigpending();
 			goto fatal;
-- 
2.25.1


