Return-Path: <linux-kernel+bounces-98941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9BC878153
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A0B1C20481
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ACB3FB9C;
	Mon, 11 Mar 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bd5kjuqk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C13E46D;
	Mon, 11 Mar 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710166120; cv=none; b=LW8gd1reXEJ7dhT75tWdV1ewrrr3eOAHY/AmNtesjNAVpoML1j0Ib/J6Po2ulQww6f9yio4inbR/71Z/lYCxNxk9tSQV5oSfUPyhLYevHIuv2jzlwo8zanC2ICQMw+1wx7d1xV3vMxtzZgelKB20jsdmJliuAdN96GCvQESFgrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710166120; c=relaxed/simple;
	bh=4opJTjHk6eRIzxcJR3OPwb0vcJcIOIZAXBxw8+TIagA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s2I8pS1SSTDUnVKGrF2hGrKVHZ8W38idhE7Ussn67Hi44OHpcV6VJDE11Hm7N4MwFtudx0a0o1JyByAq42Sbmkv7S6E+mvmGiU3uUiKP89aO5I/FrgbwqLk2MOJOdWrevO1QyWFvi4MERykYdY6ltJ3/hCYWQpXqMI0Lig7o7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bd5kjuqk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710166119; x=1741702119;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4opJTjHk6eRIzxcJR3OPwb0vcJcIOIZAXBxw8+TIagA=;
  b=bd5kjuqknv7jNcVOdKnAxMXk4OThBZ99rfbRUPTZkCDs8ygqFpy/1gp3
   EU1ZajYHJ4lJLbyIaRfgf2gkuYEEkbcEfpWcUtQCs+qTquCLlN9WgWuOR
   QfNT+qMJX1JrcaOV4R+TnvJTGLVA65ijyR0FTqXszQKTH/4ft0KWL3C8C
   9O+FG7TaNPCf7wBn/Z9GLRjMDGNvfSKdLflDo/7E6SFumHZFZioRmSpo3
   XO7s1BZMJTqGt4RBNZXzrPPddwo5Cbtkw/Gcd4KBNqvQNSGWELBXSX8ao
   W+6DmlYtON55SJ+1TK0jx5wv51wFfIJ0/Pe9DFLpMtDymYEAfB/5TQSVG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="22351046"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="22351046"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 07:08:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="937049955"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="937049955"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2024 07:08:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 393A1177; Mon, 11 Mar 2024 16:08:34 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: pxa2xx: Make use of struct pinfunction
Date: Mon, 11 Mar 2024 16:08:33 +0200
Message-ID: <20240311140833.1168742-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since pin control provides a generic data type for the pin function,
use it in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c | 24 ++++++++++--------------
 drivers/pinctrl/pxa/pinctrl-pxa2xx.h |  8 +-------
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
index d2568dab8c78..f24bf49fa82b 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -109,7 +109,7 @@ static const char *pxa2xx_pmx_get_func_name(struct pinctrl_dev *pctldev,
 					    unsigned function)
 {
 	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
-	struct pxa_pinctrl_function *pf = pctl->functions + function;
+	struct pinfunction *pf = pctl->functions + function;
 
 	return pf->name;
 }
@@ -127,7 +127,7 @@ static int pxa2xx_pmx_get_func_groups(struct pinctrl_dev *pctldev,
 				      unsigned * const num_groups)
 {
 	struct pxa_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
-	struct pxa_pinctrl_function *pf = pctl->functions + function;
+	struct pinfunction *pf = pctl->functions + function;
 
 	*groups = pf->groups;
 	*num_groups = pf->ngroups;
@@ -249,11 +249,11 @@ static struct pinctrl_desc pxa2xx_pinctrl_desc = {
 	.pmxops		= &pxa2xx_pinmux_ops,
 };
 
-static const struct pxa_pinctrl_function *
-pxa2xx_find_function(struct pxa_pinctrl *pctl, const char *fname,
-		     const struct pxa_pinctrl_function *functions)
+static const struct pinfunction *pxa2xx_find_function(struct pxa_pinctrl *pctl,
+						      const char *fname,
+						      const struct pinfunction *functions)
 {
-	const struct pxa_pinctrl_function *func;
+	const struct pinfunction *func;
 
 	for (func = functions; func->name; func++)
 		if (!strcmp(fname, func->name))
@@ -264,8 +264,8 @@ pxa2xx_find_function(struct pxa_pinctrl *pctl, const char *fname,
 
 static int pxa2xx_build_functions(struct pxa_pinctrl *pctl)
 {
+	struct pinfunction *functions;
 	int i;
-	struct pxa_pinctrl_function *functions;
 	struct pxa_desc_function *df;
 
 	/*
@@ -296,9 +296,9 @@ static int pxa2xx_build_functions(struct pxa_pinctrl *pctl)
 static int pxa2xx_build_groups(struct pxa_pinctrl *pctl)
 {
 	int i, j, ngroups;
-	struct pxa_pinctrl_function *func;
 	struct pxa_desc_function *df;
-	char **gtmp;
+	struct pinfunction *func;
+	const char **gtmp;
 
 	gtmp = devm_kmalloc_array(pctl->dev, pctl->npins, sizeof(*gtmp),
 				  GFP_KERNEL);
@@ -316,13 +316,9 @@ static int pxa2xx_build_groups(struct pxa_pinctrl *pctl)
 						pctl->ppins[j].pin.name;
 		func = pctl->functions + i;
 		func->ngroups = ngroups;
-		func->groups =
-			devm_kmalloc_array(pctl->dev, ngroups,
-					   sizeof(char *), GFP_KERNEL);
+		func->groups = devm_kmemdup(pctl->dev, gtmp, ngroups * sizeof(*gtmp), GFP_KERNEL);
 		if (!func->groups)
 			return -ENOMEM;
-
-		memcpy(func->groups, gtmp, ngroups * sizeof(*gtmp));
 	}
 
 	devm_kfree(pctl->dev, gtmp);
diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.h b/drivers/pinctrl/pxa/pinctrl-pxa2xx.h
index d86d47dbbc94..a0bdcec55158 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.h
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.h
@@ -57,12 +57,6 @@ struct pxa_pinctrl_group {
 	unsigned	pin;
 };
 
-struct pxa_pinctrl_function {
-	const char	*name;
-	const char	**groups;
-	unsigned	ngroups;
-};
-
 struct pxa_pinctrl {
 	spinlock_t			lock;
 	void __iomem			**base_gafr;
@@ -76,7 +70,7 @@ struct pxa_pinctrl {
 	unsigned			ngroups;
 	struct pxa_pinctrl_group	*groups;
 	unsigned			nfuncs;
-	struct pxa_pinctrl_function	*functions;
+	struct pinfunction		*functions;
 	char				*name;
 };
 
-- 
2.43.0.rc1.1.gbec44491f096


