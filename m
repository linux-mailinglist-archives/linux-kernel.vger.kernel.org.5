Return-Path: <linux-kernel+bounces-154053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D53AD8AD69F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD1D1F20FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F273E47A;
	Mon, 22 Apr 2024 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSi/U93X"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06272E62D;
	Mon, 22 Apr 2024 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821437; cv=none; b=Cl1uaX5iR+nTh61LiPwt6ICUBrtkQ4giJjRZf53REdvqU1OyLc3OOWo2T9XNU29ZPQqpwh3hO0McgNyuSe98KBp/K16wRFZuIx5nBD/aHhsituZTWT4laRsrkq9KjOTUleNX/9TLwrFs3NC+bF4lgH/BVd0e+WUeVCo/MCEa4sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821437; c=relaxed/simple;
	bh=8OkoOGVcUuDmJ9C0ZDEoOT8qoNeBbO96MI1mreNHBUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2XaN8XMG/Pi5pWGa6EvPobVjllAZyszkg/P9FyBmHgmfOUpZ9pBwymZc0O7HFMKiApm+l8iNiiC5qMSAvwowW+npU8vr490rmf7puk2AMgeC5796bKqnvt9zE/E4VehTtDXSLDYjxcBKHdoYwDLfB0wPfcI2q5g2qRA4xQjwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSi/U93X; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41a77836fa6so8643355e9.2;
        Mon, 22 Apr 2024 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713821434; x=1714426234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7KsZzo89keBW/R65fPmWDsgpK4/r+4FeNTi5sISBeU=;
        b=CSi/U93XRH3poRl00pvoDWAUHjdpgmrOwsGAHKSt8JrfSOPFyBy40Ff+qsherO4jZd
         hFIeg5kJAYBYWCmIhcMK5oHYq8xIPmpEiPGbLuQEHYSNeiXzC+UW3yZYA8RBnxjwJdN8
         n7piXCtA9FKRcNb+VHRx2ziSwqi7FDDRxW3grQYOMyRMywglMCA/1SYZuZQMuyToFeWp
         kAvZN7sRvDyyUQmQwh1iosxLp93bH2OwgiyY60G7y7qKpVAWJ3bQPCyZcJWu+VRMuyU8
         1Wa9IIiGBDbq3NdOc0hyAhrUP60tloHZY2Hvnw9VETR4W6qPprnnN19q6RFI81c27Ptm
         SV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713821434; x=1714426234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7KsZzo89keBW/R65fPmWDsgpK4/r+4FeNTi5sISBeU=;
        b=MzpzfYdLRv5kpfWcgjwCDFid35PIV5Sfl5CRdfamsra8c/n50RZU5hWDh6h4o3pu3h
         1/iO93mjOYG9Q5gnttdifHjQ9INBVjnTJyp5kj0ibv1EDVevk4J+tgVs/k4IJFuu2+r8
         RKNINVSYr4+4kmG3vcO7I4kFVuPIjzLyBj5V+wdD7J6AmN4NY7wjgaoy9vcWUFI+6T9W
         NDholUdW5Q4gINp3yTu2PEaj9Kh0aCp9MnOSF4/frL9ZSJockhPJpdhGuAxdOiY2Pzoy
         ShjsLdsZUQCPhnIQYEVKsLyysVBMinfV1RJDV2eH36u+kjarfPCDSBGEj0kFOgNcqV93
         h1ig==
X-Forwarded-Encrypted: i=1; AJvYcCUAY69ZXHsAijBV2Eft9CgO/n3Zk+4A8BTF/1wl4wUe0eBIvJuodWOxzklzSWvfq16qIricyMR8bzdTiMmCcqZtRz+amA7kxeXFmAVZdM9VOGjO0/WC5dLoLzdfBZPNSpGy8xKq9GRidepxPWjNw5fZZQ8F3MhLgHUHFdHGsNPSFWULr7AZcVZWe7M=
X-Gm-Message-State: AOJu0Yzcb2FxFYQh01kWxMxW20XQH65he9uV6MoxC/LpTv4LTWcNK9Xw
	yp/O9Z1U4seim8WE4Jh5GBIFyZIFSphh/02uTOUiOYpWa7NtKeJ0
X-Google-Smtp-Source: AGHT+IHt/RP9yBQfiS7wQHUWPFK7LdIaA+PTIsAKChkIP/bMfEvHLz0IAEBnF7tSI5COnllTKXgStA==
X-Received: by 2002:a5d:4451:0:b0:343:9f91:82ba with SMTP id x17-20020a5d4451000000b003439f9182bamr10334598wrr.54.1713821434043;
        Mon, 22 Apr 2024 14:30:34 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:ab0d:124:447c:bf37])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4844000000b00349f098f4a6sm12886793wrs.53.2024.04.22.14.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 14:30:33 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/6] mmc: renesas_sdhi: Add compatible string for RZ/G2L family, RZ/G3S, and RZ/V2M SoCs
Date: Mon, 22 Apr 2024 22:30:03 +0100
Message-Id: <20240422213006.505576-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

- RZ/G2UL and RZ/Five ("r9a07g043")
- RZ/G2L(C) ("r9a07g044")
- RZ/V2L ("r9a07g054")
- RZ/G3S ("r9a08g045")
- RZ/V2M ("r9a09g011")

The above SoCs have HS400 disabled and use fixed address mode. Add a
generic compatible 'renesas,rzg2l-sdhi' fallback string for these SoCs,
where fixed_addr_mode and hs400_disabled quirks are applied.

Note, 'renesas,sdhi-r9a09g011' is dropped as we will be using
'renesas,rzg2l-sdhi' as a fallback string for RZ/V2M SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 53d34c3eddce..1828c37e0198 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -210,7 +210,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_r8a77990 = {
 	.manual_tap_correction = true,
 };
 
-static const struct renesas_sdhi_quirks sdhi_quirks_r9a09g011 = {
+static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
 	.fixed_addr_mode = true,
 	.hs400_disabled = true,
 };
@@ -255,9 +255,9 @@ static const struct renesas_sdhi_of_data_with_quirks of_r8a77990_compatible = {
 	.quirks = &sdhi_quirks_r8a77990,
 };
 
-static const struct renesas_sdhi_of_data_with_quirks of_r9a09g011_compatible = {
+static const struct renesas_sdhi_of_data_with_quirks of_rzg2l_compatible = {
 	.of_data = &of_data_rcar_gen3,
-	.quirks = &sdhi_quirks_r9a09g011,
+	.quirks = &sdhi_quirks_rzg2l,
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_compatible = {
@@ -283,7 +283,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a77970", .data = &of_r8a77970_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77990", .data = &of_r8a77990_compatible, },
 	{ .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_nohs400_compatible, },
-	{ .compatible = "renesas,sdhi-r9a09g011", .data = &of_r9a09g011_compatible, },
+	{ .compatible = "renesas,rzg2l-sdhi", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,rcar-gen4-sdhi", .data = &of_rcar_gen3_compatible, },
 	{},
-- 
2.34.1


