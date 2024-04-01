Return-Path: <linux-kernel+bounces-127078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ECC89467A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767E01C21DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DD555E73;
	Mon,  1 Apr 2024 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENqd+/3P"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7678C54BE8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006438; cv=none; b=rZ7/P/beT+ArTY27G9stkIqQ/ZIOSAHhYIGRCZ9poPGkrFsb3ZEA5y0mAzIM+BJ/kY4qokQas065nm9Xmbgi4/YbgMAjlOrTRj+OUyqhxLcLqC05IcKB77lRMyGn2IRNpfBb6V6//R1Bth8y6YSv1k8W2snBNygEOT9LSfG/rRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006438; c=relaxed/simple;
	bh=4tAT8rRy70vJeo8NmALG6/yPhj/u7VxHH0WOeoyFZZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYmyEj5xfkUgberQJw8mxh1vZrUFSf9xA9kS491ssykcIMYMCqr/VLqqTZDhGfvCIkT/UkK0JFs5O86gMr8pU5t1Qh7DOIHjt2OYaD5YYFdjz9WPcCjQkrajVjj37Rr6gsl9dqIQSIN3bR27BA65eOe74PIpwORGflrSawKfzjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENqd+/3P; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so8738263a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 14:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712006435; x=1712611235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6CZf7DmYX851P/l0Uf00dwEomagAVZ/kC4VexJ4Dzo=;
        b=ENqd+/3P4nIBn1yCGJ0pyjn+yCOo1SozdAURRuiLoXRG2A+Ai7grd+hESjd3OpypOD
         c8TnDqnNecgX8Ed5Q0PVjfA3ei0ZxK5eUoLdzJVk03Y7V57ZIiEmYWvG2dvJtPF6lgb6
         rKUS/dkTjZd+H7/t1vfz22YwkEzu5d0w9R69F25WnmFeABs2Ui4aRORd8GlZguvDKCrj
         6IsPuC2Vulbb+bOhsOQIfY60CdjbJPSxp5NEJuc+NuTLbjLU+ao2B6v8NvOL8rB3bhXj
         pYzDt4RKEfWe5Yn9zy0bVKFh5WRkBaRTjR7MdBGUNUzisICENWwUlrjI8jvLp0UJrwFB
         Ljzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712006435; x=1712611235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6CZf7DmYX851P/l0Uf00dwEomagAVZ/kC4VexJ4Dzo=;
        b=w8JLje0cmvkM6jvJY0ZD7/TCWNaW2vgn7L2b3u9RuJAmJdlE+avZV6Bri+1/ozueXg
         ez5c1qAHezud8HAylAqjtN7RGGzjb5AWClaxyKSBzPcofw18yXE39QlwPatbCWtDV0Gy
         3CipGdcKlF+oDRsD+PgurP2SoyrIKJd57QyIPoOf8WwProqKQPfoOB2i2IRoFAt8Amfi
         MVXqBcVv3pqn7Hc4bAWKOWL43Zr/uXaZfbP8GShxVb2DXWB/qh1HzpGTAhZIEGm1r3Vl
         d2OzKKTcxkm3ILRkGaS4Bf1t1hBpesmWWc/VUqKy5rV8to+gdxDjGnpce8CiNo9P9/hn
         iUMA==
X-Forwarded-Encrypted: i=1; AJvYcCVUWOC1R6dg56us3uCogtSTZ17wuw0yQDk1qCXJCOhHI8yvEvw521f3mIv4+nK83tNSXCXW7ygIC5m8RuAcNf7HadwNB+2fF13oHnYd
X-Gm-Message-State: AOJu0Yxi7raE25heqlGOWvd+j0/pS7yDpDQ2btUK6br4dAJxv4pUChxg
	V0+AY/o3s6kDo8y4E7UtzB3GGjGFAM6ASZwzm93merz1zv8rpZv3
X-Google-Smtp-Source: AGHT+IHgu03nwowrHJ4hNvbD6J9I7GBjKkJAgtAh3gEv1A3EjqvjMjgBEd/bURK64Y93yv+dakE7Rw==
X-Received: by 2002:a17:906:670e:b0:a4a:3b6e:1fa9 with SMTP id a14-20020a170906670e00b00a4a3b6e1fa9mr8425321ejp.15.1712006434693;
        Mon, 01 Apr 2024 14:20:34 -0700 (PDT)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709061d0c00b00a4da28f42f1sm5737881ejh.177.2024.04.01.14.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:20:34 -0700 (PDT)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	anarsoul@gmail.com,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	christian.koenig@amd.com,
	megi@xff.cz,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH 2/2] drm/lima: mask irqs in timeout path before hard reset
Date: Mon,  1 Apr 2024 23:20:02 +0200
Message-ID: <20240401212002.1191549-3-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401212002.1191549-1-nunes.erico@gmail.com>
References: <20240401212002.1191549-1-nunes.erico@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a race condition in which a rendering job might take just long
enough to trigger the drm sched job timeout handler but also still
complete before the hard reset is done by the timeout handler.
This runs into race conditions not expected by the timeout handler.
In some very specific cases it currently may result in a refcount
imbalance on lima_pm_idle, with a stack dump such as:

[10136.669170] WARNING: CPU: 0 PID: 0 at drivers/gpu/drm/lima/lima_devfreq.c:205 lima_devfreq_record_idle+0xa0/0xb0
..
[10136.669459] pc : lima_devfreq_record_idle+0xa0/0xb0
..
[10136.669628] Call trace:
[10136.669634]  lima_devfreq_record_idle+0xa0/0xb0
[10136.669646]  lima_sched_pipe_task_done+0x5c/0xb0
[10136.669656]  lima_gp_irq_handler+0xa8/0x120
[10136.669666]  __handle_irq_event_percpu+0x48/0x160
[10136.669679]  handle_irq_event+0x4c/0xc0

We can prevent that race condition entirely by masking the irqs at the
beginning of the timeout handler, at which point we give up on waiting
for that job entirely.
The irqs will be enabled again at the next hard reset which is already
done as a recovery by the timeout handler.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_sched.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index 66841503a618..bbf3f8feab94 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -430,6 +430,13 @@ static enum drm_gpu_sched_stat lima_sched_timedout_job(struct drm_sched_job *job
 		return DRM_GPU_SCHED_STAT_NOMINAL;
 	}
 
+	/*
+	 * The task might still finish while this timeout handler runs.
+	 * To prevent a race condition on its completion, mask all irqs
+	 * on the running core until the next hard reset completes.
+	 */
+	pipe->task_mask_irq(pipe);
+
 	if (!pipe->error)
 		DRM_ERROR("%s job timeout\n", lima_ip_name(ip));
 
-- 
2.44.0


