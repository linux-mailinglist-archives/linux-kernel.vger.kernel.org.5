Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F33C7E6F5C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344792AbjKIQja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344842AbjKIQi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:38:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D854496;
        Thu,  9 Nov 2023 08:38:21 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 401AD66076BF;
        Thu,  9 Nov 2023 16:38:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547900;
        bh=B9/TxQu67i5OUs2XFrxigqj4gKM3accNnzrVxeIEiTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oW6Lr0o226QIo1W9LdS8FR7c3JMJm0ddcz3LvLYVBHQO6eI3nd1iolBOXH4rMB6yc
         tRffp2Ykw9puuECxH8//oWqGIF8xTElJTvvVbVlZ83i7ibBOQ0jlks8WytjhccJ4Ri
         mUc67TgPdHqx5aA0Kq5dQwJidqbKnwzT4cORaIpoBN+90yEsgEdolOuDTeAiFSfKrp
         oGVF5gq5q2NFkJqBu6Nj18r9+1QtDB+0Y99OYNSimmhlfXxtLMjgA7pfEWypBxrB/X
         2ry2V3oAg3giZdq080HxlZ1S/203fQveAhBedrC1su+BYPY3iI1S0fDFxGDJ0/a22/
         frWo1ugH0MPsA==
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
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH v15 37/56] media: renesas: Stop direct calls to queue num_buffers field
Date:   Thu,  9 Nov 2023 17:34:53 +0100
Message-Id: <20231109163512.179524-38-benjamin.gaignard@collabora.com>
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
CC: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/media/platform/renesas/rcar_drif.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar_drif.c b/drivers/media/platform/renesas/rcar_drif.c
index 292c5bf9e50c..f21d05054341 100644
--- a/drivers/media/platform/renesas/rcar_drif.c
+++ b/drivers/media/platform/renesas/rcar_drif.c
@@ -424,10 +424,11 @@ static int rcar_drif_queue_setup(struct vb2_queue *vq,
 			unsigned int sizes[], struct device *alloc_devs[])
 {
 	struct rcar_drif_sdr *sdr = vb2_get_drv_priv(vq);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 
 	/* Need at least 16 buffers */
-	if (vq->num_buffers + *num_buffers < 16)
-		*num_buffers = 16 - vq->num_buffers;
+	if (q_num_bufs + *num_buffers < 16)
+		*num_buffers = 16 - q_num_bufs;
 
 	*num_planes = 1;
 	sizes[0] = PAGE_ALIGN(sdr->fmt->buffersize);
-- 
2.39.2

