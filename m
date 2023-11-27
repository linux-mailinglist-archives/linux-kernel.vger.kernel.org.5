Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC2B7FA758
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbjK0Q6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjK0Q4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:56:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF752708;
        Mon, 27 Nov 2023 08:55:41 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2FCCC660740B;
        Mon, 27 Nov 2023 16:55:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104140;
        bh=4e1hOLtYACGxKpv70NswjOrCLbRfh4IuvxjaZ96vjZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGkKb169X7rS7McuEhNRieeSnHBe1RhG1TOGDwtwHiQKKk1HKBxJ9cbjQUqKc+UCB
         QXA1QTTgzQ3txXhyrBYh2iTC7A2AIXnm9k79ePfyy9OJiu2MpEtZ6TX+mPtyoCr1CU
         D9Ju9Hz1z+/o8Jz/r6WndG7yUFKHLgkRqwLsUDfjh4tb0P8msDLpHOqEWY0VdGNDki
         +rJFSdyavDljNblVB8pFtI9pIrKEnCkK9qYAJYLBk+8CO/HbcO7n3lIz/4W4dMt8Su
         PN3qzqfQajZT/DuKfVXCZ8ukqmnPn2tigDY2WcBDViPie59Oir9KseYg1hQroogFzD
         Ji5bHV6aYzYzg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Martin Tuma <martin.tuma@digiteqautomotive.com>
Subject: [PATCH 45/55] media: pci: mgb4: Use min_dma_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:44 +0100
Message-Id: <20231127165454.166373-46-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mgb4 driver use a dma engine and needs a minimum number of
buffers to be present before start streaming.
That is 'min_dma_buffers_needed' purpose so use it instead
of 'min_buffers_needed' field.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Martin Tuma <martin.tuma@digiteqautomotive.com>
---
 drivers/media/pci/mgb4/mgb4_vin.c  | 2 +-
 drivers/media/pci/mgb4/mgb4_vout.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/mgb4/mgb4_vin.c b/drivers/media/pci/mgb4/mgb4_vin.c
index d72b07b87cd1..89e87aa87341 100644
--- a/drivers/media/pci/mgb4/mgb4_vin.c
+++ b/drivers/media/pci/mgb4/mgb4_vin.c
@@ -849,7 +849,7 @@ struct mgb4_vin_dev *mgb4_vin_create(struct mgb4_dev *mgbdev, int id)
 	vindev->queue.mem_ops = &vb2_dma_sg_memops;
 	vindev->queue.gfp_flags = GFP_DMA32;
 	vindev->queue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	vindev->queue.min_buffers_needed = 2;
+	vindev->queue.min_dma_buffers_needed = 2;
 	vindev->queue.drv_priv = vindev;
 	vindev->queue.lock = &vindev->lock;
 	vindev->queue.dev = dev;
diff --git a/drivers/media/pci/mgb4/mgb4_vout.c b/drivers/media/pci/mgb4/mgb4_vout.c
index 857fc7bbd21a..23f0e4fb195f 100644
--- a/drivers/media/pci/mgb4/mgb4_vout.c
+++ b/drivers/media/pci/mgb4/mgb4_vout.c
@@ -523,7 +523,7 @@ struct mgb4_vout_dev *mgb4_vout_create(struct mgb4_dev *mgbdev, int id)
 	voutdev->queue.mem_ops = &vb2_dma_sg_memops;
 	voutdev->queue.gfp_flags = GFP_DMA32;
 	voutdev->queue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	voutdev->queue.min_buffers_needed = 2;
+	voutdev->queue.min_dma_buffers_needed = 2;
 	voutdev->queue.drv_priv = voutdev;
 	voutdev->queue.lock = &voutdev->lock;
 	voutdev->queue.dev = dev;
-- 
2.39.2

