Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591037FA6E8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjK0QzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjK0QzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:55:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DBE19D;
        Mon, 27 Nov 2023 08:55:07 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F2CC66022D7;
        Mon, 27 Nov 2023 16:55:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104106;
        bh=7RGpb9eXUi6lQdxW/1vzQwvC1+GPAwIhQ8xVVzZPHxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mZH1E01jZ/S5Hq899zWgoDmRG3t+rsfwswbnQ3j9cmRv8JM0v38MqPuPY5/2B40iD
         1WRWKwwnTEOngzDCfrIk5/KqBhzjaIaXbQmp2tUux612pDmybPPKjAHh1mpC+j4eei
         cl+3OBHY/39B/Mde6CvN9xUD5YU+UPJn+COl/YdBjjnUX16/q+HSJLxS/ke7/2JawY
         BRb1K8WbapOpUdL5zN9Gbc+cZqKhHXu9b1TwtlKT7gAnr/Dhww53zxW8b64YXq16bE
         ARZQfGTzdGRO1ny4wbMK7kJRhXuvgz8C757X0smbHbyN9LedmbhV+rGFpzWjwr1k2r
         6D2TV0Ov0syGA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 01/55] videobuf2: Add min_reqbufs_allocation field to vb2_queue structure
Date:   Mon, 27 Nov 2023 17:54:00 +0100
Message-Id: <20231127165454.166373-2-benjamin.gaignard@collabora.com>
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

Add 'min_reqbufs_allocation' field in vb2_queue structure so drivers
can specificy the minimum number of buffers to allocate when calling
VIDIOC_REQBUFS.
Later that will help to distinguish the minimum number of buffers
needed to start streaming versus the minimum allocation requirement.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 1 +
 include/media/videobuf2-core.h                  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 8c1df829745b..c224d13b3105 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -866,6 +866,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	 * Make sure the requested values and current defaults are sane.
 	 */
 	num_buffers = max_t(unsigned int, *count, q->min_buffers_needed);
+	num_buffers = max_t(unsigned int, num_buffers, q->min_reqbufs_allocation);
 	num_buffers = min_t(unsigned int, num_buffers, q->max_num_buffers);
 	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
 	/*
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 5557d78b6f20..17cacd696ab4 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -550,6 +550,9 @@ struct vb2_buf_ops {
  *		@start_streaming can be called. Used when a DMA engine
  *		cannot be started unless at least this number of buffers
  *		have been queued into the driver.
+ * @min_reqbufs_allocation: the minimum number of buffers allocated when
+ *		calling VIDIOC_REQBUFS. Used when drivers need a to
+ *		specify a minimum buffers allocation before setup a queue.
  */
 /*
  * Private elements (won't appear at the uAPI book):
@@ -615,6 +618,7 @@ struct vb2_queue {
 	u32				timestamp_flags;
 	gfp_t				gfp_flags;
 	u32				min_buffers_needed;
+	u32				min_reqbufs_allocation;
 
 	struct device			*alloc_devs[VB2_MAX_PLANES];
 
-- 
2.39.2

