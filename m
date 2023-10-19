Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F387CF5C9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjJSKun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjJSKu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:50:27 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60A8134;
        Thu, 19 Oct 2023 03:50:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso71216715e9.2;
        Thu, 19 Oct 2023 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697712623; x=1698317423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPqEeVVKIhz21/2Qmdn4Au69nSgOnfpcZtoCP0yo2Is=;
        b=Q4mG8m2CbLCSu5femUZ46Srq+HPWUSrlYXn1fi9SQCpnPQF7RRal5SwlxgmlQzw/72
         DunJyPn0NXRprTIE2knT8fUn8X7ovm8fcM6KpbC+c5Zc1KS7MW0CrTk97l8cGUZz/yVs
         UBDSA4NZEMz8ChwuiOYKJGjsQXzB4ZzbQWoo3/tOk9mYSnFXJ9P4h3/XfISEScldG2xO
         yhkpZ1WGvsFJTIxomumvtB2esmsrhY4SV43oF/olB5BbluOSoRGpF3PyCpv+qbPpdDZ9
         cnOJXkiS++ZD8WkfsULP5p4Pr+FWKYA4O5VNiPZa3A9lx0Ewf7S99+Ygq9ScEuCjZyL9
         lk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697712623; x=1698317423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPqEeVVKIhz21/2Qmdn4Au69nSgOnfpcZtoCP0yo2Is=;
        b=hC2eEUCTvg8OxgYF7z0XK3iMroncDHWRdYjYpeSkpsWrnjzFPk0YPnUlQedtZIpsil
         wUQZebsWI+y6pQSLr9pNC8STzITwY5s73XjFuxep1qUNN+5VC4LM8Cp3Dld6J9Vp7azf
         rZ2Py+eOvsw81ATSCXdhmNBvY8tm8m7G4hFzHgQhfD9NmEyjDMDRDt4ZHH7TkEnpJt8g
         cuFYjQQS4pDsZTF9bIfwEd3Gbcj/eYEIGpzb2cqbuUuLyjU2epqDNvI2TB6GjUoUmlgu
         5qcmvwDuWmJp1FRCr6C13msskgk6MXSF3xYY97PezW4+OOYnK/mLLKrEmkEIprsxMq4K
         wSeA==
X-Gm-Message-State: AOJu0YysYu30kmmGCYPyFWnkQSlkrptF1TyRNw31Tu9gJ6B5lhYwBvZS
        YwQcitwCz3NT4Vy+cfdZ/U8=
X-Google-Smtp-Source: AGHT+IG6ZSKt2vKvydkP6jFITJ4LeqoYwXH5H5K5Iav582b1CvGiZLOD+qsqtxTFuJSfEzlubds/ZQ==
X-Received: by 2002:a05:600c:46d1:b0:405:37bb:d942 with SMTP id q17-20020a05600c46d100b0040537bbd942mr1442544wmo.4.1697712622877;
        Thu, 19 Oct 2023 03:50:22 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id bh9-20020a05600c3d0900b003feae747ff2sm4129511wmb.35.2023.10.19.03.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:50:22 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v7 3/4] cpufreq: qcom-nvmem: add support for IPQ8064
Date:   Thu, 19 Oct 2023 12:50:10 +0200
Message-Id: <20231019105011.7289-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231019105011.7289-1-ansuelsmth@gmail.com>
References: <20231019105011.7289-1-ansuelsmth@gmail.com>
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
Changes v7:
* Rebase on top of vireshk cpufreq/arm/linux-next

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
index 57842d60d6ec..59b045471f91 100644
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
 #define IPQ6000_VERSION	BIT(2)
 
 struct qcom_cpufreq_drv;
@@ -231,6 +237,61 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
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
 static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
 					     struct nvmem_cell *speedbin_nvmem,
 					     char **pvs_name,
@@ -345,6 +406,10 @@ static const struct qcom_cpufreq_match_data match_data_ipq6018 = {
 	.get_version = qcom_cpufreq_ipq6018_name_version,
 };
 
+static const struct qcom_cpufreq_match_data match_data_ipq8064 = {
+	.get_version = qcom_cpufreq_ipq8064_name_version,
+};
+
 static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
 	.get_version = qcom_cpufreq_ipq8074_name_version,
 };
@@ -477,7 +542,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
 	{ .compatible = "qcom,ipq6018", .data = &match_data_ipq6018 },
-	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
+	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
 	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
 	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
-- 
2.40.1

