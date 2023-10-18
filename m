Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519467CD610
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjJRIGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjJRIGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:06:21 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944A6109;
        Wed, 18 Oct 2023 01:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=0faEUPY3ndqV9NJQNGrIT8yZHoSOeQ7ubvm2InXJDKg=; b=WEN+LmlrwsBT26PALa+9h1VGwv
        sERCSJCHVPnmFBzgRRv+MEVGRP+IwdcXvAAE4vPMUKltE5zOwJWysvveTzvqQZFN+TF9Kf+DOLB37
        k060uv21PY43q05arCMkWLIUYqCTu4W9QEux4al7/y6xoGHPQGbxz032yuqsS7Z+xAB0+T4mrJN1D
        CmQsFE3NnRLiGx8CHaRW4mhPsu/Mx7g90NuB7wUEYMGr4iE4yEynaMZMuBgjozP9xp1z0HOUsQxCG
        q3UOaHNUC8gtu8LQBLSvNJ/iXKuLNDPaopG991iwi4XFANoYo8V9icGVbe2zcMisQ7sksEiqtru1c
        lvpL9pXw==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qt1ZG-009lIU-1D;
        Wed, 18 Oct 2023 10:06:14 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Wed, 18 Oct 2023 10:06:03 +0200
Subject: [PATCH v2 2/3] cpufreq: qcom-nvmem: Enable virtual power domain
 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-msm8909-cpufreq-v2-2-0962df95f654@kernkonzept.com>
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
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The genpd core caches performance state votes from devices that are
runtime suspended as of commit 3c5a272202c2 ("PM: domains: Improve
runtime PM performance state handling"). They get applied once the
device becomes active again.

To attach the power domains needed by qcom-cpufreq-nvmem the OPP core
calls genpd_dev_pm_attach_by_id(). This results in "virtual" dummy
devices that use runtime PM only to control the enable and performance
state for the attached power domain.

However, at the moment nothing ever resumes the virtual devices created
for qcom-cpufreq-nvmem. They remain permanently runtime suspended. This
means that performance state votes made during cpufreq scaling get
always cached and never applied to the hardware.

Fix this by enabling the devices after attaching them and use
dev_pm_syscore_device() to ensure the power domains also stay on when
going to suspend. Since it supplies the CPU we can never turn it off
from Linux. There are other mechanisms to turn it off when needed,
usually in the RPM firmware (RPMPD) or the cpuidle path (CPR genpd).

Without this fix performance states votes are silently ignored, and the
CPU/CPR voltage is never adjusted. This has been broken since 5.14 but
for some reason no one noticed this on QCS404 so far.

Cc: stable@vger.kernel.org
Fixes: 1cb8339ca225 ("cpufreq: qcom: Add support for qcs404 on nvmem driver")
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 49 +++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 82a244f3fa52..3794390089b0 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
 
@@ -47,6 +48,7 @@ struct qcom_cpufreq_match_data {
 
 struct qcom_cpufreq_drv_cpu {
 	int opp_token;
+	struct device **virt_devs;
 };
 
 struct qcom_cpufreq_drv {
@@ -268,6 +270,18 @@ static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
 	.get_version = qcom_cpufreq_ipq8074_name_version,
 };
 
+static void qcom_cpufreq_put_virt_devs(struct qcom_cpufreq_drv *drv, unsigned cpu)
+{
+	const char * const *name = drv->data->genpd_names;
+	int i;
+
+	if (!drv->cpus[cpu].virt_devs)
+		return;
+
+	for (i = 0; *name; i++, name++)
+		pm_runtime_put(drv->cpus[cpu].virt_devs[i]);
+}
+
 static int qcom_cpufreq_probe(struct platform_device *pdev)
 {
 	struct qcom_cpufreq_drv *drv;
@@ -321,6 +335,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	of_node_put(np);
 
 	for_each_possible_cpu(cpu) {
+		struct device **virt_devs = NULL;
 		struct dev_pm_opp_config config = {
 			.supported_hw = NULL,
 		};
@@ -341,7 +356,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 
 		if (drv->data->genpd_names) {
 			config.genpd_names = drv->data->genpd_names;
-			config.virt_devs = NULL;
+			config.virt_devs = &virt_devs;
 		}
 
 		if (config.supported_hw || config.genpd_names) {
@@ -352,6 +367,30 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 				goto free_opp;
 			}
 		}
+
+		if (virt_devs) {
+			const char * const *name = config.genpd_names;
+			int i, j;
+
+			for (i = 0; *name; i++, name++) {
+				ret = pm_runtime_resume_and_get(virt_devs[i]);
+				if (ret) {
+					dev_err(cpu_dev, "failed to resume %s: %d\n",
+						*name, ret);
+
+					/* Rollback previous PM runtime calls */
+					name = config.genpd_names;
+					for (j = 0; *name && j < i; j++, name++)
+						pm_runtime_put(virt_devs[j]);
+
+					goto free_opp;
+				}
+
+				/* Keep CPU power domain always-on */
+				dev_pm_syscore_device(virt_devs[i], true);
+			}
+			drv->cpus[cpu].virt_devs = virt_devs;
+		}
 	}
 
 	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
@@ -365,8 +404,10 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	dev_err(cpu_dev, "Failed to register platform device\n");
 
 free_opp:
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
+		qcom_cpufreq_put_virt_devs(drv, cpu);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
+	}
 	return ret;
 }
 
@@ -377,8 +418,10 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
+		qcom_cpufreq_put_virt_devs(drv, cpu);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
+	}
 }
 
 static struct platform_driver qcom_cpufreq_driver = {

-- 
2.39.2

