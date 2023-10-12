Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A107C71A9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347339AbjJLPgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379172AbjJLPgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:36:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA887EE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:36:20 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so13027551fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697124979; x=1697729779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG5ZMvbc/231iS9bGZIwnFfA7k32eTQNm7qUwA1Humk=;
        b=ILud/K+qRJz5JV7Qy7T6wa0zfEmBlO89DIGhjxsnSRMCz2rgL8zyX0F/3XfG+UDDE/
         hO6qHY68ghjr7+sx2m/Jh7A60D+POlI2KGNu4uY3wb9ai+TehX5S5XU0Epl/0rzj+xSn
         qf+gf1F66q9yT4aN+SE6IWm/Ox5jQS7tw9tLVQvHx2t3WgGv/UGHQI5GWNXPCJJ1U3Yj
         3vRLHF9CyWk6JzHfHljAoN6RZpTvbKif45mNXgV4BacDA6w3c6lyuke70az22eKcrfow
         XCCF8iNSF7HArgg4sO1N3OksapVt2mDST7fqUqMppNjLnz7yh7cKlux78oyLin/y8C0J
         9U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124979; x=1697729779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tG5ZMvbc/231iS9bGZIwnFfA7k32eTQNm7qUwA1Humk=;
        b=A61Z+GI/8SJPuI0JPBLzubkUAcLAdcIHPz1jVolFjIRiYNpFFpdhVpKHu8xGbQWeaR
         KmPX5PjPASBskhBb0k+y9lRaOucYuZxqXiOG7UHcilBr4DZJgNVd584pZCtbWmb523KV
         0jBxxng/ajt/SVuzmZ1QPCgSwo8p8kXGyq/XclY0PkiE5kBXGCKp3ZgBewv3CJ1u+i3w
         7u3txGsY9ShoYogdjtw5MQuKMNdJl/Dr6la4vlBlLNdW3oPDEJoZ7Jrq9HEoL5Wj8snH
         bAktnUk0ZyUNVccTyIJ3wdOOb+RAGi1Z5FreXC9WoWZ5tahjyUrzq4f1NIisx06dZxNz
         MFZw==
X-Gm-Message-State: AOJu0YxZCMt7tpJVkCglS9zmFO2gYOM/Wx/ow3+SEYzoeP2DvWxlUyFq
        UpncTr4cCZbqdzYHdvILJigowQ==
X-Google-Smtp-Source: AGHT+IG8sYtgmxjUGA4Gz/lVuYLOQcH5yynWBIYvk5xYfJMjqzZRnVBFmVCBGSHUxHBvUkJajqTTiA==
X-Received: by 2002:a19:5017:0:b0:507:9701:2705 with SMTP id e23-20020a195017000000b0050797012705mr520821lfb.9.1697124979127;
        Thu, 12 Oct 2023 08:36:19 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id b3-20020ac247e3000000b004fb9c625b4asm2848218lfp.210.2023.10.12.08.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 08:36:18 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 5/5] PM: domains: Drop the unused pm_genpd_opp_to_performance_state()
Date:   Thu, 12 Oct 2023 17:36:16 +0200
Message-Id: <20231012153616.101485-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012152108.101270-1-ulf.hansson@linaro.org>
References: 
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

Since commit 7c41cdcd3bbe ("OPP: Simplify the over-designed pstate <->
level dance"), there is no longer any users of the
pm_genpd_opp_to_performance_state() API. Let's therefore drop it and its
corresponding ->opp_to_performance_state() callback, which also no longer
has any users.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 32 --------------------------------
 include/linux/pm_domain.h   | 12 ------------
 2 files changed, 44 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5cb2023581d4..04bd4fd82acf 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -3032,38 +3032,6 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 }
 EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 
-/**
- * pm_genpd_opp_to_performance_state - Gets performance state of the genpd from its OPP node.
- *
- * @genpd_dev: Genpd's device for which the performance-state needs to be found.
- * @opp: struct dev_pm_opp of the OPP for which we need to find performance
- *	state.
- *
- * Returns performance state encoded in the OPP of the genpd. This calls
- * platform specific genpd->opp_to_performance_state() callback to translate
- * power domain OPP to performance state.
- *
- * Returns performance state on success and 0 on failure.
- */
-unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
-					       struct dev_pm_opp *opp)
-{
-	struct generic_pm_domain *genpd = NULL;
-	int state;
-
-	genpd = container_of(genpd_dev, struct generic_pm_domain, dev);
-
-	if (unlikely(!genpd->opp_to_performance_state))
-		return 0;
-
-	genpd_lock(genpd);
-	state = genpd->opp_to_performance_state(genpd, opp);
-	genpd_unlock(genpd);
-
-	return state;
-}
-EXPORT_SYMBOL_GPL(pm_genpd_opp_to_performance_state);
-
 static int __init genpd_bus_init(void)
 {
 	return bus_register(&genpd_bus_type);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f776fb93eaa0..124f870f38ca 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -113,7 +113,6 @@ struct genpd_power_state {
 };
 
 struct genpd_lock_ops;
-struct dev_pm_opp;
 struct opp_table;
 
 struct generic_pm_domain {
@@ -141,8 +140,6 @@ struct generic_pm_domain {
 	int (*power_on)(struct generic_pm_domain *domain);
 	struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
 	struct opp_table *opp_table;	/* OPP table of the genpd */
-	unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
-						 struct dev_pm_opp *opp);
 	int (*set_performance_state)(struct generic_pm_domain *genpd,
 				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
@@ -343,8 +340,6 @@ int of_genpd_remove_subdomain(struct of_phandle_args *parent_spec,
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
-unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
-					       struct dev_pm_opp *opp);
 
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
@@ -390,13 +385,6 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
 	return -ENODEV;
 }
 
-static inline unsigned int
-pm_genpd_opp_to_performance_state(struct device *genpd_dev,
-				  struct dev_pm_opp *opp)
-{
-	return 0;
-}
-
 static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return 0;
-- 
2.34.1

