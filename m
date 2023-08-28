Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38BC78AF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjH1LnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjH1Lmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:42:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F29C7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:42:44 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50078e52537so4695776e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693222963; x=1693827763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mURuWhQcqwdxA0h1SO5G5+/fSllQ5WaEtLbIkJXNYyI=;
        b=yp/o+hJTurbk9hbxVHq+huKnmev5FExbRnQcblRCC5YDByBmcoI1fejrDPev63I8Td
         r3wHQFup05eBHuqN3uRu5svRhOl6w9fFBjhYS2J/+g5WIY/giLV7rymCPdlkY3kWUmoT
         Ln5lkT40Hdek0PeAmRoRtIZclzCflQCvRX0M/hxLjlqILlCtgavVt9nGtDRCrPNKEIe6
         lvFog0AHfstR7b42uIJyCqvrkrvm7peFNoWnwojWUq2MXImrdrGJQripP5HJIUbhslHX
         2laxX6YaMZRiwWm6t0msnL44CQJ8XQvyfEajMlUanXK/g1eLlNbJQMvdo0JDdNFaWuOG
         shkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693222963; x=1693827763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mURuWhQcqwdxA0h1SO5G5+/fSllQ5WaEtLbIkJXNYyI=;
        b=Hm2x9lQTX+nQY3gKTMRGWKJ9pnT98BACL6YG/g9KgJqNXUOguDlB7cNpyeMZSinp4X
         H+9smpQqk+qx+IAnz/7N5D1pZsK/500kBijq2kfTt+oM1cRbc0EJMV3CCmWMWef8cjAo
         vQJ5ZyNcgr4+u8QODFBp7eS0MdnJvYD1KLqJJxwzZzztqC0sCsTczxfghgJ4tVuvft2g
         JVSq58GOg9zq8gAWiY8hIgW9FTrAu20l8FQ7ahCKqbm2ZzBRWVsjwoCPxhS1hiNIj4OQ
         YslLOLaFKy0ly3U58BPDpANld7z5os0pquB89FtqYO+dsJB4Ii0Dzmz1nWGYoRIaL6zH
         VhpA==
X-Gm-Message-State: AOJu0YwNsFQl2tZbiKZf4ubZPQG2RkR6cLJ2YgtfO27udETiZnzdUDMX
        35MOsmIn1YwubfdjUNtWBbhrDQ==
X-Google-Smtp-Source: AGHT+IFF9cWv3W2h6F3dTzAhz5H/0aOcEqyDUNLcJ6iMAznQ95fy8xn7BMPpo2YfntCVFdG90CpkOQ==
X-Received: by 2002:a05:6512:3189:b0:4f7:6453:f3f1 with SMTP id i9-20020a056512318900b004f76453f3f1mr24058858lfe.15.1693222962771;
        Mon, 28 Aug 2023 04:42:42 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id b2-20020ac247e2000000b005009920b6afsm1547799lfp.9.2023.08.28.04.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 04:42:42 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 28 Aug 2023 13:42:19 +0200
Subject: [PATCH v14 7/9] soc: qcom: cpr-common: Add threads support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v14-7-9fd23241493d@linaro.org>
References: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693222948; l=6379;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=S8vmgrJN9AFT0bpi7IGZdre8ux94XqD5utZkNeZW4O4=;
 b=FlezQ3B0xYfT41r4cYIwm5Kxn6q5F+vyIHbFKlqF3IhwSb5UBled8udx/kMCSpxAMDuKHXTuK
 3MJOTuvu3eTCa+XX9TaTdARvOeCT+nmjT4C3aEddZvBXLZ2AVD+FRzm
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
2.42.0

