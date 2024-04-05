Return-Path: <linux-kernel+bounces-133255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2BB89A143
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1974A1C237B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DE517165B;
	Fri,  5 Apr 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8QLlFG8"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA617107E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331069; cv=none; b=j5X4P0U2dHIwGfhESHGUsrxPGqwqxkrXAbqGfDH/9iBdQppSNlto9buOV75BIG/xObmr0I2UhuZIDpOYiA+aiqH7kVkHcz15K+z5Nog3YfkPjJXuDx7NEGGijZyku42XwmpQG9t+rg+jvLpkUUbzrGiueF44n4QxkXuC4mFH9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331069; c=relaxed/simple;
	bh=UfcObyrPF0XuVQDFk7S8F4W/87r0ONr3OPfGcZ6NTsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZLYSVwGeX87qr4sN7dfhxEluVSkMC4k34RU0WrQXGdzOHw5sB6iUg0lcw9qnoOvN5d2+gvENcdOz/YiofnWaEdObmJWazNusiAV7MWeMCZYSHuhYfOS5d32PBGEwtfLz3Y1oTsue4qqq5D8swZY/djJQeq2b/yW0kJf+ryJR+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8QLlFG8; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e2b41187aso1852580a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712331065; x=1712935865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Wc7eRrLLTaY9o1kesXYpNbXIiaQ79me6bUkH9C+N8s=;
        b=N8QLlFG87N+yu2RVO4LKcv01H6BAd7Z8uZC3GL2TRMeyO9Ljmt/erl6euhNiem1iFL
         LbEPqdzfk6DgMnZcEMe2qPOHlsgJuuAurZW1n51zdOdGWHzMAtfLDVphm7LPNSrxBTNO
         q2FvTtYlpY7eaOew1mxPV/rOfocuVfPRAfAvAlhLEIQe30nm+sONigVghPUonyMaaBYh
         jnHC83mvMfMw0ER0JM+1SAmnjX4DvQhOKDhwi8VYL7vOCc4rKx6dcFgvA1t8Xugc/Qb0
         MiHgtKUdlGdBEHn3/65QzkL80HyYXIn6CDF9UrwykLZCuETqUuRRDbcUsidEndyKkx9S
         aV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331065; x=1712935865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Wc7eRrLLTaY9o1kesXYpNbXIiaQ79me6bUkH9C+N8s=;
        b=c9702KoIOzd92m83B+1KCACcQV231rs3SnmESFmCjKW4I+vG1avz3NTJ9aztCRNTnv
         +0cOyH0iBrY/N27gcjdyTWWmMmQt8hlJ3SRZ0ClaJWocHWvZfcbOa5py0oQS92tro11w
         dC0Ecj3K4jtCMYhhJTLRT7VFB1tWbkGBctenLxvIfVm1nHOprH/wOpjlHSlUNm6RBkIT
         JHq9eaklN7qLUeILuYhTuImo55YdWvPqDu3YpbjY0vCtMPwvoJHgc99F+/XV+3heuVac
         OKNU64oJ1T10tDMgzGUF8/Jeamp5S6ZmiHhZBbxKSZ1N6h2ypV6lxAz2NXp/W0U697cF
         GtZA==
X-Forwarded-Encrypted: i=1; AJvYcCW2nlAcUgBq//OIRPGSR4MfuofiXUNjnF0ER6lp6B9UPZ2sXtDJnQdK0xyCdSivzw5wJrSmxYusHPQFVyOxO/AIoxMZRpxccqC5y1WT
X-Gm-Message-State: AOJu0YwFqCKl2MHulw6dJ/acz4uKzIlPvlRusUy+1yhan+kDW/bZuDgN
	CjmADMVIQQaJ0PEyBgVjrfiUHGqecYqDCkDnYOwbdx74u5RMXc1ucSZai+YBXL4=
X-Google-Smtp-Source: AGHT+IG8XRGLoAvJSk3V6tIUxHh1MIP1Ubq65h4+cLa/zgO/WLETmMWp1Z1DJ/2HAU/3sW4nJR2XQw==
X-Received: by 2002:a05:6402:e81:b0:56c:292f:84da with SMTP id h1-20020a0564020e8100b0056c292f84damr2264828eda.17.1712331065319;
        Fri, 05 Apr 2024 08:31:05 -0700 (PDT)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id ca19-20020aa7cd73000000b0056dfda8eef3sm906752edb.54.2024.04.05.08.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:31:04 -0700 (PDT)
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
Subject: [PATCH v2 2/3] drm/lima: include pp bcast irq in timeout handler check
Date: Fri,  5 Apr 2024 17:29:50 +0200
Message-ID: <20240405152951.1531555-3-nunes.erico@gmail.com>
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

In commit 53cb55b20208 ("drm/lima: handle spurious timeouts due to high
irq latency") a check was added to detect an unexpectedly high interrupt
latency timeout.
With further investigation it was noted that on Mali-450 the pp bcast
irq may also be a trigger of race conditions against the timeout
handler, so add it to this check too.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_sched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index 00b19adfc888..66841503a618 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -422,6 +422,8 @@ static enum drm_gpu_sched_stat lima_sched_timedout_job(struct drm_sched_job *job
 	 */
 	for (i = 0; i < pipe->num_processor; i++)
 		synchronize_irq(pipe->processor[i]->irq);
+	if (pipe->bcast_processor)
+		synchronize_irq(pipe->bcast_processor->irq);
 
 	if (dma_fence_is_signaled(task->fence)) {
 		DRM_WARN("%s unexpectedly high interrupt latency\n", lima_ip_name(ip));
-- 
2.44.0


