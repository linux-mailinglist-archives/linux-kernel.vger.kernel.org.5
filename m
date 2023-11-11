Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CC87E8D2B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 23:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjKKWno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 17:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKWnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 17:43:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5169D8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 14:43:39 -0800 (PST)
Received: from workpc.. (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 62B1966073B7;
        Sat, 11 Nov 2023 22:43:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699742618;
        bh=U10+EkHqkOD4kaEoYu2gK2478uYYFAVFdFMCVmakhG8=;
        h=From:To:Cc:Subject:Date:From;
        b=kC3L8gWiZ0wdnhznrSREusgQLxJc+IkSf97mNgdSNHO+XbRywCHmeXoAh4KxLVcwJ
         hYuALejDVbvWoSmsNsdrt/jpDv+/yse1MSvAQ/NnlUu1nbzHeuBCjUdcKsSHzGFlJ8
         4nK6XeRj8OzJ7u8oFrJAVQLGMrUIchXWXjPHDbI8oj7yMmVGi5yee/73HUQAN3X42T
         7bPdGGUlStlcReb/KljFTjrYVDLjn5ysuhloyoVpGOnNRKGEXrbHXcAWZtG91i9FDb
         fNnPoQRD06ZrOAy14Sk5RIRfhK0SPG8stElNplvjx3yh2u24IEzSV/cdgxf4u0IUPf
         WOj7vKN+ERmUw==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v1] drm/virtio: Fix return value for VIRTGPU_CONTEXT_PARAM_DEBUG_NAME
Date:   Sun, 12 Nov 2023 01:42:36 +0300
Message-ID: <20231111224236.890431-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strncpy_from_user() returns number of copied bytes and not zero on
success. The non-zero return value of ioctl is treated as error. Return
zero on success instead of the number of copied bytes.

Fixes: 7add80126bce ("drm/uapi: add explicit virtgpu context debug name")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 1e2042419f95..e4f76f315550 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -665,6 +665,7 @@ static int virtio_gpu_context_init_ioctl(struct drm_device *dev,
 				goto out_unlock;
 
 			vfpriv->explicit_debug_name = true;
+			ret = 0;
 			break;
 		default:
 			ret = -EINVAL;
-- 
2.41.0

