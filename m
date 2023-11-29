Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F65B7FD8B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjK2Nws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjK2Nwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:52:46 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E85CE;
        Wed, 29 Nov 2023 05:52:51 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 21be0937861611c0; Wed, 29 Nov 2023 14:52:50 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0D2A16685F3;
        Wed, 29 Nov 2023 14:52:50 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 2/4] ACPI: OSL: Rearrange workqueue selection in acpi_os_execute()
Date:   Wed, 29 Nov 2023 14:48:22 +0100
Message-ID: <2267180.iZASKD2KPV@kreacher>
In-Reply-To: <3281896.aeNJFYEL58@kreacher>
References: <3281896.aeNJFYEL58@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudeihedgheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgt
 ohhmpdhrtghpthhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the 3-branch if () statement used for selecting the target
workqueue in acpi_os_execute() with a switch () one that is more
suitable for this purpose and carry out the work item initialization
before it to avoid code duplication.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/osl.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -1092,19 +1092,21 @@ acpi_status acpi_os_execute(acpi_execute
 
 	dpc->function = function;
 	dpc->context = context;
+	INIT_WORK(&dpc->work, acpi_os_execute_deferred);
 
 	/*
 	 * To prevent lockdep from complaining unnecessarily, make sure that
 	 * there is a different static lockdep key for each workqueue by using
 	 * INIT_WORK() for each of them separately.
 	 */
-	if (type == OSL_NOTIFY_HANDLER) {
+	switch (type) {
+	case OSL_NOTIFY_HANDLER:
 		queue = kacpi_notify_wq;
-		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
-	} else if (type == OSL_GPE_HANDLER) {
+		break;
+	case OSL_GPE_HANDLER:
 		queue = kacpid_wq;
-		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
-	} else {
+		break;
+	default:
 		pr_err("Unsupported os_execute type %d.\n", type);
 		goto err;
 	}



