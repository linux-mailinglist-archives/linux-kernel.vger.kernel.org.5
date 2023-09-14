Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15327A061B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239061AbjINNfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239851AbjINNeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:34:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4990272D;
        Thu, 14 Sep 2023 06:33:53 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:36f2:37bd:ccbb:373f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D7676607350;
        Thu, 14 Sep 2023 14:33:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694698432;
        bh=8QdmTHdgoaFCZ92hWXIEL9hOaDrX90tCZOqZYUq2PdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIrpjdHHkd8DCsezUS6Db1t2mu//j9qGKSeanMJQE79X+olRQO4KTQpC5RaEVpaXZ
         fuztA6tGqvwzZ1PtMQJtqVn2jR+bbTJlozFixJYdu64lOLpfm86pNS0Htz0Spop+Oh
         Wd1Wevs9N5g1gGaXwynNkHxF6L1jjDQwlDyEa/bRvVS/GpyU3vGcaZXPNLG8YMeiEu
         5/hrxlneaY3Pi+0si5lcj1NKHcHZuEhgQhhOdftaYznfEim3yrOBNLzUa5vLyhLISI
         8jYt914ufA6p3QiSz+BypCIRLDedkOW6MUxydy9ude1UD5XADaX26eJ8LV+b3sRizY
         n1nNnWMdKdXeA==
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
Subject: [PATCH v7 40/49] media: usb: usbtv: Stop direct calls to queue num_buffers field
Date:   Thu, 14 Sep 2023 15:33:14 +0200
Message-Id: <20230914133323.198857-41-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_num_buffers() to avoid using queue num_buffer field directly.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/usb/usbtv/usbtv-video.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
index 1e30e05953dc..41704d45c65c 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -725,10 +725,11 @@ static int usbtv_queue_setup(struct vb2_queue *vq,
 	unsigned int *nplanes, unsigned int sizes[], struct device *alloc_devs[])
 {
 	struct usbtv *usbtv = vb2_get_drv_priv(vq);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 	unsigned size = USBTV_CHUNK * usbtv->n_chunks * 2 * sizeof(u32);
 
-	if (vq->num_buffers + *nbuffers < 2)
-		*nbuffers = 2 - vq->num_buffers;
+	if (q_num_bufs + *nbuffers < 2)
+		*nbuffers = 2 - q_num_bufs;
 	if (*nplanes)
 		return sizes[0] < size ? -EINVAL : 0;
 	*nplanes = 1;
-- 
2.39.2

