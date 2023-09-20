Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8C07A8090
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbjITMh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjITMhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A44283
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695213421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CkUiTYo02brbH9rdldgLT7YiM95DCTjC6m+zHLs+f1Y=;
        b=NQ6WtxB5bLM6In9RF2xe4/ErjZ2CauEawMTpsDtqT1BSO0DF/5VG6J8RjC2aR0Eye+R8Jc
        bmO4h1CcY1G1s2bbKD2DjqppAGDeydxUu3UcfhnNiTde5lEGaXNi6qjqrJJiPTl0pupaoy
        Dtek3ZX3492u1vAJtBpallfDvzaEViU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-Of_b6cLRNj-ZPLm5ZtSWDQ-1; Wed, 20 Sep 2023 08:37:00 -0400
X-MC-Unique: Of_b6cLRNj-ZPLm5ZtSWDQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2be48142a6cso15826121fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213418; x=1695818218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkUiTYo02brbH9rdldgLT7YiM95DCTjC6m+zHLs+f1Y=;
        b=jE8N/EVWEB1ptVdFEJHg+zGm6nI9v2skLtZal3R1DLgx+f4kHm4iPmeYOqfXGikkep
         S80PxRgXnm2CW5fry3YqsXh5W76pObbVBhbNQZSUz1nU8odAiQy82a9L/QRi/cC6FxmW
         8k5i/2CXtcOH4vZLgeQod+Lkacyuq4jFWkK6BXoJypYNXIvupQfBZP4CNhecZiu9hxbI
         bU+nLWgqPqykAxl+ZIHMh82yOCiL3glq8+5RRkK4xDL5siteohMtF3Ww254w54Sf7CLl
         ZVfXFO3iXahNSA2KV+WxKlYvqyk+MFHjYCE62Kr+2/lZByQtFO5ANoiTh5rIeIiynzRH
         CKUQ==
X-Gm-Message-State: AOJu0YypG120nkKftsyO63fV8euV+ui75D7HXt+6V2lli67M7gnYcwz+
        gzMtVROfOdoriW2AV9ZVBCwnYjCcmoScHsmblDrhOWx4fxYeCliI5opNl66Wewxg5LKfuWj56eQ
        wqpgHSqkiN6+z3AEwJUxgpPsH
X-Received: by 2002:a05:651c:1693:b0:2c0:196c:e38f with SMTP id bd19-20020a05651c169300b002c0196ce38fmr1921134ljb.1.1695213418530;
        Wed, 20 Sep 2023 05:36:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGtYN79a4/Uyeq8meM3+9mCAQ2LGvBXOKnKduArpSa1zP3qsVYH9Wh1PFHrd4S88GImDITZQ==
X-Received: by 2002:a05:651c:1693:b0:2c0:196c:e38f with SMTP id bd19-20020a05651c169300b002c0196ce38fmr1921120ljb.1.1695213418185;
        Wed, 20 Sep 2023 05:36:58 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id op15-20020a170906bcef00b009ae4ead6c01sm660073ejb.163.2023.09.20.05.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:36:55 -0700 (PDT)
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
Subject: [PATCH v3 3/5] kernel: watch_queue: copy user-array safely
Date:   Wed, 20 Sep 2023 14:36:11 +0200
Message-ID: <20230920123612.16914-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920123612.16914-2-pstanner@redhat.com>
References: <20230920123612.16914-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
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

