Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EBF7A05EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbjINNee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239277AbjINNd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:33:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3401FFD;
        Thu, 14 Sep 2023 06:33:44 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:36f2:37bd:ccbb:373f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9577B6607377;
        Thu, 14 Sep 2023 14:33:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694698423;
        bh=N8F0TVW71sKqYIUdg2i7jHGXNNiGuYTWU5qjY+j8Vz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oFsDgzTcyrpxAlQlpxQ/2P4j2Ix+qcXNOxuNIVTdX9cEOU+1AnhgoyFAZ0JP9REkC
         Q/fUx+vRTrNK0B5SGzPHltRe+aGb05x/P1VLmP196NpE4zMd5ivunjMB3JiKPIfpA7
         ic1mCSv88L0jXh2UPG+oa497ijOIHDnmES/OdCKiI1Zasm7r4Zp2XQaJyY9MOXxpwO
         Zh24HgChuFlwTu+pHvKEEtFlJOx8adD7d+6aB3ueY4OTlpLgP/R+QqSXsHtpYDeTgc
         pIWUvnhR1K3jSDqGfAsdOaAiZJyqksjDbycmJPq0yYAWHWMloYhfbkZDkhHGgbvqet
         nD03lIDSkdM0g==
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
Subject: [PATCH v7 22/49] media: i2c: Stop direct calls to queue num_buffers field
Date:   Thu, 14 Sep 2023 15:32:56 +0200
Message-Id: <20230914133323.198857-23-benjamin.gaignard@collabora.com>
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
 drivers/media/i2c/video-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
index 537ebd9fa8d7..60d3e2f35afe 100644
--- a/drivers/media/i2c/video-i2c.c
+++ b/drivers/media/i2c/video-i2c.c
@@ -406,7 +406,7 @@ static int queue_setup(struct vb2_queue *vq,
 	struct video_i2c_data *data = vb2_get_drv_priv(vq);
 	unsigned int size = data->chip->buffer_size;
 
-	if (vq->num_buffers + *nbuffers < 2)
+	if (vb2_get_num_buffers(vq) + *nbuffers < 2)
 		*nbuffers = 2;
 
 	if (*nplanes)
-- 
2.39.2

