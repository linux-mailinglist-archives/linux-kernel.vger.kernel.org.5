Return-Path: <linux-kernel+bounces-133254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E0E89A142
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C381F21A1A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A3317165A;
	Fri,  5 Apr 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3RtmLph"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A40171090
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331069; cv=none; b=REwbkfG/SCoqjn59Akl2Igjywsk1W3h1JfTSjEJHe8OGjNNZen6x7pX00T6mTKwYoWzsmkYFbEYKDaVH+pzvDL0LwvgnXT/qmyD0zrTwchQuH31WeDSLPCAfZ9pQcnXYGRGXJaRO7pm/yZ5uhoyqammjBkXwdNXDXnMwN5YSRoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331069; c=relaxed/simple;
	bh=2Kt4SH2gGiz91yQulAqzYzGqZughTmXtdSCmlRBjfH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zx/x0ZtfE56EMbP1kDhUhtxhRShm6Y0ie409835RubknYXwrIv7EQF0aYn67J7vz6/r4DugD9t+Gyv/s0krLgPBLxJVYstVFqMnSir93qU1dooGeopdCPmreSj+2jMZqsamc1URFOHTki41Wx9Q92tfhLEXJlkqkDxQGK+Y6KkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3RtmLph; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e37503115so345742a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712331066; x=1712935866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f26+JW8g/Mxdh9BcUQdPk6EFgK15mePlKBpnnLhSmdE=;
        b=Y3RtmLphm9Nnng82H+9/94NnAoLvx3YkqvkXZ7DWJqZAHH4G+ga8KQwHhu6KW1m/u7
         hfVNRV4P6segm1+D9U5jN6NxZCCG+OQN9uEpyTIbxOE2HwGsD5Nf5DwjnK/cfq0yXDa/
         F1nLVciiaevlmxNs3zTPL0Ye+qOknWtEeUTbxmfrGhuWPQwQcfeadbZY3YiyaqfSxl/s
         dAf23sdlmgWaYtTK35X3bW5O/DIKQgPJr6kZhFzWgCKro0h6qbwufr455vG1FcC8GMRi
         Fr1b7musirkOvZmrGn8AVd0jpExaPGUUCIN9P5MG+E62anKKTrdXb16qdYp4wa7bfwEN
         WBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331066; x=1712935866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f26+JW8g/Mxdh9BcUQdPk6EFgK15mePlKBpnnLhSmdE=;
        b=TNPI7sMM9eRdty38K5XBWfqTGUyd9vFiOojC4kiJCu2IXLjCWC00DipH8LEZw7ERIj
         09XhCtTtl3Y7943C0yIeVUrqtxLRBeGWFTnDV5R2OxiRiW8tqEPaFByarEOmLhhGxdMo
         ijsrojolVN+znOW3V+/QCukbljoOeD5aQl+3+DYzwEM8k/ku/ZaKTI7IynOL1NjEPc5b
         z7K6psfsqz8cmmdfP9/1FT2tFg6s1m9LYAPw/rsnbpcZEPiRyrkUWEC4l2lyjVFBqLJm
         D2Azv3F9VqZGUpxAEOLcPQYxaVl2PhLI6odKptR/DjElVGoX8AB1PrMUH25Ww9JdETm1
         BSyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJFqhjngk4lVxRxmOUWNDu20mAi8CiCtPrbcM7H3g5yEM2hc3q2phnUEKnZcfzKr8yC3J9NA3nj23LIDBbBZ8qZLZdOE3kmfiDfBmt
X-Gm-Message-State: AOJu0Yy4raN5zhz/bmYxrtyqZhuqh3sOY+EFFwaNh4KATBnp1jMZq1a9
	K0EnHm9wyz+5OVIhDIx6tAOOVN/RuBHOAoVPoMd/szIvL40DFDmn
X-Google-Smtp-Source: AGHT+IEOoVbeSJ/OSUmQPcHN5mMxTwHjjaoROo5lfs6LhyW4u0ipSb8oGcAGiW5kwuMmalkC8ave+w==
X-Received: by 2002:a50:f60b:0:b0:56c:3feb:8898 with SMTP id c11-20020a50f60b000000b0056c3feb8898mr1359874edn.3.1712331066460;
        Fri, 05 Apr 2024 08:31:06 -0700 (PDT)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id ca19-20020aa7cd73000000b0056dfda8eef3sm906752edb.54.2024.04.05.08.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:31:05 -0700 (PDT)
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
Subject: [PATCH v2 3/3] drm/lima: mask irqs in timeout path before hard reset
Date: Fri,  5 Apr 2024 17:29:51 +0200
Message-ID: <20240405152951.1531555-4-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405152951.1531555-1-nunes.erico@gmail.com>
References: <20240405152951.1531555-1-nunes.erico@gmail.com>
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
Reviewed-by: Qiang Yu <yuq825@gmail.com>
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


