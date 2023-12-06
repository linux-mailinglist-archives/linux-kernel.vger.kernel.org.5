Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB535807B98
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377811AbjLFWmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377664AbjLFWmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:42:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A25D5B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 14:42:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D98C433C8;
        Wed,  6 Dec 2023 22:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701902562;
        bh=C/z2J4QPXebp5y/KZX3b+//X9l7x7jrXFPy9z32q6dI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sr6tDrjVNEGXBrIduHYruCE+26Os5jBYxrBIYnZAcYvDRtFDMObUCXJJLzMUiCw7N
         xChDFP4dnQByUNM2/9AyMINDb1Vomrc7EhfOeGD2bM4wqUrc+hhuYlwKunZE96eJkg
         G+g2dZ/la0NQ90ncYg3505KmeqhbhUQ/Si+BzUaflfPMPdSZO/raSwCsdtAVQ30vrl
         zRlsZmwaCZva4DJ9GndQ1gNnQm55/qaRW60CcvTD+BxbS/ZpmExY0DNPWSKO7cNl/6
         86Z5jo9swQunULx2h2jUinrNNC1rLTrUPa3Vci2CxSo+rTAtgIUph4s/Y9dyPHI3SN
         wCN/Tr12lMFjQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Robert Richter <rrichter@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/3] PCI/AER: Decode Requester ID when no error info found
Date:   Wed,  6 Dec 2023 16:42:30 -0600
Message-Id: <20231206224231.732765-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206224231.732765-1-helgaas@kernel.org>
References: <20231206224231.732765-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

When a device with AER detects an error, it logs error information in its
own AER Error Status registers.  It may send an Error Message to the Root
Port (RCEC in the case of an RCiEP), which logs the fact that an Error
Message was received (Root Error Status) and the Requester ID of the
message source (Error Source Identification).

aer_print_port_info() prints the Requester ID from the Root Port Error
Source in the usual Linux "bb:dd.f" format, but when find_source_device()
finds no error details in the hierarchy below the Root Port, it printed the
raw Requester ID without decoding it.

Decode the Requester ID in the usual Linux format so it matches other
messages.

Sample message changes:

  - pcieport 0000:00:1c.5: AER: Correctable error received: 0000:00:1c.5
  - pcieport 0000:00:1c.5: AER: can't find device of ID00e5
  + pcieport 0000:00:1c.5: AER: Correctable error message received from 0000:00:1c.5
  + pcieport 0000:00:1c.5: AER: found no error details for 0000:00:1c.5

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 20db80018b5d..2ff6bac9979f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -740,7 +740,7 @@ static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
 	u8 bus = info->id >> 8;
 	u8 devfn = info->id & 0xff;
 
-	pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
+	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
 		 info->multi_error_valid ? "Multiple " : "",
 		 aer_error_severity_string[info->severity],
 		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
@@ -929,7 +929,12 @@ static bool find_source_device(struct pci_dev *parent,
 		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num) {
-		pci_info(parent, "can't find device of ID%04x\n", e_info->id);
+		u8 bus = e_info->id >> 8;
+		u8 devfn = e_info->id & 0xff;
+
+		pci_info(parent, "found no error details for %04x:%02x:%02x.%d\n",
+			 pci_domain_nr(parent->bus), bus, PCI_SLOT(devfn),
+			 PCI_FUNC(devfn));
 		return false;
 	}
 	return true;
-- 
2.34.1

