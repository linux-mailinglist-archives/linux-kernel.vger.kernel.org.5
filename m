Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE39876CD03
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjHBMjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjHBMim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:38:42 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4352026BB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:38:31 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9bf52cd08so106514741fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690979908; x=1691584708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GlT2pkYBcy/nQRcCdP9T0z6uOlkGORzEMj7h5JKTHw=;
        b=EGeobirt9ZFZYlcTK7eig3uqr5feCM2E9PnhB8AWfRL49d9q21Pb5i4b18IyCWSQTj
         rqstbkm5QixPewSuRkAM6ocwReczL6wC4F9E8yEbSo/o0WLIjC5DBDVmLL4rZCUTiS64
         XQhC5LdgExAWCHk2HTEuXGFzyJbwDE/GOGrQbRvjN+6RDqOmv1/E38enotw165eSPRFI
         JJFxjdtZtUimzKewgz00ayvWhJmJb1ifcujhr5wtHmjZSBZhnV4q2kqTY8T4Dg2w2V1D
         ZFSowSPNO3laL6h7k6viwGmfUiIEK1c/owXtH78aCG7iLeOTuH3duhgX3Kv/QyhKIIIs
         DjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979908; x=1691584708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GlT2pkYBcy/nQRcCdP9T0z6uOlkGORzEMj7h5JKTHw=;
        b=fytcmK5+mGj/yicEUK2oi5HMGXfnLYvztMjWJ1/ks853EH2xVTESDTZeEY0v5KszYo
         2TkOGE5oho+SQjWZ8T3/uOkdx9KOjhnmRmd3lsCEdvIeo0XUgA6ZelIlgOBgifOlsqkw
         FXAqcThyVcVjpyYhFcH1oLPkZKhuT4iyysQM+53MaZ86dKGvUAo5bA15Pi/g1wQaYjXj
         Coj3mM+JXpNtPwh3xDOzeWnqBW1zxNG68jIyQJP6oByLmECcN8v6o1HYG1RShl2xb4LX
         DN7kZClHv0SGGp6xemHljY5Pgh5qA6En+ZqqsZNh70AhaPaZ1EdrJChzrNJJ7r+V5hqT
         RJxg==
X-Gm-Message-State: ABy/qLabCK5OdvDWvK2wS1tLTtj2RWenPWPsuRdTgcqjfJ/WuvGhVhF+
        y0mgcrlh9SIoJM/+hxvVbjiGIw==
X-Google-Smtp-Source: APBJJlFsxtpYwhWUi8Hj8oSH7QlhrDmmLFiKhi0x6CSVj9seyiiq15j9d/8khLKTgWjiJuAcQfHPCg==
X-Received: by 2002:a2e:7011:0:b0:2b6:c886:681 with SMTP id l17-20020a2e7011000000b002b6c8860681mr5088641ljc.6.1690979908788;
        Wed, 02 Aug 2023 05:38:28 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id h8-20020a2e9ec8000000b002b9e5fe86dasm1897050ljk.81.2023.08.02.05.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:38:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 02 Aug 2023 14:37:47 +0200
Subject: [PATCH v13 07/10] soc: qcom: cpr: Use u64 for frequency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v13-7-d01cff1c54cf@linaro.org>
References: <20230217-topic-cpr3h-v13-0-d01cff1c54cf@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v13-0-d01cff1c54cf@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690979891; l=4796;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PnNJAxexYUK7Fjao2Gj25/Eg+Za0hd+877zekBWHmIc=;
 b=DFBbjB6mGVKC4gBxsiqg2AbCV1shtmdjVEx28n+/77OP6+8sg/uDosX58qW7Q9vGdqnAH93Xm
 QSPCaJF2t/QBVcHx6A1N2rrfVljdV49hk3+VeLZA62HIGIouj9bL8NQ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32 bits is not enough for over-2.changeGHz frequencies. Move all variables
that operate on Hz to u64 to avoid overflows.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/genpd/qcom/cpr-common.c | 13 +++++++------
 drivers/genpd/qcom/cpr-common.h |  9 ++++-----
 drivers/genpd/qcom/cpr.c        |  8 ++++----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/genpd/qcom/cpr-common.c b/drivers/genpd/qcom/cpr-common.c
index 44c681bbbf13..3e3a4a61cfde 100644
--- a/drivers/genpd/qcom/cpr-common.c
+++ b/drivers/genpd/qcom/cpr-common.c
@@ -218,7 +218,7 @@ unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(cpr_get_fuse_corner);
 
-unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
+u64 cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 				     struct device *cpu_dev)
 {
 	u64 rate = 0;
@@ -250,7 +250,7 @@ unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 out_ref:
 	of_node_put(desc_np);
 
-	return (unsigned long) rate;
+	return rate;
 }
 EXPORT_SYMBOL_GPL(cpr_get_opp_hz_for_req);
 
