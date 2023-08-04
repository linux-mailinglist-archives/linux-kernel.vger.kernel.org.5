Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1140476FF24
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjHDLAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHDK7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:59:35 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCB6273A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:58:13 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 98367188E;
        Fri,  4 Aug 2023 12:56:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691146611;
        bh=W3BdCub5uZqFZ3mcZrRZT/MkOLhq4JHeGg/aXz3nw1I=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=kvA6fMuoRo1j5nIIY4k+dISbOKqRumEyxFPcz+9nvbehNM1KM9SImM79Ig82Hq3AX
         5sAKvt/hhBS122FqZB0HFLI47vguOEqY/Tek6K4QzAefzo7dB8tnFeIfdnnPQFKeO+
         UJuMHEubt+uRaeUixNSMOsFBmvDuokOJu51zPVC8=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Fri, 04 Aug 2023 13:57:40 +0300
Subject: [PATCH 2/2] drm/framebuffer: Fix use of uninitialized variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230804-uninit-fixes-v1-2-a60772c04db5@ideasonboard.com>
References: <20230804-uninit-fixes-v1-0-a60772c04db5@ideasonboard.com>
In-Reply-To: <20230804-uninit-fixes-v1-0-a60772c04db5@ideasonboard.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=957;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=W3BdCub5uZqFZ3mcZrRZT/MkOLhq4JHeGg/aXz3nw1I=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkzNmxZWV22iZzrPJkJW6W5BD4iTDw0P5YJjzUk
 BzzN5se7uKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMzZsQAKCRD6PaqMvJYe
 9acCD/9Jqv5JDU5Yg3BWu883KU+wA96GtjuEePd9EJOMd/im3JTG77qMTGlkUQ07EIQ7l5/QzRw
 CQcyhXk3LYB5ocA3wWtTX0O5hvsT/k0/zVtur/wANTbncq7Ae+OoFBxYbdWwTbCkpYNW8lwlOc6
 fv/9fgZ83E/NLAbdFTqyb1ER/x8si7NUKh7cHcm8Zjq2xPW01wKmsBLfl51XoYMOi+KaSvPajfg
 74v1/shwTaOg/WapJlgBWgTISdJ9LnK2fFT/pNp16Y8KMBj1a40Tw+381Ne5zu21+IjNrOcfTF1
 6LaNTK7kb5Bxugj8S2En42mUkACDUU6Gj0GrWEVqYD/ri6Q2GppTM48vjfKLhkKECkUJhKiHEby
 o8LbFZNMJG3auZHreOYO4pr/0xxwOXJ3GzvKRaykPD31h46dw7BLvHqU+J0If3LHYP51Hp1i228
 J8knCsXJJu8XV+JBy9pzgpu9Dwj/67cbQY86+C/JZ4syDmqb1klTgbq+hDjR7kMfnytX9d0yl+S
 J472vWkDKGUksF06JVFHAq4QOnAlmv5JtuCqUZY0BVwkMoVXXPzlyVA/LlTeozb4lwih6EunGcb
 LVvmb/O/t2T6n7OqmQ/IcuUtxODVYWuatZeszSYFt/Td7DDXin5BFDfXKNF/EHzWhB0zkqWAEuE
 RvIi4bOlH9kqyUg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports:

drivers/gpu/drm/drm_framebuffer.c:654 drm_mode_getfb2_ioctl() error: uninitialized symbol 'ret'.

'ret' is possibly not set when there are no errors, causing the error
above. I can't say if that ever happens in real-life, but in any case I
think it is good to initialize 'ret' to 0.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/drm_framebuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index aff3746dedfb..1955eaeba0ab 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -570,7 +570,7 @@ int drm_mode_getfb2_ioctl(struct drm_device *dev,
 	struct drm_mode_fb_cmd2 *r = data;
 	struct drm_framebuffer *fb;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (!drm_core_check_feature(dev, DRIVER_MODESET))
 		return -EINVAL;

-- 
2.34.1

