Return-Path: <linux-kernel+bounces-43111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E49840BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C5B282F75
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3122315B114;
	Mon, 29 Jan 2024 16:32:11 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB615AACD;
	Mon, 29 Jan 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545930; cv=none; b=LmCY/kkC1ESYyScfXSOhsuWliNl2dpH+bP/vpxtd6s7c0SOZSXBScxDMBAVlDpcLjb+69Nw9UgsxN5b/3OpiCVfkZ4dZeNfYxi21nsTOshvfOIg/znLVUFNJLXnIUUztizeY8C+mtpieO9gMVy0U2FuQF10mQavEldXilyTj7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545930; c=relaxed/simple;
	bh=7fxQNM1F9gSwYD3pmbV6BTo0di62ynoQFOfMMO14Uo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCP+0RnSdgqpqxcvtShChS+45ZjB3p/7V0vSAoZ81K4uZ0TiraovnJqg82H2SViq1iqCiE0hoxqxmogIG8YiTR1nd/rhwEPRtNgPrDrVReybGEILmH+JnNWp5OVfKp/N372GPNe1l+0s+GX/OF+Rh4ogbzxCJO7WaNmneP/cYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 6cb907a726e0e30d; Mon, 29 Jan 2024 17:32:00 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B771966975C;
	Mon, 29 Jan 2024 17:31:59 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v2 10/10] PM: sleep: Call dpm_async_fn() directly in each suspend phase
Date: Mon, 29 Jan 2024 17:29:41 +0100
Message-ID: <2203732.Icojqenx9y@kreacher>
In-Reply-To: <5770175.DvuYhMxLoT@kreacher>
References: <5770175.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgrnhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Simplify the system-wide suspend of devices by invoking dpm_async_fn()
directly from the main loop in each suspend phase instead of using an
additional wrapper function for running it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes.

---
 drivers/base/power/main.c |   61 ++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1192,7 +1192,7 @@ static void dpm_superior_set_must_resume
 }
 
 /**
- * __device_suspend_noirq - Execute a "noirq suspend" callback for given device.
+ * device_suspend_noirq - Execute a "noirq suspend" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being suspended asynchronously.
@@ -1200,7 +1200,7 @@ static void dpm_superior_set_must_resume
  * The driver of @dev will not receive interrupts while this function is being
  * executed.
  */
-static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool async)
+static int device_suspend_noirq(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -1277,18 +1277,10 @@ static void async_suspend_noirq(void *da
 {
 	struct device *dev = data;
 
-	__device_suspend_noirq(dev, pm_transition, true);
+	device_suspend_noirq(dev, pm_transition, true);
 	put_device(dev);
 }
 
-static int device_suspend_noirq(struct device *dev)
-{
-	if (dpm_async_fn(dev, async_suspend_noirq))
-		return 0;
-
-	return __device_suspend_noirq(dev, pm_transition, false);
-}
-
 static int dpm_noirq_suspend_devices(pm_message_t state)
 {
 	ktime_t starttime = ktime_get();
@@ -1305,10 +1297,15 @@ static int dpm_noirq_suspend_devices(pm_
 		struct device *dev = to_device(dpm_late_early_list.prev);
 
 		list_move(&dev->power.entry, &dpm_noirq_list);
+
+		if (dpm_async_fn(dev, async_suspend_noirq))
+			continue;
+
 		get_device(dev);
+
 		mutex_unlock(&dpm_list_mtx);
 
-		error = device_suspend_noirq(dev);
+		error = device_suspend_noirq(dev, state, false);
 
 		put_device(dev);
 
@@ -1369,14 +1366,14 @@ static void dpm_propagate_wakeup_to_pare
 }
 
 /**
- * __device_suspend_late - Execute a "late suspend" callback for given device.
+ * device_suspend_late - Execute a "late suspend" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being suspended asynchronously.
  *
  * Runtime PM is disabled for @dev while this function is being executed.
  */
-static int __device_suspend_late(struct device *dev, pm_message_t state, bool async)
+static int device_suspend_late(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -1447,18 +1444,10 @@ static void async_suspend_late(void *dat
 {
 	struct device *dev = data;
 
-	__device_suspend_late(dev, pm_transition, true);
+	device_suspend_late(dev, pm_transition, true);
 	put_device(dev);
 }
 
-static int device_suspend_late(struct device *dev)
-{
-	if (dpm_async_fn(dev, async_suspend_late))
-		return 0;
-
-	return __device_suspend_late(dev, pm_transition, false);
-}
-
 /**
  * dpm_suspend_late - Execute "late suspend" callbacks for all devices.
  * @state: PM transition of the system being carried out.
@@ -1481,11 +1470,15 @@ int dpm_suspend_late(pm_message_t state)
 		struct device *dev = to_device(dpm_suspended_list.prev);
 
 		list_move(&dev->power.entry, &dpm_late_early_list);
+
+		if (dpm_async_fn(dev, async_suspend_late))
+			continue;
+
 		get_device(dev);
 
 		mutex_unlock(&dpm_list_mtx);
 
-		error = device_suspend_late(dev);
+		error = device_suspend_late(dev, state, false);
 
 		put_device(dev);
 
@@ -1582,12 +1575,12 @@ static void dpm_clear_superiors_direct_c
 }
 
 /**
- * __device_suspend - Execute "suspend" callbacks for given device.
+ * device_suspend - Execute "suspend" callbacks for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
  * @async: If true, the device is being suspended asynchronously.
  */
-static int __device_suspend(struct device *dev, pm_message_t state, bool async)
+static int device_suspend(struct device *dev, pm_message_t state, bool async)
 {
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
@@ -1716,18 +1709,10 @@ static void async_suspend(void *data, as
 {
 	struct device *dev = data;
 
-	__device_suspend(dev, pm_transition, true);
+	device_suspend(dev, pm_transition, true);
 	put_device(dev);
 }
 
-static int device_suspend(struct device *dev)
-{
-	if (dpm_async_fn(dev, async_suspend))
-		return 0;
-
-	return __device_suspend(dev, pm_transition, false);
-}
-
 /**
  * dpm_suspend - Execute "suspend" callbacks for all non-sysdev devices.
  * @state: PM transition of the system being carried out.
@@ -1752,11 +1737,15 @@ int dpm_suspend(pm_message_t state)
 		struct device *dev = to_device(dpm_prepared_list.prev);
 
 		list_move(&dev->power.entry, &dpm_suspended_list);
+
+		if (dpm_async_fn(dev, async_suspend))
+			continue;
+
 		get_device(dev);
 
 		mutex_unlock(&dpm_list_mtx);
 
-		error = device_suspend(dev);
+		error = device_suspend(dev, state, false);
 
 		put_device(dev);
 




