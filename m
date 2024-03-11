Return-Path: <linux-kernel+bounces-98954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7189987818D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4114AB23316
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858E13FE28;
	Mon, 11 Mar 2024 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUV7S3k6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B9C4436E;
	Mon, 11 Mar 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167033; cv=none; b=Kr5Kwcmt6hJ6cmnJ39/P0TPc6HQrL+4umXqJ6sWBP+k0HJhjVIR0QWbf+ZH3k/iN5ZpUi3lf0rSs4q0VH8ICFNYgynh8QAUaidWge7DadoA/ekZN8NEm4nfSobpQ4vkeQKJgujHUm6tBpQrwT/1Ys8Hnx3FYMqkX0apWtBgZh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167033; c=relaxed/simple;
	bh=RAljMRZTESMUnqSWSdhDReDCoHPcNMTfVdGXxHn/jo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NyTETyTo9YUE/wAv5UXjlZDQiO0wTX6ZFeToDoaP2NDmk2DRAb6Li2XrMxF6p0yTL4W56+8O98UK+MlOtLh27OSikmLGyhDEsBjxhx5zltM7tXeyIIHIS/guittcb+Q+VBezOLwUZY1baMtXYZARF6FwzOZA5mOGJt/vePAxAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUV7S3k6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710167032; x=1741703032;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RAljMRZTESMUnqSWSdhDReDCoHPcNMTfVdGXxHn/jo0=;
  b=AUV7S3k6aH2HQiVUrvuesPLprymokxBjhdtP2Nvu5KbbjCeSddfsSlde
   wLFZ6g8JHyIkJhGsaGX2P3yR7bwvT4KPLhyYJWc0jXQeOM/N7P0WsHV2j
   wrrXiaSdxOLRgga6ftSMB3ZGlSb66XdvYzKLBlqTVM15FtRRx6xPXfFW6
   mQCwCvMuHovbcAB9jeM+9kf72ShnkbD51QLvUUtuAASAqv99xHUep+Nzf
   kY6pm/i0Ei3I3c0rfmBzy9nvtb2u1i68PQOGrj6wIqEzY9FjVgrOHZ8wP
   JiKvFIsCUWEMR42LRaIh0tAPCAwhPHSD5M85hjip4vcavt2Vpr1CyoHJJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22352731"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="22352731"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:23:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="937049993"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="937049993"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2024 07:23:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C5872177; Mon, 11 Mar 2024 16:23:47 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: pxa2xx: Make use of struct pingroup
Date: Mon, 11 Mar 2024 16:22:48 +0200
Message-ID: <20240311142346.1261203-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since pin control provides a generic data type for the pin group,
use it in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

This depends on https://lore.kernel.org/r/20240311140833.1168742-1-andriy.shevchenko@linux.intel.com

 drivers/pinctrl/pxa/pinctrl-pxa2xx.c | 31 ++++++++++++++--------------
 drivers/pinctrl/pxa/pinctrl-pxa2xx.h |  7 +------
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
index f24bf49fa82b..9e34b92ff5f2 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -32,7 +32,7 @@ static const char *pxa2xx_pctrl_get_group_name(struct pinctrl_dev *pctldev,
 					       unsigned tgroup)
 {
 	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
-	struct pxa_pinctrl_group *group = pctl->groups + tgroup;
+	struct pingroup *group = pctl->groups + tgroup;
 
 	return group->name;
 }
@@ -43,10 +43,10 @@ static int pxa2xx_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
 				       unsigned *num_pins)
 {
 	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
-	struct pxa_pinctrl_group *group = pctl->groups + tgroup;
+	struct pingroup *group = pctl->groups + tgroup;
 
-	*pins = (unsigned *)&group->pin;
-	*num_pins = 1;
+	*pins = group->pins;
+	*num_pins = group->npins;
 
 	return 0;
 }
@@ -139,20 +139,18 @@ static int pxa2xx_pmx_set_mux(struct pinctrl_dev *pctldev, unsigned function,
 			      unsigned tgroup)
 {
 	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
-	struct pxa_pinctrl_group *group = pctl->groups + tgroup;
+	struct pingroup *g = pctl->groups + tgroup;
+	unsigned int pin = g->pins[0];
 	struct pxa_desc_function *df;
-	int pin, shift;
 	unsigned long flags;
 	void __iomem *gafr, *gpdr;
+	int shift;
 	u32 val;
 
-
-	df = pxa_desc_by_func_group(pctl, group->name,
-				    (pctl->functions + function)->name);
+	df = pxa_desc_by_func_group(pctl, g->name, (pctl->functions + function)->name);
 	if (!df)
 		return -EINVAL;
 
-	pin = group->pin;
 	gafr = pctl->base_gafr[pin / 16];
 	gpdr = pctl->base_gpdr[pin / 32];
 	shift = (pin % 16) << 1;
@@ -186,9 +184,9 @@ static int pxa2xx_pconf_group_get(struct pinctrl_dev *pctldev,
 				  unsigned long *config)
 {
 	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
-	struct pxa_pinctrl_group *g = pctl->groups + group;
+	struct pingroup *g = pctl->groups + group;
+	unsigned int pin = g->pins[0];
 	unsigned long flags;
-	unsigned pin = g->pin;
 	void __iomem *pgsr = pctl->base_pgsr[pin / 32];
 	u32 val;
 
@@ -208,9 +206,9 @@ static int pxa2xx_pconf_group_set(struct pinctrl_dev *pctldev,
 				  unsigned num_configs)
 {
 	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
-	struct pxa_pinctrl_group *g = pctl->groups + group;
+	struct pingroup *g = pctl->groups + group;
+	unsigned int pin = g->pins[0];
 	unsigned long flags;
-	unsigned pin = g->pin;
 	void __iomem *pgsr = pctl->base_pgsr[pin / 32];
 	int i, is_set = 0;
 	u32 val;
@@ -328,8 +326,8 @@ static int pxa2xx_build_groups(struct pxa_pinctrl *pctl)
 static int pxa2xx_build_state(struct pxa_pinctrl *pctl,
 			      const struct pxa_desc_pin *ppins, int npins)
 {
-	struct pxa_pinctrl_group *group;
 	struct pinctrl_pin_desc *pins;
+	struct pingroup *group;
 	int ret, i;
 
 	pctl->npins = npins;
@@ -353,7 +351,8 @@ static int pxa2xx_build_state(struct pxa_pinctrl *pctl,
 	for (i = 0; i < npins; i++) {
 		group = pctl->groups + i;
 		group->name = ppins[i].pin.name;
-		group->pin = ppins[i].pin.number;
+		group->pins = &ppins[i].pin.number;
+		group->npins = 1;
 	}
 
 	ret = pxa2xx_build_functions(pctl);
diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.h b/drivers/pinctrl/pxa/pinctrl-pxa2xx.h
index a0bdcec55158..b292b79efdf8 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.h
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.h
@@ -52,11 +52,6 @@ struct pxa_desc_pin {
 	struct pxa_desc_function	*functions;
 };
 
-struct pxa_pinctrl_group {
-	const char	*name;
-	unsigned	pin;
-};
-
 struct pxa_pinctrl {
 	spinlock_t			lock;
 	void __iomem			**base_gafr;
@@ -68,7 +63,7 @@ struct pxa_pinctrl {
 	unsigned			npins;
 	const struct pxa_desc_pin	*ppins;
 	unsigned			ngroups;
-	struct pxa_pinctrl_group	*groups;
+	struct pingroup			*groups;
 	unsigned			nfuncs;
 	struct pinfunction		*functions;
 	char				*name;
-- 
2.43.0.rc1.1.gbec44491f096


