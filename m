Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE4079CCAC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjILKAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjILKAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:00:13 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67A0E64;
        Tue, 12 Sep 2023 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=BxXw2lPBlPXmQ8F4w0fefRPMnE8WnMJ9NcWQp72L7OE=; b=WMMOE1JdxyWmMDacjV73+JJ8Ec
        iBcnvhReNiQMfRVKMTDiS6FOo4trT2yvmbWboWzIDZHe7kevkONS8v3KLV2UTiDAF4Qw8B9ZGjeMa
        0f1YN50EXx2kE+QYmTu5Jt+MVpTcuzPAjsYtIAuJU4u5SBa1HeHkwBEUQUB4iIPsc4IgbIEk64YeG
        v6T10qZ9anMbbTKwgx6Pp0rgI8tPPRTCKC0ECJpr0PT5C/6vVfvG76aAC7LM39BOB1+rgnLGTtCd9
        dAFeOawFHAXelKSqwD5VNkL73SjSiSp+amqdMfC39XckjhUmUYidZ2zyj8c1yeuyE/uw/ZZUOmhIK
        HIMDzNkw==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qfzsr-0030Ws-0o;
        Tue, 12 Sep 2023 11:40:37 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Tue, 12 Sep 2023 11:40:18 +0200
Subject: [PATCH 4/4] cpufreq: qcom-nvmem: Add MSM8909
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-msm8909-cpufreq-v1-4-767ce66b544b@kernkonzept.com>
References: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
In-Reply-To: <20230912-msm8909-cpufreq-v1-0-767ce66b544b@kernkonzept.com>
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
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.3
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

To describe this in a more generic way, use "apc" as power domain name
instead of "cpr". From the Linux point of view there is no CPR involved
when MSM8909 is used together with PM8909.

Also add a simple function that reads the speedbin from a NVMEM cell
and sets it as-is for opp-supported-hw. The actual bit position can be
described in the device tree without additional driver changes.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 17d6ab14c909..2ea5e5ee9f1c 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -49,6 +49,24 @@ struct qcom_cpufreq_drv {
 
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
@@ -212,6 +230,13 @@ static const struct qcom_cpufreq_match_data match_data_krait = {
 	.get_version = qcom_cpufreq_krait_name_version,
 };
 
+static const char *msm8909_genpd_names[] = { "apc", NULL };
+
+static const struct qcom_cpufreq_match_data match_data_msm8909 = {
+	.get_version = qcom_cpufreq_simple_get_version,
+	.genpd_names = msm8909_genpd_names,
+};
+
 static const char *qcs404_genpd_names[] = { "cpr", NULL };
 
 static const struct qcom_cpufreq_match_data match_data_qcs404 = {
@@ -375,6 +400,7 @@ static struct platform_driver qcom_cpufreq_driver = {
 };
 
 static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
+	{ .compatible = "qcom,msm8909", .data = &match_data_msm8909 },
 	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },

-- 
2.39.2

