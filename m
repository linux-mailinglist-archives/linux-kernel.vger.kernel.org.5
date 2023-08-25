Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48B57885BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244241AbjHYL1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243943AbjHYL1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:27:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8762688
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:27:08 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so11840161fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692962827; x=1693567627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQ10KjgMpqc0TH2RSYB+FyfOupm6xniaP3PuJgrZOCQ=;
        b=jVyfBenIs3YrwoiLJlhjUlRMpDrrXrPF7WvEihCIDBBSds8an1aikYCb3fyZHGwdTp
         vER9xRn9sAxxrWIPuCMq2qdGg7xBABZe6PErJkOQ1Y96ORMDi6Gfdt4b9HdQFKNDsUos
         M6sDkqAnFJnfOwUb7W9Wlf8/AQM/xvbSDHteIQo6JrIRDqHshVNdl++RbnNOPH5e+I/E
         po0Gpd5yGHNBa+l0s+BIqhAxLxb9ibj01d7rGnLQEx5rX/nYqQwQTSJbAPC6H3kLZWZt
         vQ/YB/+O7akzgEvUVz54Co/Pc47IQWcV6D0wX3RhMzVb3ZxLNLrwS5v9gwm23nsnpGh3
         0RTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962827; x=1693567627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQ10KjgMpqc0TH2RSYB+FyfOupm6xniaP3PuJgrZOCQ=;
        b=FijxuPAhiuCEliV0txdUxjBBpr3UTXsNoJshAJZshzxWGSbFytj0B2WcGJvOEsFQV9
         Nol1H7F8DpxfuzMJdC7ET6HIJp6KUrOq3t0Iho+a5EWEFvx7kHPDTHjNYLsmr7tIfYLn
         RoRqvP51WuENtvt/oTcoBA3cItOXGR1VDydpTTdFDx5Hl4YZnAGAYspuJzrXY7NW4P5r
         nYmLZK6glW5NUyugXEMBCV5zWtQg2+P1YgeV0GogLCxlQ+8z7/HdgcBW/Ikv6SN6rmYE
         /c9edIPq/tAHm2+G+WYE2k4owRepoF2bcVw8qYRFLiMNaMscJQDn7N30+jTy9RHbZMtC
         3gZA==
X-Gm-Message-State: AOJu0YyzIITcJg51q1JvukvdPWDBVhqY1VcndMqqdhSBHXZF+wJ0jSMR
        R5nm78/ofLPQ4c23NqoFvzeQhw==
X-Google-Smtp-Source: AGHT+IHXSuubNrdaloTOGX7P7Udqw4Ibzcy9wqcH/rDCusCFRW5crtQshAf4pXtAAq+Rv4izeqHX2A==
X-Received: by 2002:ac2:58f6:0:b0:500:95f7:c416 with SMTP id v22-20020ac258f6000000b0050095f7c416mr5282808lfo.7.1692962826738;
        Fri, 25 Aug 2023 04:27:06 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004fb7ac67bbdsm259164lfh.41.2023.08.25.04.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:27:06 -0700 (PDT)
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
Subject: [PATCH v3 11/13] cpufreq: scmi: Add support to parse domain-id using #power-domain-cells
Date:   Fri, 25 Aug 2023 13:26:31 +0200
Message-Id: <20230825112633.236607-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825112633.236607-1-ulf.hansson@linaro.org>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The performance domain-id can be described in DT using the power-domains
property or the clock property. The latter is already supported, so let's
add support for the power-domains too.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Move to get the power-domain index from power-domain-names.

---
 drivers/cpufreq/scmi-cpufreq.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 48bd393a1506..08497b84efe1 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -72,13 +72,26 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 
 static int scmi_cpu_domain_id(struct device *cpu_dev)
 {
-	struct of_phandle_args clkspec;
-
-	if (of_parse_phandle_with_args(cpu_dev->of_node, "clocks",
-				       "#clock-cells", 0, &clkspec))
-		return -EINVAL;
+	struct device_node *np = cpu_dev->of_node;
+	struct of_phandle_args domain_id;
+	int index;
+
+	if (of_parse_phandle_with_args(np, "clocks", "#clock-cells", 0,
+				       &domain_id)) {
+
+		/* Find the corresponding index for power-domain "perf". */
+		index = of_property_match_string(np, "power-domain-names",
+						 "perf");
+		if (index < 0)
+			return -EINVAL;
+
+		if (of_parse_phandle_with_args(np, "power-domains",
+					       "#power-domain-cells", index,
+					       &domain_id))
+			return -EINVAL;
+	}
 
-	return clkspec.args[0];
+	return domain_id.args[0];
 }
 
 static int
-- 
2.34.1

