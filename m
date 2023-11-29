Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9557FDCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjK2QQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjK2QQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:16:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5BF172E;
        Wed, 29 Nov 2023 08:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701274537; x=1732810537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hHglKP9UfhqzXQ1Uva+bBMbp444lixlJ1lXoP3fZ2No=;
  b=e0sNzPULGPlW4EWIRBwtb4MugrG/0+PbiGHp0YoGlUcDZyeZB55FxtOF
   BMJzAZVahpOM47+IumfBtRszpaMOS9oqx5GYG/tVHLhuYanoETesrrcBv
   qsQBtR7j9zNaAFCJV/7s2Et0qVIF7/Njg+Im7PHHCdqXrXjwzUqrBeQUh
   pwZdqK5RR/jtANt+EsWng3ukoIgcT08L/XrfwVcO5rJaEug+3IieK1MIZ
   rooC8vRFy0N6ljqPgMD+/oc8O/BDpFOqY82rym71fGxDXzpSDjrx/F+kr
   CBObXZbpHAo9LTpZ/aruNT1BxqMoYESERMvQUwB7Lqq3WwwRL7JaZMfNO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="373372869"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="373372869"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 08:15:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="745316940"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="745316940"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2023 08:15:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8D3D9CC9; Wed, 29 Nov 2023 18:15:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: [PATCH v4 23/23] pinctrl: Convert unsigned to unsigned int
