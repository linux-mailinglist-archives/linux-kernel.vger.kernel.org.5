Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C6476CD07
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjHBMjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjHBMiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:38:54 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247442737
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:38:33 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9a828c920so106345531fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690979910; x=1691584710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6iaGA/yeCE/Lf+ArixfofIFT/9x07smUmbo4Bxdl+U=;
        b=ZFhkbOoKPak08NlBbo+Um+YLD+3thwkVLDjUH4CrnwtRzajDNTPjHA84HToPPchKbJ
         TkH3JEcloUM/D3KWpKx19rB2sxEDYJVjjjIiLcJsIU27pbAPn+bS97cvRp4Bl/DVBC34
         V9JCZHD6DRJwob06yUgua7/dPWw/daXKhUv/pUEJCVfgZ264GUZf2At3TonSTDHacGfU
         ngj4ti12q/WMWvBAjfpIS1OahZx7b/J5eqQOZggWIufzYxdf79f29L2i4+dQtvZs54jd
         VMitD0M09SAmYfBULdrlqNClvHmZ2R2d/LtLmuqb8t/ptpYLl5uZtSpx1Vhjlg79aok8
         ylAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979910; x=1691584710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6iaGA/yeCE/Lf+ArixfofIFT/9x07smUmbo4Bxdl+U=;
        b=ORjd2kB9AbQCm67uiT+TReGl6YmTi3bFq3qAD8fQR0VvDkvXE4kBkLXdk7A9FNEgV3
         q6Okonfig4hw1LvsZomaHw/6VEFJHjKfTTjLlicJUTq9DAdamPWZVf7/2o0dvCJM2I3f
         A6phAUST1qCnTCE2sAnIfca2RVhqGybRuNimbrM7i0jwvzCiJ38wZu1ww7pLyM5hjULg
         GUx8QsZT043gV+conS7OFX7PfmeZIMRzsCu+vxX6irW/82tcZsnFUNLGMr8+GbkyFuhn
         kmC+fKrAI1auInIOaj50dh7IbPEJHAmYDdseX5cQIXLVeVCXSM/ivmIcPfPmZKALkIYl
         JkPQ==
X-Gm-Message-State: ABy/qLZNTGFeMIG7eJXVSSc7v+nmQtQg+Y+zZGOAEuhORoRtorzYDxi3
        A3Ykh9RtlCLzrEJl803hM+/52w==
X-Google-Smtp-Source: APBJJlFP/4rU6mnFjhSjsfqkAqSp4WGEP/TU/Gjmtp0AnA1QQV8VujmqcGlrZ+niimRJlY5ngO96lQ==
X-Received: by 2002:a2e:7816:0:b0:2b1:a89a:5f2b with SMTP id t22-20020a2e7816000000b002b1a89a5f2bmr4698494ljc.2.1690979910750;
        Wed, 02 Aug 2023 05:38:30 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id h8-20020a2e9ec8000000b002b9e5fe86dasm1897050ljk.81.2023.08.02.05.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:38:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 02 Aug 2023 14:37:48 +0200
Subject: [PATCH v13 08/10] soc: qcom: cpr-common: Add threads support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v13-8-d01cff1c54cf@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690979891; l=6379;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/qN6id+G6Hc1Hg3hbtJEIbdmDiwIlOm7I1a8TXQ7Lb4=;
 b=1LdcyLQj3IydQrBgHW4l7MLyd4H888jdb1RNIIgUs/TR0CtDOPy6C31KmBCpGUK21qWTFtAgU
 Bu7TeiB4mkeDpLdhk2CPmLRhBqqDEXF6qZIXqdVD6lo/pUr6gKRSL36
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Add support for parsing per-CPR-thread data in preparation for introducing
CPR3+ support.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: separate this patch out of a bigger one]
Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/genpd/qcom/cpr-common.c | 42 ++++++++++++++++++++++++-----------------
 drivers/genpd/qcom/cpr-common.h |  8 ++++++--
 drivers/genpd/qcom/cpr.c        |  4 ++--
 3 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/genpd/qcom/cpr-common.c b/drivers/genpd/qcom/cpr-common.c
