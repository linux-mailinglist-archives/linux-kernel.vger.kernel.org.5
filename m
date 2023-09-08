Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194227990CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbjIHUEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344480AbjIHUEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F150170F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694203385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJlM81Ad0uqQunhdFKofh1JwhP2kaFm8hxSxz8OfTMk=;
        b=ePZJUstpqLUGNvY10VuB9AYfCD4dvj3m10nybqw9kdfteIuEWQp7ZfSbtnImd5Q6jibuww
        vwdegGnb5VzcUFbCV+UTQtJuVikxOvp+1P9Kxf6WcC2JmUIXQKGn3ZL/q3NrM3BcrRCibj
        /LmX2ESKlCFyCQyMKuiwhK+tK16ZXnM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-N7lXP_I2PAGVZeGgOExc8w-1; Fri, 08 Sep 2023 16:03:02 -0400
X-MC-Unique: N7lXP_I2PAGVZeGgOExc8w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-64a4269ca98so6043486d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 13:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694203382; x=1694808182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJlM81Ad0uqQunhdFKofh1JwhP2kaFm8hxSxz8OfTMk=;
        b=MczSR9pi2q5pqIkuq/22nTF5u75JZfOjfAKHUhT+iMGZcAP1wCbHTkzvjiL/Y8wfkP
         6/mjtZDtmgGKMlkO1yDY0dV1gJfNHzrCS2P6CrflqWizdOXzlHbJGr+yKVtiAc6+1Nkj
         51dJY4Fw8ttvalsRWyhCDgUbXv4lujE+IGUrNizO6utqV9gqQTLVN6C7gY+J2qIBncp6
         9dkyWA5us751gHkwl/f5NcyJZ0kPX0cLD9tlwimCBLBWchQqAyYUBNKnQmODxIBeOJfD
         XpRS5aPE3JcGDQz8BSAy4Hau5ILpcqH2XvF7rIVk08aE/0SQP2OFn/eHI2leQvMdvDeN
         pVRA==
X-Gm-Message-State: AOJu0YxLggkJN1nwvGyu/Sfy1HnuRUXRr6FPZaIbo4tohgKEPHLixmi8
        WRQwavCl7xxUEM6GD4kkt7YWDaLSzDLo4Tu4ioX5xmfvbAoc+tTMqmBdwXTz6uKc77vaCGXKkmG
        cNG501NBxqii5AuHpHD8SSzWL
X-Received: by 2002:a05:6214:234b:b0:649:5f43:245c with SMTP id hu11-20020a056214234b00b006495f43245cmr3403718qvb.4.1694203382304;
        Fri, 08 Sep 2023 13:03:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkpjEpC3M4jl16uIjnS3PMQJTudw+DmAKJXO1LGuAkwNI/2h/IQUepIX3UGSH4cUrAf1SALA==
X-Received: by 2002:a05:6214:234b:b0:649:5f43:245c with SMTP id hu11-20020a056214234b00b006495f43245cmr3403702qvb.4.1694203382095;
        Fri, 08 Sep 2023 13:03:02 -0700 (PDT)
Received: from fedorinator.redhat.com ([2001:9e8:32da:e500:513e:fbe9:e455:ae67])
        by smtp.gmail.com with ESMTPSA id r19-20020a0ccc13000000b0064f523836fdsm959242qvk.123.2023.09.08.13.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 13:03:01 -0700 (PDT)
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
Subject: [PATCH v2 2/5] kernel: kexec: copy user-array safely
Date:   Fri,  8 Sep 2023 21:59:41 +0200
Message-ID: <31313a8a1dd1baf9dd3c21fbe8dd46b9e111f20c.1694202430.git.pstanner@redhat.com>
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
 kernel/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 107f355eac10..8f35a5a42af8 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -247,7 +247,7 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 		((flags & KEXEC_ARCH_MASK) != KEXEC_ARCH_DEFAULT))
 		return -EINVAL;
 
-	ksegments = memdup_user(segments, nr_segments * sizeof(ksegments[0]));
+	ksegments = memdup_array_user(segments, nr_segments, sizeof(ksegments[0]));
 	if (IS_ERR(ksegments))
 		return PTR_ERR(ksegments);
 
-- 
2.41.0

