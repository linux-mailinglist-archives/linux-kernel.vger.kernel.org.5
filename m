Return-Path: <linux-kernel+bounces-95700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC6875173
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB3A1F25FAF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D0C12FF87;
	Thu,  7 Mar 2024 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bmYvbfHt"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7003112E1D2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820479; cv=none; b=Rp9Cse1dCG9HHdMkrGDw7B/GuR/fnaa0xkaF0aBB2lDSXI/xOftaGMbq7y0/CkiYnVfL9D7USQILRVIfIQJDvrRjPYjNHxqUMmAZu5RtA7GEUHjLzrhsHcNnuKofmC8P1xlCJnQC4Q6JyoVKxIkojDps8Vg+ev6em2u0lwArocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820479; c=relaxed/simple;
	bh=SLToaJ3ozkWSUjsUTyrPGGCTDP/5Lqa8znOubad3iPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kexm9ws6m5uJus/bAOxewLejq6etN8aUkRgIStHXi4X6qnznCZJEfVgKkpiFqIrN03m942N0e8ZZQKHXY4gy5X+czFxc3HKl0rnQpQMppi5s5q0FItgFhxv35DQiIN9A2AiWpZM+7sGOLTvEBZqMc4bN7/nsSvYXKnNGF81MPNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bmYvbfHt; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44d084bfe1so130534166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709820476; x=1710425276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmELIFewI/nFhbbASoQXck1zYfP16lq7b28SpM7LTcA=;
        b=bmYvbfHtY+okw7b5SzD4Lgw9uZzNmdWBiN8SNfPkoa2+kLthLuVwImGTXxR+U3elba
         xLyOwPo+g2TCmtkjCr0L0jVomrkzUIc3l3PW2deqop4LzSKDr+aju21JUSRrTTm0sIR5
         jnsf+h72qBj1Gt2Ky3DT7zVbgf3Avhm0z6KmvSu26oK0uQuLim4ALJc6oLV++jLOkgAk
         MvDpsBPdpwc32K8z9qImPPSKTPyO+0LJBgQJ1+biyoMK4BTqedPCWDkKjvc1LHSuRt0B
         X+AAq/lrskAADvky9Rw4jIZ1yYO81IUHQ/GRA+KC4sdAMLIMQhAahushLYg4HQmwRUn9
         iGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709820476; x=1710425276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmELIFewI/nFhbbASoQXck1zYfP16lq7b28SpM7LTcA=;
        b=uz9EGjFsJc2jbrusvOo0Gp0b1P+iPI92R5YFJY4MnC/TSIapWa1gmAQuf8KGOJxUp3
         q3GgNx3TTO/tjGqCTPM/PCv2odXQV3Dso2/9j0oveoOZ594WuTLPz5MHtIXsd27W6gk5
         RbwrCM4WIhQae/PcCg7iEqMKK4W8dtCLGVVtfsRc8URN5zgGBlwHR1SSHU7axhsWCYK/
         Ec6NwuD+u2sEJ/QGt60B5z6SjXTE3t+cpZWwoaLgxbPW6M7rHxoX8lz9XUt8fyu0Rsv9
         EESjvB507wefE5UE7wOBPbKmYsUvET9MVqB64hkYiJTpzwnIPVKCLUxMJM8g021EviYW
         ueJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpdx11dUIqReZubDwarcgAEbhkMoryx1O3Cnqf7OXIjdFkbhagycM/IqB0jr9Pu4kMpeTrQ9CNaXhxEsiS5EUtlYMTmZoxSSYASkAz
X-Gm-Message-State: AOJu0YxmES1nmUjeQEgoqzFMiK9P1EMOwvjBkE962lyl7s2ZyN0D0yp5
	FxkmFfoL6umX50W3wGjixyZBUSUWbNPT58ul0EQsxY5kXoshZP6mYOxHuxNkIuw=
X-Google-Smtp-Source: AGHT+IHFuySMCgCweGoMPRrH2V6CX1wFnBARAUgpnKcanVWrRGuzj2M3JjeQySxkjNgCeH3UHsRU1A==
X-Received: by 2002:a17:907:20e3:b0:a44:4c9e:8809 with SMTP id rh3-20020a17090720e300b00a444c9e8809mr12234809ejb.32.1709820475986;
        Thu, 07 Mar 2024 06:07:55 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709067d9700b00a42ee62b634sm8200648ejo.106.2024.03.07.06.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 06:07:55 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 07/10] clk: renesas: r9a08g045: Add support for power domains
Date: Thu,  7 Mar 2024 16:07:25 +0200
Message-Id: <20240307140728.190184-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Instantiate power domains for the currently enabled IPs of R9A08G045 SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Change in v2:
- used DEF_REG_CONF() to describe register offests and bits
- updated MSTOP bitmask for ddr domain
- updated MSTOP config for oftde_ddr
- kept the same description for gic as the CPG_BUS_ACPU_MSTOP register
  documentation in the latest HW manual version is wrong and it will be
  fixed; proper description for GIC is located in "Registers for Module
  Standby Mode" table
