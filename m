Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42927E6F16
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344415AbjKIQiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344206AbjKIQh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:37:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E15D384A;
        Thu,  9 Nov 2023 08:37:49 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 50BBC66076AC;
        Thu,  9 Nov 2023 16:37:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547868;
        bh=4RzVJeiaNWJl64ltMbZK/gliYakvNCXiKbj4cdjzk0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HsNH8W0xojhkRfYJMLXzC9+4KkuxDowhuPqSp4aVXN3GOoT6CzhbmBrOLqPSKdB7o
         VJCR4VM/JE4vRoXosfEccUoABdby1qMZ7f6GYjxn8metWxrCL64ThKrftmmlFyISnw
         AdfsRyV0cjqFKG3vxSMMiU4HuTGkMIiNQpyy0gske6xUjcTn5u8EwDNsEQxmE/55/p
         65OenSfIfskA1/iZTHsvd+Z/kHicnw3CD4AnWlrYRz24KF7PwIA4yacDXfDIWp1h2W
         Z95N/n84zNwS8WbQLq/sNiGO2XRNTgkoix3EfK1prpRk2rWA/h58g4fA0/k09Zi7Dl
         4u1cRQo1OUgUw==
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
Subject: [PATCH v15 19/56] media: dvb-core: Do not initialize twice queue num_buffer field
Date:   Thu,  9 Nov 2023 17:34:35 +0100
Message-Id: <20231109163512.179524-20-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
References: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The above memset already zeroed all the ctx fields, it is useless
to do it here again.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/dvb-core/dvb_vb2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_vb2.c b/drivers/media/dvb-core/dvb_vb2.c
index 3a966fdf814c..167ff82a6fed 100644
--- a/drivers/media/dvb-core/dvb_vb2.c
+++ b/drivers/media/dvb-core/dvb_vb2.c
@@ -167,8 +167,6 @@ int dvb_vb2_init(struct dvb_vb2_ctx *ctx, const char *name, int nonblocking)
 
 	memset(ctx, 0, sizeof(struct dvb_vb2_ctx));
 	q->type = DVB_BUF_TYPE_CAPTURE;
-	/**capture type*/
-	q->is_output = 0;
 	/**only mmap is supported currently*/
 	q->io_modes = VB2_MMAP;
 	q->drv_priv = ctx;
@@ -177,7 +175,6 @@ int dvb_vb2_init(struct dvb_vb2_ctx *ctx, const char *name, int nonblocking)
 	q->ops = &dvb_vb2_qops;
 	q->mem_ops = &vb2_vmalloc_memops;
 	q->buf_ops = &dvb_vb2_buf_ops;
-	q->num_buffers = 0;
 	ret = vb2_core_queue_init(q);
 	if (ret) {
 		ctx->state = DVB_VB2_STATE_NONE;
-- 
2.39.2

