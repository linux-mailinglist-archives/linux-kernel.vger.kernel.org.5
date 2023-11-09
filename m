Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD17E6F0A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344293AbjKIQhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjKIQhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:37:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB6B3843;
        Thu,  9 Nov 2023 08:37:44 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F25B8660741B;
        Thu,  9 Nov 2023 16:37:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547863;
        bh=NE9Dr0xaEnB6dw9lflcnBD1PZMhluEk9SDENx9Slyak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZVXuIiw4SFUXVgXuIO063mfiC0LD7+zHWWLu8i1PG7XTKs3Y4D0rmVUKLu+1WzYc
         t9BVrPUIBS6hfqZPJ1+qFi7PE0JqZ4JSg8JmLA7leGTgF5zd57dtfmD2A5Cr/0CO8d
         uExpmgAXjikLHNXbbKM0PlyKBwDjYIj7HPJMyG+jMDVPokI30QfcjqeNGhUmfT9cTW
         6f2tPxNGh0NHrMjdjo/pPPGd0CLRzG4Mi4/s9bWs8bbAAry6A9cz64vFa46jBSxWtb
         GYlA54wq4Cvwmoy1VjsUbOYpWPgOTnLUe6WjAQhkt2oKo6x1QaOWDnClgnsG2e4nDY
         rhEQ9i23ZmH2A==
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
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v15 16/56] media: atomisp: Use vb2_get_buffer() instead of directly access to buffers array
Date:   Thu,  9 Nov 2023 17:34:32 +0100
Message-Id: <20231109163512.179524-17-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
References: <20231109163512.179524-14-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_buffer() instead of direct access to the vb2_queue bufs array.
This allows us to change the type of the bufs in the future.
No need to check the result of vb2_get_buffer, vb2_ioctl_dqbuf() already
checked that it is valid.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index a8e4779d007f..a8a964b2f1a8 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1059,7 +1059,7 @@ static int atomisp_dqbuf_wrapper(struct file *file, void *fh, struct v4l2_buffer
 	if (ret)
 		return ret;
 
-	vb = pipe->vb_queue.bufs[buf->index];
+	vb = vb2_get_buffer(&pipe->vb_queue, buf->index);
 	frame = vb_to_frame(vb);
 
 	buf->reserved = asd->frame_status[buf->index];
-- 
2.39.2

