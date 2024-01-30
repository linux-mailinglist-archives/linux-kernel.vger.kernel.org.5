Return-Path: <linux-kernel+bounces-44445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789E884221D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A9D1F2DC67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333F367A06;
	Tue, 30 Jan 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OTjnlGn6"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB59679FD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612412; cv=none; b=HRHc1AOuXSDS66+Z4peOyu0SPsHRTQ8GXowLeD/5e/n2HNzIOcCWqNJTELF4gR1K3O95sRVocc53rxMNGpIwZGjoVCkFJZB3awF5isGz4UPyCd+wVOMtNAgu6kG3GXTwpksRObmV+MbyMGYAlDzwfmxe2eZYPraIFt1AnoWNZzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612412; c=relaxed/simple;
	bh=jgeafpJI+MYDNRoPvXNTdDfiHQEnLFcoETk5RR++mSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cD58jd7RfoI5IKPLJo7avPkl9jF11CHcaugnrZ6LNLpj54vxmrZukwy7vTS7NPX4L9d9WLjjZGO9eIJ4XViQRmkWevL0kXjUzteGVo6ExepDrgMJJrZdCSOTITGDKWt2ZkZof2gwYzS+JnkmxT/qpB8oXHhwoD5/8jNo3azgyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OTjnlGn6 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DE99840E01FE;
	Tue, 30 Jan 2024 11:00:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id km_ryPGWyPCV; Tue, 30 Jan 2024 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706612406; bh=njqwLfrv56leHkX+AonJAZ0qg8TBI+C0ajpxz+Cn0Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OTjnlGn6LgS9QuS49oeJ51uVOHhFXrZOzFkMxaJc5FTZQUM24RJpzByIImRZrdi0x
	 Kp2+1i8t7mAruSVfSzPb690CUJlhdcs0PytNvnek5izutBVARqUTr9MFO1DY9t9RGx
	 +ZZwfdjnAMnzDCcioulTTZlnYSJ/coCMeLjFOTjtxNVnZ0iRCfTsZMSIt35DMeYmm9
	 fXQE/HHPm1irE+ccxrGeKAZMo1O4Yr65tfwXWjPq6geTE4HTI3vr6Ma7zoZNmIsoqT
	 xLCFrDXpy5SuZlNKNgBVk8Yn16ccb42OeYZsss/J4TEdDvqGR5ue7oICVvUTvFiFbF
	 /JHxZaEqNYU39PUHzb7mLaaOoONCHxYXYv5ijYtlyYzsQAp6Srwbu080o4VwBR30Sh
	 4Hys7u3OV/Ua4IILMgTSSSFcA+u92rKeCTNGHJ01C/QfR5IIJjK6r5ps4uGVQDZGUC
	 1KCg4RoWOpkiqMafjgFIHWqmEL1NIRqrCBG/SOO1W8+EUTVtgdCi/eg6p+Rx3x8M8I
	 OMINe6Uev0RagiBQ4WGdhhptBaNEv80IeOucy/5psVL05+ysZD/4RORE5wQ8cookqb
	 8TZIkv69YgilpOIzZ0YeT3Q662yAeneeLhnWqIRfIs3ALBgHVyl/zFjFgf6ih84Lik
	 CVZJWoo4SLSZNQyLEN/Rq1/A=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 867C840E0177;
	Tue, 30 Jan 2024 11:00:03 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] x86/alternatives: Optimize optimize_nops()
Date: Tue, 30 Jan 2024 11:59:40 +0100
Message-ID: <20240130105941.19707-4-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130105941.19707-1-bp@alien8.de>
References: <20240130105941.19707-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Return early if NOPs have already been optimized.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/alternative.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
index 2dd1c7fe0949..68ee46c379c1 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -233,6 +233,10 @@ static void __init_or_module noinline optimize_nops(=
const u8 * const instr, u8 *
 		if (insn_is_nop(&insn)) {
 			int nop =3D i;
=20
+			/* Has the NOP already been optimized? */
+			if (i + insn.length =3D=3D len)
+				return;
+
 			next =3D skip_nops(buf, next, len);
=20
 			add_nop(buf + nop, next - nop);
--=20
2.43.0


