Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FDB7DD168
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344974AbjJaQUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344890AbjJaQUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB89BA6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698769203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=9vLLa3ZDoGKvMI4Q2cPPmXzBmtdoj810TCBQHEKpzcg=;
        b=VuLqSImgl3oeLrtHvrGmwTeOo8OvaW/jBY6FqCIUipFPe/jQnB+x1VuZ1o3LSntnHDlVMH
        W9LTgvZk2yhfCo0quWjxHwPACZQi+ZNvMs6qgdtNKt6uOWIy/P6l14Lvg+D4CDjlRYJ3M8
        uY7r9vtUMkZvC7mm3qQmLVvyuJLMt8k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-qIvHpz7QMjSCz53FO6IDjA-1; Tue, 31 Oct 2023 12:20:01 -0400
X-MC-Unique: qIvHpz7QMjSCz53FO6IDjA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae0bf9c0b4so407858266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698769199; x=1699373999;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vLLa3ZDoGKvMI4Q2cPPmXzBmtdoj810TCBQHEKpzcg=;
        b=uZ2ULs2q9SwnE0K0aWUENYx5X62c8mt+k/OUzAJa/Vofcr2XSkeZuDuzYTI9fYgQfR
         CeW4xJADb4gnx6eMUYbnDQnrJBS7M5Rht9eRfMMpKrhl3hftO3TdoaNgjV+6kzynKpfO
         22zbNy52kWwnuTzYN9x2aOI0P2FVHzzm367pHYtiHpDZfhnEITsjh3mx+cwl+hvMyTjZ
         9lrgFTikLrSaInWUlcIOKBIZLxjbbmVBciBWCl2zTFtekimTPHm+NhR7Nb8BVGA+pCv2
         1YXIiFfX6i3j3/i2lw45ru03bM+N6t0c2f1rkhD59glw/2aI19wH1+zExKJ71dXyYCAo
         GVSA==
X-Gm-Message-State: AOJu0Yxqv2Np3SbTWvWX/UJke39VNF9i6BgsiJ/N8jdIoezg3/Tt8Hqr
        U1QBoldIg2thGwlyx/etcFoG0x4Vx9yS4kL4nloUOmwHyIOEmO/YJKFz/N97JKQ8miCyN6ksaIe
        0VL7WVRFuaXguB7VSBRUCzKsKWC52a6XJVr4Xe82wAtU/c+jsL5VYwOBoRyML79IsTPmA/lQoDQ
        oj9A==
X-Received: by 2002:a17:907:944e:b0:9bf:2bf:65f3 with SMTP id dl14-20020a170907944e00b009bf02bf65f3mr11554571ejc.7.1698769199717;
        Tue, 31 Oct 2023 09:19:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9Uml7tqNWi/g3OFNU0ZTpYp3zZEOt77dL9nlhkY9Roe9vB+ogV3dpvxgs1FQIIvYiEvUkMQ==
X-Received: by 2002:a17:907:944e:b0:9bf:2bf:65f3 with SMTP id dl14-20020a170907944e00b009bf02bf65f3mr11554554ejc.7.1698769199351;
        Tue, 31 Oct 2023 09:19:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:14b6:b6f1:4797:8f5d:fa41])
        by smtp.gmail.com with ESMTPSA id i1-20020a1709064ec100b009d2eb40ff9dsm1198573ejv.33.2023.10.31.09.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 09:19:58 -0700 (PDT)
Date:   Tue, 31 Oct 2023 12:19:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_pci: move structure to a header
Message-ID: <110d3058179284b092722827bef4f74f8ba0c622.1698769192.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are guest/host interfaces so belong in the header
where e.g. qemu will know to find them.
Note: we added a new structure as opposed to extending existing one
because someone might be relying on the size of the existing structure
staying unchanged.  Add a warning to avoid using sizeof.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c |  7 ++++---
 include/linux/virtio_pci_modern.h      |  7 -------
 include/uapi/linux/virtio_pci.h        | 11 +++++++++++
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index e2a1fe7bb66c..7de8b1ebabac 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -294,9 +294,10 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 
 	err = -EINVAL;
 	mdev->common = vp_modern_map_capability(mdev, common,
-				      sizeof(struct virtio_pci_common_cfg), 4,
-				      0, sizeof(struct virtio_pci_modern_common_cfg),
-				      &mdev->common_len, NULL);
+			      sizeof(struct virtio_pci_common_cfg), 4, 0,
+			      offsetofend(struct virtio_pci_modern_common_cfg,
+					  queue_reset),
+			      &mdev->common_len, NULL);
 	if (!mdev->common)
 		goto err_map_common;
 	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index d0f2797420f7..a09e13a577a9 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -5,13 +5,6 @@
 #include <linux/pci.h>
 #include <linux/virtio_pci.h>
 
-struct virtio_pci_modern_common_cfg {
-	struct virtio_pci_common_cfg cfg;
-
-	__le16 queue_notify_data;	/* read-write */
-	__le16 queue_reset;		/* read-write */
-};
-
 /**
  * struct virtio_pci_modern_device - info for modern PCI virtio
  * @pci_dev:	    Ptr to the PCI device struct
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index f703afc7ad31..44f4dd2add18 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -166,6 +166,17 @@ struct virtio_pci_common_cfg {
 	__le32 queue_used_hi;		/* read-write */
 };
 
+/*
+ * Warning: do not use sizeof on this: use offsetofend for
+ * specific fields you need.
+ */
+struct virtio_pci_modern_common_cfg {
+	struct virtio_pci_common_cfg cfg;
+
+	__le16 queue_notify_data;	/* read-write */
+	__le16 queue_reset;		/* read-write */
+};
+
 /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
 struct virtio_pci_cfg_cap {
 	struct virtio_pci_cap cap;
-- 
MST

