Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFEB7CF4E4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345252AbjJSKQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345242AbjJSKQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:16:33 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6292C119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:16:31 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso13621176a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697710590; x=1698315390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibyNWRVCDx3qtUdZOs6HtDQhMI8S1gxSQ6nQBRN1fXM=;
        b=GWUXGm4IKjI+hRNeEkqoaqd8aMgQs4PkhxA8X0P1G5/ZUpA+e3MDhR0BLEfGEcDj8Y
         SO7SKVLdLSeWER506vAvM6ZFzJMh54uZceY3z6KVAanKGb+dYtbX6Qohcw2U/AKpqQFz
         +ImZywzZUY7TEWdk5Fb9W2mAt97Tx1eQNIPF+i9my3ckpz8EVOwEOWZay3676twfI75v
         O7nayWjjTspKHR3uMmL+xhTL0A8gqetlqy8YwpSe6iEV8IenfFFxR8z6QBe9nUfWamPF
         Jb23ISrJOURAYopFRnPwRHXYNL+xYjatQjSWrksaaUmx8go77KKn+eJOQUiW8dBQ5Lox
         dzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697710590; x=1698315390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibyNWRVCDx3qtUdZOs6HtDQhMI8S1gxSQ6nQBRN1fXM=;
        b=qofL+gB9nN1KmvEaYiSLHlLCvOKqjBAHR656SXALhf1Io3yP7TDheYTNwNv3mb/dMq
         zAemy1Hy/IvlfmSxasm2dd9euij+oD6HwPzQvBXJggsSYZwii2Ltx9BBjsuwBxSN/rkt
         mr67JLEyXiWdfqXS8LqwTqA4JJZ2j+TIZ8Gb0lUsObOGfx0jeGCxx9rLk4W1NqUkDMEo
         UQsqub0VWM4wB3nmfqiPJClP3smKkY7iOR5B2OqS7ag2XmCYn0lHWtMrdZJSeu24uEu+
         VjoagKovTQ9zNip3tg5Bm/ViSjCd2Av5/LrVuoCojSX02hIuzu8za8pa9w0KytmtRljT
         hpwg==
X-Gm-Message-State: AOJu0YxfiowMdgr9/Um+BunZVieNykwAw2GXByr6zEIYFQ1942i77V1i
        JOsk16GTZfKQOYat8NjSA+1zYg==
X-Google-Smtp-Source: AGHT+IHF/5NdBr8oE08ju1QLZcHvtSIqTtdkG3W8vghatpkOTfnKNt9vsEurU2jwiofOOYZadF9yrg==
X-Received: by 2002:a17:907:706:b0:9be:45b3:3116 with SMTP id xb6-20020a170907070600b009be45b33116mr1517324ejb.71.1697710589833;
        Thu, 19 Oct 2023 03:16:29 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:194])
        by smtp.gmail.com with ESMTPSA id p6-20020a1709061b4600b009b65b2be80bsm3249835ejg.76.2023.10.19.03.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:16:29 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH 2/2] virtio_pci: Switch away from deprecated irq_set_affinity_hint
Date:   Thu, 19 Oct 2023 12:16:25 +0200
Message-ID: <20231019101625.412936-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019101625.412936-1-jakub@cloudflare.com>
References: <20231019101625.412936-1-jakub@cloudflare.com>
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

Since commit 65c7cdedeb30 ("genirq: Provide new interfaces for affinity
hints") irq_set_affinity_hint is being phased out.

Switch to new interfaces for setting and applying irq affinity hints.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/virtio/virtio_pci_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 8927bc338f06..9fab99b540f1 100644
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
@@ -440,7 +440,7 @@ int vp_set_vq_affinity(struct virtqueue *vq, const struct cpumask *cpu_mask)
 
 	if (vp_dev->msix_enabled) {
 		irq = pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
-		irq_set_affinity_hint(irq, cpu_mask);
+		irq_set_affinity_and_hint(irq, cpu_mask);
 	}
 	return 0;
 }
-- 
2.41.0

