Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBDF7B3FE7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 12:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjI3KWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 06:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjI3KW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 06:22:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53D2195;
        Sat, 30 Sep 2023 03:22:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso2046114666b.2;
        Sat, 30 Sep 2023 03:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696069344; x=1696674144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At6mV+t12HD5fi2eom0kJSJcVqs7Y5KHuO03wN8Mx64=;
        b=abfsP9cM4JC00KJpR1OfTeozWto3eI8K6pWdjKH6AXDIXmt1B2tAx7BHjBsP/6AT18
         p2HPY7NocPvYqjoAV97APBEfRCF9lKJTTFxQECX4wJdh2U0UBQ7QrD4JubHJ/OR4OwJ9
         dmQ9+xOzOhsYsPKIGsgL4zqfsTqPWu/Wez2B9RAsHNyDGkP0QSmURk8bk832SkWCwW0E
         Lmdwcqa3xNY0jTbOtc4DzD2RxA/GsNja4QOn+8RlnqkYp4OkAsRLPiekheeh+T06Yf45
         xi7m6USfuS/+vNG0aMlkVe/oWOX69AsaZ8dA/ph/EYFGfnzlkG6JJcMT09iTMQ8nMDN5
         taJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696069344; x=1696674144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=At6mV+t12HD5fi2eom0kJSJcVqs7Y5KHuO03wN8Mx64=;
        b=fTh5yXra5SAOHjXBajRT3cujwa0V0da9GSLrJ0hwgHLOV6eXb3qAh39WCgkoqF/zSv
         Qn5KoRxEfqfxUDWzbO/0pJ2keiEDYKCaO2prTOeRi0ul5LCGXkTmZ+f9FQYIWfUe8h7f
         wHIByuOxzX6b17MlVs3rp88cCbt+jfj6n8vfpaqXuyGtmns4qVrXBvDji+JZT3yBm5zk
         35KwJXT742QN5c3qdH3uEm8G9Sk1bx4uEglZ47K6lUjzvHWGZojnNBf+FdPZDGS5Z7sm
         wQyucUyRo0ImPQJF8H99lLp5Ie2pPwa66Ig3ShH1c2PQB54dEkoxmaFO1KCmzTVHgaHs
         6R8Q==
X-Gm-Message-State: AOJu0YzW37Tg4zxsePumVDFEgSfy+pkXJzfdGQt2iyjjH6RpCsrSgz/E
        wTH3n7dQ6nXUftzoj7PhqFY=
X-Google-Smtp-Source: AGHT+IEgLTDHmmLtTeLvWLss177ZMJGt9msEkr/j7HiVG1N2pFGP4UFof4xqWrJOkO6+9F95Zx8mzQ==
X-Received: by 2002:a17:906:73ca:b0:9af:159a:5113 with SMTP id n10-20020a17090673ca00b009af159a5113mr6734189ejl.52.1696069344006;
        Sat, 30 Sep 2023 03:22:24 -0700 (PDT)
Received: from fedora.. (dh207-96-216.xnet.hr. [88.207.96.216])
        by smtp.googlemail.com with ESMTPSA id j25-20020a170906255900b0099bcf1c07c6sm13716547ejb.138.2023.09.30.03.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 03:22:23 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     ilia.lin@kernel.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 3/4] cpufreq: qcom-nvmem: add support for IPQ8064
Date:   Sat, 30 Sep 2023 12:21:18 +0200
Message-ID: <20230930102218.229613-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230930102218.229613-1-robimarko@gmail.com>
References: <20230930102218.229613-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Changes in v4:
* Free speedbin in case of an error

Changes in v3:
* Use enum for SoC version
* Dont evaluate speed as its not fused, only pvs

Changes in v2:
* Include IPQ8064 support

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

