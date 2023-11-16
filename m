Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C787EDEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345033AbjKPKna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344985AbjKPKn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:43:27 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21EF1A7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:43:22 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc4f777ab9so6021705ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700131402; x=1700736202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9BTLIceKJGW92qKd3ko8bGti/Wwlg3EknEGU5HzzG8=;
        b=ZJdA3UgW5qM31WGwmfS1N/ABXivzwRJRqCX+fe4VMpMFl1ry7xUqZ3ayZYfP9sEkVC
         jZTBaWsv1BHzyvhF7hiYJq7yFGuEISL0B8y0Xtum0ZiKSWY5AZfcrHJd7q/NQsz9lN6i
         qVPfggn8RcDxUdnmiYzG18sNBtszsx9Yye0V5aipji/Fymz1AWbvrB/WBlu1HPxHR6Ve
         nlcndLc/N7VAerxN810GNAlVdVKM7EOiP6skZSj5CkNt7DtwJw4QjKeH+1LnFL0pywd8
         M0D9sxHdbFPbv6QmE2YiEozgEaSwPMSknUG9aF/L00F9nB6ckDj2gFr1GOoYefs14GfB
         0y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700131402; x=1700736202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9BTLIceKJGW92qKd3ko8bGti/Wwlg3EknEGU5HzzG8=;
        b=flX/R9+xDwOCAyImyag2fELSGwhLjvY0+3wOV6U4NAZjetku1xSyn2jbyfa0EC5guC
         z9GZBsgAnlQQkk9o6tv+7aUjdNmC/O78N8wKLo6BOzqNZMaRoTiFSmMA5ViRNitNAcq0
         7blXj+regqL0Jrm190DuZ5u0bfVcos74GImlP0eausvKj2+FR2giDoHsh0/zI4NOQooA
         DX6N8EMFgmiMe2VxYLR3hGz9vlu4sx+aIT0QEvZH/f20i9IsLzlRWjEjFhtwqykrMwuD
         ELG29MKPnzVS5N772RHCSTWA+fs8WNrjd9VPkdU87qx+TJY9ipwXEVfvYxIj8+ZozqQM
         qwAQ==
X-Gm-Message-State: AOJu0YwYjk3wk66r70UMeMc3bDupQmHt1KwEpzhMJJglJli/BWJBh7NQ
        dSjI5TrK5oSTdRQqyMuh6VZyXg==
X-Google-Smtp-Source: AGHT+IH1j0bxjDkRH01TYL8RmeGGUObFnJhKV7GL8eCxgG0N5Mc9E0g5N/jXAb/814C9ibjPgPqeJQ==
X-Received: by 2002:a17:902:dace:b0:1bb:6875:5a73 with SMTP id q14-20020a170902dace00b001bb68755a73mr9742084plx.2.1700131402233;
        Thu, 16 Nov 2023 02:43:22 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id u10-20020a170903124a00b001c9c879ee4asm8906686plh.17.2023.11.16.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 02:43:21 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] OPP: Call dev_pm_opp_set_opp() for required OPPs
Date:   Thu, 16 Nov 2023 16:13:06 +0530
Message-Id: <57ba55c5568ac4131429124661b37581b6cd6b7a.1700131353.git.viresh.kumar@linaro.org>
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
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c     | 168 ++++++++++++++++++++---------------------
 drivers/opp/of.c       |  17 +++--
 drivers/opp/opp.h      |   8 +-
 include/linux/pm_opp.h |   7 +-
 4 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index aeb216f7e978..e08375ed50aa 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1054,48 +1054,22 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 	return 0;
 }
 
