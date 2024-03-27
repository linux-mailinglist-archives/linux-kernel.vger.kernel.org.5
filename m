Return-Path: <linux-kernel+bounces-120516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C3888D89A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC596B233BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85542E645;
	Wed, 27 Mar 2024 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="R7DTwvkJ"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818422D7B8;
	Wed, 27 Mar 2024 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527385; cv=none; b=eOfKKBv9k/R+g2sshBeinsMaWUZVblW20GN0sQ2TdElrVFyvpy7tr9UIZD8gZxy3dCHwk1ivgj8JZ65oo94looDsU285pHF5dOH3rS9PpSBhxkuP5K64IYOmeFwQr7WCqs+Xg9xg3U7GpfFFnZQR42csAjFoknPzgqWukpQtTRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527385; c=relaxed/simple;
	bh=5XVLYxZnsE3IFzszPgGoCMdQGtUkTEW8giYsWGBSh3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8eBaGsySh3Ns0wk0MePQvfDgdPXJqzGjj49CabyKFl+sIKvzWmoP8/V6V6XHMy4KcSTnNmn2JR4ao0ywjhOhDakLLBKfYcxX558xAgNZkthM96V76lWSKvxd1ZNsbV2wCZdviV1dwGIQtJdBKj3c2QYC4BkTcUtIrzdmjvj8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=R7DTwvkJ; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 4A71260462;
	Wed, 27 Mar 2024 08:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711527382;
	bh=5XVLYxZnsE3IFzszPgGoCMdQGtUkTEW8giYsWGBSh3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7DTwvkJlHqP04o/uUpJuZQJPY3/StqC/WYALswXEh0U7V66CkVLSd0BMzx5cXkmH
	 +oRFSsH0XiNU5MZc0rkAM/hAWlqv+mU3EK/vz0dFuiPMke+DBPawEYCFCJSYqabzmv
	 0aWpoe9p2CZzjXg+NYgnQgSQfCEo2dwEJ4oH5gpcTC+p1oqkH7DyhGg9MYwdPIgBpa
	 KJt+kh48IgqRLYPvYONp5GMi+HOgXMlrA9ULZdP60lkmEiMh3BF0Fc9xsnEA+uEiWc
	 5gm+TkIY2cPdyVugAek4/xvL5rRke0qcijVd2NjY3JziCrnJyhsmbyABHdFYCPxeSh
	 kEvxP3FQ2XUcA==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] bus: ti-sysc: Drop legacy idle quirk handling
Date: Wed, 27 Mar 2024 10:15:08 +0200
Message-ID: <20240327081508.36747-6-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327081508.36747-1-tony@atomide.com>
References: <20240327081508.36747-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no more users that need the legacy idle quirk so let's drop
the legacy idle quirk handling. This simplifies the PM code to just
sysc_pm_ops with unified handling for all the interconnect targets.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c                 | 109 +-------------------------
 include/linux/platform_data/ti-sysc.h |   1 -
 2 files changed, 2 insertions(+), 108 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1469,8 +1469,7 @@ static int __maybe_unused sysc_noirq_suspend(struct device *dev)
 
 	ddata = dev_get_drvdata(dev);
 
-	if (ddata->cfg.quirks &
-	    (SYSC_QUIRK_LEGACY_IDLE | SYSC_QUIRK_NO_IDLE))
+	if (ddata->cfg.quirks & SYSC_QUIRK_NO_IDLE)
 		return 0;
 
 	if (!ddata->enabled)
@@ -1488,8 +1487,7 @@ static int __maybe_unused sysc_noirq_resume(struct device *dev)
 
 	ddata = dev_get_drvdata(dev);
 
