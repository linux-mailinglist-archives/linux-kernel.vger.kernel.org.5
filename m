Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00BF770976
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjHDUJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjHDUJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:09:28 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BB810F0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:09:22 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so44102921fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 13:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691179760; x=1691784560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GAfNOOZsUrEUpiif19oOd/1CBxC+V2hxPidV1U/nxvQ=;
        b=lg/J7G2kAQvldwF78GD/t8A75UV2RfpEAm5BKi433hrFVhxBgd15VRk6PttBaGN8Z3
         GJIusoscyC1U3yIQGosWbTOwU6HEayueWhluSb1hcXS5/Y0QvPIzPMSoFPxkWWbNiTpB
         jtCoOSuyMlod/nlPazcXrvTvyKRV1jDlc4M3sjaQHxPDWTul1ReMWhzSvBFqdFaqBIWk
         fLETUzSaAK2FPTgvBjE9gbpPIRPxLBNdjDwMYbjXJ1cQPHMpgvLkH/L5h689lMnNSx5Q
         nnMHpMXf+g16NFL98E1rqiNd7/OAJXP0VE5CLRIKZiGy1ZxUaDiBjsltqOX8aQYjRjyR
         38oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691179760; x=1691784560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAfNOOZsUrEUpiif19oOd/1CBxC+V2hxPidV1U/nxvQ=;
        b=hhJf3opCAlalcE/q3PynSCpZJGbUxQYzVOzpv3Ltesl1J6kaXpdl7YQ9roBvteZWHf
         TeN92J2KzF2CrEK8fOi5ByIldqzf7hBlxqC4fF80s3SMYWvWPzW+kHfD/rYFTziBwNuS
         OhKlB1vSdMt68xwdQHmaNQntkkCMyrvshqVXbIDtDbEdWY3aLnyj2hGvYx78eDsfnWKc
         trkC3VYgeYSsM23pvAAVutwyr+csn4QKiDFHCxY8bV9sJc8YVitIW4LL76Qv424t+sNx
         muWQrnbIP98NiDS4frsCPqqGHMY/1o+ERzfkfqVuvW+boJ9LXZ2/oXjdlO1SkZFeqpRF
         XpQA==
X-Gm-Message-State: AOJu0Yz/y4HZNUuir/CH7DLMI1AzR5n07PdrOSH7PUCe6prK6BJW/DtF
        8oGiPzuTc4lMNBsGrE9nUVE/GA==
X-Google-Smtp-Source: AGHT+IFWlaL0gWo1yzhMV9160arpLBVobhp+PjzCFDzkdW3mDrlRWk4lxcvHTbRPZcq37IDdKnX0zw==
X-Received: by 2002:a05:651c:1713:b0:2b9:d0bf:a3c5 with SMTP id be19-20020a05651c171300b002b9d0bfa3c5mr206617ljb.14.1691179760351;
        Fri, 04 Aug 2023 13:09:20 -0700 (PDT)
Received: from [192.168.1.101] (abym15.neoplus.adsl.tpnet.pl. [83.9.32.15])
        by smtp.gmail.com with ESMTPSA id m8-20020a2e97c8000000b002b6fed37b18sm580048ljj.101.2023.08.04.13.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 13:09:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 04 Aug 2023 22:09:11 +0200
Subject: [PATCH 4/6] media: platform: venus: Add optional LLCC path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-topic-8280_venus-v1-4-8c8bbe1983a5@linaro.org>
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
In-Reply-To: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691179750; l=3780;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=BC8RlOk5ohAzk3rcxFKHSc9QI4m0YaadlVYznKCNU1Q=;
 b=E6Ft3/vQg9IHK6mDD5mYxT9hlAoDaR8ksYxp5ZDYw6skRvNjZIyfGbGyAE8GqsYWAmoBs7py2
 T87KbdsDD5bABB1raWB56RJzkXTqMvjMkETBYdiN/GTIbnbubtz/yE1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some newer SoCs (such as SM8350) have a third interconnect path. Add
