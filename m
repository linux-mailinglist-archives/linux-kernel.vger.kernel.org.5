Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0707E6F6F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbjKIQk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjKIQjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:39:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59CA4693;
        Thu,  9 Nov 2023 08:38:34 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CD6F266076D0;
        Thu,  9 Nov 2023 16:38:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547913;
        bh=43xinBr2kPIZE8TtRPdS2cjSs0wQVBCzw73zdRmmfY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoW+KWPGTwYzK9VZL/9RxbJgCyVQhJDcYpmDGW+3PK2nATjpaqE2hbHzCjZK9rZdR
         gYZ7KTVrE08gwA3kdn5BDQa4Waxv85DbxD/I0tFsNSqzy+iA4jJz+9f30NPUePMLgL
         ISLJhLgTL008vDbgSBWdS8g0sv+aRIN8JXYT9SzzpWTbOlEs4gy1fcxavmbghI+4wT
         1qEzgF2s8gd7xiLOzln0O2PNKhn+GyO4gcDCnHWRxIy6ABfuhkOZboewmyOscd6ikO
         mFdgL9ov4ECzPYblv4MQ/PwNqyeDtQdC8kSfLRknYOi33Tusw974Eg9dbx1/YeC6ur
         kSOz4pbUklITw==
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
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: [PATCH v15 45/56] media: test-drivers: vivid: Increase max supported buffers for capture queues
Date:   Thu,  9 Nov 2023 17:35:01 +0100
Message-Id: <20231109163512.179524-46-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
References: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 drivers/media/test-drivers/vivid/vivid-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
index 394c9f81ea72..353f035fcd19 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -876,6 +876,20 @@ static int vivid_create_queue(struct vivid_dev *dev,
 	q->type = buf_type;
 	q->io_modes = VB2_MMAP | VB2_DMABUF;
 	q->io_modes |= V4L2_TYPE_IS_OUTPUT(buf_type) ?  VB2_WRITE : VB2_READ;
+
+	/*
+	 * The maximum number of buffers is 32768 if PAGE_SHIFT == 12,
+	 * see also MAX_BUFFER_INDEX in videobuf2-core.c. It will be less if
+	 * PAGE_SHIFT > 12, but then max_num_buffers will be clamped by
+	 * videobuf2-core.c to MAX_BUFFER_INDEX.
+	 */
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

