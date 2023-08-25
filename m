Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A0B7885B6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbjHYL1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243328AbjHYL1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:27:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4228210C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:27:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ffae5bdc9aso1230084e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692962820; x=1693567620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6dRAO4EfoAn2re7zIc0y2rFhEJtu95IouhvL8pLKsw=;
        b=PrZOmJtwD08yAaOBlxYOMRmce35UWUSuZX0cID7fIByJYAZOWPG8UCdKFup591sQdw
         aKEI+RKumG0cR/ggCV3sMS5P1Ijo8gRorJS6WSFgojpYP9gzV7OGOQvvqPfujjkPGAfW
         7JWaa6YenhNptu1oDfaA/xqYK5zss6bs0QLHr0fOH10oOr0FnoxfFnoMP0QuEarVB06N
         ovxeRI2klfCdGI74WApPOYSAkcREByMy7Fc2n+DHtVHG4U65ECP/VCtbjsp4tSzbmIIO
         ZAoIcXX814Vl0ats39/tvRJDVfJdYacYzyR6g5OPuLFa5EgBUukGwPw88mWcHMI8cNPO
         7tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962820; x=1693567620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6dRAO4EfoAn2re7zIc0y2rFhEJtu95IouhvL8pLKsw=;
        b=CizmY93FaI1FilwPZT4qvt84ce4TM/q8N8taPyT+aYKHna34Nreg4k/hNU50NYwmgw
         bYnyFR2pM25/GfNbaQK1jZuMGQqRV/Ddfaj1fP42BgpiVB9HuSXPDElXQtHkUzgRa/zj
         fT21h/lYc5wJc6+4COaj/GBZQ7H1AofMJyjKJOXGkq8lRFENuqEreDM2gvC/3dqjZc82
         sNuQTX65zVFx4xPP5ZXoSSV0obbMH8NIkM2CQloucdNy+quPBosCL9xqV7AE4FlPod/G
         ACygxGYUZQfxDbLB6yRY1Go0CsjF4N1ci/HCsUZDGzEtvR0CN7uwUrcJGJ8uOfjZ9ad8
         PQHQ==
X-Gm-Message-State: AOJu0YxRkHJp/Gn902iKrUgZj/l6OEIgtQkBYOyHbVQD5WU2TYh9xy6M
        YpDxLaSB6mHpKqdmd/P6//VlpA==
X-Google-Smtp-Source: AGHT+IHYk6QR/qJHStjgxhG5KWjzyp+nCjXgemUVAMEhLlaa2oudO6hS4L4C6mpOzsgc6fGW9YmYcA==
X-Received: by 2002:a05:6512:3e9:b0:4ff:95c:e158 with SMTP id n9-20020a05651203e900b004ff095ce158mr10864148lfq.64.1692962820057;
        Fri, 25 Aug 2023 04:27:00 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004fb7ac67bbdsm259164lfh.41.2023.08.25.04.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:26:59 -0700 (PDT)
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
Subject: [PATCH v3 06/13] cpufreq: scmi: Avoid one OF parsing in scmi_get_sharing_cpus()
Date:   Fri, 25 Aug 2023 13:26:26 +0200
Message-Id: <20230825112633.236607-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825112633.236607-1-ulf.hansson@linaro.org>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The domain-id for the cpu_dev has already been parsed at the point when
scmi_get_sharing_cpus() is getting called. Let's pass it as an in-parameter
to avoid the unnecessary OF parsing.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- None.

---
 drivers/cpufreq/scmi-cpufreq.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 125e8a8421fb..78f53e388094 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -82,15 +82,12 @@ static int scmi_cpu_domain_id(struct device *cpu_dev)
 }
 
 static int
-scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
+scmi_get_sharing_cpus(struct device *cpu_dev, int domain,
+		      struct cpumask *cpumask)
 {
-	int cpu, domain, tdomain;
+	int cpu, tdomain;
 	struct device *tcpu_dev;
 
-	domain = scmi_cpu_domain_id(cpu_dev);
-	if (domain < 0)
-		return domain;
-
 	for_each_possible_cpu(cpu) {
 		if (cpu == cpu_dev->id)
 			continue;
@@ -163,7 +160,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	/* Obtain CPUs that share SCMI performance controls */
-	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);
+	ret = scmi_get_sharing_cpus(cpu_dev, domain, policy->cpus);
 	if (ret) {
 		dev_warn(cpu_dev, "failed to get sharing cpumask\n");
 		goto out_free_cpumask;
-- 
2.34.1

