Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B71B7CF509
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345251AbjJSKWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345249AbjJSKWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:22:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E044FA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:22:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27d0251d305so4784253a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697710933; x=1698315733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmjA0HEYlUuwJKncR5UsQ51jJen21NHSaXoRnKSgrrY=;
        b=VJ8GXYbixIqdEPgD7WbhMfgUrcvQOnLomDlFXdlE1s2/8hF7HwrQbxChbqkSJ8L6/n
         Sdpz+o5NMw8diFBAZvIniynKBeFbbpW6BpqYRQBPqMqbar528XYSs5Gvd6/jYTUqB5Ix
         2mWilVgA+Pgxlz69EeA4o9ZTmk+D3iNb5DVkScLkKWLo4qE5d6AkyutzAfVsowaKnRnN
         WNlNihmb8kp5+/LTfYvbFbuIwFnbbP6J4S71YGHQqM/KUg/w3yktq+unwsEZzFi9YrBG
         buAL6DDxG5IXIqI9JuHGFiojQqawVXtV27UW+EQXgUBurZ5Fug7mJ1Swv0lQPf+sHVcG
         SNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697710933; x=1698315733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmjA0HEYlUuwJKncR5UsQ51jJen21NHSaXoRnKSgrrY=;
        b=apryUP8VO6RVyR95/JmQ0qBINI/+xxc2AZ79CnpVYSdjKrjHBqJij3ukCzqWiH6jjF
         X1XL7ozO4DK9sXWD4rsWgJ3qFRAUAHCy1D4B+zwx/tlvVteqPJ/sXg2D+3cN3ZWz11r9
         +Ni1i2f3rd/VmYOSE/YrIlFEGQloMZc+Aza3VmJw+pyOkbXeK70YlHvY5e3zjVlJHvzQ
         Vl1ZgRNA+2p1TMnSmz0rNUSP6HFDoys1pm9SXTzgMoJNzdzAYCMnZ3hHifQeS0niKL6b
         xtFWmAqCSOL+AFpv4IH767VkMOyyKdya3UlT/WMMsFsCKOQJb53vsZkeWk/tIyOlytFM
         adnQ==
X-Gm-Message-State: AOJu0Yzv3DpbuPffK5TbkDtt1FfFxxjIkY3C5Pqfxu7eVMkFTQjfTfNl
        1C5PoW0Gs0T5W5TgncGsWaRwdw==
X-Google-Smtp-Source: AGHT+IEP3jN2Coy1i4l4sCop8XumfySpFdag9EvlhEBvKEdV1ysREFxhOd2kQlIY7VbcVh08UjS9+g==
X-Received: by 2002:a17:90b:3793:b0:27d:2364:44f6 with SMTP id mz19-20020a17090b379300b0027d236444f6mr1559112pjb.6.1697710932749;
        Thu, 19 Oct 2023 03:22:12 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a005400b0026cecddfc58sm1430945pjb.42.2023.10.19.03.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:22:12 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] OPP: Use _set_opp_level() for single genpd case
Date:   Thu, 19 Oct 2023 15:52:00 +0530
Message-Id: <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1697710527.git.viresh.kumar@linaro.org>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two genpd (as required-opp) cases that we need to handle,
devices with a single genpd and ones with multiple genpds.

The multiple genpds case is clear, where the OPP core calls
dev_pm_domain_attach_by_name() for them and uses the virtual devices
returned by this helper to call dev_pm_domain_set_performance_state()
later to change the performance state.

The single genpd case however requires special handling as we need to
use the same `dev` structure (instead of a virtual one provided by genpd
core) for setting the performance state via
dev_pm_domain_set_performance_state().

As we move towards more generic code to take care of the required OPPs,
where we will recursively call dev_pm_opp_set_opp() for all the required
OPPs, the above special case becomes a problem.

Eventually we want to handle all performance state changes via
_set_opp_level(), so lets move the single genpd case to that right away.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  6 ++++--
 drivers/opp/of.c   | 25 ++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 84f345c69ea5..aab8c8e79146 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1074,10 +1074,12 @@ static int _opp_set_required_opps_generic(struct device *dev,
 static int _opp_set_required_opps_genpd(struct device *dev,
 	struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down)
 {
-	struct device **genpd_virt_devs =
-		opp_table->genpd_virt_devs ? opp_table->genpd_virt_devs : &dev;
+	struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
 	int index, target, delta, ret;
 
+	if (!genpd_virt_devs)
+		return 0;
+
 	/* Scaling up? Set required OPPs in normal order, else reverse */
 	if (!scaling_down) {
 		index = 0;
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 81fa27599d58..e056f31a48b5 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -296,7 +296,7 @@ void _of_clear_opp(struct opp_table *opp_table, struct dev_pm_opp *opp)
 	of_node_put(opp->np);
 }
 
-static int _link_required_opps(struct dev_pm_opp *opp,
+static int _link_required_opps(struct dev_pm_opp *opp, struct opp_table *opp_table,
 			       struct opp_table *required_table, int index)
 {
 	struct device_node *np;
@@ -314,6 +314,25 @@ static int _link_required_opps(struct dev_pm_opp *opp,
 		return -ENODEV;
 	}
 
+	/*
+	 * There are two genpd (as required-opp) cases that we need to handle,
+	 * devices with a single genpd and ones with multiple genpds.
+	 *
+	 * The single genpd case requires special handling as we need to use the
+	 * same `dev` structure (instead of a virtual one provided by genpd
+	 * core) for setting the performance state. Lets treat this as a case
+	 * where the OPP's level is directly available without required genpd
+	 * link in the DT.
+	 *
+	 * Just update the `level` with the right value, which
+	 * dev_pm_opp_set_opp() will take care of in the normal path itself.
+	 */
+	if (required_table->is_genpd && opp_table->required_opp_count == 1 &&
+	    !opp_table->genpd_virt_devs) {
+		if (!WARN_ON(opp->level))
+			opp->level = opp->required_opps[0]->level;
+	}
+
 	return 0;
 }
 
@@ -338,7 +357,7 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 		if (IS_ERR_OR_NULL(required_table))
 			continue;
 
-		ret = _link_required_opps(opp, required_table, i);
+		ret = _link_required_opps(opp, opp_table, required_table, i);
 		if (ret)
 			goto free_required_opps;
 	}
@@ -359,7 +378,7 @@ static int lazy_link_required_opps(struct opp_table *opp_table,
 	int ret;
 
 	list_for_each_entry(opp, &opp_table->opp_list, node) {
-		ret = _link_required_opps(opp, new_table, index);
+		ret = _link_required_opps(opp, opp_table, new_table, index);
 		if (ret)
 			return ret;
 	}
-- 
2.31.1.272.g89b43f80a514

