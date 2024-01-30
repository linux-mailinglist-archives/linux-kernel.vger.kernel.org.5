Return-Path: <linux-kernel+bounces-44446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2483884221E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DEA1C23A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7738D67E75;
	Tue, 30 Jan 2024 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ksB+8sP2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64D67E63
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612416; cv=none; b=UkU104PO5+lk8vwWHTVkL7D3knYd45WZNdH6Gv4V4iXBKrOy3trJ+WA/HvSA/VEPoqqEGwxNP1cGeMMacunh3gJgljvtPmPqmIQgjmPDab4+9EZtbgzlTOlGTU32IGub+Fai0VDQNxfTG4YrCd/K1B/UsS5x+9dP/vBQ1s39zLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612416; c=relaxed/simple;
	bh=iZE2cJ+UUdAouN6yh05MZbqDS0n/dNAjBnlGvlNnGZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBDfJIdWj8JHDP4uYRfqM83Ry+XB3Wegd2bfvxjT117/wiTTWjyLUcNoGDTeGVqFxn5AWykhuOHsarTtu13KVBE5WbkNj9E+CuRW82k0VNh9n1xUd9LPVjKJVIhCUGw1AI1GHsjusiGZLnr4+39OJSxa9sDXa2e2SveKNLQYYx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ksB+8sP2 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6302440E0205;
	Tue, 30 Jan 2024 11:00:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ca8CsOTBOhjH; Tue, 30 Jan 2024 11:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706612411; bh=RoNfl/PZJS4s6CCR7YHy3tG03HlOLbZeqL1F+quJhz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ksB+8sP2xf8kWs2Ebc5SwExLY6g1pvpCRQl4iNU+U30tU19CH7boN+YZpymBmIbp6
	 BNw5OhJTQo/urOeoNcwv6Wa8zHBGi2CcP3kA4Idh7ZELmtOK1tsmAABiVz2nQAuR88
	 lKiGYtpF5FBNtqSpkYJMyks/vAmHJKsvAxYuRg3MLda88z70bz1nRsaVgDsvDoJjmi
	 WGTjigW+GhhvUnUBjt0UgvR+o5qP6Ck49Z+7tvm5tVAV2nO1fQ4B1PcKE59hi2P5Ae
	 3RTjdOrlpZIAXtZ4YWbZJ/t0hBLBFKVgiCTuZRxungRMA6DGYgeU4p+Oy1uDb6zKhp
	 r3QE69jRr3e+Jjcq/aBHpGew1CcHvnEZO4Tw0WC4x0KmOrTu09avJxmiTLz+YPkNIt
	 eb7MdS6aNM/IObRGFxBWmGPOJe9mN4fmT/EGUqHoPByxU6fLyTjGD1FL8qzx+sokjq
	 9AI/2RV7bD76I6HaDlpmN2z5NBwYT2MziRl4TNGPThLGcWKXwLsf4cGgQlS7v+lOoA
	 TdsniwDQjhZVlUT15ggyxUpY2LnYjDn1XF18UsfB6TKa/o3iWpqnZkCpmPOucpV+3p
	 ylzP6F8O4vFoUqyw8LEKSfJ11QroiyeDKZOJ5dg+HfiULQ9r9GGTK6nRSDhCTWGPIr
	 OSIv0t0HmvMC8N3yBGXvES+s=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25BDE40E01BB;
	Tue, 30 Jan 2024 11:00:08 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] x86/alternatives: Sort local vars in apply_alternatives()
Date: Tue, 30 Jan 2024 11:59:41 +0100
Message-ID: <20240130105941.19707-5-bp@alien8.de>
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

In a reverse x-mas tree.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
index 68ee46c379c1..ee0f681ae107 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -440,9 +440,9 @@ static int alt_replace_call(u8 *instr, u8 *insn_buff,=
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


