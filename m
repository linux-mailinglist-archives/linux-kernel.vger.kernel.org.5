Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9733E7DD221
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346289AbjJaQcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345940AbjJaQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:32:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0843D1BF;
        Tue, 31 Oct 2023 09:31:47 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:c562:2ef4:80c0:92f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 63CAD66073AE;
        Tue, 31 Oct 2023 16:31:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698769905;
        bh=7OP/lnsbD5MzPZ4L/gceSmxIzda3Ng9eLtu0phjni7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhZvI0Wm6tpsneCvOt5IoGfJVyNH+/OpU7UlOjcjY4UZsgk8dc55BjoI7wX3bDJFV
         ytEiqyn297DiwwaX5+GRYPGpFp0teKBvBcmNWxK+875xqHhycAZvcqPp0EiFUODr7J
         KdVhF0I1TMLct5mfJoehCzcPqx8xXFKUuIhWW3VBnnh4vsUVovTYgt/OaXI/ijgKeC
         LohvT/M1/kWGGVMTo8JDrffuBGneRtcx98g+xzdTC6EOZnSaIYQ3JnVBfsUHY/MZZt
         t4xZlFmA7/JF1t/HhPSVK/0K9Z3fvefHBhXoEUmqdGtTLiExuS/OxRTC4hQUMdEAn7
         uL14uvLIcbJww==
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
Subject: [PATCH v14 21/56] media: pci: dt3155: Remove useless check
Date:   Tue, 31 Oct 2023 17:30:29 +0100
Message-Id: <20231031163104.112469-22-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

min_buffers_needed is already set to 2 so remove this useless
check.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/pci/dt3155/dt3155.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/pci/dt3155/dt3155.c b/drivers/media/pci/dt3155/dt3155.c
index 548156b199cc..d09cde2f6ee4 100644
--- a/drivers/media/pci/dt3155/dt3155.c
+++ b/drivers/media/pci/dt3155/dt3155.c
@@ -128,8 +128,6 @@ dt3155_queue_setup(struct vb2_queue *vq,
 	struct dt3155_priv *pd = vb2_get_drv_priv(vq);
 	unsigned size = pd->width * pd->height;
 
-	if (vq->num_buffers + *nbuffers < 2)
-		*nbuffers = 2 - vq->num_buffers;
 	if (*num_planes)
 		return sizes[0] < size ? -EINVAL : 0;
 	*num_planes = 1;
-- 
2.39.2

