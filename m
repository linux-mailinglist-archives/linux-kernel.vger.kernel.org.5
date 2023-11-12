Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCF47E901F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjKLNZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjKLNZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:25:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976A44EEA;
        Sun, 12 Nov 2023 05:24:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772E5C433BC;
        Sun, 12 Nov 2023 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795478;
        bh=lMxgzkyq2IcTJHsewfFDozAFajBZzVRz4hG3yP0Tjpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ePuys/dxFOA67ikj+6gTPNls66j9J/032mVTVtL8rwLY6LgyubYEhKdocIuiV20UP
         FX4qfF6asO7rRsHrRIwVlfSPUO8bpF92EwHp95/BfRVg8YnxdGWCaXqjbh+Ol5yqHE
         dmbKv3Fdyg6Thol1Kq1ShEHgO1GhwxI9C9rZEpWSBxGWoeC3K2y8jSxsgIJ/SzcwRr
         oDIcgEtv8SQUiELJNgSt4RLZFe2dY6wjYEr/DKbaTtmnMqLLJGEUNJAhQVBHlf4H7P
         prtflBIOaNltfHp4pg4Gys245q0Azy7lFH75rtrX12GMm+sliBwiF5fELOU0DjTLqI
         mma9JsQEQBtPA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhenwei pi <pizhenwei@bytedance.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>, jasowang@redhat.com,
        axboe@kernel.dk, virtualization@lists.linux.dev,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/4] virtio-blk: fix implicit overflow on virtio_max_dma_size
Date:   Sun, 12 Nov 2023 08:24:23 -0500
Message-ID: <20231112132432.174680-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132432.174680-1-sashal@kernel.org>
References: <20231112132432.174680-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.138
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

From: zhenwei pi <pizhenwei@bytedance.com>

[ Upstream commit fafb51a67fb883eb2dde352539df939a251851be ]

The following codes have an implicit conversion from size_t to u32:
(u32)max_size = (size_t)virtio_max_dma_size(vdev);

This may lead overflow, Ex (size_t)4G -> (u32)0. Once
virtio_max_dma_size() has a larger size than U32_MAX, use U32_MAX
instead.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20230904061045.510460-1-pizhenwei@bytedance.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index d2ba849bb8d19..affeca0dbc7ea 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -743,6 +743,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	u16 min_io_size;
 	u8 physical_block_exp, alignment_offset;
 	unsigned int queue_depth;
+	size_t max_dma_size;
 
 	if (!vdev->config->get) {
 		dev_err(&vdev->dev, "%s failure: config access disabled\n",
@@ -844,7 +845,8 @@ static int virtblk_probe(struct virtio_device *vdev)
 	/* No real sector limit. */
 	blk_queue_max_hw_sectors(q, -1U);
 
-	max_size = virtio_max_dma_size(vdev);
+	max_dma_size = virtio_max_dma_size(vdev);
+	max_size = max_dma_size > U32_MAX ? U32_MAX : max_dma_size;
 
 	/* Host can optionally specify maximum segment size and number of
 	 * segments. */
-- 
2.42.0

