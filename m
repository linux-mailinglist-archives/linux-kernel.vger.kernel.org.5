Return-Path: <linux-kernel+bounces-32955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3094836272
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8182F1F225B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31FC3DB93;
	Mon, 22 Jan 2024 11:44:34 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC0A3CF43;
	Mon, 22 Jan 2024 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923874; cv=none; b=B5BzDkIbJMw1Ymdx211LVM2OqERCER83GPU5NQfNDnarwzarm4QEk9fxDPmqYYnEFRVyQJiycmKakARdaAzVG9EwgL+YfebbG9gnCSK/uhpFtA4iOPZenKnqba3ypsd0Ir/7koTCoEIm7cIhRPqZ0NToceNnMkvt5c2s6l8dFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923874; c=relaxed/simple;
	bh=ViL55juQL2yZg0/fut6nXH2YChHT8Lh7HKMvuFfirfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZvj7IZ1t23HnCjfLH513RloxQc7/1A0yeg3Gy/eg7pvEMPOEGpKHCPYb1nvdrjvWNvJw8M14SKai7Y27fyvTGa+ofbhK8zAzGJRkk1ogPboL+n6ILoEA7cQ+qkbo+8bhC8Vpc/vevXLxvXXNLHmXQsIgN6dP9wEYy7uBVNo0wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 573e3b755b40b71a; Mon, 22 Jan 2024 12:44:26 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 28093669540;
	Mon, 22 Jan 2024 12:44:26 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v1 05/12] PM: sleep: stats: Use step_failures[0] as a counter of successful cycles
Date: Mon, 22 Jan 2024 12:29:11 +0100
Message-ID: <3290637.44csPzL39Z@kreacher>
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

The first (index 0) cell of the step_failures[] array in struct
suspend_stats introduced previously can be used as a counter of
successful suspend-resume cycles instead of the separate "success"
field in it, so do that.

While at it, change the type of the "fail" field in struct
suspend_stats to unsigned int, because it cannot be negative.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/suspend.h |    3 +--
 kernel/power/main.c     |    9 +++++----
 kernel/power/suspend.c  |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -55,8 +55,7 @@ enum suspend_stat_step {
 
 struct suspend_stats {
 	unsigned int step_failures[SUSPEND_NR_STEPS];
-	int	success;
-	int	fail;
+	unsigned int fail;
 #define	REC_FAILED_NUM	2
 	int	last_failed_dev;
 	char	failed_devs[REC_FAILED_NUM][40];
Index: linux-pm/kernel/power/main.c
===================================================================
--- linux-pm.orig/kernel/power/main.c
+++ linux-pm/kernel/power/main.c
@@ -339,8 +339,7 @@ static ssize_t _name##_show(struct kobje
 }								\
 static struct kobj_attribute _name = __ATTR_RO(_name)
 
-suspend_attr(success, "%d\n");
-suspend_attr(fail, "%d\n");
+suspend_attr(fail, "%u\n");
 suspend_attr(last_hw_sleep, "%llu\n");
 suspend_attr(total_hw_sleep, "%llu\n");
 suspend_attr(max_hw_sleep, "%llu\n");
@@ -354,6 +353,7 @@ static ssize_t _name##_show(struct kobje
 }								\
 static struct kobj_attribute _name = __ATTR_RO(_name)
 
+suspend_step_attr(success, SUSPEND_NONE);
 suspend_step_attr(failed_freeze, SUSPEND_FREEZE);
 suspend_step_attr(failed_prepare, SUSPEND_PREPARE);
 suspend_step_attr(failed_suspend, SUSPEND_SUSPEND);
@@ -458,8 +458,9 @@ static int suspend_stats_show(struct seq
 	last_step = suspend_stats.last_failed_step + REC_FAILED_NUM - 1;
 	last_step %= REC_FAILED_NUM;
 
-	seq_printf(s, "success: %d\nfail: %d\n",
-		   suspend_stats.success, suspend_stats.fail);
+	seq_printf(s, "success: %u\nfail: %u\n",
+		   suspend_stats.step_failures[SUSPEND_NONE],
+		   suspend_stats.fail);
 
 	for (step = SUSPEND_FREEZE; step < SUSPEND_NR_STEPS; step++)
 		seq_printf(s, "failed_%s: %u\n", suspend_step_names[step],
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -620,7 +620,7 @@ int pm_suspend(suspend_state_t state)
 		suspend_stats.fail++;
 		dpm_save_failed_errno(error);
 	} else {
-		suspend_stats.success++;
+		suspend_stats.step_failures[SUSPEND_NONE]++;
 	}
 	pr_info("suspend exit\n");
 	return error;




