Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1157E6F72
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbjKIQkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344200AbjKIQjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:39:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F223ABE;
        Thu,  9 Nov 2023 08:38:36 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 51A8B66076D3;
        Thu,  9 Nov 2023 16:38:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547915;
        bh=wmqT6khpuFCBRkOFjuZTLj7c7dshuytjAXj8w7ajsMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcfiJN7oEFvfZUk6VhhHBEnhn0B/Gp+HbiNtzdoBrkQcujeYg0RtKIy7qM4tc6Sad
         spJ9i1GSoJRNkEjSostqbn1V6T8Ly/Trc/9Fm8j5v/hTj7ML+jcGyzA8CeiRHtBqeS
         VsRIUYmJyxwOM+5Ib2I6ZKfRWaTotrSjCJwp1XMMkXW7uB/mwurHe+dbSSHFpSJdx4
         gsrAEXi+coJVTC8R4nrpfrIJC/XhS7xeiFzFgjhhj8ZsX5O61vsp/IbFCsU7v1p00o
         lskjGLgxCMz2liLqNQWDtRqpQCl893adF1S8y8OMmERhpOeMuPTxfgHvh4sIroy14v
         x2CrqTDGYEGWQ==
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
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: [PATCH v15 46/56] media: test-drivers: vicodec: Increase max supported capture queue buffers
Date:   Thu,  9 Nov 2023 17:35:02 +0100
Message-Id: <20231109163512.179524-47-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
References: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to allocated up to 64 buffers on capture queue.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 drivers/media/test-drivers/vicodec/vicodec-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
index 6f0e20df74e9..69cbe2c094e1 100644
--- a/drivers/media/test-drivers/vicodec/vicodec-core.c
+++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
@@ -1718,6 +1718,7 @@ static int queue_init(void *priv, struct vb2_queue *src_vq,
 			V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE :
 			V4L2_BUF_TYPE_VIDEO_CAPTURE);
 	dst_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
+	dst_vq->max_num_buffers = 64;
 	dst_vq->drv_priv = ctx;
 	dst_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
 	dst_vq->ops = &vicodec_qops;
-- 
2.39.2

