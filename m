Return-Path: <linux-kernel+bounces-47179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F3A844A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C825B284A80
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AFC39AD7;
	Wed, 31 Jan 2024 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="JFx7hBtw"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3239856;
	Wed, 31 Jan 2024 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737111; cv=none; b=fZ0WfwEQgjCPRRcL7kNjYo4pfs05QOkweqmFZq3ifD56vFH9S6D9KcshTd5V4UA5C8uq3hALh4S70txZ4HKucTSmqC1ML8tUZUf73L51LgB4YimQtX1scvvnDtyYbDXzGnrFAGh7/a7v7RuUPNmJLl0QPeLGZ4s9ERm8zQE1nUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737111; c=relaxed/simple;
	bh=HQ6gKRe0xRL58jdYZkkO6uFLtLKXC0B6nYjSAio34pE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OxJKR4TFkOICAoicMKlG6MWAho4GA1kx1KZYpGg7yM1jPbPhxqg4MJf2aWVMajpQQpmt2tsSoLv5Z5U6jWuBqRmjtVsLOrzlcOkv3/8trQkpJOY3XdBOSAPsOq5+wZBwt7GV54NgcLHgdbDCbvFq81hfpbrDF03+GmCp2SOnPZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=JFx7hBtw; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fQ8IQFtMKOI8ZFbk+vJFnfeMBCxeLoLxyONdb3rUnWw=;
  b=JFx7hBtwzlQBB6D4twAzVtg1izXOnF7/t2YNG4WHDzJ48l9/nOhXTXKX
   YVW/MOHNnotXc5t2nQkNS/iVpT0NQwJ0H+f9efB3JTwQCjc7d7H07yRAb
   4A631UuMOyTH6tj/1r52DC9n8EiZSSpq4rXlBSKVQqBRN0cv5x4VJIqp9
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,233,1701126000"; 
   d="scan'208";a="78404330"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 22:38:21 +0100
Date: Wed, 31 Jan 2024 22:38:21 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
cc: Julia Lawall <julia.lawall@inria.fr>, Jonathan Cameron <jic23@kernel.org>, 
    linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, 
    Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    Sumera Priyadarsini <sylphrenadin@gmail.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    linux-acpi@vger.kernel.org, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    =?ISO-8859-15?Q?Nuno_S=E1?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH 0/5] of: automate of_node_put() - new approach to
 loops.
In-Reply-To: <20240130093854.00000acc@Huawei.com>
Message-ID: <alpine.DEB.2.22.394.2401312234250.3245@hadrien>
References: <20240128160542.178315-1-jic23@kernel.org> <alpine.DEB.2.22.394.2401281903550.3119@hadrien> <20240129114218.00003c34@Huawei.com> <alpine.DEB.2.22.394.2401291455430.8649@hadrien> <20240129195227.3c3adae1@jic23-huawei> <alpine.DEB.2.22.394.2401292120260.32795@hadrien>
 <20240130093854.00000acc@Huawei.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Here are some loop cases.  The semantic patch is as follows:

#spatch --allow-inconsistent-paths

@@
expression node;
identifier child;
symbol drop_me;
iterator name for_each_child_of_node;
@@

for_each_child_of_node(node,child) {
  ...
+ of_node_put(drop_me, child);
}

@@
expression node;
identifier child;
symbol drop_me;
iterator name for_each_child_of_node, for_each_child_of_node_scoped;
identifier L;
@@

- struct device_node *child;
 ... when != child
-for_each_child_of_node
+for_each_child_of_node_scoped
  (node,child) {
   ... when strict
(
-   {
-   of_node_put(child);
    return ...;
-   }
|
-   {
-   of_node_put(child);
    goto L;
-   }
|
-   {
-   of_node_put(child);
    break;
-   }
|
    continue;
|
-   of_node_put(child);
    return ...;
|
-   of_node_put(child);
    break;
|
-  of_node_put(drop_me, child);
)
}
 ... when != child

@@
expression child;
@@

- of_node_put(drop_me, child);

-------------------------------

This is quite conservative, in that it requires the only use of the child
variable to be in a single for_each_child_of_node loop at top level.

The drop_me thing is a hack to be able to refer to the bottom of the loop
in the same way as of_node_puts in front of returns etc are referenced.

This works fine when multiple device_node variables are declared at once.

The result is below.

julia

