Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5817EDEB0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjKPKn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjKPKnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:43:22 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594DEB8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:43:19 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc9b626a96so5772005ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700131399; x=1700736199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtC8Hkqp39VdOkkGa+oSqv3EzGyQo+AktZrizfGIeEc=;
        b=k+3Uj5GrEcIGlGmv8swGd0kfO07hKdSpoSlw9c2SPvFG8dyQk7KwzOwskhER+nqO40
         a/2Z31pnBGnTnRLhOlDghU3BqpRDl+hsRPZbWjfnqL+/c5j/J23bqKGjMqoyM2LNLzOf
         dWJxINBKVGqmeATjsNVVAZPFEhcKY5bmX/Nrh8u/rhvtIH8acMnzdkvrMZGom95JKQvn
         mR4cqpuFCSIu6ATuaeHXCiAU5tBp2MS9GjBTMcHTOg4uRNAMqT/vx1eDbqEc1Ax5wKWk
         ZzuqdmcfnPLwQ5fIfJY/fWVKnm8SNYxIvxgK9R5VS35mnALb5NGc5ABySLsodAAY2tQX
         F6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700131399; x=1700736199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtC8Hkqp39VdOkkGa+oSqv3EzGyQo+AktZrizfGIeEc=;
        b=ZLiR08GraqazlH4FkT/LgWM5kGiCptocs4ibo3QrT1hglRP/CsEzA3p8UGImrhL6b9
         WXq6rZEHfMpe9DiJ9Jm6y1aVkDVrdbrwv247vb3fEewc4xNwKg+pQxHhFk+juPx5P/eS
         3L/RBiaw0/jj/k7NgOt+TmJlRs0vi/dJIOYHFQR4spU6PyguJYwuU3t5RqV/foiWyPb+
         uZJ7+/B1dlbSKUnB2cEbPktrKCADdVr1p1iFXAmMjdyt7tm8OpDkmyWoaJNHZR4OHU1q
         AXhxcGn2mbWsufSGAdW9mSF7o0cmGljDmVyHM4t36VmKIwR7tWfoyFzSAaAuhVyDXb4Z
         D57w==
X-Gm-Message-State: AOJu0YzLEx4nPM34VlLII5SOqBuO+D9kcuXyfr/WFYz+pFREFlFNzCC6
        /g1pw3a1EcILrpDyoeK3sSbBDQ==
X-Google-Smtp-Source: AGHT+IF+lLCjAJlkXERdKhnkQRcLuiOMhIXIZ8Un4tFtKHyyQLgswdzWIFtSbmdHtKcVwWQaySXPZA==
X-Received: by 2002:a17:902:ce86:b0:1b5:561a:5ca9 with SMTP id f6-20020a170902ce8600b001b5561a5ca9mr9977070plg.50.1700131398716;
        Thu, 16 Nov 2023 02:43:18 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id n2-20020a1709026a8200b001c44dbc92a2sm8859446plk.184.2023.11.16.02.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:43:18 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/3] OPP: Use _set_opp_level() for single genpd case
Date:   Thu, 16 Nov 2023 16:13:05 +0530
Message-Id: <5e04c29cd98cf309cd9810dcb13e7789b4a17ada.1700131353.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1700131353.git.viresh.kumar@linaro.org>
References: <cover.1700131353.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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

It doesn't make sense for a device's DT entry to have both "opp-level"
and single "required-opps" entry pointing to a genpd's OPP, as that
would make the OPP core call dev_pm_domain_set_performance_state() for
two different values for the same device structure. And so we can reuse
the 'opp->level" field in such a case and call _set_opp_level() for the
device.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  6 ++++--
 drivers/opp/of.c   | 31 ++++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index f2e2aa07b431..aeb216f7e978 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1088,10 +1088,12 @@ static int _opp_set_required_opps_generic(struct device *dev,
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
index 85fad7ca0007..4cdeeab5ceee 100644
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
@@ -314,6 +314,31 @@ static int _link_required_opps(struct dev_pm_opp *opp,
 		return -ENODEV;
 	}
 
+	/*
+	 * There are two genpd (as required-opp) cases that we need to handle,
+	 * devices with a single genpd and ones with multiple genpds.
+	 *
+	 * The single genpd case requires special handling as we need to use the
+	 * same `dev` structure (instead of a virtual one provided by genpd
+	 * core) for setting the performance state.
+	 *
+	 * It doesn't make sense for a device's DT entry to have both
+	 * "opp-level" and single "required-opps" entry pointing to a genpd's
+	 * OPP, as that would make the OPP core call
+	 * dev_pm_domain_set_performance_state() for two different values for
+	 * the same device structure. Lets treat single genpd configuration as a
+	 * case where the OPP's level is directly available without required-opp
+	 * link in the DT.
+	 *
+	 * Just update the `level` with the right value, which
+	 * dev_pm_opp_set_opp() will take care of in the normal path itself.
+	 */
+	if (required_table->is_genpd && opp_table->required_opp_count == 1 &&
+	    !opp_table->genpd_virt_devs) {
+		if (!WARN_ON(opp->level != OPP_LEVEL_UNSET))
+			opp->level = opp->required_opps[0]->level;
+	}
+
 	return 0;
 }
 
@@ -338,7 +363,7 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 		if (IS_ERR_OR_NULL(required_table))
 			continue;
 
-		ret = _link_required_opps(opp, required_table, i);
+		ret = _link_required_opps(opp, opp_table, required_table, i);
 		if (ret)
 			goto free_required_opps;
 	}
@@ -359,7 +384,7 @@ static int lazy_link_required_opps(struct opp_table *opp_table,
 	int ret;
 
 	list_for_each_entry(opp, &opp_table->opp_list, node) {
-		ret = _link_required_opps(opp, new_table, index);
+		ret = _link_required_opps(opp, opp_table, new_table, index);
 		if (ret)
 			return ret;
 	}
-- 
2.31.1.272.g89b43f80a514

