Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DB1752509
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjGMOTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjGMOS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:18:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A920D26AF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:18:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so1390261e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689257905; x=1691849905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2FGnkTFhckKy1B44O7jpGYAwsWcXuAkok3ADC0wZTc=;
        b=X9wOIS7sK7yvNtsVAiKkpFNNk91CbLAr4zI+HQyk3zRR1NPaiQCXoby+zXUMadvHK8
         eX/kBeKhdi62T144tgbpLA+i4vU3JD1rER4gDSvMYAVjXOKlb6KcZ2ALQrBG1rdr3xHK
         k4l1Mjx8G1F/4Zimf5K0/Y/NND9tQtLfwV4oyU0JZygLjFASGWARJG2l+NLmRjNOF5cF
         iv4ZkELNEcHy3DO6s2+vG64KL7p7IznRyOL+8maZqCa2LRwZZ47Zb9h7dxjnwt+CG0UM
         2rijsnRKyxFR9dml1ng5KX58W/MYvqPWXLjtfz2HUFuB/EU5xNVY0Ce7OvcGlyz54Hpc
         mAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257905; x=1691849905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2FGnkTFhckKy1B44O7jpGYAwsWcXuAkok3ADC0wZTc=;
        b=TNRWWk4Ti8AOW0oQ/uagkZmiy1DcDQCuELgzqV5TDykZRbXDgsS8wVWJFI54qP0wK3
         2rkIqOF0vpcVclCuZZqA17oumijkzw8lMvzp3Guis9IqeXb80ymj79LjOAxIczFEZhAq
         v4TuuFfatZ9/a9RvISAXboURY8W1k3ZB3M3dfv9HiqPUoOpF9PNcP1aLc0tzLt4CHQrM
         7wwZ6szLOFwKa9eXp1xXFtEelS4Wxptf/izMYB4d/fl7l7OSdkn0jboTLeIN5v/BQzxt
         WKkR8tXlexCBPSA1GsFYX/skWAOxeAJfDRy+6e/Z0EPvpk+MA4DOPBKOc9HOgE+ez+Ap
         QuVA==
X-Gm-Message-State: ABy/qLavGXmc7onznSAyHygrAg6zqAymgci5KM4D4P3svsjNsyR2HZgZ
        97EPm/jLpSRwJzZDNH69lt9YbA==
X-Google-Smtp-Source: APBJJlEe/LcOSdXGIs29m2hZJ6aDLIXECWIhX2RS15qAHOIH0lx4KMJaPzvxHM3/7G6hBrDa3Z7jsQ==
X-Received: by 2002:ac2:43c4:0:b0:4f8:5f32:b1da with SMTP id u4-20020ac243c4000000b004f85f32b1damr1233186lfl.24.1689257905043;
        Thu, 13 Jul 2023 07:18:25 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w28-20020ac2599c000000b004fb759964a9sm1132426lfn.168.2023.07.13.07.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:18:24 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] cpufreq: scmi: Drop redundant ifdef in scmi_cpufreq_probe()
Date:   Thu, 13 Jul 2023 16:17:38 +0200
Message-Id: <20230713141738.23970-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713141738.23970-1-ulf.hansson@linaro.org>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have stubs for devm_of_clk_add_hw_provider(), so there should be no need
to protect this with the '#ifdef CONFIG_COMMON_CLK'. Let's drop it to clean
up the code a bit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- New patch.

---

 drivers/cpufreq/scmi-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index b42f43d9bd89..ab967e520355 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -326,11 +326,9 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 	if (IS_ERR(perf_ops))
 		return PTR_ERR(perf_ops);
 
-#ifdef CONFIG_COMMON_CLK
 	/* dummy clock provider as needed by OPP if clocks property is used */
 	if (of_property_present(dev->of_node, "#clock-cells"))
 		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
-#endif
 
 	ret = cpufreq_register_driver(&scmi_cpufreq_driver);
 	if (ret) {
-- 
2.34.1

