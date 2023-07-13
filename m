Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93597524FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjGMOTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjGMOSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:18:15 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF06212D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:18:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so1359335e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689257893; x=1691849893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd+uTowpoGoaLjs+8GyD8zBwDxjZvMxPBML0/pIgiM4=;
        b=zwhhMOGvaCt1HHvjagwnxKjIxAW0y9o4DsUJLYY195zhF0YstHXRaHgAb4F+lVwmvM
         NpyDCkgtY0BX+vyiooweGe2WcJr3USF742hF9UJykoB59r4L5tCfH1IQMeYQw8S8TSaJ
         8JH0+wDYwSdwemiG7d2cCCWt4KYEHZ3jVaHF2E9sL73gEQGAMixWSIdjTV6mqp7i7O7p
         lOr70qr3hw4PAY/SLXRxToU5RkLxgzJtlOZfq6xfpTDsbsinN0NZB4Hpu8Y5DaSHpEZW
         A7E8o/6BzJtLxnIhzOelslDTnLBYOeyg0k6pLwBQ9Wy4aIkwHOb+VCiEiYh3ugGjZ790
         WGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257893; x=1691849893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hd+uTowpoGoaLjs+8GyD8zBwDxjZvMxPBML0/pIgiM4=;
        b=behOKblkeOHWvAxkWutPKXljYdEqHLV+W33VXhM21om5U7kaqz3R3SZrrrO6pAjJ0o
         6J9MLlnS0CFK2NZwh/5ctdbG0Afun4nS02Hi5i7DPYjxvr66Did7EqrpxcNbbQpJrwpQ
         ECbb4BfaJeXoG2vNw2DjN4Tny9Tb5rOVGBqpvC0nftPp8G6UO+NzgBWbSGfQMUymrFYq
         Djo2MH4plJxXF+Bivxi3ZFzR8jCaXx/7KZEMQHh0kZZG5nxgweR1QHN2yc6F/yUpY4NF
         5AaX2Rvk2S8r9Ek2fbpy25bm5X2C/aDRuZ47U20bfjY/Ijvry6v32elwWF0DLJKw8gYk
         YPeg==
X-Gm-Message-State: ABy/qLbn4Fw0YjgRWrmIU7N5nx9E2naJ5yckIRYbYVPl3Dvek65bd/j6
        F9dUeQGN6ELASPm3KOHtmi8w3g==
X-Google-Smtp-Source: APBJJlFrQEjPQt+5/y+wdQoOfFaUfEE72mvDkJIp9j/oX0ZvtYqr5uSAVtOMMU6Nnu8hShdw/NVATQ==
X-Received: by 2002:ac2:58f6:0:b0:4f7:6b72:3323 with SMTP id v22-20020ac258f6000000b004f76b723323mr1229474lfo.55.1689257892879;
        Thu, 13 Jul 2023 07:18:12 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w28-20020ac2599c000000b004fb759964a9sm1132426lfn.168.2023.07.13.07.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:18:12 -0700 (PDT)
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
Subject: [PATCH v2 03/11] cpufreq: scmi: Prepare to move OF parsing of domain-id to cpufreq
Date:   Thu, 13 Jul 2023 16:17:30 +0200
Message-Id: <20230713141738.23970-4-ulf.hansson@linaro.org>
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

The OF parsing of the clock domain specifier seems to better belong in the
scmi cpufreq driver, rather than being implemented behind the generic
->device_domain_id() perf protocol ops.

To prepare to remove the ->device_domain_id() ops, let's implement the OF
parsing in the scmi cpufreq driver instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- None.

---
 drivers/cpufreq/scmi-cpufreq.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index f34e6382a4c5..7d05d48c0337 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -70,13 +70,24 @@ static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	return 0;
 }
 
+static int scmi_cpu_domain_id(struct device *cpu_dev)
+{
+	struct of_phandle_args clkspec;
+
+	if (of_parse_phandle_with_args(cpu_dev->of_node, "clocks",
+				       "#clock-cells", 0, &clkspec))
+		return -EINVAL;
+
+	return clkspec.args[0];
+}
+
 static int
 scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
 	int cpu, domain, tdomain;
 	struct device *tcpu_dev;
 
-	domain = perf_ops->device_domain_id(cpu_dev);
+	domain = scmi_cpu_domain_id(cpu_dev);
 	if (domain < 0)
 		return domain;
 
@@ -88,7 +99,7 @@ scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 		if (!tcpu_dev)
 			continue;
 
-		tdomain = perf_ops->device_domain_id(tcpu_dev);
+		tdomain = scmi_cpu_domain_id(tcpu_dev);
 		if (tdomain == domain)
 			cpumask_set_cpu(cpu, cpumask);
 	}
@@ -104,7 +115,7 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
 	unsigned long Hz;
 	int ret, domain;
 
-	domain = perf_ops->device_domain_id(cpu_dev);
+	domain = scmi_cpu_domain_id(cpu_dev);
 	if (domain < 0)
 		return domain;
 
@@ -209,7 +220,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->cpu_dev = cpu_dev;
-	priv->domain_id = perf_ops->device_domain_id(cpu_dev);
+	priv->domain_id = scmi_cpu_domain_id(cpu_dev);
 
 	policy->driver_data = priv;
 	policy->freq_table = freq_table;
-- 
2.34.1

