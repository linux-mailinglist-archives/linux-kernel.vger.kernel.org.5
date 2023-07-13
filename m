Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFB4751C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjGMJAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjGMJAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9071FDB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689238766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vnxC9yGQS3oyHtrj9CFhBKbzf8XATjvmszGm7K4qRhU=;
        b=J1+a/rwMuijE91Vn5WWEKx20adjFromES5t0W5WYM5x+2GwZ9NSTh3DXaaljY1cqQz5GSD
        BJVUYvbetE22rT5Ww1yxPm4BmVRvVaZvm/AA2tqq/gP/ebcGirDzCx8aF20F4gPfrWtEKp
        8aGae1ykkct5uBw2pl+n099q56rFmd0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-XjQDjZ86M6CjAkN_w4kGqg-1; Thu, 13 Jul 2023 04:59:25 -0400
X-MC-Unique: XjQDjZ86M6CjAkN_w4kGqg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b701e0bb10so4256391fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689238764; x=1691830764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnxC9yGQS3oyHtrj9CFhBKbzf8XATjvmszGm7K4qRhU=;
        b=Rqx8lqzgBmP3V9KdcpSzQAUxqhECE3JFN6KPD79EuS+IfQYESibb1K4rodOB/twwMb
         2AXbJmMyS1d5XdHqZOjQMZMw3aT06p85Y2AhZ+uK2fpqyyGrry3rp7Ykdp95pDnMSlJ3
         AYDu1PTGrrQ90ak+WjH+wtojoke+i1AVvfWup8593RbioDYFbHo64is0LN7aheAwZJUs
         N69MxInZ+FPjZO9WC79Uz7neGO9RAdmRzFhWE9j+7xL4CHIFev4Ap8M+3JySSruRwoAu
         7NAi/Jq94lcj7BU1u0bOt5m8C6TmkjT7Dp2uEgJ2BbLKQudJniYgI9FweAdQFtsHoJUT
         ITmw==
X-Gm-Message-State: ABy/qLZkr9lBmGhESLXfNurB+kODVpmtCJPHDRfwDaOksMUwKVO7N4Zy
        1QJsdyhLslRknvx5kQk8rVwioHfMGgmw6KXx9tAJX4icgDvr0Gq2hg6U0/it7CwCEyEx5IGJH68
        uWcax6zyGvc9aGx7ZdPmtkXYshmW3O+U1Fqx0jzmkDrH0Mh6oYtvnvu7qgsJyrKV8I3EOBzF94U
        K7IThrJ10=
X-Received: by 2002:ac2:4d0a:0:b0:4fb:61ea:95dc with SMTP id r10-20020ac24d0a000000b004fb61ea95dcmr668303lfi.7.1689238763918;
        Thu, 13 Jul 2023 01:59:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGc5HFE7WCmY1lT5YS/h/GV1g02JYORqPk5tgrQ7etZG94Yv7rrcroiXJTHdwIkOtIEUGSKDA==
X-Received: by 2002:ac2:4d0a:0:b0:4fb:61ea:95dc with SMTP id r10-20020ac24d0a000000b004fb61ea95dcmr668279lfi.7.1689238763561;
        Thu, 13 Jul 2023 01:59:23 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a4-20020adfeec4000000b0030c4d8930b1sm7356588wrp.91.2023.07.13.01.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 01:59:23 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ssd130x: Change pixel format used to compute the buffer size
Date:   Thu, 13 Jul 2023 10:58:07 +0200
Message-ID: <20230713085859.907127-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e254b584dbc0 ("drm/ssd130x: Remove hardcoded bits-per-pixel in
ssd130x_buf_alloc()") used a pixel format info instead of a hardcoded bpp
to calculate the size of the buffer allocated to store the native pixels.

But that wrongly used the DRM_FORMAT_C1 fourcc pixel format, which is for
color-indexed frame buffer formats. While the ssd103x controllers don't
support different single-channel colors nor a Color Lookup Table (CLUT).

Both formats use eight pixels/byte, so in practice there is no functional
changes in this patch. But still the correct pixel format should be used.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index b3dc1ca9dc10..afb08a8aa9fc 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -153,7 +153,7 @@ static int ssd130x_buf_alloc(struct ssd130x_device *ssd130x)
 	const struct drm_format_info *fi;
 	unsigned int pitch;
 
-	fi = drm_format_info(DRM_FORMAT_C1);
+	fi = drm_format_info(DRM_FORMAT_R1);
 	if (!fi)
 		return -EINVAL;
 
-- 
2.41.0

