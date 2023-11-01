Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774307DDE17
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjKAJEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjKAJEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:04:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3D8131
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:04:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53e855d7dacso10854520a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698829470; x=1699434270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=deorSarSbR1QxtZLSCW9XETCm3ns93gkolRiX/6H0K0=;
        b=Br+uhlUFxpobLPEu7czSyczscaBiZSU1xQAhp49eoHMqpoGGs/+49aIgeOzLFeX2mN
         kJtzaGHUDGj8X6s+QQoljjkuSh6TRZvGrKZO7fRbGPh+1PRtXrQPaxFs1IUNE4LFyGX8
         PJ25JR5mm0pCH7c2jBnBrj53prE0YMzQiaqvwuMw8ATmTD4nK16AdwZ34BhzG7S7+s9R
         bU/dkwX8QMPjWHkNSKdL1cM4XFKvjyvVZSNg/F0TrsldEVVvx3xKoPKbkEdCbmBo2GXn
         7UKFrNpSVS2n5Y3JighwAQnyhuzh+8jX/iHmu6c5nSdnUatmL5KtCsFxfx5P7sR9KOod
         G5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698829470; x=1699434270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deorSarSbR1QxtZLSCW9XETCm3ns93gkolRiX/6H0K0=;
        b=cNLsy06+GvxiIwcBYIk9QFkcCGgYCANRSi9PBaoXn7rKVIQgdZubZU6eK7bO4KIFqa
         S7xNMPr/+cfMfgoATrquw9v+JKLDf2yL1M+LH19lcCDLh+ddfQeeJ7WJXZdn5R5kH0ij
         KFaSB+4xXcDzDdMj1OAR9JVp+Gg7O/9Wxt8Rwu7gmmHAYbPOwGTYhlKnGscqk01CL74Z
         0x4iN+0j05f3OhWA4d/BEwBmJMLEOqMX/MRZXLADUy6o6ZBbQ4GQ7k3riqM5Wtc110W0
         K6CT6dYrL8HMFkWEA86XDIDv1AcZHjRJxIn3yp4sLOqVyCkE5CUf2DokeSqG/gQ2OB8C
         Apuw==
X-Gm-Message-State: AOJu0Yzi1MrZo61z/NfEvmebdggcgwrwi/+U92PF77pSGYv8zfeykaF/
        6gkYRNaPXwq8dSVZg1MrD5oF5A==
X-Google-Smtp-Source: AGHT+IEPolrieRML2v8bbaODfnES9U9NNN2M+epaLneHTikCZ7+r522LapRxt0TJ49vjNuLy6Z8wAA==
X-Received: by 2002:a17:907:2d2a:b0:9be:e278:4d45 with SMTP id gs42-20020a1709072d2a00b009bee2784d45mr1421982ejc.15.1698829470695;
        Wed, 01 Nov 2023 02:04:30 -0700 (PDT)
Received: from [127.0.1.1] ([86.122.213.220])
        by smtp.gmail.com with ESMTPSA id l25-20020a170906a41900b0099cd1c0cb21sm2152781ejz.129.2023.11.01.02.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 02:04:30 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Wed, 01 Nov 2023 11:04:11 +0200
Subject: [PATCH RESEND v3 5/5] venus: pm_helpers: Use
 dev_pm_genpd_set_hwmode to switch GDSC mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-gdsc-hwctrl-v3-5-0740ae6b2b04@linaro.org>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
In-Reply-To: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5363; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=xnuOTf2Kr8/935lTdlMi0E5z4E2laKtVSwUNwYdMNTI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlQhSSEptyMNL/Gg49IXQ+Hqq6akfRm5iPC6mWP
 HczQT3IiZ+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZUIUkgAKCRAbX0TJAJUV
 VmMRD/4snqQ3+O/zco8zeG9Unkij03wDt5uoYcOCpOObJGrXgStVICT9LJ/DJNmFqHKYHSJIyII
 A55qGK3uRQC828E5uxiy42Mi6yJF9jYOla7SuLXqcY47Db8gYdovM3TMe7ghOmjA8t2PvX/rKYV
 EM7qZS/EDCoilLDMbuSAPuPkGB1pWcDCJJwliisHGpJEutojPRWuZp//wZTZL0IKyiqz/cn5rl5
 1dmUQRixMsQjkofhyR+I3kV/eLkTsaJFglnoLVJ9AA+aHjEcrcWkIup7Li0T96vhBlIQaZbDjBt
 71Za0JkJNj5fDf889sQpOZeBUieV1r3xSdMdCnZD14r1zO0HSCa2Lx1yLZGQHiGN6e3soCD/9Dq
 30TxHg+OlMRuPUe/Mgl8deUthFweJCojsf1j6azqpFtT8UAmknuRwO1NKrtsDHGudJNhF/0vAlX
 MVvESARLuSr4tDHkoxijD4vsP9H9RH8qWnkiShhVwS4zFDo4qGzUyFcsaZXdzmrvJABV744nziI
 HQitBcAYzyfFME5GNAYiXiuyX9efIOe1BX3x29m+nNdslnBGZhBwRUEyUcC4aOhkTsY0THdIDEj
 c/hJoRQDZ/DTuIgcDcb/gnbTS5A03LrrEFO0/t3CIaaly7IJI1rn/uU+AlPBV9hT+AsjaTnWbX4
 PkhllUF+q2xDghw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Kona <quic_jkona@quicinc.com>

