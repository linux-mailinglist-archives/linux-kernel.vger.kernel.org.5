Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416987EAD9C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjKNKIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjKNKIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:08:15 -0500
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02565191;
        Tue, 14 Nov 2023 02:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=U1jqULllO9yyumvw2SGWYMHOTDF/1W4JaEKNAJ5zL9g=; b=UxxEL2jHHreKo90GBCCSwoWIWo
        BK0IvKT7BIo8AvjH9p+jhGpnag+bgSLKbojRzqF++uxhYAp66MHtkhCBqCFHJAoR0jDypw2tC/j8z
        OtPyf5iendwiO82EXogfOWJMVcK+fRsVA+ZPNGw3nit6MreWLBtelCw1aUIGKdqlkAQTSoFHHg3Dl
        48lLbp5ntWDSzBdEPo0ufpzbKVwRQv9dlSzBIijDnqG/RALi6Cs4jT4V/89/uNEc81eq9UxzciBIo
        uHzm0n4sMaYjfLW4zYbvuNem0tldizO36ls4ytVh0Gz3uSXlaNc/5gm+WsMcOIyByYlf29JH1MqGi
        3wA1ytrg==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1r2qL2-0050az-0X;
        Tue, 14 Nov 2023 11:08:08 +0100
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Tue, 14 Nov 2023 11:07:44 +0100
Subject: [PATCH v3 2/3] cpufreq: qcom-nvmem: Preserve PM domain votes in
 system suspend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-msm8909-cpufreq-v3-2-926097a6e5c1@kernkonzept.com>
References: <20231114-msm8909-cpufreq-v3-0-926097a6e5c1@kernkonzept.com>
In-Reply-To: <20231114-msm8909-cpufreq-v3-0-926097a6e5c1@kernkonzept.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the Linux point of view, the power domains used by the CPU must
stay always-on. This is because we still need the CPU to keep running
until the last instruction, which will typically be a firmware call that
shuts down the CPU cleanly.

At the moment the power domain votes (enable + performance state) are
dropped during system suspend, which means the CPU could potentially
malfunction while entering suspend.

We need to distinguish between two different setups used with
qcom-cpufreq-nvmem:

 1. CPR power domain: The backing regulator used by CPR should stay
    always-on in Linux; it is typically disabled automatically by
    hardware when the CPU enters a deep idle state. However, we
    should pause the CPR state machine during system suspend.

 2. RPMPD: The power domains used by the CPU should stay always-on
    in Linux (also across system suspend). The CPU typically only
    uses the *_AO ("active-only") variants of the power domains in
    RPMPD. For those, the RPM firmware will automatically drop
    the votes internally when the CPU enters a deep idle state.

Make this work correctly by calling device_set_awake_path() on the
virtual genpd devices, so that the votes are maintained across system
suspend. The power domain drivers need to set GENPD_FLAG_ACTIVE_WAKEUP
to opt into staying on during system suspend.

For now we only set this for the RPMPD case. For CPR, not setting it
will ensure the state machine is still paused during system suspend,
while the backing regulator will stay on with "regulator-always-on".

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
This patch can be merged independently from the pmdomain one for RPMPD.
Both are needed to actually preserve the votes during system suspend but
there is no compile-time dependency.
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index d239a45ed497..ea05d9d67490 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -23,6 +23,7 @@
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
@@ -426,6 +427,18 @@ static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
 	.get_version = qcom_cpufreq_ipq8074_name_version,
 };
 
+static void qcom_cpufreq_suspend_virt_devs(struct qcom_cpufreq_drv *drv, unsigned int cpu)
+{
+	const char * const *name = drv->data->genpd_names;
+	int i;
+
+	if (!drv->cpus[cpu].virt_devs)
+		return;
+
+	for (i = 0; *name; i++, name++)
+		device_set_awake_path(drv->cpus[cpu].virt_devs[i]);
+}
+
 static void qcom_cpufreq_put_virt_devs(struct qcom_cpufreq_drv *drv, unsigned int cpu)
 {
 	const char * const *name = drv->data->genpd_names;
@@ -578,11 +591,25 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
 	}
 }
 
+static int qcom_cpufreq_suspend(struct device *dev)
+{
+	struct qcom_cpufreq_drv *drv = dev_get_drvdata(dev);
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu)
+		qcom_cpufreq_suspend_virt_devs(drv, cpu);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(qcom_cpufreq_pm_ops, qcom_cpufreq_suspend, NULL);
+
 static struct platform_driver qcom_cpufreq_driver = {
 	.probe = qcom_cpufreq_probe,
 	.remove_new = qcom_cpufreq_remove,
 	.driver = {
 		.name = "qcom-cpufreq-nvmem",
+		.pm = pm_sleep_ptr(&qcom_cpufreq_pm_ops),
 	},
 };
 

-- 
2.39.2

