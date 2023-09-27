Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168217B08F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjI0Pig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjI0Pge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:36:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B181BD;
        Wed, 27 Sep 2023 08:36:31 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:672:46bd:3ec7:6cdf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 944136607379;
        Wed, 27 Sep 2023 16:36:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695828989;
        bh=uwQYrGuMm2ejNz+6p1iPg1BLomW4NJekCoZt42bzvk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AlqQgzobtesqfGrDxwhOqSYfYn2QQtcUygEczU7exug94O8iDwsanECUJ8iRrMj4F
         9NFbx+V5AXelw+8SEPMa6XW+VPySUyhXEi45/9lhGnvdR4n2hGJ/4MOlKQ9UbojxZE
         XFpTRhzXm8YSK3wssqLifIjWe7nCNXxPHH4iwdbyX3L40+8ZIBwX44kOIEJoVacGCL
         RGcWMolRAl3kW68fvjhZLcGsBJCe+YgXmqAqoIRfy4XLM/Qso035ePPv/d8XmMNFgo
         w+FZQg8L9eTKhCZASwBwvK/jUIGAf74yAShBfxBa2CdTqa8ByYm/rFfeQMl22OEnY4
         qut9i7JQcC9GQ==
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
Subject: [PATCH v8 45/53] touchscreen: sur40: Stop direct calls to queue num_buffers field
Date:   Wed, 27 Sep 2023 17:35:50 +0200
Message-Id: <20230927153558.159278-46-benjamin.gaignard@collabora.com>
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

Use vb2_get_num_buffers() to avoid using queue num_buffer field directly.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/input/touchscreen/sur40.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 8ddb3f7d307a..e7d2a52169a0 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -847,9 +847,10 @@ static int sur40_queue_setup(struct vb2_queue *q,
 		       unsigned int sizes[], struct device *alloc_devs[])
 {
 	struct sur40_state *sur40 = vb2_get_drv_priv(q);
+	unsigned int q_num_bufs = vb2_get_num_buffers(q);
 
-	if (q->num_buffers + *nbuffers < 3)
-		*nbuffers = 3 - q->num_buffers;
+	if (q_num_bufs + *nbuffers < 3)
+		*nbuffers = 3 - q_num_bufs;
 
 	if (*nplanes)
 		return sizes[0] < sur40->pix_fmt.sizeimage ? -EINVAL : 0;
-- 
2.39.2

