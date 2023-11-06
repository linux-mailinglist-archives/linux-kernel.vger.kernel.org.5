Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B255B7E29C1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjKFQbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjKFQbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:31:38 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5111BF;
        Mon,  6 Nov 2023 08:31:34 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 8c88228d28cf286d; Mon, 6 Nov 2023 17:31:33 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8A0496678F9;
        Mon,  6 Nov 2023 17:31:32 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 7/7] ACPI: property: Replicate DT-aligned u32 properties from DisCo for Imaging
Date:   Mon, 06 Nov 2023 17:31:18 +0100
Message-ID: <4325211.ejJDZkT8p0@kreacher>
In-Reply-To: <4542595.LvFx2qVVIh@kreacher>
References: <4542595.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddugedgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghkrghrihdrrghilhhusheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sakari Ailus <sakari.ailus@linux.intel.com>

MIPI DisCo for Imaging defines properties for camera sensors that
functionally align with DT equivalents.

Replicate these properties in the ACPI device swnodes so the code
using the corresponding DT properties already does not need to be
updated to deal with their MIPI counterparts directly.

The replicated properties are:

	"mipi-img-clock-frequency" -> "clock-frequency"
	"mipi-img-led-max-current" -> "led-max-microamp"
	"mipi-img-flash-max-current" -> "flash-max-microamp"
	"mipi-img-flash-max-timeout" -> "flash-max-timeout-us"

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
[ rjw: Changelog edits, removal of redundant braces ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/mipi-disco-img.c |   17 +++++++++++++++++
 include/acpi/acpi_bus.h       |    4 ++++
 2 files changed, 21 insertions(+)

Index: linux-pm/drivers/acpi/mipi-disco-img.c
===================================================================
--- linux-pm.orig/drivers/acpi/mipi-disco-img.c
+++ linux-pm/drivers/acpi/mipi-disco-img.c
@@ -597,6 +597,7 @@ static void init_crs_csi2_swnodes(struct
 	struct acpi_device *adev;
 	acpi_status status;
 	unsigned int i;
+	u32 val;
 	int ret;
 
 	/*
@@ -628,6 +629,22 @@ static void init_crs_csi2_swnodes(struct
 		}
 	}
 
+	if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-clock-frequency", &val))
+		swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_CLOCK_FREQUENCY)] =
+			PROPERTY_ENTRY_U32("clock-frequency", val);
+
+	if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-led-max-current", &val))
+		swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_LED_MAX_MICROAMP)] =
+			PROPERTY_ENTRY_U32("led-max-microamp", val);
+
+	if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-flash-max-current", &val))
+		swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_FLASH_MAX_MICROAMP)] =
+			PROPERTY_ENTRY_U32("flash-max-microamp", val);
+
+	if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-flash-max-timeout-us", &val))
+		swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_FLASH_MAX_TIMEOUT_US)] =
+			PROPERTY_ENTRY_U32("flash-max-timeout-us", val);
+
 	status = acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 	if (ACPI_FAILURE(status)) {
 		acpi_handle_info(handle, "Unable to get the path name\n");
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -381,6 +381,10 @@ struct acpi_gpio_mapping;
 
 enum acpi_device_swnode_dev_props {
 	ACPI_DEVICE_SWNODE_DEV_ROTATION,
+	ACPI_DEVICE_SWNODE_DEV_CLOCK_FREQUENCY,
+	ACPI_DEVICE_SWNODE_DEV_LED_MAX_MICROAMP,
+	ACPI_DEVICE_SWNODE_DEV_FLASH_MAX_MICROAMP,
+	ACPI_DEVICE_SWNODE_DEV_FLASH_MAX_TIMEOUT_US,
 	ACPI_DEVICE_SWNODE_DEV_NUM_OF,
 	ACPI_DEVICE_SWNODE_DEV_NUM_ENTRIES
 };



