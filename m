Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EFE7D7010
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344452AbjJYOxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjJYOx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:53:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C342137
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:53:23 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c2a0725825so866979966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698245601; x=1698850401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IV52gqKvJLev/nEwlZaq8bDCbTo7SRK1FTCEJKQYD08=;
        b=cOd15unraBWkmFspGLaL0GfxB/78j1Tm6aOiofDjj4L45vwmftUaz4LFGWXxVHde7r
         IYB4/Hsg7BQQ+A03gdZb5T4c1wUzJIE0KO6/bkgKx8RQ7Li1VtSQ5POhQIa8fGk8xKkY
         oBgNDOgnWV8w62tlGVe2bYu6N29tMaoUFPPLmZK2kRu/YLTezHPEHaob3Fjy1zxeTt1W
         LBxbRVoOp07RvVxq9T+P/PXZqYpB8ZS5yyMg9XGD03rv0qcH5CiHS8XFYSulQQp1vsnp
         IkELAHwMfdZMSFs4fbxW9kbRjQU0g94+HptwjCPUojLFNbdC0e2+guUUzUBfZleSyMgc
         ijBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698245601; x=1698850401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IV52gqKvJLev/nEwlZaq8bDCbTo7SRK1FTCEJKQYD08=;
        b=hJCFHvA7qV3U+dLo+o4QID6jPv0uKUE3mV8w8AWQ7cuNzikxlDoAJ1yeHQ49AfDKur
         JbuYUIqxZwe96Ke2IvOh/WwheGR45SQ6YfBr253Tn1/AobM/kMXebjjZxnUpVnW/M0GK
         5L5t5i5Svlph+HvrhR2yUPjAqrB8Po2RgT9qKXyKqMx0LCR+63SDU7t35K4e0rj/zoAk
         6+3MGoBoMfrCivA8ousOmOWkfK7+yL/dB9lqB/zx+KBps8NCmDQw1DY4+2gienn7zQcT
         SwrWT6U88fXuWiSeRx+gkpkCIjrwzJ/a2z99bAh9SGaGSgIMAmjvUqSCpwM9X45ohZLQ
         9noA==
X-Gm-Message-State: AOJu0YzlvwNHiSOZr3uONzz64qT8X98iR8iTsH8Z5tPEJQaSanxdSJf5
        UJhp9m0vzqk0SrNOfKr4wYjZXmyZ6bifklahYYZSZg==
X-Google-Smtp-Source: AGHT+IGmhcMX3P2d7rTTjdKLj40MV1gB5lLVVyV2lpf5dzF8jwl8z5JSxtSWL2/X52ewQjM28dAM3Q==
X-Received: by 2002:a17:907:94ce:b0:9bd:931e:30d8 with SMTP id dn14-20020a17090794ce00b009bd931e30d8mr12102066ejc.14.1698245601586;
        Wed, 25 Oct 2023 07:53:21 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1a6])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709062b0700b009932337747esm9856733ejg.86.2023.10.25.07.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:53:21 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH v2] virtio_pci: Switch away from deprecated irq_set_affinity_hint
Date:   Wed, 25 Oct 2023 16:53:19 +0200
Message-ID: <20231025145319.380775-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 65c7cdedeb30 ("genirq: Provide new interfaces for affinity
hints") irq_set_affinity_hint is being phased out.

Switch to new interfaces for setting and applying irq affinity hints.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
v2:
 - Leave cpumask_copy as is. We can't pass pointer to stack memory as hint.
   Proposed a change to IRQ affinity interface to address this limitation:
   https://lore.kernel.org/r/20231025141517.375378-1-jakub@cloudflare.com

v1: https://lore.kernel.org/r/20231019101625.412936-2-jakub@cloudflare.com
---
 drivers/virtio/virtio_pci_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index c2524a7207cf..7a5593997e0e 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -242,7 +242,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 			if (v != VIRTIO_MSI_NO_VECTOR) {
 				int irq = pci_irq_vector(vp_dev->pci_dev, v);
 
-				irq_set_affinity_hint(irq, NULL);
+				irq_update_affinity_hint(irq, NULL);
 				free_irq(irq, vq);
 			}
 		}
@@ -443,10 +443,10 @@ int vp_set_vq_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
 		mask = vp_dev->msix_affinity_masks[info->msix_vector];
 		irq = pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
 		if (!cpu_mask)
-			irq_set_affinity_hint(irq, NULL);
+			irq_update_affinity_hint(irq, NULL);
 		else {
 			cpumask_copy(mask, cpu_mask);
-			irq_set_affinity_hint(irq, mask);
+			irq_set_affinity_and_hint(irq, mask);
 		}
 	}
 	return 0;
-- 
2.41.0

