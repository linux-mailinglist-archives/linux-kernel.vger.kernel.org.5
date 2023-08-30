Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C635878DFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241160AbjH3TKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243668AbjH3LYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:24:37 -0400
Received: from out-244.mta0.migadu.com (out-244.mta0.migadu.com [91.218.175.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6E4CDC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:24:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693394149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Zg38/yfbHtNqcp81DKpY9eh6KOeHZbhiShVOmvA7V4=;
        b=jv3CuduPEnOmyI8RCuaM2tOrlJYrgKnWrIgY/SGdnDCtIaD1737g7qQZj11M3sQabQuS/T
        Nrx3PYIJaQeoUy4Eri1cT6M1NSRWACUCi8EUJw28uZQTTHIp051FWT1KU2Nxjfory8qhWa
        amSavgZwh8A/3Nlh1prwwA4ytPWkdqQ=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [-next 3/5] PCI/sysfs: Use pci_is_vga() helper
Date:   Wed, 30 Aug 2023 19:15:30 +0800
Message-Id: <20230830111532.444535-4-sui.jingfeng@linux.dev>
In-Reply-To: <20230830111532.444535-1-sui.jingfeng@linux.dev>
References: <20230830111532.444535-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

Instead of accessing the PCI_CLASS_DISPLAY_VGA and pdev->class directly.
The PCI_CLASS_NOT_DEFINED_VGA is defined to provide backward compatibility
for devices that were built before the class code field was defined. It
should be visiable via sysfs(boot_vga) as the normal VGA-compatible devices.

Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/pci-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d9eede2dbc0e..522708938563 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1552,10 +1552,10 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
 	struct pci_dev *pdev = to_pci_dev(dev);
 
 	if (a == &dev_attr_boot_vga.attr)
-		if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
-			return 0;
+		if (pci_is_vga(pdev))
+			return a->mode;
 
-	return a->mode;
+	return 0;
 }
 
 static struct attribute *pci_dev_hp_attrs[] = {
-- 
2.34.1