@@ -260,7 +260,7 @@ int cpr_calculate_scaling(struct device *dev,
 			  const struct corner *corner)
 {
 	u32 quot_diff = 0;
-	unsigned long freq_diff;
+	u64 freq_diff;
 	int scaling;
 	const struct fuse_corner *fuse, *prev_fuse;
 	int ret;
@@ -280,8 +280,9 @@ int cpr_calculate_scaling(struct device *dev,
 	}
 
 	freq_diff = fuse->max_freq - prev_fuse->max_freq;
-	freq_diff /= 1000000; /* Convert to MHz */
-	scaling = 1000 * quot_diff / freq_diff;
+	freq_diff = div_u64(freq_diff, 1000000); /* Convert to MHz */
+	scaling = 1000 * quot_diff;
+	do_div(scaling, freq_diff);
 	return min(scaling, fdata->max_quot_scale);
 }
 EXPORT_SYMBOL_GPL(cpr_calculate_scaling);
@@ -289,7 +290,7 @@ EXPORT_SYMBOL_GPL(cpr_calculate_scaling);
 int cpr_interpolate(const struct corner *corner, int step_volt,
 		    const struct fuse_corner_data *fdata)
 {
-	unsigned long f_high, f_low, f_diff;
+	u64 f_high, f_low, f_diff;
 	int uV_high, uV_low, uV;
 	u64 temp, temp_limit;
 	const struct fuse_corner *fuse, *prev_fuse;
diff --git a/drivers/genpd/qcom/cpr-common.h b/drivers/genpd/qcom/cpr-common.h
index 0aa227617d2f..1b2fa344eb09 100644
--- a/drivers/genpd/qcom/cpr-common.h
+++ b/drivers/genpd/qcom/cpr-common.h
@@ -42,7 +42,7 @@ struct fuse_corner {
 	int step_quot;
 	const struct reg_sequence *accs;
 	int num_accs;
-	unsigned long max_freq;
+	u64 max_freq;
 	u8 ring_osc_idx;
 };
 
@@ -54,13 +54,13 @@ struct corner {
 	int quot_adjust;
 	u32 save_ctl;
 	u32 save_irq;
-	unsigned long freq;
+	u64 freq;
 	struct fuse_corner *fuse_corner;
 };
 
 struct corner_data {
 	unsigned int fuse_corner;
-	unsigned long freq;
+	u64 freq;
 };
 
 struct acc_desc {
@@ -92,8 +92,7 @@ int cpr_populate_fuse_common(struct device *dev,
 int cpr_find_initial_corner(struct device *dev, struct clk *cpu_clk,
 			    struct corner *corners, int num_corners);
 u32 cpr_get_fuse_corner(struct dev_pm_opp *opp);
-unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
-				     struct device *cpu_dev);
+u64 cpr_get_opp_hz_for_req(struct dev_pm_opp *ref, struct device *cpu_dev);
 int cpr_calculate_scaling(struct device *dev,
 			  const char *quot_offset,
 			  const struct fuse_corner_data *fdata,
diff --git a/drivers/genpd/qcom/cpr.c b/drivers/genpd/qcom/cpr.c
index 2cfeefebd24c..bd0ac95e86e7 100644
--- a/drivers/genpd/qcom/cpr.c
+++ b/drivers/genpd/qcom/cpr.c
@@ -826,8 +826,8 @@ static int cpr_corner_init(struct cpr_drv *drv)
 	struct corner_data *cdata;
 	const struct fuse_corner_data *fdata;
 	bool apply_scaling;
-	unsigned long freq_diff, freq_diff_mhz;
-	unsigned long freq;
+	unsigned long freq_diff_mhz;
+	u64 freq, freq_diff;
 	int step_volt = regulator_get_linear_step(drv->vdd_apc);
 	struct dev_pm_opp *opp;
 
@@ -866,7 +866,7 @@ static int cpr_corner_init(struct cpr_drv *drv)
 		cdata[level - 1].freq = freq;
 
 		fuse = &drv->fuse_corners[fnum];
-		dev_dbg(drv->dev, "freq: %lu level: %u fuse level: %u\n",
+		dev_dbg(drv->dev, "freq: %llu level: %u fuse level: %u\n",
 			freq, dev_pm_opp_get_level(opp) - 1, fnum);
 		if (freq > fuse->max_freq)
 			fuse->max_freq = freq;
@@ -940,7 +940,7 @@ static int cpr_corner_init(struct cpr_drv *drv)
 
 		if (apply_scaling) {
 			freq_diff = fuse->max_freq - corner->freq;
-			freq_diff_mhz = freq_diff / 1000000;
+			freq_diff_mhz = (u32)div_u64(freq_diff, 1000000);
 			corner->quot_adjust = scaling * freq_diff_mhz / 1000;
 
 			corner->uV = cpr_interpolate(corner, step_volt, fdata);

-- 
2.41.0

