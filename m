Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587D77C8C70
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjJMRjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjJMRjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:39:09 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBF4A9;
        Fri, 13 Oct 2023 10:39:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405524e6768so23952595e9.2;
        Fri, 13 Oct 2023 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697218746; x=1697823546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2snCKtjMSm4tN6lk7reehS7y1VLVQECFr7QjjH/bic=;
        b=ZXBnr0+lOlZiFifQYucLsPFAbDbtXMxsMLWh0laXR2carz8L+REriUcFIDyXD65FXo
         2UEwlnJpZZ0lYDr8ogXT9WP6JqlmrK7JR1evcRP9b4TxubpgDvLVYnuLjpUxdSBHEz/K
         SYTXlKbJqHnrln7/6WqgjL1dREolPE/1Wm408k3agvX7yPrBB0s6yvQ/It48iUtoqhqi
         lOUykdBA5VfQEsetxl+ApTJIKKZebgVsVjDqzWcOVBvCASp+LDI8Z1u9WYGQzk+0ce1M
         lCMuJXc2qfUnYNuKdvNunYyGZztlOtHgG4wYIPqf/qKVDVQHvr2psWL1PqiViO4lii8n
         i2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697218746; x=1697823546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2snCKtjMSm4tN6lk7reehS7y1VLVQECFr7QjjH/bic=;
        b=DH/xIr0s5KzDjYoVss3XuLUXvuaA/VCTUgHVb33D/dLizGEfuNOaeM4OAquOyaqWFL
         pnoU3p6bb/DEnNXSORVbByZaQKwVMqgkXam5RNrCnQ014krJv5akMQthjsSRanl4HsGs
         JFApSE7m7Dj6d1FIElH3QyL22QpAu50dEMPmIRLWgs18TV6YqJBMl9bpWXijObAKIP9g
         ADdmWQqDw4btGhGR7NoqiTZLt+W3mo6P5R3Yzbiohs1ZtoAYYHPRAucj68keZ9kfR0Sj
         gSGhD6oi51jb+AQrHAUYy7cwzbAzd9ZWMc35h6lRp6xqyECZNKV87ARrH53bewoCje6U
         30lA==
X-Gm-Message-State: AOJu0YzbbNw411i8odODHaMHruCN6z++d0+3PxpJ4knhNISzc4ReAWGK
        fbQXG2M/rzO5FJ8TfzP+tKA=
X-Google-Smtp-Source: AGHT+IGOqy/1x7vrK61QVKQRHol8PeNRBAWftt4uCqXFWZyCvgZgCZxGec86TjhBdB93+cKNOfMB3w==
X-Received: by 2002:a5d:4204:0:b0:32d:7efc:7e1f with SMTP id n4-20020a5d4204000000b0032d7efc7e1fmr8043939wrq.71.1697218745914;
        Fri, 13 Oct 2023 10:39:05 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j11-20020a05600c42cb00b0040652e8ca13sm692074wme.43.2023.10.13.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 10:39:05 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] cpufreq: qcom-nvmem: add support for IPQ8064
Date:   Fri, 13 Oct 2023 19:38:53 +0200
Message-Id: <20231013173854.7399-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231013173854.7399-1-ansuelsmth@gmail.com>
References: <20231013173854.7399-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8064 comes in 3 families:
* IPQ8062 up to 1.0GHz
* IPQ8064/IPQ8066/IPQ8068 up to 1.4GHz
* IPQ8065/IPQ8069 up to 1.7Ghz

So, in order to be able to support one OPP table, add support for
IPQ8064 family based of SMEM SoC ID-s and correctly set the version so
opp-supported-hw can be correctly used.

Bit are set with the following logic:
* IPQ8062 BIT 0
* IPQ8064/IPQ8066/IPQ8068 BIT 1
* IPQ8065/IPQ8069 BIT 2

speed is never fused, only pvs values are fused.

IPQ806x SoC doesn't have pvs_version so we drop and we use the new
pattern:
opp-microvolt-speed0-pvs<PSV_VALUE>

Example:
- for ipq8062 psv2
  opp-microvolt-speed0-pvs2 = < 925000 878750 971250>

Fixes: a8811ec764f9 ("cpufreq: qcom: Add support for krait based socs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v6:
* Rebase on top of dependant series
* Fix leaking speedbin nvmem
* Fix format_a function to follow new functions
* Improve snprintf as suggested from Konrad

Changes v5:
* Fix leaking speedbin nvmem

Changes in v3:
* Use enum for SoC version
* Dont evaluate speed as its not fused, only pvs

Changes in v2:
* Include IPQ8064 support
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 67 +++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 6b54a674e9ea..eaeff14bbc75 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -32,6 +32,12 @@
 
 #include <dt-bindings/arm/qcom,ids.h>
 
+enum ipq806x_versions {
+	IPQ8062_VERSION = 0,
+	IPQ8064_VERSION,
+	IPQ8065_VERSION,
+};
+
 struct qcom_cpufreq_drv;
 
 struct qcom_cpufreq_match_data {
@@ -205,6 +211,61 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 	return ret;
 }
 
+static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
+					     struct nvmem_cell *speedbin_nvmem,
+					     char **pvs_name,
+					     struct qcom_cpufreq_drv *drv)
+{
+	int speed = 0, pvs = 0;
+	int msm_id, ret = 0;
+	u8 *speedbin;
+	size_t len;
+
+	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
+
+	if (len != 4) {
+		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
+		ret = -ENODEV;
+		goto exit;
+	}
+
+	get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
+
+	ret = qcom_smem_get_soc_id(&msm_id);
+	if (ret)
+		goto exit;
+
+	switch (msm_id) {
+	case QCOM_ID_IPQ8062:
+		drv->versions = BIT(IPQ8062_VERSION);
+		break;
+	case QCOM_ID_IPQ8064:
+	case QCOM_ID_IPQ8066:
+	case QCOM_ID_IPQ8068:
+		drv->versions = BIT(IPQ8064_VERSION);
+		break;
+	case QCOM_ID_IPQ8065:
+	case QCOM_ID_IPQ8069:
+		drv->versions = BIT(IPQ8065_VERSION);
+		break;
+	default:
+		dev_err(cpu_dev,
+			"SoC ID %u is not part of IPQ8064 family, limiting to 1.0GHz!\n",
+			msm_id);
+		drv->versions = BIT(IPQ8062_VERSION);
+		break;
+	}
+
+	/* IPQ8064 speed is never fused. Only pvs values are fused. */
+	snprintf(*pvs_name, sizeof("speed0-pvsXX"), "speed0-pvs%d", pvs);
+
+exit:
+	kfree(speedbin);
+	return ret;
+}
+
 static int qcom_cpufreq_apq8064_name_version(struct device *cpu_dev,
 					     struct nvmem_cell *speedbin_nvmem,
 					     char **pvs_name,
@@ -247,6 +308,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
 	.genpd_names = qcs404_genpd_names,
 };
 
+static const struct qcom_cpufreq_match_data match_data_ipq8064 = {
+	.get_version = qcom_cpufreq_ipq8064_name_version,
+};
+
 static const char * apq8064_regulator_names[] = {
 	"vdd-core",
 	NULL
@@ -405,7 +470,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
-	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
+	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
 	{ .compatible = "qcom,apq8064", .data = &match_data_apq8064 },
 	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8960", .data = &match_data_apq8064 },
-- 
2.40.1

