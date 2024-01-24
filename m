Return-Path: <linux-kernel+bounces-36377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9C2839FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9991C283FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDC2168BD;
	Wed, 24 Jan 2024 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMveMR92"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E9EF9EB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065220; cv=none; b=p/RNHESHW0XluYiMO3yaVQQmIA9sj51qiEjcqNBfPQ1VRMT9wIbCVKFrJddDJzn5gZLUZtHaaL7QTv0eylogbK+BnzHQydF+HT37KaBkMdUwBDsKWLTOyI5aPKJzLmmUaNBeCfr7nNHiqq5A0HYRnVnZeANqJLgmKy2JZSQ7/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065220; c=relaxed/simple;
	bh=3BC2F6xZE6oGPR5HTxu2FCWMFh6XofuXNdXWJ+WqSHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TojDI0F3mzmOpVeqJnPak3Rbgy1AQlewkYmicNboyYK6HmYaa0HbwZEyorPK3UyeOvIX9sK+Tp74ei04pNDxOqMSS5Mq9Loa95y9P4eB+4fLJ/0cDaJyxJ/D0H4L2xfKxJwIH72Aqu8OB2rR3zGxrIaEjxtfWz8+PFJnP1KkCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMveMR92; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-559cef15db5so10611550a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706065216; x=1706670016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7t4g0dsSRdpeLCYs8MxmtMoFxRmps4SUlUHmKsZELwE=;
        b=IMveMR9239WW6q/MG9tQbZoyf1DRUPJQVE00StLK0+vi7ZVOGLDZg4ewyVEF3AB+mA
         3nL+0FHPq6NhqaE+/yZwvtmnw/rGztZm9Jh0NXCr2ehppre9D4HAzQYggaclJR6BOon9
         teq8aX6QaiszGsE729mH0Da1j0Aw1uD68gicok+EOM7m+A0bnFknVON9Kg6T6mIAppWr
         xmKJidXp4JJ3u+EmJdaYdrBRk/kQ5FI4xfC8zAvh8MDL5WItfN2NO0/mk3pwGgNM/Fij
         5jrI2kqrbSogCA4pV8OrS+bk4OrSLzPhnhGxyWYplAkVDdAsT5eNXkql/TLKKTI80OFt
         srAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065216; x=1706670016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7t4g0dsSRdpeLCYs8MxmtMoFxRmps4SUlUHmKsZELwE=;
        b=EyWoSsx7U1rPA61uc8vC5jlNIj+vKrXumgAfwldtLGEsB6dSwEM8B1sfYzVXJCZgaA
         8KFaDT14OR5uxDKk0EuZO3SLOI6LDmPzZFu64Bl+oVxjFGQAcw6P+uKDsUsM+awUiv9L
         rIfHBjPF/bk6bY11kpbhN61Huy2LaF1RIQvpAjn3tcBN287IABmytbajw9TdbNkB1TY/
         JF3oXTzj+Ww9AVEqwEgV1zpfB6jb41BNyQvVV6dicy+FD6mYvwjmlqGzDPC3XY0VpdTm
         kHgnCFtPT2s1/Z00cFDFFnH6/r1yx7ZyD2ifm/9s1wsgZWW2TUjY5dR3UFv0RBeNxa4N
         6YwQ==
X-Gm-Message-State: AOJu0Yx5y4fZIBqaBZyyXU6mDpy31dBc/A2/0DmV1golgQdV/CklueVJ
	RDV1JI4vLKLsgYGKjf5WpWF8w2Ed0NkPb5Qqysy7fW65P6k9/taO
X-Google-Smtp-Source: AGHT+IEqm4FeloylkgEyETEhp1HlT+xVHaBlzFpBrcRgGswpJ3yK7Jf9LdlNlQ1dmrLktikKiUiZ/w==
X-Received: by 2002:a50:fc04:0:b0:55c:7d37:7d9d with SMTP id i4-20020a50fc04000000b0055c7d377d9dmr481849edr.2.1706065216428;
        Tue, 23 Jan 2024 19:00:16 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id dj17-20020a05640231b100b00559bb146ecbsm9637914edb.6.2024.01.23.19.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 19:00:15 -0800 (PST)
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
Subject: [PATCH v2 8/8] drm/lima: standardize debug messages by ip name
Date: Wed, 24 Jan 2024 03:59:47 +0100
Message-ID: <20240124025947.2110659-9-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124025947.2110659-1-nunes.erico@gmail.com>
References: <20240124025947.2110659-1-nunes.erico@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some debug messages carried the ip name, or included "lima", or
included both the ip name and then the numbered ip name again.
Make the messages more consistent by always looking up and showing
the ip name first.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_gp.c       | 20 +++++++++++---------
 drivers/gpu/drm/lima/lima_l2_cache.c |  6 ++++--
 drivers/gpu/drm/lima/lima_mmu.c      | 18 +++++++++---------
 drivers/gpu/drm/lima/lima_pmu.c      |  3 ++-
 drivers/gpu/drm/lima/lima_pp.c       | 19 ++++++++++---------
 5 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_gp.c
