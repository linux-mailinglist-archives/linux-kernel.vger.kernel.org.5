Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F2079BE9A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244996AbjIKVIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241634AbjIKPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:11:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C456FE50
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:11:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so6049291a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445059; x=1695049859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Go8soGhozFyZDdpekIDfsnoJQHz3sv19mqRqwFidsQ=;
        b=upDxVrujiJPei1qqYtTVWI1jVYpExNjNSDi2PlePpNnisPlLKPMla5yu35E4t8/Nyb
         jyPQVX1/w4+fPLwTWvXLdFrq3bPFT4g3rRkIGmgHHHHz2St+l45cYSRIAiqm+lzebCbc
         0p/ro69HqkEP2bWTHvAM/bIV82XZvYum1zMhMP/jJ0viUCDY8yMfDCs3V1X4kd3k0LTq
         PlUzekWInp/omvFJMfAvUsb/v7KH4EdWKvGEzdOEO8wQaw9rKop1DbJvYe87Lh1uE5cQ
         w3pocIdbmtindNNSjs0bBpHXNSFNAiUwZf4X3Kdj2HrQrZcuA7qjY2HTIgaMnPOgJAVH
         VpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445059; x=1695049859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Go8soGhozFyZDdpekIDfsnoJQHz3sv19mqRqwFidsQ=;
        b=pIZ1AJDLrHmRS/ERLVOwpINDbKkwoHCZLVdkCWNOttJ61OPouVjBcSHiR5HbiDyKB2
         yxaQhyXpvZ3ufzvsvcPAIzEkGXmYag3xg3/KJPeVc/HsVd94Kibw/pBr0jqzkS5XxATh
         d/HvGCTjbW1llAUD8s6h/dJczWoJuUv78mMp6K/tJMMxyVVhVhuDI7ZbdBZ5n/V6G/Bw
         hUIpuj7vhTUIVyPPBgDzTAHAkcp/NsXZd+1z4VZUjFABoxGLi3kaMRFX1zxRc6577bp2
         YAxYpIysBY0E6SySH9E2atf6AiByX/+SteQFmTG0mq+/b/uPwQ7IxwIR+sb6F3iisgcS
         uZJw==
X-Gm-Message-State: AOJu0YzAF60CUU1bL+89ksbFL85r8DI0IIr7gHKrC1Wtm3sB11JcnyR8
        uuAalaNuzotWIM6dESjXmAP9wA==
X-Google-Smtp-Source: AGHT+IHiYhxr+24cOk8gE+cu96H02Re+vpcUfn80D1q6RN1itKvte/hfail/Rq+AMq5HFWUU2P0c+g==
X-Received: by 2002:aa7:d402:0:b0:52b:c980:43f3 with SMTP id z2-20020aa7d402000000b0052bc98043f3mr8132781edq.28.1694445059295;
        Mon, 11 Sep 2023 08:10:59 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:10:58 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:31 +0200
Subject: [PATCH RFT 17/20] media: venus: pm_helpers: Simplify vcodec clock
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-17-a7d38bf87bdb@linaro.org>
References: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
In-Reply-To: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=13444;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6BGfkN0sVdRCleGUxSZssA0BPUP+ZuPOYmY/oEbAozY=;
 b=1nCUwuuaILLiPkIDfKcwswHQCilUZTknH7v5plrM7EyGYYQ8lsMzOj3KlcHD/1ZBTK8ZztY8O
 31gjj1nxPffDZikPYdJC7+f9GZOJ7qK6CX2dlayHvw4Ts9C6ODVbdoj
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the infrastructure is set up for vast expandability, but
it's far too complex for what is just 0-2 clocks. Categorize the
clocks and simplify their getting.

