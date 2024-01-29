Return-Path: <linux-kernel+bounces-43113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352C9840BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F271F23ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C791115CD43;
	Mon, 29 Jan 2024 16:32:11 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC6115AAC2;
	Mon, 29 Jan 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545931; cv=none; b=sPOlqlG5PJmtqQ33XGGUsFcGsreUsohOwZ7hIuyK6RIgAdkDe6p0RdwR1nqZPkUzV07WU7FXD6grhVc6sisDaGubDUk87UqAr+1Wpj4wguUsUNxVUFC5rG0gbK+H4jZvT49iqf55uO8PTSNhgT8IvP58mOPynglATD6hNCXHfCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545931; c=relaxed/simple;
	bh=SjzW2UsvZ2GkecO/LbDZYZGdT8+JTKkaLkPfaULWwgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwwNWaG2cuqzWIGkGj4sg0X92mqrp+wM7ZcN07V9RriAOQPuqZpCbufYhCam1PugprqYuoOHJtrtuV7cDaW9F0gbEjb+JBXlRvPBkqBKuYQ76ZKO4QLwNfxWSwlbYU1dmQ5/zs0yiEjBHYsBy+scxtH5g86FdpnhUdg715mp7UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 315201b9b6dcb32a; Mon, 29 Jan 2024 17:32:00 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6A39F66975C;
	Mon, 29 Jan 2024 17:32:00 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v2 09/10] PM: sleep: Move devices to new lists earlier in each suspend phase
Date: Mon, 29 Jan 2024 17:28:37 +0100
Message-ID: <1871146.atdPhlSkOF@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgrnhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

During a system-wide suspend of devices, dpm_noirq_suspend_devices(),
dpm_suspend_late() and dpm_suspend() move devices from one list to
another.  They do it with each device after its PM callback in the
given suspend phase has run or has been scheduled for asynchronous
execution, in case it is deleted from the current list in the
meantime.

However, devices can be moved to a new list before invoking their PM
callbacks (which usually is the case for the devices whose callbacks
are executed asynchronously anyway), because doing so does not affect
the ordering of that list.  In either case, each device is moved to
the new list after the previous device has been moved to it or gone
away, and if a device is removed, it does not matter which list it is
in at that point, because deleting an entry from a list does not change
the ordering of the other entries in it.

Accordingly, modify the functions mentioned above to move devices to
new lists without waiting for their PM callbacks to run regardless of
whether or not they run asynchronously.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---

v1 -> v2: Added R-by from Stanislaw.

---
 drivers/base/power/main.c |   24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1304,18 +1304,12 @@ static int dpm_noirq_suspend_devices(pm_
 	while (!list_empty(&dpm_late_early_list)) {
 		struct device *dev = to_device(dpm_late_early_list.prev);
 
+		list_move(&dev->power.entry, &dpm_noirq_list);
 		get_device(dev);
 		mutex_unlock(&dpm_list_mtx);
 
 		error = device_suspend_noirq(dev);
 
-		mutex_lock(&dpm_list_mtx);
-
-		if (!error && !list_empty(&dev->power.entry))
-			list_move(&dev->power.entry, &dpm_noirq_list);
-
-		mutex_unlock(&dpm_list_mtx);
-
 		put_device(dev);
 
 		mutex_lock(&dpm_list_mtx);
@@ -1486,19 +1480,13 @@ int dpm_suspend_late(pm_message_t state)
 	while (!list_empty(&dpm_suspended_list)) {
 		struct device *dev = to_device(dpm_suspended_list.prev);
 
+		list_move(&dev->power.entry, &dpm_late_early_list);
 		get_device(dev);
 
 		mutex_unlock(&dpm_list_mtx);
 
 		error = device_suspend_late(dev);
 
-		mutex_lock(&dpm_list_mtx);
-
-		if (!list_empty(&dev->power.entry))
-			list_move(&dev->power.entry, &dpm_late_early_list);
-
-		mutex_unlock(&dpm_list_mtx);
-
 		put_device(dev);
 
 		mutex_lock(&dpm_list_mtx);
@@ -1763,19 +1751,13 @@ int dpm_suspend(pm_message_t state)
 	while (!list_empty(&dpm_prepared_list)) {
 		struct device *dev = to_device(dpm_prepared_list.prev);
 
+		list_move(&dev->power.entry, &dpm_suspended_list);
 		get_device(dev);
 
 		mutex_unlock(&dpm_list_mtx);
 
 		error = device_suspend(dev);
 
-		mutex_lock(&dpm_list_mtx);
-
-		if (!error && !list_empty(&dev->power.entry))
-			list_move(&dev->power.entry, &dpm_suspended_list);
-
-		mutex_unlock(&dpm_list_mtx);
-
 		put_device(dev);
 
 		mutex_lock(&dpm_list_mtx);




