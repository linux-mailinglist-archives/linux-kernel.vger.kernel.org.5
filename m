Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FD67CF50B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345287AbjJSKWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345283AbjJSKWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:22:20 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216BB11D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:22:17 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c4b9e09521so5074734a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697710936; x=1698315736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5cNSrE9rhEL2kYfgL1rTFcIHVYfLkBG+dEUsUc/tOs=;
        b=IMoLl15+CX7GipPVKmi5a23E+sP0IzobwUSfg+4hUJm0Y3m1M6NcNM1J6aSQCzn5n9
         LSrjyF0PSqwIP+jYRXCOsEAg8Z6fYXKLbdi4orapilFhKfJ46Lo6iTTVPIYK3jfcrYUH
         ODWdWl1J+XTLC+qflNPSjX1kuzwSnu9HklIhGnrjYb2UXbpwo8MmRAGwbh8Ln2ReFbNv
         N4efLNAPsS5TVYlaOSqm7wIKgAlrTGKIy2/9O8/75SwI080k4lBw4rSWQ42cdJ+O9UaG
         D9FRjqhFb8c6GCaWeBUtZPcvSHqr8KB+DzaMEG8LFUpdifiJWTK+apf1kU8sXqpVpm6p
         eMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697710936; x=1698315736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5cNSrE9rhEL2kYfgL1rTFcIHVYfLkBG+dEUsUc/tOs=;
        b=laaziU1HUKZWLyI5iFWhXy69NAFrL+R52cW8JrxcJ+xbxEVdIUCqdCh42OwaTF03aX
         HWNcxN9/ZpiqhmZaWF+hVaBsrZUCTvskZmov3UkWpaTuf1h976S60Szta0WQpaNV8F2h
         MMJ5TMz4Kd5rtsNIUpdskd0fwr6WsZsmMWFszYJtX7vomS9IKA3u7T8s6BOA5gzCT61E
         0XSUYdogcHjB0nFvGE0ChMm+ZeFxt19TMy20TgqTGspFi4Xjbse4cHlkjdaK1V9uRWhw
         FXQ7kgj5h3Atjha4VlV+F8Y0brymEJ2p/39v9GkW81w5amQtXXkw/wFwOv78qg873z69
         bKbw==
X-Gm-Message-State: AOJu0YxIFMt1KVo3YDsWfrVlne6hbc2eTHx2SPE10oJn5/BMDSf7KzDC
        pSd/A58+qUSWGlDe83ESH+2ibg==
X-Google-Smtp-Source: AGHT+IGSqX3v5dIhAERaYjI1k535CnrL+tOM58XrH0ltlBvwTuAMzftr8GjGir+pvGdlO2cH4e77lg==
X-Received: by 2002:a05:6830:1e46:b0:6ce:2c8e:79f2 with SMTP id e6-20020a0568301e4600b006ce2c8e79f2mr588925otj.8.1697710936325;
        Thu, 19 Oct 2023 03:22:16 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id f186-20020a6251c3000000b00692754580f0sm4963587pfb.187.2023.10.19.03.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:22:15 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] OPP: Call dev_pm_opp_set_opp() for required OPPs
Date:   Thu, 19 Oct 2023 15:52:01 +0530
Message-Id: <6de4fcb5bb943a131d0cdf0a858bd35af02a2f88.1697710527.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1697710527.git.viresh.kumar@linaro.org>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configuring the required OPP was never properly implemented, we just
took an exception for genpds and configured them directly, while leaving
out all other required OPP types.

Now that a standard call to dev_pm_opp_set_opp() takes care of
configuring the opp->level too, the special handling for genpds can be
avoided by simply calling dev_pm_opp_set_opp() for the required OPPs,
which shall eventually configure the corresponding level for genpds.

This also makes it possible for us to configure other type of required
OPPs (no concrete users yet though), via the same path. This is how
other frameworks take care of parent nodes, like clock, regulators, etc,
where we recursively call the same helper.

In order to call dev_pm_opp_set_opp() for the virtual genpd devices,
they must share the OPP table of the genpd. Call _add_opp_dev() for them
to get that done.