One notable change is that vcodec clocks are switched to use
devm_clk_get_optional, which will let us commonize the code further
while leaving the burden of figuring out which SoCs need codec-specific
clocks and which don't to the bindings checker.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       |  18 ----
 drivers/media/platform/qcom/venus/core.h       |   9 +-
 drivers/media/platform/qcom/venus/pm_helpers.c | 129 +++++++++++++------------
 3 files changed, 69 insertions(+), 87 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 435f6f10a905..42bfcef9449a 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -584,9 +584,6 @@ static const struct venus_resources msm8996_res = {
 	.reg_tbl_size = ARRAY_SIZE(msm8996_reg_preset),
 	.clks = {"core", "iface", "bus", "mbus" },
 	.clks_num = 4,
-	.vcodec0_clks = { "core" },
-	.vcodec1_clks = { "core" },
-	.vcodec_clks_num = 1,
 	.max_load = 2563200,
 	.hfi_version = HFI_VERSION_3XX,
 	.dma_mask = (GENMASK(31, 30) | GENMASK(28, 26) | GENMASK(24, 22)) - 1,
@@ -639,9 +636,6 @@ static const struct venus_resources sdm660_res = {
 	.bw_tbl_dec_size = ARRAY_SIZE(sdm660_bw_table_dec),
 	.clks = {"core", "iface", "bus", "bus_throttle" },
 	.clks_num = 4,
-	.vcodec0_clks = { "vcodec0_core" },
-	.vcodec1_clks = { "vcodec0_core" },
-	.vcodec_clks_num = 1,
 	.max_load = 1036800,
 	.hfi_version = HFI_VERSION_3XX,
 	.cp_size = 0x79000000,
@@ -683,9 +677,6 @@ static const struct venus_resources sdm845_res = {
 	.bw_tbl_dec_size = ARRAY_SIZE(sdm845_bw_table_dec),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
-	.vcodec0_clks = { "core", "bus" },
-	.vcodec1_clks = { "core", "bus" },
-	.vcodec_clks_num = 2,
 	.max_load = 3110400,	/* 4096x2160@90 */
 	.hfi_version = HFI_VERSION_4XX,
 	.vpu_version = VPU_VERSION_AR50,
@@ -702,9 +693,6 @@ static const struct venus_resources sdm845_res_v2 = {
 	.bw_tbl_dec_size = ARRAY_SIZE(sdm845_bw_table_dec),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
-	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
-	.vcodec1_clks = { "vcodec1_core", "vcodec1_bus" },
-	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = { "venus", "vcodec0", "vcodec1" },
 	.vcodec_pmdomains_num = 3,
 	.opp_pmdomain = pd_names_cx,
@@ -747,8 +735,6 @@ static const struct venus_resources sc7180_res = {
 	.bw_tbl_dec_size = ARRAY_SIZE(sc7180_bw_table_dec),
 	.clks = {"core", "iface", "bus" },
 	.clks_num = 3,
-	.vcodec0_clks = { "vcodec0_core", "vcodec0_bus" },
-	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_cx,
@@ -799,8 +785,6 @@ static const struct venus_resources sm8250_res = {
 	.clks_num = 2,
 	.resets = { "bus", "core" },
 	.resets_num = 2,
-	.vcodec0_clks = { "vcodec0_core" },
-	.vcodec_clks_num = 1,
 	.vcodec_pmdomains = { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_mx,
@@ -854,8 +838,6 @@ static const struct venus_resources sc7280_res = {
 	.ubwc_conf = &sc7280_ubwc_config,
 	.clks = {"core", "bus", "iface"},
 	.clks_num = 3,
-	.vcodec0_clks = {"vcodec_core", "vcodec_bus"},
-	.vcodec_clks_num = 2,
 	.vcodec_pmdomains = { "venus", "vcodec0" },
 	.vcodec_pmdomains_num = 2,
 	.opp_pmdomain = pd_names_cx,
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 16acf738fd6c..fd78f17c12d8 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -24,10 +24,11 @@
 #define VDBGFW	"VenusFW  : "
 
 #define VIDC_CLKS_NUM_MAX		4
-#define VIDC_VCODEC_CLKS_NUM_MAX	2
 #define VIDC_PMDOMAINS_NUM_MAX		3
 #define VIDC_RESETS_NUM_MAX		2
 
+#define MAX_NUM_VCODECS			2
+
 extern int venus_fw_debug;
 
 struct freq_tbl {
@@ -69,8 +70,6 @@ struct venus_resources {
 	const struct hfi_ubwc_config * const ubwc_conf;
 	const char * const clks[VIDC_CLKS_NUM_MAX];
 	const unsigned int clks_num;
-	const char * const vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
-	const char * const vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
 	const unsigned int vcodec_clks_num;
 	const char * const vcodec_pmdomains[VIDC_PMDOMAINS_NUM_MAX];
 	const unsigned int vcodec_pmdomains_num;
@@ -177,8 +176,8 @@ struct venus_core {
 	void __iomem *aon_base;
 	int irq;
 	struct clk *clks[VIDC_CLKS_NUM_MAX];
-	struct clk *vcodec0_clks[VIDC_VCODEC_CLKS_NUM_MAX];
-	struct clk *vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
+	struct clk *vcodec_core_clks[MAX_NUM_VCODECS];
+	struct clk *vcodec_bus_clks[MAX_NUM_VCODECS];
 	struct icc_path *video_path;
 	struct icc_path *cpucfg_path;
 	bool has_opp_table;
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 9a0e2a00f383..741b29cc76c9 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -110,67 +110,74 @@ static void core_clks_disable(struct venus_core *core)
 
 static int core_clks_set_rate(struct venus_core *core, unsigned long freq)
 {
-	int ret;
+	int i, ret;
 
 	ret = dev_pm_opp_set_rate(core->dev, freq);
 	if (ret)
 		return ret;
 
-	ret = clk_set_rate(core->vcodec0_clks[0], freq);
-	if (ret)
-		return ret;
-
-	ret = clk_set_rate(core->vcodec1_clks[0], freq);
-	if (ret)
-		return ret;
+	for (i = 0; i < MAX_NUM_VCODECS; i++) {
+		ret = clk_set_rate(core->vcodec_core_clks[i], freq);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
 
-static int vcodec_clks_get(struct venus_core *core, struct device *dev,
-			   struct clk **clks, const char * const *id)
+static int vcodec_clks_get(struct venus_core *core, struct device *dev, u8 id)
 {
-	const struct venus_resources *res = core->res;
-	unsigned int i;
+	char buf[13] = { 0 }; /* vcodecX_core\0 */
 
-	for (i = 0; i < res->vcodec_clks_num; i++) {
-		if (!id[i])
-			continue;
-		clks[i] = devm_clk_get(dev, id[i]);
-		if (IS_ERR(clks[i]))
-			return PTR_ERR(clks[i]);
+	/* Best we can do is 2 cores */
+	if (id > MAX_NUM_VCODECS - 1) {
+		dev_err(dev, "Got impossible vcodec id %u\n", id);
+		return -EINVAL;
+	};
+
+	snprintf(buf, sizeof(buf), "vcodec%u_core", id);
+
+	/* First try the non-legacy name */
+	core->vcodec_core_clks[id] = devm_clk_get_optional(dev, buf);
+	if (IS_ERR(core->vcodec_core_clks[id])) {
+		/* Try again, with the legacy name */
+		core->vcodec_core_clks[id] = devm_clk_get_optional(dev, "core");
+		if (IS_ERR(core->vcodec_core_clks[id]))
+			return PTR_ERR(core->vcodec_core_clks[id]);
+	}
+
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf), "vcodec%u_bus", id);
+
+	core->vcodec_bus_clks[id] = devm_clk_get_optional(dev, buf);
+	if (IS_ERR(core->vcodec_bus_clks[id])) {
+		core->vcodec_bus_clks[id] = devm_clk_get_optional(dev, "bus");
+		if (IS_ERR(core->vcodec_bus_clks[id]))
+			return PTR_ERR(core->vcodec_bus_clks[id]);
 	}
 
 	return 0;
 }
 
-static int vcodec_clks_enable(struct venus_core *core, struct clk **clks)
+static int vcodec_clks_enable(struct venus_core *core, u8 id)
 {
-	const struct venus_resources *res = core->res;
-	unsigned int i;
 	int ret;
 
-	for (i = 0; i < res->vcodec_clks_num; i++) {
-		ret = clk_prepare_enable(clks[i]);
-		if (ret)
-			goto err;
-	}
+	ret = clk_prepare_enable(core->vcodec_core_clks[id]);
+	if (ret)
+		return ret;
 
-	return 0;
-err:
-	while (i--)
-		clk_disable_unprepare(clks[i]);
+	ret = clk_prepare_enable(core->vcodec_bus_clks[id]);
+	if (ret)
+		clk_disable_unprepare(core->vcodec_core_clks[id]);
 
 	return ret;
 }
 
-static void vcodec_clks_disable(struct venus_core *core, struct clk **clks)
+static void vcodec_clks_disable(struct venus_core *core, u8 id)
 {
-	const struct venus_resources *res = core->res;
-	unsigned int i = res->vcodec_clks_num;
-
-	while (i--)
-		clk_disable_unprepare(clks[i]);
+	clk_disable_unprepare(core->vcodec_bus_clks[id]);
+	clk_disable_unprepare(core->vcodec_core_clks[id]);
 }
 
 static u32 load_per_instance(struct venus_inst *inst)
@@ -343,8 +350,7 @@ static int vdec_get_v3(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
 
-	return vcodec_clks_get(core, dev, core->vcodec0_clks,
-			       core->res->vcodec0_clks);
+	return vcodec_clks_get(core, dev, 0);
 }
 
 static int vdec_power_v3(struct device *dev, int on)
@@ -355,9 +361,9 @@ static int vdec_power_v3(struct device *dev, int on)
 	vcodec_control_v3(core, VIDC_SESSION_TYPE_DEC, true);
 
 	if (on == POWER_ON)
-		ret = vcodec_clks_enable(core, core->vcodec0_clks);
+		ret = vcodec_clks_enable(core, 0);
 	else
-		vcodec_clks_disable(core, core->vcodec0_clks);
+		vcodec_clks_disable(core, 0);
 
 	vcodec_control_v3(core, VIDC_SESSION_TYPE_DEC, false);
 
@@ -368,8 +374,7 @@ static int venc_get_v3(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
 
-	return vcodec_clks_get(core, dev, core->vcodec1_clks,
-			       core->res->vcodec1_clks);
+	return vcodec_clks_get(core, dev, 1);
 }
 
 static int venc_power_v3(struct device *dev, int on)
@@ -380,9 +385,9 @@ static int venc_power_v3(struct device *dev, int on)
 	vcodec_control_v3(core, VIDC_SESSION_TYPE_ENC, true);
 
 	if (on == POWER_ON)
-		ret = vcodec_clks_enable(core, core->vcodec1_clks);
+		ret = vcodec_clks_enable(core, 1);
 	else
-		vcodec_clks_disable(core, core->vcodec1_clks);
+		vcodec_clks_disable(core, 1);
 
 	vcodec_control_v3(core, VIDC_SESSION_TYPE_ENC, false);
 
@@ -441,7 +446,7 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		vcodec_clks_disable(core, core->vcodec0_clks);
+		vcodec_clks_disable(core, 0);
 
 		ret = vcodec_control_v4(core, VIDC_CORE_ID_1, false);
 		if (ret)
@@ -457,7 +462,7 @@ static int poweroff_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		vcodec_clks_disable(core, core->vcodec1_clks);
+		vcodec_clks_disable(core, 1);
 
 		ret = vcodec_control_v4(core, VIDC_CORE_ID_2, false);
 		if (ret)
@@ -484,7 +489,7 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		ret = vcodec_clks_enable(core, core->vcodec0_clks);
+		ret = vcodec_clks_enable(core, 0);
 		if (ret)
 			return ret;
 
@@ -502,7 +507,7 @@ static int poweron_coreid(struct venus_core *core, unsigned int coreid_mask)
 		if (ret)
 			return ret;
 
-		ret = vcodec_clks_enable(core, core->vcodec1_clks);
+		ret = vcodec_clks_enable(core, 1);
 		if (ret)
 			return ret;
 
@@ -763,20 +768,18 @@ static int vdec_get_v4(struct device *dev)
 	if (!legacy_binding)
 		return 0;
 
-	return vcodec_clks_get(core, dev, core->vcodec0_clks,
-			       core->res->vcodec0_clks);
+	return vcodec_clks_get(core, dev, 0);
 }
 
 static void vdec_put_v4(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
-	unsigned int i;
 
 	if (!legacy_binding)
 		return;
 
-	for (i = 0; i < core->res->vcodec_clks_num; i++)
-		core->vcodec0_clks[i] = NULL;
+	core->vcodec_core_clks[0] = NULL;
+	core->vcodec_bus_clks[0] = NULL;
 }
 
 static int vdec_power_v4(struct device *dev, int on)
@@ -792,9 +795,9 @@ static int vdec_power_v4(struct device *dev, int on)
 		return ret;
 
 	if (on == POWER_ON)
-		ret = vcodec_clks_enable(core, core->vcodec0_clks);
+		ret = vcodec_clks_enable(core, 0);
 	else
-		vcodec_clks_disable(core, core->vcodec0_clks);
+		vcodec_clks_disable(core, 0);
 
 	vcodec_control_v4(core, VIDC_CORE_ID_1, false);
 
@@ -808,20 +811,18 @@ static int venc_get_v4(struct device *dev)
 	if (!legacy_binding)
 		return 0;
 
-	return vcodec_clks_get(core, dev, core->vcodec1_clks,
-			       core->res->vcodec1_clks);
+	return vcodec_clks_get(core, dev, 1);
 }
 
 static void venc_put_v4(struct device *dev)
 {
 	struct venus_core *core = dev_get_drvdata(dev);
-	unsigned int i;
 
 	if (!legacy_binding)
 		return;
 
-	for (i = 0; i < core->res->vcodec_clks_num; i++)
-		core->vcodec1_clks[i] = NULL;
+	core->vcodec_core_clks[1] = NULL;
+	core->vcodec_bus_clks[1] = NULL;
 }
 
 static int venc_power_v4(struct device *dev, int on)
@@ -837,9 +838,9 @@ static int venc_power_v4(struct device *dev, int on)
 		return ret;
 
 	if (on == POWER_ON)
-		ret = vcodec_clks_enable(core, core->vcodec1_clks);
+		ret = vcodec_clks_enable(core, 1);
 	else
-		vcodec_clks_disable(core, core->vcodec1_clks);
+		vcodec_clks_disable(core, 1);
 
 	vcodec_control_v4(core, VIDC_CORE_ID_2, false);
 
@@ -940,11 +941,11 @@ static int core_get_v4(struct venus_core *core)
 
 	dev_info(dev, "%s legacy binding\n", legacy_binding ? "" : "non");
 
-	ret = vcodec_clks_get(core, dev, core->vcodec0_clks, res->vcodec0_clks);
+	ret = vcodec_clks_get(core, dev, 0);
 	if (ret)
 		return ret;
 
-	ret = vcodec_clks_get(core, dev, core->vcodec1_clks, res->vcodec1_clks);
+	ret = vcodec_clks_get(core, dev, 1);
 	if (ret)
 		return ret;
 

-- 
2.42.0

