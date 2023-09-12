Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169C979CCB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjILKAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjILKAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:00:19 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544F61BB;
        Tue, 12 Sep 2023 03:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=atVlEBB4YMZABXH4SWOY4OFQPXFW6vNTHPIocXGctJs=; b=GBXLRQKsy0kqC1hGKFV9w8TpKE
        KuakT0tdPMcVGhJZO4zcgucH7f9F3mwE6+kWPFGeux2al94LSQ8zCGjY0INTR0UdY6d0ZupJ+cLLD
        v1l/3Tje+cC8fP5UExUvTERFP26gAbJT5eJ0qeA9ofEVQqU3dSnzGOQsgXp99xU4Q1fuESB/rvOgw
        DXBvvmdyEmqbTSJ/vl7BDGvQYigxU6JUfMbI0d5/046342b5ataMVmj6AvspYt52mNjK7WTJjCYNZ
        cGHWD8pz6u44i1uLfqGrlsj6QMBXBnxFRZcF8BfVnxxT1GSfIHcAOJ1wlfNgMIAf11Bmw9btKwm3V
        ke/pPqcg==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qfzsl-0030Ws-0N;
        Tue, 12 Sep 2023 11:40:31 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Tue, 12 Sep 2023 11:40:15 +0200
Subject: [PATCH 1/4] cpufreq: qcom-nvmem: Enable virtual power domain
 devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-msm8909-cpufreq-v1-1-767ce66b544b@kernkonzept.com>
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
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The genpd core ignores performance state votes from devices that are
runtime suspended as of commit 5937c3ce2122 ("PM: domains: Drop/restore
performance state votes for devices at runtime PM"). However, at the
moment nothing ever enables the virtual devices created in
qcom-cpufreq-nvmem for the cpufreq power domain scaling, so they are
permanently runtime-suspended.

Fix this by enabling the devices after attaching them and use
dev_pm_syscore_device() to ensure the power domain also stays on when
going to suspend. Since it supplies the CPU we can never turn it off
from Linux. There are other mechanisms to turn it off when needed,
usually in the RPM firmware or the cpuidle path.

Without this fix performance states votes are silently ignored, and the
CPU/CPR voltage is never adjusted. This has been broken since 5.14 but
for some reason no one noticed this on QCS404 so far.

Cc: stable@vger.kernel.org
Fixes: 1cb8339ca225 ("cpufreq: qcom: Add support for qcs404 on nvmem driver")
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 84d7033e5efe..17d6ab14c909 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
 
@@ -280,6 +281,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	for_each_possible_cpu(cpu) {
+		struct device **virt_devs = NULL;
 		struct dev_pm_opp_config config = {
 			.supported_hw = NULL,
 		};
@@ -300,7 +302,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 
 		if (drv->data->genpd_names) {
 			config.genpd_names = drv->data->genpd_names;
-			config.virt_devs = NULL;
+			config.virt_devs = &virt_devs;
 		}
 
 		if (config.supported_hw || config.genpd_names) {
@@ -311,6 +313,23 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 				goto free_opp;
 			}
 		}
+
+		if (virt_devs) {
+			const char * const *name = config.genpd_names;
+			int i;
+
+			for (i = 0; *name; i++, name++) {
+				ret = pm_runtime_resume_and_get(virt_devs[i]);
+				if (ret) {
+					dev_err(cpu_dev, "failed to resume %s: %d\n",
+						*name, ret);
+					goto free_opp;
+				}
+
+				/* Keep CPU power domain always-on */
+				dev_pm_syscore_device(virt_devs[i], true);
+			}
+		}
 	}
 
 	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,

-- 
2.39.2

