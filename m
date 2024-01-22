Return-Path: <linux-kernel+bounces-32952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF4D83626B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE282B23549
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0003D556;
	Mon, 22 Jan 2024 11:44:33 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460C3A1BD;
	Mon, 22 Jan 2024 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923872; cv=none; b=o3AtZW7AP+dDF5biAOnqDx+oia0MO9qfgtFRx2RSeR/1De8VRJwQt192xYOZVcuxAyWtYymUdRY+VVEYHLIKQd33KRjLhWIBOAXrQWobkibOowkMslez7PYwVbn4wlvhhpZlG+s0g1FKXb3mX7r3p5X08gaf0BHa42ZPWPHPf0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923872; c=relaxed/simple;
	bh=fw+tx0QLXKQOvFgAfYfyFRwUUJeuGesaym5awIhseJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOe+ifPrbmI4NCx7svsdzijU/9pzn8tj8cZCRQXkcRVuHyvNTWPQv+6W4MeF0cQLDqLgphjNpWy8FbOqmsAoPOPfbQoLnjvlJE+FBFph25tkYMSwNd7qXtbR8+OrsXT//9/B55MOBfVwrGC0btD+D5+AFNa4SjEgFAKf/7PbMs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id c437ba25a9c7dce7; Mon, 22 Jan 2024 12:44:23 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0D45D669540;
	Mon, 22 Jan 2024 12:44:23 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v1 09/12] PM: sleep: stats: Log errors right after running suspend callbacks
Date: Mon, 22 Jan 2024 12:35:32 +0100
Message-ID: <9237520.CDJkKcVGEf@kreacher>
In-Reply-To: <5760158.DvuYhMxLoT@kreacher>
References: <5760158.DvuYhMxLoT@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgrnhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The error logging and failure statistics updates are carried out in two
places in each system-wide device suspend phase, which is unnecessary
code duplication, so do that in one place in each phase, right after
invoking device suspend callbacks.

While at it, add "noirq" or "late" to the "async" string printed when
the failing device callback in the "noirq" or "late" suspend phase,
respectively, was run asynchronously.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   49 ++++++++++++----------------------------------
 1 file changed, 13 insertions(+), 36 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1244,6 +1244,8 @@ Run:
 	error = dpm_run_callback(callback, dev, state, info);
 	if (error) {
 		async_error = error;
+		dpm_save_failed_dev(dev_name(dev));
+		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
 		goto Complete;
 	}
 
@@ -1273,14 +1275,8 @@ Complete:
 static void async_suspend_noirq(void *data, async_cookie_t cookie)
 {
 	struct device *dev = data;
-	int error;
-
-	error = __device_suspend_noirq(dev, pm_transition, true);
-	if (error) {
-		dpm_save_failed_dev(dev_name(dev));
-		pm_dev_err(dev, pm_transition, " async", error);
-	}
 
+	__device_suspend_noirq(dev, pm_transition, true);
 	put_device(dev);
 }
 
@@ -1312,12 +1308,8 @@ static int dpm_noirq_suspend_devices(pm_
 
 		mutex_lock(&dpm_list_mtx);
 
-		if (error) {
-			pm_dev_err(dev, state, " noirq", error);
-			dpm_save_failed_dev(dev_name(dev));
-		} else if (!list_empty(&dev->power.entry)) {
+		if (!error && !list_empty(&dev->power.entry))
 			list_move(&dev->power.entry, &dpm_noirq_list);
-		}
 
 		mutex_unlock(&dpm_list_mtx);
 
@@ -1437,6 +1429,8 @@ Run:
 	error = dpm_run_callback(callback, dev, state, info);
 	if (error) {
 		async_error = error;
+		dpm_save_failed_dev(dev_name(dev));
+		pm_dev_err(dev, state, async ? " async late" : " late", error);
 		goto Complete;
 	}
 	dpm_propagate_wakeup_to_parent(dev);
@@ -1453,13 +1447,8 @@ Complete:
 static void async_suspend_late(void *data, async_cookie_t cookie)
 {
 	struct device *dev = data;
-	int error;
 
-	error = __device_suspend_late(dev, pm_transition, true);
-	if (error) {
-		dpm_save_failed_dev(dev_name(dev));
-		pm_dev_err(dev, pm_transition, " async", error);
-	}
+	__device_suspend_late(dev, pm_transition, true);
 	put_device(dev);
 }
 
@@ -1500,11 +1489,6 @@ int dpm_suspend_late(pm_message_t state)
 		if (!list_empty(&dev->power.entry))
 			list_move(&dev->power.entry, &dpm_late_early_list);
 
-		if (error) {
-			pm_dev_err(dev, state, " late", error);
-			dpm_save_failed_dev(dev_name(dev));
-		}
-
 		mutex_unlock(&dpm_list_mtx);
 
 		put_device(dev);
@@ -1719,8 +1703,11 @@ static int __device_suspend(struct devic
 	dpm_watchdog_clear(&wd);
 
  Complete:
-	if (error)
+	if (error) {
 		async_error = error;
+		dpm_save_failed_dev(dev_name(dev));
+		pm_dev_err(dev, state, async ? " async" : "", error);
+	}
 
 	complete_all(&dev->power.completion);
 	TRACE_SUSPEND(error);
@@ -1730,14 +1717,8 @@ static int __device_suspend(struct devic
 static void async_suspend(void *data, async_cookie_t cookie)
 {
 	struct device *dev = data;
-	int error;
-
-	error = __device_suspend(dev, pm_transition, true);
-	if (error) {
-		dpm_save_failed_dev(dev_name(dev));
-		pm_dev_err(dev, pm_transition, " async", error);
-	}
 
+	__device_suspend(dev, pm_transition, true);
 	put_device(dev);
 }
 
@@ -1778,12 +1759,8 @@ int dpm_suspend(pm_message_t state)
 
 		mutex_lock(&dpm_list_mtx);
 
-		if (error) {
-			pm_dev_err(dev, state, "", error);
-			dpm_save_failed_dev(dev_name(dev));
-		} else if (!list_empty(&dev->power.entry)) {
+		if (!error && !list_empty(&dev->power.entry))
 			list_move(&dev->power.entry, &dpm_suspended_list);
-		}
 
 		mutex_unlock(&dpm_list_mtx);
 




