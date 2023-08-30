Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269DE78DE3D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbjH3TAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244715AbjH3Nr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBF51BB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693403199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UOJpuwbwTVfs+j95sEE93OpkqtbclA96WzipEC/nM14=;
        b=Ajc4RXTRaqs5I0UDdsHHKD6sy/q7kOld/OnuN2CnAkzTkUoH/k7h2hGcasWHD0mplFqWls
        yhRX5UGKO4hQsWFhBhopYsCTPtdn8DJ6eOPhPB69sviPXt0xt7zUFBgQT0ybMxd81HDTCs
        GVODes/oVN/NS4SfvSQg4sY2JO+pxMM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-8YP4AMB-P8ucjMNdzh10jw-1; Wed, 30 Aug 2023 09:46:38 -0400
X-MC-Unique: 8YP4AMB-P8ucjMNdzh10jw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b6fdb8d0acso19452151fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403196; x=1694007996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOJpuwbwTVfs+j95sEE93OpkqtbclA96WzipEC/nM14=;
        b=dHitNMAbMAew/ADm2z0fpaeSsRJBdjtqNE5+FIIRPXwjU/FS7vxGNitX6BfUzpTPEY
         +2Xcg7rpNTu92MWCS+MDn280ThZoRb5Sg9ClVqXIr1IaqtkfZl/w/PGVYIk+njaeM50d
         Y5fe7zT7/VrZbeQJWGr0TXs85Vzozd4jhloLQ4aQhSMhzeUR+DOUuhxBzRRClt3fHp9M
         wCsfzJEME+q8kWu+LMMIuC7+oP+CH3hPqaqnQWQj5ubBQK3RaeL4KaIzSEAW9gNhL2dC
         Mo5wIuWfz4Q0G2Dnx3e0Mx33tp29rhrb2weJw+9ZHpxWOujlIdBwayIB0YBgbQ6cPh+0
         l99g==
X-Gm-Message-State: AOJu0YyJFEqFGDM5kdt90gsxcGnadmxQS5O4hJDCRYV7FU5WNQHK7Eaw
        UUw6kdPrNg25QnBnFwwbIOJi/ar6j9m9mwC3oa3mlbhzkldP/pTQ/O80TCiMb2vMYSDk1eDABTv
        PAwuSFBh8z2BJfk3GLoD2MhUA
X-Received: by 2002:a05:651c:1182:b0:2bc:fc2e:766c with SMTP id w2-20020a05651c118200b002bcfc2e766cmr1857340ljo.3.1693403196828;
        Wed, 30 Aug 2023 06:46:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNBSsy/iFndvURQgQS9ZCnlQ9lW+9HBjOb1QIZNMn1l3Gt7cB24Ma8x0ITyx+CEVBlGHtj+A==
X-Received: by 2002:a05:651c:1182:b0:2bc:fc2e:766c with SMTP id w2-20020a05651c118200b002bcfc2e766cmr1857319ljo.3.1693403196642;
        Wed, 30 Aug 2023 06:46:36 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id li22-20020a170906f99600b009a198078c53sm7167678ejb.214.2023.08.30.06.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:36 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>
Cc:     VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>
Subject: [PATCH 4/5] drm_lease.c: copy user-array safely
Date:   Wed, 30 Aug 2023 15:45:55 +0200
Message-ID: <34e14523c9cea13e2f63afabf2938c89d2e84776.1693386602.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693386602.git.pstanner@redhat.com>
References: <cover.1693386602.git.pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is no overflow-check with memdup_user().

Use the new function memdup_array_user() instead of memdup_user() for
duplicating the user-space array safely.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/drm_lease.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index 150fe1555068..94375c6a5425 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -510,8 +510,8 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	/* Handle leased objects, if any */
 	idr_init(&leases);
 	if (object_count != 0) {
-		object_ids = memdup_user(u64_to_user_ptr(cl->object_ids),
-					 array_size(object_count, sizeof(__u32)));
+		object_ids = memdup_array_user(u64_to_user_ptr(cl->object_ids),
+					       object_count, sizeof(__u32));
 		if (IS_ERR(object_ids)) {
 			ret = PTR_ERR(object_ids);
 			idr_destroy(&leases);
-- 
2.41.0

