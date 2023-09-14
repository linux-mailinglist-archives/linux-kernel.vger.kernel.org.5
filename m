Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED807A05E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239616AbjINNeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbjINNd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:33:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A091FC2;
        Thu, 14 Sep 2023 06:33:43 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:36f2:37bd:ccbb:373f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 16B99660734D;
        Thu, 14 Sep 2023 14:33:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694698422;
        bh=aeJc8Jxcb8/QbECmV25qK+8LTdH51/KXmWUpXuI4BR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkLIjEy2vX3bpMH3buUT4cdpI7iRafMZckCzgDYWsix0SUPgu3Jc8uxt7LyFI/4FN
         zpki5QpXi/wJpp4RUvpkfSVJu5j5QMl9lueRCWkn/VlXfac6kiOCt7yUj64gPTODZT
         wLnIU5q+RBlJRH1uQh6RLh72Vm8WEFetXbdxsvY8gvnFTTU5bOJtuptiAXMpAD0/ru
         /wCR2yEG4NgHtL1iG2hqtlUo2K8JiZWp44XQ1+u1dnWMSHHAqdXA1LWFaD77pz9f7r
         gvMSAwli3PdGl/6EYHWc2QbbHdDP6st86TBiJddI7gFfvzgLJuG4osJSS8ICQPqXUU
         3sQ+c6hN6G+BA==
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
Subject: [PATCH v7 21/49] media: dvb: Stop direct calls to queue num_buffers field
Date:   Thu, 14 Sep 2023 15:32:55 +0200
Message-Id: <20230914133323.198857-22-benjamin.gaignard@collabora.com>
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
 drivers/media/dvb-core/dvb_vb2.c          | 1 -
 drivers/media/dvb-frontends/rtl2832_sdr.c | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_vb2.c b/drivers/media/dvb-core/dvb_vb2.c
index 3a966fdf814c..a731b755a0b9 100644
--- a/drivers/media/dvb-core/dvb_vb2.c
+++ b/drivers/media/dvb-core/dvb_vb2.c
@@ -177,7 +177,6 @@ int dvb_vb2_init(struct dvb_vb2_ctx *ctx, const char *name, int nonblocking)
 	q->ops = &dvb_vb2_qops;
 	q->mem_ops = &vb2_vmalloc_memops;
 	q->buf_ops = &dvb_vb2_buf_ops;
-	q->num_buffers = 0;
 	ret = vb2_core_queue_init(q);
 	if (ret) {
 		ctx->state = DVB_VB2_STATE_NONE;
diff --git a/drivers/media/dvb-frontends/rtl2832_sdr.c b/drivers/media/dvb-frontends/rtl2832_sdr.c
index 02c619e51641..023db6e793f8 100644
--- a/drivers/media/dvb-frontends/rtl2832_sdr.c
+++ b/drivers/media/dvb-frontends/rtl2832_sdr.c
@@ -439,12 +439,13 @@ static int rtl2832_sdr_queue_setup(struct vb2_queue *vq,
 {
 	struct rtl2832_sdr_dev *dev = vb2_get_drv_priv(vq);
 	struct platform_device *pdev = dev->pdev;
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 
 	dev_dbg(&pdev->dev, "nbuffers=%d\n", *nbuffers);
 
 	/* Need at least 8 buffers */
-	if (vq->num_buffers + *nbuffers < 8)
-		*nbuffers = 8 - vq->num_buffers;
+	if (q_num_bufs + *nbuffers < 8)
+		*nbuffers = 8 - q_num_bufs;
 	*nplanes = 1;
 	sizes[0] = PAGE_ALIGN(dev->buffersize);
 	dev_dbg(&pdev->dev, "nbuffers=%d sizes[0]=%d\n", *nbuffers, sizes[0]);
-- 
2.39.2

