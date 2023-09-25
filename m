Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141907AD8DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjIYNSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjIYNSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:18:13 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7026E10E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:18:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50337b43ee6so10566864e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695647883; x=1696252683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxw1p33YOE1Wx3IdS6/yDe9IgDNF8zci3+vg+kboqRc=;
        b=xwOH8+NWikrFsbTxiNt18SPwgZRiyXp+O/c1EVyL4+dR7QzPvPN8XKSDt553DK/UF6
         dcVsYvU9QzpkwdXf7keozroHEuhtrcz86fFXn/kkr+qK3bAJe7hdk6uicJkawfY3CxPn
         jfeA/QvFJAD+xNXYo7PbKLpw0kFG6/3uVBScxXzZEPD2s5CniwEOvyHtxVHlMnMrl8BR
         mPQRd3sitKKrEstHg4k21+wHzRdNWS0c8PZPMYeo8I2QaaS+0Um1ACRbpuIQr3FvNlIA
         NQjRdMXiUYhhOPbNcaQtER8dnkZryqWl1CWyFyQMc4n8xNkCcbvCiRb15hcRC+JzdrD4
         xpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647883; x=1696252683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxw1p33YOE1Wx3IdS6/yDe9IgDNF8zci3+vg+kboqRc=;
        b=BB+zupt6axtQvmGszA8CPLfyjKDqKbo3uv/rKFGPdN2Qnl3V8qtOSMum5lRLlsgLB0
         s+mxWEc0/9pSpJ/fH2j4kBnLPpKFsVXGvpbvj5bIZOuQf0WoBSdBX9FLDWGbbq6uZzea
         JEOxqrrPrM+Hk7PHdhc8SEos80ZHqX6IXFD85BskD2+5WLeJ0lKpLjh8rEGCAo4uM1+g
         d4YvDF6IldfruB+uuCh9KFd7Wh0QAa/Two+jnLjoxpKdkZ0Z49ulREsKt8CEbHj383wd
         3fLg38MmpOkCQ6W5GHbC+DCgDNLriSyBdvIgS3egcwBsnnlAFo2lISdFwk1n3tGcnKzI
         lXtQ==
X-Gm-Message-State: AOJu0Yxe20QJz0JT7+9ZXy6kicVIAYQKpcZOprxdys6BCYkg1rv6RROX
        GOfcyKP6z0K2xXEcC8KrpWRmiw==
X-Google-Smtp-Source: AGHT+IFNueuLCXRNbVrLA4eVjJu12iokEykiWxOyhkw7rPrvIF7kGqhFmBrd80yDDQXxWRiDucIYXA==
X-Received: by 2002:a05:6512:308c:b0:500:79f7:1738 with SMTP id z12-20020a056512308c00b0050079f71738mr5892894lfd.17.1695647883494;
        Mon, 25 Sep 2023 06:18:03 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id m29-20020a056512015d00b004fe10276bbfsm1823583lfo.296.2023.09.25.06.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:18:02 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] firmware: arm_scmi: Simplify error path in scmi_dvfs_device_opps_add()
Date:   Mon, 25 Sep 2023 15:17:13 +0200
Message-Id: <20230925131715.138411-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925131715.138411-1-ulf.hansson@linaro.org>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
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

Let's simplify the code in scmi_dvfs_device_opps_add() by using
dev_pm_opp_remove_all_dynamic() in the error path.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/arm_scmi/perf.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 9eb58df9124d..733c5ebeb555 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -787,30 +787,22 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 {
 	int idx, ret;
 	unsigned long freq;
-	struct scmi_opp *opp;
 	struct perf_dom_info *dom;
 
 	dom = scmi_perf_domain_lookup(ph, domain);
 	if (IS_ERR(dom))
 		return PTR_ERR(dom);
 
-	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
+	for (idx = 0; idx < dom->opp_count; idx++) {
 		if (!dom->level_indexing_mode)
-			freq = opp->perf * dom->mult_factor;
+			freq = dom->opp[idx].perf * dom->mult_factor;
 		else
-			freq = opp->indicative_freq * 1000;
+			freq = dom->opp[idx].indicative_freq * 1000;
 
 		ret = dev_pm_opp_add(dev, freq, 0);
 		if (ret) {
 			dev_warn(dev, "failed to add opp %luHz\n", freq);
-
-			while (idx-- > 0) {
-				if (!dom->level_indexing_mode)
-					freq = (--opp)->perf * dom->mult_factor;
-				else
-					freq = (--opp)->indicative_freq * 1000;
-				dev_pm_opp_remove(dev, freq);
-			}
+			dev_pm_opp_remove_all_dynamic(dev);
 			return ret;
 		}
 
-- 
2.34.1

