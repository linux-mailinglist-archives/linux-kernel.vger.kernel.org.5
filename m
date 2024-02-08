Return-Path: <linux-kernel+bounces-58354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56F784E518
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04BB4B2221E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E40A7EEFE;
	Thu,  8 Feb 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jhg6jjWj"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF2F7E769
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410246; cv=none; b=Ug4b/NEx0K+CJF21brMsN5VAXNEE29AH1KIKKXc5YR3n5KMkrE51Kw6pmAVVz4rY4/B3PCjRAHmbh7CAuvswiOmwM1oASKxSW+4J9kDxrdlfF02CfD690OoZAgPiJwACiyd9xJJqW45YiFNFHLSRHHdJF/5q2ZfL3m8ffKlgcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410246; c=relaxed/simple;
	bh=4V3FamJpmiINURo1Cn6g6NjlG5NU5kyiLTxXmwgKQ5M=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=fOujuCTZA4keD7YQcTVBBumTN2Bj+nfjqXAR0sR60CfpUPnZ5n1kRyKP5fK42y+3AvNKlliOAfZ6bOa7PoVIQ0ula21iGdl1RQoU46dCXjNrI4wfyUazAmQDGZSaNGnmkiiNDvLwOcQeKQZuSWENA72UBK+Q49GCFUEsRFitXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jhg6jjWj; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c4085a960aso37905939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707410241; x=1708015041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DVDRzJBRqPrJdj20pQGGAH3Le30HZ+DEDlSpmFcwYqA=;
        b=Jhg6jjWjG2wYcKBPRp3OZ3cCg/SJRHwy/Oxm1n+y/ntV/L1ADh38ffbgG8W9PwZKoJ
         pN20LnulwyRrYfoPnIEbhl5a1iKx0017lvqMBdu2WxSAM6nuFxePAGXQQGI1ZiC6+IYW
         YvQO6UL1eCp/woij8GkduuCgYqUMxzKR388IS6EaVs20Qg0SmhhP6BorW0NsIZJPbyHR
         f8KGN9Ttde0xgDwvLAhUeu6YPwX+b2A6W5eWNmTqAJ1sJOQX8ZhEGKd0arT0rMEn/Fp8
         J+0dvOAFo5aPyRRfIwW2whrwtKHRZ3s5TfPKpEOdW3ZGpaRKCaRTHe4TO7rIEjMwwo+I
         1+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707410241; x=1708015041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVDRzJBRqPrJdj20pQGGAH3Le30HZ+DEDlSpmFcwYqA=;
        b=tyG2IVuK+I3Is7QHnU9Q5vwYpZolplnYMEIh2gq9e0fPi8pz7b7RhIesrQflTAlLt1
         BQnyykPzcz8lOEEJQvmwYvnHe2fJXYfNU1kBN4+6+kKc7seSgWXsO56n+Ex+MNFRfJZK
         3X2v4V/rYPQO3IwfBmzMwWvLMTtImn/DsruvlO2D7rZWmQTiK8d5kCbrgB6ffhl+dwhB
         wRqPecfk3NJUBuozpi7GjIByj0KkIAeLxH654TbqrKiL8/s1bij6Pozl/g7YqEwpp4K1
         kkT+kgL8pSsOIJVrkMOe3dDyiTif55k0sKzCjusDwO+OYwPaTplk6u/XCfDPWsg96OcB
         pVcA==
X-Forwarded-Encrypted: i=1; AJvYcCUU6+CxMbGcmTWxG/Rns0Dwrm0bdyolP+7H97ZHsBDq338vRElellBykBXWJFs0mNr0109DwW+NtwxbcASo07WlJ9EVUvtRjO4emF5h
X-Gm-Message-State: AOJu0Yz1+kd4YT3BtBdsLbbwzVvNxXBX+zCHzMlH3/hoYfe7ISUmqjei
	rOWeptTLsE/9fD4uRWs0UmB3LYCi9HsJTQ2F+foXvrRKSS4q53IdZ8W7r6/G+vc=
X-Google-Smtp-Source: AGHT+IF6e6JWj/GESqPFkvCFEymbzdOJ/40mqg1b+1ZgqG/IAjRkBb/PQ9gM0RAC/wO4u5+tmEc1FQ==
X-Received: by 2002:a6b:6118:0:b0:7c0:3b4e:8ffa with SMTP id v24-20020a6b6118000000b007c03b4e8ffamr80713iob.5.1707410241184;
        Thu, 08 Feb 2024 08:37:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXRICWdCd3BpNfnHWIOZlzDqRmjtu+ALQf6fbJFRnImfjw/j8e6BcGAwKiSyz3goSHmQMLfpLXA166GKGylIYFPP22tqASNX34CwBXy8CNGCoqLq07Q6ElC20wBd5G1mpiDjspj+8EquasJlIs/KCuQ6c1Eg0HKs/RWwPQLMEPU/ccXdlx7O7zUF0OhqSJDON7FyiTc+cXVMpSlmFzLyBLICOTwGe5TTLrd7aKtcwnedPRs/LicX4o3c19IOYpqwidp9fUe/eCzDtzGR7SotkoNtD2aXKFiZ7UNSbaJUaxcZb1bL3GBqVMm2fXKRBpJCZkZiEPzYyM8UrXxET8d2rrdtdm14vPBzEqweZ3VgSodf+fbHR15K5HTGiTgEadAcrjozO/hbsr0oC5G7OQAzoUGq+cUq8qOvHWbs0LdzxFCGsq+JB6xPeY0k2NQ2zG64tm89z/qO693yBZomZZKSJQ5vEKEEVq93rEsN4EAO1wbzsE+/TC/CSeBBXivwgAte2WG4/tdXUZYOmseklTKKg52+sSCnnJVkfzOG+VClAsuwOiMSK/1oJvM+3m+ryY8ZPuALOrBIN5nj7etvk2dK0rhPBumJ5/kqUOHv5zrBgIk+eUA5S03IvbAWSY9+fcgO7c0cvVU9082qUc3/f2Qywy0XxArbIcJHIKyz97pdVVpPHCzHebqVoPr9JCF1XjGy9SRRzvz5yMwenTK6e23c7D26KG1DDfSfOZmsO45NDg3nwYS5RonPvYjeHCJqtvBBwhH4skXj2KMZWo+KlF23GXSshRn2GqeED3MILt1jus0Wn1xj4iVKu+XwfBYddpqqHLr0DutVyxLN90GbMl7QNLz/xZNC5HcRRaZIfAT5mK0hfPvhaKJP6yaiqxktMjS8lQKuoNn64KeO2oKZMbK3yYtHwDxKzwQNTIdOfGcgmbzKCaDQQXMGEuPGNv1uqgGtyEmMf
 dP9nOuOd51jQVMbOa8R85TnBqE5GP5d01y7wbbDLJxBCHEyr0j9XFJ2aD6bQ+NeOj6Fc/tPDMaPLLSh8o9Le4CgBAQ5dkvQPCQqh6vKd8LyLyDdulLL/bOhPxNSXxjwkxd5o9Q2eEwP5JQzueYncu7NcVQr1ILDsRjMZZh8G05xtHxDJj0uhYHVNQ9Lbm5EbrV9mQaMzCNZx1Lwyizop60p4LARTN145pnym8HGHeRursj5+GLHcjuqKrX8IkJMd8SArxFJ2OcV+YWfQvErpDDp/ozIXdOZPVc1o23c9hsiojjtlEPKqNDkIDJ
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id f19-20020a02a813000000b004712b76c70csm944868jaj.179.2024.02.08.08.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:37:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Peng Fan <peng.fan@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-stm32@st-md-mailman.stormreply.com,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-phy@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH] clk: constify the of_phandle_args argument of of_clk_provider
Date: Thu,  8 Feb 2024 17:37:10 +0100
Message-Id: <20240208163710.512733-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

