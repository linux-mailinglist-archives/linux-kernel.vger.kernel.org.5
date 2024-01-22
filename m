Return-Path: <linux-kernel+bounces-32953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8857783626E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC67D1C28343
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB43D969;
	Mon, 22 Jan 2024 11:44:33 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5263CF58;
	Mon, 22 Jan 2024 11:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923873; cv=none; b=Fz4O6sx0QUS5eHzAX2Ds2EVrHZtYqtvcg6g5R1j0dhUx02e3Y7eUyCr4BUdUDFnwNEF3DFWM+KopUBN3DdIQIxSk335kbktdD7Tt2wZZOHPhSCEhuBPfElItJXFl3zjED10+mqW/zA6OM+wzE4bEUfDMth8IcuAUrS5U/DtH/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923873; c=relaxed/simple;
	bh=jydXufZGYcpgz4WEsMMBaaJhEjPprcdtdbjiT+OAzHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ti1Wc8LMp1P6SMnqyyGpl/bdemXlyQyuH0dAy8NZ4NKhyWWC2ggGwZIuRxYiEFCC35kZKeRzrelegyAeCtMaYZzmkk91zafoOEGy3zPclCyhcPUSQ1cEMXtLtc/1QtJq9thSl7HpQibT9BSEDfpnorc/o4O2zqh8Ze6edOjJ2Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 8af684c178176ffb; Mon, 22 Jan 2024 12:44:28 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9D8E1669540;
	Mon, 22 Jan 2024 12:44:27 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v1 03/12] PM: sleep: stats: Use array of suspend step names
Date: Mon, 22 Jan 2024 12:25:45 +0100
Message-ID: <2183940.irdbgypaU6@kreacher>
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

Replace suspend_step_name() in the suspend statistics code with an array
of suspend step names which has fewer lines of code and less overhead.

While at it, remove two unnecessary line breaks in suspend_stats_show()
for a more consistent code layout.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/suspend.h |    3 ++-
 kernel/power/main.c     |   48 +++++++++++++++++-------------------------------
 2 files changed, 19 insertions(+), 32 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -41,7 +41,8 @@ typedef int __bitwise suspend_state_t;
 #define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
 
 enum suspend_stat_step {
-	SUSPEND_FREEZE = 1,
+	SUSPEND_NONE = 0,
+	SUSPEND_FREEZE,
 	SUSPEND_PREPARE,
 	SUSPEND_SUSPEND,
 	SUSPEND_SUSPEND_LATE,
Index: linux-pm/kernel/power/main.c
===================================================================
--- linux-pm.orig/kernel/power/main.c
+++ linux-pm/kernel/power/main.c
@@ -319,25 +319,17 @@ static ssize_t pm_test_store(struct kobj
 power_attr(pm_test);
 #endif /* CONFIG_PM_SLEEP_DEBUG */
 
-static char *suspend_step_name(enum suspend_stat_step step)
-{
-	switch (step) {
-	case SUSPEND_FREEZE:
-		return "freeze";
-	case SUSPEND_PREPARE:
-		return "prepare";
-	case SUSPEND_SUSPEND:
-		return "suspend";
-	case SUSPEND_SUSPEND_NOIRQ:
-		return "suspend_noirq";
-	case SUSPEND_RESUME_NOIRQ:
-		return "resume_noirq";
-	case SUSPEND_RESUME:
-		return "resume";
-	default:
-		return "";
-	}
-}
+static const char * const suspend_step_names[] = {
+	[SUSPEND_NONE] = "",
+	[SUSPEND_FREEZE] = "freeze",
+	[SUSPEND_PREPARE] = "prepare",
+	[SUSPEND_SUSPEND] = "suspend",
+	[SUSPEND_SUSPEND_LATE] = "suspend_late",
+	[SUSPEND_SUSPEND_NOIRQ] = "suspend_noirq",
+	[SUSPEND_RESUME_NOIRQ] = "resume_noirq",
+	[SUSPEND_RESUME_EARLY] = "resume_early",
+	[SUSPEND_RESUME] = "resume",
+};
 
 #define suspend_attr(_name, format_str)				\
 static ssize_t _name##_show(struct kobject *kobj,		\
@@ -392,16 +384,14 @@ static struct kobj_attribute last_failed
 static ssize_t last_failed_step_show(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
-	int index;
 	enum suspend_stat_step step;
-	char *last_failed_step = NULL;
+	int index;
 
 	index = suspend_stats.last_failed_step + REC_FAILED_NUM - 1;
 	index %= REC_FAILED_NUM;
 	step = suspend_stats.failed_steps[index];
-	last_failed_step = suspend_step_name(step);
 
-	return sprintf(buf, "%s\n", last_failed_step);
+	return sprintf(buf, "%s\n", suspend_step_names[step]);
 }
 static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
 
@@ -477,26 +467,22 @@ static int suspend_stats_show(struct seq
 	for (i = 1; i < REC_FAILED_NUM; i++) {
 		index = last_dev + REC_FAILED_NUM - i;
 		index %= REC_FAILED_NUM;
-		seq_printf(s, "\t\t\t%-s\n",
-			suspend_stats.failed_devs[index]);
+		seq_printf(s, "\t\t\t%-s\n", suspend_stats.failed_devs[index]);
 	}
 	seq_printf(s,	"  last_failed_errno:\t%-d\n",
 			suspend_stats.errno[last_errno]);
 	for (i = 1; i < REC_FAILED_NUM; i++) {
 		index = last_errno + REC_FAILED_NUM - i;
 		index %= REC_FAILED_NUM;
-		seq_printf(s, "\t\t\t%-d\n",
-			suspend_stats.errno[index]);
+		seq_printf(s, "\t\t\t%-d\n", suspend_stats.errno[index]);
 	}
 	seq_printf(s,	"  last_failed_step:\t%-s\n",
-			suspend_step_name(
-				suspend_stats.failed_steps[last_step]));
+		   suspend_step_names[suspend_stats.failed_steps[last_step]]);
 	for (i = 1; i < REC_FAILED_NUM; i++) {
 		index = last_step + REC_FAILED_NUM - i;
 		index %= REC_FAILED_NUM;
 		seq_printf(s, "\t\t\t%-s\n",
-			suspend_step_name(
-				suspend_stats.failed_steps[index]));
+			   suspend_step_names[suspend_stats.failed_steps[index]]);
 	}
 
 	return 0;




