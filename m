Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797528037B6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjLDN0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344595AbjLDNYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:24:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD2719A4;
        Mon,  4 Dec 2023 05:24:23 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 19C1C660711D;
        Mon,  4 Dec 2023 13:24:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701696262;
        bh=Gl50yamOqxp5F3J61bdrX38ELoxqbgPRLIk274ynKbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7AymoDN23peeo2rYK+6KBvHLhLevEnsznJewdctG2+XbxaZqVFAotigw//kcWyeL
         0/yS9hdKsu8JlMHkZ48H6r22r5ftYMnRpd9yo6OAq02BPB8bEg4w5Eu3R1kq3g+FCX
         Cl2cfj8wftNOLQSM5Gk/Rknxfeg/SuoH+xUr3+0OVDpaloGrFqo0Z6oyDVA8S/Quzr
         /jEejnMap3aV9zOb04kFrMuMWSk9j6SwwrJ70/ZfucGS4taGygNhCYAUVm5ZKqwHBd
         Me8/GJU6+c2Jpgq4Whw6bxOGbcbr9ZswbeULXElhiFk+pwpJ72KU867vQIkSDbu1xf
         XAMJB4rlRNaiQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 29/36] media: sunxi: sun6i-csi: Fix misuse of min_buffers_needed field
Date:   Mon,  4 Dec 2023 14:23:16 +0100
Message-Id: <20231204132323.22811-30-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204132323.22811-1-benjamin.gaignard@collabora.com>
References: <20231204132323.22811-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'min_buffers_needed' is suppose to be used to indicate the number
of buffers needed by DMA engine to start streaming.
sun6i-csi driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Chen-Yu Tsai <wens@csie.org>
CC: Jernej Skrabec <jernej.skrabec@gmail.com>
CC: Samuel Holland <samuel@sholland.org>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index cf6aadbc130b..73e721936d27 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -1010,7 +1010,7 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 	queue->buf_struct_size = sizeof(struct sun6i_csi_buffer);
 	queue->ops = &sun6i_csi_capture_queue_ops;
 	queue->mem_ops = &vb2_dma_contig_memops;
-	queue->min_buffers_needed = 2;
+	queue->min_reqbufs_allocation = 2;
 	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	queue->lock = &capture->lock;
 	queue->dev = csi_dev->dev;
-- 
2.39.2

