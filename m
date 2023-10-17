Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219CC7CC64C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344219AbjJQOsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344126AbjJQOsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:48:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D18BF5;
        Tue, 17 Oct 2023 07:48:08 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7205:da49:a7e8:59f8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CEF7B6607319;
        Tue, 17 Oct 2023 15:48:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697554087;
        bh=lM3wXK65Q+RBpyeYExb53Y3bnLmIcGL+rErhrVO2B80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PP81loCKWTKjK1+86vofkXTFXVAYLuvXUxc2qiOq6ZbJxkmBuzwNywJpBOBjwpX6S
         K15xrXVhtCZVQQkfZL5NteMhulqFfwp6Xv8IYe47CF09oCq/ObVt+FHoVz42o8kDxy
         YE0PNW11wXoMycJcWPlQt/8zQg4IqIzAuVdaW33Ej6LOpIWNeXU9kdMITSpmnK2plq
         d4eumTeYlbGQBWI6987sNj3EmzWFa4iuPGlKfLqO1f+0LWxKML7UCKDcw+bBnVnBwg
         Pm198/OLU4bHey09mYxgqY/bUOFBEGD9FubmdpPUihnoRSYQpcZm7R2Lqy5cph7hmR
         jIX60IFJOSNCg==
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
Subject: [PATCH v12 07/56] media: videobuf2: Add helper to get queue number of buffers
Date:   Tue, 17 Oct 2023 16:47:07 +0200
Message-Id: <20231017144756.34719-8-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
References: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
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

In the future a side effect of introducing DELETE_BUFS ioctl is
the create of 'holes' (i.e. unused buffers) in bufs arrays.
To know which entries of the bufs arrays are used a bitmap will
be added in struct vb2_queue. That will also mean that the number
of buffers will be computed given the number of bit set in this bitmap.
To smoothly allow this evolution all drives must stop using
directly num_buffers field from struct vb2_queue.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 include/media/videobuf2-core.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index cd3ff1cd759d..8f9d9e4af5b1 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -1139,6 +1139,15 @@ static inline bool vb2_fileio_is_active(struct vb2_queue *q)
 	return q->fileio;
 }
 
+/**
+ * vb2_get_num_buffers() - get the number of buffer in a queue
+ * @q:		pointer to &struct vb2_queue with videobuf2 queue.
+ */
+static inline unsigned int vb2_get_num_buffers(struct vb2_queue *q)
+{
+	return q->num_buffers;
+}
+
 /**
  * vb2_is_busy() - return busy status of the queue.
  * @q:		pointer to &struct vb2_queue with videobuf2 queue.
@@ -1147,7 +1156,7 @@ static inline bool vb2_fileio_is_active(struct vb2_queue *q)
  */
 static inline bool vb2_is_busy(struct vb2_queue *q)
 {
-	return (q->num_buffers > 0);
+	return vb2_get_num_buffers(q) > 0;
 }
 
 /**
-- 
2.39.2

