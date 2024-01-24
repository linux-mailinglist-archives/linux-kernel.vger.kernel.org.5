Return-Path: <linux-kernel+bounces-36375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E801839FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A0E1F259AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15235C98;
	Wed, 24 Jan 2024 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgXtL6ly"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F4DDD6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065218; cv=none; b=Mmrf0m+BUzcdw+msAxcJCbPclxngrcUhRUTVwQj6N2d0BarChm36RSBrtqODnGVfbrF/6x+RBGWNItBoMp1T+i463sTXaikC556qNQ7Dnl42lkRqRc4oyQM82QWSHplgxgqOAwmyPTtZ15O5VAMLUxTZ9jxACLIg9F4NZF4JnIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065218; c=relaxed/simple;
	bh=CAAyd6m6zHz9mQ5m5c51BGdzwELNqXW4ebqMAmJGEBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+hac85C6sfkMhT7DyDbK45m9URhN+JfMi9Nfx43tqm2nVoTElGeZwbLRU1soI0zIubFVI1AG4XNsQs6202TsJYXqg5gCDwTFEV3erHNOgVgAVH6SLQVLjnmZDJcgz4SlJOsSDwLEfTu9gE2e4ofq62Ck9UsmbpoC1oVmloiGOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgXtL6ly; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40eb99a72dcso14183315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706065214; x=1706670014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPOuKECiwusygEzLYMH/0TGCGdxpS/EWgBvieVarlTc=;
        b=EgXtL6lyP/SnIbHjYdglYO8uOyygJM53ibpBl4MZkwObBHC2PtuLMpGSlpA9XNLzgd
         W7e4yi0T97LzPhnEH1MsyQrbJvA/aAxWmgZDkDT3OMiFPgRvv0L4ncIHIRgvHbtogXZO
         6eO6ROPsOw3jobbsXO1vgQpJf9qtUPDr6vC+E89YiFZr/3hiimOc8Ly8VpiUmWCMUftE
         Q1BIekkQIDsN3hkaGak2EYgGeu0ArE46Ncig35dEp0H8tkWR4kWE1vAtLRYQhU0QRVRP
         ONbZlqd5wl0gORT6Ka8s/KxQ4CahqwZTpQ1BBvmp6wIvD3AZMbMwjEdzrdeBqIzkXlIA
         91DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065214; x=1706670014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPOuKECiwusygEzLYMH/0TGCGdxpS/EWgBvieVarlTc=;
        b=O/oDRg1W8YBWqE5sELz16D5ZiVUlhxLRzVRorvmXQEzhTThuSZahrAIlwh0HNeyWZM
         rzDes0Ew/uoIUkeg6soVPU+/4Qi70mRW8wr8/LRyIswZ8CTX8x/EZKj3cIKiBWQUYRAy
         dShXeOvJsLw3peOO1sfJFLweoIw99ZzdgLgPlTD6b4I3y6vgq1H6rgC0/S2f+mm3GLz7
         pnaJniEh6rQHXk7FIqiAMs7DiDMyaXZVB6aBrjPjrFcZn7kFXnmy8fbDMKZGoLgLd7TO
         xf7R4A8RzoCE2RHrENJtgnwwYEcVEHg/8IzxY8xRnzjaQ6qBlsLmFuY6/fsaKshfdUwt
         bIqQ==
X-Gm-Message-State: AOJu0YzEpeFWaeqhtytWVIAwi2fBz7dOyBuVnfHaRebecHAc3pXS1DVZ
	4SGzBaqsX3LbCJuU/cLd8lzb4y0GTwYnxW8TApieTOHcGmdhnCH+
X-Google-Smtp-Source: AGHT+IH9nwxT639jdbbzp4/DS6PQHGpdpzVCBa61wucVXmalZ7SmRPk+J63hGBQfS46wwyrTbkMVXQ==
X-Received: by 2002:a05:600c:45c9:b0:40e:6238:e9e8 with SMTP id s9-20020a05600c45c900b0040e6238e9e8mr642304wmo.1.1706065214435;
        Tue, 23 Jan 2024 19:00:14 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id dj17-20020a05640231b100b00559bb146ecbsm9637914edb.6.2024.01.23.19.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 19:00:13 -0800 (PST)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	anarsoul@gmail.com,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH v2 6/8] drm/lima: remove guilty drm_sched context handling
