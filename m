Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA58B7E6F02
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344252AbjKIQhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbjKIQhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:37:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF56F35BD;
        Thu,  9 Nov 2023 08:37:39 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D7E3666076A5;
        Thu,  9 Nov 2023 16:37:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547858;
        bh=bV0ERtEqdV4yHcsPhAjbGgZ+BzDtJjLwQFzfoOyB/fM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5GvkQLlCM+m4Xl43QcH1akmp7cjecSe3ztlpuCREXLg1uS3msm9Vse6tcCr/pXsM
         ol5GEKFBMW6gz0UHLPpBld/TQ5obsJKUaQXFTZzddvR8Kxau6yJlFYUpcKggK5tI7u
         sblcvHwesYLJHGmgOSbLapbg/LR4YyK5elk8xwsRuoy+6W7Zm/Q/Dl+ELC97Yr5q/+
         37KVrPg6reMWapTPKyelhKv47bi1oQwudRqlHaow5RuOXFdeuE46LVmo2ftXoQ8CAZ
         htwbFEiSDwbAdQuij7SnLGVMv9teO//GHRQd+U06BbqrDh4IT59IQHuYVHUGt4QcIn
         f3avZvAJTgbnA==
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
        Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>
Subject: [PATCH v15 14/56] media: sti: hva: Remove useless check
Date:   Thu,  9 Nov 2023 17:34:30 +0100
Message-Id: <20231109163512.179524-15-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
References: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove index range test since it is done by vb2_get_buffer().
vb2_get_buffer() can return a NULL pointer so we need the return
value.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>
---
 drivers/media/platform/st/sti/hva/hva-v4l2.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/st/sti/hva/hva-v4l2.c b/drivers/media/platform/st/sti/hva/hva-v4l2.c
index 3a848ca32a0e..cfe83e9dc01b 100644
--- a/drivers/media/platform/st/sti/hva/hva-v4l2.c
+++ b/drivers/media/platform/st/sti/hva/hva-v4l2.c
@@ -569,14 +569,11 @@ static int hva_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
 		struct vb2_buffer *vb2_buf;
 
 		vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx, buf->type);
-
-		if (buf->index >= vq->num_buffers) {
-			dev_dbg(dev, "%s buffer index %d out of range (%d)\n",
-				ctx->name, buf->index, vq->num_buffers);
+		vb2_buf = vb2_get_buffer(vq, buf->index);
+		if (!vb2_buf) {
+			dev_dbg(dev, "%s buffer index %d not found\n", ctx->name, buf->index);
 			return -EINVAL;
 		}
-
-		vb2_buf = vb2_get_buffer(vq, buf->index);
 		stream = to_hva_stream(to_vb2_v4l2_buffer(vb2_buf));
 		stream->bytesused = buf->bytesused;
 	}
-- 
2.39.2