index 4355fa7b17f4..6b354e2fb61d 100644
--- a/drivers/gpu/drm/lima/lima_gp.c
+++ b/drivers/gpu/drm/lima/lima_gp.c
@@ -34,11 +34,11 @@ static irqreturn_t lima_gp_irq_handler(int irq, void *data)
 	if (state & LIMA_GP_IRQ_MASK_ERROR) {
 		if ((state & LIMA_GP_IRQ_MASK_ERROR) ==
 		    LIMA_GP_IRQ_PLBU_OUT_OF_MEM) {
-			dev_dbg(dev->dev, "gp out of heap irq status=%x\n",
-				status);
+			dev_dbg(dev->dev, "%s out of heap irq status=%x\n",
+				lima_ip_name(ip), status);
 		} else {
-			dev_err(dev->dev, "gp error irq state=%x status=%x\n",
-				state, status);
+			dev_err(dev->dev, "%s error irq state=%x status=%x\n",
+				lima_ip_name(ip), state, status);
 			if (task)
 				task->recoverable = false;
 		}
@@ -89,7 +89,8 @@ static int lima_gp_soft_reset_async_wait(struct lima_ip *ip)
 				 v & LIMA_GP_IRQ_RESET_COMPLETED,
 				 0, 100);
 	if (err) {
-		dev_err(dev->dev, "gp soft reset time out\n");
+		dev_err(dev->dev, "%s soft reset time out\n",
+			lima_ip_name(ip));
 		return err;
 	}
 
@@ -194,7 +195,7 @@ static int lima_gp_hard_reset(struct lima_ip *ip)
 	gp_write(LIMA_GP_CMD, LIMA_GP_CMD_RESET);
 	ret = lima_poll_timeout(ip, lima_gp_hard_reset_poll, 10, 100);
 	if (ret) {
-		dev_err(dev->dev, "gp hard reset timeout\n");
+		dev_err(dev->dev, "%s hard reset timeout\n", lima_ip_name(ip));
 		return ret;
 	}
 
@@ -220,8 +221,9 @@ static void lima_gp_task_error(struct lima_sched_pipe *pipe)
 {
 	struct lima_ip *ip = pipe->processor[0];
 
-	dev_err(ip->dev->dev, "gp task error int_state=%x status=%x\n",
-		gp_read(LIMA_GP_INT_STAT), gp_read(LIMA_GP_STATUS));
+	dev_err(ip->dev->dev, "%s task error int_state=%x status=%x\n",
+		lima_ip_name(ip), gp_read(LIMA_GP_INT_STAT),
+		gp_read(LIMA_GP_STATUS));
 
 	lima_gp_hard_reset(ip);
 }
@@ -324,7 +326,7 @@ int lima_gp_init(struct lima_ip *ip)
 	err = devm_request_irq(dev->dev, ip->irq, lima_gp_irq_handler,
 			       IRQF_SHARED, lima_ip_name(ip), ip);
 	if (err) {
-		dev_err(dev->dev, "gp %s fail to request irq\n",
+		dev_err(dev->dev, "%s fail to request irq\n",
 			lima_ip_name(ip));
 		return err;
 	}
diff --git a/drivers/gpu/drm/lima/lima_l2_cache.c b/drivers/gpu/drm/lima/lima_l2_cache.c
index c4080a02957b..184106ce55f8 100644
--- a/drivers/gpu/drm/lima/lima_l2_cache.c
+++ b/drivers/gpu/drm/lima/lima_l2_cache.c
@@ -21,7 +21,8 @@ static int lima_l2_cache_wait_idle(struct lima_ip *ip)
 				 !(v & LIMA_L2_CACHE_STATUS_COMMAND_BUSY),
 				 0, 1000);
 	if (err) {
-		dev_err(dev->dev, "l2 cache wait command timeout\n");
+		dev_err(dev->dev, "%s wait command timeout\n",
+			lima_ip_name(ip));
 		return err;
 	}
 	return 0;
