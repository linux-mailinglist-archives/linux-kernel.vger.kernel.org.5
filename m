Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED8B7B08F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjI0PiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjI0Pgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:36:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BC41AE;
        Wed, 27 Sep 2023 08:36:29 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:672:46bd:3ec7:6cdf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A00876607373;
        Wed, 27 Sep 2023 16:36:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695828988;
        bh=nwepyznt8z6pxABzkpFHR6clGV59kYVToyX8aj6cN+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ONqyrTE2hGWLwWIGz+oEE+zkDiSdp7AY/6CC6gkND7/p8p/mpNXXGuXdyjke8Eqbv
         4zatZ6INn/pGM7xDf07Z3CaOXgauPQ8B4stL1tCXSWnYtjpGir2/VmwXkdzOqbBhMY
         dMTyrV4uLADgw0lgk37/dB5+iPTX9k2Q0l8vrSoD3Usi59ebktNrYxpXvqdRB33BSf
         d+hzKTGzNwgKEM2x9luscYeYxeOxc2/UbRb5Nm1bIeiLC62A+ugBDlzS1ZxOCRCeRO
         o2v/I4Mxjf+7IhJjbN4h7BSBuVz0VYGANcRNq5sg+WrrPPr0zIcQkWv+EpgckcGJTV
         lbtvLRwdAsmdA==
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
Subject: [PATCH v8 41/53] media: usb: usbtv: Set min_buffers_needed to 2
Date:   Wed, 27 Sep 2023 17:35:46 +0200
Message-Id: <20230927153558.159278-42-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
References: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vb2 queue_setup checks for a minimum number of buffers so set
min_buffers_needed to 2 and remove the useless check in
usbtv_queue_setup().

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/usb/usbtv/usbtv-video.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
index 1e30e05953dc..0e9e860be47f 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -727,8 +727,6 @@ static int usbtv_queue_setup(struct vb2_queue *vq,
 	struct usbtv *usbtv = vb2_get_drv_priv(vq);
 	unsigned size = USBTV_CHUNK * usbtv->n_chunks * 2 * sizeof(u32);
 
-	if (vq->num_buffers + *nbuffers < 2)
-		*nbuffers = 2 - vq->num_buffers;
 	if (*nplanes)
 		return sizes[0] < size ? -EINVAL : 0;
 	*nplanes = 1;
@@ -892,6 +890,7 @@ int usbtv_video_init(struct usbtv *usbtv)
 	/* videobuf2 structure */
 	usbtv->vb2q.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	usbtv->vb2q.io_modes = VB2_MMAP | VB2_USERPTR | VB2_READ;
+	usbtv->vb2q.min_buffers_needed = 2;
 	usbtv->vb2q.drv_priv = usbtv;
 	usbtv->vb2q.buf_struct_size = sizeof(struct usbtv_buf);
 	usbtv->vb2q.ops = &usbtv_vb2_ops;
-- 
2.39.2