This commit also extends the struct dev_pm_opp_config to pass required
devices, for non-genpd cases, which can be used to call
dev_pm_opp_set_opp() for the non-genpd required devices.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 144 ++++++++++++++++++-----------------------
 drivers/opp/of.c       |  12 ++--
 drivers/opp/opp.h      |   8 +--
 include/linux/pm_opp.h |   7 +-
 4 files changed, 76 insertions(+), 95 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index aab8c8e79146..056b51abc501 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1046,42 +1046,19 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 	return 0;
 }
 
-static int _set_performance_state(struct device *dev, struct device *pd_dev,
-				  struct dev_pm_opp *opp, int i)
-{
-	unsigned int pstate = likely(opp) ? opp->required_opps[i]->level: 0;
-	int ret;
-
-	if (!pd_dev)
-		return 0;
-
-	ret = dev_pm_domain_set_performance_state(pd_dev, pstate);
-	if (ret) {
-		dev_err(dev, "Failed to set performance state of %s: %d (%d)\n",
-			dev_name(pd_dev), pstate, ret);
-	}
-
-	return ret;
-}
-
-static int _opp_set_required_opps_generic(struct device *dev,
-	struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down)
-{
-	dev_err(dev, "setting required-opps isn't supported for non-genpd devices\n");
-	return -ENOENT;
-}
-
-static int _opp_set_required_opps_genpd(struct device *dev,
-	struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down)
+/* This is only called for PM domain for now */
+static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
+			      struct dev_pm_opp *opp, bool up)
 {
-	struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
+	struct device **devs = opp_table->required_devs;
 	int index, target, delta, ret;
 
-	if (!genpd_virt_devs)
-		return 0;
+	/* required-opps not fully initialized yet */
+	if (lazy_linking_pending(opp_table))
+		return -EBUSY;
 
 	/* Scaling up? Set required OPPs in normal order, else reverse */
-	if (!scaling_down) {
+	if (up) {
 		index = 0;
 		target = opp_table->required_opp_count;
 		delta = 1;
@@ -1092,9 +1069,11 @@ static int _opp_set_required_opps_genpd(struct device *dev,
 	}
 
 	while (index != target) {
-		ret = _set_performance_state(dev, genpd_virt_devs[index], opp, index);
-		if (ret)
-			return ret;
+		if (devs[index]) {
+			ret = dev_pm_opp_set_opp(devs[index], opp);
+			if (ret)
+				return ret;
+		}
 
 		index += delta;
 	}
@@ -1102,34 +1081,6 @@ static int _opp_set_required_opps_genpd(struct device *dev,
 	return 0;
 }
 
-/* This is only called for PM domain for now */
-static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
-			      struct dev_pm_opp *opp, bool up)
-{
-	/* required-opps not fully initialized yet */
-	if (lazy_linking_pending(opp_table))
-		return -EBUSY;
-
-	if (opp_table->set_required_opps)
-		return opp_table->set_required_opps(dev, opp_table, opp, up);
-
-	return 0;
-}
-
-/* Update set_required_opps handler */
-void _update_set_required_opps(struct opp_table *opp_table)
-{
-	/* Already set */
-	if (opp_table->set_required_opps)
-		return;
-
-	/* All required OPPs will belong to genpd or none */
-	if (opp_table->required_opp_tables[0]->is_genpd)
-		opp_table->set_required_opps = _opp_set_required_opps_genpd;
-	else
-		opp_table->set_required_opps = _opp_set_required_opps_generic;
-}
-
 static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
 			  struct dev_pm_opp *opp)
 {
@@ -2390,19 +2341,13 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 {
 	int index;
 
-	if (!opp_table->genpd_virt_devs)
-		return;
-
 	for (index = 0; index < opp_table->required_opp_count; index++) {
-		if (!opp_table->genpd_virt_devs[index])
+		if (!opp_table->required_devs[index])
 			continue;
 
-		dev_pm_domain_detach(opp_table->genpd_virt_devs[index], false);
-		opp_table->genpd_virt_devs[index] = NULL;
+		dev_pm_domain_detach(opp_table->required_devs[index], false);
+		opp_table->required_devs[index] = NULL;
 	}
-
-	kfree(opp_table->genpd_virt_devs);
-	opp_table->genpd_virt_devs = NULL;
 }
 
 /*
@@ -2429,15 +2374,10 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 	int index = 0, ret = -EINVAL;
 	const char * const *name = names;
 
-	if (opp_table->genpd_virt_devs)
+	/* Checking only the first one is enough ? */
+	if (opp_table->required_devs[0])
 		return 0;
 
-	opp_table->genpd_virt_devs = kcalloc(opp_table->required_opp_count,
-					     sizeof(*opp_table->genpd_virt_devs),
-					     GFP_KERNEL);
-	if (!opp_table->genpd_virt_devs)
-		return -ENOMEM;
-
 	while (*name) {
 		if (index >= opp_table->required_opp_count) {
 			dev_err(dev, "Index can't be greater than required-opp-count - 1, %s (%d : %d)\n",
@@ -2452,13 +2392,25 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			goto err;
 		}
 
-		opp_table->genpd_virt_devs[index] = virt_dev;
+		/*
+		 * Add the virtual genpd device as a user of the OPP table, so
+		 * we can call dev_pm_opp_set_opp() on it directly.
+		 *
+		 * This will be automatically removed when the OPP table is
+		 * removed, don't need to handle that here.
+		 */
+		if (!_add_opp_dev(virt_dev, opp_table->required_opp_tables[index])) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		opp_table->required_devs[index] = virt_dev;
 		index++;
 		name++;
 	}
 
 	if (virt_devs)
-		*virt_devs = opp_table->genpd_virt_devs;
+		*virt_devs = opp_table->required_devs;
 
 	return 0;
 
@@ -2468,10 +2420,34 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 
 }
 
+static void _opp_set_required_devs(struct opp_table *opp_table,
+				   struct device **required_devs)
+{
+	int i;
+
+	/* Another CPU that shares the OPP table has set the required devs ? */
+	if (opp_table->required_devs[0])
+		return;
+
+	for (i = 0; i < opp_table->required_opp_count; i++)
+		opp_table->required_devs[i] = required_devs[i];
+}
+
+static void _opp_put_required_devs(struct opp_table *opp_table)
+{
+	int i;
+
+	for (i = 0; i < opp_table->required_opp_count; i++)
+		opp_table->required_devs[i] = NULL;
+}
+
 static void _opp_clear_config(struct opp_config_data *data)
 {
-	if (data->flags & OPP_CONFIG_GENPD)
+	if (data->flags & OPP_CONFIG_REQUIRED_DEVS)
+		_opp_put_required_devs(data->opp_table);
+	else if (data->flags & OPP_CONFIG_GENPD)
 		_opp_detach_genpd(data->opp_table);
+
 	if (data->flags & OPP_CONFIG_REGULATOR)
 		_opp_put_regulators(data->opp_table);
 	if (data->flags & OPP_CONFIG_SUPPORTED_HW)
@@ -2585,12 +2561,18 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
 	/* Attach genpds */
 	if (config->genpd_names) {
+		if (config->required_devs)
+			goto err;
+
 		ret = _opp_attach_genpd(opp_table, dev, config->genpd_names,
 					config->virt_devs);
 		if (ret)
 			goto err;
 
 		data->flags |= OPP_CONFIG_GENPD;
+	} else if (config->required_devs) {
+		_opp_set_required_devs(opp_table, config->required_devs);
+		data->flags |= OPP_CONFIG_REQUIRED_DEVS;
 	}
 
 	ret = xa_alloc(&opp_configs, &id, data, XA_LIMIT(1, INT_MAX),
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e056f31a48b5..27659d23d54d 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -165,7 +165,7 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	struct opp_table **required_opp_tables;
 	struct device_node *required_np, *np;
 	bool lazy = false;
-	int count, i;
+	int count, i, size;
 
 	/* Traversing the first OPP node is all we need */
 	np = of_get_next_available_child(opp_np, NULL);
@@ -179,12 +179,13 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 	if (count <= 0)
 		goto put_np;
 
-	required_opp_tables = kcalloc(count, sizeof(*required_opp_tables),
-				      GFP_KERNEL);
+	size = sizeof(*required_opp_tables) + sizeof(*opp_table->required_devs);
+	required_opp_tables = kcalloc(count, size, GFP_KERNEL);
 	if (!required_opp_tables)
 		goto put_np;
 
 	opp_table->required_opp_tables = required_opp_tables;
+	opp_table->required_devs = (void *)(required_opp_tables + count);
 	opp_table->required_opp_count = count;
 
 	for (i = 0; i < count; i++) {
@@ -208,8 +209,6 @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
 		mutex_lock(&opp_table_lock);
 		list_add(&opp_table->lazy, &lazy_opp_tables);
 		mutex_unlock(&opp_table_lock);
-	} else {
-		_update_set_required_opps(opp_table);
 	}
 
 	goto put_np;
@@ -328,7 +327,7 @@ static int _link_required_opps(struct dev_pm_opp *opp, struct opp_table *opp_tab
 	 * dev_pm_opp_set_opp() will take care of in the normal path itself.
 	 */
 	if (required_table->is_genpd && opp_table->required_opp_count == 1 &&
-	    !opp_table->genpd_virt_devs) {
+	    !opp_table->required_devs[0]) {
 		if (!WARN_ON(opp->level))
 			opp->level = opp->required_opps[0]->level;
 	}
@@ -441,7 +440,6 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
 
 		/* All required opp-tables found, remove from lazy list */
 		if (!lazy) {
-			_update_set_required_opps(opp_table);
 			list_del_init(&opp_table->lazy);
 
 			list_for_each_entry(opp, &opp_table->opp_list, node)
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 08366f90f16b..23dcb2fbf8c3 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -35,6 +35,7 @@ extern struct list_head opp_tables;
 #define OPP_CONFIG_PROP_NAME		BIT(3)
 #define OPP_CONFIG_SUPPORTED_HW		BIT(4)
 #define OPP_CONFIG_GENPD		BIT(5)
+#define OPP_CONFIG_REQUIRED_DEVS	BIT(6)
 
 /**
  * struct opp_config_data - data for set config operations
@@ -160,9 +161,9 @@ enum opp_table_access {
  * @rate_clk_single: Currently configured frequency for single clk.
  * @current_opp: Currently configured OPP for the table.
  * @suspend_opp: Pointer to OPP to be used during device suspend.
- * @genpd_virt_devs: List of virtual devices for multiple genpd support.
  * @required_opp_tables: List of device OPP tables that are required by OPPs in
  *		this table.
+ * @required_devs: List of devices for required OPP tables.
  * @required_opp_count: Number of required devices.
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
@@ -180,7 +181,6 @@ enum opp_table_access {
  * @path_count: Number of interconnect paths
  * @enabled: Set to true if the device's resources are enabled/configured.
  * @is_genpd: Marks if the OPP table belongs to a genpd.
- * @set_required_opps: Helper responsible to set required OPPs.
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
  * @dentry_name: Name of the real dentry.
  *
@@ -211,8 +211,8 @@ struct opp_table {
 	struct dev_pm_opp *current_opp;
 	struct dev_pm_opp *suspend_opp;
 
-	struct device **genpd_virt_devs;
 	struct opp_table **required_opp_tables;
+	struct device **required_devs;
 	unsigned int required_opp_count;
 
 	unsigned int *supported_hw;
@@ -229,8 +229,6 @@ struct opp_table {
 	unsigned int path_count;
 	bool enabled;
 	bool is_genpd;
-	int (*set_required_opps)(struct device *dev,
-		struct opp_table *opp_table, struct dev_pm_opp *opp, bool scaling_down);
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index ccd97bcef269..25f7bcbea7ab 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -74,8 +74,10 @@ typedef int (*config_clks_t)(struct device *dev, struct opp_table *opp_table,
  * @supported_hw_count: Number of elements in the array.
  * @regulator_names: Array of pointers to the names of the regulator, NULL terminated.
  * @genpd_names: Null terminated array of pointers containing names of genpd to
- *		 attach.
- * @virt_devs: Pointer to return the array of virtual devices.
+ *		attach. Mutually exclusive with required_devs.
+ * @virt_devs: Pointer to return the array of genpd virtual devices. Mutually
+ *		exclusive with required_devs.
+ * @required_devs: Required OPP devices. Mutually exclusive with genpd_names/virt_devs.
  *
  * This structure contains platform specific OPP configurations for the device.
  */
@@ -90,6 +92,7 @@ struct dev_pm_opp_config {
 	const char * const *regulator_names;
 	const char * const *genpd_names;
 	struct device ***virt_devs;
+	struct device **required_devs;
 };
 
 /**
-- 
2.31.1.272.g89b43f80a514

