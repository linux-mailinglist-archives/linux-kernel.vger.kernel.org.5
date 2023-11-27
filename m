Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6667FA739
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjK0Q5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbjK0Q4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:56:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D8D2119;
        Mon, 27 Nov 2023 08:55:33 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 085D266073E5;
        Mon, 27 Nov 2023 16:55:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104132;
        bh=2gAqxxEJ2KqwbPuMzplAmWNudI3ZJjJVcvYYervFwW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqpRUR5B7rLkIPBrl96mQJqeD5R0o9Q5BMCoaKtg5QuqkLlcc+C911iU2FJnQzBX6
         F2zlghBwHF16o0UIYyjlbkocDMkKKD/AaICpRYiV4w57I/LqUDJ+7dQqqlVlGB+s99
         qG5ySA4re0p45He3Ra0IqcIm/IGL4lvPbWUIDdb93OxZFJA3DvKJqzFTnZhRkLtVu+
         wOSCU48w+YYSaPCltcO+cYnd3AyuzqTB6xc881+R4CslyHe3nXrQe92JmFPJhK2CcM
         LegUwvBEHebpAjinyfNEM35kcTmAZRZrrc3iy/D1gvAN5Mt2PtX0axNXNrjYIbSTiV
         +T5FmrLdIH1Ow==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 34/55] input: touchscreen: sur40: Stop abusing of min_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:33 +0100
Message-Id: <20231127165454.166373-35-benjamin.gaignard@collabora.com>
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

'min_buffers_needed' is suppose to be used to indicate the number
of buffers needed by DMA engine to start streaming.
sur40 touchscreen driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: linux-input@vger.kernel.org
---
 drivers/input/touchscreen/sur40.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index e7d2a52169a0..4da3063c352e 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -1124,7 +1124,7 @@ static const struct vb2_queue sur40_queue = {
 	.ops = &sur40_queue_ops,
 	.mem_ops = &vb2_dma_sg_memops,
 	.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC,
-	.min_buffers_needed = 3,
+	.min_reqbufs_allocation = 3,
 };
 
 static const struct v4l2_file_operations sur40_video_fops = {
-- 
2.39.2

