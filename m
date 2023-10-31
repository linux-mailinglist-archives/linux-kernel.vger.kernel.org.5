Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377BD7DD23B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345904AbjJaQgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346498AbjJaQfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:35:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DF31FF5;
        Tue, 31 Oct 2023 09:32:36 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:c562:2ef4:80c0:92f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D589E66073CB;
        Tue, 31 Oct 2023 16:32:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698769954;
        bh=KPoxd/SvOk21SjAKuo9XuAAvSFR2sEuxtH4tG5ksUhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DpcRlo+g4zRXEYOU+WftkbigSJXhl2DKpriogjse66Na81yCRc8ckOsxrJsuNqmsh
         ahmm4pnVx/ek+QMvXnX1zspZIlmexmrb+gTR78PgWsbEluJXieHA6XErfctUrMqwW2
         hpx61fI7ObqfD48kfQFNCRIlS9/+QNjhvoTDFZnhRdiDkPZm3KWelD6Qr11ridmGFm
         BdmN7aXIizxfjWSCHN5KIsLOj57mBNjCqNc3tDIVd3mhY+TWwDRQyF0MUhDgVAmwJj
         9cVhAk0tOXEpNb9jkPK9bv4rj9+ykcyEzACOUF1GQfTIXtGsDbFZ+L2U7BoYSygClV
         dLh3PLiXKnBjg==
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
Subject: [PATCH v14 42/56] media: usb: usbtv: Stop direct calls to queue num_buffers field
Date:   Tue, 31 Oct 2023 17:30:50 +0100
Message-Id: <20231031163104.112469-43-benjamin.gaignard@collabora.com>
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

Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.
This allows us to change how the number of buffers is computed in the
future.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/usb/usbtv/usbtv-video.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
index 1e30e05953dc..62a583040cd4 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -726,9 +726,10 @@ static int usbtv_queue_setup(struct vb2_queue *vq,
 {
 	struct usbtv *usbtv = vb2_get_drv_priv(vq);
 	unsigned size = USBTV_CHUNK * usbtv->n_chunks * 2 * sizeof(u32);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 
-	if (vq->num_buffers + *nbuffers < 2)
-		*nbuffers = 2 - vq->num_buffers;
+	if (q_num_bufs + *nbuffers < 2)
+		*nbuffers = 2 - q_num_bufs;
 	if (*nplanes)
 		return sizes[0] < size ? -EINVAL : 0;
 	*nplanes = 1;
-- 
2.39.2

