Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370C5806A34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377113AbjLFI4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377229AbjLFI4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:56:17 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6841B716;
        Wed,  6 Dec 2023 00:56:19 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8DDE8660732A;
        Wed,  6 Dec 2023 08:56:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701852978;
        bh=FTU8KzPND5ID0Hx3E+vk2e0gEDIDzN1LiyjU+EkE4jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvOo3pMftWfEYWWSJy44jD9zyzsPKAfR3zznUSvGY8ng4kAP8EMdKakgLzIBUVqlD
         xtr7Fcmu7+Z8ZfMWYwBVDFUwNewL5gaTkqJLK/lFnUMf420Nfs/6049NCBizwY3Jg3
         26JxiCzrYHzMu7Csl521xeSPP3UIcK8aiTQFDDgwCCAwm0zyzZiR3rfZ4lh9eYGUU8
         4VS+trLgkXcaSK01byLLNoodwoTmO7ta8eVRFDTPOdTcIFxG/MfujGg2MvzYf7WAPL
         elFDWvaDyenPG2qAYdi0b3eQGdZGBS5vm/lHbieOZ1EKvHPm/ONESn5efRoScwEVnG
         jQxJp5ngvuJpg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 2/2] videobuf2: Add min_reqbufs_allocation field to vb2_queue structure
Date:   Wed,  6 Dec 2023 09:56:08 +0100
Message-Id: <20231206085608.33246-3-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206085608.33246-1-benjamin.gaignard@collabora.com>
References: <20231206085608.33246-1-benjamin.gaignard@collabora.com>
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
If used this minimum should be higher than the minimum number of
queued buffers needed to start streaming.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 1 +
 include/media/videobuf2-core.h                  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 7b6d89641e66..3bc30d107308 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -866,6 +866,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	 * Make sure the requested values and current defaults are sane.
 	 */
 	num_buffers = max_t(unsigned int, *count, q->min_queued_buffers);
+	num_buffers = max_t(unsigned int, num_buffers, q->min_reqbufs_allocation);
 	num_buffers = min_t(unsigned int, num_buffers, q->max_num_buffers);
 	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
 	/*
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 6d11cb724e95..252d34cc47d3 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -550,6 +550,11 @@ struct vb2_buf_ops {
  *		@start_streaming can be called. Used when a DMA engine
  *		cannot be started unless at least this number of buffers
  *		have been queued into the driver.
+ * @min_reqbufs_allocation: the minimum number of buffers allocated when
+ *		calling VIDIOC_REQBUFS. Used when drivers need a to
+ *		specify a minimum buffers allocation before setup a queue.
+ *		If min_queued_buffers < min_queued_buffers then min_queued_buffers
+ *		is the minimum.
  */
 /*
  * Private elements (won't appear at the uAPI book):
@@ -615,6 +620,7 @@ struct vb2_queue {
 	u32				timestamp_flags;
 	gfp_t				gfp_flags;
 	u32				min_queued_buffers;
+	u32				min_reqbufs_allocation;
 
 	struct device			*alloc_devs[VB2_MAX_PLANES];
 
-- 
2.39.2

