Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1EE8037B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjLDN0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344445AbjLDNZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:25:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD0B181;
        Mon,  4 Dec 2023 05:24:28 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D230660715D;
        Mon,  4 Dec 2023 13:24:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701696266;
        bh=PJOb0upzYk5sy+kA9Qk465u2DFL4NHA2Gb2jqg1/r/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BrCeCc7qRmtQhFxZpNy//e47tTrDrrONVVN0Upa4UssbezXdbTueftYV+u6/mOS7/
         QwC847PPjD5sdBVNYaUTgtY3eSpItOHCf7FVIm3sd8Euz1IuixXqe4AAnfasXqPrYq
         ilf6D7iJmAoX2prua+vwEaYERnBbhfzIUPCtZXuRbub71zAg6i/bAzBt40ya2Tbtyp
         R5stB9RXoXUA7/Tp5j3456lPQ/DR2z80upofbFpiCJzUNim6aUg4CFV/EfnKW+JOB5
         hJnbCe31m9Mf1ntpRiEJmMUyvT5AxqmatoFddH0ylBT+HhpVmTNAwIsYQE3c4VTEMo
         GThhDniGrBlPQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 32/36] media: tegra-video: Fix misuse of min_buffers_needed field
Date:   Mon,  4 Dec 2023 14:23:19 +0100
Message-Id: <20231204132323.22811-33-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204132323.22811-1-benjamin.gaignard@collabora.com>
References: <20231204132323.22811-1-benjamin.gaignard@collabora.com>
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

'min_buffers_needed' is suppose to be used to indicate the number
of buffers needed by DMA engine to start streaming.
tegra-video driver doesn't use DMA engine and just want to specify
the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
That 'min_reqbufs_allocation' field purpose so use it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Thierry Reding <thierry.reding@gmail.com>
CC: Jonathan Hunter <jonathanh@nvidia.com>
CC: Sowjanya Komatineni <skomatineni@nvidia.com>
CC: Luca Ceresoli <luca.ceresoli@bootlin.com>
CC: linux-tegra@vger.kernel.org
---
 drivers/staging/media/tegra-video/vi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index e0bb59ee3c09..b8242c8c0497 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1174,7 +1174,7 @@ static int tegra_channel_init(struct tegra_vi_channel *chan)
 	chan->queue.ops = &tegra_channel_queue_qops;
 	chan->queue.mem_ops = &vb2_dma_contig_memops;
 	chan->queue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	chan->queue.min_buffers_needed = 2;
+	chan->queue.min_reqbufs_allocation = 2;
 	chan->queue.dev = vi->dev;
 	ret = vb2_queue_init(&chan->queue);
 	if (ret < 0) {
-- 
2.39.2

