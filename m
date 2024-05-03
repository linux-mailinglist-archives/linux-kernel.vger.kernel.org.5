Return-Path: <linux-kernel+bounces-167898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 283CF8BB0D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913D91F23C81
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F8B15664E;
	Fri,  3 May 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PleDJKNh"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9731115539B
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753350; cv=none; b=uAYkh6gWsumhy3NuuPdhdkvm0mEvR3fnrpBx2/dUSJ6rU0AJJP+kYEOh8HSzlNRcUWrXIZem7BgcxbVPtL5cHq+LsT3DcWh7kAaxGg0ANt5P97cNTE0IHaRUJf3JBWdcCFBa8EHNmARQ9h8iZiBWNy8TWOcRLAgTpHLGdmAUqsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753350; c=relaxed/simple;
	bh=sxWk1kyzJe459ZF807IGaoNEXtJYOMA0WnR1dYVPGd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=erSfFbIbGzG8VPuo7m33EwnGTsATl5Hx2tT55eE49I7oJ4DHopXsBwIPYruBJ+fTkpGmL8CHK1RU5OJgIm3hWZTaKKQ5omT73rn/4DBoV8xZhHSfP9CXOvP5Xp4qHvue3bfic33C/49hNY9eqXDVWyhMILlOxTnKYMJJ9pALNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PleDJKNh; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714753347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CpdUrrfvqPyGvsIJRAWt/WzCNSwYYm+TR0RUAGPWFiU=;
	b=PleDJKNh3NgsRKu4C1QCkkI8sbW0Tw4lxhT8YQGxlEK2tijEYkETKFq6lLa/w95KZJoXs+
	q6xg7mp7J7Wzzr+mzDv5HzNvUsDkPb8HlPFO+ky3QWTDTgfG4Mg99QMB+A6haBaP+ZShkO
	ZdksKWvWI8a8ztZDw9b5u3rS3mQJeO0=
From: Sean Anderson <sean.anderson@linux.dev>
To: Linus Walleij <linus.walleij@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-gpio@vger.kernel.org
Cc: Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 2/2] pinctrl: zynqmp: Support muxing individual pins
Date: Fri,  3 May 2024 12:22:17 -0400
Message-Id: <20240503162217.1999467-3-sean.anderson@linux.dev>
In-Reply-To: <20240503162217.1999467-1-sean.anderson@linux.dev>
References: <20240503162217.1999467-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

While muxing groups of pins at once can be convenient for large
interfaces, it can also be rigid. This is because the group is set to
all pins which support a particular function, even though not all pins
may be used. For example, the sdhci0 function may be used with a 8-bit
eMMC, 4-bit SD card, or even a 1-bit SD card. In these cases, the extra
pins may be repurposed for other uses, but this is not currently
allowed.

Add a new group for each pin which can be muxed. These groups are part
of each function the pin can be muxed to. We treat group selectors
beyond the number of groups as "pin" groups. To set this up, we
initialize groups before functions, and then create a bitmap of used
pins for each function. These used pins are appended to the function's
list of groups.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/pinctrl/pinctrl-zynqmp.c | 61 ++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index 5c46b7d7ebcb..4829150ab069 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -10,6 +10,7 @@
 
 #include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
 
