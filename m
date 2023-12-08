Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958E180AD8B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574689AbjLHUHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjLHUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:07:46 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE33E1734;
        Fri,  8 Dec 2023 12:07:52 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id d5c18fa1728abe13; Fri, 8 Dec 2023 21:07:51 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0460B6688FF;
        Fri,  8 Dec 2023 21:07:51 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 1/4] ACPI: utils: Rearrange in acpi_evaluate_reference()
Date:   Fri, 08 Dec 2023 21:05:19 +0100
Message-ID: <4541600.LvFx2qVVIh@kreacher>
In-Reply-To: <6008018.lOV4Wx5bFT@kreacher>
References: <6008018.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhm
 pdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The code in acpi_evaluate_reference() can be improved in some ways
without changing its observable behavior.  Among other things:

 * None of the local variables in that function except for buffer
   needs to be initialized.

 * The element local variable is only used in the for () loop block,
   so it can be defined there.

 * Multiple checks can be combined.

 * Code duplication related to error handling can be eliminated.

 * Redundant inner parens can be dropped.

Modify the function as per the above.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/utils.c |   58 +++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 34 deletions(-)

Index: linux-pm/drivers/acpi/utils.c
===================================================================
--- linux-pm.orig/drivers/acpi/utils.c
+++ linux-pm/drivers/acpi/utils.c
@@ -335,12 +335,10 @@ acpi_evaluate_reference(acpi_handle hand
 			struct acpi_object_list *arguments,
 			struct acpi_handle_list *list)
 {
-	acpi_status status = AE_OK;
-	union acpi_object *package = NULL;
-	union acpi_object *element = NULL;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	u32 i = 0;
-
+	union acpi_object *package;
+	acpi_status status;
+	u32 i;
 
 	if (!list)
 		return AE_BAD_PARAMETER;
@@ -353,45 +351,32 @@ acpi_evaluate_reference(acpi_handle hand
 
 	package = buffer.pointer;
 
-	if ((buffer.length == 0) || !package) {
-		status = AE_BAD_DATA;
-		acpi_util_eval_error(handle, pathname, status);
-		goto end;
-	}
-	if (package->type != ACPI_TYPE_PACKAGE) {
-		status = AE_BAD_DATA;
-		acpi_util_eval_error(handle, pathname, status);
-		goto end;
-	}
-	if (!package->package.count) {
+	if (buffer.length == 0 || !package ||
+	    package->type != ACPI_TYPE_PACKAGE || !package->package.count) {
 		status = AE_BAD_DATA;
-		acpi_util_eval_error(handle, pathname, status);
-		goto end;
+		goto err;
 	}
 
-	list->handles = kcalloc(package->package.count, sizeof(*list->handles), GFP_KERNEL);
+	list->count = package->package.count;
+	list->handles = kcalloc(list->count, sizeof(*list->handles), GFP_KERNEL);
 	if (!list->handles) {
-		kfree(package);
-		return AE_NO_MEMORY;
+		status = AE_NO_MEMORY;
+		goto err_clear;
 	}
-	list->count = package->package.count;
 
 	/* Extract package data. */
 
 	for (i = 0; i < list->count; i++) {
-
-		element = &(package->package.elements[i]);
+		union acpi_object *element = &(package->package.elements[i]);
 
 		if (element->type != ACPI_TYPE_LOCAL_REFERENCE) {
 			status = AE_BAD_DATA;
-			acpi_util_eval_error(handle, pathname, status);
-			break;
+			goto err_free;
 		}
 
 		if (!element->reference.handle) {
 			status = AE_NULL_ENTRY;
-			acpi_util_eval_error(handle, pathname, status);
-			break;
+			goto err_free;
 		}
 		/* Get the  acpi_handle. */
 
@@ -399,16 +384,21 @@ acpi_evaluate_reference(acpi_handle hand
 		acpi_handle_debug(list->handles[i], "Found in reference list\n");
 	}
 
-	if (ACPI_FAILURE(status)) {
-		list->count = 0;
-		kfree(list->handles);
-		list->handles = NULL;
-	}
-
 end:
 	kfree(buffer.pointer);
 
 	return status;
+
+err_free:
+	kfree(list->handles);
+	list->handles = NULL;
+
+err_clear:
+	list->count = 0;
+
+err:
+	acpi_util_eval_error(handle, pathname, status);
+	goto end;
 }
 
 EXPORT_SYMBOL(acpi_evaluate_reference);



