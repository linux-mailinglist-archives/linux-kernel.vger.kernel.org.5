Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E41B7CD613
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjJRIGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbjJRIGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:06:23 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE55B6;
        Wed, 18 Oct 2023 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=ee24+roHTQoZFVVx9N6XyCjPrXcrkPUK4h/ySpFKwAE=; b=E8hYlVyQjRGKI6S6CFOVTWmLv0
        u1noWkd7WbREf8IDFxc3ASV7K98mS5tsuyz7DBkjFK1N79sPydTwMFOj1jKBOJMqKzR/ebbGD0s7W
        rbtrtcYnhVUcTicO2fkP54Q10a+qmG4xi2ZHBU1qt0raBvMZqD9k4CY2S4uC/uJ5lVz1DukCikS3T
        OYvvSe26D6JTG9baPfxYSUWDdOiI+vRrTPus2e2AAlrjkHTRyD9/aakqrCiXCsZtVFtxdN21cZUi2
        TaOBJ6E163ozo3ZsCz2ipEVUXXkAU629XOob2i2URidTsSjyeXadkZFvfZhzadfEg9ijMvcQyfvxv
        OIlhX4gA==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qt1ZI-009lIU-1g;
        Wed, 18 Oct 2023 10:06:16 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Wed, 18 Oct 2023 10:06:04 +0200
Subject: [PATCH v2 3/3] cpufreq: qcom-nvmem: Add MSM8909
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-msm8909-cpufreq-v2-3-0962df95f654@kernkonzept.com>
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
In-Reply-To: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the MSM8909 SoC is used together with the PM8909 PMIC the primary
power supply for the CPU (VDD_APC) is shared with other components to
the SoC, namely the VDD_CX power domain typically supplied by the PM8909
S1 regulator. This means that all votes for necessary performance states
go via the RPM firmware which collects the requirements from all the
processors in the SoC. The RPM firmware then chooses the actual voltage
based on the performance states ("corners"), depending on calibration
values in the NVMEM and other factors.

The MSM8909 SoC is also sometimes used with the PM8916 or PM660 PMIC.
In that case there is a dedicated regulator connected to VDD_APC and
Linux is responsible to do adaptive voltage scaling using CPR (similar
to the existing code for QCS404).

This difference can be described in the device tree, by either assigning
the CPU a power domain from RPMPD or from the CPR driver.

Describe this using "perf" as generic power domain name, which is also
used already for SCMI based platforms.

Also add a simple function that reads the speedbin from a NVMEM cell
and sets it as-is for opp-supported-hw. The actual bit position can be
described in the device tree without additional driver changes.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3794390089b0..e52031863350 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -59,6 +59,24 @@ struct qcom_cpufreq_drv {
 
 static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
 
+static int qcom_cpufreq_simple_get_version(struct device *cpu_dev,
+					   struct nvmem_cell *speedbin_nvmem,
+					   char **pvs_name,
+					   struct qcom_cpufreq_drv *drv)
+{
+	u8 *speedbin;
+
+	*pvs_name = NULL;
+	speedbin = nvmem_cell_read(speedbin_nvmem, NULL);
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
+
+	dev_dbg(cpu_dev, "speedbin: %d\n", *speedbin);
+	drv->versions = 1 << *speedbin;
+	kfree(speedbin);
+	return 0;
+}
+
 static void get_krait_bin_format_a(struct device *cpu_dev,
 					  int *speed, int *pvs, int *pvs_ver,
 					  u8 *buf)
@@ -252,6 +270,8 @@ static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
 	return 0;
 }
 
+static const char *generic_genpd_names[] = { "perf", NULL };
+
 static const struct qcom_cpufreq_match_data match_data_kryo = {
 	.get_version = qcom_cpufreq_kryo_name_version,
 };
@@ -260,6 +280,11 @@ static const struct qcom_cpufreq_match_data match_data_krait = {
 	.get_version = qcom_cpufreq_krait_name_version,
 };
 
+static const struct qcom_cpufreq_match_data match_data_msm8909 = {
+	.get_version = qcom_cpufreq_simple_get_version,
+	.genpd_names = generic_genpd_names,
+};
+
 static const char *qcs404_genpd_names[] = { "cpr", NULL };
 
 static const struct qcom_cpufreq_match_data match_data_qcs404 = {
@@ -434,6 +459,7 @@ static struct platform_driver qcom_cpufreq_driver = {
 
 static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
+	{ .compatible = "qcom,msm8909", .data = &match_data_msm8909 },
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
 	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },

-- 
2.39.2