- haven't added watchdog domain (was missing in v1, too, by mistake) as
  the watchdog restart handler will fail w/o patch [1]; with this pm domain
  support the watchdog will fail to probe; not sure what is the best
  option until [1] will be integrated

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20240228083253.2640997-10-claudiu.beznea.uj@bp.renesas.com

 drivers/clk/renesas/r9a08g045-cpg.c | 61 +++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9a08g045-cpg.c
index c3e6da2de197..c64769082f5b 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -240,6 +240,62 @@ static const unsigned int r9a08g045_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A08G045_DMAC_ACLK,
 };
 
+static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[] = {
+	/* Keep always-on domain on the first position for proper domains registration. */
+	DEF_PD("always-on",	R9A08G045_PD_ALWAYS_ON,
+				DEF_REG_CONF(0, 0),
+				DEF_REG_CONF(0, 0),
+				RZG2L_PD_F_ALWAYS_ON),
+	DEF_PD("gic",		R9A08G045_PD_GIC,
+				DEF_REG_CONF(CPG_BUS_ACPU_MSTOP, BIT(3)),
+				DEF_REG_CONF(CPG_PWRDN_IP1, BIT(2)),
+				RZG2L_PD_F_ALWAYS_ON),
+	DEF_PD("ia55",		R9A08G045_PD_IA55,
+				DEF_REG_CONF(CPG_BUS_PERI_CPU_MSTOP, BIT(13)),
+				DEF_REG_CONF(CPG_PWRDN_IP1, BIT(3)),
+				RZG2L_PD_F_ALWAYS_ON),
+	DEF_PD("dmac",		R9A08G045_PD_DMAC,
+				DEF_REG_CONF(CPG_BUS_REG1_MSTOP, GENMASK(3, 0)),
+				DEF_REG_CONF(0, 0),
+				RZG2L_PD_F_ALWAYS_ON),
+	DEF_PD("ddr",		R9A08G045_PD_DDR,
+				DEF_REG_CONF(CPG_BUS_PERI_DDR_MSTOP, GENMASK(1, 0)),
+				DEF_REG_CONF(CPG_PWRDN_IP2, BIT(0)),
+				RZG2L_PD_F_ALWAYS_ON),
+	DEF_PD("tzcddr",	R9A08G045_PD_TZCDDR,
+				DEF_REG_CONF(CPG_BUS_TZCDDR_MSTOP, GENMASK(2, 0)),
+				DEF_REG_CONF(CPG_PWRDN_IP2, BIT(1)),
+				RZG2L_PD_F_ALWAYS_ON),
+	DEF_PD("otfde_ddr",	R9A08G045_PD_OTFDE_DDR,
+				DEF_REG_CONF(CPG_BUS_PERI_CPU2_MSTOP, BIT(2)),
+				DEF_REG_CONF(CPG_PWRDN_IP2, BIT(2)),
+				RZG2L_PD_F_ALWAYS_ON),
+	DEF_PD("sdhi0",		R9A08G045_PD_SDHI0,
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(0)),
+				DEF_REG_CONF(CPG_PWRDN_IP1, BIT(13)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("sdhi1",		R9A08G045_PD_SDHI1,
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(1)),
+				DEF_REG_CONF(CPG_PWRDN_IP1, BIT(14)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("sdhi2",		R9A08G045_PD_SDHI2,
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(11)),
+				DEF_REG_CONF(CPG_PWRDN_IP1, BIT(15)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("eth0",		R9A08G045_PD_ETHER0,
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(2)),
+				DEF_REG_CONF(CPG_PWRDN_IP1, BIT(11)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("eth1",		R9A08G045_PD_ETHER1,
+				DEF_REG_CONF(CPG_BUS_PERI_COM_MSTOP, BIT(3)),
+				DEF_REG_CONF(CPG_PWRDN_IP1, BIT(12)),
+				RZG2L_PD_F_NONE),
+	DEF_PD("scif0",		R9A08G045_PD_SCIF0,
+				DEF_REG_CONF(CPG_BUS_MCPU2_MSTOP, BIT(1)),
+				DEF_REG_CONF(0, 0),
+				RZG2L_PD_F_NONE),
+};
+
 const struct rzg2l_cpg_info r9a08g045_cpg_info = {
 	/* Core Clocks */
 	.core_clks = r9a08g045_core_clks,
@@ -260,5 +316,10 @@ const struct rzg2l_cpg_info r9a08g045_cpg_info = {
 	.resets = r9a08g045_resets,
 	.num_resets = R9A08G045_VBAT_BRESETN + 1, /* Last reset ID + 1 */
 
+	/* Power domains */
+	.pm_domains = r9a08g045_pm_domains,
+	.num_pm_domains = ARRAY_SIZE(r9a08g045_pm_domains),
+	.pm_domain_pwrdn_mstop = true,
+
 	.has_clk_mon_regs = true,
 };
-- 
2.39.2


