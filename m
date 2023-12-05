Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD5E805BED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345454AbjLERLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjLERLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:11:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37B41BE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:11:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DA0C433C7;
        Tue,  5 Dec 2023 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701796288;
        bh=HTRqZd2oPNNCESbeb303NgbHA77C4zlrwiA3tsQYhYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AiWzord3m/BV+v7+SAdv3NamPdu+rDjCuz1XRZXd7KIoVvGSOYeU9wTJ6fiu298Nj
         czSQ5aBxiv8IaKez6tZfaqvbZCmdT4xYpSp27TNZzFx+EYzpOC/j3L+x7H8F7tuq+q
         UD/mfTcLXS4FaxFhulE3QENyflHdlJYPCkcKL5y79w/nkoZk0/c05uP1/j04BR+kv5
         drzm7uOtrUOaY/0rgAKMqpbgioIpDjnH1zyXsG+4K6S1f5Ds/3ATyKVpRVT2luiyNU
         GjDnHFIQ6QUSW04OkQ1RRRwWhPpFZEgghXQrzfTlugwYHz6Ue+7+xbdglzlm6rebgL
         9KeK8hgf0WVtA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/7] PCI: Update BAR # and window messages
Date:   Tue,  5 Dec 2023 11:11:14 -0600
Message-Id: <20231205171119.680358-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205171119.680358-1-helgaas@kernel.org>
References: <20231205171119.680358-1-helgaas@kernel.org>
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

From: Puranjay Mohan <puranjay12@gmail.com>

The PCI log messages print the register offsets at some places and BAR
numbers at other places. There is no uniformity in this logging mechanism.
It would be better to print names than register offsets.

Add a helper function that aids in printing more meaningful information
about the BAR numbers like "VF BAR", "ROM", "bridge window", etc.  This
function can be called while printing PCI log messages.

[bhelgaas: fold in Lukas' static array suggestion from
https://lore.kernel.org/all/20211106115831.GA7452@wunner.de/]
Link: https://lore.kernel.org/r/20211106112606.192563-2-puranjay12@gmail.com
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 55bc3576a985..af36a0bf3e42 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -850,6 +850,66 @@ struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res)
 }
 EXPORT_SYMBOL(pci_find_resource);
 
+/**
+ * pci_resource_name - Return the name of the PCI resource
+ * @dev: PCI device to query
+ * @i: index of the resource
+ *
+ * Return the standard PCI resource (BAR) name according to their index.
+ */
+const char *pci_resource_name(struct pci_dev *dev, unsigned int i)
+{
+	static const char *bar_name[] = {
+		"BAR 0",
+		"BAR 1",
+		"BAR 2",
+		"BAR 3",
+		"BAR 4",
+		"BAR 5",
+		"ROM",
+#ifdef CONFIG_PCI_IOV
+		"VF BAR 0",
+		"VF BAR 1",
+		"VF BAR 2",
+		"VF BAR 3",
+		"VF BAR 4",
+		"VF BAR 5",
+#endif
+		"bridge window",	/* "io" included in %pR */
+		"bridge window",	/* "mem" included in %pR */
+		"bridge window",	/* "mem pref" included in %pR */
+	};
+	static const char *cardbus_name[] = {
+		"BAR 1",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+#ifdef CONFIG_PCI_IOV
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+#endif
+		"CardBus bridge window 0",	/* I/O */
+		"CardBus bridge window 1",	/* I/O */
+		"CardBus bridge window 0",	/* mem */
+		"CardBus bridge window 1",	/* mem */
+	};
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS &&
+	    i < ARRAY_SIZE(cardbus_name))
+		return cardbus_name[i];
+
+	if (i < ARRAY_SIZE(bar_name))
+		return bar_name[i];
+
+	return "unknown";
+}
+
 /**
  * pci_wait_for_pending - wait for @mask bit(s) to clear in status word @pos
  * @dev: the PCI device to operate on
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..fb9c94a1c0b5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -255,6 +255,8 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *fail_head);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
 
+const char *pci_resource_name(struct pci_dev *dev, unsigned int i);
+
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
-- 
2.34.1