Date: Wed, 24 Jan 2024 03:59:45 +0100
Message-ID: <20240124025947.2110659-7-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124025947.2110659-1-nunes.erico@gmail.com>
References: <20240124025947.2110659-1-nunes.erico@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Marking the context as guilty currently only makes the application which
hits a single timeout problem to stop its rendering context entirely.
All jobs submitted later are dropped from the guilty context.

Lima runs on fairly underpowered hardware for modern standards and it is
not entirely unreasonable that a rendering job may time out occasionally
due to high system load or too demanding application stack. In this case
it would be generally preferred to report the error but try to keep the
application going.

Other similar embedded GPU drivers don't make use of the guilty context
flag. Now that there are reliability improvements to the lima timeout
recovery handling, drop the guilty contexts to let the application keep
running in this case.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/lima/lima_ctx.c   | 2 +-
 drivers/gpu/drm/lima/lima_ctx.h   | 1 -
 drivers/gpu/drm/lima/lima_sched.c | 5 ++---
 drivers/gpu/drm/lima/lima_sched.h | 3 +--
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_ctx.c b/drivers/gpu/drm/lima/lima_ctx.c
index 8389f2d7d021..0e668fc1e0f9 100644
--- a/drivers/gpu/drm/lima/lima_ctx.c
+++ b/drivers/gpu/drm/lima/lima_ctx.c
@@ -19,7 +19,7 @@ int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id)
 	kref_init(&ctx->refcnt);
 
 	for (i = 0; i < lima_pipe_num; i++) {
-		err = lima_sched_context_init(dev->pipe + i, ctx->context + i, &ctx->guilty);
+		err = lima_sched_context_init(dev->pipe + i, ctx->context + i);
 		if (err)
 			goto err_out0;
 	}
diff --git a/drivers/gpu/drm/lima/lima_ctx.h b/drivers/gpu/drm/lima/lima_ctx.h
index 74e2be09090f..5b1063ce968b 100644
--- a/drivers/gpu/drm/lima/lima_ctx.h
+++ b/drivers/gpu/drm/lima/lima_ctx.h
@@ -13,7 +13,6 @@ struct lima_ctx {
 	struct kref refcnt;
 	struct lima_device *dev;
 	struct lima_sched_context context[lima_pipe_num];
-	atomic_t guilty;
 
 	/* debug info */
 	char pname[TASK_COMM_LEN];
diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index 814428564637..c2e78605e43e 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -154,13 +154,12 @@ void lima_sched_task_fini(struct lima_sched_task *task)
 }
 
 int lima_sched_context_init(struct lima_sched_pipe *pipe,
-			    struct lima_sched_context *context,
-			    atomic_t *guilty)
+			    struct lima_sched_context *context)
 {
 	struct drm_gpu_scheduler *sched = &pipe->base;
 
 	return drm_sched_entity_init(&context->base, DRM_SCHED_PRIORITY_NORMAL,
-				     &sched, 1, guilty);
+				     &sched, 1, NULL);
 }
 
 void lima_sched_context_fini(struct lima_sched_pipe *pipe,
diff --git a/drivers/gpu/drm/lima/lima_sched.h b/drivers/gpu/drm/lima/lima_sched.h
index 6a11764d87b3..6bd4f3b70109 100644
--- a/drivers/gpu/drm/lima/lima_sched.h
+++ b/drivers/gpu/drm/lima/lima_sched.h
@@ -91,8 +91,7 @@ int lima_sched_task_init(struct lima_sched_task *task,
 void lima_sched_task_fini(struct lima_sched_task *task);
 
 int lima_sched_context_init(struct lima_sched_pipe *pipe,
-			    struct lima_sched_context *context,
-			    atomic_t *guilty);
+			    struct lima_sched_context *context);
 void lima_sched_context_fini(struct lima_sched_pipe *pipe,
 			     struct lima_sched_context *context);
 struct dma_fence *lima_sched_context_queue_task(struct lima_sched_task *task);
-- 
2.43.0


