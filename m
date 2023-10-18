Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AD17CD60E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbjJRIG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjJRIGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:06:19 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C713FA;
        Wed, 18 Oct 2023 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=STNJwzUZgB4UhvM8z7lT2Hoj0RIjLauqJYgZpngPYdA=; b=HJk3ZItH9qZHuRO8QMZG93jFiM
        8lR7W5DaQXGwQsRQJHRkD1p+L8v6MGBtdF4xan1CV7xZWCKMc1zy8iiyG7JJsa8hMZ+2F2wDObi+C
        Ba1ZIFzY0f830IvSFBDX/ucAZMGzrZv2OF4mYunad/qrBImBaLtlmfT+g0p3jof7FKvM7UVbrEZI1
        LKFkO4vTqrgtiFyjRxhu3J3HTMnOyo16+CsMH6Tdr/mgPWGhsAIff8QNscBBMQq1R7SCtkwHYs8pJ
        17uezkBR3OYkSUpbQN0Rujflb1g3CryeLy/zLymn+eia63h0yyV+rBVYKDnPnVKZZS7VBy2DBUdrX
        5xKvCHCA==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qt1ZE-009lIU-0U;
        Wed, 18 Oct 2023 10:06:12 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Wed, 18 Oct 2023 10:06:02 +0200
Subject: [PATCH v2 1/3] cpufreq: qcom-nvmem: Simplify driver data
 allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-msm8909-cpufreq-v2-1-0962df95f654@kernkonzept.com>
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

Simplify the allocation and cleanup of driver data by using devm
together with a flexible array. Prepare for adding additional per-CPU
data by defining a struct qcom_cpufreq_drv_cpu instead of storing the
opp_tokens directly.

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 49 +++++++++++++-----------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3fa12648ceb6..82a244f3fa52 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -45,10 +45,14 @@ struct qcom_cpufreq_match_data {
 	const char **genpd_names;
 };
 
+struct qcom_cpufreq_drv_cpu {
+	int opp_token;
+};
+
 struct qcom_cpufreq_drv {
-	int *opp_tokens;
 	u32 versions;
 	const struct qcom_cpufreq_match_data *data;
+	struct qcom_cpufreq_drv_cpu cpus[];
 };
 
 static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
@@ -290,42 +294,32 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	drv = kzalloc(sizeof(*drv), GFP_KERNEL);
+	drv = devm_kzalloc(&pdev->dev, struct_size(drv, cpus, num_possible_cpus()),
+		           GFP_KERNEL);
 	if (!drv)
 		return -ENOMEM;
 
 	match = pdev->dev.platform_data;
 	drv->data = match->data;
-	if (!drv->data) {
-		ret = -ENODEV;
-		goto free_drv;
-	}
+	if (!drv->data)
+		return -ENODEV;
 
 	if (drv->data->get_version) {
 		speedbin_nvmem = of_nvmem_cell_get(np, NULL);
-		if (IS_ERR(speedbin_nvmem)) {
-			ret = dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
-					    "Could not get nvmem cell\n");
-			goto free_drv;
-		}
+		if (IS_ERR(speedbin_nvmem))
+			return dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
+					     "Could not get nvmem cell\n");
 
 		ret = drv->data->get_version(cpu_dev,
 							speedbin_nvmem, &pvs_name, drv);
 		if (ret) {
 			nvmem_cell_put(speedbin_nvmem);
-			goto free_drv;
+			return ret;
 		}
 		nvmem_cell_put(speedbin_nvmem);
 	}
 	of_node_put(np);
 
-	drv->opp_tokens = kcalloc(num_possible_cpus(), sizeof(*drv->opp_tokens),
-				  GFP_KERNEL);
-	if (!drv->opp_tokens) {
-		ret = -ENOMEM;
-		goto free_drv;
-	}
-
 	for_each_possible_cpu(cpu) {
 		struct dev_pm_opp_config config = {
 			.supported_hw = NULL,
@@ -351,9 +345,9 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 		}
 
 		if (config.supported_hw || config.genpd_names) {
-			drv->opp_tokens[cpu] = dev_pm_opp_set_config(cpu_dev, &config);
-			if (drv->opp_tokens[cpu] < 0) {
-				ret = drv->opp_tokens[cpu];
+			drv->cpus[cpu].opp_token = dev_pm_opp_set_config(cpu_dev, &config);
+			if (drv->cpus[cpu].opp_token < 0) {
+				ret = drv->cpus[cpu].opp_token;
 				dev_err(cpu_dev, "Failed to set OPP config\n");
 				goto free_opp;
 			}
@@ -372,11 +366,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 
 free_opp:
 	for_each_possible_cpu(cpu)
-		dev_pm_opp_clear_config(drv->opp_tokens[cpu]);
-	kfree(drv->opp_tokens);
-free_drv:
-	kfree(drv);
-
+		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	return ret;
 }
 
@@ -388,10 +378,7 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
 	platform_device_unregister(cpufreq_dt_pdev);
 
 	for_each_possible_cpu(cpu)
-		dev_pm_opp_clear_config(drv->opp_tokens[cpu]);
-
-	kfree(drv->opp_tokens);
-	kfree(drv);
+		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 }
 
 static struct platform_driver qcom_cpufreq_driver = {

-- 
2.39.2

