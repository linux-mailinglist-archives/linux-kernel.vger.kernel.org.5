Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3B27D9E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345911AbjJ0Q7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ0Q7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:59:19 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB42B128;
        Fri, 27 Oct 2023 09:59:16 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5b8c39a2dceso1807122a12.2;
        Fri, 27 Oct 2023 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698425956; x=1699030756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5R6dnp6JYl9GTg3p8/cfLvJpZVQTPFVKn1Jc3rRbi2Y=;
        b=KagQFQXObISaEISU+45Xa5HA+1ctecJbfNQDuigNAdrSELcbIDNH5PX+ovC4OIZr63
         Tl2MofT8FPkRB4ti8e0X3Ur5/ySrxhuxYEaQZOYpGOBOdrwDaa0DSR0eUQMSA6yHFTZp
         QMVAQxEwwng6A9hRPSVQNPRg7SMZGX4poU4BU2Djh4JLU9ehYzL1e3zKNIIimygtndlX
         PrJDiTe/BMfonnOXE2wFdW/BRnetG7uYTqlyFqMe+Xwkseoy3qXZ0P6wQR1AKRTuN48t
         AkQwgO2fwoyrfwxF8DZMteNQZovcUowGabIauZGehVrMStrK0MpTSWtwDSF8DtJJ8GTZ
         6oPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698425956; x=1699030756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5R6dnp6JYl9GTg3p8/cfLvJpZVQTPFVKn1Jc3rRbi2Y=;
        b=mAgRPxlG5wZNMW+x13WaP+kS2iAjceLANveb+KparvCaVxGv0SEA6/wcDtKeJjvzSb
         C6XCYxZxeo+m3NWm/9UX80Yyiyo64pXtMGbamMR9Co/GRnFGm0tosM85wIQSxq2CmCTx
         ncSCPF7Oyi3Cg7SRsB/pGIRYYdVUgyLFBJD4Y8qNKQlxI+5d/W3TVxW2+g229gZ4r9rL
         KVlJLQ4ktWtuXF3z6aDaMCtKPPL6B2HF9DvCxoGY25rFrrpGDndeOG/EfcBW0wjDvTaK
         iWX0EJOmTqMR3scOn/7w8EAhnVQHk3Up3gzgKURGEhTmLDpruaOCbKZ9mYeCL/JT7dtQ
         +T1Q==
X-Gm-Message-State: AOJu0YxCC/G6h+rkWMTajjUkX0/tgG5gAje1mdTDP4QAjZt4Kj+6zUCP
        QNlpRBKc5dJcG+1o/MPuXpY=
X-Google-Smtp-Source: AGHT+IGKn3WMc6OBc8kKe4JkxH8X2ZWrozRHWu6T+6S+ZBzTtDZM8a8mjcxLZWnStYmHSFiQ1ePvig==
X-Received: by 2002:a17:90b:3781:b0:27d:d36:763b with SMTP id mz1-20020a17090b378100b0027d0d36763bmr3013167pjb.31.1698425956153;
        Fri, 27 Oct 2023 09:59:16 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id pj1-20020a17090b4f4100b00273744e6eccsm1446083pjb.12.2023.10.27.09.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 09:59:15 -0700 (PDT)
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
Subject: [PATCH 1/7] drm/msm/gem: Remove "valid" tracking
Date:   Fri, 27 Oct 2023 09:58:35 -0700
Message-ID: <20231027165859.395638-2-robdclark@gmail.com>
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

