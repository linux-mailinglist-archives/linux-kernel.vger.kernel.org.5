Return-Path: <linux-kernel+bounces-43117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D67B840BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F06C1C22E54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CFC15AAC8;
	Mon, 29 Jan 2024 16:32:14 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE715B0F4;
	Mon, 29 Jan 2024 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545933; cv=none; b=UJKFDK1VkaxaedpaMFhw6YcLXsLc5GsKGLE6X6rlTakol5M6QeQfjUUJLGuzQbnta1IMqvNLhJBr6hUX9emBdIeEY7u5Y/O91jL09AcrHj79dS1b3aMenlSbwGtdlum3yqCGPahRrdpq2kK47KR+vXYyR3+j7sUZFuJcALr/nQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545933; c=relaxed/simple;
	bh=iyXE7t0eskj3g5+cWmxPvH1tVv8VprKcfE27yahn7mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsfR0+9JRt3nNYN1VIOODz0Wwyduxr+1JpMAoVyCohhg1Gk7eAAjqehNQkNOhVq4YFs0B2ezlHoZAi4bOly314P0AKu0ExznrZW/xFjUWDo96VPLMRLOCgulvm1YJwBEWLFUiatW/X+X6g9CLRTeToDlP6fGx5libO8gHV9H1PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 3184fcaa49044cda; Mon, 29 Jan 2024 17:32:03 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 233A066975C;
	Mon, 29 Jan 2024 17:32:03 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v2 05/10] PM: sleep: stats: Call dpm_save_failed_step() at most once per phase
Date: Mon, 29 Jan 2024 17:24:04 +0100
Message-ID: <23401570.6Emhk5qWAg@kreacher>
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

If the handling of two or more devices fails in one suspend-resume
phase, it should be counted once in the statistics which is not
guaranteed to happen during system-wide resume of devices due to
the possible asynchronous execution of device callbacks.

Address this by using the async_error static variable during system-wide
device resume to indicate that there has been a device resume error and
the given suspend-resume phase should be counted as failing.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes.

---
 drivers/base/power/main.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -685,7 +685,7 @@ Out:
 	TRACE_RESUME(error);
 
 	if (error) {
-		dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
+		async_error = error;
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
 	}
@@ -705,6 +705,9 @@ static void dpm_noirq_resume_devices(pm_
 	ktime_t starttime = ktime_get();
 
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, true);
+
+	async_error = 0;
+
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 
@@ -734,6 +737,9 @@ static void dpm_noirq_resume_devices(pm_
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
 	dpm_show_time(starttime, state, 0, "noirq");
+	if (async_error)
+		dpm_save_failed_step(SUSPEND_RESUME_NOIRQ);
+
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
 }
 
@@ -815,7 +821,7 @@ Out:
 	complete_all(&dev->power.completion);
 
 	if (error) {
-		dpm_save_failed_step(SUSPEND_RESUME_EARLY);
+		async_error = error;
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async early" : " early", error);
 	}
@@ -839,6 +845,9 @@ void dpm_resume_early(pm_message_t state
 	ktime_t starttime = ktime_get();
 
 	trace_suspend_resume(TPS("dpm_resume_early"), state.event, true);
+
+	async_error = 0;
+
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 
@@ -868,6 +877,9 @@ void dpm_resume_early(pm_message_t state
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
 	dpm_show_time(starttime, state, 0, "early");
+	if (async_error)
+		dpm_save_failed_step(SUSPEND_RESUME_EARLY);
+
 	trace_suspend_resume(TPS("dpm_resume_early"), state.event, false);
 }
 
@@ -971,7 +983,7 @@ static void device_resume(struct device
 	TRACE_RESUME(error);
 
 	if (error) {
-		dpm_save_failed_step(SUSPEND_RESUME);
+		async_error = error;
 		dpm_save_failed_dev(dev_name(dev));
 		pm_dev_err(dev, state, async ? " async" : "", error);
 	}
@@ -1030,6 +1042,8 @@ void dpm_resume(pm_message_t state)
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
 	dpm_show_time(starttime, state, 0, NULL);
+	if (async_error)
+		dpm_save_failed_step(SUSPEND_RESUME);
 
 	cpufreq_resume();
 	devfreq_resume();




