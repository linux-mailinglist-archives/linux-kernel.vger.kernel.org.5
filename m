Return-Path: <linux-kernel+bounces-851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C3081470B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 074ADB233B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779C525577;
	Fri, 15 Dec 2023 11:34:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD9A250E6;
	Fri, 15 Dec 2023 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 452ee2495fde20ac; Fri, 15 Dec 2023 12:27:50 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 754B3668B1E;
	Fri, 15 Dec 2023 12:27:49 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Michal Wilczynski <michal.wilczynski@intel.com>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>, Daniel Drake <drake@endlessm.com>
Subject: [PATCH v1 1/3] ACPI: OSL: Use spin locks without disabling interrupts
Date: Fri, 15 Dec 2023 12:25:15 +0100
Message-ID: <1895035.tdWV9SEqCh@kreacher>
In-Reply-To: <2330034.ElGaqSPkdT@kreacher>
References: <2330034.ElGaqSPkdT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddgvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgt
 ohhmpdhrtghpthhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=11 Fuz1=11 Fuz2=11

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler
for SCI") any ACPICA code never runs in a hardirq handler, so it need
not dissable interrupts on the local CPU when acquiring a spin lock.

Make it use spin locks without disabling interrupts.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -1515,20 +1515,18 @@ void acpi_os_delete_lock(acpi_spinlock h
 acpi_cpu_flags acpi_os_acquire_lock(acpi_spinlock lockp)
 	__acquires(lockp)
 {
-	acpi_cpu_flags flags;
-
-	spin_lock_irqsave(lockp, flags);
-	return flags;
+	spin_lock(lockp);
+	return 0;
 }
 
 /*
  * Release a spinlock. See above.
  */
 
-void acpi_os_release_lock(acpi_spinlock lockp, acpi_cpu_flags flags)
+void acpi_os_release_lock(acpi_spinlock lockp, acpi_cpu_flags not_used)
 	__releases(lockp)
 {
-	spin_unlock_irqrestore(lockp, flags);
+	spin_unlock(lockp);
 }
 
 #ifndef ACPI_USE_LOCAL_CACHE




