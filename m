Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193B07990CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344484AbjIHUEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344522AbjIHUET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7971704
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694203402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UOJpuwbwTVfs+j95sEE93OpkqtbclA96WzipEC/nM14=;
        b=B5Xj9Ttc+s+aZQxg2A3jQbfa8yOwnks3IUTh3RJHo7yUvJyDP16+zr0pbXdQJGzZ2QKyOM
        /FMh94mhge3/pdvosTE+WUPmnH2gljxTFxIiU0hk8G/oBDLk4if3OGV5NxLQYXtMrY2H8m
        Jvw4Lgy9Ll3TePAjZwnXltt+hPxTNdw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-FsduL-wZOmyv3k3rPoEeaw-1; Fri, 08 Sep 2023 16:03:20 -0400
X-MC-Unique: FsduL-wZOmyv3k3rPoEeaw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4122119722eso4981691cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 13:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203399; x=1694808199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOJpuwbwTVfs+j95sEE93OpkqtbclA96WzipEC/nM14=;
        b=arOwL+XefdaFkxnwiHKBWtwmj8n6BBQtiz+CRawE1RMANw1cPEcqwUTziu2ezwmpcE
         bpOIJHU4ppahw/mlHwVhoTBrUiDINnr/eKlbRdt3ZZKxncWBXvejYqaj4r9cXmKKB0Vc
         hfDWvSbA+wKAxY8NGtrC04DHtmwO7NcBKsiwXOn6IphamA0Jfh4Zt6mQvH1XyJjxqGQn
         DoGRgwNTlnMqvvoPt1SCJMVarSfv8w1aJXx4plIi1LcLD3+7FWgEp9+3HtFLOmxgT8gD
         PMBYpThCId79fZBL4RbtTyKF2vqnbsuG/6+fcBtzSVytWtcIlFiK1GOzGofhPJW7z9X0
         rlSg==
X-Gm-Message-State: AOJu0YynWZXjRcK4ib8SzLvPlw/0or4uAzOzDQtLXx8AteLzk8KkGhCR
        MjSu6ifj6leMY+FsplhYEQyHKYxzyl10+ugiejhkHju1+wBLkUZSPrn6UG5XMiiioiTVVyyOXtn
        I08PLqXJw2zKN6Kshk5pp0LN8
X-Received: by 2002:ac8:7e94:0:b0:412:12e8:8538 with SMTP id w20-20020ac87e94000000b0041212e88538mr3683927qtj.1.1694203399530;
        Fri, 08 Sep 2023 13:03:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAKN1YnAkZtTcGtA674mV4f8NT9irZONaAKXTHG61Fqfz6xPH+/e15CARdB3FRUjLa10PQWg==
X-Received: by 2002:ac8:7e94:0:b0:412:12e8:8538 with SMTP id w20-20020ac87e94000000b0041212e88538mr3683913qtj.1.1694203399274;
        Fri, 08 Sep 2023 13:03:19 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id bb37-20020a05622a1b2500b004116b082feesm843284qtb.75.2023.09.08.13.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:03:19 -0700 (PDT)
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
Subject: [PATCH v2 4/5] drm_lease.c: copy user-array safely
Date:   Fri,  8 Sep 2023 21:59:43 +0200
Message-ID: <bca4966d616f417267ba02f66ff9891fceffd7f0.1694202430.git.pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694202430.git.pstanner@redhat.com>
References: <cover.1694202430.git.pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

