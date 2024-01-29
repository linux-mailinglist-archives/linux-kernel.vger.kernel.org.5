Return-Path: <linux-kernel+bounces-43118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7876E840BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1783A1F24BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB0B15AAA8;
	Mon, 29 Jan 2024 16:32:14 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF24E15B99D;
	Mon, 29 Jan 2024 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545934; cv=none; b=Nv2V+CeK9bUT5vrHLyHBHdg13E1IU33StFQfdkHx7euNj+pG3eufHI5cQvEVdQlQ4YMeHSTAQjRtO0fMprg/wz07tdffuMJf5VKRLC3oR8fJ4J/BFLX+KxWTzMQCoyj+RE+N5Qi0ldnyIpdAVjAfVJpRAxZSa9bFTStC0uG4L5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545934; c=relaxed/simple;
	bh=SLYZDfBRj0nJ3TIDw4DlpBNWJI9WE3g0fX18rhc77nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHbwmcSlMvmf14z0zkFLsOiCfxvtfqJXrh0W2a0vgsssbJFVJsIgf/B+p9JiS3BYoA5OaDen99id31jrwOMrgU1DDQiJ7XZ43Px9qOpOyXtpgB6mkIstHe4pFFkmQuE0CUJVmqw3fKFY0fLHL4v+htzgJuJuFa4PwQCXa8zew/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 2e1f42a0c7c859a6; Mon, 29 Jan 2024 17:32:04 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C8DE266975C;
	Mon, 29 Jan 2024 17:32:03 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v2 03/10] PM: sleep: stats: Use unsigned int for success and failure counters
Date: Mon, 29 Jan 2024 17:13:14 +0100
Message-ID: <2941406.e9J7NaK4W3@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgrnhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Change the type of the "success" and "fail" fields in struct
suspend_stats to unsigned int, because they cannot be negative.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: New patch.

---
 include/linux/suspend.h |    4 ++--
 kernel/power/main.c     |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -56,8 +56,8 @@ enum suspend_stat_step {
 
 struct suspend_stats {
 	unsigned int step_failures[SUSPEND_NR_STEPS];
-	int	success;
-	int	fail;
+	unsigned int success;
+	unsigned int fail;
 #define	REC_FAILED_NUM	2
 	int	last_failed_dev;
 	char	failed_devs[REC_FAILED_NUM][40];
Index: linux-pm/kernel/power/main.c
===================================================================
--- linux-pm.orig/kernel/power/main.c
+++ linux-pm/kernel/power/main.c
@@ -339,8 +339,8 @@ static ssize_t _name##_show(struct kobje
 }								\
 static struct kobj_attribute _name = __ATTR_RO(_name)
 
-suspend_attr(success, "%d\n");
-suspend_attr(fail, "%d\n");
+suspend_attr(success, "%u\n");
+suspend_attr(fail, "%u\n");
 suspend_attr(last_hw_sleep, "%llu\n");
 suspend_attr(total_hw_sleep, "%llu\n");
 suspend_attr(max_hw_sleep, "%llu\n");
@@ -458,7 +458,7 @@ static int suspend_stats_show(struct seq
 	last_step = suspend_stats.last_failed_step + REC_FAILED_NUM - 1;
 	last_step %= REC_FAILED_NUM;
 
-	seq_printf(s, "success: %d\nfail: %d\n",
+	seq_printf(s, "success: %u\nfail: %u\n",
 		   suspend_stats.success, suspend_stats.fail);
 
 	for (step = SUSPEND_FREEZE; step <= SUSPEND_NR_STEPS; step++)




