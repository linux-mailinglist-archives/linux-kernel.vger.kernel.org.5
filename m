Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090BC7B5262
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbjJBMHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbjJBMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:06:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE31A6;
        Mon,  2 Oct 2023 05:06:31 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:9537:67ca:c85e:d0ae])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4057B66072FF;
        Mon,  2 Oct 2023 13:06:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696248389;
        bh=zXmFfNU0uMtsKoYh9PP3wEGhm6Xs7lwp8Ba27axk8pE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqGNR7ol6yzChR+uCnEriDgYWiToz7rivFjk14HeK9BIqiC+cdLwUCj7Ises9FtEC
         9PKSLkvbjY/NBpWASDmp8pOvYhL9KJJfiGHfaGuTgGMKzyoGtg0EK5eAOa7RPtj+qF
         MH9h/RUlhCxs5ByyAfqfa75A0RyOVZggduunivyE5o3avTqncPYO23pBT3rXgbbvYN
         o1L16weNcQqve97MNQmvtj+qmKksSWman6S6MY5khkvr2kf07g6uN1ZFcS+4jIpp7v
         B2s82hDL34IVX6R6ixx+0C41LZnJnmstCMT0x+QHXjYHqgh4QOmb8sYLyfWUKNwtJN
         bZHusnOdNXOKQ==
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
Subject: [PATCH v9 09/53] media: atomisp: Use vb2_get_buffer() instead of directly access to buffers array
Date:   Mon,  2 Oct 2023 14:05:33 +0200
Message-Id: <20231002120617.119602-10-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002120617.119602-1-benjamin.gaignard@collabora.com>
References: <20231002120617.119602-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_buffer() instead of directly access to vb2_buffer buffer array.
This could allow to change the type bufs[] field of vb2_buffer structure if
needed.
No need to check the result of vb2_get_buffer, vb2_ioctl_dqbuf() already
checked that it is valid.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index d2174156573a..4b65c69fa60d 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1061,7 +1061,7 @@ static int atomisp_dqbuf_wrapper(struct file *file, void *fh, struct v4l2_buffer
 	if (ret)
 		return ret;
 
-	vb = pipe->vb_queue.bufs[buf->index];
+	vb = vb2_get_buffer(&pipe->vb_queue, buf->index);
 	frame = vb_to_frame(vb);
 
 	buf->reserved = asd->frame_status[buf->index];
-- 
2.39.2

