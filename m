Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FE97E6F2F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344310AbjKIQid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344672AbjKIQiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:38:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAF03863;
        Thu,  9 Nov 2023 08:37:59 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8F09B660741B;
        Thu,  9 Nov 2023 16:37:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547878;
        bh=AtH8K8Z2Aob2e0uNs8JrzF1vK5paJ9ly85DM9H+gmrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkY1lwTGVi/CKA3h+b9wU7SZHZX1MOf9TKjj2eqU8RQDROcPck7kdVwtqdUU4RK2H
         pa7BNi/Egy8NxGzfWIvMf3M/9Es/Apg+ySVgiCeW+/SQhQhL6Lj/pJdB4Fbm8RCdxd
         RJdBrUm9JNFy2ZpLVpiBFaicG7YJc0w1ErD7a8gzWq35pqZcRDtPhHd0Nosq2/eqT3
         tWwi+9t9i0b8ewQg+wLeLG1vwuD2eRzIc2PmVzExTcXWi6uboenunTtwltbT/E7qXY
         xjOeh0+q4T5BHqw71+1+oJApl4F4B7qYwAJD1whO1q145h+f9Aiapc1H2eRrdQqWws
         4UowFRVx6Jp9w==
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
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH v15 25/56] media: pci: tw68: Stop direct calls to queue num_buffers field
Date:   Thu,  9 Nov 2023 17:34:41 +0100
Message-Id: <20231109163512.179524-26-benjamin.gaignard@collabora.com>
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
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/media/pci/tw68/tw68-video.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/tw68/tw68-video.c b/drivers/media/pci/tw68/tw68-video.c
index 773a18702d36..79b627ebc92a 100644
--- a/drivers/media/pci/tw68/tw68-video.c
+++ b/drivers/media/pci/tw68/tw68-video.c
@@ -360,13 +360,14 @@ static int tw68_queue_setup(struct vb2_queue *q,
 			   unsigned int sizes[], struct device *alloc_devs[])
 {
 	struct tw68_dev *dev = vb2_get_drv_priv(q);
-	unsigned tot_bufs = q->num_buffers + *num_buffers;
+	unsigned int q_num_bufs = vb2_get_num_buffers(q);
+	unsigned int tot_bufs = q_num_bufs + *num_buffers;
 	unsigned size = (dev->fmt->depth * dev->width * dev->height) >> 3;
 
 	if (tot_bufs < 2)
 		tot_bufs = 2;
 	tot_bufs = tw68_buffer_count(size, tot_bufs);
-	*num_buffers = tot_bufs - q->num_buffers;
+	*num_buffers = tot_bufs - q_num_bufs;
 	/*
 	 * We allow create_bufs, but only if the sizeimage is >= as the
 	 * current sizeimage. The tw68_buffer_count calculation becomes quite
-- 
2.39.2

