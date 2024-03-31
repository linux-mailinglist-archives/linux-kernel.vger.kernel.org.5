Return-Path: <linux-kernel+bounces-126338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C9489354F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA23A1F22E26
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16992146D72;
	Sun, 31 Mar 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VGbgEjZY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6320145B24
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711908077; cv=none; b=OpFAxWAXIBQ2XvecfuPG4cQH5mXIbw3J5v7RePx19sbf9DAkaSBzYBjJQap1EzO7M/lfH8WlC7ryzpqoC9/OAzo59IHoJ1V/w9UbhgfQtRu9eufWTPYdfYzDR48CT9WsOFXbT14A8cne5tOHh2oLlGpMKqAQfcRpJKjR5YU54D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711908077; c=relaxed/simple;
	bh=wW/hM2suVHdvMVTfvZ04ENlpM59FopqQ2RH5VOfXQK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shRjcb6FTcnl8DjXZHNb+VoO66+90HoED8xvp0LxiaJx7aoFsNsk3B2Id7NseEnUfwZwHFwL0fIfSCo/d1tRn4PxMKZyv6g/XTXn1QyCcwgGFJ4/GWuZOKdUU4FyJNViFzqr3ZCzZ1XHY2WTgsnbW6DqXlU9ie+imaItHjOmAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VGbgEjZY reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0ED4840E0202;
	Sun, 31 Mar 2024 18:01:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BRxOl6_4aL4i; Sun, 31 Mar 2024 18:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711908070; bh=kBucdMbXIcOk6bcPF3yfiq/poL2A4vPTnxg3GqSRyTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGbgEjZYIoRzaxGkxRcPoj976yA3EWtUzim+y8+ezm/awOsv3BO6GKEgjMMLCwX5Y
	 ZA2looMQGCsOuzEn/xCGpaa6PHmS2YZSswIIu9C3fwbpe0rE5w0Jv6ZsvmUHpLZyWH
	 xqnee0h1R2hIzUaS4wY5lW5jFABO3CKSNhTKbFyYwhi5GklMaE+s2aZQGY21zFWbVZ
	 AsSpWfOFQWu1ACOqu4x4b5LByglxX3fxeqSisAms96ef+VHbpvTh9V+eMqoSXsPOBn
	 tJkOH3B/k6X50QItHaTC+z0KVUomn3D3lGUbrTkfvCgAT35aFrvY+ftOg88qBh6L/V
	 MOWLft+ta5XSao0kQA2LnQ27jxdpYiL5TBC7YfMSQdftGGpoA4mIgjPFRw0ydiwYK8
	 SOEqILduf2D9so2wJWnFnr9r30eZrTTDSe9Lo+XnTYeAx2AXqtlkF/KXXc2Eft8wl5
	 1061D5rEEhNQZO3otRXNknLdLfD+PzHtaHIixcxzTyTaxZ2qtiDom1bpPm3+3+Ovkm
	 pjrxLEST4Ng0akL7vTnJkCaOV2q/zHmGJCy8E8PguYvK0BkNlOABDWHEltF6h6Z/vc
	 a9z+JQ8KBHIGbKsSxBHXfol3t6oImvjVRkgrLDoi5zwP0R0IJRc9Mj15IPNxtaExqP
	 6fjCd/oAGaHNlOwqVBk1NKoc=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CAF6440E0028;
	Sun, 31 Mar 2024 18:01:08 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] x86/alternatives: Sort local vars in apply_alternatives()
Date: Sun, 31 Mar 2024 20:00:42 +0200
Message-ID: <20240331180042.13933-5-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331180042.13933-1-bp@alien8.de>
References: <20240331180042.13933-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

In a reverse x-mas tree.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
index 67dd7c371d28..7555c15b7183 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -445,9 +445,9 @@ static int alt_replace_call(u8 *instr, u8 *insn_buff,=
 struct alt_instr *a)
 void __init_or_module noinline apply_alternatives(struct alt_instr *star=
t,
 						  struct alt_instr *end)
 {
-	struct alt_instr *a;
-	u8 *instr, *replacement;
 	u8 insn_buff[MAX_PATCH_LEN];
+	u8 *instr, *replacement;
+	struct alt_instr *a;
=20
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
=20
--=20
2.43.0


