Return-Path: <linux-kernel+bounces-108717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7347880F11
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64191C20299
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347A43BBE3;
	Wed, 20 Mar 2024 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="l04TrEHs"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674B3BBC6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928284; cv=none; b=ENhhMZZRbPzC6xStQ+xoT7IBmm/aGUJoyyaV+2TzRmRwoLI7nCdHrO33b/sB+dObxDihz839yyBJU9+X3zRRREc19TARYokPk84xeOpEsWYLENGXz5EfrzoMTcDTDTamS1TrEbu8prYQARPXPIdfxfOIwqoSB3TaOQaEb6qxLFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928284; c=relaxed/simple;
	bh=kmLizDXHgs/iBotX2XWt0DRN99WHQUwnu+ZiSdLsfi4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=e8Yh3QvFohLbrK+QPvPtOAnbRwzq+B6ST9Ii9Uf3c9GJ74Xo6nRigB9BuZWDQpoFDPxZdfOtleAkvUZ59hpGz/Sqip4LI6U78YfDR5q+QZg7FeXcymGJlBYvP2httXP2CwTrCZl89RpA1bfUuyolTA/wOinNLVYlkg/dzMeXqv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=l04TrEHs; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710927977; bh=cc72wCrojgeL0grxxVuvtCMAT1zZo13OV+rd4PAMkik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l04TrEHsvfA1zXAO1a0sSn6sN0TeKrchpH8f94uX8Jmd9kVL3/4YyseSuSjhXxFiV
	 rctGkm/GY8sNl06LscZXvDOejbA0VNIu0N5WLG7n58Hic7gT2aK10mA/gpkzcdW8p1
	 mQrBL/ydYoX2k2zdCl7tSAnAOgC42mT/XOiBrhI4=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id A0511E1D; Wed, 20 Mar 2024 17:40:05 +0800
X-QQ-mid: xmsmtpt1710927605tzis4koew
Message-ID: <tencent_03A5CF0DA11232DDE15D9699184F920DD007@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0ae1WvG5xAKJG6BAAIIU3xaJtk/pya7jjYQzKR7IMr5EjfVeYMr1
	 ana2mqkJx4p+twGCdDiQnhqDOeb26Pq8EM0QjrrlCJeQQD4GaG4hMsKPhlm2wQEfiUOol6/mGB0h
	 vC4ZWqI/ddc8clq8Vx6vuJnbsIIH43oSzIGv6/IOUgul7qMeRn3lJ9RoLBjMrwsZakhYTX0cgmh6
	 oX/LOE0Z5wtqMSc7C0yoN3c3TEjk3Si7m70Hyi+vC3AAEOQij/bApoxarB7GW0vh3bVx7BMSRana
	 MEWyKzP+vBbZTQCwSrHa3cunlFNokno/P8v1+OLCqxwoIwzrduOqs+iHeADtE/s+Hr2d7AxlN2RP
	 3Y3mssstfuOMDQgnxBArcLthGxb0Uz/kDMBKaZynHsxlgeOfpZtV8RtvGhzAOaXY5aCT3EvQx2iz
	 vOX0Hv32MPf3HwSVJ/KZnvxwmG2qLY/1AnyFkvLa73b2XESsixFpIhsb0fuVVZ4vTW72y4pmqFxO
	 MNRioC3adFxW79yVRXe+6iuhWk/5G2SHvyh2Y4ZDGJ+XliVZXLyDnYMCQCRIzi0d3D87BHH0Xxoe
	 tpgyNihGdb4vszeXdbrlV+HxeuFPe0wP7sA7bUCIJC0juqbawVKGXgW4VVF8g7MDV1b+I86ow0/z
	 yKGXObRkDSBor9PGHnUtpbq8yFTzcRzbBkwFQMm2SC0/2u4SmUb3CiRR1XGCy44iQx4LRG6Eru/L
	 UUz/cMXkoHZxNmqJCk5UVA15JvaujDLvOADSyoij4rFAHHquw6op56tp1OwPgWyzI8s3zWdbUif+
	 xZFt2aQuG5pyN2YFBlYyQobZDTEV1LO+EOhtrbe+07rpMZDBkWxuykfvzaUpabHMuxeZJe4ZxNsq
	 h/dl91F5swWQMaMMTA5ZZg4qozngiK7tE2HHAiRHPaLbyYq4IaUY85nm8/V4tVFC1zaNpMvGMHkR
	 Jg651+T0U=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in check_stack_range_initialized
Date: Wed, 20 Mar 2024 17:40:06 +0800
X-OQ-MSGID: <20240320094005.1244716-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000003dc8e00614076ab6@google.com>
References: <0000000000003dc8e00614076ab6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob in check_stack_range_initialized

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master


diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1dd3b99d1bb9..ed0878f4373a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7177,6 +7177,11 @@ static int check_stack_range_initialized(
 		return 0;
 	}
 
+	if (INT_MIN - access_size > max_off) {
+		verbose(env, "invalid access size\n");
+		return -EACCES;
+	}
+
 	for (i = min_off; i < max_off + access_size; i++) {
 		u8 *stype;
 


