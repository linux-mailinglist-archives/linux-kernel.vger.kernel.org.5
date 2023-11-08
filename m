Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365AE7E4EE3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbjKHC2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjKHC2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:28:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ECE10F9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 18:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699410444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=B3DL0Vft98Gq2vq6RutJxBknUxdBNOODfG1hAxtLDfY=;
        b=BAK6VOXBVV30gXMwFuppfSa17AnQbIdnC1ECUQ9z+J6UIE+nU3gdF8n5g6+NG0ckIEIH37
        iVKOyAlFg5nqWtUyiZxL+SABq1dw5aqIjsGRcj71dUH86I90RXZdYsIlWcrMzNzlThTRa/
        78FyGnCXWiNKBbo59PyNB8Roal5IiCs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-2kOUYiDqMOmBCiKXhtJjtA-1; Tue, 07 Nov 2023 21:27:21 -0500
X-MC-Unique: 2kOUYiDqMOmBCiKXhtJjtA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-53df4385dccso5053577a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 18:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699410440; x=1700015240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3DL0Vft98Gq2vq6RutJxBknUxdBNOODfG1hAxtLDfY=;
        b=vyJh+MDLr/MRsrdMhmEKOFgXpR8gQUoHMmOXY3XFZ+R4Eiu5xoRELrg8XJ1T2SJJWh
         a2JTgIZ2hhjti595B4KbtPhC3NUOekjV9hQPrQAzxc7cDqqGIgFZMagBdajXCOekapUM
         2tvnZ53wrr8eVScCu1u4JpPkt6YusTfXvhiN8qrSaY9m7Fk0S3Oj8OSgqCYf5poxr+h9
         Nxhm3WCUBUmiyiH2DkiK5RM1eqwgIEfpAcy0lcLtjlb6Mn/Sl9RuygBmoz4EVye/65zm
         BoJVIEjg1xZuodefk8cZwT3IrTeyo5D9nDXCi/YFM/jxLqMV/9mMzEBE0agP8zpt/WzX
         KMpQ==
X-Gm-Message-State: AOJu0YyKxTIlRhhyvXJi9l2bYhKsWmA4Ny+DVfjUpsqLkFBdWxuGOZSU
        s9KD6NjLezQ1vb68GAuRgKYnJocYImK4koSJ1uHf8PubHvLir97jjZopWBZbn/L9rEb3mjaukL0
        hcPyglfdN+n2WAZfXfiMm2N5x
X-Received: by 2002:a50:d555:0:b0:540:b0ec:bcd5 with SMTP id f21-20020a50d555000000b00540b0ecbcd5mr357602edj.15.1699410440221;
        Tue, 07 Nov 2023 18:27:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9Cp1VyYPjw3gjL38WhjvNs3AyxxiTpwYPuWjALttn8dwms8ZMyFDJwb9VJPRjdtsqUpNKCw==
X-Received: by 2002:a50:d555:0:b0:540:b0ec:bcd5 with SMTP id f21-20020a50d555000000b00540b0ecbcd5mr357590edj.15.1699410439971;
        Tue, 07 Nov 2023 18:27:19 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id m6-20020a50ef06000000b00543525d9fddsm5922217eds.21.2023.11.07.18.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 18:27:19 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, christian.koenig@amd.com,
        luben.tuikov@amd.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH] drm/sched: fix potential page fault in drm_sched_job_init()
Date:   Wed,  8 Nov 2023 03:26:07 +0100
Message-ID: <20231108022716.15250-1-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable
number of run-queues") introduces drm_err() in drm_sched_job_init(), in
order to indicate that the given entity has no runq, however at this
time job->sched is not yet set, likely to be NULL initialized, and hence
shouldn't be used.

Replace the corresponding drm_err() call with pr_err() to avoid a
potential page fault.

While at it, extend the documentation of drm_sched_job_init() to
indicate that job->sched is not a valid pointer until
drm_sched_job_arm() has been called.

Fixes: 56e449603f0a ("drm/sched: Convert the GPU scheduler to variable number of run-queues")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 27843e37d9b7..dd28389f0ddd 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -680,6 +680,9 @@ EXPORT_SYMBOL(drm_sched_resubmit_jobs);
  * This function returns -ENOENT in this case (which probably should be -EIO as
  * a more meanigful return value).
  *
+ * Note that job->sched is not a valid pointer until drm_sched_job_arm() has
+ * been called.
+ *
  * Returns 0 for success, negative error code otherwise.
  */
 int drm_sched_job_init(struct drm_sched_job *job,
@@ -691,7 +694,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
 		 * or worse--a blank screen--leave a trail in the
 		 * logs, so this can be debugged easier.
 		 */
-		drm_err(job->sched, "%s: entity has no rq!\n", __func__);
+		pr_err("%s: entity has no rq!\n", __func__);
 		return -ENOENT;
 	}
 

base-commit: c015fb6d01adb616fb54824feb55ce5ab18e8ca1
-- 
2.41.0

