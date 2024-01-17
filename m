Return-Path: <linux-kernel+bounces-28494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D0682FF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01140B23B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61222BE7F;
	Wed, 17 Jan 2024 03:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6FczG8S"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EB8F5F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705461147; cv=none; b=qWSthIXjYbsc8OPPwsj6tCmseQzujQGAiheZxGiduuW2QIQG3q9l30veT9T2mjwO2jrLIWtEJIfnRhjVovC04uie+mvr2BQoGCr2XXvo/Y5BhQu4JwM9VmWEicn0lB7Issib935uw09LiExMe6QnSnVLR+v6VZMfiTY4t9aUKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705461147; c=relaxed/simple;
	bh=kBQHWvJeg/cN7D9wVq31Z/qnvPhBjHrVZP82wVlIrAc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=L6kcTty/XW2VrH7veRjc4ocqYxwHjqmSmXOfOcsBITjWoHfD6PbAQJOZgNEvVU51sLVvOUNUCm/K7g6j+uJOlbn6IRsMuZNSILMmbRZWe7eEtrHjc7//T+x36WUb4Nue+eIWTQcbZsjFJuzGLo4b237WTSlpiR5N60LcOVArNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6FczG8S; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-559cef15db5so657641a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705461144; x=1706065944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TurR4TSqa7pH4YQLivqIMoaxRqWtz6E/dts/c6GuzZE=;
        b=D6FczG8SPQ2B8Bx/1pF4LYhQe0R3sK1RTqO+wLgxQDrhi5HaE5Zz5hlmGYWQMZslZK
         uGOQjxyNQX/kGw5QHaEG0UOQ9qJiFVpx0qrDArenCwA8NyUFnbxPoQCUgcVRLhJPS7+Y
         eB6Dq2f2x/D+BmP9C5lCCiQHjcYCBrko1IeMH/qhFG82voOOLRZNTmIQIKMj/DhkI8u4
         Qcu7pkLLwxUdNVmnRyvhrEaTtTllrWAg4ap8S/W5HIxsWLVy8EVUMPQG+/whB1WMXEXc
         QzfTJ9oytWkxfIMu6dOuMP9M8Y7F1SJ4yfk2WvhFqmlXsuHyUbcDs1432fUGmeErIyiF
         kAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705461144; x=1706065944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TurR4TSqa7pH4YQLivqIMoaxRqWtz6E/dts/c6GuzZE=;
        b=UwLyBLzWQV+wo+eOuQMmaGdgG0oQs5B+QRSyddQUew7SFtVrxsKoNG7lrWCsx3ev43
         uspQJ6ibK/AgyvsV7+JoqwfO1Jwc9r4I6QOGJYBLI6xSSO24FBnMxfQdDBgOFHclwSg7
         3z7x/12yCsuwrRWtFGBC42h/EyYCIJX48/kKpZboGEULbVVTDU5GxPaRznG6D8j3Ix3K
         jYjdjGn5LfvyROqXVZOcWl8i+JEKgYusx07yZI+0mhim1yvalZ2cHr4Gq1PO2PLc2arL
         OObLNgvrtqF7Tu/WowHAG8clK8H3eoHpxH1+vK+rzIizBapOEgcQCFY417XBskaHIn/8
         TkKA==
X-Gm-Message-State: AOJu0YwbsOPxRcvgNa9ccRG3KSn/p/fN3Fp0VUrdvoli12noazf3lMfB
	tJzrneq40EDHJ2BIHJ5cx5Q=
X-Google-Smtp-Source: AGHT+IGetluui/FySPGgoTIPulAjmlBnWc8jvnBGs+ZlVHD0WYWX+lScQaqSVrFsrUDD1HER0F64yg==
X-Received: by 2002:aa7:d84d:0:b0:558:308f:db04 with SMTP id f13-20020aa7d84d000000b00558308fdb04mr153546eds.18.1705461144164;
        Tue, 16 Jan 2024 19:12:24 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640204cd00b0055971af7a23sm2258418edw.95.2024.01.16.19.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 19:12:23 -0800 (PST)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: anarsoul@gmail.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	christian.koenig@amd.com,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH v1 5/6] drm/lima: remove guilty drm_sched context handling
Date: Wed, 17 Jan 2024 04:12:11 +0100
Message-ID: <20240117031212.1104034-6-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117031212.1104034-1-nunes.erico@gmail.com>
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
index 9449b81bcd5b..496c79713fe8 100644
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
index 34050facb110..677e908b53f8 100644
--- a/drivers/gpu/drm/lima/lima_sched.h
+++ b/drivers/gpu/drm/lima/lima_sched.h
@@ -93,8 +93,7 @@ int lima_sched_task_init(struct lima_sched_task *task,
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