Date:   Wed, 29 Nov 2023 18:06:46 +0200
Message-ID: <20231129161459.1002323-24-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
References: <20231129161459.1002323-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple type conversion with no functional change implied.
While at it, adjust indentation where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/core.c                  | 28 +++++++++----------
 drivers/pinctrl/core.h                  | 14 +++++-----
 drivers/pinctrl/devicetree.c            |  8 +++---
 drivers/pinctrl/pinconf-generic.c       | 16 +++++------
 drivers/pinctrl/pinconf.c               | 14 +++++-----
 drivers/pinctrl/pinconf.h               | 10 +++----
 drivers/pinctrl/pinctrl-utils.c         | 26 +++++++++---------
 drivers/pinctrl/pinctrl-utils.h         | 18 ++++++-------
 drivers/pinctrl/pinmux.c                | 36 ++++++++++++-------------
 drivers/pinctrl/pinmux.h                | 20 +++++++-------
 include/linux/pinctrl/machine.h         |  6 ++---
 include/linux/pinctrl/pinconf-generic.h | 10 +++----
 include/linux/pinctrl/pinconf.h         | 16 +++++------
 include/linux/pinctrl/pinctrl.h         | 24 ++++++++---------
 include/linux/pinctrl/pinmux.h          | 22 +++++++--------
 15 files changed, 134 insertions(+), 134 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 6688911c00db..ee56856cb80c 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -143,7 +143,7 @@ struct pinctrl_dev *get_pinctrl_dev_from_of_node(struct device_node *np)
  */
 int pin_get_from_name(struct pinctrl_dev *pctldev, const char *name)
 {
-	unsigned i, pin;
+	unsigned int i, pin;
 
 	/* The pin number can be retrived from the pin controller descriptor */
 	for (i = 0; i < pctldev->desc->npins; i++) {
@@ -164,7 +164,7 @@ int pin_get_from_name(struct pinctrl_dev *pctldev, const char *name)
  * @pctldev: the pin control device to lookup the pin on
  * @pin: pin number/id to look up
  */
-const char *pin_get_name(struct pinctrl_dev *pctldev, const unsigned pin)
+const char *pin_get_name(struct pinctrl_dev *pctldev, const unsigned int pin)
 {
 	const struct pin_desc *desc;
 
@@ -182,7 +182,7 @@ EXPORT_SYMBOL_GPL(pin_get_name);
 /* Deletes a range of pin descriptors */
 static void pinctrl_free_pindescs(struct pinctrl_dev *pctldev,
 				  const struct pinctrl_pin_desc *pins,
-				  unsigned num_pins)
+				  unsigned int num_pins)
 {
 	int i;
 
@@ -250,9 +250,9 @@ static int pinctrl_register_one_pin(struct pinctrl_dev *pctldev,
 
 static int pinctrl_register_pins(struct pinctrl_dev *pctldev,
 				 const struct pinctrl_pin_desc *pins,
-				 unsigned num_descs)
+				 unsigned int num_descs)
 {
-	unsigned i;
+	unsigned int i;
 	int ret = 0;
 
 	for (i = 0; i < num_descs; i++) {
@@ -426,7 +426,7 @@ EXPORT_SYMBOL_GPL(pinctrl_add_gpio_range);
 
 void pinctrl_add_gpio_ranges(struct pinctrl_dev *pctldev,
 			     struct pinctrl_gpio_range *ranges,
-			     unsigned nranges)
+			     unsigned int nranges)
 {
 	int i;
 
@@ -457,7 +457,7 @@ struct pinctrl_dev *pinctrl_find_and_add_gpio_range(const char *devname,
 EXPORT_SYMBOL_GPL(pinctrl_find_and_add_gpio_range);
 
 int pinctrl_get_group_pins(struct pinctrl_dev *pctldev, const char *pin_group,
-				const unsigned **pins, unsigned *num_pins)
+			   const unsigned int **pins, unsigned int *num_pins)
 {
 	const struct pinctrl_ops *pctlops = pctldev->desc->pctlops;
 	int gs;
@@ -729,8 +729,8 @@ int pinctrl_get_group_selector(struct pinctrl_dev *pctldev,
 			       const char *pin_group)
 {
 	const struct pinctrl_ops *pctlops = pctldev->desc->pctlops;
-	unsigned ngroups = pctlops->get_groups_count(pctldev);
-	unsigned group_selector = 0;
+	unsigned int ngroups = pctlops->get_groups_count(pctldev);
+	unsigned int group_selector = 0;
 
 	while (group_selector < ngroups) {
 		const char *gname = pctlops->get_group_name(pctldev,
@@ -1427,7 +1427,7 @@ EXPORT_SYMBOL_GPL(devm_pinctrl_put);
  * @num_maps: the number of maps in the mapping table
  */
 int pinctrl_register_mappings(const struct pinctrl_map *maps,
-			      unsigned num_maps)
+			      unsigned int num_maps)
 {
 	int i, ret;
 	struct pinctrl_maps *maps_node;
@@ -1642,7 +1642,7 @@ static int pinctrl_pins_show(struct seq_file *s, void *what)
 {
 	struct pinctrl_dev *pctldev = s->private;
 	const struct pinctrl_ops *ops = pctldev->desc->pctlops;
-	unsigned i, pin;
+	unsigned int i, pin;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_device *gdev __free(gpio_device_put) = NULL;
 	struct pinctrl_gpio_range *range;
@@ -1706,7 +1706,7 @@ static int pinctrl_groups_show(struct seq_file *s, void *what)
 {
 	struct pinctrl_dev *pctldev = s->private;
 	const struct pinctrl_ops *ops = pctldev->desc->pctlops;
-	unsigned ngroups, selector = 0;
+	unsigned int ngroups, selector = 0;
 
 	mutex_lock(&pctldev->mutex);
 
@@ -1714,8 +1714,8 @@ static int pinctrl_groups_show(struct seq_file *s, void *what)
 
 	seq_puts(s, "registered pin groups:\n");
 	while (selector < ngroups) {
-		const unsigned *pins = NULL;
-		unsigned num_pins = 0;
+		const unsigned int *pins = NULL;
+		unsigned int num_pins = 0;
 		const char *gname = ops->get_group_name(pctldev, selector);
 		const char *pname;
 		int ret = 0;
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index 0c1803dd85e5..837fd5bd903d 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -111,8 +111,8 @@ struct pinctrl_state {
  * @func: the function selector to program
  */
 struct pinctrl_setting_mux {
-	unsigned group;
-	unsigned func;
+	unsigned int group;
+	unsigned int func;
 };
 
 /**
@@ -124,9 +124,9 @@ struct pinctrl_setting_mux {
  * @num_configs: the number of entries in array @configs
  */
 struct pinctrl_setting_configs {
-	unsigned group_or_pin;
+	unsigned int group_or_pin;
 	unsigned long *configs;
-	unsigned num_configs;
+	unsigned int num_configs;
 };
 
 /**
@@ -173,7 +173,7 @@ struct pin_desc {
 	void *drv_data;
 	/* These fields only added when supporting pinmux drivers */
 #ifdef CONFIG_PINMUX
-	unsigned mux_usecount;
+	unsigned int mux_usecount;
 	const char *mux_owner;
 	const struct pinctrl_setting_mux *mux_setting;
 	const char *gpio_owner;
@@ -189,7 +189,7 @@ struct pin_desc {
 struct pinctrl_maps {
 	struct list_head node;
 	const struct pinctrl_map *maps;
-	unsigned num_maps;
+	unsigned int num_maps;
 };
 
 #ifdef CONFIG_GENERIC_PINCTRL_GROUPS
@@ -237,7 +237,7 @@ int pinctrl_generic_remove_group(struct pinctrl_dev *pctldev,
 struct pinctrl_dev *get_pinctrl_dev_from_devname(const char *dev_name);
 struct pinctrl_dev *get_pinctrl_dev_from_of_node(struct device_node *np);
 int pin_get_from_name(struct pinctrl_dev *pctldev, const char *name);
-const char *pin_get_name(struct pinctrl_dev *pctldev, const unsigned pin);
+const char *pin_get_name(struct pinctrl_dev *pctldev, const unsigned int pin);
 int pinctrl_get_group_selector(struct pinctrl_dev *pctldev,
 			       const char *pin_group);
 
diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index 6e0a40962f38..df1efc2e5202 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -24,11 +24,11 @@ struct pinctrl_dt_map {
 	struct list_head node;
 	struct pinctrl_dev *pctldev;
 	struct pinctrl_map *map;
-	unsigned num_maps;
+	unsigned int num_maps;
 };
 
 static void dt_free_map(struct pinctrl_dev *pctldev,
-		     struct pinctrl_map *map, unsigned num_maps)
+			struct pinctrl_map *map, unsigned int num_maps)
 {
 	int i;
 
@@ -64,7 +64,7 @@ void pinctrl_dt_free_maps(struct pinctrl *p)
 
 static int dt_remember_or_free_map(struct pinctrl *p, const char *statename,
 				   struct pinctrl_dev *pctldev,
-				   struct pinctrl_map *map, unsigned num_maps)
+				   struct pinctrl_map *map, unsigned int num_maps)
 {
 	int i;
 	struct pinctrl_dt_map *dt_map;
@@ -116,7 +116,7 @@ static int dt_to_map_one_config(struct pinctrl *p,
 	const struct pinctrl_ops *ops;
 	int ret;
 	struct pinctrl_map *map;
-	unsigned num_maps;
+	unsigned int num_maps;
 	bool allow_default = false;
 
 	/* Find the pin controller containing np_config */
diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 8313cb5f3b3c..cada5d18ffae 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -57,7 +57,7 @@ static const struct pin_config_item conf_items[] = {
 
 static void pinconf_generic_dump_one(struct pinctrl_dev *pctldev,
 				     struct seq_file *s, const char *gname,
-				     unsigned pin,
+				     unsigned int pin,
 				     const struct pin_config_item *items,
 				     int nitems, int *print_sep)
 {
@@ -110,7 +110,7 @@ static void pinconf_generic_dump_one(struct pinctrl_dev *pctldev,
  * to be specified the other can be NULL/0.
  */
 void pinconf_generic_dump_pins(struct pinctrl_dev *pctldev, struct seq_file *s,
-			       const char *gname, unsigned pin)
+			       const char *gname, unsigned int pin)
 {
 	const struct pinconf_ops *ops = pctldev->desc->confops;
 	int print_sep = 0;
@@ -295,15 +295,15 @@ EXPORT_SYMBOL_GPL(pinconf_generic_parse_dt_config);
 
 int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		struct device_node *np, struct pinctrl_map **map,
-		unsigned *reserved_maps, unsigned *num_maps,
+		unsigned int *reserved_maps, unsigned int *num_maps,
 		enum pinctrl_map_type type)
 {
 	int ret;
 	const char *function;
 	struct device *dev = pctldev->dev;
 	unsigned long *configs = NULL;
-	unsigned num_configs = 0;
-	unsigned reserve, strings_count;
+	unsigned int num_configs = 0;
+	unsigned int reserve, strings_count;
 	struct property *prop;
 	const char *group;
 	const char *subnode_target_type = "pins";
@@ -379,9 +379,9 @@ EXPORT_SYMBOL_GPL(pinconf_generic_dt_subnode_to_map);
 
 int pinconf_generic_dt_node_to_map(struct pinctrl_dev *pctldev,
 		struct device_node *np_config, struct pinctrl_map **map,
-		unsigned *num_maps, enum pinctrl_map_type type)
+		unsigned int *num_maps, enum pinctrl_map_type type)
 {
-	unsigned reserved_maps;
+	unsigned int reserved_maps;
 	struct device_node *np;
 	int ret;
 
@@ -412,7 +412,7 @@ EXPORT_SYMBOL_GPL(pinconf_generic_dt_node_to_map);
 
 void pinconf_generic_dt_free_map(struct pinctrl_dev *pctldev,
 				 struct pinctrl_map *map,
-				 unsigned num_maps)
+				 unsigned int num_maps)
 {
 	pinctrl_utils_free_map(pctldev, map, num_maps);
 }
diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index 96d853a8f339..dca963633b5d 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -55,7 +55,7 @@ int pinconf_validate_map(const struct pinctrl_map *map, int i)
 	return 0;
 }
 
-int pin_config_get_for_pin(struct pinctrl_dev *pctldev, unsigned pin,
+int pin_config_get_for_pin(struct pinctrl_dev *pctldev, unsigned int pin,
 			   unsigned long *config)
 {
 	const struct pinconf_ops *ops = pctldev->desc->confops;
@@ -199,7 +199,7 @@ int pinconf_apply_setting(const struct pinctrl_setting *setting)
 	return 0;
 }
 
-int pinconf_set_config(struct pinctrl_dev *pctldev, unsigned pin,
+int pinconf_set_config(struct pinctrl_dev *pctldev, unsigned int pin,
 		       unsigned long *configs, size_t nconfigs)
 {
 	const struct pinconf_ops *ops;
@@ -214,7 +214,7 @@ int pinconf_set_config(struct pinctrl_dev *pctldev, unsigned pin,
 #ifdef CONFIG_DEBUG_FS
 
 static void pinconf_show_config(struct seq_file *s, struct pinctrl_dev *pctldev,
-		      unsigned long *configs, unsigned num_configs)
+				unsigned long *configs, unsigned int num_configs)
 {
 	const struct pinconf_ops *confops;
 	int i;
@@ -304,7 +304,7 @@ static void pinconf_dump_pin(struct pinctrl_dev *pctldev,
 static int pinconf_pins_show(struct seq_file *s, void *what)
 {
 	struct pinctrl_dev *pctldev = s->private;
-	unsigned i, pin;
+	unsigned int i, pin;
 
 	seq_puts(s, "Pin config settings per pin\n");
 	seq_puts(s, "Format: pin (name): configs\n");
@@ -333,7 +333,7 @@ static int pinconf_pins_show(struct seq_file *s, void *what)
 }
 
 static void pinconf_dump_group(struct pinctrl_dev *pctldev,
-			       struct seq_file *s, unsigned selector,
+			       struct seq_file *s, unsigned int selector,
 			       const char *gname)
 {
 	const struct pinconf_ops *ops = pctldev->desc->confops;
@@ -348,8 +348,8 @@ static int pinconf_groups_show(struct seq_file *s, void *what)
 {
 	struct pinctrl_dev *pctldev = s->private;
 	const struct pinctrl_ops *pctlops = pctldev->desc->pctlops;
-	unsigned ngroups = pctlops->get_groups_count(pctldev);
-	unsigned selector = 0;
+	unsigned int ngroups = pctlops->get_groups_count(pctldev);
+	unsigned int selector = 0;
 
 	seq_puts(s, "Pin config settings per pin group\n");
 	seq_puts(s, "Format: group (name): configs\n");
diff --git a/drivers/pinctrl/pinconf.h b/drivers/pinctrl/pinconf.h
index 694bfc9961fa..a14c950bc700 100644
--- a/drivers/pinctrl/pinconf.h
+++ b/drivers/pinctrl/pinconf.h
@@ -29,14 +29,14 @@ int pinconf_map_to_setting(const struct pinctrl_map *map,
 void pinconf_free_setting(const struct pinctrl_setting *setting);
 int pinconf_apply_setting(const struct pinctrl_setting *setting);
 
-int pinconf_set_config(struct pinctrl_dev *pctldev, unsigned pin,
+int pinconf_set_config(struct pinctrl_dev *pctldev, unsigned int pin,
 		       unsigned long *configs, size_t nconfigs);
 
 /*
  * You will only be interested in these if you're using PINCONF
  * so don't supply any stubs for these.
  */
-int pin_config_get_for_pin(struct pinctrl_dev *pctldev, unsigned pin,
+int pin_config_get_for_pin(struct pinctrl_dev *pctldev, unsigned int pin,
 			   unsigned long *config);
 int pin_config_group_get(const char *dev_name, const char *pin_group,
 			 unsigned long *config);
@@ -68,7 +68,7 @@ static inline int pinconf_apply_setting(const struct pinctrl_setting *setting)
 	return 0;
 }
 
-static inline int pinconf_set_config(struct pinctrl_dev *pctldev, unsigned pin,
+static inline int pinconf_set_config(struct pinctrl_dev *pctldev, unsigned int pin,
 				     unsigned long *configs, size_t nconfigs)
 {
 	return -ENOTSUPP;
@@ -112,7 +112,7 @@ static inline void pinconf_init_device_debugfs(struct dentry *devroot,
 
 void pinconf_generic_dump_pins(struct pinctrl_dev *pctldev,
 			       struct seq_file *s, const char *gname,
-			       unsigned pin);
+			       unsigned int pin);
 
 void pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
 				 struct seq_file *s, unsigned long config);
@@ -120,7 +120,7 @@ void pinconf_generic_dump_config(struct pinctrl_dev *pctldev,
 
 static inline void pinconf_generic_dump_pins(struct pinctrl_dev *pctldev,
 					     struct seq_file *s,
-					     const char *gname, unsigned pin)
+					     const char *gname, unsigned int pin)
 {
 	return;
 }
diff --git a/drivers/pinctrl/pinctrl-utils.c b/drivers/pinctrl/pinctrl-utils.c
index 40862f7bd6ca..d81d7b46116c 100644
--- a/drivers/pinctrl/pinctrl-utils.c
+++ b/drivers/pinctrl/pinctrl-utils.c
@@ -18,11 +18,11 @@
 #include "pinctrl-utils.h"
 
 int pinctrl_utils_reserve_map(struct pinctrl_dev *pctldev,
-		struct pinctrl_map **map, unsigned *reserved_maps,
-		unsigned *num_maps, unsigned reserve)
+		struct pinctrl_map **map, unsigned int *reserved_maps,
+		unsigned int *num_maps, unsigned int reserve)
 {
-	unsigned old_num = *reserved_maps;
-	unsigned new_num = *num_maps + reserve;
+	unsigned int old_num = *reserved_maps;
+	unsigned int new_num = *num_maps + reserve;
 	struct pinctrl_map *new_map;
 
 	if (old_num >= new_num)
@@ -43,8 +43,8 @@ int pinctrl_utils_reserve_map(struct pinctrl_dev *pctldev,
 EXPORT_SYMBOL_GPL(pinctrl_utils_reserve_map);
 
 int pinctrl_utils_add_map_mux(struct pinctrl_dev *pctldev,
-		struct pinctrl_map **map, unsigned *reserved_maps,
-		unsigned *num_maps, const char *group,
+		struct pinctrl_map **map, unsigned int *reserved_maps,
+		unsigned int *num_maps, const char *group,
 		const char *function)
 {
 	if (WARN_ON(*num_maps == *reserved_maps))
@@ -60,9 +60,9 @@ int pinctrl_utils_add_map_mux(struct pinctrl_dev *pctldev,
 EXPORT_SYMBOL_GPL(pinctrl_utils_add_map_mux);
 
 int pinctrl_utils_add_map_configs(struct pinctrl_dev *pctldev,
-		struct pinctrl_map **map, unsigned *reserved_maps,
-		unsigned *num_maps, const char *group,
-		unsigned long *configs, unsigned num_configs,
+		struct pinctrl_map **map, unsigned int *reserved_maps,
+		unsigned int *num_maps, const char *group,
+		unsigned long *configs, unsigned int num_configs,
 		enum pinctrl_map_type type)
 {
 	unsigned long *dup_configs;
@@ -86,11 +86,11 @@ int pinctrl_utils_add_map_configs(struct pinctrl_dev *pctldev,
 EXPORT_SYMBOL_GPL(pinctrl_utils_add_map_configs);
 
 int pinctrl_utils_add_config(struct pinctrl_dev *pctldev,
-		unsigned long **configs, unsigned *num_configs,
+		unsigned long **configs, unsigned int *num_configs,
 		unsigned long config)
 {
-	unsigned old_num = *num_configs;
-	unsigned new_num = old_num + 1;
+	unsigned int old_num = *num_configs;
+	unsigned int new_num = old_num + 1;
 	unsigned long *new_configs;
 
 	new_configs = krealloc(*configs, sizeof(*new_configs) * new_num,
@@ -110,7 +110,7 @@ int pinctrl_utils_add_config(struct pinctrl_dev *pctldev,
 EXPORT_SYMBOL_GPL(pinctrl_utils_add_config);
 
 void pinctrl_utils_free_map(struct pinctrl_dev *pctldev,
-	      struct pinctrl_map *map, unsigned num_maps)
+	      struct pinctrl_map *map, unsigned int num_maps)
 {
 	int i;
 
diff --git a/drivers/pinctrl/pinctrl-utils.h b/drivers/pinctrl/pinctrl-utils.h
index 4108ee2dd6d0..203fba257d71 100644
--- a/drivers/pinctrl/pinctrl-utils.h
+++ b/drivers/pinctrl/pinctrl-utils.h
@@ -15,21 +15,21 @@ struct pinctrl_dev;
 struct pinctrl_map;
 
 int pinctrl_utils_reserve_map(struct pinctrl_dev *pctldev,
-		struct pinctrl_map **map, unsigned *reserved_maps,
-		unsigned *num_maps, unsigned reserve);
+		struct pinctrl_map **map, unsigned int *reserved_maps,
+		unsigned int *num_maps, unsigned int reserve);
 int pinctrl_utils_add_map_mux(struct pinctrl_dev *pctldev,
-		struct pinctrl_map **map, unsigned *reserved_maps,
-		unsigned *num_maps, const char *group,
+		struct pinctrl_map **map, unsigned int *reserved_maps,
+		unsigned int *num_maps, const char *group,
 		const char *function);
 int pinctrl_utils_add_map_configs(struct pinctrl_dev *pctldev,
-		struct pinctrl_map **map, unsigned *reserved_maps,
-		unsigned *num_maps, const char *group,
-		unsigned long *configs, unsigned num_configs,
+		struct pinctrl_map **map, unsigned int *reserved_maps,
+		unsigned int *num_maps, const char *group,
+		unsigned long *configs, unsigned int num_configs,
 		enum pinctrl_map_type type);
 int pinctrl_utils_add_config(struct pinctrl_dev *pctldev,
-		unsigned long **configs, unsigned *num_configs,
+		unsigned long **configs, unsigned int *num_configs,
 		unsigned long config);
 void pinctrl_utils_free_map(struct pinctrl_dev *pctldev,
-		struct pinctrl_map *map, unsigned num_maps);
+		struct pinctrl_map *map, unsigned int num_maps);
 
 #endif /* __PINCTRL_UTILS_H__ */
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 23d2da0b99b9..abbb044d6ace 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -35,8 +35,8 @@
 int pinmux_check_ops(struct pinctrl_dev *pctldev)
 {
 	const struct pinmux_ops *ops = pctldev->desc->pmxops;
-	unsigned nfuncs;
-	unsigned selector = 0;
+	unsigned int nfuncs;
+	unsigned int selector = 0;
 
 	/* Check that we implement required operations */
 	if (!ops ||
@@ -84,7 +84,7 @@ int pinmux_validate_map(const struct pinctrl_map *map, int i)
  * Controllers not defined as strict will always return true,
  * menaning that the gpio can be used.
  */
-bool pinmux_can_be_used_for_gpio(struct pinctrl_dev *pctldev, unsigned pin)
+bool pinmux_can_be_used_for_gpio(struct pinctrl_dev *pctldev, unsigned int pin)
 {
 	struct pin_desc *desc = pin_desc_get(pctldev, pin);
 	const struct pinmux_ops *ops = pctldev->desc->pmxops;
@@ -262,7 +262,7 @@ static const char *pin_free(struct pinctrl_dev *pctldev, int pin,
  */
 int pinmux_request_gpio(struct pinctrl_dev *pctldev,
 			struct pinctrl_gpio_range *range,
-			unsigned pin, unsigned gpio)
+			unsigned int pin, unsigned int gpio)
 {
 	const char *owner;
 	int ret;
@@ -285,7 +285,7 @@ int pinmux_request_gpio(struct pinctrl_dev *pctldev,
  * @pin: the affected currently GPIO-muxed in pin
  * @range: applicable GPIO range
  */
-void pinmux_free_gpio(struct pinctrl_dev *pctldev, unsigned pin,
+void pinmux_free_gpio(struct pinctrl_dev *pctldev, unsigned int pin,
 		      struct pinctrl_gpio_range *range)
 {
 	const char *owner;
@@ -303,7 +303,7 @@ void pinmux_free_gpio(struct pinctrl_dev *pctldev, unsigned pin,
  */
 int pinmux_gpio_direction(struct pinctrl_dev *pctldev,
 			  struct pinctrl_gpio_range *range,
-			  unsigned pin, bool input)
+			  unsigned int pin, bool input)
 {
 	const struct pinmux_ops *ops;
 	int ret;
@@ -322,8 +322,8 @@ static int pinmux_func_name_to_selector(struct pinctrl_dev *pctldev,
 					const char *function)
 {
 	const struct pinmux_ops *ops = pctldev->desc->pmxops;
-	unsigned nfuncs = ops->get_functions_count(pctldev);
-	unsigned selector = 0;
+	unsigned int nfuncs = ops->get_functions_count(pctldev);
+	unsigned int selector = 0;
 
 	/* See if this pctldev has this function */
 	while (selector < nfuncs) {
@@ -344,7 +344,7 @@ int pinmux_map_to_setting(const struct pinctrl_map *map,
 	struct pinctrl_dev *pctldev = setting->pctldev;
 	const struct pinmux_ops *pmxops = pctldev->desc->pmxops;
 	char const * const *groups;
-	unsigned num_groups;
+	unsigned int num_groups;
 	int ret;
 	const char *group;
 
@@ -409,8 +409,8 @@ int pinmux_enable_setting(const struct pinctrl_setting *setting)
 	const struct pinctrl_ops *pctlops = pctldev->desc->pctlops;
 	const struct pinmux_ops *ops = pctldev->desc->pmxops;
 	int ret = 0;
-	const unsigned *pins = NULL;
-	unsigned num_pins = 0;
+	const unsigned int *pins = NULL;
+	unsigned int num_pins = 0;
 	int i;
 	struct pin_desc *desc;
 
@@ -489,8 +489,8 @@ void pinmux_disable_setting(const struct pinctrl_setting *setting)
 	struct pinctrl_dev *pctldev = setting->pctldev;
 	const struct pinctrl_ops *pctlops = pctldev->desc->pctlops;
 	int ret = 0;
-	const unsigned *pins = NULL;
-	unsigned num_pins = 0;
+	const unsigned int *pins = NULL;
+	unsigned int num_pins = 0;
 	int i;
 	struct pin_desc *desc;
 
@@ -541,8 +541,8 @@ static int pinmux_functions_show(struct seq_file *s, void *what)
 {
 	struct pinctrl_dev *pctldev = s->private;
 	const struct pinmux_ops *pmxops = pctldev->desc->pmxops;
-	unsigned nfuncs;
-	unsigned func_selector = 0;
+	unsigned int nfuncs;
+	unsigned int func_selector = 0;
 
 	if (!pmxops)
 		return 0;
@@ -553,7 +553,7 @@ static int pinmux_functions_show(struct seq_file *s, void *what)
 		const char *func = pmxops->get_function_name(pctldev,
 							  func_selector);
 		const char * const *groups;
-		unsigned num_groups;
+		unsigned int num_groups;
 		int ret;
 		int i;
 
@@ -584,7 +584,7 @@ static int pinmux_pins_show(struct seq_file *s, void *what)
 	struct pinctrl_dev *pctldev = s->private;
 	const struct pinctrl_ops *pctlops = pctldev->desc->pctlops;
 	const struct pinmux_ops *pmxops = pctldev->desc->pmxops;
-	unsigned i, pin;
+	unsigned int i, pin;
 
 	if (!pmxops)
 		return 0;
@@ -818,7 +818,7 @@ EXPORT_SYMBOL_GPL(pinmux_generic_get_function_name);
 int pinmux_generic_get_function_groups(struct pinctrl_dev *pctldev,
 				       unsigned int selector,
 				       const char * const **groups,
-				       unsigned * const num_groups)
+				       unsigned int * const num_groups)
 {
 	struct function_desc *function;
 
diff --git a/drivers/pinctrl/pinmux.h b/drivers/pinctrl/pinmux.h
index ea6f99c24aa5..7c8aa25ccc80 100644
--- a/drivers/pinctrl/pinmux.h
+++ b/drivers/pinctrl/pinmux.h
@@ -26,16 +26,16 @@ int pinmux_check_ops(struct pinctrl_dev *pctldev);
 
 int pinmux_validate_map(const struct pinctrl_map *map, int i);
 
-bool pinmux_can_be_used_for_gpio(struct pinctrl_dev *pctldev, unsigned pin);
+bool pinmux_can_be_used_for_gpio(struct pinctrl_dev *pctldev, unsigned int pin);
 
 int pinmux_request_gpio(struct pinctrl_dev *pctldev,
 			struct pinctrl_gpio_range *range,
-			unsigned pin, unsigned gpio);
-void pinmux_free_gpio(struct pinctrl_dev *pctldev, unsigned pin,
+			unsigned int pin, unsigned int gpio);
+void pinmux_free_gpio(struct pinctrl_dev *pctldev, unsigned int pin,
 		      struct pinctrl_gpio_range *range);
 int pinmux_gpio_direction(struct pinctrl_dev *pctldev,
 			  struct pinctrl_gpio_range *range,
-			  unsigned pin, bool input);
+			  unsigned int pin, bool input);
 
 int pinmux_map_to_setting(const struct pinctrl_map *map,
 			  struct pinctrl_setting *setting);
@@ -56,27 +56,27 @@ static inline int pinmux_validate_map(const struct pinctrl_map *map, int i)
 }
 
 static inline bool pinmux_can_be_used_for_gpio(struct pinctrl_dev *pctldev,
-					       unsigned pin)
+					       unsigned int pin)
 {
 	return true;
 }
 
 static inline int pinmux_request_gpio(struct pinctrl_dev *pctldev,
 			struct pinctrl_gpio_range *range,
-			unsigned pin, unsigned gpio)
+			unsigned int pin, unsigned int gpio)
 {
 	return 0;
 }
 
 static inline void pinmux_free_gpio(struct pinctrl_dev *pctldev,
-				    unsigned pin,
+				    unsigned int pin,
 				    struct pinctrl_gpio_range *range)
 {
 }
 
 static inline int pinmux_gpio_direction(struct pinctrl_dev *pctldev,
 					struct pinctrl_gpio_range *range,
-					unsigned pin, bool input)
+					unsigned int pin, bool input)
 {
 	return 0;
 }
@@ -154,7 +154,7 @@ pinmux_generic_get_function_name(struct pinctrl_dev *pctldev,
 int pinmux_generic_get_function_groups(struct pinctrl_dev *pctldev,
 				       unsigned int selector,
 				       const char * const **groups,
-				       unsigned * const num_groups);
+				       unsigned int * const num_groups);
 
 struct function_desc *pinmux_generic_get_function(struct pinctrl_dev *pctldev,
 						  unsigned int selector);
@@ -162,7 +162,7 @@ struct function_desc *pinmux_generic_get_function(struct pinctrl_dev *pctldev,
 int pinmux_generic_add_function(struct pinctrl_dev *pctldev,
 				const char *name,
 				const char * const *groups,
-				unsigned const num_groups,
+				unsigned int const num_groups,
 				void *data);
 
 int pinmux_generic_remove_function(struct pinctrl_dev *pctldev,
diff --git a/include/linux/pinctrl/machine.h b/include/linux/pinctrl/machine.h
index ee8803f6ad07..673e96df453b 100644
--- a/include/linux/pinctrl/machine.h
+++ b/include/linux/pinctrl/machine.h
@@ -47,7 +47,7 @@ struct pinctrl_map_mux {
 struct pinctrl_map_configs {
 	const char *group_or_pin;
 	unsigned long *configs;
-	unsigned num_configs;
+	unsigned int num_configs;
 };
 
 /**
@@ -154,13 +154,13 @@ struct pinctrl_map;
 #ifdef CONFIG_PINCTRL
 
 extern int pinctrl_register_mappings(const struct pinctrl_map *map,
-				     unsigned num_maps);
+				     unsigned int num_maps);
 extern void pinctrl_unregister_mappings(const struct pinctrl_map *map);
 extern void pinctrl_provide_dummies(void);
 #else
 
 static inline int pinctrl_register_mappings(const struct pinctrl_map *map,
-					    unsigned num_maps)
+					    unsigned int num_maps)
 {
 	return 0;
 }
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index d74b7a4ea154..a65d3d078e58 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -193,17 +193,17 @@ struct pinconf_generic_params {
 
 int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		struct device_node *np, struct pinctrl_map **map,
-		unsigned *reserved_maps, unsigned *num_maps,
+		unsigned int *reserved_maps, unsigned int *num_maps,
 		enum pinctrl_map_type type);
 int pinconf_generic_dt_node_to_map(struct pinctrl_dev *pctldev,
 		struct device_node *np_config, struct pinctrl_map **map,
-		unsigned *num_maps, enum pinctrl_map_type type);
+		unsigned int *num_maps, enum pinctrl_map_type type);
 void pinconf_generic_dt_free_map(struct pinctrl_dev *pctldev,
-		struct pinctrl_map *map, unsigned num_maps);
+		struct pinctrl_map *map, unsigned int num_maps);
 
 static inline int pinconf_generic_dt_node_to_map_group(struct pinctrl_dev *pctldev,
 		struct device_node *np_config, struct pinctrl_map **map,
-		unsigned *num_maps)
+		unsigned int *num_maps)
 {
 	return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
 			PIN_MAP_TYPE_CONFIGS_GROUP);
@@ -211,7 +211,7 @@ static inline int pinconf_generic_dt_node_to_map_group(struct pinctrl_dev *pctld
 
 static inline int pinconf_generic_dt_node_to_map_pin(struct pinctrl_dev *pctldev,
 		struct device_node *np_config, struct pinctrl_map **map,
-		unsigned *num_maps)
+		unsigned int *num_maps)
 {
 	return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
 			PIN_MAP_TYPE_CONFIGS_PIN);
diff --git a/include/linux/pinctrl/pinconf.h b/include/linux/pinctrl/pinconf.h
index f8a8215e9021..770ec2221156 100644
--- a/include/linux/pinctrl/pinconf.h
+++ b/include/linux/pinctrl/pinconf.h
@@ -40,25 +40,25 @@ struct pinconf_ops {
 	bool is_generic;
 #endif
 	int (*pin_config_get) (struct pinctrl_dev *pctldev,
-			       unsigned pin,
+			       unsigned int pin,
 			       unsigned long *config);
 	int (*pin_config_set) (struct pinctrl_dev *pctldev,
-			       unsigned pin,
+			       unsigned int pin,
 			       unsigned long *configs,
-			       unsigned num_configs);
+			       unsigned int num_configs);
 	int (*pin_config_group_get) (struct pinctrl_dev *pctldev,
-				     unsigned selector,
+				     unsigned int selector,
 				     unsigned long *config);
 	int (*pin_config_group_set) (struct pinctrl_dev *pctldev,
-				     unsigned selector,
+				     unsigned int selector,
 				     unsigned long *configs,
-				     unsigned num_configs);
+				     unsigned int num_configs);
 	void (*pin_config_dbg_show) (struct pinctrl_dev *pctldev,
 				     struct seq_file *s,
-				     unsigned offset);
+				     unsigned int offset);
 	void (*pin_config_group_dbg_show) (struct pinctrl_dev *pctldev,
 					   struct seq_file *s,
-					   unsigned selector);
+					   unsigned int selector);
 	void (*pin_config_config_dbg_show) (struct pinctrl_dev *pctldev,
 					    struct seq_file *s,
 					    unsigned long config);
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index 4d252ea00ed1..9a8189ffd0f2 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -54,7 +54,7 @@ struct pingroup {
  * @drv_data: driver-defined per-pin data. pinctrl core does not touch this
  */
 struct pinctrl_pin_desc {
-	unsigned number;
+	unsigned int number;
 	const char *name;
 	void *drv_data;
 };
@@ -82,7 +82,7 @@ struct pinctrl_gpio_range {
 	unsigned int base;
 	unsigned int pin_base;
 	unsigned int npins;
-	unsigned const *pins;
+	unsigned int const *pins;
 	struct gpio_chip *gc;
 };
 
@@ -108,18 +108,18 @@ struct pinctrl_gpio_range {
 struct pinctrl_ops {
 	int (*get_groups_count) (struct pinctrl_dev *pctldev);
 	const char *(*get_group_name) (struct pinctrl_dev *pctldev,
-				       unsigned selector);
+				       unsigned int selector);
 	int (*get_group_pins) (struct pinctrl_dev *pctldev,
-			       unsigned selector,
-			       const unsigned **pins,
-			       unsigned *num_pins);
+			       unsigned int selector,
+			       const unsigned int **pins,
+			       unsigned int *num_pins);
 	void (*pin_dbg_show) (struct pinctrl_dev *pctldev, struct seq_file *s,
-			  unsigned offset);
+			      unsigned int offset);
 	int (*dt_node_to_map) (struct pinctrl_dev *pctldev,
 			       struct device_node *np_config,
-			       struct pinctrl_map **map, unsigned *num_maps);
+			       struct pinctrl_map **map, unsigned int *num_maps);
 	void (*dt_free_map) (struct pinctrl_dev *pctldev,
-			     struct pinctrl_map *map, unsigned num_maps);
+			     struct pinctrl_map *map, unsigned int num_maps);
 };
 
 /**
@@ -193,7 +193,7 @@ extern void pinctrl_add_gpio_range(struct pinctrl_dev *pctldev,
 				struct pinctrl_gpio_range *range);
 extern void pinctrl_add_gpio_ranges(struct pinctrl_dev *pctldev,
 				struct pinctrl_gpio_range *ranges,
-				unsigned nranges);
+				unsigned int nranges);
 extern void pinctrl_remove_gpio_range(struct pinctrl_dev *pctldev,
 				struct pinctrl_gpio_range *range);
 
@@ -203,8 +203,8 @@ extern struct pinctrl_gpio_range *
 pinctrl_find_gpio_range_from_pin(struct pinctrl_dev *pctldev,
 				 unsigned int pin);
 extern int pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
-				const char *pin_group, const unsigned **pins,
-				unsigned *num_pins);
+				  const char *pin_group, const unsigned int **pins,
+				  unsigned int *num_pins);
 
 /**
  * struct pinfunction - Description about a function
diff --git a/include/linux/pinctrl/pinmux.h b/include/linux/pinctrl/pinmux.h
index a7e370965c53..d6f7b58d6ad0 100644
--- a/include/linux/pinctrl/pinmux.h
+++ b/include/linux/pinctrl/pinmux.h
@@ -57,26 +57,26 @@ struct pinctrl_gpio_range;
  *	the pin request.
  */
 struct pinmux_ops {
-	int (*request) (struct pinctrl_dev *pctldev, unsigned offset);
-	int (*free) (struct pinctrl_dev *pctldev, unsigned offset);
+	int (*request) (struct pinctrl_dev *pctldev, unsigned int offset);
+	int (*free) (struct pinctrl_dev *pctldev, unsigned int offset);
 	int (*get_functions_count) (struct pinctrl_dev *pctldev);
 	const char *(*get_function_name) (struct pinctrl_dev *pctldev,
-					  unsigned selector);
+					  unsigned int selector);
 	int (*get_function_groups) (struct pinctrl_dev *pctldev,
-				  unsigned selector,
-				  const char * const **groups,
-				  unsigned *num_groups);
-	int (*set_mux) (struct pinctrl_dev *pctldev, unsigned func_selector,
-			unsigned group_selector);
+				    unsigned int selector,
+				    const char * const **groups,
+				    unsigned int *num_groups);
+	int (*set_mux) (struct pinctrl_dev *pctldev, unsigned int func_selector,
+			unsigned int group_selector);
 	int (*gpio_request_enable) (struct pinctrl_dev *pctldev,
 				    struct pinctrl_gpio_range *range,
-				    unsigned offset);
+				    unsigned int offset);
 	void (*gpio_disable_free) (struct pinctrl_dev *pctldev,
 				   struct pinctrl_gpio_range *range,
-				   unsigned offset);
+				   unsigned int offset);
 	int (*gpio_set_direction) (struct pinctrl_dev *pctldev,
 				   struct pinctrl_gpio_range *range,
-				   unsigned offset,
+				   unsigned int offset,
 				   bool input);
 	bool strict;
 };
-- 
2.43.0.rc1.1.gbec44491f096