None of the implementations of the get() and get_hw() callbacks of
"struct of_clk_provider" modify the contents of received of_phandle_args
pointer.  They treat it as read-only variable used to find the clock to
return.  Make obvious that implementations are not supposed to modify
the of_phandle_args, by making it a pointer to const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/at91/pmc.c                        |  3 +-
 drivers/clk/at91/pmc.h                        |  3 +-
 drivers/clk/baikal-t1/clk-ccu-div.c           |  2 +-
 drivers/clk/baikal-t1/clk-ccu-pll.c           |  2 +-
 drivers/clk/bcm/clk-kona-setup.c              |  2 +-
 drivers/clk/clk-axm5516.c                     |  2 +-
 drivers/clk/clk-cdce706.c                     |  2 +-
 drivers/clk/clk-cdce925.c                     |  2 +-
 drivers/clk/clk-k210.c                        |  2 +-
 drivers/clk/clk-lochnagar.c                   |  2 +-
 drivers/clk/clk-max77686.c                    |  2 +-
 drivers/clk/clk-max9485.c                     |  2 +-
 drivers/clk/clk-qoriq.c                       |  3 +-
 drivers/clk/clk-renesas-pcie.c                |  2 +-
 drivers/clk/clk-rk808.c                       |  2 +-
 drivers/clk/clk-scpi.c                        |  2 +-
 drivers/clk/clk-si521xx.c                     |  2 +-
 drivers/clk/clk-si5341.c                      |  2 +-
 drivers/clk/clk-si5351.c                      |  4 +--
 drivers/clk/clk-sparx5.c                      |  3 +-
 drivers/clk/clk-stm32f4.c                     |  2 +-
 drivers/clk/clk-versaclock3.c                 |  2 +-
 drivers/clk/clk-versaclock5.c                 |  2 +-
 drivers/clk/clk-versaclock7.c                 |  2 +-
 drivers/clk/clk.c                             | 30 ++++++++++---------
 drivers/clk/hisilicon/clk-hi3660-stub.c       |  2 +-
 drivers/clk/imx/clk-imx8qxp-lpcg.c            |  2 +-
 drivers/clk/imx/clk-scu.c                     |  2 +-
 drivers/clk/imx/clk-scu.h                     |  2 +-
 drivers/clk/keystone/sci-clk.c                |  3 +-
 drivers/clk/meson/meson-clkc-utils.c          |  3 +-
 drivers/clk/meson/meson-clkc-utils.h          |  3 +-
 drivers/clk/mvebu/common.c                    |  2 +-
 drivers/clk/mvebu/cp110-system-controller.c   |  2 +-
 drivers/clk/mvebu/kirkwood.c                  |  2 +-
 drivers/clk/nxp/clk-lpc18xx-ccu.c             |  2 +-
 drivers/clk/qcom/clk-rpm.c                    |  2 +-
 drivers/clk/qcom/clk-rpmh.c                   |  2 +-
 drivers/clk/qcom/clk-smd-rpm.c                |  2 +-
 drivers/clk/qcom/clk-spmi-pmic-div.c          |  2 +-
 drivers/clk/qcom/common.c                     |  2 +-
 drivers/clk/qcom/krait-cc.c                   |  2 +-
 drivers/clk/renesas/r9a06g032-clocks.c        |  2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c        |  2 +-
 drivers/clk/renesas/rzg2l-cpg.c               |  2 +-
 .../clk/starfive/clk-starfive-jh7100-audio.c  |  3 +-
 drivers/clk/starfive/clk-starfive-jh7100.c    |  3 +-
 .../clk/starfive/clk-starfive-jh7110-aon.c    |  3 +-
 .../clk/starfive/clk-starfive-jh7110-isp.c    |  3 +-
 .../clk/starfive/clk-starfive-jh7110-pll.c    |  3 +-
 .../clk/starfive/clk-starfive-jh7110-stg.c    |  3 +-
 .../clk/starfive/clk-starfive-jh7110-sys.c    |  3 +-
 .../clk/starfive/clk-starfive-jh7110-vout.c   |  3 +-
 drivers/clk/tegra/clk-bpmp.c                  |  2 +-
 drivers/clk/tegra/clk-tegra124.c              |  2 +-
 drivers/clk/tegra/clk-tegra20.c               |  2 +-
 drivers/clk/tegra/clk-tegra30.c               |  2 +-
 drivers/clk/ti/clkctrl.c                      |  2 +-
 drivers/clk/ux500/u8500_of_clk.c              |  4 +--
 drivers/clk/versatile/clk-sp810.c             |  2 +-
 drivers/media/platform/ti/omap3isp/isp.c      |  3 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     |  6 ++--
 include/linux/clk-provider.h                  | 28 ++++++++---------
 include/linux/clk.h                           |  4 +--
 sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c     |  2 +-
 65 files changed, 115 insertions(+), 95 deletions(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 5aa9c1f1c886..64ec624ffc15 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -44,7 +44,8 @@ int of_at91_get_clk_range(struct device_node *np, const char *propname,
 }
 EXPORT_SYMBOL_GPL(of_at91_get_clk_range);
 
-struct clk_hw *of_clk_hw_pmc_get(struct of_phandle_args *clkspec, void *data)
+struct clk_hw *of_clk_hw_pmc_get(const struct of_phandle_args *clkspec,
+				 void *data)
 {
 	unsigned int type = clkspec->args[0];
 	unsigned int idx = clkspec->args[1];
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 0f52e80bcd49..09ae26d0cece 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -126,7 +126,8 @@ struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
 int of_at91_get_clk_range(struct device_node *np, const char *propname,
 			  struct clk_range *range);
 
-struct clk_hw *of_clk_hw_pmc_get(struct of_phandle_args *clkspec, void *data);
+struct clk_hw *of_clk_hw_pmc_get(const struct of_phandle_args *clkspec,
+				 void *data);
 
 struct clk_hw * __init
 at91_clk_register_audio_pll_frac(struct regmap *regmap, const char *name,
diff --git a/drivers/clk/baikal-t1/clk-ccu-div.c b/drivers/clk/baikal-t1/clk-ccu-div.c
index 84555a00f950..97ea3d747a78 100644
--- a/drivers/clk/baikal-t1/clk-ccu-div.c
+++ b/drivers/clk/baikal-t1/clk-ccu-div.c
@@ -322,7 +322,7 @@ static int ccu_div_find_sys_regs(struct ccu_div_data *data)
 	return 0;
 }
 
-static struct clk_hw *ccu_div_of_clk_hw_get(struct of_phandle_args *clkspec,
+static struct clk_hw *ccu_div_of_clk_hw_get(const struct of_phandle_args *clkspec,
 					    void *priv)
 {
 	struct ccu_div_data *data = priv;
diff --git a/drivers/clk/baikal-t1/clk-ccu-pll.c b/drivers/clk/baikal-t1/clk-ccu-pll.c
index fce02ce77347..0e71d5967794 100644
--- a/drivers/clk/baikal-t1/clk-ccu-pll.c
+++ b/drivers/clk/baikal-t1/clk-ccu-pll.c
@@ -126,7 +126,7 @@ static int ccu_pll_find_sys_regs(struct ccu_pll_data *data)
 	return 0;
 }
 
-static struct clk_hw *ccu_pll_of_clk_hw_get(struct of_phandle_args *clkspec,
+static struct clk_hw *ccu_pll_of_clk_hw_get(const struct of_phandle_args *clkspec,
 					    void *priv)
 {
 	struct ccu_pll_data *data = priv;
diff --git a/drivers/clk/bcm/clk-kona-setup.c b/drivers/clk/bcm/clk-kona-setup.c
index 338558f6fbae..1149bcd7617f 100644
--- a/drivers/clk/bcm/clk-kona-setup.c
+++ b/drivers/clk/bcm/clk-kona-setup.c
@@ -773,7 +773,7 @@ static bool ccu_data_valid(struct ccu_data *ccu)
 }
 
 static struct clk_hw *
-of_clk_kona_onecell_get(struct of_phandle_args *clkspec, void *data)
+of_clk_kona_onecell_get(const struct of_phandle_args *clkspec, void *data)
 {
 	struct ccu_data *ccu = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/clk-axm5516.c b/drivers/clk/clk-axm5516.c
index 4a3462ee8f3e..458f44f4c08e 100644
--- a/drivers/clk/clk-axm5516.c
+++ b/drivers/clk/clk-axm5516.c
@@ -512,7 +512,7 @@ static struct axxia_clk *axmclk_clocks[] = {
 };
 
 static struct clk_hw *
-of_clk_axmclk_get(struct of_phandle_args *clkspec, void *unused)
+of_clk_axmclk_get(const struct of_phandle_args *clkspec, void *unused)
 {
 	unsigned int idx = clkspec->args[0];
 
diff --git a/drivers/clk/clk-cdce706.c b/drivers/clk/clk-cdce706.c
index dd3d42d9ad86..1db9fc5d2af7 100644
--- a/drivers/clk/clk-cdce706.c
+++ b/drivers/clk/clk-cdce706.c
@@ -618,7 +618,7 @@ static int cdce706_register_clkouts(struct cdce706_dev_data *cdce)
 }
 
 static struct clk_hw *
-of_clk_cdce_get(struct of_phandle_args *clkspec, void *data)
+of_clk_cdce_get(const struct of_phandle_args *clkspec, void *data)
 {
 	struct cdce706_dev_data *cdce = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index b0122093c6ff..48135ee578c5 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -576,7 +576,7 @@ static int cdce925_regmap_i2c_read(void *context,
 }
 
 static struct clk_hw *
-of_clk_cdce925_get(struct of_phandle_args *clkspec, void *_data)
+of_clk_cdce925_get(const struct of_phandle_args *clkspec, void *_data)
 {
 	struct clk_cdce925_chip *data = _data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/clk-k210.c b/drivers/clk/clk-k210.c
index 7b7329a907ab..2333ed3ed7a2 100644
--- a/drivers/clk/clk-k210.c
+++ b/drivers/clk/clk-k210.c
@@ -875,7 +875,7 @@ static inline void __init k210_register_clk_child(struct device_node *np,
 	k210_register_clk(np, ksc, id, &parent_data, 1, 0);
 }
 
-static struct clk_hw *k210_clk_hw_onecell_get(struct of_phandle_args *clkspec,
+static struct clk_hw *k210_clk_hw_onecell_get(const struct of_phandle_args *clkspec,
 					      void *data)
 {
 	struct k210_sysclk *ksc = data;
diff --git a/drivers/clk/clk-lochnagar.c b/drivers/clk/clk-lochnagar.c
index 5561a2c66b69..5b773787a225 100644
--- a/drivers/clk/clk-lochnagar.c
+++ b/drivers/clk/clk-lochnagar.c
@@ -215,7 +215,7 @@ static const struct clk_ops lochnagar_clk_ops = {
 };
 
 static struct clk_hw *
-lochnagar_of_clk_hw_get(struct of_phandle_args *clkspec, void *data)
+lochnagar_of_clk_hw_get(const struct of_phandle_args *clkspec, void *data)
 {
 	struct lochnagar_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index 3727d5472450..3ce2453c116c 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -145,7 +145,7 @@ static const struct clk_ops max77686_clk_ops = {
 };
 
 static struct clk_hw *
-of_clk_max77686_get(struct of_phandle_args *clkspec, void *data)
+of_clk_max77686_get(const struct of_phandle_args *clkspec, void *data)
 {
 	struct max77686_clk_driver_data *drv_data = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/clk-max9485.c b/drivers/clk/clk-max9485.c
index be9020b6c789..050246008514 100644
--- a/drivers/clk/clk-max9485.c
+++ b/drivers/clk/clk-max9485.c
@@ -246,7 +246,7 @@ static const struct max9485_clk max9485_clks[MAX9485_NUM_CLKS] = {
 };
 
 static struct clk_hw *
-max9485_of_clk_get(struct of_phandle_args *clkspec, void *data)
+max9485_of_clk_get(const struct of_phandle_args *clkspec, void *data)
 {
 	struct max9485_driver_data *drvdata = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 4dcde305944c..95baeca8c031 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -1384,7 +1384,8 @@ static void __init core_pll_init(struct device_node *np)
 	}
 }
 
-static struct clk *clockgen_clk_get(struct of_phandle_args *clkspec, void *data)
+static struct clk *clockgen_clk_get(const struct of_phandle_args *clkspec,
+				    void *data)
 {
 	struct clockgen *cg = data;
 	struct clk *clk;
diff --git a/drivers/clk/clk-renesas-pcie.c b/drivers/clk/clk-renesas-pcie.c
index 53e21ac302e6..0fad48ff0f95 100644
--- a/drivers/clk/clk-renesas-pcie.c
+++ b/drivers/clk/clk-renesas-pcie.c
@@ -270,7 +270,7 @@ static void rs9_update_config(struct rs9_driver_data *rs9)
 }
 
 static struct clk_hw *
-rs9_of_clk_get(struct of_phandle_args *clkspec, void *data)
+rs9_of_clk_get(const struct of_phandle_args *clkspec, void *data)
 {
 	struct rs9_driver_data *rs9 = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
index f7412b137e5e..05e5047e7ce8 100644
--- a/drivers/clk/clk-rk808.c
+++ b/drivers/clk/clk-rk808.c
@@ -72,7 +72,7 @@ static const struct clk_ops rk808_clkout2_ops = {
 };
 
 static struct clk_hw *
-of_clk_rk808_get(struct of_phandle_args *clkspec, void *data)
+of_clk_rk808_get(const struct of_phandle_args *clkspec, void *data)
 {
 	struct rk808_clkout *rk808_clkout = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
index 108b697bd317..8125e6ac7916 100644
--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -172,7 +172,7 @@ struct scpi_clk_data {
 };
 
 static struct clk_hw *
-scpi_of_clk_src_get(struct of_phandle_args *clkspec, void *data)
+scpi_of_clk_src_get(const struct of_phandle_args *clkspec, void *data)
 {
 	struct scpi_clk *sclk;
 	struct scpi_clk_data *clk_data = data;
diff --git a/drivers/clk/clk-si521xx.c b/drivers/clk/clk-si521xx.c
index 4f7b74f889f1..5912bc5ad375 100644
--- a/drivers/clk/clk-si521xx.c
+++ b/drivers/clk/clk-si521xx.c
@@ -269,7 +269,7 @@ static void si521xx_diff_idx_to_reg_bit(const u16 chip_info, const int idx,
 }
 
 static struct clk_hw *
-si521xx_of_clk_get(struct of_phandle_args *clkspec, void *data)
+si521xx_of_clk_get(const struct of_phandle_args *clkspec, void *data)
 {
 	struct si521xx *si = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index 6e8dd7387cfd..4acf1daabcdf 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -957,7 +957,7 @@ static int si5341_is_programmed_already(struct clk_si5341 *data)
 }
 
 static struct clk_hw *
-of_clk_si5341_get(struct of_phandle_args *clkspec, void *_data)
+of_clk_si5341_get(const struct of_phandle_args *clkspec, void *_data)
 {
 	struct clk_si5341 *data = _data;
 	unsigned int idx = clkspec->args[1];
diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 4ce83c5265b8..3b325167c072 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -1390,7 +1390,7 @@ static int si5351_dt_parse(struct i2c_client *client,
 }
 
 static struct clk_hw *
-si53351_of_clk_get(struct of_phandle_args *clkspec, void *data)
+si53351_of_clk_get(const struct of_phandle_args *clkspec, void *data)
 {
 	struct si5351_driver_data *drvdata = data;
 	unsigned int idx = clkspec->args[0];
@@ -1409,7 +1409,7 @@ static int si5351_dt_parse(struct i2c_client *client, enum si5351_variant varian
 }
 
 static struct clk_hw *
-si53351_of_clk_get(struct of_phandle_args *clkspec, void *data)
+si53351_of_clk_get(const struct of_phandle_args *clkspec, void *data)
 {
 	return NULL;
 }
diff --git a/drivers/clk/clk-sparx5.c b/drivers/clk/clk-sparx5.c
index 0fad0c1a0186..b352cdc289b6 100644
--- a/drivers/clk/clk-sparx5.c
+++ b/drivers/clk/clk-sparx5.c
@@ -229,7 +229,8 @@ static const struct clk_ops s5_pll_ops = {
 	.recalc_rate	= s5_pll_recalc_rate,
 };
 
-static struct clk_hw *s5_clk_hw_get(struct of_phandle_args *clkspec, void *data)
+static struct clk_hw *s5_clk_hw_get(const struct of_phandle_args *clkspec,
+				    void *data)
 {
 	struct s5_clk_data *s5_clk = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index 07c13ebe327d..daa21cc8851b 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -872,7 +872,7 @@ static int stm32f4_rcc_lookup_clk_idx(u8 primary, u8 secondary)
 }
 
 static struct clk_hw *
-stm32f4_rcc_lookup_clk(struct of_phandle_args *clkspec, void *data)
+stm32f4_rcc_lookup_clk(const struct of_phandle_args *clkspec, void *data)
 {
 	int i = stm32f4_rcc_lookup_clk_idx(clkspec->args[0], clkspec->args[1]);
 
diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index 76d7ea1964c3..257160509310 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -964,7 +964,7 @@ static struct vc3_hw_data clk_mux[] = {
 	}
 };
 
-static struct clk_hw *vc3_of_clk_get(struct of_phandle_args *clkspec,
+static struct clk_hw *vc3_of_clk_get(const struct of_phandle_args *clkspec,
 				     void *data)
 {
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 6d31cd54d7cf..9a25e96955bd 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -731,7 +731,7 @@ static const struct clk_ops vc5_clk_out_ops = {
 	.get_parent	= vc5_clk_out_get_parent,
 };
 
-static struct clk_hw *vc5_of_clk_get(struct of_phandle_args *clkspec,
+static struct clk_hw *vc5_of_clk_get(const struct of_phandle_args *clkspec,
 				     void *data)
 {
 	struct vc5_driver_data *vc5 = data;
diff --git a/drivers/clk/clk-versaclock7.c b/drivers/clk/clk-versaclock7.c
index f323263e32c3..8345a946c1ec 100644
--- a/drivers/clk/clk-versaclock7.c
+++ b/drivers/clk/clk-versaclock7.c
@@ -174,7 +174,7 @@ struct vc7_bank_src_map {
 	} src;
 };
 
-static struct clk_hw *vc7_of_clk_get(struct of_phandle_args *clkspec,
+static struct clk_hw *vc7_of_clk_get(const struct of_phandle_args *clkspec,
 				     void *data)
 {
 	struct vc7_driver_data *vc7 = data;
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2253c154a824..cfb1dfeeb329 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -342,7 +342,7 @@ static struct clk_core *clk_core_lookup(const char *name)
 static int of_parse_clkspec(const struct device_node *np, int index,
 			    const char *name, struct of_phandle_args *out_args);
 static struct clk_hw *
-of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec);
+of_clk_get_hw_from_clkspec(const struct of_phandle_args *clkspec);
 #else
 static inline int of_parse_clkspec(const struct device_node *np, int index,
 				   const char *name,
@@ -351,7 +351,7 @@ static inline int of_parse_clkspec(const struct device_node *np, int index,
 	return -ENOENT;
 }
 static inline struct clk_hw *
-of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
+of_clk_get_hw_from_clkspec(const struct of_phandle_args *clkspec)
 {
 	return ERR_PTR(-ENOENT);
 }
@@ -4818,8 +4818,8 @@ struct of_clk_provider {
 	struct list_head link;
 
 	struct device_node *node;
-	struct clk *(*get)(struct of_phandle_args *clkspec, void *data);
-	struct clk_hw *(*get_hw)(struct of_phandle_args *clkspec, void *data);
+	struct clk *(*get)(const struct of_phandle_args *clkspec, void *data);
+	struct clk_hw *(*get_hw)(const struct of_phandle_args *clkspec, void *data);
 	void *data;
 };
 
@@ -4830,20 +4830,22 @@ static const struct of_device_id __clk_of_table_sentinel
 static LIST_HEAD(of_clk_providers);
 static DEFINE_MUTEX(of_clk_mutex);
 
-struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
+struct clk *of_clk_src_simple_get(const struct of_phandle_args *clkspec,
 				     void *data)
 {
 	return data;
 }
 EXPORT_SYMBOL_GPL(of_clk_src_simple_get);
 
-struct clk_hw *of_clk_hw_simple_get(struct of_phandle_args *clkspec, void *data)
+struct clk_hw *of_clk_hw_simple_get(const struct of_phandle_args *clkspec,
+				    void *data)
 {
 	return data;
 }
 EXPORT_SYMBOL_GPL(of_clk_hw_simple_get);
 
-struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data)
+struct clk *of_clk_src_onecell_get(const struct of_phandle_args *clkspec,
+				   void *data)
 {
 	struct clk_onecell_data *clk_data = data;
 	unsigned int idx = clkspec->args[0];
@@ -4858,7 +4860,7 @@ struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data)
 EXPORT_SYMBOL_GPL(of_clk_src_onecell_get);
 
 struct clk_hw *
-of_clk_hw_onecell_get(struct of_phandle_args *clkspec, void *data)
+of_clk_hw_onecell_get(const struct of_phandle_args *clkspec, void *data)
 {
 	struct clk_hw_onecell_data *hw_data = data;
 	unsigned int idx = clkspec->args[0];
@@ -4881,7 +4883,7 @@ EXPORT_SYMBOL_GPL(of_clk_hw_onecell_get);
  * This function is *deprecated*. Use of_clk_add_hw_provider() instead.
  */
 int of_clk_add_provider(struct device_node *np,
-			struct clk *(*clk_src_get)(struct of_phandle_args *clkspec,
+			struct clk *(*clk_src_get)(const struct of_phandle_args *clkspec,
 						   void *data),
 			void *data)
 {
@@ -4923,7 +4925,7 @@ EXPORT_SYMBOL_GPL(of_clk_add_provider);
  * @data: context pointer for @get callback.
  */
 int of_clk_add_hw_provider(struct device_node *np,
-			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+			   struct clk_hw *(*get)(const struct of_phandle_args *clkspec,
 						 void *data),
 			   void *data)
 {
@@ -4997,7 +4999,7 @@ static struct device_node *get_clk_provider_node(struct device *dev)
  * Return: 0 on success or an errno on failure.
  */
 int devm_of_clk_add_hw_provider(struct device *dev,
-			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+			struct clk_hw *(*get)(const struct of_phandle_args *clkspec,
 					      void *data),
 			void *data)
 {
@@ -5123,7 +5125,7 @@ static int of_parse_clkspec(const struct device_node *np, int index,
 
 static struct clk_hw *
 __of_clk_get_hw_from_provider(struct of_clk_provider *provider,
-			      struct of_phandle_args *clkspec)
+			      const struct of_phandle_args *clkspec)
 {
 	struct clk *clk;
 
@@ -5137,7 +5139,7 @@ __of_clk_get_hw_from_provider(struct of_clk_provider *provider,
 }
 
 static struct clk_hw *
-of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
+of_clk_get_hw_from_clkspec(const struct of_phandle_args *clkspec)
 {
 	struct of_clk_provider *provider;
 	struct clk_hw *hw = ERR_PTR(-EPROBE_DEFER);
@@ -5166,7 +5168,7 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
  * providers, an input is a clock specifier data structure as returned
  * from the of_parse_phandle_with_args() function call.
  */
-struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
+struct clk *of_clk_get_from_provider(const struct of_phandle_args *clkspec)
 {
 	struct clk_hw *hw = of_clk_get_hw_from_clkspec(clkspec);
 
diff --git a/drivers/clk/hisilicon/clk-hi3660-stub.c b/drivers/clk/hisilicon/clk-hi3660-stub.c
index 3a653d54bee0..1dd7fb7cfa5b 100644
--- a/drivers/clk/hisilicon/clk-hi3660-stub.c
+++ b/drivers/clk/hisilicon/clk-hi3660-stub.c
@@ -108,7 +108,7 @@ static struct hi3660_stub_clk hi3660_stub_clks[HI3660_CLK_STUB_NUM] = {
 	DEFINE_CLK_STUB(HI3660_CLK_STUB_DDR, 0x00040309, "clk-ddrc")
 };
 
-static struct clk_hw *hi3660_stub_clk_hw_get(struct of_phandle_args *clkspec,
+static struct clk_hw *hi3660_stub_clk_hw_get(const struct of_phandle_args *clkspec,
 					     void *data)
 {
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
index d0ccaa040225..feb2e4a61b6c 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -159,7 +159,7 @@ static const struct imx8qxp_ss_lpcg imx8qxp_ss_lsio = {
 
 #define IMX_LPCG_MAX_CLKS	8
 
-static struct clk_hw *imx_lpcg_of_clk_src_get(struct of_phandle_args *clkspec,
+static struct clk_hw *imx_lpcg_of_clk_src_get(const struct of_phandle_args *clkspec,
 					      void *data)
 {
 	struct clk_hw_onecell_data *hw_data = data;
diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index e48a904c0013..d357dc337741 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -517,7 +517,7 @@ struct clk_hw *__imx_clk_scu(struct device *dev, const char *name,
 	return hw;
 }
 
-struct clk_hw *imx_scu_of_clk_src_get(struct of_phandle_args *clkspec,
+struct clk_hw *imx_scu_of_clk_src_get(const struct of_phandle_args *clkspec,
 				      void *data)
 {
 	unsigned int rsrc = clkspec->args[0];
diff --git a/drivers/clk/imx/clk-scu.h b/drivers/clk/imx/clk-scu.h
index af7b697f51ca..38db6a1905d0 100644
--- a/drivers/clk/imx/clk-scu.h
+++ b/drivers/clk/imx/clk-scu.h
@@ -27,7 +27,7 @@ extern const struct imx_clk_scu_rsrc_table imx_clk_scu_rsrc_imx8qm;
 
 int imx_clk_scu_init(struct device_node *np,
 		     const struct imx_clk_scu_rsrc_table *data);
-struct clk_hw *imx_scu_of_clk_src_get(struct of_phandle_args *clkspec,
+struct clk_hw *imx_scu_of_clk_src_get(const struct of_phandle_args *clkspec,
 				      void *data);
 struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
 				     const char * const *parents,
diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index 35fe197dd303..ba27fb22f973 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -375,7 +375,8 @@ static int _cmp_sci_clk(const void *a, const void *b)
  * when a corresponding of_clk_get call is executed. Returns a pointer
  * to the TI SCI hw clock struct, or ERR_PTR value in failure.
  */
-static struct clk_hw *sci_clk_get(struct of_phandle_args *clkspec, void *data)
+static struct clk_hw *sci_clk_get(const struct of_phandle_args *clkspec,
+				  void *data)
 {
 	struct sci_clk_provider *provider = data;
 	struct sci_clk **clk;
diff --git a/drivers/clk/meson/meson-clkc-utils.c b/drivers/clk/meson/meson-clkc-utils.c
index 7370644e8092..904b482bf47b 100644
--- a/drivers/clk/meson/meson-clkc-utils.c
+++ b/drivers/clk/meson/meson-clkc-utils.c
@@ -8,7 +8,8 @@
 #include <linux/module.h>
 #include "meson-clkc-utils.h"
 
-struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_data)
+struct clk_hw *meson_clk_hw_get(const struct of_phandle_args *clkspec,
+				void *clk_hw_data)
 {
 	const struct meson_clk_hw_data *data = clk_hw_data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/meson/meson-clkc-utils.h b/drivers/clk/meson/meson-clkc-utils.h
index fe6f40728949..3889ead76a07 100644
--- a/drivers/clk/meson/meson-clkc-utils.h
+++ b/drivers/clk/meson/meson-clkc-utils.h
@@ -14,6 +14,7 @@ struct meson_clk_hw_data {
 	unsigned int	num;
 };
 
-struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_data);
+struct clk_hw *meson_clk_hw_get(const struct of_phandle_args *clkspec,
+				void *clk_hw_data);
 
 #endif
diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
index 785dbede4835..19cd62152175 100644
--- a/drivers/clk/mvebu/common.c
+++ b/drivers/clk/mvebu/common.c
@@ -199,7 +199,7 @@ struct clk_gating_ctrl {
 static struct clk_gating_ctrl *ctrl;
 
 static struct clk *clk_gating_get_src(
-	struct of_phandle_args *clkspec, void *data)
+	const struct of_phandle_args *clkspec, void *data)
 {
 	int n;
 
diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
index 03c59bf22106..8f6e2dd3e044 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -192,7 +192,7 @@ static void cp110_unregister_gate(struct clk_hw *hw)
 	kfree(to_cp110_gate_clk(hw));
 }
 
-static struct clk_hw *cp110_of_clk_get(struct of_phandle_args *clkspec,
+static struct clk_hw *cp110_of_clk_get(const struct of_phandle_args *clkspec,
 				       void *data)
 {
 	struct clk_hw_onecell_data *clk_data = data;
diff --git a/drivers/clk/mvebu/kirkwood.c b/drivers/clk/mvebu/kirkwood.c
index 8bc893df4736..b2b9a7a7a8fb 100644
--- a/drivers/clk/mvebu/kirkwood.c
+++ b/drivers/clk/mvebu/kirkwood.c
@@ -269,7 +269,7 @@ static const struct clk_muxing_soc_desc kirkwood_mux_desc[] __initconst = {
 };
 
 static struct clk *clk_muxing_get_src(
-	struct of_phandle_args *clkspec, void *data)
+	const struct of_phandle_args *clkspec, void *data)
 {
 	struct clk_muxing_ctrl *ctrl = (struct clk_muxing_ctrl *)data;
 	int n;
diff --git a/drivers/clk/nxp/clk-lpc18xx-ccu.c b/drivers/clk/nxp/clk-lpc18xx-ccu.c
index ddb28b38f549..3d8299b7e790 100644
--- a/drivers/clk/nxp/clk-lpc18xx-ccu.c
+++ b/drivers/clk/nxp/clk-lpc18xx-ccu.c
@@ -109,7 +109,7 @@ static struct lpc18xx_clk_branch clk_branches[] = {
 	{"base_sdio_clk",  "sdio",		CLK_SDIO,		0},
 };
 
-static struct clk *lpc18xx_ccu_branch_clk_get(struct of_phandle_args *clkspec,
+static struct clk *lpc18xx_ccu_branch_clk_get(const struct of_phandle_args *clkspec,
 					      void *data)
 {
 	struct lpc18xx_branch_clk_data *clk_data = data;
diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
index 745026ef4d9c..b7e048237bc0 100644
--- a/drivers/clk/qcom/clk-rpm.c
+++ b/drivers/clk/qcom/clk-rpm.c
@@ -514,7 +514,7 @@ static const struct of_device_id rpm_clk_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, rpm_clk_match_table);
 
-static struct clk_hw *qcom_rpm_clk_hw_get(struct of_phandle_args *clkspec,
+static struct clk_hw *qcom_rpm_clk_hw_get(const struct of_phandle_args *clkspec,
 					  void *data)
 {
 	struct rpm_cc *rcc = data;
diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index bb82abeed88f..8c2c6aa3a793 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -793,7 +793,7 @@ static const struct clk_rpmh_desc clk_rpmh_x1e80100 = {
 	.num_clks = ARRAY_SIZE(x1e80100_rpmh_clocks),
 };
 
-static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
+static struct clk_hw *of_clk_rpmh_hw_get(const struct of_phandle_args *clkspec,
 					 void *data)
 {
 	struct clk_rpmh_desc *rpmh = data;
diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 8602c02047d0..5d7e0cd2d450 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -1232,7 +1232,7 @@ static const struct of_device_id rpm_smd_clk_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, rpm_smd_clk_match_table);
 
-static struct clk_hw *qcom_smdrpm_clk_hw_get(struct of_phandle_args *clkspec,
+static struct clk_hw *qcom_smdrpm_clk_hw_get(const struct of_phandle_args *clkspec,
 					     void *data)
 {
 	const struct rpm_smd_clk_desc *desc = data;
diff --git a/drivers/clk/qcom/clk-spmi-pmic-div.c b/drivers/clk/qcom/clk-spmi-pmic-div.c
index f394031eb0e5..3f65aead519d 100644
--- a/drivers/clk/qcom/clk-spmi-pmic-div.c
+++ b/drivers/clk/qcom/clk-spmi-pmic-div.c
@@ -181,7 +181,7 @@ struct spmi_pmic_div_clk_cc {
 };
 
 static struct clk_hw *
-spmi_pmic_div_clk_hw_get(struct of_phandle_args *clkspec, void *data)
+spmi_pmic_div_clk_hw_get(const struct of_phandle_args *clkspec, void *data)
 {
 	struct spmi_pmic_div_clk_cc *cc = data;
 	int idx = clkspec->args[0] - 1; /* Start at 1 instead of 0 */
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 75f09e6e057e..0ae6f8ea607a 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -220,7 +220,7 @@ static void qcom_cc_drop_protected(struct device *dev, struct qcom_cc *cc)
 	}
 }
 
-static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
+static struct clk_hw *qcom_cc_clk_hw_get(const struct of_phandle_args *clkspec,
 					 void *data)
 {
 	struct qcom_cc *cc = data;
diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index ae325f4e1047..181f4096a506 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -324,7 +324,7 @@ static struct clk_hw *krait_add_clks(struct device *dev, int id, bool unique_aux
 	return pri_mux;
 }
 
-static struct clk *krait_of_get(struct of_phandle_args *clkspec, void *data)
+static struct clk *krait_of_get(const struct of_phandle_args *clkspec, void *data)
 {
 	unsigned int idx = clkspec->args[0];
 	struct clk **clks = data;
diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index c1348e2d450c..f8ea88663fca 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -733,7 +733,7 @@ struct r9a06g032_clk_gate {
 
 #define to_r9a06g032_gate(_hw) container_of(_hw, struct r9a06g032_clk_gate, hw)
 
-static int create_add_module_clock(struct of_phandle_args *clkspec,
+static int create_add_module_clock(const struct of_phandle_args *clkspec,
 				   struct device *dev)
 {
 	struct clk *clk;
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 1b421b809796..c172444ee766 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -273,7 +273,7 @@ static const struct clk_ops cpg_mstp_clock_ops = {
 };
 
 static
-struct clk *cpg_mssr_clk_src_twocell_get(struct of_phandle_args *clkspec,
+struct clk *cpg_mssr_clk_src_twocell_get(const struct of_phandle_args *clkspec,
 					 void *data)
 {
 	unsigned int clkidx = clkspec->args[1];
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 3d2daa4ba2a4..7464a298b2e5 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1052,7 +1052,7 @@ rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
 }
 
 static struct clk
-*rzg2l_cpg_clk_src_twocell_get(struct of_phandle_args *clkspec,
+*rzg2l_cpg_clk_src_twocell_get(const struct of_phandle_args *clkspec,
 			       void *data)
 {
 	unsigned int clkidx = clkspec->args[1];
diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
index 1fcf4e62f347..79feba75ea43 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
@@ -84,7 +84,8 @@ static const struct jh71x0_clk_data jh7100_audclk_data[] = {
 		    JH7100_AUDCLK_AUDIO_12288),
 };
 
-static struct clk_hw *jh7100_audclk_get(struct of_phandle_args *clkspec, void *data)
+static struct clk_hw *jh7100_audclk_get(const struct of_phandle_args *clkspec,
+					void *data)
 {
 	struct jh71x0_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
index 03f6f26a15d8..b7e43f4847d2 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100.c
@@ -267,7 +267,8 @@ static const struct jh71x0_clk_data jh7100_clk_data[] __initconst = {
 	JH71X0_GATE(JH7100_CLK_SYSERR_APB, "syserr_apb", 0, JH7100_CLK_APB2_BUS),
 };
 
-static struct clk_hw *jh7100_clk_get(struct of_phandle_args *clkspec, void *data)
+static struct clk_hw *jh7100_clk_get(const struct of_phandle_args *clkspec,
+				     void *data)
 {
 	struct jh71x0_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-aon.c b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
index 418efdad719b..d05da683a544 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-aon.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
@@ -54,7 +54,8 @@ static const struct jh71x0_clk_data jh7110_aonclk_data[] = {
 	JH71X0_GATE(JH7110_AONCLK_RTC_CAL, "rtc_cal", 0, JH7110_AONCLK_OSC),
 };
 
-static struct clk_hw *jh7110_aonclk_get(struct of_phandle_args *clkspec, void *data)
+static struct clk_hw *jh7110_aonclk_get(const struct of_phandle_args *clkspec,
+					void *data)
 {
 	struct jh71x0_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-isp.c b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
index 929b8788279e..518c4a8d4200 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-isp.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
@@ -75,7 +75,8 @@ static inline int jh7110_isp_top_rst_init(struct jh71x0_clk_priv *priv)
 	return reset_control_deassert(top_rsts);
 }
 
-static struct clk_hw *jh7110_ispclk_get(struct of_phandle_args *clkspec, void *data)
+static struct clk_hw *jh7110_ispclk_get(const struct of_phandle_args *clkspec,
+					void *data)
 {
 	struct jh71x0_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-pll.c b/drivers/clk/starfive/clk-starfive-jh7110-pll.c
index 3598390e8fd0..3c53459c554b 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-pll.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-pll.c
@@ -442,7 +442,8 @@ static const struct clk_ops jh7110_pll_ops = {
 	.debug_init = jh7110_pll_debug_init,
 };
 
-static struct clk_hw *jh7110_pll_get(struct of_phandle_args *clkspec, void *data)
+static struct clk_hw *jh7110_pll_get(const struct of_phandle_args *clkspec,
+				     void *data)
 {
 	struct jh7110_pll_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-stg.c b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
index dafcb7190592..0fba5de830e9 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-stg.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
@@ -75,7 +75,8 @@ static const struct jh71x0_clk_data jh7110_stgclk_data[] = {
 	JH71X0_GATE(JH7110_STGCLK_DMA1P_AHB, "dma1p_ahb", 0, JH7110_STGCLK_STG_AXIAHB),
 };
 
-static struct clk_hw *jh7110_stgclk_get(struct of_phandle_args *clkspec, void *data)
+static struct clk_hw *jh7110_stgclk_get(const struct of_phandle_args *clkspec,
+					void *data)
 {
 	struct jh71x0_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 8f5e5abfa178..6ea25b959091 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -323,7 +323,8 @@ static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
 		    JH7110_SYSCLK_OSC),
 };
 
-static struct clk_hw *jh7110_sysclk_get(struct of_phandle_args *clkspec, void *data)
+static struct clk_hw *jh7110_sysclk_get(const struct of_phandle_args *clkspec,
+					void *data)
 {
 	struct jh71x0_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
index 10cc1ec43925..7f69a4d75126 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-vout.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
@@ -80,7 +80,8 @@ static int jh7110_vout_top_rst_init(struct jh71x0_clk_priv *priv)
 	return reset_control_deassert(top_rst);
 }
 
-static struct clk_hw *jh7110_voutclk_get(struct of_phandle_args *clkspec, void *data)
+static struct clk_hw *jh7110_voutclk_get(const struct of_phandle_args *clkspec,
+					 void *data)
 {
 	struct jh71x0_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index 7bfba0afd778..9c53ab9b8a00 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -654,7 +654,7 @@ static void tegra_bpmp_unregister_clocks(struct tegra_bpmp *bpmp)
 		clk_hw_unregister(&bpmp->clocks[i]->hw);
 }
 
-static struct clk_hw *tegra_bpmp_clk_of_xlate(struct of_phandle_args *clkspec,
+static struct clk_hw *tegra_bpmp_clk_of_xlate(const struct of_phandle_args *clkspec,
 					      void *data)
 {
 	unsigned int id = clkspec->args[0], i;
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 6c46592d794e..87f1e5bc5c0e 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1502,7 +1502,7 @@ static void __init tegra124_132_clock_init_pre(struct device_node *np)
 	writel(plld_base, clk_base + PLLD_BASE);
 }
 
-static struct clk *tegra124_clk_src_onecell_get(struct of_phandle_args *clkspec,
+static struct clk *tegra124_clk_src_onecell_get(const struct of_phandle_args *clkspec,
 						void *data)
 {
 	struct clk_hw *hw;
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 2c58ce25af75..8a7e17d3379a 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1069,7 +1069,7 @@ static const struct of_device_id pmc_match[] __initconst = {
 
 static bool tegra20_car_initialized;
 
-static struct clk *tegra20_clk_src_onecell_get(struct of_phandle_args *clkspec,
+static struct clk *tegra20_clk_src_onecell_get(const struct of_phandle_args *clkspec,
 					       void *data)
 {
 	struct clk_hw *parent_hw;
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 82a8cb9545eb..4317c68cdeb4 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1273,7 +1273,7 @@ static struct tegra_audio_clk_info tegra30_audio_plls[] = {
 
 static bool tegra30_car_initialized;
 
-static struct clk *tegra30_clk_src_onecell_get(struct of_phandle_args *clkspec,
+static struct clk *tegra30_clk_src_onecell_get(const struct of_phandle_args *clkspec,
 					       void *data)
 {
 	struct clk_hw *hw;
diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 607e34d8e289..31df051c116c 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -221,7 +221,7 @@ static const struct clk_ops omap4_clkctrl_clk_ops = {
 	.init		= omap2_init_clk_clkdm,
 };
 
-static struct clk_hw *_ti_omap4_clkctrl_xlate(struct of_phandle_args *clkspec,
+static struct clk_hw *_ti_omap4_clkctrl_xlate(const struct of_phandle_args *clkspec,
 					      void *data)
 {
 	struct omap_clkctrl_provider *provider = data;
diff --git a/drivers/clk/ux500/u8500_of_clk.c b/drivers/clk/ux500/u8500_of_clk.c
index 8e2f6c65db2a..aba91ca5ca07 100644
--- a/drivers/clk/ux500/u8500_of_clk.c
+++ b/drivers/clk/ux500/u8500_of_clk.c
@@ -26,7 +26,7 @@ static struct clk_hw *clkout_clk[2];
 #define PRCC_KCLK_STORE(clk, base, bit)        \
 	prcc_kclk[(base * PRCC_PERIPHS_PER_CLUSTER) + bit] = clk
 
-static struct clk *ux500_twocell_get(struct of_phandle_args *clkspec,
+static struct clk *ux500_twocell_get(const struct of_phandle_args *clkspec,
 				     void *data)
 {
 	struct clk **clk_data = data;
@@ -71,7 +71,7 @@ static const char * const u8500_clkout_parents[] = {
 	"clk009",
 };
 
-static struct clk_hw *ux500_clkout_get(struct of_phandle_args *clkspec,
+static struct clk_hw *ux500_clkout_get(const struct of_phandle_args *clkspec,
 				       void *data)
 {
 	u32 id, source, divider;
diff --git a/drivers/clk/versatile/clk-sp810.c b/drivers/clk/versatile/clk-sp810.c
index 45adac1b4630..5fd21c13f546 100644
--- a/drivers/clk/versatile/clk-sp810.c
+++ b/drivers/clk/versatile/clk-sp810.c
@@ -68,7 +68,7 @@ static const struct clk_ops clk_sp810_timerclken_ops = {
 	.set_parent = clk_sp810_timerclken_set_parent,
 };
 
-static struct clk *clk_sp810_timerclken_of_get(struct of_phandle_args *clkspec,
+static struct clk *clk_sp810_timerclken_of_get(const struct of_phandle_args *clkspec,
 		void *data)
 {
 	struct clk_sp810 *sp810 = data;
diff --git a/drivers/media/platform/ti/omap3isp/isp.c b/drivers/media/platform/ti/omap3isp/isp.c
index 1cda23244c7b..e2c78f9ab797 100644
--- a/drivers/media/platform/ti/omap3isp/isp.c
+++ b/drivers/media/platform/ti/omap3isp/isp.c
@@ -281,7 +281,8 @@ static const struct clk_ops isp_xclk_ops = {
 
 static const char *isp_xclk_parent_name = "cam_mclk";
 
-static struct clk *isp_xclk_src_get(struct of_phandle_args *clkspec, void *data)
+static struct clk *isp_xclk_src_get(const struct of_phandle_args *clkspec,
+				    void *data)
 {
 	unsigned int idx = clkspec->args[0];
 	struct isp_device *isp = data;
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index b6908a03da58..46a77df32dff 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -3136,7 +3136,8 @@ static const struct clk_ops qmp_dp_link_clk_ops = {
 	.recalc_rate	= qmp_dp_link_clk_recalc_rate,
 };
 
-static struct clk_hw *qmp_dp_clks_hw_get(struct of_phandle_args *clkspec, void *data)
+static struct clk_hw *qmp_dp_clks_hw_get(const struct of_phandle_args *clkspec,
+					 void *data)
 {
 	struct qmp_combo *qmp = data;
 	unsigned int idx = clkspec->args[0];
@@ -3177,7 +3178,8 @@ static int phy_dp_clks_register(struct qmp_combo *qmp, struct device_node *np)
 	return 0;
 }
 
-static struct clk_hw *qmp_combo_clk_hw_get(struct of_phandle_args *clkspec, void *data)
+static struct clk_hw *qmp_combo_clk_hw_get(const struct of_phandle_args *clkspec,
+					   void *data)
 {
 	struct qmp_combo *qmp = data;
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1293c38ddb7f..d58313368924 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1532,25 +1532,25 @@ struct clk_hw_onecell_data {
 
 #ifdef CONFIG_OF
 int of_clk_add_provider(struct device_node *np,
-			struct clk *(*clk_src_get)(struct of_phandle_args *args,
+			struct clk *(*clk_src_get)(const struct of_phandle_args *args,
 						   void *data),
 			void *data);
 int of_clk_add_hw_provider(struct device_node *np,
-			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+			   struct clk_hw *(*get)(const struct of_phandle_args *clkspec,
 						 void *data),
 			   void *data);
 int devm_of_clk_add_hw_provider(struct device *dev,
-			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+			   struct clk_hw *(*get)(const struct of_phandle_args *clkspec,
 						 void *data),
 			   void *data);
 void of_clk_del_provider(struct device_node *np);
 
-struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
+struct clk *of_clk_src_simple_get(const struct of_phandle_args *clkspec,
 				  void *data);
-struct clk_hw *of_clk_hw_simple_get(struct of_phandle_args *clkspec,
+struct clk_hw *of_clk_hw_simple_get(const struct of_phandle_args *clkspec,
 				    void *data);
-struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data);
-struct clk_hw *of_clk_hw_onecell_get(struct of_phandle_args *clkspec,
+struct clk *of_clk_src_onecell_get(const struct of_phandle_args *clkspec, void *data);
+struct clk_hw *of_clk_hw_onecell_get(const struct of_phandle_args *clkspec,
 				     void *data);
 int of_clk_parent_fill(struct device_node *np, const char **parents,
 		       unsigned int size);
@@ -1560,21 +1560,21 @@ int of_clk_detect_critical(struct device_node *np, int index,
 #else /* !CONFIG_OF */
 
 static inline int of_clk_add_provider(struct device_node *np,
-			struct clk *(*clk_src_get)(struct of_phandle_args *args,
+			struct clk *(*clk_src_get)(const struct of_phandle_args *args,
 						   void *data),
 			void *data)
 {
 	return 0;
 }
 static inline int of_clk_add_hw_provider(struct device_node *np,
-			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+			struct clk_hw *(*get)(const struct of_phandle_args *clkspec,
 					      void *data),
 			void *data)
 {
 	return 0;
 }
 static inline int devm_of_clk_add_hw_provider(struct device *dev,
-			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+			   struct clk_hw *(*get)(const struct of_phandle_args *clkspec,
 						 void *data),
 			   void *data)
 {
@@ -1583,22 +1583,22 @@ static inline int devm_of_clk_add_hw_provider(struct device *dev,
 static inline void of_clk_del_provider(struct device_node *np) {}
 
 static inline struct clk *of_clk_src_simple_get(
-	struct of_phandle_args *clkspec, void *data)
+	const struct of_phandle_args *clkspec, void *data)
 {
 	return ERR_PTR(-ENOENT);
 }
 static inline struct clk_hw *
-of_clk_hw_simple_get(struct of_phandle_args *clkspec, void *data)
+of_clk_hw_simple_get(const struct of_phandle_args *clkspec, void *data)
 {
 	return ERR_PTR(-ENOENT);
 }
 static inline struct clk *of_clk_src_onecell_get(
-	struct of_phandle_args *clkspec, void *data)
+	const struct of_phandle_args *clkspec, void *data)
 {
 	return ERR_PTR(-ENOENT);
 }
 static inline struct clk_hw *
-of_clk_hw_onecell_get(struct of_phandle_args *clkspec, void *data)
+of_clk_hw_onecell_get(const struct of_phandle_args *clkspec, void *data)
 {
 	return ERR_PTR(-ENOENT);
 }
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 06f1b292f8a0..8e3c44ff89da 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -1141,7 +1141,7 @@ static inline struct clk *clk_get_optional(struct device *dev, const char *id)
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
-struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
+struct clk *of_clk_get_from_provider(const struct of_phandle_args *clkspec);
 #else
 static inline struct clk *of_clk_get(struct device_node *np, int index)
 {
@@ -1152,7 +1152,7 @@ static inline struct clk *of_clk_get_by_name(struct device_node *np,
 {
 	return ERR_PTR(-ENOENT);
 }
-static inline struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
+static inline struct clk *of_clk_get_from_provider(const struct of_phandle_args *clkspec)
 {
 	return ERR_PTR(-ENOENT);
 }
diff --git a/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c b/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
index e758411603be..b846707baa89 100644
--- a/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
+++ b/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
@@ -106,7 +106,7 @@ static const struct clk_ops clk_vote_q6dsp_ops = {
 };
 
 
-static struct clk_hw *q6dsp_of_clk_hw_get(struct of_phandle_args *clkspec,
+static struct clk_hw *q6dsp_of_clk_hw_get(const struct of_phandle_args *clkspec,
 					  void *data)
 {
 	struct q6dsp_cc *cc = data;
-- 
2.34.1


