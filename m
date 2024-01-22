Return-Path: <linux-kernel+bounces-33663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27614836CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FD31C26CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F314F5FA;
	Mon, 22 Jan 2024 16:11:32 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD043DBA9;
	Mon, 22 Jan 2024 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939891; cv=none; b=iRzQLbyU5Y6G3fwP+bl3lNtBrmGkrt+UC58dECUt9Z92D8O9udoYVhvWwAK2I4siiF781ovVcAHzdEcGpkNmbyvWrF6P0l2SXPJMjDWM1BV/RkCTi9stSBXZXJwfZ4cVRvRmxGhpsHs/SHvvRAakPM/0H+eME9xkOxPR4fedbdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939891; c=relaxed/simple;
	bh=gd1xG0QVWf2kr1Slio5ktaMDy9hNa5uZog6KlhgzvOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S1RVcAnJmCa9DcxXqpXShRWzViexDStQjWoazCTRK88V6cX9epqMJmlijyjPEyjNjwIK34duxpghBRiurQRycx91Kgb4G1z3ZYjSY7PdKggiKQ1UVjbW/hWm7VnI+ywUporal6AqjXGU8oejWN4I0SMJAgyOw8kgK33Gub0NSrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 8cc4570eae3495fb; Mon, 22 Jan 2024 17:11:26 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 50F1166954D;
	Mon, 22 Jan 2024 17:11:26 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: [PATCH v1] PM: sleep: Use bool for all 1-bit fields in struct dev_pm_info
Date: Mon, 22 Jan 2024 17:11:26 +0100
Message-ID: <12380944.O9o76ZdvQC@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehs
 thgrnhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

For some 1-bit fields in struct dev_pm_info the data type is bool, while
for some other 1-bit fields in there it is unsigned int, and these
differences are somewhat arbitrary.

For consistency, change the data type of the latter to bool, so that all
of the 1-bit fields in struct dev_pm_info fields are bool.

This also reduces the size of struct device on my x86 systems by 8 B,
from 1120 B to 1112 B.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm.h |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -662,8 +662,8 @@ struct pm_subsys_data {
 
 struct dev_pm_info {
 	pm_message_t		power_state;
-	unsigned int		can_wakeup:1;
-	unsigned int		async_suspend:1;
+	bool			can_wakeup:1;
+	bool			async_suspend:1;
 	bool			in_dpm_list:1;	/* Owned by the PM core */
 	bool			is_prepared:1;	/* Owned by the PM core */
 	bool			is_suspended:1;	/* Ditto */
@@ -682,10 +682,10 @@ struct dev_pm_info {
 	bool			syscore:1;
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
 	bool			async_in_progress:1;	/* Owned by the PM core */
-	unsigned int		must_resume:1;	/* Owned by the PM core */
-	unsigned int		may_skip_resume:1;	/* Set by subsystems */
+	bool			must_resume:1;	/* Owned by the PM core */
+	bool			may_skip_resume:1;	/* Set by subsystems */
 #else
-	unsigned int		should_wakeup:1;
+	bool			should_wakeup:1;
 #endif
 #ifdef CONFIG_PM
 	struct hrtimer		suspend_timer;
@@ -696,18 +696,18 @@ struct dev_pm_info {
 	atomic_t		usage_count;
 	atomic_t		child_count;
 	unsigned int		disable_depth:3;
-	unsigned int		idle_notification:1;
-	unsigned int		request_pending:1;
-	unsigned int		deferred_resume:1;
-	unsigned int		needs_force_resume:1;
-	unsigned int		runtime_auto:1;
+	bool			idle_notification:1;
+	bool			request_pending:1;
+	bool			deferred_resume:1;
+	bool			needs_force_resume:1;
+	bool			runtime_auto:1;
 	bool			ignore_children:1;
-	unsigned int		no_callbacks:1;
-	unsigned int		irq_safe:1;
-	unsigned int		use_autosuspend:1;
-	unsigned int		timer_autosuspends:1;
-	unsigned int		memalloc_noio:1;
-	unsigned int		links_count;
+	bool			no_callbacks:1;
+	bool			irq_safe:1;
+	bool			use_autosuspend:1;
+	bool			timer_autosuspends:1;
+	bool			memalloc_noio:1;
+	bool			links_count;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
 	enum rpm_status		last_status;




