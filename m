Return-Path: <linux-kernel+bounces-43115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A95C840BB2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC1D1C22069
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DE415D5B0;
	Mon, 29 Jan 2024 16:32:13 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE015AAC9;
	Mon, 29 Jan 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545932; cv=none; b=URBoMmkmjguqI9A6RrKG+d2HlwISEB8ZUcDYmz0vpIF2b5SCzJshDdB3rKANmNfOShck075z7MCQYH5Gx48hLdzc2YRhD+Qmkr2cKkAaAHPrnobuzBFnSUiFsIxW3k8y8SFPukIM6t1fAmt8q1g6IVtQGFE9v9sSpJ8515IWvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545932; c=relaxed/simple;
	bh=t4M5s2l4WBiO5aXChunZB44zHCQq/VhfSSIwb2z2C7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkbi6QNWzxoRRFH+xRrqzIj+oX7UXausCfJu3ckDNmiaS+2qbyashSdYp/YmVsFzhIFO1BsAQB8V1hnh0hR3l/x058F3/5nyROYtpKjUBitOLZvJ6v88SfPE8SuQWah14WspkCKxnWb4G1ia92cJk+EbZjaIpM3O2+aniqn8rLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id cf5c7351ec63126c; Mon, 29 Jan 2024 17:32:01 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 13A7E66975C;
	Mon, 29 Jan 2024 17:32:01 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v2 08/10] PM: sleep: Move some assignments from under a lock
Date: Mon, 29 Jan 2024 17:27:33 +0100
Message-ID: <3750318.MHq7AAxBmi@kreacher>
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

The async_error and pm_transition variables are set under dpm_list_mtx
in multiple places in the system-wide device PM core code, which is
unnecessary and confusing, so rearrange the code so that the variables
in question are set before acquiring the lock.

While at it, add some empty code lines around locking to improve the
consistency of the code.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes.

---
 drivers/base/power/main.c |   28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -707,9 +707,9 @@ static void dpm_noirq_resume_devices(pm_
 	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, true);
 
 	async_error = 0;
+	pm_transition = state;
 
 	mutex_lock(&dpm_list_mtx);
-	pm_transition = state;
 
 	/*
 	 * Trigger the resume of "async" devices upfront so they don't have to
@@ -847,9 +847,9 @@ void dpm_resume_early(pm_message_t state
 	trace_suspend_resume(TPS("dpm_resume_early"), state.event, true);
 
 	async_error = 0;
+	pm_transition = state;
 
 	mutex_lock(&dpm_list_mtx);
-	pm_transition = state;
 
 	/*
 	 * Trigger the resume of "async" devices upfront so they don't have to
@@ -1012,10 +1012,11 @@ void dpm_resume(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_resume"), state.event, true);
 	might_sleep();
 
-	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 	async_error = 0;
 
+	mutex_lock(&dpm_list_mtx);
+
 	/*
 	 * Trigger the resume of "async" devices upfront so they don't have to
 	 * wait for the "non-async" ones they don't depend on.
@@ -1294,10 +1295,12 @@ static int dpm_noirq_suspend_devices(pm_
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true);
-	mutex_lock(&dpm_list_mtx);
+
 	pm_transition = state;
 	async_error = 0;
 
+	mutex_lock(&dpm_list_mtx);
+
 	while (!list_empty(&dpm_late_early_list)) {
 		struct device *dev = to_device(dpm_late_early_list.prev);
 
@@ -1320,7 +1323,9 @@ static int dpm_noirq_suspend_devices(pm_
 		if (error || async_error)
 			break;
 	}
+
 	mutex_unlock(&dpm_list_mtx);
+
 	async_synchronize_full();
 	if (!error)
 		error = async_error;
@@ -1470,11 +1475,14 @@ int dpm_suspend_late(pm_message_t state)
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend_late"), state.event, true);
-	wake_up_all_idle_cpus();
-	mutex_lock(&dpm_list_mtx);
+
 	pm_transition = state;
 	async_error = 0;
 
+	wake_up_all_idle_cpus();
+
+	mutex_lock(&dpm_list_mtx);
+
 	while (!list_empty(&dpm_suspended_list)) {
 		struct device *dev = to_device(dpm_suspended_list.prev);
 
@@ -1498,7 +1506,9 @@ int dpm_suspend_late(pm_message_t state)
 		if (error || async_error)
 			break;
 	}
+
 	mutex_unlock(&dpm_list_mtx);
+
 	async_synchronize_full();
 	if (!error)
 		error = async_error;
@@ -1745,9 +1755,11 @@ int dpm_suspend(pm_message_t state)
 	devfreq_suspend();
 	cpufreq_suspend();
 
-	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 	async_error = 0;
+
+	mutex_lock(&dpm_list_mtx);
+
 	while (!list_empty(&dpm_prepared_list)) {
 		struct device *dev = to_device(dpm_prepared_list.prev);
 
@@ -1771,7 +1783,9 @@ int dpm_suspend(pm_message_t state)
 		if (error || async_error)
 			break;
 	}
+
 	mutex_unlock(&dpm_list_mtx);
+
 	async_synchronize_full();
 	if (!error)
 		error = async_error;




