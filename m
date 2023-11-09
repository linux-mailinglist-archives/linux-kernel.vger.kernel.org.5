Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90297E6FBE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343841AbjKIQzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjKIQin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:38:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD50F3C3A;
        Thu,  9 Nov 2023 08:38:15 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C3D5966076BA;
        Thu,  9 Nov 2023 16:38:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547894;
        bh=VwZU4+ckcXzSAwnWbSC53r966DVTmWsb2+Sz1f2VGIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dll9Owb3ybwYnDK8Q7X0yrqAA1cXb582B4OcCJoiE+pSC1HOjwsi9CO2kTjWfnHom
         uT0rJ4Z/kXSD43XhiJ4hHQHjJ+gykyx7tC17X/qiCT8/M3Knfaqt1T7sPijJaonJzN
         x9r7QJMgYi5I8wf40bQJEwEvp+Q+Ei5wkOETxRa2JEi99zC3uIN7D9XiDHkvT3sUbZ
         NcxyM3l1WAvmwodoCbgjZ7YslUwgJZgyI19uy+fyP2Cfx87GKoqJ+ZJLlWMs18F2Y4
         dO7nSMKy+hEc2aJxgswqPq+rPQdKI2ge+RHZ9dsHvmVsrDxYdj4OgsbQf3iLwNdUPN
         lMxe+DWioTspg==
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
Subject: [PATCH v15 34/56] sample: v4l: Stop direct calls to queue num_buffers field
Date:   Thu,  9 Nov 2023 17:34:50 +0100
Message-Id: <20231109163512.179524-35-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
References: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
This allows us to change how the number of buffers is computed in the
future.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 samples/v4l/v4l2-pci-skeleton.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/samples/v4l/v4l2-pci-skeleton.c b/samples/v4l/v4l2-pci-skeleton.c
index a61f94db18d9..a65aa9d1e9da 100644
--- a/samples/v4l/v4l2-pci-skeleton.c
+++ b/samples/v4l/v4l2-pci-skeleton.c
@@ -155,6 +155,7 @@ static int queue_setup(struct vb2_queue *vq,
 		       unsigned int sizes[], struct device *alloc_devs[])
 {
 	struct skeleton *skel = vb2_get_drv_priv(vq);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 
 	skel->field = skel->format.field;
 	if (skel->field == V4L2_FIELD_ALTERNATE) {
@@ -167,8 +168,8 @@ static int queue_setup(struct vb2_queue *vq,
 		skel->field = V4L2_FIELD_TOP;
 	}
 
-	if (vq->num_buffers + *nbuffers < 3)
-		*nbuffers = 3 - vq->num_buffers;
+	if (q_num_bufs + *nbuffers < 3)
+		*nbuffers = 3 - q_num_bufs;
 
 	if (*nplanes)
 		return sizes[0] < skel->format.sizeimage ? -EINVAL : 0;
-- 
2.39.2

