Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AA87C6D53
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379361AbjJLLtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378700AbjJLLrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:47:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7EE109;
        Thu, 12 Oct 2023 04:47:15 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7ae7:b86d:c19a:877e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 658226607379;
        Thu, 12 Oct 2023 12:47:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697111233;
        bh=MaJc8KF/Sr+P2A1rELzeazrdtI+Dtx39Ekc9mMARKkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAouVKN3OAalElzf429fDxDA3/X/KhRsnUm3ukPaWmjHHSEZdBhsjtFVUSjP2l+qq
         9KVnzkreD84VAAr3Y5CIxt6zyFHRUzEDzGKGlN/gp0fQMumcwtSf4zapr/lo6UeSXv
         JTU6Sa95+SIAdK6M5QCN2QcYp9WZRb0Zb1/KxrUCH+LJK7Bob798lW8d/G4Ws3fmyR
         WpB5ztYPv0DJbSY6g3L8H0iPvnA5Fx68im1FbQiqpKf4qsbSfHt/2gSwvzvOdBVR8I
         T1u46E1GZQikH219t2eYkO71x4a+vgjX50i2G5mhsPk3kOAwOwJLmN2+J6Gvjps//5
         9RBi3mbPAHH9g==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v11 45/56] media: test-drivers: vivid: Increase max supported buffers for capture queues
Date:   Thu, 12 Oct 2023 13:46:31 +0200
Message-Id: <20231012114642.19040-46-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
References: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the maximum number of buffers of some capture queues in order
to test max_num_buffers field.

Allow to allocate up to:
- 64 buffers for video capture queue.
- 1024 buffers for sdr capture queue.
- 32768 buffers for vbi capture queue.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/test-drivers/vivid/vivid-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
index 394c9f81ea72..b5656330578d 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -876,6 +876,13 @@ static int vivid_create_queue(struct vivid_dev *dev,
 	q->type = buf_type;
 	q->io_modes = VB2_MMAP | VB2_DMABUF;
 	q->io_modes |= V4L2_TYPE_IS_OUTPUT(buf_type) ?  VB2_WRITE : VB2_READ;
+	if (buf_type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+		q->max_num_buffers = 64;
+	if (buf_type == V4L2_BUF_TYPE_SDR_CAPTURE)
+		q->max_num_buffers = 1024;
+	if (buf_type == V4L2_BUF_TYPE_VBI_CAPTURE)
+		q->max_num_buffers = 32768;
+
 	if (allocators[dev->inst] != 1)
 		q->io_modes |= VB2_USERPTR;
 	q->drv_priv = dev;
-- 
2.39.2

