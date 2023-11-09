Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7765C7E6F21
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbjKIQiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344353AbjKIQiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:38:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564B73A9D;
        Thu,  9 Nov 2023 08:37:54 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 414F666076A9;
        Thu,  9 Nov 2023 16:37:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547873;
        bh=tH0dDZoY7AzlQtbTMci7rFl4joXADXoUOtykCWAO0ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2Z3fvqBe7KzpKhhXolyZoXKhY8XlKdqkwyaHfS4j7hR0A+KSc3wqDK00rvTk1QlQ
         DlNaoCYh0e0KuZrEFnIIPt1wxg/PJ/JhzIHpKTaA74980sRTyRI5TpHLqizYVX8BIZ
         Ro31Ec6rZE7u6i4/VPruIg8rEe/gc2xycCNvAJgSAR9/2mK9lYjpQzwofp9+7WUDNx
         3YH/e0E4vdI6R+/vaOg6h7pnl7NeuIQOcuIPswD95elNNWL+FpR+9VyDYxf9TJ4z+W
         SOAqsDyN20SJ3l4V2GnTuzra5nVRwaNMMbkfb3dOb23Kpg+OchP6RWnTmllC6zrZPX
         Zt3lCj0D2lwWQ==
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
Subject: [PATCH v15 22/56] media: pci: tw686x: Stop direct calls to queue num_buffers field
Date:   Thu,  9 Nov 2023 17:34:38 +0100
Message-Id: <20231109163512.179524-23-benjamin.gaignard@collabora.com>
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
CC: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/media/pci/tw686x/tw686x-video.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/tw686x/tw686x-video.c b/drivers/media/pci/tw686x/tw686x-video.c
index 3ebf7a2c95f0..6bc6d143d18c 100644
--- a/drivers/media/pci/tw686x/tw686x-video.c
+++ b/drivers/media/pci/tw686x/tw686x-video.c
@@ -423,6 +423,7 @@ static int tw686x_queue_setup(struct vb2_queue *vq,
 			      unsigned int sizes[], struct device *alloc_devs[])
 {
 	struct tw686x_video_channel *vc = vb2_get_drv_priv(vq);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 	unsigned int szimage =
 		(vc->width * vc->height * vc->format->depth) >> 3;
 
@@ -430,8 +431,8 @@ static int tw686x_queue_setup(struct vb2_queue *vq,
 	 * Let's request at least three buffers: two for the
 	 * DMA engine and one for userspace.
 	 */
-	if (vq->num_buffers + *nbuffers < 3)
-		*nbuffers = 3 - vq->num_buffers;
+	if (q_num_bufs + *nbuffers < 3)
+		*nbuffers = 3 - q_num_bufs;
 
 	if (*nplanes) {
 		if (*nplanes != 1 || sizes[0] < szimage)
-- 
2.39.2

