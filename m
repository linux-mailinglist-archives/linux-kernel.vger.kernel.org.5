Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0152F7F225C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjKUAk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjKUAkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:40:19 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1629114;
        Mon, 20 Nov 2023 16:40:13 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc0e78ec92so31414955ad.3;
        Mon, 20 Nov 2023 16:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700527213; x=1701132013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0h8yAS+G8YHpuqagMyaQ9goLsE9tJyhmBTQ25AFj0s=;
        b=XFl80V1Og099vz55KWPDjiTyP9/em07jGeREaCjtjfkjMvA5QE6a/ZoNkWZcw9a0jb
         ngHgPouSgzkvgMdtHeIQD++1Ez72yp0PRUXivbOcebtdhSPLFf1O+mGu1ZOiMUrXLYga
         SHAvzkoSiYqZGoq/TaZCBITVE7lSyxRbL+UZsm+/r7dhiaJhfo0MbJHuNBcOOeCyZEWt
         L/4qLfP5wJHRRPzKKjxc1gWNMVC9N/KMJra2B3koQfS6AG701wx3Mm2noipzE/T2YjAU
         wkaho+5DyQtKcWN5KkknB3J567VJf+ScIx2REH2TXB8Qu+JzbpObvESlQz2rSs/Vpuay
         sDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700527213; x=1701132013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0h8yAS+G8YHpuqagMyaQ9goLsE9tJyhmBTQ25AFj0s=;
        b=dlYMHVhxFP2MWUoq0HniqdzXiAFLMldE6Bse7/Ww03wwMsJL5Lwd2NxG8/XXjhHcNJ
         UJ7AJvEvNRZbNg8A0Crw7XzzzHKAjl7hkE9IQGSmxUcvuHWY4/W6JySDyzc6MTWK8j3N
         QuxNKX4Z8zN+Ka5OXXRVYVEjK+QVVnPcPm0s1pKmzWAf4wzXUbwFlWP5tI62frE9pwS0
         lvhTUiBX4JDXziI7TpPFD48dBTvhozU+2JkeddtKVL95DhsiWHwC7m94ZyvL22WmAPe4
         vk382D0yg299uytaJSVjGYq2KDrmKz0Vj7hXyOgqB3PdobLctAupQ9fJszBTRQqUPScm
         wCuQ==
X-Gm-Message-State: AOJu0YzAMn3udRDZJAl5XFKgmqs/5xSiw11ZwlLgQXea6qyho96QRMdo
        4Rw23kqIQ/nzb2TqFH3VirI=
X-Google-Smtp-Source: AGHT+IFRewbZRAvUU6gZKQNB4YVM/KU5JvPUE8Ku/K2+YHY6o9UQhoZvejH2rTSIxis/nDYoz8E2Qw==
X-Received: by 2002:a17:902:eb8f:b0:1cc:237c:75d6 with SMTP id q15-20020a170902eb8f00b001cc237c75d6mr7706097plg.67.1700527213178;
        Mon, 20 Nov 2023 16:40:13 -0800 (PST)
Received: from localhost ([47.215.232.245])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902b28100b001cf567252besm4035798plr.237.2023.11.20.16.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 16:40:12 -0800 (PST)
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
Subject: [PATCH v2 5/7] drm/msm/gem: Cleanup submit_cleanup_bo()
Date:   Mon, 20 Nov 2023 16:38:49 -0800
Message-ID: <20231121003935.5868-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121003935.5868-1-robdclark@gmail.com>
References: <20231121003935.5868-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
2.42.0

