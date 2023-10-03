Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E917B6771
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbjJCLNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbjJCLN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:13:26 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB60116
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:13:16 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fa455cd94so460668a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 04:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696331595; x=1696936395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE8Ieh2E0y9927Pv5gN4de1tpZTkbTbXjQkQ4apFuec=;
        b=LgDGxeaiVLRznc5Bd/kJFxsaEipUoxVMfH3c+G4lEjWgzz2LqpMrOKSAawAxfo0JVv
         xV5rtqpzwaZVmunMxvmDDBS4Cut0I/FIne+Bc/4jzkNaWbl4o1/jazrHRn3rax3cfiuw
         Z+Nq/g7Doni4A9hIvBdqQIqh82/Ogk1YpFBVcBZyFclHH8jsTpnnEOA5hCNvjcN4xvGf
         Tam26gEAZaQ4tpmhRfPGbBG4jGGs93BMpQZJQAzgzH8bECNVokfQOlleFl+Lx6ul9Nc2
         SaEyiSTq5obdeNcYklqA9+B8nntp+QuJMd08oOtkYr79S080QIAnW2qt/5pzcV1SWG9r
         kzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696331595; x=1696936395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rE8Ieh2E0y9927Pv5gN4de1tpZTkbTbXjQkQ4apFuec=;
        b=UNfwTAb2fw6cxImQoPLSe2LWQt86UCOcI6L63RMDshK6EhwQrz/dsWlU96yTBs9PKg
         TEZnbra5P8waWYGgIYxM4SBr0mqK7O6PnFKLsmS3AkIAoNdzNB0+1dM9WgGX+bD8E3Me
         VGFXpW1aCBXtyQKaGFameheWcNGBa7rjqik/uePsoHCEOSlwNHsfhQ2S1fwPmE1TU0Jb
         dr7rRb2KpkpNpJkHyEMfTJO6d0DcO750X44Nt5Fv6AGCdg3mO+PsDA9HJ+C3lKO4V9bu
         gCJSKY6jDlyL5wDfJWa3g7jhGBORkiQWmzbYUCJBMtjVQ/SrxXImepDD9hKihbdeGdKz
         1EBg==
X-Gm-Message-State: AOJu0YxmcUuWekygms57HfiQ/L4/KD/cFWjPuhg40Ne9CC8+KSLBo7QQ
        kbGjmiNyvtY4KyXevglcNvKP
X-Google-Smtp-Source: AGHT+IFPcQUvfV5/S2kFcPVQO2n4wdmkKIy+q55dqcmC6ikQX8zuF1qoQTLpLYeV12vFSBGm/kF9rg==
X-Received: by 2002:a05:6a20:3d26:b0:159:e0b9:bd02 with SMTP id y38-20020a056a203d2600b00159e0b9bd02mr13170565pzi.40.1696331595399;
        Tue, 03 Oct 2023 04:13:15 -0700 (PDT)
Received: from localhost.localdomain ([117.217.185.220])
        by smtp.gmail.com with ESMTPSA id d9-20020a170903230900b001ab2b4105ddsm1250328plh.60.2023.10.03.04.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 04:13:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 3/6] scsi: ufs: core: Add OPP support for scaling clocks and regulators
Date:   Tue,  3 Oct 2023 16:42:29 +0530
Message-Id: <20231003111232.42663-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231003111232.42663-1-manivannan.sadhasivam@linaro.org>
References: <20231003111232.42663-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS core is only scaling the clocks during devfreq scaling and
initialization. But for an optimum power saving, regulators should also
be scaled along with the clocks.

So let's use the OPP framework which supports scaling clocks, regulators,
and performance state using OPP table defined in devicetree. For
accomodating the OPP support, the existing APIs (ufshcd_scale_clks,
ufshcd_is_devfreq_scaling_required and ufshcd_devfreq_scale) are modified
to accept "freq" as an argument which in turn used by the OPP helpers.

The OPP support is added along with the old freq-table based clock scaling
so that the existing platforms work as expected.

Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/core/ufshcd.c | 144 +++++++++++++++++++++++++++++---------
 include/ufs/ufshcd.h      |   4 ++
 2 files changed, 115 insertions(+), 33 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index c2df07545f96..55de0ff1f01f 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/pm_opp.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/clock.h>
 #include <linux/iopoll.h>
@@ -275,7 +276,8 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba);
 static void ufshcd_resume_clkscaling(struct ufs_hba *hba);
 static void ufshcd_suspend_clkscaling(struct ufs_hba *hba);
 static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba);
-static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up);
+static int ufshcd_scale_clks(struct ufs_hba *hba, unsigned long freq,
+			     bool scale_up);
 static irqreturn_t ufshcd_intr(int irq, void *__hba);
 static int ufshcd_change_power_mode(struct ufs_hba *hba,
 			     struct ufs_pa_layer_attr *pwr_mode);
