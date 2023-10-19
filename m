Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F81A7CF4E1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345240AbjJSKQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345158AbjJSKQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:16:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83F5119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:16:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99de884ad25so1254353766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697710587; x=1698315387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wsXbezCZoeuJrO98GwOgaGC8RBPaWgtTZVWkdUgAb5c=;
        b=QBQEUx2dM/w3WoNxf18/Xha5qYxh+N8ngyNb477UeHecJuVPOGpG6O2gM9g1JB5yUv
         8DghkNRQEK1qKaxBYcRqFsLxC40diuEP/PkU4uEDawa9iZVCC3Z7NsSpEuFd6pb2iZFQ
         fo5y6iFqw737kBNxZf7CiJoYCcTv4XTQ2J0YIw7WhJ0S0cuhwEiAeGvR9VEr+7lOquWl
         HMHqNx/LDZgoAKMkLWLDDaOhdNLnaNog3hezV+t4I/cXj79MLp+V+sookBWo0/1usdMk
         3nIu8cObUYD4uAzEpcapfYwOnLlG1dCIoknGNciK05kZwuF6ia2raGZAlhWhrzPWjHtF
         Fbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697710587; x=1698315387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wsXbezCZoeuJrO98GwOgaGC8RBPaWgtTZVWkdUgAb5c=;
        b=u3VfTyih6teb736fkDnhWiLDNJQ9+/M5j/KdJ3fNgGz60cHYnC5bZz41p5EB7UcFLb
         7AuYsFyCYLzpGBxPOBze+J4777UdoOE2tiCYG04xwiglH6Jd9Mz37VwoWwvn0au79fom
         1tPeMIlrNjGU5YrximC3Xz8QX39omppVZKpUGBc+eYc1m5qWDcGyysf41u8osGH8e4hl
         iH57q3b/s+xi5auy/NoJTQSypnUjIiSvokyawpPbNHDsYkK2d2eJhd10IYNvY5BtGVfr
         +oyUJ9gqZBWolm2rye4+V4/fZ240ztpbdeEXPN6dxQnUGkvm52fEXGgd/iJeDPL5hG8v
         2Ovg==
X-Gm-Message-State: AOJu0YxH8wtQeqWNr+kD43bfAW+WjcEYk6GsgPScOUCxJZWFnWHL7VG1
        wvBGMgzoCZTsFTMclhBaelu7Lg==
X-Google-Smtp-Source: AGHT+IGKx6okUJClW9akG9H6m9kJqJ0Nyt+kBKsXxyAiYiyCKsRx/FPkbX0599vNxVESnPv8DZ7cIQ==
X-Received: by 2002:a17:906:dac4:b0:9c4:4b20:44a4 with SMTP id xi4-20020a170906dac400b009c44b2044a4mr1270036ejb.48.1697710587277;
        Thu, 19 Oct 2023 03:16:27 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:194])
        by smtp.gmail.com with ESMTPSA id le3-20020a170907170300b009c70b392051sm3252439ejc.100.2023.10.19.03.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:16:26 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Caleb Raitto <caraitto@google.com>
Subject: [PATCH 1/2] virtio_pci: Don't make an extra copy of cpu affinity mask
Date:   Thu, 19 Oct 2023 12:16:24 +0200
Message-ID: <20231019101625.412936-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 19e226e8cc5d ("virtio: Make vp_set_vq_affinity() take a
mask.") it is actually not needed to have a local copy of the cpu mask.

Pass the cpu mask we got as argument to set the irq affinity hint.

Cc: Caleb Raitto <caraitto@google.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/virtio/virtio_pci_common.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index c2524a7207cf..8927bc338f06 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -433,21 +433,14 @@ int vp_set_vq_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
 	struct virtio_device *vdev = vq->vdev;
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
-	struct cpumask *mask;
 	unsigned int irq;
 
 	if (!vq->callback)
 		return -EINVAL;
 
 	if (vp_dev->msix_enabled) {
-		mask = vp_dev->msix_affinity_masks[info->msix_vector];
 		irq = pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
-		if (!cpu_mask)
-			irq_set_affinity_hint(irq, NULL);
-		else {
-			cpumask_copy(mask, cpu_mask);
-			irq_set_affinity_hint(irq, mask);
-		}
+		irq_set_affinity_hint(irq, cpu_mask);
 	}
 	return 0;
 }
-- 
2.41.0

