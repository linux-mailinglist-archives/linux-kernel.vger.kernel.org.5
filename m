Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D1975C33E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGUJlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjGUJlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:41:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D678F30DF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:41:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8ad907ba4so10602525ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689932489; x=1690537289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV1Dq3qxy3owBxFZT6zTX4jA+LGfZlUCj9m2f/LMDI4=;
        b=PX7uG1KzgJBF9OqFkdVoGQGowY0yc8uyhhSfAf0grrqIE31HiSaobdTHh3woQlGXGl
         AFqxibmxcYe39UOHeBHgoboxh9JYggzuUuvt1gJCi3ouJBIdUMoF4ixPcx8eJN3OK+ki
         btdQ/IoO87PY9n2Su1E4ChD5X10ObsuPDki1Rx/1aBCFcdc0ZdGVGdfetwIkwd4MKWeJ
         bJJqDzcGmqQUmyZtwGJPIyHwHDwculDG0IBmUXRxtWgTrZCBt4aD8Bdicjs7GNHauexv
         CtVk4Y80Atp8Fu256ntEOo/AGfDuZyhUX4EgdG9q7xiblOoGPCtYOssK23WQuWvV/B85
         uh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689932489; x=1690537289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV1Dq3qxy3owBxFZT6zTX4jA+LGfZlUCj9m2f/LMDI4=;
        b=e7/rr6+6a3pPsqitwekgGYVAaPHPZlmIpANFQL7wlM/TIz9YGhTDQ6AZw7TzppkJAR
         nKQ12n8niVXvUemJxndRP0IcW6A/la/zNJNCKux+/nORCjKoDgDrXIzM1UMvaJT3N4qo
         CRLej4sgTYfqDNG1vV7lc2VbvyuMxUa2ssnxJ5x6ob+CVN6O0JRFuv3i7Iizj6cs7P5h
         SiyINEB8u6ay5QESOZFmFE2I3+VgMBuRGazx9UjUR3D5+PLGqgK8bDlieBlhcLJhUNrP
         GzG5zetFKqELu8FNB0jiOCSLbFNzkXH8jXCd2jSPXuhIsIbPXmyXqroq9X2NMAzWpUN5
         0x9g==
X-Gm-Message-State: ABy/qLZVUQGdSgOxwMCbBWtu6QyJax1np+4fJQqdgRN9yaOMs7mc86Tk
        s+JeNuFpv6V9CLazmGZWqoJC/g==
X-Google-Smtp-Source: APBJJlFwLBVVI5u6w9IjfM/dmNtJVCNAkIhF1rY/8iqPtscxzS4IN3fls6jffvT2kO3RWDvl6CRYyw==
X-Received: by 2002:a17:902:ce84:b0:1b6:ba60:77f0 with SMTP id f4-20020a170902ce8400b001b6ba6077f0mr1347697plg.10.1689932489156;
        Fri, 21 Jul 2023 02:41:29 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id u22-20020a170902a61600b001b2069072ccsm3005270plq.18.2023.07.21.02.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:41:28 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] OPP: Reuse dev_pm_opp_get_freq_indexed()
Date:   Fri, 21 Jul 2023 15:10:59 +0530
Message-Id: <5ddded46303f9d034ecb79f1fcc48abcc590f7db.1689932341.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1689932341.git.viresh.kumar@linaro.org>
References: <cover.1689932341.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse dev_pm_opp_get_freq_indexed() from dev_pm_opp_get_freq().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 21 ---------------------
 include/linux/pm_opp.h | 12 +++++-------
 2 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 95f49fbe431c..16a103e6695b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -176,27 +176,6 @@ unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_power);
 
-/**
- * dev_pm_opp_get_freq() - Gets the frequency corresponding to an available opp
- * @opp:	opp for which frequency has to be returned for
- *
- * Return: frequency in hertz corresponding to the opp, else
- * return 0
- */
-unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
-{
-	if (IS_ERR_OR_NULL(opp)) {
-		pr_err("%s: Invalid parameters\n", __func__);
-		return 0;
-	}
-
-	if (!assert_single_clk(opp->opp_table))
-		return 0;
-
-	return opp->rates[0];
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
-
 /**
  * dev_pm_opp_get_freq_indexed() - Gets the frequency corresponding to an
  *				   available opp with specified index
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 23e4e4eaaa42..91f87d7e807c 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -103,8 +103,6 @@ int dev_pm_opp_get_supplies(struct dev_pm_opp *opp, struct dev_pm_opp_supply *su
 
 unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp);
 
-unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
-
 unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index);
 
 unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
@@ -214,11 +212,6 @@ static inline unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp)
 	return 0;
 }
 
-static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
-{
-	return 0;
-}
-
 static inline unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index)
 {
 	return 0;
@@ -669,4 +662,9 @@ static inline void dev_pm_opp_put_prop_name(int token)
 	dev_pm_opp_clear_config(token);
 }
 
+static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
+{
+	return dev_pm_opp_get_freq_indexed(opp, 0);
+}
+
 #endif		/* __LINUX_OPP_H__ */
-- 
2.31.1.272.g89b43f80a514