+#include <linux/bitmap.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -97,7 +98,7 @@ static int zynqmp_pctrl_get_groups_count(struct pinctrl_dev *pctldev)
 {
 	struct zynqmp_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
-	return pctrl->ngroups;
+	return pctrl->ngroups + zynqmp_desc.npins;
 }
 
 static const char *zynqmp_pctrl_get_group_name(struct pinctrl_dev *pctldev,
@@ -105,7 +106,10 @@ static const char *zynqmp_pctrl_get_group_name(struct pinctrl_dev *pctldev,
 {
 	struct zynqmp_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
-	return pctrl->groups[selector].name;
+	if (selector < pctrl->ngroups)
+		return pctrl->groups[selector].name;
+
+	return zynqmp_desc.pins[selector - pctrl->ngroups].name;
 }
 
 static int zynqmp_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
@@ -115,8 +119,13 @@ static int zynqmp_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
 {
 	struct zynqmp_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 
-	*pins = pctrl->groups[selector].pins;
-	*npins = pctrl->groups[selector].npins;
+	if (selector < pctrl->ngroups) {
+		*pins = pctrl->groups[selector].pins;
+		*npins = pctrl->groups[selector].npins;
+	} else {
+		*pins = &zynqmp_desc.pins[selector - pctrl->ngroups].number;
+		*npins = 1;
+	}
 
 	return 0;
 }
@@ -560,10 +569,12 @@ static int zynqmp_pinctrl_prepare_func_groups(struct device *dev, u32 fid,
 {
 	u16 resp[NUM_GROUPS_PER_RESP] = {0};
 	const char **fgroups;
-	int ret, index, i;
+	int ret, index, i, pin;
+	unsigned int npins;
+	unsigned long *used_pins __free(bitmap) =
+		bitmap_zalloc(zynqmp_desc.npins, GFP_KERNEL);
 
-	fgroups = devm_kcalloc(dev, func->ngroups, sizeof(*fgroups), GFP_KERNEL);
-	if (!fgroups)
+	if (!used_pins)
 		return -ENOMEM;
 
 	for (index = 0; index < func->ngroups; index += NUM_GROUPS_PER_RESP) {
@@ -578,23 +589,37 @@ static int zynqmp_pinctrl_prepare_func_groups(struct device *dev, u32 fid,
 			if (resp[i] == RESERVED_GROUP)
 				continue;
 
-			fgroups[index + i] = devm_kasprintf(dev, GFP_KERNEL,
-							    "%s_%d_grp",
-							    func->name,
-							    index + i);
-			if (!fgroups[index + i])
-				return -ENOMEM;
-
 			groups[resp[i]].name = devm_kasprintf(dev, GFP_KERNEL,
 							      "%s_%d_grp",
 							      func->name,
 							      index + i);
 			if (!groups[resp[i]].name)
 				return -ENOMEM;
+
+			for (pin = 0; pin < groups[resp[i]].npins; pin++)
+				set_bit(groups[resp[i]].pins[pin], used_pins);
 		}
 	}
 done:
+	npins = bitmap_weight(used_pins, zynqmp_desc.npins);
+	fgroups = devm_kcalloc(dev, func->ngroups + npins, sizeof(*fgroups),
+			       GFP_KERNEL);
+	if (!fgroups)
+		return -ENOMEM;
+
+	for (i = 0; i < func->ngroups; i++) {
+		fgroups[i] = devm_kasprintf(dev, GFP_KERNEL, "%s_%d_grp",
+					    func->name, i);
+		if (!fgroups[i])
+			return -ENOMEM;
+	}
+
+	pin = 0;
+	for_each_set_bit(pin, used_pins, zynqmp_desc.npins)
+		fgroups[i++] = zynqmp_desc.pins[pin].name;
+
 	func->groups = fgroups;
+	func->ngroups += npins;
 
 	return 0;
 }
@@ -772,6 +797,10 @@ static int zynqmp_pinctrl_prepare_function_info(struct device *dev,
 	if (!groups)
 		return -ENOMEM;
 
+	ret = zynqmp_pinctrl_prepare_group_pins(dev, groups, pctrl->ngroups);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < pctrl->nfuncs; i++) {
 		ret = zynqmp_pinctrl_prepare_func_groups(dev, i, &funcs[i],
 							 groups);
@@ -779,10 +808,6 @@ static int zynqmp_pinctrl_prepare_function_info(struct device *dev,
 			return ret;
 	}
 
-	ret = zynqmp_pinctrl_prepare_group_pins(dev, groups, pctrl->ngroups);
-	if (ret)
-		return ret;
-
 	pctrl->funcs = funcs;
 	pctrl->groups = groups;
 
-- 
2.35.1.1320.gc452695387.dirty