This was a small optimization for pre-soft-pin userspace.  But mesa
switched to soft-pin nearly 5yrs ago.  So lets drop the optimization
and simplify the code.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.h        |  2 --
 drivers/gpu/drm/msm/msm_gem_submit.c | 44 +++++-----------------------
 2 files changed, 8 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 8ddef5443140..c36c1c1fa222 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -271,7 +271,6 @@ struct msm_gem_submit {
 	struct msm_gpu_submitqueue *queue;
 	struct pid *pid;    /* submitting process */
 	bool fault_dumped;  /* Limit devcoredump dumping to one per submit */
-	bool valid;         /* true if no cmdstream patching needed */
 	bool in_rb;         /* "sudo" mode, copy cmds into RB */
 	struct msm_ringbuffer *ring;
 	unsigned int nr_cmds;
@@ -288,7 +287,6 @@ struct msm_gem_submit {
 	} *cmd;  /* array of size nr_cmds */
 	struct {
 /* make sure these don't conflict w/ MSM_SUBMIT_BO_x */
-#define BO_VALID	0x8000	/* is current addr in cmdstream correct/valid? */
 #define BO_LOCKED	0x4000	/* obj lock is held */
 #define BO_PINNED	0x2000	/* obj (pages) is pinned and on active list */
 		uint32_t flags;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 6d8ec1337e8b..996274ef32a6 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -150,8 +150,6 @@ static int submit_lookup_objects(struct msm_gem_submit *submit,
 
 		submit->bos[i].handle = submit_bo.handle;
 		submit->bos[i].flags = submit_bo.flags;
-		/* in validate_objects() we figure out if this is true: */
-		submit->bos[i].iova  = submit_bo.presumed;
 	}
 
 	spin_lock(&file->table_lock);
@@ -278,9 +276,6 @@ static void submit_unlock_unpin_bo(struct msm_gem_submit *submit, int i)
 {
 	unsigned cleanup_flags = BO_PINNED | BO_LOCKED;
 	submit_cleanup_bo(submit, i, cleanup_flags);
-
-	if (!(submit->bos[i].flags & BO_VALID))
-		submit->bos[i].iova = 0;
 }
 
 /* This is where we make sure all the bo's are reserved and pin'd: */
@@ -390,8 +385,6 @@ static int submit_pin_objects(struct msm_gem_submit *submit)
 	struct msm_drm_private *priv = submit->dev->dev_private;
 	int i, ret = 0;
 
-	submit->valid = true;
-
 	for (i = 0; i < submit->nr_bos; i++) {
 		struct drm_gem_object *obj = submit->bos[i].obj;
 		struct msm_gem_vma *vma;
@@ -407,14 +400,7 @@ static int submit_pin_objects(struct msm_gem_submit *submit)
 		if (ret)
 			break;
 
-		if (vma->iova == submit->bos[i].iova) {
-			submit->bos[i].flags |= BO_VALID;
-		} else {
-			submit->bos[i].iova = vma->iova;
-			/* iova changed, so address in cmdstream is not valid: */
-			submit->bos[i].flags &= ~BO_VALID;
-			submit->valid = false;
-		}
+		submit->bos[i].iova = vma->iova;
 	}
 
 	/*
@@ -451,7 +437,7 @@ static void submit_attach_object_fences(struct msm_gem_submit *submit)
 }
 
 static int submit_bo(struct msm_gem_submit *submit, uint32_t idx,
-		struct drm_gem_object **obj, uint64_t *iova, bool *valid)
+		struct drm_gem_object **obj, uint64_t *iova)
 {
 	if (idx >= submit->nr_bos) {
 		SUBMIT_ERROR(submit, "invalid buffer index: %u (out of %u)\n",
@@ -463,8 +449,6 @@ static int submit_bo(struct msm_gem_submit *submit, uint32_t idx,
 		*obj = submit->bos[idx].obj;
 	if (iova)
 		*iova = submit->bos[idx].iova;
-	if (valid)
-		*valid = !!(submit->bos[idx].flags & BO_VALID);
 
 	return 0;
 }
@@ -477,9 +461,6 @@ static int submit_reloc(struct msm_gem_submit *submit, struct drm_gem_object *ob
 	uint32_t *ptr;
 	int ret = 0;
 
-	if (!nr_relocs)
-		return 0;
-
 	if (offset % 4) {
 		SUBMIT_ERROR(submit, "non-aligned cmdstream buffer: %u\n", offset);
 		return -EINVAL;
@@ -500,7 +481,6 @@ static int submit_reloc(struct msm_gem_submit *submit, struct drm_gem_object *ob
 		struct drm_msm_gem_submit_reloc submit_reloc = relocs[i];
 		uint32_t off;
 		uint64_t iova;
-		bool valid;
 
 		if (submit_reloc.submit_offset % 4) {
 			SUBMIT_ERROR(submit, "non-aligned reloc offset: %u\n",
@@ -519,13 +499,10 @@ static int submit_reloc(struct msm_gem_submit *submit, struct drm_gem_object *ob
 			goto out;
 		}
 
-		ret = submit_bo(submit, submit_reloc.reloc_idx, NULL, &iova, &valid);
+		ret = submit_bo(submit, submit_reloc.reloc_idx, NULL, &iova);
 		if (ret)
 			goto out;
 
-		if (valid)
-			continue;
-
 		iova += submit_reloc.reloc_offset;
 
 		if (submit_reloc.shift < 0)
@@ -879,8 +856,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		struct drm_gem_object *obj;
 		uint64_t iova;
 
-		ret = submit_bo(submit, submit->cmd[i].idx,
-				&obj, &iova, NULL);
+		ret = submit_bo(submit, submit->cmd[i].idx, &obj, &iova);
 		if (ret)
 			goto out;
 
@@ -894,17 +870,13 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 
 		submit->cmd[i].iova = iova + (submit->cmd[i].offset * 4);
 
-		if (submit->valid)
+		if (likely(!submit->cmd[i].nr_relocs))
 			continue;
 
 		if (!gpu->allow_relocs) {
-			if (submit->cmd[i].nr_relocs) {
-				SUBMIT_ERROR(submit, "relocs not allowed\n");
-				ret = -EINVAL;
-				goto out;
-			}
-
-			continue;
+			SUBMIT_ERROR(submit, "relocs not allowed\n");
+			ret = -EINVAL;
+			goto out;
 		}
 
 		ret = submit_reloc(submit, obj, submit->cmd[i].offset * 4,
-- 
2.41.0

