Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AC48106A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377848AbjLMAgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377815AbjLMAgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:36:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9822D92
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 16:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702427784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i9MCzR8hm8n3phQFUj5SiSzmRj2klqcZQOfChS9uSo8=;
        b=c12GEfGEmJZVH/qGSmaxuV3hOEv7dekpgHaFgZ6tyWoWmws058iEearSM2W5+YdGDGOLFR
        sGlzq4waTZ/+NmcFj4jeNvBCFXtzetSdEhy4vLtp/J2flJAeg81K9QsV7LjkZF83JqFfFP
        zsduEFteUvxhwl5RUZlXaA/Y7fAK1rw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-afEb-U-uNXKPOOwDedQvLQ-1; Tue, 12 Dec 2023 19:36:21 -0500
X-MC-Unique: afEb-U-uNXKPOOwDedQvLQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1EDD85A596;
        Wed, 13 Dec 2023 00:36:20 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D23FC1121306;
        Wed, 13 Dec 2023 00:36:18 +0000 (UTC)
From:   Igor Mammedov <imammedo@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dongli Zhang <dongli.zhang@oracle.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, imammedo@redhat.com, mst@redhat.com,
        rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
        mika.westerberg@linux.intel.com, boris.ostrovsky@oracle.com,
        joe.jin@oracle.com, stable@vger.kernel.org,
        Fiona Ebner <f.ebner@proxmox.com>,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: [RFC 1/2] PCI: acpiphp: enable slot only if it hasn't been enabled already
Date:   Wed, 13 Dec 2023 01:36:13 +0100
Message-Id: <20231213003614.1648343-2-imammedo@redhat.com>
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

When SCSI_SCAN_ASYNC is enabled (either via config or via cmd line),
adding device to bus and enabling it will kick in async host scan

 scsi_scan_host+0x21/0x1f0
 virtscsi_probe+0x2dd/0x350
 ..
 driver_probe_device+0x19/0x80
 ...
 driver_probe_device+0x19/0x80
 pci_bus_add_device+0x53/0x80
 pci_bus_add_devices+0x2b/0x70
 ...

which will schedule a job for async scan. That however breaks
if there are more than one SCSI host behind bridge, since
acpiphp_check_bridge() will walk over all slots and try to
enable each of them regardless of whether they were already
enabled.
As result the bridge might be reconfigured several times
and trigger following sequence:

  [cpu 0] acpiphp_check_bridge()
  [cpu 0]   enable_slot(a)
  [cpu 0]     configure bridge
  [cpu 0]     pci_bus_add_devices() -> scsi_scan_host(a1)
  [cpu 0]   enable_slot(b)
  ...
  [cpu 1] do_scsi_scan_host(a1) <- async jib scheduled for slot a
  ...
  [cpu 0]     configure bridge <- temporaly disables bridge

and cause do_scsi_scan_host() failure.
The same race affects SHPC (but it manages to avoid hitting the race due to
1sec delay when enabling slot).
To cover case of single device hotplug (at a time) do not attempt to
enable slot that have already been enabled.

Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
Reported-by: iona Ebner <f.ebner@proxmox.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 601129772b2d..6b11609927d6 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -722,7 +722,9 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
 					trim_stale_devices(dev);
 
 			/* configure all functions */
-			enable_slot(slot, true);
+			if (slot->flags != SLOT_ENABLED) {
+				enable_slot(slot, true);
+			}
 		} else {
 			disable_slot(slot);
 		}
-- 
2.39.3

