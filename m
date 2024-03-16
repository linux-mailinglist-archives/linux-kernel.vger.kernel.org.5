Return-Path: <linux-kernel+bounces-105174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B0587DA10
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 13:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E191F2189B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D191E18036;
	Sat, 16 Mar 2024 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ckFJmsEz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ACE17BA9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710590847; cv=none; b=bxZJel6dU3K8lIGFxn+qr+4k9Tcy+Bmkt4J7wSAtq0AZ1/hZsJ5UQ+aqE4FC9G2HwnbYK1BT78caVlMXQr2wn2aMiYRYTiPg8Hmb0Hd+/g5kYTGOWcq/FEnRhieYbIiIVM1sM8JIZ5MJlDZVFeEKpp/Im60s/6kwdlBAvApuPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710590847; c=relaxed/simple;
	bh=jKro2/gRgX6heE2Jq0/ZJ4FoBarMH3/aFLbsxgQ6JDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AXdH4+S96+LMN+DVdltA2FMOzV2FrlgcJgNSH3hN6FkofqzKwdYxCu2GxXjylfyfXuIbJ/MBPHU9GaQTV4oUvjcfQdi6mRISRfts9PctdSTWPd5Gsq00mHIGGrbdQte2LNSE1QzqGKf63XBs5m3Mfc7ez0e6YwLnihSSGUsCQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ckFJmsEz reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DCD3440E0196;
	Sat, 16 Mar 2024 12:07:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VJkoq3PToC3h; Sat, 16 Mar 2024 12:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710590836; bh=Sib9tg+0McX6SOT0e+44wERQmlUitSpPWoz5I1BPfG0=;
	h=From:To:Cc:Subject:Date:From;
	b=ckFJmsEzH33EAjt7M+HhynOpIEJW2a5zLfwywQ3vcLQgu8Ju1VoxU9435Ku6mqtHQ
	 ywMxfCTye939gU068QCPE4Dg/yJlhyB5KFSB5vRS/yUsgXj9/cpDEzf6wrNaBTFki7
	 6RIJZdAMiqDe3u5w4/Df67SU8RmxHK5UVOj3AToCgN1VRssw28ob1ffW6hiuGDg7Js
	 b1ryk+ONFpvyXxXPXfAnm0k7iObB/TZSnyxuIloXFpJjvkqsYLoRA2bG2+Kz26bX3s
	 tsm2UHcZfH4XD4uMpYQWAZYXjjCBYYq3aqqECjjhU+xFF9ZTMxRCvA1Yy/JyWUe+QI
	 QLCep+E3pxhsXKCqNIJqVL7dbh7CL18DfqcGB7l538C4oDn+Oc0d9NkBVJH2s4nHUp
	 KHBO0BIQVBQPfH12/s5cAFsPNTAauHpF+qKqubUcnZ/vQrzLpJia5TfC77jB2dr1UB
	 kQlQ3S0vMYXRrzOKxRi1EC4/BWgr0U4DUp0g5rMrYhiksHHA/VSENXUBurbpHlFT1O
	 pFi+jLQ4wPqQF43xBQA4y8gq6bRy/Q2fLydTpcmOehI/FtIGP0fIfMmNW49s2REjxC
	 dba4qjQawfhvL8Fw2WR1NyEcwiAawaIsP0dh6x7oascbngPLGA2uNQMTZcEIfElVlj
	 6CV13hEaxSXEuqqZOJ5UGGzE=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 93DF740E0174;
	Sat, 16 Mar 2024 12:07:14 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/cpu: Get rid of a local var in get_cpu_address_sizes()
Date: Sat, 16 Mar 2024 13:07:06 +0100
Message-ID: <20240316120706.4352-1-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Drop vp_bits_from_cpuid as it is not really needed.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/common.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ba8cf5e9ce56..9a34651d24e7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1053,18 +1053,9 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
-	bool vp_bits_from_cpuid =3D true;
=20
 	if (!cpu_has(c, X86_FEATURE_CPUID) ||
-	    (c->extended_cpuid_level < 0x80000008))
-		vp_bits_from_cpuid =3D false;
-
-	if (vp_bits_from_cpuid) {
-		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
-
-		c->x86_virt_bits =3D (eax >> 8) & 0xff;
-		c->x86_phys_bits =3D eax & 0xff;
-	} else {
+	    (c->extended_cpuid_level < 0x80000008)) {
 		if (IS_ENABLED(CONFIG_X86_64)) {
 			c->x86_clflush_size =3D 64;
 			c->x86_phys_bits =3D 36;
@@ -1078,7 +1069,13 @@ void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 			    cpu_has(c, X86_FEATURE_PSE36))
 				c->x86_phys_bits =3D 36;
 		}
+	} else {
+		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
+
+		c->x86_virt_bits =3D (eax >> 8) & 0xff;
+		c->x86_phys_bits =3D eax & 0xff;
 	}
+
 	c->x86_cache_bits =3D c->x86_phys_bits;
 	c->x86_cache_alignment =3D c->x86_clflush_size;
 }
--=20
2.43.0


