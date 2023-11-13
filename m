Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C287E9689
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 06:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjKMFwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 00:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKMFv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 00:51:59 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C0210C4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 21:51:53 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3119137a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 21:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699854713; x=1700459513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d3gsxgxUWE7sauUTr/vPNFu3myJ6+D29dcITW4pw1EI=;
        b=YPV4lMDrAi03rw/HZCDs6+PNicwJ/V5TyjZRZNDHf32VvMtQOnyhAEDifs/nRgachv
         aFRa9B5fr8x+pnApZ+/R9/GMbSmKGpexL9dQZ2kHg7AVpLbp6ljFcJTM6AgexTcthhxJ
         5WNqOAI6yS+NFeJhyEa3PqOhJXEJhpYjYNoB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699854713; x=1700459513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3gsxgxUWE7sauUTr/vPNFu3myJ6+D29dcITW4pw1EI=;
        b=MZcHA30B3EF3d45E+zMkkQlCNlvuj5ylu4a9dvhCQ1w0RKw8ETrTdRrusIyOixDrq2
         3wbPI87uHSZ5otYCgkfi44bNgNB0rOYm15Rpm6J1/pNAMMhWzExzFcYdCe5rOWxaLUNR
         3bmh2tHNhOTzG9mCgQMUKy+YLkCbWJXDjnEHhtF8OSs4RBW+egJ+wrILRxIJ2VyabnZY
         vCV8m43QOYvnzYZHjGd8gw0vpKBULK6cABHBmkMdxj7PowbW3ziR+grvLaR7TUvRmHmC
         IPwX3YoTnJNZzTKIL7dpX5G7j7tz3VcB7npSddVQKUdmuvR9ujHHALvi/PCVFDt5gx5N
         JeXg==
X-Gm-Message-State: AOJu0YzGbwgFT0jA58Vzl2Cu1UJyE3rDqFKC07D9nKBXBXqOBb7U3QxW
        qq/prfJws+F/pZbMST13khv4jg==
X-Google-Smtp-Source: AGHT+IGtoqIiLNdRIrkQj/Km8AZg8AWLn5j3QqvI8VTAGO98KBA9/AXhjfpsp6WdhaljfbeKQiE4fA==
X-Received: by 2002:a05:6a20:1447:b0:185:a90d:367e with SMTP id a7-20020a056a20144700b00185a90d367emr8322809pzi.2.1699854713209;
        Sun, 12 Nov 2023 21:51:53 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:b3d4:3d34:1798:ff1c])
        by smtp.gmail.com with UTF8SMTPSA id jc17-20020a17090325d100b001c724732058sm3373241plb.235.2023.11.12.21.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 21:51:52 -0800 (PST)
From:   David Stevens <stevensd@chromium.org>
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     David Stevens <stevensd@chromium.org>
Subject: [PATCH] virtio: Add virtio-device power management
Date:   Mon, 13 Nov 2023 14:51:38 +0900
Message-ID: <20231113055138.117392-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtio power management for virtio pci devices is defined on top of PCI
power management, so it mostly works out of the box. All that's needed
is to add suspend/resume callbacks to the virtio core, instead of
reusing the freeze/restore.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/virtio/virtio_pci_common.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index c2524a7207cf..0cad900eaf4f 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -492,8 +492,27 @@ static int virtio_pci_restore(struct device *dev)
 	return virtio_device_restore(&vp_dev->vdev);
 }
 
+static int virtio_pci_suspend(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+
+	return pci_dev->pm_cap ? 0 : virtio_pci_freeze(dev);
+}
+
+static int virtio_pci_resume(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+
+	return pci_dev->pm_cap ? 0 : virtio_pci_restore(dev);
+}
+
 static const struct dev_pm_ops virtio_pci_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
+	.suspend = virtio_pci_suspend,
+	.resume = virtio_pci_resume,
+	.freeze = virtio_pci_freeze,
+	.thaw = virtio_pci_restore,
+	.poweroff = virtio_pci_freeze,
+	.restore = virtio_pci_restore,
 };
 #endif
 
-- 
2.42.0.869.gea05f2083d-goog

