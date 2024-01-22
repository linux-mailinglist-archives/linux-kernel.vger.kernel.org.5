Return-Path: <linux-kernel+bounces-32954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E1983626D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0005290973
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E693D968;
	Mon, 22 Jan 2024 11:44:33 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6B53CF7C;
	Mon, 22 Jan 2024 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923873; cv=none; b=qjOSBp6+11rmOymCBTGoHAou7j+fDibLJ4tZ+H7WslDJ5LQOY8QjfcJV6T7y/w2crfF+Nepo4gNx7uaGOyEXTK/Wa9VYUu/Rbo1ICQPSxko9zM5zVfjsdzL0mHEw5r6iMSm0OJRjs8RzckNexukZdwETun3j4Hr9mM7fyk4SY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923873; c=relaxed/simple;
	bh=hzzxCxYHKJlV//EcCCMyFY5XRICC4MkyQFC2eFI+AqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHR9I3YBdvnm7BzD6tQYw3U8thue/b0X/1RKMvUlJknh9gM2U9qtEWlOv1Gua6+L3IqcZAWEmGMWPTsR13FN1JbgEHDTwQo9YeYApQ/FNHM6zyt85aTdXTM071FtU+yFqg5WFwU4Ccl5bJDWbJ/YbRsb2TCQb9qBSFGXuLwAIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id c0f29add93c09374; Mon, 22 Jan 2024 12:44:28 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 53F7A669540;
	Mon, 22 Jan 2024 12:44:28 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v1 02/12] PM: sleep: Relocate two device PM core functions
Date: Mon, 22 Jan 2024 12:24:21 +0100
Message-ID: <4876491.GXAFRqVoOG@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgrnhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move is_async() and dpm_async_fn() in the PM core to a more suitable
place.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   58 +++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -578,6 +578,35 @@ bool dev_pm_skip_resume(struct device *d
 	return !dev->power.must_resume;
 }
 
+static bool is_async(struct device *dev)
+{
+	return dev->power.async_suspend && pm_async_enabled
+		&& !pm_trace_is_enabled();
+}
+
+static bool dpm_async_fn(struct device *dev, async_func_t func)
+{
+	reinit_completion(&dev->power.completion);
+
+	if (is_async(dev)) {
+		dev->power.async_in_progress = true;
+
+		get_device(dev);
+
+		if (async_schedule_dev_nocall(func, dev))
+			return true;
+
+		put_device(dev);
+	}
+	/*
+	 * Because async_schedule_dev_nocall() above has returned false or it
+	 * has not been called at all, func() is not running and it is safe to
+	 * update the async_in_progress flag without extra synchronization.
+	 */
+	dev->power.async_in_progress = false;
+	return false;
+}
+
 /**
  * device_resume_noirq - Execute a "noirq resume" callback for given device.
  * @dev: Device to handle.
@@ -664,35 +693,6 @@ Out:
 	}
 }
 
-static bool is_async(struct device *dev)
-{
-	return dev->power.async_suspend && pm_async_enabled
-		&& !pm_trace_is_enabled();
-}
-
-static bool dpm_async_fn(struct device *dev, async_func_t func)
-{
-	reinit_completion(&dev->power.completion);
-
-	if (is_async(dev)) {
-		dev->power.async_in_progress = true;
-
-		get_device(dev);
-
-		if (async_schedule_dev_nocall(func, dev))
-			return true;
-
-		put_device(dev);
-	}
-	/*
-	 * Because async_schedule_dev_nocall() above has returned false or it
-	 * has not been called at all, func() is not running and it is safe to
-	 * update the async_in_progress flag without extra synchronization.
-	 */
-	dev->power.async_in_progress = false;
-	return false;
-}
-
 static void async_resume_noirq(void *data, async_cookie_t cookie)
 {
 	struct device *dev = data;