@@ -1062,14 +1064,32 @@ static int ufshcd_set_clk_freq(struct ufs_hba *hba, bool scale_up)
 	return ret;
 }
 
+static int ufshcd_opp_set_rate(struct ufs_hba *hba, unsigned long freq)
+{
+	struct dev_pm_opp *opp;
+	int ret;
+
+	opp = dev_pm_opp_find_freq_floor_indexed(hba->dev,
+						 &freq, 0);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	ret = dev_pm_opp_set_opp(hba->dev, opp);
+	dev_pm_opp_put(opp);
+
+	return ret;
+}
+
 /**
  * ufshcd_scale_clks - scale up or scale down UFS controller clocks
  * @hba: per adapter instance
+ * @freq: frequency to scale
  * @scale_up: True if scaling up and false if scaling down
  *
  * Return: 0 if successful; < 0 upon failure.
  */
-static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
+static int ufshcd_scale_clks(struct ufs_hba *hba, unsigned long freq,
+			     bool scale_up)
 {
 	int ret = 0;
 	ktime_t start = ktime_get();
@@ -1078,13 +1098,21 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
 	if (ret)
 		goto out;
 
-	ret = ufshcd_set_clk_freq(hba, scale_up);
+	if (hba->use_pm_opp)
+		ret = ufshcd_opp_set_rate(hba, freq);
+	else
+		ret = ufshcd_set_clk_freq(hba, scale_up);
 	if (ret)
 		goto out;
 
 	ret = ufshcd_vops_clk_scale_notify(hba, scale_up, POST_CHANGE);
-	if (ret)
-		ufshcd_set_clk_freq(hba, !scale_up);
+	if (ret) {
+		if (hba->use_pm_opp)
+			ufshcd_opp_set_rate(hba,
+					    hba->devfreq->previous_freq);
+		else
+			ufshcd_set_clk_freq(hba, !scale_up);
+	}
 
 out:
 	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
@@ -1096,12 +1124,13 @@ static int ufshcd_scale_clks(struct ufs_hba *hba, bool scale_up)
 /**
  * ufshcd_is_devfreq_scaling_required - check if scaling is required or not
  * @hba: per adapter instance
+ * @freq: frequency to scale
  * @scale_up: True if scaling up and false if scaling down
  *
  * Return: true if scaling is required, false otherwise.
  */
 static bool ufshcd_is_devfreq_scaling_required(struct ufs_hba *hba,
-					       bool scale_up)
+					       unsigned long freq, bool scale_up)
 {
 	struct ufs_clk_info *clki;
 	struct list_head *head = &hba->clk_list_head;
@@ -1109,6 +1138,9 @@ static bool ufshcd_is_devfreq_scaling_required(struct ufs_hba *hba,
 	if (list_empty(head))
 		return false;
 
+	if (hba->use_pm_opp)
+		return freq != hba->clk_scaling.target_freq;
+
 	list_for_each_entry(clki, head, list) {
 		if (!IS_ERR_OR_NULL(clki->clk)) {
 			if (scale_up && clki->max_freq) {
@@ -1304,12 +1336,14 @@ static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba, int err, bool sc
 /**
  * ufshcd_devfreq_scale - scale up/down UFS clocks and gear
  * @hba: per adapter instance
+ * @freq: frequency to scale
  * @scale_up: True for scaling up and false for scalin down
  *
  * Return: 0 for success; -EBUSY if scaling can't happen at this time; non-zero
  * for any other errors.
  */
-static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
+static int ufshcd_devfreq_scale(struct ufs_hba *hba, unsigned long freq,
+				bool scale_up)
 {
 	int ret = 0;
 
@@ -1324,7 +1358,7 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 			goto out_unprepare;
 	}
 
-	ret = ufshcd_scale_clks(hba, scale_up);
+	ret = ufshcd_scale_clks(hba, freq, scale_up);
 	if (ret) {
 		if (!scale_up)
 			ufshcd_scale_gear(hba, true);
@@ -1335,7 +1369,8 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 	if (scale_up) {
 		ret = ufshcd_scale_gear(hba, true);
 		if (ret) {
-			ufshcd_scale_clks(hba, false);
+			ufshcd_scale_clks(hba, hba->devfreq->previous_freq,
+					  false);
 			goto out_unprepare;
 		}
 	}
@@ -1393,9 +1428,22 @@ static int ufshcd_devfreq_target(struct device *dev,
 	if (!ufshcd_is_clkscaling_supported(hba))
 		return -EINVAL;
 
-	clki = list_first_entry(&hba->clk_list_head, struct ufs_clk_info, list);
-	/* Override with the closest supported frequency */
-	*freq = (unsigned long) clk_round_rate(clki->clk, *freq);
+	if (hba->use_pm_opp) {
+		struct dev_pm_opp *opp;
+
+		/* Get the recommended frequency from OPP framework */
+		opp = devfreq_recommended_opp(dev, freq, flags);
+		if (IS_ERR(opp))
+			return PTR_ERR(opp);
+
+		dev_pm_opp_put(opp);
+	} else {
+		/* Override with the closest supported frequency */
+		clki = list_first_entry(&hba->clk_list_head, struct ufs_clk_info,
+					list);
+		*freq =	(unsigned long) clk_round_rate(clki->clk, *freq);
+	}
+
 	spin_lock_irqsave(hba->host->host_lock, irq_flags);
 	if (ufshcd_eh_in_progress(hba)) {
 		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
@@ -1410,12 +1458,17 @@ static int ufshcd_devfreq_target(struct device *dev,
 		goto out;
 	}
 
-	/* Decide based on the rounded-off frequency and update */
-	scale_up = *freq == clki->max_freq;
-	if (!scale_up)
+	/* Decide based on the target or rounded-off frequency and update */
+	if (hba->use_pm_opp)
+		scale_up = *freq > hba->clk_scaling.target_freq;
+	else
+		scale_up = *freq == clki->max_freq;
+
+	if (!hba->use_pm_opp && !scale_up)
 		*freq = clki->min_freq;
+
 	/* Update the frequency */
-	if (!ufshcd_is_devfreq_scaling_required(hba, scale_up)) {
+	if (!ufshcd_is_devfreq_scaling_required(hba, *freq, scale_up)) {
 		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
 		ret = 0;
 		goto out; /* no state change required */
@@ -1423,7 +1476,9 @@ static int ufshcd_devfreq_target(struct device *dev,
 	spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
 
 	start = ktime_get();
-	ret = ufshcd_devfreq_scale(hba, scale_up);
+	ret = ufshcd_devfreq_scale(hba, *freq, scale_up);
+	if (!ret)
+		hba->clk_scaling.target_freq = *freq;
 
 	trace_ufshcd_profile_clk_scaling(dev_name(hba->dev),
 		(scale_up ? "up" : "down"),
@@ -1443,8 +1498,6 @@ static int ufshcd_devfreq_get_dev_status(struct device *dev,
 	struct ufs_hba *hba = dev_get_drvdata(dev);
 	struct ufs_clk_scaling *scaling = &hba->clk_scaling;
 	unsigned long flags;
-	struct list_head *clk_list = &hba->clk_list_head;
-	struct ufs_clk_info *clki;
 	ktime_t curr_t;
 
 	if (!ufshcd_is_clkscaling_supported(hba))
@@ -1457,17 +1510,24 @@ static int ufshcd_devfreq_get_dev_status(struct device *dev,
 	if (!scaling->window_start_t)
 		goto start_window;
 
-	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
 	/*
 	 * If current frequency is 0, then the ondemand governor considers
 	 * there's no initial frequency set. And it always requests to set
 	 * to max. frequency.
 	 */
-	stat->current_frequency = clki->curr_freq;
+	if (hba->use_pm_opp) {
+		stat->current_frequency = hba->clk_scaling.target_freq;
+	} else {
+		struct list_head *clk_list = &hba->clk_list_head;
+		struct ufs_clk_info *clki;
+
+		clki = list_first_entry(clk_list, struct ufs_clk_info, list);
+		stat->current_frequency = clki->curr_freq;
+	}
+
 	if (scaling->is_busy_started)
 		scaling->tot_busy_t += ktime_us_delta(curr_t,
 				scaling->busy_start_t);
-
 	stat->total_time = ktime_us_delta(curr_t, scaling->window_start_t);
 	stat->busy_time = scaling->tot_busy_t;
 start_window:
@@ -1496,9 +1556,11 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
 	if (list_empty(clk_list))
 		return 0;
 
-	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
-	dev_pm_opp_add(hba->dev, clki->min_freq, 0);
-	dev_pm_opp_add(hba->dev, clki->max_freq, 0);
+	if (!hba->use_pm_opp) {
+		clki = list_first_entry(clk_list, struct ufs_clk_info, list);
+		dev_pm_opp_add(hba->dev, clki->min_freq, 0);
+		dev_pm_opp_add(hba->dev, clki->max_freq, 0);
+	}
 
 	ufshcd_vops_config_scaling_param(hba, &hba->vps->devfreq_profile,
 					 &hba->vps->ondemand_data);
@@ -1510,8 +1572,10 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
 		ret = PTR_ERR(devfreq);
 		dev_err(hba->dev, "Unable to register with devfreq %d\n", ret);
 
-		dev_pm_opp_remove(hba->dev, clki->min_freq);
-		dev_pm_opp_remove(hba->dev, clki->max_freq);
+		if (!hba->use_pm_opp) {
+			dev_pm_opp_remove(hba->dev, clki->min_freq);
+			dev_pm_opp_remove(hba->dev, clki->max_freq);
+		}
 		return ret;
 	}
 
@@ -1523,7 +1587,6 @@ static int ufshcd_devfreq_init(struct ufs_hba *hba)
 static void ufshcd_devfreq_remove(struct ufs_hba *hba)
 {
 	struct list_head *clk_list = &hba->clk_list_head;
-	struct ufs_clk_info *clki;
 
 	if (!hba->devfreq)
 		return;
@@ -1531,9 +1594,13 @@ static void ufshcd_devfreq_remove(struct ufs_hba *hba)
 	devfreq_remove_device(hba->devfreq);
 	hba->devfreq = NULL;
 
-	clki = list_first_entry(clk_list, struct ufs_clk_info, list);
-	dev_pm_opp_remove(hba->dev, clki->min_freq);
-	dev_pm_opp_remove(hba->dev, clki->max_freq);
+	if (!hba->use_pm_opp) {
+		struct ufs_clk_info *clki;
+
+		clki = list_first_entry(clk_list, struct ufs_clk_info, list);
+		dev_pm_opp_remove(hba->dev, clki->min_freq);
+		dev_pm_opp_remove(hba->dev, clki->max_freq);
+	}
 }
 
 static void __ufshcd_suspend_clkscaling(struct ufs_hba *hba)
@@ -1618,7 +1685,7 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
 		ufshcd_resume_clkscaling(hba);
 	} else {
 		ufshcd_suspend_clkscaling(hba);
-		err = ufshcd_devfreq_scale(hba, true);
+		err = ufshcd_devfreq_scale(hba, ULONG_MAX, true);
 		if (err)
 			dev_err(hba->dev, "%s: failed to scale clocks up %d\n",
 					__func__, err);
@@ -7627,7 +7694,7 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	hba->silence_err_logs = false;
 
 	/* scale up clocks to max frequency before full reinitialization */
-	ufshcd_scale_clks(hba, true);
+	ufshcd_scale_clks(hba, ULONG_MAX, true);
 
 	err = ufshcd_hba_enable(hba);
 
@@ -9159,6 +9226,17 @@ static int ufshcd_init_clocks(struct ufs_hba *hba)
 		dev_dbg(dev, "%s: clk: %s, rate: %lu\n", __func__,
 				clki->name, clk_get_rate(clki->clk));
 	}
+
+	/* Set Max. frequency for all clocks */
+	if (hba->use_pm_opp) {
+		ret = ufshcd_opp_set_rate(hba, ULONG_MAX);
+		if (ret) {
+			dev_err(hba->dev, "%s: failed to set OPP: %d", __func__,
+				ret);
+			goto out;
+		}
+	}
+
 out:
 	return ret;
 }
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7d07b256e906..c181cc5c523b 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -427,6 +427,7 @@ struct ufs_clk_gating {
  * @workq: workqueue to schedule devfreq suspend/resume work
  * @suspend_work: worker to suspend devfreq
  * @resume_work: worker to resume devfreq
+ * @target_freq: frequency requested by devfreq framework
  * @min_gear: lowest HS gear to scale down to
  * @is_enabled: tracks if scaling is currently enabled or not, controlled by
  *		clkscale_enable sysfs node
@@ -446,6 +447,7 @@ struct ufs_clk_scaling {
 	struct workqueue_struct *workq;
 	struct work_struct suspend_work;
 	struct work_struct resume_work;
+	unsigned long target_freq;
 	u32 min_gear;
 	bool is_enabled;
 	bool is_allowed;
@@ -865,6 +867,7 @@ enum ufshcd_mcq_opr {
  * @auto_bkops_enabled: to track whether bkops is enabled in device
  * @vreg_info: UFS device voltage regulator information
  * @clk_list_head: UFS host controller clocks list node head
+ * @use_pm_opp: Indicates whether OPP based scaling is used or not
  * @req_abort_count: number of times ufshcd_abort() has been called
  * @lanes_per_direction: number of lanes per data direction between the UFS
  *	controller and the UFS device.
@@ -1015,6 +1018,7 @@ struct ufs_hba {
 	bool auto_bkops_enabled;
 	struct ufs_vreg_info vreg_info;
 	struct list_head clk_list_head;
+	bool use_pm_opp;
 
 	/* Number of requests aborts */
 	int req_abort_count;
-- 
2.25.1

