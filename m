Return-Path: <linux-kernel+bounces-112466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90BD887A35
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D8D1C20B3E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5A059165;
	Sat, 23 Mar 2024 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N6BNGBcM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SydqB8Ta"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340994C3C3
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711223524; cv=none; b=mCdxHYNSpzX72Q/ZGmY2/TFMSfsc5629RLyjVbkuPt00YoShodCXMQm+fVuwtpEDOJ9Xd3p6vxKkxyqgJ51GYr2bY4EfVPushMI9l5ZfawqvTKGQjPFmHMdUhg59Lkfn3Sf6Q98wbjGlOwsVBMtH8Y3A9IWUVChIM/QX/KZFTTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711223524; c=relaxed/simple;
	bh=3Nxa5aBjaYeomuUjnSGnVU2uphSo7pNI38vouVxBOsM=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=h3BqTWmk045Jb2xgr5RY3yH60RGGKkJHIsPHlRJkBuBWUO/WERAFSdmRyOUzkU8WWpXvFucLg5v3n/y1ojB/t4glNysLAuEyIoCi4Ek+6CsuyZoBWclrMbh70r8Mz52UL13MQJn7L6AIOWiB8QTdM0WoF1StbeY/ago9XYkLMbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N6BNGBcM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SydqB8Ta; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711223520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5mmZYSyibTQ86Vjh8SC+yDAWuhU0roQ3z0+SGbZ1rQU=;
	b=N6BNGBcMeB2mAyyA5zX2k1F6JKdJujLs6lCDcqDOn8LPQoig6m1vbrS3drWgMVkgS4aiGL
	1kxm7Em5Z3HMt8McbRkn/CNaccl37KPgd9NrDxkd0CrY8yvwpF0LkrIj/YoKA3hBmiJPQm
	3QvgAK6F++ERkQnSXehxA9Zny3xmGkgJt/gm3x4VZ8lyQbgMROMSMNV+hdmOn8sThwjTpo
	ARe3A++Qb9d2k6BDutCMNV6v7ettusxSj1CXrzeH8ev+Mk8tL5KqRtyzesa5l7hyGIVzqR
	ctdEbv2CteTGPYDzUxaGi56KOOH+wLQqvlBFntGdOP1sNwkLsVzemL1aGsoTHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711223520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5mmZYSyibTQ86Vjh8SC+yDAWuhU0roQ3z0+SGbZ1rQU=;
	b=SydqB8TaNWuikyhD3E2WiZYumIMtzgvH5+bmP90hHkfrGiZ+289PlJUXRgfOEo2n8YCvcV
	GWIeMFyci58ZK9BA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/entry for v6.9-rc1
Message-ID: <171122346785.2772088.10596056144848184713.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 23 Mar 2024 20:51:59 +0100 (CET)

Linus,

please pull the latest core/entry branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2024-=
03-23

up to:  fb13b11d5387: entry: Respect changes to system call number by trace_s=
ys_enter()

A single fix for the generic entry code:

  THe trace_sys_enter() tracepoint can modify the syscall number via
  kprobes or BPF in pt_regs, but that requires that the syscall number is
  re-evaluted from pt_regs after the tracepoint.

  A seccomp fix in that area removed the re-evaluation so the change does
  not take effect as the code just uses the locally cached number.

  Restore the original behaviour by re-evaluating the syscall number after
  the tracepoint.


Thanks,

	tglx

------------------>
Andr=C3=A9 R=C3=B6sti (1):
      entry: Respect changes to system call number by trace_sys_enter()


 kernel/entry/common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 88cb3c88aaa5..90843cc38588 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -57,8 +57,14 @@ long syscall_trace_enter(struct pt_regs *regs, long syscal=
l,
 	/* Either of the above might have changed the syscall number */
 	syscall =3D syscall_get_nr(current, regs);
=20
-	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
+	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
 		trace_sys_enter(regs, syscall);
+		/*
+		 * Probes or BPF hooks in the tracepoint may have changed the
+		 * system call number as well.
+		 */
+		syscall =3D syscall_get_nr(current, regs);
+	}
=20
 	syscall_enter_audit(regs, syscall);
=20


