Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6367EE671
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345437AbjKPSIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345421AbjKPSIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:08:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCCF195
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700158083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abMypBf5ucI4kN1b2IUT7QxG30gkYzFxCp5z4V1rKYE=;
        b=DptkUAYX9+gBJwotIhbneBWTZmUUrwZCqOk0YwhjYrBPLBYir0f8BeUnJ2AvaEX0SAY+JB
        tzu+b8QlW7z0TYhFdWVH60jgcAo6ywsPAeHOqVnZ4LgVNUoZSjYplvlsemOnudUPH/ySNx
        3YMQv7eud3OwNbrBEeZnBeoKUYMkRxY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-gfzvP2BAPL-AeZgb0sH-VA-1; Thu, 16 Nov 2023 13:08:00 -0500
X-MC-Unique: gfzvP2BAPL-AeZgb0sH-VA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2c6ed315cc3so10312111fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700158077; x=1700762877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abMypBf5ucI4kN1b2IUT7QxG30gkYzFxCp5z4V1rKYE=;
        b=QJTfPq0+zw61imxxayzG+kFdu3pRKYwUyg1qvXJGWlLIuUCr8681x7OSzWyPG/iijQ
         mUDGfZAi99VdT0MZIE0bPQwJqpD3oF89lcmJAPvydVBcvj+hkPyk/T8/l4cl9L8vBCZl
         sLifro/FPB8TwuC3dNViTbo46EcKQa6n+zbzxtgE/5FiJcHLQZKe7BfSlanzHWdg4gnt
         w6zQbDHS8Zxbnx8oTXb2WQCzGHy+t0VoeI/o+46t4XrWsUioJHuKdshBa7CkJpXaLS8J
         dN20aAG/3jFOw9X9k2KT9ay8JvAgZHDTczSpVPLiFp3VM6SqTtkdyFG4dfvsZHEe9kLE
         1/Dw==
X-Gm-Message-State: AOJu0Ywvo8mDgLlIArsYumqn/mmlLknOXUc1ZOXgqEZlhoq2acqBAiaT
        DK8sM20bMomGN9O13QfHzq6LpaGcafum2G1tcHOf8Kudh2Vfg0qvKhhwKQQiDkWV6Co4nzAXlW+
        O2hScNgh2NGlAjVmA2lWlYdmVsUmXcjh3qzjJlq3nq82QUFxiayiGG+qpG64X87GF46sPHP8wtS
        OMSrOM8C4=
X-Received: by 2002:a2e:9b13:0:b0:2c5:2813:5534 with SMTP id u19-20020a2e9b13000000b002c528135534mr7628264lji.51.1700158077746;
        Thu, 16 Nov 2023 10:07:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKGl1y5xpKNFNEdGTKKeWQHa+nKfgkMEp5Q7PtqN7fzQrCOV0Z8V6aBoDs2btVWPzkwvYFHA==
X-Received: by 2002:a2e:9b13:0:b0:2c5:2813:5534 with SMTP id u19-20020a2e9b13000000b002c528135534mr7628244lji.51.1700158077374;
        Thu, 16 Nov 2023 10:07:57 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q9-20020a05600c330900b0040a3f9862e3sm3216257wmp.1.2023.11.16.10.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:07:56 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sahaj Sarup <sahaj.sarup@linaro.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] drm/ssd130x: Change "solomon,page-offset" property default value
Date:   Thu, 16 Nov 2023 19:07:39 +0100
Message-ID: <20231116180743.2763021-3-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116180743.2763021-1-javierm@redhat.com>
References: <20231116180743.2763021-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to specify the page start address offset of the display RAM.

The value is used as offset when setting the page start address with the
SSD130X_SET_PAGE_RANGE command, and the driver currently sets its value to
1 if the property is not present in the Device Tree.

But the datasheet mentions that the value on reset for the page start is a
0, so it makes more sense to also have 0 as the default value for the page
offset if the property is not present.

In fact, using a default value of 1 leads to the display not working when
the emulated fbdev is attached to the framebuffer console.

Reported-by: Sahaj Sarup <sahaj.sarup@linaro.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index bef293922b98..8944129a8e0b 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1453,7 +1453,7 @@ static void ssd130x_parse_properties(struct ssd130x_device *ssd130x)
 		ssd130x->height = ssd130x->device_info->default_height;
 
 	if (device_property_read_u32(dev, "solomon,page-offset", &ssd130x->page_offset))
-		ssd130x->page_offset = 1;
+		ssd130x->page_offset = 0;
 
 	if (device_property_read_u32(dev, "solomon,col-offset", &ssd130x->col_offset))
 		ssd130x->col_offset = 0;
-- 
2.41.0

