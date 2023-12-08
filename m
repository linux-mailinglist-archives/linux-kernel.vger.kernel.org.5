Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4F1809CEC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjLHHIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjLHHIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:08:06 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D97D53
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:08:12 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b9d8bfe845so1365136b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 23:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702019292; x=1702624092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rG1LJyzQ4WSLAFPo5foe6eDbn3FyZZB8mnOn20irkuY=;
        b=BKaqUPKo2YnujYwZE+LQM+WOgjEbyy0zqvJyUmuuXqkEZ79xKa3PdtwPCWnMBWADiF
         J4Va9YjiYLAczUbcuCz5+iCp9vwe2sxbUQsCuQxT724Ti8YrzQ/uQKaJFAOLDYTeoTZS
         R1PNsVJDk/NIStrbJ5cK0jIm41BcrKB5T08pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702019292; x=1702624092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rG1LJyzQ4WSLAFPo5foe6eDbn3FyZZB8mnOn20irkuY=;
        b=aYIejoVFGVO+SdVVIfENRt9kv00Y+ul8mdULsqJ2/JuadikfJ9fD259JUU7uWBexnH
         KRqZ+fj85HWw+VqT13D8DwIYgpxFQH0is23jzM3Aa7ytlhkOgY1I0F5pBBZf+SdAEHAG
         V02zK/6dF5YsscS7lNiRo+SCgnFARJUcCQJ+DE9TdC8I/DWq0OMbYseEmpX5QwAP/6pK
         5CdEsJe8SX86DEcCADJAmdynjZRvWgXtCNoZRxqeKc32I9n0tx07yUKpIyElj9vJWOMF
         k4aT3I5BVsLy8bs+TVeP9rfbwjDgP698/NUxu288vDmI/ouwZ2qgjzr4e80uF1/PWwIp
         PR2Q==
X-Gm-Message-State: AOJu0YzJ2/aoHdpzMiwxXCho+2BJX5KwIRsGCjg+lbMd5+HB2NKerTSY
        /Sbma3RndlsI2Qgp+Q3eMmZp2A==
X-Google-Smtp-Source: AGHT+IGgnjG/3NQ1wEHNyjy2fZFw0CEWGZ97T4Rb4NN9Ky3FyaNkvUXgjl/ynxmXyhcvvJ56IYF95A==
X-Received: by 2002:a05:6808:2388:b0:3b9:d53f:452a with SMTP id bp8-20020a056808238800b003b9d53f452amr3762370oib.70.1702019292261;
        Thu, 07 Dec 2023 23:08:12 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:e611:1861:4d10:12fc])
        by smtp.gmail.com with UTF8SMTPSA id e14-20020a056a001a8e00b006ce6bd9703csm877120pfv.194.2023.12.07.23.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 23:08:11 -0800 (PST)
From:   David Stevens <stevensd@chromium.org>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v2] virtio: Add support for no-reset virtio PCI PM
Date:   Fri,  8 Dec 2023 16:07:54 +0900
Message-ID: <20231208070754.3132339-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a virtio_pci_device supports native PCI power management and has the
No_Soft_Reset bit set, then skip resetting and reinitializing the device
when suspending and restoring the device. This allows system-wide low
power states like s2idle to be used in systems with stateful virtio
devices that can't simply be re-initialized (e.g. virtio-fs).

Signed-off-by: David Stevens <stevensd@chromium.org>
---
v1 -> v2:
 - Check the No_Soft_Reset bit

 drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index c2524a7207cf..3a95ecaf12dc 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -492,8 +492,40 @@ static int virtio_pci_restore(struct device *dev)
 	return virtio_device_restore(&vp_dev->vdev);
 }
 
+static bool vp_supports_pm_no_reset(struct device *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	u16 pmcsr;
+
+	if (!pci_dev->pm_cap)
+		return false;
+
+	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	if (PCI_POSSIBLE_ERROR(pmcsr)) {
+		dev_err(dev, "Unable to query pmcsr");
+		return false;
+	}
+
+	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
+}
+
+static int virtio_pci_suspend(struct device *dev)
+{
+	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
+}
+
+static int virtio_pci_resume(struct device *dev)
+{
+	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev);
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
2.43.0.472.g3155946c3a-goog