index 3e3a4a61cfde..9001dccd4d95 100644
--- a/drivers/genpd/qcom/cpr-common.c
+++ b/drivers/genpd/qcom/cpr-common.c
@@ -73,35 +73,42 @@ static int cpr_read_fuse_uV(int init_v_width, int step_size_uV, int ref_uV,
 	return DIV_ROUND_UP(uV, step_volt) * step_volt;
 }
 
-const struct cpr_fuse *cpr_get_fuses(struct device *dev,
+const struct cpr_fuse *cpr_get_fuses(struct device *dev, int tid,
 				     unsigned int num_fuse_corners)
 {
 	struct cpr_fuse *fuses;
-	int i;
+	char cpr_name[11]; /* length of "cpr" + length of UINT_MAX (7) + \0 */
+	unsigned int i;
 
 	fuses = devm_kcalloc(dev, num_fuse_corners, sizeof(*fuses), GFP_KERNEL);
 	if (!fuses)
 		return ERR_PTR(-ENOMEM);
 
+	/* Support legacy bindings */
+	if (tid == UINT_MAX)
+		snprintf(cpr_name, sizeof(cpr_name), "cpr");
+	else
+		snprintf(cpr_name, sizeof(cpr_name), "cpr%d", tid);
+
 	for (i = 0; i < num_fuse_corners; i++) {
-		char tbuf[32];
+		char tbuf[50];
 
-		snprintf(tbuf, 32, "cpr_ring_osc%d", i + 1);
+		snprintf(tbuf, sizeof(tbuf), "%s_ring_osc%d", cpr_name, i + 1);
 		fuses[i].ring_osc = devm_kstrdup(dev, tbuf, GFP_KERNEL);
 		if (!fuses[i].ring_osc)
 			return ERR_PTR(-ENOMEM);
 
-		snprintf(tbuf, 32, "cpr_init_voltage%d", i + 1);
+		snprintf(tbuf, sizeof(tbuf), "%s_init_voltage%d", cpr_name, i + 1);
 		fuses[i].init_voltage = devm_kstrdup(dev, tbuf, GFP_KERNEL);
 		if (!fuses[i].init_voltage)
 			return ERR_PTR(-ENOMEM);
 
-		snprintf(tbuf, 32, "cpr_quotient%d", i + 1);
+		snprintf(tbuf, sizeof(tbuf), "%s_quotient%d", cpr_name, i + 1);
 		fuses[i].quotient = devm_kstrdup(dev, tbuf, GFP_KERNEL);
 		if (!fuses[i].quotient)
 			return ERR_PTR(-ENOMEM);
 
-		snprintf(tbuf, 32, "cpr_quotient_offset%d", i + 1);
+		snprintf(tbuf, sizeof(tbuf), "%s_quotient_offset%d", cpr_name, i + 1);
 		fuses[i].quotient_offset = devm_kstrdup(dev, tbuf, GFP_KERNEL);
 		if (!fuses[i].quotient_offset)
 			return ERR_PTR(-ENOMEM);
@@ -202,15 +209,15 @@ int cpr_find_initial_corner(struct device *dev, struct clk *cpu_clk,
 }
 EXPORT_SYMBOL_GPL(cpr_find_initial_corner);
 
-unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp)
+unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp, u32 tid)
 {
 	struct device_node *np;
 	unsigned int fuse_corner = 0;
 
 	np = dev_pm_opp_get_of_node(opp);
-	if (of_property_read_u32(np, "qcom,opp-fuse-level", &fuse_corner))
-		pr_err("%s: missing 'qcom,opp-fuse-level' property\n",
-		       __func__);
+	if (of_property_read_u32_index(np, "qcom,opp-fuse-level", tid, &fuse_corner))
+		pr_err("%s: missing 'qcom,opp-fuse-level[%u]' property\n",
+		       __func__, tid);
 
 	of_node_put(np);
 
@@ -235,15 +242,16 @@ u64 cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 	if (!ref_np)
 		goto out_ref;
 
-	do {
-		of_node_put(child_req_np);
-		child_np = of_get_next_available_child(desc_np, child_np);
+	for_each_available_child_of_node(desc_np, child_np) {
 		child_req_np = of_parse_phandle(child_np, "required-opps", 0);
-	} while (child_np && child_req_np != ref_np);
 
-	if (child_np && child_req_np == ref_np)
-		of_property_read_u64(child_np, "opp-hz", &rate);
+		if (child_np && child_req_np == ref_np) {
+			of_property_read_u64(child_np, "opp-hz", &rate);
+			goto out;
+		}
+	}
 
+out:
 	of_node_put(child_req_np);
 	of_node_put(child_np);
 	of_node_put(ref_np);
diff --git a/drivers/genpd/qcom/cpr-common.h b/drivers/genpd/qcom/cpr-common.h
index 1b2fa344eb09..2c5bb81ab713 100644
--- a/drivers/genpd/qcom/cpr-common.h
+++ b/drivers/genpd/qcom/cpr-common.h
@@ -22,6 +22,9 @@ struct fuse_corner_data {
 	int ref_uV;
 	int max_uV;
 	int min_uV;
+	int range_uV;
+	/* fuse volt: closed/open loop */
+	int volt_cloop_adjust;
 	int volt_oloop_adjust;
 	int max_volt_scale;
 	int max_quot_scale;
@@ -55,6 +58,7 @@ struct corner {
 	u32 save_ctl;
 	u32 save_irq;
 	u64 freq;
+	bool is_open_loop;
 	struct fuse_corner *fuse_corner;
 };
 
@@ -81,7 +85,7 @@ int cpr_populate_ring_osc_idx(struct device *dev,
 			      struct fuse_corner *fuse_corner,
 			      const struct cpr_fuse *cpr_fuse,
 			      int num_fuse_corners);
-const struct cpr_fuse *cpr_get_fuses(struct device *dev,
+const struct cpr_fuse *cpr_get_fuses(struct device *dev, int tid,
 				     unsigned int num_fuse_corners);
 int cpr_populate_fuse_common(struct device *dev,
 			     struct fuse_corner_data *fdata,
@@ -91,7 +95,7 @@ int cpr_populate_fuse_common(struct device *dev,
 			     int init_v_step);
 int cpr_find_initial_corner(struct device *dev, struct clk *cpu_clk,
 			    struct corner *corners, int num_corners);
-u32 cpr_get_fuse_corner(struct dev_pm_opp *opp);
+u32 cpr_get_fuse_corner(struct dev_pm_opp *opp, u32 tid);
 u64 cpr_get_opp_hz_for_req(struct dev_pm_opp *ref, struct device *cpu_dev);
 int cpr_calculate_scaling(struct device *dev,
 			  const char *quot_offset,
diff --git a/drivers/genpd/qcom/cpr.c b/drivers/genpd/qcom/cpr.c
index bd0ac95e86e7..9fd26080481a 100644
--- a/drivers/genpd/qcom/cpr.c
+++ b/drivers/genpd/qcom/cpr.c
@@ -851,7 +851,7 @@ static int cpr_corner_init(struct cpr_drv *drv)
 		opp = dev_pm_opp_find_level_exact(&drv->pd.dev, level);
 		if (IS_ERR(opp))
 			return -EINVAL;
-		fc = cpr_get_fuse_corner(opp);
+		fc = cpr_get_fuse_corner(opp, 0);
 		if (!fc) {
 			dev_pm_opp_put(opp);
 			return -EINVAL;
@@ -1325,7 +1325,7 @@ static int cpr_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	drv->cpr_fuses = cpr_get_fuses(drv->dev, desc->num_fuse_corners);
+	drv->cpr_fuses = cpr_get_fuses(drv->dev, UINT_MAX, desc->num_fuse_corners);
 	if (IS_ERR(drv->cpr_fuses))
 		return PTR_ERR(drv->cpr_fuses);
 

-- 
2.41.0

