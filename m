Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5CC8106A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377873AbjLMAgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377847AbjLMAgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:36:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4836EB9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702427786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4J3yyMVT0Ck6UqVMMggnyCj20M3aIOGukmt1/w28WlA=;
        b=RQHitFp8fXhxUD5EP4EHvhV7gBSpQZ/SN/nJmxzB4ZpvfKBWIA2F2/c/NhrhtCHAG4GLY1
        fY3Hrz+XtTfBxwuezsT4LxEvWnlpgViJ++VBZbAeQGVyAROQvcIGa4ixo5a3ef8n8SMKy2
        NQF7nm2XeQOnAuuhTsdy5d1RjpEQSpA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-nIPG_mAZOtSj-ICft5S-pQ-1; Tue,
 12 Dec 2023 19:36:23 -0500
X-MC-Unique: nIPG_mAZOtSj-ICft5S-pQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3BE53833343;
        Wed, 13 Dec 2023 00:36:22 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2C821121306;
        Wed, 13 Dec 2023 00:36:20 +0000 (UTC)
From:   Igor Mammedov <imammedo@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dongli Zhang <dongli.zhang@oracle.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, imammedo@redhat.com, mst@redhat.com,
        rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
        mika.westerberg@linux.intel.com, boris.ostrovsky@oracle.com,
        joe.jin@oracle.com, stable@vger.kernel.org,
        Fiona Ebner <f.ebner@proxmox.com>,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging multiple devices at a time
Date:   Wed, 13 Dec 2023 01:36:14 +0100
Message-Id: <20231213003614.1648343-3-imammedo@redhat.com>
In-Reply-To: <20231213003614.1648343-1-imammedo@redhat.com>
References: <20231213003614.1648343-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

previous commit ("PCI: acpiphp: enable slot only if it hasn't been enabled already"
introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job and
bridge reconfiguration in case of single HBA hotplug.
However in virt environment it's possible to pause machine hotplug several
HBAs and let machine run. That can hit the same race when 2nd hotplugged
HBA will start re-configuring bridge.
Do the same thing as SHPC and throttle down hotplug of 2nd and up
devices within single hotplug event.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 6b11609927d6..30bca2086b24 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -37,6 +37,7 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/delay.h>
 
 #include "../pci.h"
 #include "acpiphp.h"
@@ -700,6 +701,7 @@ static void trim_stale_devices(struct pci_dev *dev)
 static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
 {
 	struct acpiphp_slot *slot;
+        int nr_hp_slots = 0;
 
 	/* Bail out if the bridge is going away. */
 	if (bridge->is_going_away)
@@ -723,6 +725,10 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
 
 			/* configure all functions */
 			if (slot->flags != SLOT_ENABLED) {
+				if (nr_hp_slots)
+					msleep(1000);
+
+                                ++nr_hp_slots;
 				enable_slot(slot, true);
 			}
 		} else {
-- 
2.39.3

