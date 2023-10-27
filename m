Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528537D9E60
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345927AbjJ0Q7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345989AbjJ0Q73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:59:29 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D6ED43;
        Fri, 27 Oct 2023 09:59:25 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5b94489e82eso499386a12.2;
        Fri, 27 Oct 2023 09:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698425965; x=1699030765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BA1fIFWWJwK3F1h9NsiUN1cc0sAjE3mQ5LVwLgXV8Q=;
        b=grtnAZkMBiacy9wvz1HmcE51JavK+Hv/lzCSAgm1dozsmdIf5wJ7b4e+Q/h6k1eBV5
         J2WzCZmcqIYGEBgFu1MBYaBmAeI6lMlACMkx9WobyAJB5xa61n/DfjemdT3M3zGl/fxj
         Qu5GaBlIrZUx7FJkZBWizY3j1qtW5G0gI6C7K0IP+u4FHsPdN82Mauok6jAJPQT5U176
         uGL+AXlfU4eRDiB5vsJd5FkRE2hnkgiNGiyOiR3XY9sGVhGtct8uq4x7i/WIyvhLssn1
         XZiB/MHE2HUW2/t6eQ+8ztXcEBiVtufhduj1fzm6XB/cWf7EZXF5a3pwKQFAzjo6C1TH
         N+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698425965; x=1699030765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BA1fIFWWJwK3F1h9NsiUN1cc0sAjE3mQ5LVwLgXV8Q=;
        b=FpFJZIAGljesVjnWf2VGmxasWuWZ+UYwRzcNUAPQDnfVHxnd6WdhccicJr9xvTwQ6+
         PiOTYLAxtD1yydaVQYuPwRhV56FiiZXEP/wKXUgRw/g7sr4gKnz4qwMeGMZf4Tqu3PCa
         Gaem7adb6q15jirumD0Alct33Lv8nNYsMALI2yQzUjTrlPxHFjuuQqH49fKgAukuoC4O
         dj5iou8Tn1UVDZKnVu5ofzN7h3kd7rnzjlUlBBy/tMsZ482WnOXInBEMvNgvNJzfmidl
         XXvvqQlQGV62+IqTYVa8kHYyuk2vnlPNWJJIizRoR/pmc/Ab7qrvgnUaDFM2KkxOh3+x
         vgJw==
X-Gm-Message-State: AOJu0YxkG8OApizcVgzLnwAVUTKw8JFKTC1YdYLSKN27BvCv0uma6knN
        m4c8g4sU0TzNiWpCGzsA0So=
X-Google-Smtp-Source: AGHT+IH/uki0khux3haTMmLK51tgfszYjsxvRsbP4tOoqeorUKEKoGJdToiXOeNo+Y2KebPoIO/3GA==
X-Received: by 2002:a17:90a:6e48:b0:27d:9f6:47b1 with SMTP id s8-20020a17090a6e4800b0027d09f647b1mr2892882pjm.33.1698425964884;
        Fri, 27 Oct 2023 09:59:24 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001bd99fd1114sm1780352plh.288.2023.10.27.09.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 09:59:24 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/7] drm/msm/gem: Cleanup submit_cleanup_bo()
Date:   Fri, 27 Oct 2023 09:58:39 -0700
Message-ID: <20231027165859.395638-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027165859.395638-1-robdclark@gmail.com>
References: <20231027165859.395638-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Now that it only handles unlock duty, drop the superfluous arg and
rename it.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index d001bf286606..603f04d851d9 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -248,14 +248,10 @@ static int submit_lookup_cmds(struct msm_gem_submit *submit,
 	return ret;
 }
 
-/* Unwind bo state, according to cleanup_flags.  In the success case, only
- * the lock is dropped at the end of the submit (and active/pin ref is dropped
- * later when the submit is retired).
- */
-static void submit_cleanup_bo(struct msm_gem_submit *submit, int i,
-		unsigned cleanup_flags)
+static void submit_unlock_bo(struct msm_gem_submit *submit, int i)
 {
 	struct drm_gem_object *obj = submit->bos[i].obj;
+	unsigned cleanup_flags = BO_LOCKED;
 	unsigned flags = submit->bos[i].flags & cleanup_flags;
 
 	/*
@@ -304,10 +300,10 @@ static int submit_lock_objects(struct msm_gem_submit *submit)
 	}
 
 	for (; i >= 0; i--)
-		submit_cleanup_bo(submit, i, BO_LOCKED);
+		submit_unlock_bo(submit, i);
 
 	if (slow_locked > 0)
-		submit_cleanup_bo(submit, slow_locked, BO_LOCKED);
+		submit_unlock_bo(submit, slow_locked);
 
 	if (ret == -EDEADLK) {
 		struct drm_gem_object *obj = submit->bos[contended].obj;
@@ -533,7 +529,6 @@ static int submit_reloc(struct msm_gem_submit *submit, struct drm_gem_object *ob
  */
 static void submit_cleanup(struct msm_gem_submit *submit, bool error)
 {
-	unsigned cleanup_flags = BO_LOCKED;
 	unsigned i;
 
 	if (error)
@@ -541,7 +536,7 @@ static void submit_cleanup(struct msm_gem_submit *submit, bool error)
 
 	for (i = 0; i < submit->nr_bos; i++) {
 		struct drm_gem_object *obj = submit->bos[i].obj;
-		submit_cleanup_bo(submit, i, cleanup_flags);
+		submit_unlock_bo(submit, i);
 		if (error)
 			drm_gem_object_put(obj);
 	}
-- 
2.41.0

