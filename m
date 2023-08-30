Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5D378DF20
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbjH3TNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244713AbjH3Nr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EEA1B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693403195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2kuY7QrN77OjYcmiIgmsp8RgTy5tijHIGRui0VqTUY=;
        b=NYFA6JvG/pF4qaCZw2OTy4jhgTU9jzpMZUoZlzJX+TtdOmUPh71IdiReF0OtSbJXyXui0r
        PTZTtsjaCAvH04EV8duE6cAAZjAKOL2GeGjV+ilYoa1DhmOBXt5bJFYZ29XVMCMtagTW9p
        f1dQ6TyhHxTgmyZg0eX2vDfKTPG+98U=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-d8SAkmSNPH2hXd6roJqpuw-1; Wed, 30 Aug 2023 09:46:34 -0400
X-MC-Unique: d8SAkmSNPH2hXd6roJqpuw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a1c758ef63so61292766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693403193; x=1694007993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2kuY7QrN77OjYcmiIgmsp8RgTy5tijHIGRui0VqTUY=;
        b=gkUt+u7FvYAsbOnfc/Ww6ey4w2ozpAn4P6nsCvzDE2Itm+LxBOcM36xtiT7XCUJjTN
         obSgWVhGud/3H5kGyskcfOIvi1MPKFFlme6FGsdMXZpU5eHIaqrMoqQXpM/tVam1Z16d
         Bc1jWtf8j/DIFDnt3Nzrc8j+PSK81d/C0gU5KN1gU4x0C9QlztlzJjTOfY1lTcdl4puv
         Ocz0rc5UGsQcjIsee1HqH9UnWVcMkhiLERmk6LAgmFDXgZZSmiHyOI/Vme0MSvU3oIXJ
         39pQFH5bIuSEotoawHn/XW31zKMcnrsX1Wh+AFuna0W+kbZrWO8KL1eEuZ7CGCb8kR+g
         fFsw==
X-Gm-Message-State: AOJu0YwBVCXjpzVt6OEpnfEhNnBnSN9thymIAuoEtWMElawGu2utMLIz
        Wqg42HdR0it3z78+dtuokgrV2XxK/ZzkKFdoqwkYIPMJjhAZctDY7Me/jbmO554oumarXPJfr4W
        60fuo0EeciDJH4qieFQiqSZdh
X-Received: by 2002:a05:6402:51c8:b0:522:3f32:52f1 with SMTP id r8-20020a05640251c800b005223f3252f1mr1737281edd.3.1693403193055;
        Wed, 30 Aug 2023 06:46:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf9jsdBfXtDK6B3l1XAhb6uC/SE7H2eq+xyXHHwbpGSepkZ7/eGDvrY6bR1kwu2ebD+wsHwg==
X-Received: by 2002:a05:6402:51c8:b0:522:3f32:52f1 with SMTP id r8-20020a05640251c800b005223f3252f1mr1737265edd.3.1693403192770;
        Wed, 30 Aug 2023 06:46:32 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id t7-20020aa7d4c7000000b00529fa63ef6fsm6811782edr.57.2023.08.30.06.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:46:32 -0700 (PDT)
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
Subject: [PATCH 3/5] kernel: watch_queue: copy user-array safely
Date:   Wed, 30 Aug 2023 15:45:54 +0200
Message-ID: <4168bc2d9313d5d1a1a2b9ca0b9fc2990d499506.1693386602.git.pstanner@redhat.com>
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
 kernel/watch_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index d0b6b390ee42..778b4056700f 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -331,7 +331,7 @@ long watch_queue_set_filter(struct pipe_inode_info *pipe,
 	    filter.__reserved != 0)
 		return -EINVAL;
 
-	tf = memdup_user(_filter->filters, filter.nr_filters * sizeof(*tf));
+	tf = memdup_array_user(_filter->filters, filter.nr_filters, sizeof(*tf));
 	if (IS_ERR(tf))
 		return PTR_ERR(tf);
 
-- 
2.41.0

