Return-Path: <linux-kernel+bounces-36376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD7A839FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F68283457
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850611427B;
	Wed, 24 Jan 2024 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhsC9YGB"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D2DF50D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065218; cv=none; b=jY8io438dhqq5jSLoynNymfFVM/5ZbkwijseZQMB/9k8WONp3jpeHA2hjDpJhfRRypTcgE2f5MKgme7Q6WEDhYTaA9ekzQqIottiqoRE1uoVvhq8082aGK+JRtyds59glae9e8rzNOkGTkPzuGMsA56p2/JHKUG+KNxnfRbDQWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065218; c=relaxed/simple;
	bh=HDzhIKnDvEUadsba0NpYfaBhPDReAp3kSNvQfFXIXDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsQipdrUhjIDGbzEQWBu/M+ZtDui177kX3/xRtBGuoj2vWPwD6YMVb1FZViuvWpQrmAdaT4n3WNgdcIhSI3SHoUO/3mj5L0hKvchhXKMA9x1kCCB6DsmItjp6RjKF69YWTFTAc5nfDarp6UFY6sv3Ae2xnz0TF3SmXxGZ7nkYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhsC9YGB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so4172947a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706065215; x=1706670015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUjnB5UXcV+HhJdRxnmUySO0sKgHXE4jTknvXI2h7ds=;
        b=jhsC9YGBg2AfPeyHWmKQamMTsMcOZaKGKM85BXI9o6Up/vT4iSkyF9p42Hb+CDuTiT
         39BUzyDms6lX6MRFzeOAKdbUEQO4W7OYQWDMG/DyR04tp8koqzj3wN3I0ugSjEx2uR+7
         EN86gEqhhr4LS97xk0AqMr0itU3+HC1iL5MN/vFYsc+9y2bhxal4l/O4bEetzjAGxIib
         3jABMwjQiCJOXAGQnC5TLdzz0eq5liWwErVXQDN7HHfmvvywA0lTX0nOw8KBP10FE1Pf
         3TVfaMKXwwhqxp3U/BzDkHV9qhnt/2y02ZV78i9myeh7BFds7Dv+MZ2yS2AF6HWXzVZl
         Fmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065215; x=1706670015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUjnB5UXcV+HhJdRxnmUySO0sKgHXE4jTknvXI2h7ds=;
        b=LehKr9O39sRSv0KBiC6d1D6Nb4xKminFDLhaaWYERDyMG3JRFKwmV68Ba7eEkaim/T
         ij7R2lB1zV7yyeIWCV9NUL2JxUuyGqg8Ki9GFVfV0AXPMFH3TZAF+aNupQgJczDbNpBG
         leDUA49Thbmm/lPtTt8XcJKZTn4CnZdSta7mr1+1K4PTQ9Uw67PogXn/y0QaevBrFHSE
         SP9zNSIn6nq5ZYHe+noidZMmirLfQ+/SC7femKes7Gp/MGe49Ow+iC4ZyQGsPm459mMn
         HqMCY9lNYsUdtaUSdiRVwTJfYcoKRv1Y8MEbwT5wMGPoaqC4kotpcRZBlwOX9Lh4oSN4
         xicg==
X-Gm-Message-State: AOJu0YxMQqkV9w+YEW7+1d2PTxRXb0hX0EqVJKxHa3Sc2bt6XIU4+7jO
	+8sTYsEm69RVUoosCI7+fyXVe8zOu6ADGgWgHPACfjeAmpvMNVAx/2ec/ujxG6Y=
X-Google-Smtp-Source: AGHT+IHg5LrHSVYVuCNSXsc0+hEAvO6xwpPVT8afKP9CgCtUEsSJwOjoz5XuLPsY9rpygEFUeDJYEw==
X-Received: by 2002:a05:6402:358c:b0:55c:74f2:44de with SMTP id y12-20020a056402358c00b0055c74f244demr846902edc.108.1706065215429;
        Tue, 23 Jan 2024 19:00:15 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id dj17-20020a05640231b100b00559bb146ecbsm9637914edb.6.2024.01.23.19.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 19:00:14 -0800 (PST)
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
Subject: [PATCH v2 7/8] drm/lima: increase default job timeout to 10s
Date: Wed, 24 Jan 2024 03:59:46 +0100
Message-ID: <20240124025947.2110659-8-nunes.erico@gmail.com>
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

The previous 500ms default timeout was fairly optimistic and could be
hit by real world applications. Many distributions targeting devices
with a Mali-4xx already bumped this timeout to a higher limit.
We can be generous here with a high value as 10s since this should
mostly catch buggy jobs like infinite loop shaders, and these don't
seem to happen very often in real applications.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index c2e78605e43e..00b19adfc888 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -505,7 +505,7 @@ static void lima_sched_recover_work(struct work_struct *work)
 int lima_sched_pipe_init(struct lima_sched_pipe *pipe, const char *name)
 {
 	unsigned int timeout = lima_sched_timeout_ms > 0 ?
-			       lima_sched_timeout_ms : 500;
+			       lima_sched_timeout_ms : 10000;
 
 	pipe->fence_context = dma_fence_context_alloc(1);
 	spin_lock_init(&pipe->fence_lock);
-- 
2.43.0