diff -u -p a/drivers/of/unittest.c b/drivers/of/unittest.c
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2789,7 +2789,7 @@ static int unittest_i2c_mux_probe(struct
 	int i, nchans;
 	struct device *dev = &client->dev;
 	struct i2c_adapter *adap = client->adapter;
-	struct device_node *np = client->dev.of_node, *child;
+	struct device_node *np = client->dev.of_node;
 	struct i2c_mux_core *muxc;
 	u32 reg, max_reg;

@@ -2801,7 +2801,7 @@ static int unittest_i2c_mux_probe(struct
 	}

 	max_reg = (u32)-1;
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (of_property_read_u32(child, "reg", &reg))
 			continue;
 		if (max_reg == (u32)-1 || reg > max_reg)
diff -u -p a/drivers/mtd/devices/spear_smi.c b/drivers/mtd/devices/spear_smi.c
--- a/drivers/mtd/devices/spear_smi.c
+++ b/drivers/mtd/devices/spear_smi.c
@@ -793,7 +793,6 @@ static int spear_smi_probe_config_dt(str
 				     struct device_node *np)
 {
 	struct spear_smi_plat_data *pdata = dev_get_platdata(&pdev->dev);
-	struct device_node *pp;
 	const __be32 *addr;
 	u32 val;
 	int len;
@@ -812,7 +811,7 @@ static int spear_smi_probe_config_dt(str
 		return -ENOMEM;

 	/* Fill structs for each subnode (flash device) */
-	for_each_child_of_node(np, pp) {
+	for_each_child_of_node_scoped(np, pp) {
 		pdata->np[i] = pp;

 		/* Read base-addr and size from DT */
diff -u -p a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -137,7 +137,6 @@ static const struct of_device_id psci_of
 static int psci_cpuidle_domain_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *node;
 	bool use_osi = psci_has_osi_support();
 	int ret = 0, pd_count = 0;

@@ -148,15 +147,13 @@ static int psci_cpuidle_domain_probe(str
 	 * Parse child nodes for the "#power-domain-cells" property and
 	 * initialize a genpd/genpd-of-provider pair when it's found.
 	 */
-	for_each_child_of_node(np, node) {
+	for_each_child_of_node_scoped(np, node) {
 		if (!of_property_present(node, "#power-domain-cells"))
 			continue;

 		ret = psci_pd_init(node, use_osi);
-		if (ret) {
-			of_node_put(node);
+		if (ret)
 			goto exit;
-		}

 		pd_count++;
 	}
diff -u -p a/drivers/pinctrl/renesas/pinctrl.c b/drivers/pinctrl/renesas/pinctrl.c
--- a/drivers/pinctrl/renesas/pinctrl.c
+++ b/drivers/pinctrl/renesas/pinctrl.c
@@ -241,7 +241,6 @@ static int sh_pfc_dt_node_to_map(struct
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 	struct device *dev = pmx->pfc->dev;
-	struct device_node *child;
 	unsigned int index;
 	int ret;

@@ -249,13 +248,11 @@ static int sh_pfc_dt_node_to_map(struct
 	*num_maps = 0;
 	index = 0;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = sh_pfc_dt_subnode_to_map(pctldev, child, map, num_maps,
 					       &index);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			goto done;
-		}
 	}

 	/* If no mapping has been found in child nodes try the config node. */
diff -u -p a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -2715,19 +2715,16 @@ static int lm90_parse_dt_channel_info(st
 				      struct lm90_data *data)
 {
 	int err;
-	struct device_node *child;
 	struct device *dev = &client->dev;
 	const struct device_node *np = dev->of_node;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (strcmp(child->name, "channel"))
 			continue;

 		err = lm90_probe_channel_from_dt(client, child, data);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}
 	}

 	return 0;
diff -u -p a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -410,7 +410,6 @@ static int cmp_timings(const void *_a, c
 static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
 					  struct device_node *node)
 {
-	struct device_node *child;
 	struct emc_timing *timing;
 	int child_count;
 	int err;
@@ -428,15 +427,13 @@ static int tegra_emc_load_timings_from_d

 	timing = emc->timings;

-	for_each_child_of_node(node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		if (of_node_name_eq(child, "lpddr2"))
 			continue;

 		err = load_one_timing_from_dt(emc, timing++, child);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}

 		emc->num_timings++;
 	}
diff -u -p a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -895,7 +895,7 @@ static int smu_i2c_xfer(struct pmac_i2c_

 static void __init smu_i2c_probe(void)
 {
-	struct device_node *controller, *busnode;
+	struct device_node *controller;
 	struct pmac_i2c_bus *bus;
 	const u32 *reg;
 	int sz;
@@ -915,7 +915,7 @@ static void __init smu_i2c_probe(void)
 	 * type as older device trees mix i2c busses and other things
 	 * at the same level
 	 */
-	for_each_child_of_node(controller, busnode) {
+	for_each_child_of_node_scoped(controller, busnode) {
 		if (!of_node_is_type(busnode, "i2c") &&
 		    !of_node_is_type(busnode, "i2c-bus"))
 			continue;
@@ -925,10 +925,8 @@ static void __init smu_i2c_probe(void)

 		sz = sizeof(struct pmac_i2c_bus) + sizeof(struct smu_i2c_cmd);
 		bus = kzalloc(sz, GFP_KERNEL);
-		if (bus == NULL) {
-			of_node_put(busnode);
+		if (bus == NULL)
 			return;
-		}

 		bus->controller = controller;
 		bus->busnode = of_node_get(busnode);
diff -u -p a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -297,7 +297,7 @@ static int process_scmi_regulator_of_nod
 static int scmi_regulator_probe(struct scmi_device *sdev)
 {
 	int d, ret, num_doms;
-	struct device_node *np, *child;
+	struct device_node *np;
 	const struct scmi_handle *handle = sdev->handle;
 	struct scmi_regulator_info *rinfo;
 	struct scmi_protocol_handle *ph;
@@ -341,13 +341,11 @@ static int scmi_regulator_probe(struct s
 	 */
 	of_node_get(handle->dev->of_node);
 	np = of_find_node_by_name(handle->dev->of_node, "regulators");
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = process_scmi_regulator_of_node(sdev, ph, child, rinfo);
 		/* abort on any mem issue */
-		if (ret == -ENOMEM) {
-			of_node_put(child);
+		if (ret == -ENOMEM)
 			return ret;
-		}
 	}
 	of_node_put(np);
 	/*
diff -u -p a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -244,7 +244,7 @@ samsung_keypad_parse_dt(struct device *d
 	struct samsung_keypad_platdata *pdata;
 	struct matrix_keymap_data *keymap_data;
 	uint32_t *keymap, num_rows = 0, num_cols = 0;
-	struct device_node *np = dev->of_node, *key_np;
+	struct device_node *np = dev->of_node;
 	unsigned int key_count;

 	if (!np) {
@@ -283,7 +283,7 @@ samsung_keypad_parse_dt(struct device *d
 	}
 	keymap_data->keymap = keymap;

-	for_each_child_of_node(np, key_np) {
+	for_each_child_of_node_scoped(np, key_np) {
 		u32 row, col, key_code;
 		of_property_read_u32(key_np, "keypad,row", &row);
 		of_property_read_u32(key_np, "keypad,column", &col);
diff -u -p a/drivers/crypto/nx/nx-common-powernv.c b/drivers/crypto/nx/nx-common-powernv.c
--- a/drivers/crypto/nx/nx-common-powernv.c
+++ b/drivers/crypto/nx/nx-common-powernv.c
@@ -907,7 +907,6 @@ static int __init nx_powernv_probe_vas(s
 {
 	int chip_id, vasid, ret = 0;
 	int ct_842 = 0, ct_gzip = 0;
-	struct device_node *dn;

 	chip_id = of_get_ibm_chip_id(pn);
 	if (chip_id < 0) {
@@ -921,7 +920,7 @@ static int __init nx_powernv_probe_vas(s
 		return -EINVAL;
 	}

-	for_each_child_of_node(pn, dn) {
+	for_each_child_of_node_scoped(pn, dn) {
 		ret = find_nx_device_tree(dn, chip_id, vasid, NX_CT_842,
 					"ibm,p9-nx-842", &ct_842);

@@ -929,10 +928,8 @@ static int __init nx_powernv_probe_vas(s
 			ret = find_nx_device_tree(dn, chip_id, vasid,
 				NX_CT_GZIP, "ibm,p9-nx-gzip", &ct_gzip);

-		if (ret) {
-			of_node_put(dn);
+		if (ret)
 			return ret;
-		}
 	}

 	if (!ct_842 || !ct_gzip) {
diff -u -p a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1271,7 +1271,6 @@ static int st_pctl_parse_functions(struc
 			struct st_pinctrl *info, u32 index, int *grp_index)
 {
 	struct device *dev = info->dev;
-	struct device_node *child;
 	struct st_pmx_func *func;
 	struct st_pctl_group *grp;
 	int ret, i;
@@ -1286,15 +1285,13 @@ static int st_pctl_parse_functions(struc
 		return -ENOMEM;

 	i = 0;
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		func->groups[i] = child->name;
 		grp = &info->groups[*grp_index];
 		*grp_index += 1;
 		ret = st_pctl_dt_parse_groups(child, grp, info, i++);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}
 	dev_info(dev, "Function[%d\t name:%s,\tgroups:%d]\n", index, func->name, func->ngroups);

diff -u -p a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1230,9 +1230,8 @@ static int qcom_slim_ngd_power_up(struct
 static void qcom_slim_ngd_notify_slaves(struct qcom_slim_ngd_ctrl *ctrl)
 {
 	struct slim_device *sbdev;
-	struct device_node *node;

-	for_each_child_of_node(ctrl->ngd->pdev->dev.of_node, node) {
+	for_each_child_of_node_scoped(ctrl->ngd->pdev->dev.of_node, node) {
 		sbdev = of_slim_get_device(&ctrl->ctrl, node);
 		if (!sbdev)
 			continue;
diff -u -p a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -154,7 +154,6 @@ static const struct of_device_id cell_bu
 static int __init cell_publish_devices(void)
 {
 	struct device_node *root = of_find_node_by_path("/");
-	struct device_node *np;
 	int node;

 	/* Publish OF platform devices for southbridge IOs */
@@ -163,7 +162,7 @@ static int __init cell_publish_devices(v
 	/* On spider based blades, we need to manually create the OF
 	 * platform devices for the PCI host bridges
 	 */
-	for_each_child_of_node(root, np) {
+	for_each_child_of_node_scoped(root, np) {
 		if (!of_node_is_type(np, "pci") && !of_node_is_type(np, "pciex"))
 			continue;
 		of_platform_device_create(np, NULL, NULL);
diff -u -p a/drivers/of/platform.c b/drivers/of/platform.c
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -336,7 +336,6 @@ static int of_platform_bus_create(struct
 				  struct device *parent, bool strict)
 {
 	const struct of_dev_auxdata *auxdata;
-	struct device_node *child;
 	struct platform_device *dev;
 	const char *bus_id = NULL;
 	void *platform_data = NULL;
@@ -380,13 +379,11 @@ static int of_platform_bus_create(struct
 	if (!dev || !of_match_node(matches, bus))
 		return 0;

-	for_each_child_of_node(bus, child) {
+	for_each_child_of_node_scoped(bus, child) {
 		pr_debug("   create child: %pOF\n", child);
 		rc = of_platform_bus_create(child, matches, lookup, &dev->dev, strict);
-		if (rc) {
-			of_node_put(child);
+		if (rc)
 			break;
-		}
 	}
 	of_node_set_flag(bus, OF_POPULATED_BUS);
 	return rc;
@@ -457,7 +454,6 @@ int of_platform_populate(struct device_n
 			const struct of_dev_auxdata *lookup,
 			struct device *parent)
 {
-	struct device_node *child;
 	int rc = 0;

 	root = root ? of_node_get(root) : of_find_node_by_path("/");
@@ -468,12 +464,10 @@ int of_platform_populate(struct device_n
 	pr_debug(" starting at: %pOF\n", root);

 	device_links_supplier_sync_state_pause();
-	for_each_child_of_node(root, child) {
+	for_each_child_of_node_scoped(root, child) {
 		rc = of_platform_bus_create(child, matches, lookup, parent, true);
-		if (rc) {
-			of_node_put(child);
+		if (rc)
 			break;
-		}
 	}
 	device_links_supplier_sync_state_resume();

diff -u -p a/drivers/cpuidle/dt_idle_genpd.c b/drivers/cpuidle/dt_idle_genpd.c
--- a/drivers/cpuidle/dt_idle_genpd.c
+++ b/drivers/cpuidle/dt_idle_genpd.c
@@ -130,11 +130,10 @@ out:

 int dt_idle_pd_init_topology(struct device_node *np)
 {
-	struct device_node *node;
 	struct of_phandle_args child, parent;
 	int ret;

-	for_each_child_of_node(np, node) {
+	for_each_child_of_node_scoped(np, node) {
 		if (of_parse_phandle_with_args(node, "power-domains",
 					"#power-domain-cells", 0, &parent))
 			continue;
@@ -143,10 +142,8 @@ int dt_idle_pd_init_topology(struct devi
 		child.args_count = 0;
 		ret = of_genpd_add_subdomain(&parent, &child);
 		of_node_put(parent.np);
-		if (ret) {
-			of_node_put(node);
+		if (ret)
 			return ret;
-		}
 	}

 	return 0;
@@ -154,11 +151,10 @@ int dt_idle_pd_init_topology(struct devi

 int dt_idle_pd_remove_topology(struct device_node *np)
 {
-	struct device_node *node;
 	struct of_phandle_args child, parent;
 	int ret;

-	for_each_child_of_node(np, node) {
+	for_each_child_of_node_scoped(np, node) {
 		if (of_parse_phandle_with_args(node, "power-domains",
 					"#power-domain-cells", 0, &parent))
 			continue;
@@ -167,10 +163,8 @@ int dt_idle_pd_remove_topology(struct de
 		child.args_count = 0;
 		ret = of_genpd_remove_subdomain(&parent, &child);
 		of_node_put(parent.np);
-		if (ret) {
-			of_node_put(node);
+		if (ret)
 			return ret;
-		}
 	}

 	return 0;
diff -u -p a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -221,7 +221,6 @@ static int axg_card_parse_codecs_masks(s
 				       struct axg_dai_link_tdm_data *be)
 {
 	struct axg_dai_link_tdm_mask *codec_mask;
-	struct device_node *np;

 	codec_mask = devm_kcalloc(card->dev, link->num_codecs,
 				  sizeof(*codec_mask), GFP_KERNEL);
@@ -230,7 +229,7 @@ static int axg_card_parse_codecs_masks(s

 	be->codec_masks = codec_mask;

-	for_each_child_of_node(node, np) {
+	for_each_child_of_node_scoped(node, np) {
 		snd_soc_of_get_slot_mask(np, "dai-tdm-slot-rx-mask",
 					 &codec_mask->rx);
 		snd_soc_of_get_slot_mask(np, "dai-tdm-slot-tx-mask",
diff -u -p a/drivers/mtd/nand/raw/renesas-nand-controller.c b/drivers/mtd/nand/raw/renesas-nand-controller.c
--- a/drivers/mtd/nand/raw/renesas-nand-controller.c
+++ b/drivers/mtd/nand/raw/renesas-nand-controller.c
@@ -1297,15 +1297,12 @@ static void rnandc_chips_cleanup(struct

 static int rnandc_chips_init(struct rnandc *rnandc)
 {
-	struct device_node *np;
 	int ret;

-	for_each_child_of_node(rnandc->dev->of_node, np) {
+	for_each_child_of_node_scoped(rnandc->dev->of_node, np) {
 		ret = rnandc_chip_init(rnandc, np);
-		if (ret) {
-			of_node_put(np);
+		if (ret)
 			goto cleanup_chips;
-		}
 	}

 	return 0;
diff -u -p a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -330,7 +330,6 @@ tc3589x_of_probe(struct device *dev, enu
 {
 	struct device_node *np = dev->of_node;
 	struct tc3589x_platform_data *pdata;
-	struct device_node *child;
 	const struct of_device_id *of_id;

 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
@@ -342,7 +341,7 @@ tc3589x_of_probe(struct device *dev, enu
 		return ERR_PTR(-ENODEV);
 	*version = (uintptr_t) of_id->data;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (of_device_is_compatible(child, "toshiba,tc3589x-gpio"))
 			pdata->block |= TC3589x_BLOCK_GPIO;
 		if (of_device_is_compatible(child, "toshiba,tc3589x-keypad"))
diff -u -p a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -979,7 +979,6 @@ static int emc_check_mc_timings(struct t
 static int emc_load_timings_from_dt(struct tegra_emc *emc,
 				    struct device_node *node)
 {
-	struct device_node *child;
 	struct emc_timing *timing;
 	int child_count;
 	int err;
@@ -998,12 +997,10 @@ static int emc_load_timings_from_dt(stru
 	emc->num_timings = child_count;
 	timing = emc->timings;

-	for_each_child_of_node(node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		err = load_one_timing_from_dt(emc, timing++, child);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}
 	}

 	sort(emc->timings, emc->num_timings, sizeof(*timing), cmp_timings,
diff -u -p a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -665,7 +665,6 @@ static int stm32_adc_probe_identificatio
 					  struct stm32_adc_priv *priv)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *child;
 	const char *compat;
 	int ret, count = 0;
 	u32 id, val;
@@ -680,7 +679,7 @@ static int stm32_adc_probe_identificatio
 		return -EINVAL;
 	}

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = of_property_read_string(child, "compatible", &compat);
 		if (ret)
 			continue;
diff -u -p a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -3054,7 +3054,7 @@ static int xilinx_dma_probe(struct platf
 					= axivdma_clk_init;
 	struct device_node *node = pdev->dev.of_node;
 	struct xilinx_dma_device *xdev;
-	struct device_node *child, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	u32 num_frames, addr_width, len_width;
 	int i, err;

@@ -3189,12 +3189,10 @@ static int xilinx_dma_probe(struct platf
 	platform_set_drvdata(pdev, xdev);

 	/* Initialize the channels */
-	for_each_child_of_node(node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		err = xilinx_dma_child_probe(xdev, child);
-		if (err < 0) {
-			of_node_put(child);
+		if (err < 0)
 			goto error;
-		}
 	}

 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
diff -u -p a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -478,17 +478,14 @@ void rsnd_parse_connect_ssiu(struct rsnd

 	/* use rcar_sound,ssiu if exist */
 	if (node) {
-		struct device_node *np;
 		int i = 0;

-		for_each_child_of_node(node, np) {
+		for_each_child_of_node_scoped(node, np) {
 			struct rsnd_mod *mod;

 			i = rsnd_node_fixed_index(dev, np, SSIU_NAME, i);
-			if (i < 0) {
-				of_node_put(np);
+			if (i < 0)
 				break;
-			}

 			mod = rsnd_ssiu_mod_get(priv, i);

diff -u -p a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
--- a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
@@ -238,20 +238,17 @@ static int tegra_xusb_padctl_dt_node_to_
 {
 	struct tegra_xusb_padctl *padctl = pinctrl_dev_get_drvdata(pinctrl);
 	unsigned int reserved_maps = 0;
-	struct device_node *np;
 	int err;

 	*num_maps = 0;
 	*maps = NULL;

-	for_each_child_of_node(parent, np) {
+	for_each_child_of_node_scoped(parent, np) {
 		err = tegra_xusb_padctl_parse_subnode(padctl, np, maps,
 						      &reserved_maps,
 						      num_maps);
-		if (err < 0) {
-			of_node_put(np);
+		if (err < 0)
 			return err;
-		}
 	}

 	return 0;
diff -u -p a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -76,7 +76,7 @@ struct rockchip_rgb *rockchip_rgb_init(s
 {
 	struct rockchip_rgb *rgb;
 	struct drm_encoder *encoder;
-	struct device_node *port, *endpoint;
+	struct device_node *port;
 	u32 endpoint_id;
 	int ret = 0, child_count = 0;
 	struct drm_panel *panel;
@@ -94,7 +94,7 @@ struct rockchip_rgb *rockchip_rgb_init(s
 	if (!port)
 		return ERR_PTR(-EINVAL);

-	for_each_child_of_node(port, endpoint) {
+	for_each_child_of_node_scoped(port, endpoint) {
 		if (of_property_read_u32(endpoint, "reg", &endpoint_id))
 			endpoint_id = 0;

@@ -105,10 +105,8 @@ struct rockchip_rgb *rockchip_rgb_init(s
 		child_count++;
 		ret = drm_of_find_panel_or_bridge(dev->of_node, video_port,
 						  endpoint_id, &panel, &bridge);
-		if (!ret) {
-			of_node_put(endpoint);
+		if (!ret)
 			break;
-		}
 	}

 	of_node_put(port);
diff -u -p a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -544,7 +544,6 @@ static void pci_of_scan_bus(struct pci_p
 			    struct device_node *node,
 			    struct pci_bus *bus)
 {
-	struct device_node *child;
 	const u32 *reg;
 	int reglen, devfn, prev_devfn;
 	struct pci_dev *dev;
@@ -554,7 +553,7 @@ static void pci_of_scan_bus(struct pci_p
 			 node, bus->number);

 	prev_devfn = -1;
-	for_each_child_of_node(node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		if (ofpci_verbose)
 			pci_info(bus, "  * %pOF\n", child);
 		reg = of_get_property(child, "reg", &reglen);
diff -u -p a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1437,7 +1437,7 @@ static int tegra_powergate_init(struct t
 				struct device_node *parent)
 {
 	struct of_phandle_args child_args, parent_args;
-	struct device_node *np, *child;
+	struct device_node *np;
 	int err = 0;

 	/*
@@ -1456,12 +1456,10 @@ static int tegra_powergate_init(struct t
 	if (!np)
 		return 0;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		err = tegra_powergate_add(pmc, child);
-		if (err < 0) {
-			of_node_put(child);
+		if (err < 0)
 			break;
-		}

 		if (of_parse_phandle_with_args(child, "power-domains",
 					       "#power-domain-cells",
@@ -1473,10 +1471,8 @@ static int tegra_powergate_init(struct t

 		err = of_genpd_add_subdomain(&parent_args, &child_args);
 		of_node_put(parent_args.np);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			break;
-		}
 	}

 	of_node_put(np);
@@ -1503,13 +1499,13 @@ static void tegra_powergate_remove(struc
 static void tegra_powergate_remove_all(struct device_node *parent)
 {
 	struct generic_pm_domain *genpd;
-	struct device_node *np, *child;
+	struct device_node *np;

 	np = of_get_child_by_name(parent, "powergates");
 	if (!np)
 		return;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		of_genpd_del_provider(child);

 		genpd = of_genpd_remove_last(child);
diff -u -p a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -80,7 +80,7 @@ static int i2c_mux_reg_probe_dt(struct r
 				struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *adapter_np, *child;
+	struct device_node *adapter_np;
 	struct i2c_adapter *adapter;
 	struct resource res;
 	unsigned *values;
@@ -126,7 +126,7 @@ static int i2c_mux_reg_probe_dt(struct r
 	if (!values)
 		return -ENOMEM;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		of_property_read_u32(child, "reg", values + i);
 		i++;
 	}
diff -u -p a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -410,7 +410,6 @@ static int ahci_platform_get_regulator(s
 static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
 				      struct device *dev)
 {
-	struct device_node *child;
 	u32 port;

 	if (!of_property_read_u32(dev->of_node, "hba-cap", &hpriv->saved_cap))
@@ -419,14 +418,12 @@ static int ahci_platform_get_firmware(st
 	of_property_read_u32(dev->of_node,
 			     "ports-implemented", &hpriv->saved_port_map);

-	for_each_child_of_node(dev->of_node, child) {
+	for_each_child_of_node_scoped(dev->of_node, child) {
 		if (!of_device_is_available(child))
 			continue;

-		if (of_property_read_u32(child, "reg", &port)) {
-			of_node_put(child);
+		if (of_property_read_u32(child, "reg", &port))
 			return -EINVAL;
-		}

 		if (!of_property_read_u32(child, "hba-port-cap", &hpriv->saved_port_cap[port]))
 			hpriv->saved_port_cap[port] &= PORT_CMD_CAP;
diff -u -p a/drivers/power/supply/lp8727_charger.c b/drivers/power/supply/lp8727_charger.c
--- a/drivers/power/supply/lp8727_charger.c
+++ b/drivers/power/supply/lp8727_charger.c
@@ -507,7 +507,6 @@ out:
 static struct lp8727_platform_data *lp8727_parse_dt(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
-	struct device_node *child;
 	struct lp8727_platform_data *pdata;
 	const char *type;

@@ -521,7 +520,7 @@ static struct lp8727_platform_data *lp87
 	if (of_get_child_count(np) == 0)
 		return pdata;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		of_property_read_string(child, "charger-type", &type);

 		if (!strcmp(type, "ac"))
diff -u -p a/drivers/pinctrl/freescale/pinctrl-imx1-core.c b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
--- a/drivers/pinctrl/freescale/pinctrl-imx1-core.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx1-core.c
@@ -508,7 +508,6 @@ static int imx1_pinctrl_parse_functions(
 				       struct imx1_pinctrl_soc_info *info,
 				       u32 index)
 {
-	struct device_node *child;
 	struct imx1_pmx_func *func;
 	struct imx1_pin_group *grp;
 	int ret;
@@ -531,14 +530,12 @@ static int imx1_pinctrl_parse_functions(
 	if (!func->groups)
 		return -ENOMEM;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		func->groups[i] = child->name;
 		grp = &info->groups[grp_index++];
 		ret = imx1_pinctrl_parse_groups(child, grp, info, i++);
-		if (ret == -ENOMEM) {
-			of_node_put(child);
+		if (ret == -ENOMEM)
 			return ret;
-		}
 	}

 	return 0;
diff -u -p a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -133,9 +133,7 @@ EXPORT_SYMBOL_GPL(pnv_php_find_slot);
  */
 static void pnv_php_rmv_pdns(struct device_node *dn)
 {
-	struct device_node *child;
-
-	for_each_child_of_node(dn, child) {
+	for_each_child_of_node_scoped(dn, child) {
 		pnv_php_rmv_pdns(child);

 		pci_remove_device_node_info(child);
@@ -214,21 +212,16 @@ static void pnv_php_reverse_nodes(struct
 static int pnv_php_populate_changeset(struct of_changeset *ocs,
 				      struct device_node *dn)
 {
-	struct device_node *child;
 	int ret = 0;

-	for_each_child_of_node(dn, child) {
+	for_each_child_of_node_scoped(dn, child) {
 		ret = of_changeset_attach_node(ocs, child);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			break;
-		}

 		ret = pnv_php_populate_changeset(ocs, child);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			break;
-		}
 	}

 	return ret;
@@ -974,13 +967,11 @@ free_slot:

 static void pnv_php_register(struct device_node *dn)
 {
-	struct device_node *child;
-
 	/*
 	 * The parent slots should be registered before their
 	 * child slots.
 	 */
-	for_each_child_of_node(dn, child) {
+	for_each_child_of_node_scoped(dn, child) {
 		pnv_php_register_one(child);
 		pnv_php_register(child);
 	}
@@ -1002,10 +993,8 @@ static void pnv_php_unregister_one(struc

 static void pnv_php_unregister(struct device_node *dn)
 {
-	struct device_node *child;
-
 	/* The child slots should go before their parent slots */
-	for_each_child_of_node(dn, child) {
+	for_each_child_of_node_scoped(dn, child) {
 		pnv_php_unregister(child);
 		pnv_php_unregister_one(child);
 	}
diff -u -p a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -410,18 +410,15 @@ static int tmp421_probe_from_dt(struct i
 {
 	struct device *dev = &client->dev;
 	const struct device_node *np = dev->of_node;
-	struct device_node *child;
 	int err;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (strcmp(child->name, "channel"))
 			continue;

 		err = tmp421_probe_child_from_dt(client, child, data);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}
 	}

 	return 0;
diff -u -p a/drivers/media/platform/samsung/exynos4-is/media-dev.c b/drivers/media/platform/samsung/exynos4-is/media-dev.c
--- a/drivers/media/platform/samsung/exynos4-is/media-dev.c
+++ b/drivers/media/platform/samsung/exynos4-is/media-dev.c
@@ -482,15 +482,12 @@ static int fimc_md_parse_one_endpoint(st
 static int fimc_md_parse_port_node(struct fimc_md *fmd,
 				   struct device_node *port)
 {
-	struct device_node *ep;
 	int ret;

-	for_each_child_of_node(port, ep) {
+	for_each_child_of_node_scoped(port, ep) {
 		ret = fimc_md_parse_one_endpoint(fmd, ep);
-		if (ret < 0) {
-			of_node_put(ep);
+		if (ret < 0)
 			return ret;
-		}
 	}

 	return 0;
diff -u -p a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2979,9 +2979,7 @@ static const struct of_device_id rockchi
 static void rockchip_pinctrl_child_count(struct rockchip_pinctrl *info,
 						struct device_node *np)
 {
-	struct device_node *child;
-
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (of_match_node(rockchip_bank_match, child))
 			continue;

@@ -3057,7 +3055,6 @@ static int rockchip_pinctrl_parse_functi
 						u32 index)
 {
 	struct device *dev = info->dev;
-	struct device_node *child;
 	struct rockchip_pmx_func *func;
 	struct rockchip_pin_group *grp;
 	int ret;
@@ -3078,14 +3075,12 @@ static int rockchip_pinctrl_parse_functi
 	if (!func->groups)
 		return -ENOMEM;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		func->groups[i] = child->name;
 		grp = &info->groups[grp_index++];
 		ret = rockchip_pinctrl_parse_groups(child, grp, info, i++);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}

 	return 0;
diff -u -p a/drivers/of/overlay.c b/drivers/of/overlay.c
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -1083,16 +1083,12 @@ EXPORT_SYMBOL_GPL(of_overlay_fdt_apply);
  */
 static int find_node(struct device_node *tree, struct device_node *np)
 {
-	struct device_node *child;
-
 	if (tree == np)
 		return 1;

-	for_each_child_of_node(tree, child) {
-		if (find_node(child, np)) {
-			of_node_put(child);
+	for_each_child_of_node_scoped(tree, child) {
+		if (find_node(child, np))
 			return 1;
-		}
 	}

 	return 0;
diff -u -p a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -450,7 +450,6 @@ static int load_one_timing(struct tegra_

 static int load_timings(struct tegra_mc *mc, struct device_node *node)
 {
-	struct device_node *child;
 	struct tegra_mc_timing *timing;
 	int child_count = of_get_child_count(node);
 	int i = 0, err;
@@ -462,14 +461,12 @@ static int load_timings(struct tegra_mc

 	mc->num_timings = child_count;

-	for_each_child_of_node(node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		timing = &mc->timings[i++];

 		err = load_one_timing(mc, timing, child);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}
 	}

 	return 0;
diff -u -p a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -549,7 +549,7 @@ static int rockchip_lvds_bind(struct dev
 	struct drm_encoder *encoder;
 	struct drm_connector *connector;
 	struct device_node *remote = NULL;
-	struct device_node  *port, *endpoint;
+	struct device_node  *port;
 	int ret = 0, child_count = 0;
 	const char *name;
 	u32 endpoint_id = 0;
@@ -561,15 +561,13 @@ static int rockchip_lvds_bind(struct dev
 			      "can't found port point, please init lvds panel port!\n");
 		return -EINVAL;
 	}
-	for_each_child_of_node(port, endpoint) {
+	for_each_child_of_node_scoped(port, endpoint) {
 		child_count++;
 		of_property_read_u32(endpoint, "reg", &endpoint_id);
 		ret = drm_of_find_panel_or_bridge(dev->of_node, 1, endpoint_id,
 						  &lvds->panel, &lvds->bridge);
-		if (!ret) {
-			of_node_put(endpoint);
+		if (!ret)
 			break;
-		}
 	}
 	if (!child_count) {
 		DRM_DEV_ERROR(dev, "lvds port does not have any children\n");
diff -u -p a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -763,14 +763,10 @@ static struct platform_driver qcom_iommu

 static bool qcom_iommu_has_secure_context(struct qcom_iommu_dev *qcom_iommu)
 {
-	struct device_node *child;
-
-	for_each_child_of_node(qcom_iommu->dev->of_node, child) {
+	for_each_child_of_node_scoped(qcom_iommu->dev->of_node, child) {
 		if (of_device_is_compatible(child, "qcom,msm-iommu-v1-sec") ||
-		    of_device_is_compatible(child, "qcom,msm-iommu-v2-sec")) {
-			of_node_put(child);
+		    of_device_is_compatible(child, "qcom,msm-iommu-v2-sec"))
 			return true;
-		}
 	}

 	return false;
diff -u -p a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -23,7 +23,6 @@
 static int of_find_trip_id(struct device_node *np, struct device_node *trip)
 {
 	struct device_node *trips;
-	struct device_node *t;
 	int i = 0;

 	trips = of_get_child_by_name(np, "trips");
@@ -35,12 +34,10 @@ static int of_find_trip_id(struct device
 	/*
 	 * Find the trip id point associated with the cooling device map
 	 */
-	for_each_child_of_node(trips, t) {
+	for_each_child_of_node_scoped(trips, t) {

-		if (t == trip) {
-			of_node_put(t);
+		if (t == trip)
 			goto out;
-		}
 		i++;
 	}

@@ -388,7 +385,7 @@ static int thermal_of_for_each_cooling_m
 					    int (*action)(struct device_node *, int, int,
 							  struct thermal_zone_device *, struct thermal_cooling_device *))
 {
-	struct device_node *tz_np, *cm_np, *child;
+	struct device_node *tz_np, *cm_np;
 	int ret = 0;

 	tz_np = thermal_of_zone_get_by_name(tz);
@@ -401,12 +398,10 @@ static int thermal_of_for_each_cooling_m
 	if (!cm_np)
 		goto out;

-	for_each_child_of_node(cm_np, child) {
+	for_each_child_of_node_scoped(cm_np, child) {
 		ret = thermal_of_for_each_cooling_device(tz_np, child, tz, cdev, action);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			break;
-		}
 	}

 	of_node_put(cm_np);
diff -u -p a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -992,7 +992,6 @@ static int tegra_emc_load_timings_from_d
 					  struct device_node *node)
 {
 	int child_count = of_get_child_count(node);
-	struct device_node *child;
 	struct emc_timing *timing;
 	unsigned int i = 0;
 	int err;
@@ -1004,14 +1003,12 @@ static int tegra_emc_load_timings_from_d

 	emc->num_timings = child_count;

-	for_each_child_of_node(node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		timing = &emc->timings[i++];

 		err = load_one_timing_from_dt(emc, timing, child);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}
 	}

 	sort(emc->timings, emc->num_timings, sizeof(*timing), cmp_timings,
diff -u -p a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -109,15 +109,12 @@ EXPORT_SYMBOL_GPL(i2c_slave_event);
 bool i2c_detect_slave_mode(struct device *dev)
 {
 	if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {
-		struct device_node *child;
 		u32 reg;

-		for_each_child_of_node(dev->of_node, child) {
+		for_each_child_of_node_scoped(dev->of_node, child) {
 			of_property_read_u32(child, "reg", &reg);
-			if (reg & I2C_OWN_SLAVE_ADDRESS) {
-				of_node_put(child);
+			if (reg & I2C_OWN_SLAVE_ADDRESS)
 				return true;
-			}
 		}
 	} else if (IS_BUILTIN(CONFIG_ACPI) && ACPI_HANDLE(dev)) {
 		dev_dbg(dev, "ACPI slave is not supported yet\n");
diff -u -p a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -813,7 +813,6 @@ static int ina3221_probe_child_from_dt(s
 static int ina3221_probe_from_dt(struct device *dev, struct ina3221_data *ina)
 {
 	const struct device_node *np = dev->of_node;
-	struct device_node *child;
 	int ret;

 	/* Compatible with non-DT platforms */
@@ -822,12 +821,10 @@ static int ina3221_probe_from_dt(struct

 	ina->single_shot = of_property_read_bool(np, "ti,single-shot");

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = ina3221_probe_child_from_dt(dev, child, ina);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}

 	return 0;
diff -u -p a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -395,14 +395,13 @@ static struct pci_dev *of_scan_pci_dev(s
 static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
 			  int rescan_existing)
 {
-	struct device_node *child;
 	struct pci_dev *dev;

 	pr_debug("of_scan_bus(%pOF) bus no %d...\n",
 		 node, bus->number);

 	/* Scan direct children */
-	for_each_child_of_node(node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		dev = of_scan_pci_dev(bus, child);
 		if (!dev)
 			continue;
diff -u -p a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -114,10 +114,9 @@ static int vio_cmo_num_OF_devs(void)
 	 */
 	node_vroot = of_find_node_by_name(NULL, "vdevice");
 	if (node_vroot) {
-		struct device_node *of_node;
 		struct property *prop;

-		for_each_child_of_node(node_vroot, of_node) {
+		for_each_child_of_node_scoped(node_vroot, of_node) {
 			prop = of_find_property(of_node, "ibm,my-dma-window",
 			                       NULL);
 			if (prop)
diff -u -p a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -916,12 +916,11 @@ static int sprd_pinctrl_parse_groups(str

 static unsigned int sprd_pinctrl_get_groups(struct device_node *np)
 {
-	struct device_node *child;
 	unsigned int group_cnt, cnt;

 	group_cnt = of_get_child_count(np);

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		cnt = of_get_child_count(child);
 		if (cnt > 0)
 			group_cnt += cnt;
diff -u -p a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -786,7 +786,6 @@ static int s32_pinctrl_parse_functions(s
 					struct s32_pinctrl_soc_info *info,
 					u32 index)
 {
-	struct device_node *child;
 	struct pinfunction *func;
 	struct s32_pin_group *grp;
 	const char **groups;
@@ -810,14 +809,12 @@ static int s32_pinctrl_parse_functions(s
 	if (!groups)
 		return -ENOMEM;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		groups[i] = child->name;
 		grp = &info->groups[info->grp_index++];
 		ret = s32_pinctrl_parse_groups(child, grp, info);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 		i++;
 	}

diff -u -p a/drivers/of/resolver.c b/drivers/of/resolver.c
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -262,7 +262,7 @@ static int adjust_local_phandle_referenc
  */
 int of_resolve_phandles(struct device_node *overlay)
 {
-	struct device_node *child, *local_fixups, *refnode;
+	struct device_node *local_fixups, *refnode;
 	struct device_node *tree_symbols, *overlay_fixups;
 	struct property *prop;
 	const char *refpath;
@@ -296,7 +296,7 @@ int of_resolve_phandles(struct device_no

 	overlay_fixups = NULL;

-	for_each_child_of_node(overlay, child) {
+	for_each_child_of_node_scoped(overlay, child) {
 		if (of_node_name_eq(child, "__fixups__"))
 			overlay_fixups = child;
 	}
diff -u -p a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2774,7 +2774,6 @@ static void marvell_nand_chips_cleanup(s
 static int marvell_nand_chips_init(struct device *dev, struct marvell_nfc *nfc)
 {
 	struct device_node *np = dev->of_node;
-	struct device_node *nand_np;
 	int max_cs = nfc->caps->max_cs_nb;
 	int nchips;
 	int ret;
@@ -2801,12 +2800,10 @@ static int marvell_nand_chips_init(struc
 		return ret;
 	}

-	for_each_child_of_node(np, nand_np) {
+	for_each_child_of_node_scoped(np, nand_np) {
 		ret = marvell_nand_chip_init(dev, nfc, nand_np);
-		if (ret) {
-			of_node_put(nand_np);
+		if (ret)
 			goto cleanup_chips;
-		}
 	}

 	return 0;
diff -u -p a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -901,7 +901,7 @@ static void aspeed_pwm_tacho_remove(void
 static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np, *child;
+	struct device_node *np;
 	struct aspeed_pwm_tacho_data *priv;
 	void __iomem *regs;
 	struct device *hwmon;
@@ -944,12 +944,10 @@ static int aspeed_pwm_tacho_probe(struct

 	aspeed_create_type(priv);

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = aspeed_create_fan(dev, child, priv);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}

 	priv->groups[0] = &pwm_dev_group;
diff -u -p a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -343,14 +343,13 @@ static int lp855x_parse_dt(struct lp855x
 	rom_length = of_get_child_count(node);
 	if (rom_length > 0) {
 		struct lp855x_rom_data *rom;
-		struct device_node *child;
 		int i = 0;

 		rom = devm_kcalloc(dev, rom_length, sizeof(*rom), GFP_KERNEL);
 		if (!rom)
 			return -ENOMEM;

-		for_each_child_of_node(node, child) {
+		for_each_child_of_node_scoped(node, child) {
 			of_property_read_u8(child, "rom-addr", &rom[i].addr);
 			of_property_read_u8(child, "rom-val", &rom[i].val);
 			i++;
diff -u -p a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -433,7 +433,7 @@ static int populate_attr_groups(struct p
 {
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 	const struct attribute_group **pgroups = pdata->attr_groups;
-	struct device_node *opal, *np;
+	struct device_node *opal;
 	enum sensors type;
 	int ret;

@@ -442,7 +442,7 @@ static int populate_attr_groups(struct p
 		return ret;

 	opal = of_find_node_by_path("/ibm,opal/sensors");
-	for_each_child_of_node(opal, np) {
+	for_each_child_of_node_scoped(opal, np) {
 		const char *label;

 		type = get_sensor_type(np);
diff -u -p a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -1823,7 +1823,6 @@ static int stm32_fmc2_nfc_parse_child(st
 static int stm32_fmc2_nfc_parse_dt(struct stm32_fmc2_nfc *nfc)
 {
 	struct device_node *dn = nfc->dev->of_node;
-	struct device_node *child;
 	int nchips = of_get_child_count(dn);
 	int ret = 0;

@@ -1837,12 +1836,10 @@ static int stm32_fmc2_nfc_parse_dt(struc
 		return -EINVAL;
 	}

-	for_each_child_of_node(dn, child) {
+	for_each_child_of_node_scoped(dn, child) {
 		ret = stm32_fmc2_nfc_parse_child(nfc, child);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			return ret;
-		}
 	}

 	return ret;
diff -u -p a/drivers/hwmon/tmp464.c b/drivers/hwmon/tmp464.c
--- a/drivers/hwmon/tmp464.c
+++ b/drivers/hwmon/tmp464.c
@@ -565,18 +565,15 @@ static int tmp464_probe_child_from_dt(st
 static int tmp464_probe_from_dt(struct device *dev, struct tmp464_data *data)
 {
 	const struct device_node *np = dev->of_node;
-	struct device_node *child;
 	int err;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (strcmp(child->name, "channel"))
 			continue;

 		err = tmp464_probe_child_from_dt(dev, child, data);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}
 	}

 	return 0;
diff -u -p a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/pinctrl/renesas/pinctrl-rzn1.c
--- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
@@ -404,7 +404,6 @@ static int rzn1_dt_node_to_map(struct pi
 			       struct pinctrl_map **map,
 			       unsigned int *num_maps)
 {
-	struct device_node *child;
 	int ret;

 	*map = NULL;
@@ -414,12 +413,10 @@ static int rzn1_dt_node_to_map(struct pi
 	if (ret < 0)
 		return ret;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = rzn1_dt_node_to_map_one(pctldev, child, map, num_maps);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			return ret;
-		}
 	}

 	return 0;
@@ -740,13 +737,12 @@ static int rzn1_pinctrl_parse_groups(str

 static int rzn1_pinctrl_count_function_groups(struct device_node *np)
 {
-	struct device_node *child;
 	int count = 0;

 	if (of_property_count_u32_elems(np, RZN1_PINS_PROP) > 0)
 		count++;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (of_property_count_u32_elems(child, RZN1_PINS_PROP) > 0)
 			count++;
 	}
@@ -760,7 +756,6 @@ static int rzn1_pinctrl_parse_functions(
 {
 	struct rzn1_pmx_func *func;
 	struct rzn1_pin_group *grp;
-	struct device_node *child;
 	unsigned int i = 0;
 	int ret;

@@ -793,15 +788,13 @@ static int rzn1_pinctrl_parse_functions(
 		ipctl->ngroups++;
 	}

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		func->groups[i] = child->name;
 		grp = &ipctl->groups[ipctl->ngroups];
 		grp->func = func->name;
 		ret = rzn1_pinctrl_parse_groups(child, grp, ipctl);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			return ret;
-		}
 		i++;
 		ipctl->ngroups++;
 	}
diff -u -p a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -198,7 +198,6 @@ static int meson_card_add_links(struct s
 {
 	struct meson_card *priv = snd_soc_card_get_drvdata(card);
 	struct device_node *node = card->dev->of_node;
-	struct device_node *np;
 	int num, i, ret;

 	num = of_get_child_count(node);
@@ -212,12 +211,10 @@ static int meson_card_add_links(struct s
 		return ret;

 	i = 0;
-	for_each_child_of_node(node, np) {
+	for_each_child_of_node_scoped(node, np) {
 		ret = priv->match_data->add_link(card, np, &i);
-		if (ret) {
-			of_node_put(np);
+		if (ret)
 			return ret;
-		}

 		i++;
 	}
diff -u -p a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -434,7 +434,6 @@ static int miic_parse_dt(struct device *
 {
 	s8 dt_val[MIIC_MODCTRL_CONF_CONV_NUM];
 	struct device_node *np = dev->of_node;
-	struct device_node *conv;
 	u32 conf;
 	int port;

@@ -443,7 +442,7 @@ static int miic_parse_dt(struct device *
 	if (of_property_read_u32(np, "renesas,miic-switch-portin", &conf) == 0)
 		dt_val[0] = conf;

-	for_each_child_of_node(np, conv) {
+	for_each_child_of_node_scoped(np, conv) {
 		if (of_property_read_u32(conv, "reg", &port))
 			continue;

diff -u -p a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -115,7 +115,6 @@ static int denali_dt_probe(struct platfo
 	struct denali_dt *dt;
 	const struct denali_dt_data *data;
 	struct denali_controller *denali;
-	struct device_node *np;
 	int ret;

 	dt = devm_kzalloc(dev, sizeof(*dt), GFP_KERNEL);
@@ -204,12 +203,10 @@ static int denali_dt_probe(struct platfo
 	if (ret)
 		goto out_assert_rst;

-	for_each_child_of_node(dev->of_node, np) {
+	for_each_child_of_node_scoped(dev->of_node, np) {
 		ret = denali_dt_chip_init(denali, np);
-		if (ret) {
-			of_node_put(np);
+		if (ret)
 			goto out_remove_denali;
-		}
 	}

 	platform_set_drvdata(pdev, dt);
diff -u -p a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1432,15 +1432,12 @@ static int mtk_nfc_nand_chip_init(struct
 static int mtk_nfc_nand_chips_init(struct device *dev, struct mtk_nfc *nfc)
 {
 	struct device_node *np = dev->of_node;
-	struct device_node *nand_np;
 	int ret;

-	for_each_child_of_node(np, nand_np) {
+	for_each_child_of_node_scoped(np, nand_np) {
 		ret = mtk_nfc_nand_chip_init(dev, nfc, nand_np);
-		if (ret) {
-			of_node_put(nand_np);
+		if (ret)
 			return ret;
-		}
 	}

 	return 0;
diff -u -p a/drivers/clk/at91/dt-compat.c b/drivers/clk/at91/dt-compat.c
--- a/drivers/clk/at91/dt-compat.c
+++ b/drivers/clk/at91/dt-compat.c
@@ -129,7 +129,7 @@ static void __init of_sama5d2_clk_genera
 	struct clk_hw *hw;
 	unsigned int num_parents;
 	const char *parent_names[GENERATED_SOURCE_MAX];
-	struct device_node *gcknp, *parent_np;
+	struct device_node *parent_np;
 	struct clk_range range = CLK_RANGE(0, 0);
 	struct regmap *regmap;

@@ -149,7 +149,7 @@ static void __init of_sama5d2_clk_genera
 	if (IS_ERR(regmap))
 		return;

-	for_each_child_of_node(np, gcknp) {
+	for_each_child_of_node_scoped(np, gcknp) {
 		int chg_pid = INT_MIN;

 		if (of_property_read_u32(gcknp, "reg", &id))
@@ -219,7 +219,6 @@ static void __init of_sama5d2_clk_i2s_mu
 	struct regmap *regmap_sfr;
 	u8 bus_id;
 	const char *parent_names[2];
-	struct device_node *i2s_mux_np;
 	struct clk_hw *hw;
 	int ret;

@@ -227,7 +226,7 @@ static void __init of_sama5d2_clk_i2s_mu
 	if (IS_ERR(regmap_sfr))
 		return;

-	for_each_child_of_node(np, i2s_mux_np) {
+	for_each_child_of_node_scoped(np, i2s_mux_np) {
 		if (of_property_read_u8(i2s_mux_np, "reg", &bus_id))
 			continue;

@@ -743,7 +742,7 @@ of_at91_clk_prog_setup(struct device_nod
 	unsigned int num_parents;
 	const char *parent_names[PROG_SOURCE_MAX];
 	const char *name;
-	struct device_node *progclknp, *parent_np;
+	struct device_node *parent_np;
 	struct regmap *regmap;

 	num_parents = of_clk_get_parent_count(np);
@@ -762,7 +761,7 @@ of_at91_clk_prog_setup(struct device_nod
 	if (IS_ERR(regmap))
 		return;

-	for_each_child_of_node(np, progclknp) {
+	for_each_child_of_node_scoped(np, progclknp) {
 		if (of_property_read_u32(progclknp, "reg", &id))
 			continue;

@@ -875,7 +874,7 @@ static void __init of_at91rm9200_clk_sys
 	u32 id;
 	struct clk_hw *hw;
 	const char *name;
-	struct device_node *sysclknp, *parent_np;
+	struct device_node *parent_np;
 	const char *parent_name;
 	struct regmap *regmap;

@@ -889,7 +888,7 @@ static void __init of_at91rm9200_clk_sys
 	if (IS_ERR(regmap))
 		return;

-	for_each_child_of_node(np, sysclknp) {
+	for_each_child_of_node_scoped(np, sysclknp) {
 		unsigned long flags = 0;

 		if (of_property_read_u32(sysclknp, "reg", &id))
diff -u -p a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -497,11 +497,10 @@ void __init pseries_little_endian_except

 static void __init pSeries_discover_phbs(void)
 {
-	struct device_node *node;
 	struct pci_controller *phb;
 	struct device_node *root = of_find_node_by_path("/");

-	for_each_child_of_node(root, node) {
+	for_each_child_of_node_scoped(root, node) {
 		if (!of_node_is_type(node, "pci") &&
 		    !of_node_is_type(node, "pciex"))
 			continue;
diff -u -p a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -1114,7 +1114,6 @@ void rsnd_parse_connect_ssi(struct rsnd_
 	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct device_node *node;
-	struct device_node *np;
 	int i;

 	node = rsnd_ssi_of_node(priv);
@@ -1122,14 +1121,12 @@ void rsnd_parse_connect_ssi(struct rsnd_
 		return;

 	i = 0;
-	for_each_child_of_node(node, np) {
+	for_each_child_of_node_scoped(node, np) {
 		struct rsnd_mod *mod;

 		i = rsnd_node_fixed_index(dev, np, SSI_NAME, i);
-		if (i < 0) {
-			of_node_put(np);
+		if (i < 0)
 			break;
-		}

 		mod = rsnd_ssi_mod_get(priv, i);

diff -u -p a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -308,7 +308,6 @@ static int stm32_dfsdm_probe_identificat
 					    const struct stm32_dfsdm_dev_data *dev_data)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *child;
 	struct stm32_dfsdm *dfsdm = &priv->dfsdm;
 	const char *compat;
 	int ret, count = 0;
@@ -329,7 +328,7 @@ static int stm32_dfsdm_probe_identificat
 		return -EINVAL;
 	}

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = of_property_read_string(child, "compatible", &compat);
 		if (ret)
 			continue;
diff -u -p a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1244,7 +1244,6 @@ static int at91_pinctrl_parse_groups(str
 static int at91_pinctrl_parse_functions(struct device_node *np,
 					struct at91_pinctrl *info, u32 index)
 {
-	struct device_node *child;
 	struct at91_pmx_func *func;
 	struct at91_pin_group *grp;
 	int ret;
@@ -1267,14 +1266,12 @@ static int at91_pinctrl_parse_functions(
 	if (!func->groups)
 		return -ENOMEM;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		func->groups[i] = child->name;
 		grp = &info->groups[grp_index++];
 		ret = at91_pinctrl_parse_groups(child, grp, info, i++);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}

 	return 0;
@@ -1296,7 +1293,6 @@ static int at91_pinctrl_probe_dt(struct
 	int i, j, ngpio_chips_enabled = 0;
 	uint32_t *tmp;
 	struct device_node *np = dev->of_node;
-	struct device_node *child;

 	if (!np)
 		return -ENODEV;
@@ -1349,14 +1345,12 @@ static int at91_pinctrl_probe_dt(struct

 	i = 0;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (of_device_is_compatible(child, gpio_compat))
 			continue;
 		ret = at91_pinctrl_parse_functions(child, info, i++);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return dev_err_probe(dev, ret, "failed to parse function\n");
-		}
 	}

 	return 0;
diff -u -p a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -521,7 +521,6 @@ static int rzg2l_dt_node_to_map(struct p
 				unsigned int *num_maps)
 {
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-	struct device_node *child;
 	unsigned int index;
 	int ret;

@@ -529,13 +528,11 @@ static int rzg2l_dt_node_to_map(struct p
 	*num_maps = 0;
 	index = 0;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = rzg2l_dt_subnode_to_map(pctldev, child, np, map,
 					      num_maps, &index);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			goto done;
-		}
 	}

 	if (*num_maps == 0) {
diff -u -p a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -436,7 +436,7 @@ static int cap11xx_led_set(struct led_cl
 static int cap11xx_init_leds(struct device *dev,
 			     struct cap11xx_priv *priv, int num_leds)
 {
-	struct device_node *node = dev->of_node, *child;
+	struct device_node *node = dev->of_node;
 	struct cap11xx_led *led;
 	int cnt = of_get_child_count(node);
 	int error;
@@ -465,7 +465,7 @@ static int cap11xx_init_leds(struct devi
 	if (error)
 		return error;

-	for_each_child_of_node(node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		u32 reg;

 		led->cdev.name =
@@ -478,19 +478,15 @@ static int cap11xx_init_leds(struct devi
 		led->cdev.brightness = LED_OFF;

 		error = of_property_read_u32(child, "reg", &reg);
-		if (error != 0 || reg >= num_leds) {
-			of_node_put(child);
+		if (error != 0 || reg >= num_leds)
 			return -EINVAL;
-		}

 		led->reg = reg;
 		led->priv = priv;

 		error = devm_led_classdev_register(dev, &led->cdev);
-		if (error) {
-			of_node_put(child);
+		if (error)
 			return error;
-		}

 		priv->num_leds++;
 		led++;
diff -u -p a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -1844,7 +1844,6 @@ static irqreturn_t xgene_edac_isr(int ir
 static int xgene_edac_probe(struct platform_device *pdev)
 {
 	struct xgene_edac *edac;
-	struct device_node *child;
 	struct resource *res;
 	int rc;

@@ -1935,7 +1934,7 @@ static int xgene_edac_probe(struct platf

 	edac->dfs = edac_debugfs_create_dir(pdev->dev.kobj.name);

-	for_each_child_of_node(pdev->dev.of_node, child) {
+	for_each_child_of_node_scoped(pdev->dev.of_node, child) {
 		if (!of_device_is_available(child))
 			continue;
 		if (of_device_is_compatible(child, "apm,xgene-edac-mc"))
diff -u -p a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1171,21 +1171,18 @@ void rsnd_parse_connect_common(struct rs
 {
 	struct rsnd_priv *priv = rsnd_rdai_to_priv(rdai);
 	struct device *dev = rsnd_priv_to_dev(priv);
-	struct device_node *np;
 	int i;

 	if (!node)
 		return;

 	i = 0;
-	for_each_child_of_node(node, np) {
+	for_each_child_of_node_scoped(node, np) {
 		struct rsnd_mod *mod;

 		i = rsnd_node_fixed_index(dev, np, name, i);
-		if (i < 0) {
-			of_node_put(np);
+		if (i < 0)
 			break;
-		}

 		mod = mod_get(priv, i);

@@ -1234,16 +1231,13 @@ int rsnd_node_fixed_index(struct device
 int rsnd_node_count(struct rsnd_priv *priv, struct device_node *node, char *name)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
-	struct device_node *np;
 	int i;

 	i = 0;
-	for_each_child_of_node(node, np) {
+	for_each_child_of_node_scoped(node, np) {
 		i = rsnd_node_fixed_index(dev, np, name, i);
-		if (i < 0) {
-			of_node_put(np);
+		if (i < 0)
 			return 0;
-		}
 		i++;
 	}

diff -u -p a/drivers/media/platform/xilinx/xilinx-vipp.c b/drivers/media/platform/xilinx/xilinx-vipp.c
--- a/drivers/media/platform/xilinx/xilinx-vipp.c
+++ b/drivers/media/platform/xilinx/xilinx-vipp.c
@@ -455,7 +455,6 @@ static int xvip_graph_dma_init_one(struc
 static int xvip_graph_dma_init(struct xvip_composite_device *xdev)
 {
 	struct device_node *ports;
-	struct device_node *port;
 	int ret = 0;

 	ports = of_get_child_by_name(xdev->dev->of_node, "ports");
@@ -464,12 +463,10 @@ static int xvip_graph_dma_init(struct xv
 		return -EINVAL;
 	}

-	for_each_child_of_node(ports, port) {
+	for_each_child_of_node_scoped(ports, port) {
 		ret = xvip_graph_dma_init_one(xdev, port);
-		if (ret) {
-			of_node_put(port);
+		if (ret)
 			break;
-		}
 	}

 	of_node_put(ports);
diff -u -p a/drivers/pinctrl/renesas/pinctrl-rza1.c b/drivers/pinctrl/renesas/pinctrl-rza1.c
--- a/drivers/pinctrl/renesas/pinctrl-rza1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza1.c
@@ -852,7 +852,6 @@ static const struct gpio_chip rza1_gpioc
  */
 static int rza1_dt_node_pin_count(struct device_node *np)
 {
-	struct device_node *child;
 	struct property *of_pins;
 	unsigned int npins;

@@ -861,12 +860,10 @@ static int rza1_dt_node_pin_count(struct
 		return of_pins->length / sizeof(u32);

 	npins = 0;
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		of_pins = of_find_property(child, "pinmux", NULL);
-		if (!of_pins) {
-			of_node_put(child);
+		if (!of_pins)
 			return -EINVAL;
-		}

 		npins += of_pins->length / sizeof(u32);
 	}
diff -u -p a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
@@ -25,14 +25,13 @@
 static unsigned int rcar_du_encoder_count_ports(struct device_node *node)
 {
 	struct device_node *ports;
-	struct device_node *port;
 	unsigned int num_ports = 0;

 	ports = of_get_child_by_name(node, "ports");
 	if (!ports)
 		ports = of_node_get(node);

-	for_each_child_of_node(ports, port) {
+	for_each_child_of_node_scoped(ports, port) {
 		if (of_node_name_eq(port, "port"))
 			num_ports++;
 	}
diff -u -p a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1027,7 +1027,7 @@ static const struct of_device_id altr_ed
 static int __init __maybe_unused altr_init_a10_ecc_device_type(char *compat)
 {
 	int irq;
-	struct device_node *child, *np;
+	struct device_node *np;

 	np = of_find_compatible_node(NULL, NULL,
 				     "altr,socfpga-a10-ecc-manager");
@@ -1036,7 +1036,7 @@ static int __init __maybe_unused altr_in
 		return -ENODEV;
 	}

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		const struct of_device_id *pdev_id;
 		const struct edac_device_prv_data *prv;

@@ -2109,7 +2109,6 @@ static int s10_edac_dberr_handler(struct
 static int altr_edac_a10_probe(struct platform_device *pdev)
 {
 	struct altr_arria10_edac *edac;
-	struct device_node *child;

 	edac = devm_kzalloc(&pdev->dev, sizeof(*edac), GFP_KERNEL);
 	if (!edac)
@@ -2180,7 +2179,7 @@ static int altr_edac_a10_probe(struct pl
 					 altr_edac_a10_irq_handler, edac);
 #endif

-	for_each_child_of_node(pdev->dev.of_node, child) {
+	for_each_child_of_node_scoped(pdev->dev.of_node, child) {
 		if (!of_device_is_available(child))
 			continue;

diff -u -p a/drivers/pinctrl/renesas/pinctrl-rzv2m.c b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
--- a/drivers/pinctrl/renesas/pinctrl-rzv2m.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzv2m.c
@@ -388,7 +388,6 @@ static int rzv2m_dt_node_to_map(struct p
 				unsigned int *num_maps)
 {
 	struct rzv2m_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-	struct device_node *child;
 	unsigned int index;
 	int ret;

@@ -396,13 +395,11 @@ static int rzv2m_dt_node_to_map(struct p
 	*num_maps = 0;
 	index = 0;

-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		ret = rzv2m_dt_subnode_to_map(pctldev, child, np, map,
 					      num_maps, &index);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			goto done;
-		}
 	}

 	if (*num_maps == 0) {
diff -u -p a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4727,7 +4727,6 @@ static int mtk_sgmii_init(struct mtk_eth
 static int mtk_probe(struct platform_device *pdev)
 {
 	struct resource *res = NULL, *res_sram;
-	struct device_node *mac_np;
 	struct mtk_eth *eth;
 	int err, i;

@@ -4904,7 +4903,7 @@ static int mtk_probe(struct platform_dev

 	eth->hwlro = MTK_HAS_CAPS(eth->soc->caps, MTK_HWLRO);

-	for_each_child_of_node(pdev->dev.of_node, mac_np) {
+	for_each_child_of_node_scoped(pdev->dev.of_node, mac_np) {
 		if (!of_device_is_compatible(mac_np,
 					     "mediatek,eth-mac"))
 			continue;
@@ -4913,10 +4912,8 @@ static int mtk_probe(struct platform_dev
 			continue;

 		err = mtk_add_mac(eth, mac_np);
-		if (err) {
-			of_node_put(mac_np);
+		if (err)
 			goto err_deinit_hw;
-		}
 	}

 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT)) {

