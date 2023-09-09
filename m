Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B337799A26
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjIIQ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjIIQ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 12:57:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B359BB;
        Sat,  9 Sep 2023 09:57:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99cce6f7de2so377484966b.3;
        Sat, 09 Sep 2023 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694278667; x=1694883467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cpwp0v6JdlChbRTatKGsDL07X7Hnk5vl+8d9N6DJD6U=;
        b=bxK4CxtlLjYIAnWEcGtk4v37AQsGg+8LoaqvzGEw2h7a2zaqsG5XImlrjKZMFJe+BC
         6XFDwdiq4auiqpWdBQssp0pFZ/FxoVsrN9qksts/oyQLaSJZL81L30ToGTWR1S7vFZ7J
         9attfr4sywdTC66Yn0kJq9idLokMJVHoWt9Eo6fqB1f4g334NV8mYQpZA2Ny8JR/b/lJ
         D1SY9oVz/e6h4Q8/rKJUmwQjv8jxag6kQSwzpH4fPBmarn22YC9IvUjA6r3qq+ZKxm2E
         mz2Av5Q1vLjSmCr04TJlIKVNB4OMBMqA6eaYDUq6sRsna45NjNVK1c2RYTmq6G2bJUVd
         HXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694278667; x=1694883467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cpwp0v6JdlChbRTatKGsDL07X7Hnk5vl+8d9N6DJD6U=;
        b=fjWeiMgpXHBoibPHSvbFtJqK3XaOyxhYEgQ/7fWBI0pLjmFR6PmuMU5ZsN6v+z7C4c
         Hby7HSqnJ1fBOCGgQ94/LvK6RWrLBtGJHnzVFnSx6NBdmZcTeDhSXtr2tF1eZz8sVO/R
         jSIAXV+oirJEiaSM6aEsylIAAWLTX8kgJG7h2vuErA3QnAHxoL+DwluNaUbtu0fWiaqr
         BZGrsHQ6fES8Y0nFg86JdcV/MaZlerFZmsbX1RNP7OGK4lRl1qZXSASf/kgjdvYYAYxQ
         BrFBC6L1NrilRXJjXWulcR8sgTdiPhoyXN/mwWJiAwbyaXEXp/6Y/7lIa3QpqXbVeeCB
         QaRg==
X-Gm-Message-State: AOJu0YyWRehNAKDbd5BOvX8UdmWPR48X+A5ZPv/BUaM9zMD3pqYa8tbM
        G1PfSP5r9OE4Z3iN9fxw2L0=
X-Google-Smtp-Source: AGHT+IGuRXyCWJ1MlQxpgqs7XCKnF0y57cMGCFu7NuWh5PDtcqllmEoRHwLQxkXjD3WlFypUGFqOLg==
X-Received: by 2002:a17:906:2202:b0:9a1:b7ec:c8bd with SMTP id s2-20020a170906220200b009a1b7ecc8bdmr4482352ejs.42.1694278667442;
        Sat, 09 Sep 2023 09:57:47 -0700 (PDT)
Received: from fedora.. (dh207-96-186.xnet.hr. [88.207.96.186])
        by smtp.googlemail.com with ESMTPSA id si16-20020a170906ced000b00993470682e5sm2569357ejb.32.2023.09.09.09.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 09:57:46 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     ilia.lin@kernel.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        rafael@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 3/3] cpufreq: qcom-nvmem: add support for IPQ8064
Date:   Sat,  9 Sep 2023 18:56:02 +0200
Message-ID: <20230909165739.1036263-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230909165739.1036263-1-robimarko@gmail.com>
References: <20230909165739.1036263-1-robimarko@gmail.com>
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

From: Christian Marangi <ansuelsmth@gmail.com>

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

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v3:
* Use enum for SoC version
* Dont evaluate speed as its not fused, only pvs

Changes in v2:
* Include IPQ8064 support
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 68 +++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index ba9e1d60e5b5..3d93b511db86 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -35,6 +35,12 @@ enum ipq8074_versions {
 	IPQ8074_ACORN_VERSION,
 };
 
+enum ipq806x_versions {
+	IPQ8062_VERSION = 0,
+	IPQ8064_VERSION,
+	IPQ8065_VERSION,
+};
+
 struct qcom_cpufreq_drv;
 
 struct qcom_cpufreq_match_data {
@@ -208,6 +214,62 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 	return ret;
 }
 
+static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
+					     struct nvmem_cell *speedbin_nvmem,
+					     char **pvs_name,
+					     struct qcom_cpufreq_drv *drv)
+{
+	int speed = 0, pvs = 0, pvs_ver = 0;
+	int msm_id, ret = 0;
+	u8 *speedbin;
+	size_t len;
+
+	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
+
+	if (len != 4) {
+		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
+		kfree(speedbin);
+		return -ENODEV;
+	}
+
+	get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver, speedbin);
+
+	ret = qcom_smem_get_soc_id(&msm_id);
+	if (ret)
+		return ret;
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
+	snprintf(*pvs_name, sizeof("speedXX-pvsXX"), "speed%d-pvs%d",
+		 speed, pvs);
+
+	kfree(speedbin);
+	return ret;
+}
+
 static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
 					     struct nvmem_cell *speedbin_nvmem,
 					     char **pvs_name,
@@ -257,6 +319,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
 	.genpd_names = qcs404_genpd_names,
 };
 
+static const struct qcom_cpufreq_match_data match_data_ipq8064 = {
+	.get_version = qcom_cpufreq_ipq8064_name_version,
+};
+
 static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
 	.get_version = qcom_cpufreq_ipq8074_name_version,
 };
@@ -403,7 +469,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
-	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
+	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
 	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
 	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
-- 
2.41.0

