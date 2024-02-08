Return-Path: <linux-kernel+bounces-58669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BB484E9B5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796B41F2F98E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6323BB5E;
	Thu,  8 Feb 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1H8h7Vi"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841BB38DF9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424113; cv=none; b=swpB41VAq93ubKFOoNvD3cVQouFWFAI6whh9Fqqk7O9ciJM5llEu9rvSUF9ximzDDq3ZPHND65ch9AiKS6WVUsJSRa/fEyQpnHwnoTunqqKh9cjIUXbKmNMidUmAsSsXyHK4IxFe8MV9gLtzl9m6oRWr9I5LOeVFYy+Y9zcnXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424113; c=relaxed/simple;
	bh=UIiV9ESsbPEqQYxT4Q1BZNvrcYMVMHfj0d1j5Kcslpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DiDSNyGikPskfNXMQ3xOqkic4Hy9glzGyoo3iwqcXq1jocwIBV+jiZZHwxaixDM4yUhjrAZloyLsBcGEJuyxyIbsl9vfgBG9+J7UnrAzSumHzois+zAbge4nIV/+CvznmBc3vvPQYW/mb2+8liliv0703BYP500NIWnbAJ0Qiqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b1H8h7Vi; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b58ca0b95so50460f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 12:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707424106; x=1708028906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h35dRpjtXdfsQI1xSLGf2CRc3mPgECpofTf+8BcEtiA=;
        b=b1H8h7VihVDhatvs0btWQgdJUgk1RJuf+zpqWf5Z8h/1+XI1OFxlnyZ5jkdmSSypMA
         MMsy+9osdRZSrTmhu8U2FgGvt2ZMGFmvw7fvnYGE+6jUmt2F1ZfW3We2fc/YLCRh8tYE
         Otq/3EtleWRGT/iI19gcgbAAQNxGmMCqygWfXjJd8fBg5StzzRSI7V94W9lUNhO0+jQO
         VhtwJICvtqLpsRNHZReX18oROfwNXE23edELMoEroN8Dn9DthyP7HWXxiKbQ2IoV/7on
         Ji1tVvUf+woxIfAv6gTpOCEbF47Wsc6iCRV48gusk7CFm7GSamsIsAsqJ/Q04l3dc91T
         walQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707424106; x=1708028906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h35dRpjtXdfsQI1xSLGf2CRc3mPgECpofTf+8BcEtiA=;
        b=kVxN3OHqccDIBfMWDdIOu42S0Tgjd0geZXPlQ1ZzHNj4xo5gi4W6IYhkScTbzV1C/0
         3XAwxj/D68TWhGAvRtj9/kKlOL5Z0A0AZ58mYNQVi3wEWBbJuDqQf0KU3s6BS1Go4oDL
         8nmuJUsoY49Of9SOOYOduNVwEUO4ZOWAasdk+xAXlozrhfrbiFnE91PYZvJE0hh1laTM
         zvSC6AHDTnYEIlDLBQdaU7OUd/SEb2plbhPnLkX8WSqaHTS0K7YQXgtihafYLWpz92YB
         iztST2g1zPM1mqmkf83QisE1A3N+iOEZVPCuAm+gJUj6iRKbIg5//yWoKbErM8TbK3oL
         +AWA==
X-Forwarded-Encrypted: i=1; AJvYcCUf3L6/WxBoVMrqNcC+w5pIwAvQJhuYIFm+ptfQ6/CaPLUU74Db1uobTVeL9Hs++Mbn5/LLLx7AzAdTGdTEmpm92EGPSF8ZI31hwnuA
X-Gm-Message-State: AOJu0YxyRx46hoRJ2ddk6xStgC4lfkis9Nzir8KbR0xGwuSVB3YPnq4y
	BXTKu8WTvF/OSybzyX4vGXzMviZL/SU/+8MPJ+4bGRBN5uQyLqFQ0lJKnhIoN/o=