-static int _set_performance_state(struct device *dev, struct device *pd_dev,
-				  struct dev_pm_opp *opp, int i)
-{
-	unsigned int pstate = 0;
-	int ret;
-
-	if (!pd_dev)
-		return 0;
-
-	if (likely(opp)) {
-		pstate = opp->required_opps[i]->level;
-		if (pstate == OPP_LEVEL_UNSET)
-			return 0;
-	}
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
+	if (!devs)
 		return 0;
 
+	/* required-opps not fully initialized yet */
+	if (lazy_linking_pending(opp_table))
+		return -EBUSY;
+
 	/* Scaling up? Set required OPPs in normal order, else reverse */
-	if (!scaling_down) {
+	if (up) {
 		index = 0;
 		target = opp_table->required_opp_count;
 		delta = 1;
@@ -1106,9 +1080,11 @@ static int _opp_set_required_opps_genpd(struct device *dev,
 	}
 
 	while (index != target) {
-		ret = _set_performance_state(dev, genpd_virt_devs[index], opp, index);
-		if (ret)
-			return ret;
+		if (devs[index]) {
+			ret = dev_pm_opp_set_opp(devs[index], opp->required_opps[index]);
+			if (ret)
+				return ret;
+		}
 
 		index += delta;
 	}
@@ -1116,34 +1092,6 @@ static int _opp_set_required_opps_genpd(struct device *dev,
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
@@ -2406,19 +2354,13 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
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
@@ -2445,14 +2387,14 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 	int index = 0, ret = -EINVAL;
 	const char * const *name = names;
 
-	if (opp_table->genpd_virt_devs)
-		return 0;
+	if (!opp_table->required_devs) {
+		dev_err(dev, "Required OPPs not available, can't attach genpd\n");
+		return -EINVAL;
+	}
 
-	opp_table->genpd_virt_devs = kcalloc(opp_table->required_opp_count,
-					     sizeof(*opp_table->genpd_virt_devs),
-					     GFP_KERNEL);
-	if (!opp_table->genpd_virt_devs)
-		return -ENOMEM;
+	/* Checking only the first one is enough ? */
+	if (opp_table->required_devs[0])
+		return 0;
 
 	while (*name) {
 		if (index >= opp_table->required_opp_count) {
@@ -2468,13 +2410,25 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
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
 
@@ -2484,10 +2438,42 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 
 }
 
+static int _opp_set_required_devs(struct opp_table *opp_table,
+				  struct device *dev,
+				  struct device **required_devs)
+{
+	int i;
+
+	if (!opp_table->required_devs) {
+		dev_err(dev, "Required OPPs not available, can't set required devs\n");
+		return -EINVAL;
+	}
+
+	/* Another device that shares the OPP table has set the required devs ? */
+	if (opp_table->required_devs[0])
+		return 0;
+
+	for (i = 0; i < opp_table->required_opp_count; i++)
+		opp_table->required_devs[i] = required_devs[i];
+
+	return 0;
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
@@ -2601,12 +2587,22 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
 
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
+		ret = _opp_set_required_devs(opp_table, dev,
+					     config->required_devs);
+		if (ret)
+			goto err;
+
+		data->flags |= OPP_CONFIG_REQUIRED_DEVS;
 	}
 
 	ret = xa_alloc(&opp_configs, &id, data, XA_LIMIT(1, INT_MAX),
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 4cdeeab5ceee..5a7e294e56b7 100644
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
@@ -332,9 +331,14 @@ static int _link_required_opps(struct dev_pm_opp *opp, struct opp_table *opp_tab
 	 *
 	 * Just update the `level` with the right value, which
 	 * dev_pm_opp_set_opp() will take care of in the normal path itself.
+	 *
+	 * There is another case though, where a genpd's OPP table has
+	 * required-opps set to a parent genpd. The OPP core expects the user to
+	 * set the respective required `struct device` pointer via
+	 * dev_pm_opp_set_config().
 	 */
 	if (required_table->is_genpd && opp_table->required_opp_count == 1 &&
-	    !opp_table->genpd_virt_devs) {
+	    !opp_table->required_devs[0]) {
 		if (!WARN_ON(opp->level != OPP_LEVEL_UNSET))
 			opp->level = opp->required_opps[0]->level;
 	}
@@ -447,7 +451,6 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
 
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
index af53101a1383..81dff7facdc9 100644
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
 
 #define OPP_LEVEL_UNSET			U32_MAX
-- 
2.31.1.272.g89b43f80a514