it and make it optional.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c       | 19 +++++++++++++++++++
 drivers/media/platform/qcom/venus/core.h       |  3 +++
 drivers/media/platform/qcom/venus/pm_helpers.c |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 0af45faec247..db363061748f 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -302,6 +302,15 @@ static int venus_probe(struct platform_device *pdev)
 	if (IS_ERR(core->cpucfg_path))
 		return PTR_ERR(core->cpucfg_path);
 
+	core->llcc_path = devm_of_icc_get(dev, "video-llcc");
+	if (IS_ERR(core->llcc_path)) {
+		/* LLCC path is optional */
+		if (PTR_ERR(core->llcc_path) == -ENODATA)
+			core->llcc_path = NULL;
+		else
+			return PTR_ERR(core->llcc_path);
+	}
+
 	core->irq = platform_get_irq(pdev, 0);
 	if (core->irq < 0)
 		return core->irq;
@@ -479,12 +488,18 @@ static __maybe_unused int venus_runtime_suspend(struct device *dev)
 	if (ret)
 		goto err_cpucfg_path;
 
+	ret = icc_set_bw(core->llcc_path, 0, 0);
+	if (ret)
+		goto err_llcc_path;
+
 	ret = icc_set_bw(core->video_path, 0, 0);
 	if (ret)
 		goto err_video_path;
 
 	return ret;
 
+err_llcc_path:
+	icc_set_bw(core->video_path, kbps_to_icc(20000), 0);
 err_video_path:
 	icc_set_bw(core->cpucfg_path, kbps_to_icc(1000), 0);
 err_cpucfg_path:
@@ -504,6 +519,10 @@ static __maybe_unused int venus_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = icc_set_bw(core->llcc_path, kbps_to_icc(20000), 0);
+	if (ret)
+		return ret;
+
 	ret = icc_set_bw(core->cpucfg_path, kbps_to_icc(1000), 0);
 	if (ret)
 		return ret;
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 2999c24392f5..45ed1551c2db 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -65,6 +65,7 @@ struct venus_resources {
 	unsigned int bw_tbl_enc_size;
 	const struct bw_tbl *bw_tbl_dec;
 	unsigned int bw_tbl_dec_size;
+	bool has_llcc_path;
 	const struct reg_val *reg_tbl;
 	unsigned int reg_tbl_size;
 	const struct hfi_ubwc_config *ubwc_conf;
@@ -134,6 +135,7 @@ struct venus_format {
  * @vcodec1_clks: an array of vcodec1 struct clk pointers
  * @video_path: an interconnect handle to video to/from memory path
  * @cpucfg_path: an interconnect handle to cpu configuration path
+ * @llcc_path: an interconnect handle to video to/from llcc path
  * @has_opp_table: does OPP table exist
  * @pmdomains:	an array of pmdomains struct device pointers
  * @opp_dl_venus: an device-link for device OPP
@@ -186,6 +188,7 @@ struct venus_core {
 	struct clk *vcodec1_clks[VIDC_VCODEC_CLKS_NUM_MAX];
 	struct icc_path *video_path;
 	struct icc_path *cpucfg_path;
+	struct icc_path *llcc_path;
 	bool has_opp_table;
 	struct device *pmdomains[VIDC_PMDOMAINS_NUM_MAX];
 	struct device_link *opp_dl_venus;
diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 48c9084bb4db..79392ff8fa06 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -237,6 +237,9 @@ static int load_scale_bw(struct venus_core *core)
 	dev_dbg(core->dev, VDBGL "total: avg_bw: %u, peak_bw: %u\n",
 		total_avg, total_peak);
 
+	if (core->res->has_llcc_path)
+		icc_set_bw(core->llcc_path, total_avg, total_peak);
+
 	return icc_set_bw(core->video_path, total_avg, total_peak);
 }
 

-- 
2.41.0