This change demonstrates the use of dev_pm_genpd_set_hwmode API from
video driver to switch the video mvs0 gdsc to SW/HW modes at runtime
based on requirement.

This change adds a new boolean array member vcodec_pmdomains_hwctrl in
venus_resources structure to indicate if GDSC's have HW control support
or not. This data is used in vcodec_control_v4() to check if GDSC has
support to switch to HW control mode and then call dev_pm_genpd_set_hwmode
to switch the GDSC mode.

Before the GDSC HWCTL was available to the consumer, the venus driver
needed to somehow keep the power from collapsing while under the driver
control. The only way to do that was to clear the CORE_PWR_DISABLE bit
(in wrapper POWER_CONTROL register) and, respectively, set it back after
the driver control was completed.

Now, that there is a way to switch the GDSC HW/SW control back and
forth, the CORE_PWR_DISABLE toggling can be dropped.

Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       |  4 +++
 drivers/media/platform/qcom/venus/core.h       |  1 +
 drivers/media/platform/qcom/venus/pm_helpers.c | 47 +++++++++++---------------
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 054b8e74ba4f..8145062ab6f7 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -706,6 +706,7 @@ static const struct venus_resources sdm845_res_v2 = {
 	.vcodec1_clks = { "vcodec1_core", "vcodec1_bus" },
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = { "venus", "vcodec0", "vcodec1" },
+	.vcodec_pmdomains_hwctrl = { false, true, true },
 	.vcodec_pmdomains_num = 3,
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 2,
@@ -755,6 +756,7 @@ static const struct venus_resources sc7180_res = {
 	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = { "venus", "vcodec0" },
+	.vcodec_pmdomains_hwctrl = { false, true },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 1,
@@ -812,6 +814,7 @@ static const struct venus_resources sm8250_res = {
 	.vcodec0_clks = { "vcodec0_core" },
 	.vcodec_clks_num = 1,
 	.vcodec_pmdomains = { "venus", "vcodec0" },
+	.vcodec_pmdomains_hwctrl = { false, true },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = (const char *[]) { "mx", NULL },
 	.vcodec_num = 1,
@@ -871,6 +874,7 @@ static const struct venus_resources sc7280_res = {
 	.vcodec0_clks = {"vcodec_core", "vcodec_bus"},
 	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = { "venus", "vcodec0" },
+	.vcodec_pmdomains_hwctrl = { false, true },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = (const char *[]) { "cx", NULL },
 	.vcodec_num = 1,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 4a633261ece4..6d591ecad482 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -73,6 +73,7 @@ struct venus_resources {
 	const char * const vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
 	unsigned int vcodec_clks_num;
 	const char * const vcodec_pmdomains[VIDC_PMDOMAINS_NUM_MAX];
+	bool vcodec_pmdomains_hwctrl[VIDC_PMDOMAINS_NUM_MAX];
 	unsigned int vcodec_pmdomains_num;
 	const char **opp_pmdomain;
 	unsigned int vcodec_num;
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index a1b127caa90a..9d1dc8366ab0 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -408,35 +408,28 @@ static const struct venus_pm_ops pm_ops_v3 = {
 
 static int vcodec_control_v4(struct venus_core *core, u32 coreid, bool enable)
 {
-	void __iomem *ctrl, *stat;
-	u32 val;
-	int ret;
-
-	if (IS_V6(core)) {
-		ctrl = core->wrapper_base + WRAPPER_CORE_POWER_CONTROL_V6;
-		stat = core->wrapper_base + WRAPPER_CORE_POWER_STATUS_V6;
-	} else if (coreid == VIDC_CORE_ID_1) {
-		ctrl = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_CONTROL;
-		stat = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_STATUS;
-	} else {
-		ctrl = core->wrapper_base + WRAPPER_VCODEC1_MMCC_POWER_CONTROL;
-		stat = core->wrapper_base + WRAPPER_VCODEC1_MMCC_POWER_STATUS;
-	}
-
-	if (enable) {
-		writel(0, ctrl);
-
-		ret = readl_poll_timeout(stat, val, val & BIT(1), 1, 100);
-		if (ret)
-			return ret;
-	} else {
-		writel(1, ctrl);
+	int i, ret = 0;
+	struct device *dev = core->dev;
+	const struct venus_resources *res = core->res;
 
-		ret = readl_poll_timeout(stat, val, !(val & BIT(1)), 1, 100);
-		if (ret)
-			return ret;
+	for (i = 0; i < res->vcodec_pmdomains_num; i++) {
+		if (res->vcodec_pmdomains_hwctrl[i]) {
+
+			if (!core->pmdomains[i])
+				return -ENODEV;
+
+			/*
+			 * enable( true ), switch the gdsc to SW mode
+			 * enable( false), switch the gdsc to HW mode
+			 */
+			ret = dev_pm_genpd_set_hwmode(core->pmdomains[i], !enable);
+			if (ret) {
+				dev_err(dev, "Failed to switch power-domain:%d to %s mode\n",
+					i, enable ? "SW" : "HW");
+				return ret;
+			}
+		}
 	}
-
 	return 0;
 }
 

-- 
2.34.1