-	if (ddata->cfg.quirks &
-	    (SYSC_QUIRK_LEGACY_IDLE | SYSC_QUIRK_NO_IDLE))
+	if (ddata->cfg.quirks & SYSC_QUIRK_NO_IDLE)
 		return 0;
 
 	if (ddata->cfg.quirks & SYSC_QUIRK_REINIT_ON_RESUME) {
@@ -2457,89 +2455,6 @@ static int __maybe_unused sysc_child_runtime_resume(struct device *dev)
 	return pm_generic_runtime_resume(dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sysc_child_suspend_noirq(struct device *dev)
-{
-	struct sysc *ddata;
-	int error;
-
-	ddata = sysc_child_to_parent(dev);
-
-	dev_dbg(ddata->dev, "%s %s\n", __func__,
-		ddata->name ? ddata->name : "");
-
-	error = pm_generic_suspend_noirq(dev);
-	if (error) {
-		dev_err(dev, "%s error at %i: %i\n",
-			__func__, __LINE__, error);
-
-		return error;
-	}
-
-	if (!pm_runtime_status_suspended(dev)) {
-		error = pm_generic_runtime_suspend(dev);
-		if (error) {
-			dev_dbg(dev, "%s busy at %i: %i\n",
-				__func__, __LINE__, error);
-
-			return 0;
-		}
-
-		error = sysc_runtime_suspend(ddata->dev);
-		if (error) {
-			dev_err(dev, "%s error at %i: %i\n",
-				__func__, __LINE__, error);
-
-			return error;
-		}
-
-		ddata->child_needs_resume = true;
-	}
-
-	return 0;
-}
-
-static int sysc_child_resume_noirq(struct device *dev)
-{
-	struct sysc *ddata;
-	int error;
-
-	ddata = sysc_child_to_parent(dev);
-
-	dev_dbg(ddata->dev, "%s %s\n", __func__,
-		ddata->name ? ddata->name : "");
-
-	if (ddata->child_needs_resume) {
-		ddata->child_needs_resume = false;
-
-		error = sysc_runtime_resume(ddata->dev);
-		if (error)
-			dev_err(ddata->dev,
-				"%s runtime resume error: %i\n",
-				__func__, error);
-
-		error = pm_generic_runtime_resume(dev);
-		if (error)
-			dev_err(ddata->dev,
-				"%s generic runtime resume: %i\n",
-				__func__, error);
-	}
-
-	return pm_generic_resume_noirq(dev);
-}
-#endif
-
-static struct dev_pm_domain sysc_child_pm_domain = {
-	.ops = {
-		SET_RUNTIME_PM_OPS(sysc_child_runtime_suspend,
-				   sysc_child_runtime_resume,
-				   NULL)
-		USE_PLATFORM_PM_SLEEP_OPS
-		SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(sysc_child_suspend_noirq,
-					      sysc_child_resume_noirq)
-	}
-};
-
 /* Caller needs to take list_lock if ever used outside of cpu_pm */
 static void sysc_reinit_modules(struct sysc_soc_info *soc)
 {
@@ -2610,25 +2525,6 @@ static void sysc_add_restored(struct sysc *ddata)
 	mutex_unlock(&sysc_soc->list_lock);
 }
 
-/**
- * sysc_legacy_idle_quirk - handle children in omap_device compatible way
- * @ddata: device driver data
- * @child: child device driver
- *
- * Allow idle for child devices as done with _od_runtime_suspend().
- * Otherwise many child devices will not idle because of the permanent
- * parent usecount set in pm_runtime_irq_safe().
- *
- * Note that the long term solution is to just modify the child device
- * drivers to not set pm_runtime_irq_safe() and then this can be just
- * dropped.
- */
-static void sysc_legacy_idle_quirk(struct sysc *ddata, struct device *child)
-{
-	if (ddata->cfg.quirks & SYSC_QUIRK_LEGACY_IDLE)
-		dev_pm_domain_set(child, &sysc_child_pm_domain);
-}
-
 static int sysc_notifier_call(struct notifier_block *nb,
 			      unsigned long event, void *device)
 {
@@ -2645,7 +2541,6 @@ static int sysc_notifier_call(struct notifier_block *nb,
 		error = sysc_child_add_clocks(ddata, dev);
 		if (error)
 			return error;
-		sysc_legacy_idle_quirk(ddata, dev);
 		break;
 	default:
 		break;
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -71,7 +71,6 @@ struct sysc_regbits {
 #define SYSC_QUIRK_SWSUP_SIDLE_ACT	BIT(12)
 #define SYSC_QUIRK_SWSUP_SIDLE		BIT(11)
 #define SYSC_QUIRK_EXT_OPT_CLOCK	BIT(10)
-#define SYSC_QUIRK_LEGACY_IDLE		BIT(9)
 #define SYSC_QUIRK_RESET_STATUS		BIT(8)
 #define SYSC_QUIRK_NO_IDLE		BIT(7)
 #define SYSC_QUIRK_NO_IDLE_ON_INIT	BIT(6)
-- 
2.44.0