X-Google-Smtp-Source: AGHT+IHyvarizPJkALwTHM5f3L+M9gT4R2mQjWGcuZ2JWYICbZYjOr9T8gXGP+xlVB7bbj3IgWLFDA==
X-Received: by 2002:a5d:56c7:0:b0:33b:1a3f:a699 with SMTP id m7-20020a5d56c7000000b0033b1a3fa699mr364811wrw.62.1707424105808;
        Thu, 08 Feb 2024 12:28:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzkksqL6ijNTu+ChykDzdnhfrXwHt50ayfqYrwupVvquKe8T+v0Q/ETKx/yI3lkqh1WqWHoTUBFyEN4WcFMRdK8aDHfSZxim4b81425V37Z3xs5+U0JQiISpAQ459cQeLgWJmOjc41LDlz4o6HbxFvpJcOwV+4/3kWYrAv6+WIJ2X5yOV3YsBj42oyfkJnvpYpA33TIWPMpvY5UHhYVUywMe1bQSfjOovDuSUx8yfL/zNDs2KkhF/QNTuxQIosTVZ0R0wmBbcIbEhLCfu3BYLRLie+aFVXwSfVe0tjfvc2SM4sP7VSYJK6SXgVoq+nWAS1/y8Z5d+OjIw+9QjwMkqlKVNpdPSTiFJLrwMPM3QR90nDgbd5sNmErAZJb0+dUPB04/LUr1lTY5YqD1dM3Z/4BSvL+YlFPTrZ6+p1E9mrxU5zZ8x3fX/FPZ9zM8s02Kc96oqwDfcW6WSIPOxlGcMVKmnyxKTpGVrzKFE8DKK3dsmSbfjmLRkLctH8gOOQitZ0IqwysX2pe+rL80Jg/r6OOQQ+0t62iWGzU+7fBHQR+A==
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id r16-20020adfce90000000b0033b47ee01f1sm114643wrn.49.2024.02.08.12.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:28:25 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] pmdomain: constify of_phandle_args in xlate
Date: Thu,  8 Feb 2024 21:28:21 +0100
Message-Id: <20240208202822.631449-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xlate callbacks are supposed to translate of_phandle_args to proper
provider without modifying the of_phandle_args.  Make the argument
pointer to const for code safety and readability.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pmdomain/core.c                     | 4 ++--
 drivers/pmdomain/imx/scu-pd.c               | 2 +-
 drivers/pmdomain/tegra/powergate-bpmp.c     | 2 +-
 drivers/pmdomain/ti/ti_sci_pm_domains.c     | 2 +-
 drivers/pmdomain/xilinx/zynqmp-pm-domains.c | 2 +-
 include/linux/pm_domain.h                   | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 46331e71108a..ea4b29475206 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2266,7 +2266,7 @@ static DEFINE_MUTEX(of_genpd_mutex);
  * to be a valid pointer to struct generic_pm_domain.
  */
 static struct generic_pm_domain *genpd_xlate_simple(
-					struct of_phandle_args *genpdspec,
+					const struct of_phandle_args *genpdspec,
 					void *data)
 {
 	return data;
@@ -2283,7 +2283,7 @@ static struct generic_pm_domain *genpd_xlate_simple(
  * the genpd_onecell_data struct when registering the provider.
  */
 static struct generic_pm_domain *genpd_xlate_onecell(
-					struct of_phandle_args *genpdspec,
+					const struct of_phandle_args *genpdspec,
 					void *data)
 {
 	struct genpd_onecell_data *genpd_data = data;
diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
index 891c1d925a9d..05841b0bf7f3 100644
--- a/drivers/pmdomain/imx/scu-pd.c
+++ b/drivers/pmdomain/imx/scu-pd.c
@@ -393,7 +393,7 @@ static int imx_sc_pd_power_off(struct generic_pm_domain *domain)
 	return imx_sc_pd_power(domain, false);
 }
 
-static struct generic_pm_domain *imx_scu_pd_xlate(struct of_phandle_args *spec,
+static struct generic_pm_domain *imx_scu_pd_xlate(const struct of_phandle_args *spec,
 						  void *data)
 {
 	struct generic_pm_domain *domain = ERR_PTR(-ENOENT);
diff --git a/drivers/pmdomain/tegra/powergate-bpmp.c b/drivers/pmdomain/tegra/powergate-bpmp.c
index 179ed895c279..b0138ca9f851 100644
--- a/drivers/pmdomain/tegra/powergate-bpmp.c
+++ b/drivers/pmdomain/tegra/powergate-bpmp.c
@@ -305,7 +305,7 @@ static void tegra_bpmp_remove_powergates(struct tegra_bpmp *bpmp)
 }
 
 static struct generic_pm_domain *
-tegra_powergate_xlate(struct of_phandle_args *spec, void *data)
+tegra_powergate_xlate(const struct of_phandle_args *spec, void *data)
 {
 	struct generic_pm_domain *domain = ERR_PTR(-ENOENT);
 	struct genpd_onecell_data *genpd = data;
diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index c091d569ecd5..9dddf227a3a6 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -85,7 +85,7 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
  * @data: genpd core data for all the powerdomains on the device
  */
 static struct generic_pm_domain *ti_sci_pd_xlate(
-					struct of_phandle_args *genpdspec,
+					const struct of_phandle_args *genpdspec,
 					void *data)
 {
 	struct genpd_onecell_data *genpd_data = data;
diff --git a/drivers/pmdomain/xilinx/zynqmp-pm-domains.c b/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
index 6fd514286d82..0b5831e5ba1b 100644
--- a/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
+++ b/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
@@ -210,7 +210,7 @@ static void zynqmp_gpd_detach_dev(struct generic_pm_domain *domain,
 }
 
 static struct generic_pm_domain *zynqmp_gpd_xlate
-				(struct of_phandle_args *genpdspec, void *data)
+				(const struct of_phandle_args *genpdspec, void *data)
 {
 	struct genpd_onecell_data *genpd_data = data;
 	unsigned int i, idx = genpdspec->args[0];
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index fb91770ba4ba..1a391ef1b6f8 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -349,7 +349,7 @@ static inline void dev_pm_genpd_resume(struct device *dev) {}
 /* OF PM domain providers */
 struct of_device_id;
 
-typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
+typedef struct generic_pm_domain *(*genpd_xlate_t)(const struct of_phandle_args *args,
 						   void *data);
 
 struct genpd_onecell_data {
-- 
2.34.1