@@ -83,7 +84,8 @@ int lima_l2_cache_init(struct lima_ip *ip)
 	spin_lock_init(&ip->data.lock);
 
 	size = l2_cache_read(LIMA_L2_CACHE_SIZE);
-	dev_info(dev->dev, "l2 cache %uK, %u-way, %ubyte cache line, %ubit external bus\n",
+	dev_info(dev->dev, "%s %uK, %u-way, %ubyte cache line, %ubit external bus\n",
+		 lima_ip_name(ip),
 		 1 << (((size >> 16) & 0xff) - 10),
 		 1 << ((size >> 8) & 0xff),
 		 1 << (size & 0xff),
diff --git a/drivers/gpu/drm/lima/lima_mmu.c b/drivers/gpu/drm/lima/lima_mmu.c
index a1ae6c252dc2..e18317c5ca8c 100644
--- a/drivers/gpu/drm/lima/lima_mmu.c
+++ b/drivers/gpu/drm/lima/lima_mmu.c
@@ -22,7 +22,8 @@
 				  cond, 0, 100);	     \
 	if (__ret)					     \
 		dev_err(dev->dev,			     \
-			"mmu command %x timeout\n", cmd);    \
+			"%s command %x timeout\n",           \
+			lima_ip_name(ip), cmd);              \
 	__ret;						     \
 })
 
@@ -40,14 +41,13 @@ static irqreturn_t lima_mmu_irq_handler(int irq, void *data)
 	if (status & LIMA_MMU_INT_PAGE_FAULT) {
 		u32 fault = mmu_read(LIMA_MMU_PAGE_FAULT_ADDR);
 
-		dev_err(dev->dev, "mmu page fault at 0x%x from bus id %d of type %s on %s\n",
-			fault, LIMA_MMU_STATUS_BUS_ID(status),
-			status & LIMA_MMU_STATUS_PAGE_FAULT_IS_WRITE ? "write" : "read",
-			lima_ip_name(ip));
+		dev_err(dev->dev, "%s page fault at 0x%x from bus id %d of type %s\n",
+			lima_ip_name(ip), fault, LIMA_MMU_STATUS_BUS_ID(status),
+			status & LIMA_MMU_STATUS_PAGE_FAULT_IS_WRITE ? "write" : "read");
 	}
 
 	if (status & LIMA_MMU_INT_READ_BUS_ERROR)
-		dev_err(dev->dev, "mmu %s irq bus error\n", lima_ip_name(ip));
+		dev_err(dev->dev, "%s irq bus error\n", lima_ip_name(ip));
 
 	/* mask all interrupts before resume */
 	mmu_write(LIMA_MMU_INT_MASK, 0);
@@ -102,14 +102,14 @@ int lima_mmu_init(struct lima_ip *ip)
 
 	mmu_write(LIMA_MMU_DTE_ADDR, 0xCAFEBABE);
 	if (mmu_read(LIMA_MMU_DTE_ADDR) != 0xCAFEB000) {
-		dev_err(dev->dev, "mmu %s dte write test fail\n", lima_ip_name(ip));
+		dev_err(dev->dev, "%s dte write test fail\n", lima_ip_name(ip));
 		return -EIO;
 	}
 
 	err = devm_request_irq(dev->dev, ip->irq, lima_mmu_irq_handler,
 			       IRQF_SHARED, lima_ip_name(ip), ip);
 	if (err) {
-		dev_err(dev->dev, "mmu %s fail to request irq\n", lima_ip_name(ip));
+		dev_err(dev->dev, "%s fail to request irq\n", lima_ip_name(ip));
 		return err;
 	}
 
@@ -152,7 +152,7 @@ void lima_mmu_page_fault_resume(struct lima_ip *ip)
 	u32 v;
 
 	if (status & LIMA_MMU_STATUS_PAGE_FAULT_ACTIVE) {
-		dev_info(dev->dev, "mmu resume\n");
+		dev_info(dev->dev, "%s resume\n", lima_ip_name(ip));
 
 		mmu_write(LIMA_MMU_INT_MASK, 0);
 		mmu_write(LIMA_MMU_DTE_ADDR, 0xCAFEBABE);
diff --git a/drivers/gpu/drm/lima/lima_pmu.c b/drivers/gpu/drm/lima/lima_pmu.c
index e397e1146e96..113cb9b215cd 100644
--- a/drivers/gpu/drm/lima/lima_pmu.c
+++ b/drivers/gpu/drm/lima/lima_pmu.c
@@ -21,7 +21,8 @@ static int lima_pmu_wait_cmd(struct lima_ip *ip)
 				 v, v & LIMA_PMU_INT_CMD_MASK,
 				 100, 100000);
 	if (err) {
-		dev_err(dev->dev, "timeout wait pmu cmd\n");
+		dev_err(dev->dev, "%s timeout wait pmu cmd\n",
+			lima_ip_name(ip));
 		return err;
 	}
 
diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_pp.c
index ac097dd75072..d0d2db0ef1ce 100644
--- a/drivers/gpu/drm/lima/lima_pp.c
+++ b/drivers/gpu/drm/lima/lima_pp.c
@@ -26,8 +26,8 @@ static void lima_pp_handle_irq(struct lima_ip *ip, u32 state)
 	if (state & LIMA_PP_IRQ_MASK_ERROR) {
 		u32 status = pp_read(LIMA_PP_STATUS);
 
-		dev_err(dev->dev, "pp error irq state=%x status=%x\n",
-			state, status);
+		dev_err(dev->dev, "%s error irq state=%x status=%x\n",
+			lima_ip_name(ip), state, status);
 
 		pipe->error = true;
 
@@ -125,7 +125,7 @@ static int lima_pp_soft_reset_async_wait_one(struct lima_ip *ip)
 
 	ret = lima_poll_timeout(ip, lima_pp_soft_reset_poll, 0, 100);
 	if (ret) {
-		dev_err(dev->dev, "pp %s reset time out\n", lima_ip_name(ip));
+		dev_err(dev->dev, "%s reset time out\n", lima_ip_name(ip));
 		return ret;
 	}
 
@@ -190,14 +190,14 @@ static int lima_pp_hard_reset(struct lima_ip *ip)
 	pp_write(LIMA_PP_CTRL, LIMA_PP_CTRL_STOP_BUS);
 	ret = lima_poll_timeout(ip, lima_pp_bus_stop_poll, 10, 100);
 	if (ret) {
-		dev_err(dev->dev, "pp %s bus stop timeout\n", lima_ip_name(ip));
+		dev_err(dev->dev, "%s bus stop timeout\n", lima_ip_name(ip));
 		return ret;
 	}
 
 	pp_write(LIMA_PP_CTRL, LIMA_PP_CTRL_FORCE_RESET);
 	ret = lima_poll_timeout(ip, lima_pp_hard_reset_poll, 10, 100);
 	if (ret) {
-		dev_err(dev->dev, "pp hard reset timeout\n");
+		dev_err(dev->dev, "%s hard reset timeout\n", lima_ip_name(ip));
 		return ret;
 	}
 
@@ -274,7 +274,7 @@ int lima_pp_init(struct lima_ip *ip)
 	err = devm_request_irq(dev->dev, ip->irq, lima_pp_irq_handler,
 			       IRQF_SHARED, lima_ip_name(ip), ip);
 	if (err) {
-		dev_err(dev->dev, "pp %s fail to request irq\n",
+		dev_err(dev->dev, "%s fail to request irq\n",
 			lima_ip_name(ip));
 		return err;
 	}
@@ -309,7 +309,7 @@ int lima_pp_bcast_init(struct lima_ip *ip)
 	err = devm_request_irq(dev->dev, ip->irq, lima_pp_bcast_irq_handler,
 			       IRQF_SHARED, lima_ip_name(ip), ip);
 	if (err) {
-		dev_err(dev->dev, "pp %s fail to request irq\n",
+		dev_err(dev->dev, "%s fail to request irq\n",
 			lima_ip_name(ip));
 		return err;
 	}
@@ -423,8 +423,9 @@ static void lima_pp_task_error(struct lima_sched_pipe *pipe)
 	for (i = 0; i < pipe->num_processor; i++) {
 		struct lima_ip *ip = pipe->processor[i];
 
-		dev_err(ip->dev->dev, "pp task error %d int_state=%x status=%x\n",
-			i, pp_read(LIMA_PP_INT_STATUS), pp_read(LIMA_PP_STATUS));
+		dev_err(ip->dev->dev, "%s task error %d int_state=%x status=%x\n",
+			lima_ip_name(ip), i, pp_read(LIMA_PP_INT_STATUS),
+			pp_read(LIMA_PP_STATUS));
 
 		lima_pp_hard_reset(ip);
 	}
-- 
2.43.0


