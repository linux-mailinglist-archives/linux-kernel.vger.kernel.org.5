Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946D97DB82A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjJ3KeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbjJ3Kdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:33:46 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3832D1FFF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:24:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9e072472bso27963925ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698661470; x=1699266270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtcQW3aXfAlTqsT2Zd28zglQGGMRvlM92lJnVAtaLXI=;
        b=bCBs+dxR5upVHY3kIoBkFu6WzFKGSi5xa3qGQQdGMTMPoFMjzKPlRT37J3VLfAnlvz
         zwy8r6PAuZyI+f4/4N7Ni02ImjLdZppWh2gS5RKbx0dFk1siENju9669EGKIyKK6Grkh
         C9R1wpl2JGyhIBn0Htp10KZbrkHJqeX8J1awpCOWmR+OjP3TmaV5DqCV+cnSNEF+GhEy
         6npFGPJ9Vd2lqBhK2BD9te1Eay//gq6YbWABcBg1S/UB4W6lPQQW5/+fXl/lCWVflzb+
         oVzuXXA7aO78rtrOV3gLFQvdE1XQEjJ9hfL2Hca7UpzCt4ovlFKn/jt5weQf5Q6vVJMa
         RGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698661470; x=1699266270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtcQW3aXfAlTqsT2Zd28zglQGGMRvlM92lJnVAtaLXI=;
        b=i/X2H8H99186g4eunr+WJCrH1Kj43unVNXyo277TdqAYFN81p6YxSHG2dOM1MamgWR
         uqdGOvbmWb2PW1/OstYp115TcHRGFgy3HGcd7rXuvMsXelU/9DNlN9sfAKhy7MZIg7Rp
         XxbOVjG/HwYGn5cx+KLP6OcTeS26fDG0sJjMRk2Oxrxxsp4ILij9MQJ1plj45mdv83r+
         AvM3UypYiYEcNpmlzbP6MQ2bxOsrzsDIR5OyX3P7TjIjKUYhUHWb35EBtPGJcR0K5aTq
         1X4/SVP9R7nwoBVl23L2Sx+D/xNWvrTLeNF6u4lraiWhKlA9H+HLTTCxoiL6Y5yDFk3I
         nIBQ==
X-Gm-Message-State: AOJu0Yw8ekvCLvZcjxo5UGO1o7/L4HFpQ5m8O3OKKESlxvs4s70Oeb4o
        vbB8GPptsZk6grZ9vchki8b1GA==
X-Google-Smtp-Source: AGHT+IFgyeHjA9sogygg8xypf8hBMtPaYzXskWNdJR2tQjr35CqM9pZCqmNzAcGtEdefivF3T0mipA==
X-Received: by 2002:a17:902:e0c5:b0:1ca:8b90:1cbd with SMTP id e5-20020a170902e0c500b001ca8b901cbdmr6303726pla.0.1698661470519;
        Mon, 30 Oct 2023 03:24:30 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id ix9-20020a170902f80900b001cc1dff5b86sm5919271plb.244.2023.10.30.03.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 03:24:30 -0700 (PDT)
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
Subject: [PATCH V2 2/3] OPP: Use _set_opp_level() for single genpd case
Date:   Mon, 30 Oct 2023 15:54:16 +0530
Message-Id: <c84f4cd7f3586c50b361d4ae117bb6f188205c79.1698661048.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1698661048.git.viresh.kumar@linaro.org>
References: <cover.1698661048.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c |  6 ++++--
 drivers/opp/of.c   | 25 ++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

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
index 85fad7ca0007..4b7191440bdf 100644
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
+		if (!WARN_ON(opp->level != OPP_LEVEL_UNSET))
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

