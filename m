Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3CA8136EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443661AbjLNQwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjLNQvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:51:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3924D66
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:51:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7C4C433C8;
        Thu, 14 Dec 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702572671;
        bh=/Qylc2+JKzSkPgqtG0O15AfjjZ9hpoVXvrfTV9+uIPA=;
        h=From:To:Cc:Subject:Date:From;
        b=Rw4g39EK4Oz975BOvXZXh6h9gnLJDQFsGE9qj6QwJbbXn59dZWCY2oC+Jm3rfAJry
         poOCUcsm5X+40s3GlTO52kgrnj8YITcOc8xNYA9lzI3rzVZ48/So37jLNPuXi5sbOq
         C9jCLamZVMBCmLWwVCTl68hCpTqTisLsU5MO2FEQKSAeRPPYCq2oxJopZKk4ICoOn3
         dxaryI8HdITj+XGWhhuItNYvo/lJfoUbElVMMu5siFy2DptQgaaeVuPYyUIn8rvo4g
         Buom6W9VT0cFvLFIF6fUTqIM4NPW1TL3yfM7JrlklrOCfbQzj3yVFllQeMbtzQxG/l
         AxXqeB39K3a6A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
        Fiona Ebner <f.ebner@proxmox.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Jonathan Woithe <jwoithe@just42.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org
Subject: [PATCH] Revert "PCI: acpiphp: Reassign resources on bridge if necessary"
Date:   Thu, 14 Dec 2023 10:51:02 -0600
Message-Id: <20231214165102.1093961-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit 40613da52b13fb21c5566f10b287e0ca8c12c4e9 and the
subsequent fix to it:

  cc22522fd55e ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus")

40613da52b13 fixed a problem where hot-adding a device with large BARs
failed if the bridge windows programmed by firmware were not large enough.

cc22522fd55e ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources()
only for non-root bus") fixed a problem with 40613da52b13: an ACPI hot-add
of a device on a PCI root bus (common in the virt world) or firmware
sending ACPI Bus Check to non-existent Root Ports (e.g., on Dell Inspiron
7352/0W6WV0) caused a NULL pointer dereference and suspend/resume hangs.

Unfortunately the combination of 40613da52b13 and cc22522fd55e caused other
problems:

  - Fiona reported that hot-add of SCSI disks in QEMU virtual machine fails
    sometimes.

  - Dongli reported a similar problem with hot-add of SCSI disks.

  - Jonathan reported a console freeze during boot on bare metal due to an
    error in radeon GPU initialization.

Revert both patches to avoid adding these problems.  This means we will
again see the problems with hot-adding devices with large BARs and the NULL
pointer dereferences and suspend/resume issues that 40613da52b13 and
cc22522fd55e were intended to fix.

Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
Fixes: cc22522fd55e ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus")
Reported-by: Fiona Ebner <f.ebner@proxmox.com>
Closes: https://lore.kernel.org/r/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com
Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
Closes: https://lore.kernel.org/r/3c4a446a-b167-11b8-f36f-d3c1b49b42e9@oracle.com
Reported-by: Jonathan Woithe <jwoithe@just42.net>
Closes: https://lore.kernel.org/r/ZXpaNCLiDM+Kv38H@marvin.atrad.com.au
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: <stable@vger.kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>
---
 drivers/pci/hotplug/acpiphp_glue.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 601129772b2d..5b1f271c6034 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -512,15 +512,12 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
 				if (pass && dev->subordinate) {
 					check_hotplug_bridge(slot, dev);
 					pcibios_resource_survey_bus(dev->subordinate);
-					if (pci_is_root_bus(bus))
-						__pci_bus_size_bridges(dev->subordinate, &add_list);
+					__pci_bus_size_bridges(dev->subordinate,
+							       &add_list);
 				}
 			}
 		}
-		if (pci_is_root_bus(bus))
-			__pci_bus_assign_resources(bus, &add_list, NULL);
-		else
-			pci_assign_unassigned_bridge_resources(bus->self);
+		__pci_bus_assign_resources(bus, &add_list, NULL);
 	}
 
 	acpiphp_sanitize_bus(bus);
-- 
2.34.1

