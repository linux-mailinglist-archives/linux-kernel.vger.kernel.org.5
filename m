Return-Path: <linux-kernel+bounces-36371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15353839FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DD02824BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDD9BE5C;
	Wed, 24 Jan 2024 03:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6OApORt"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49421290A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065213; cv=none; b=Fap8sMjWxzSvlcvTHOlCu3gh577AmYFsaWcje0Y0Nd7B2JoSQC3lWMQwZu2A0voVGEwT5DpcGslJC649k9iHqcHyOIU6aAlvNd9694GW8bS9HvTbsgNBTUWv4T+qbhJIxA54v9lB6Jj6QaQr0TwBect8VKDTHI0zQV+0+SvBp9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065213; c=relaxed/simple;
	bh=J2Ku4zUqtPoQnOkUOB5TlnuoIop2sLljbl7vXV1zRx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVfN5LZoYpQ1iUKIAoE5PszSB4nuj2SCwRqUKWbzme4qSLj/9Z9FY80/dXt2WGDlNGBh5KKwFM8Pbch/rQEPnbbahSbpz6kGCz1KkLVmCps+Ezwl74wVjdFdOfA8XOLN4A6vmOkR9AKp7oSFELO5eNHpigLLBq1EaH8RkK+tstM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6OApORt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso55015285e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706065210; x=1706670010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaTJtCWzAa42d+m/EougaGDz2r//03gZrDKzLfNv26E=;
        b=K6OApORtQ+gK/JgcDY3vT2q2mS0q7L8/imp0FF5pLsrYYGVoeByCy8OOrFWtIfgTQR
         X2hNFhvw94nh9KguHwovLF9GgjfDgKnU43QmtAaf559nkqFABu60z6bnaWdisfiRDyPh
         f+zp4k2R3ao10PJzsEfcBXKZQSyuYRjzdudpqK8uC5XE73Fx5hsfz3kJRNME6x3k4TQN
         4MwXkJ1vi/Ng6iSHKfbdIEYi0sL1aHGdwyDnOvcSMHeGakzXiQfGmDpYtA2NbSY4tdJb
         9PgDAUH5QPg2WXtrn5kAwAB1sc08vc3vUJE6Qv/T0Z9IDwCgHyrVIWlojRH8pvSl4W2f
         S1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065210; x=1706670010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaTJtCWzAa42d+m/EougaGDz2r//03gZrDKzLfNv26E=;
        b=jVgp4n8A/sM+0QEOoOSxHwXYb2xEmvdgOn53C5HXdSW2zOj3ZTeXP94Q46bl3Tf7lz
         s2ksJWNBX/vpRMiPhTFTBcXWUtliAGhoHKWP7BoZXXarmHQBpfRzur9jfHdvRC5Vf/IR
         PTaIeRNAqAR0ZeFXATfyxDEC3/htTLG/OgVBHlhOMr9OqRmffQBEDt0ZcGuSmKTdCcKz
         UcHncGkWdNm/oJmyF+fAUfZH9mEIswpFKGf+IcwBijcVLz4M3VC8tZNHa8paJ1tgSUWR
         pg3PttDqLIrpuvKcu5FrQSxMvTIfXWEzZLD/xvti9Tm4eKogLDq+8TNhc789UA/DrwgT
         AZow==
X-Gm-Message-State: AOJu0YwuBXpWV7qLolaYG2GduprkZq8o3m1G4PjcJMJ2s8i1pTVDk62e
	LKE4rtacpvz+aI6QNmBmCozRW//s+39lGcbn/J+mpzZ1X3Zh1HDp
X-Google-Smtp-Source: AGHT+IFwR+0PHlmlGEWSlXVj5MQPq5ymiWct8wa0quwiQCc/blJhRIrth30UAoMURGBv8vL3XTjvRA==
X-Received: by 2002:a05:600c:5115:b0:40e:b6d0:82d8 with SMTP id o21-20020a05600c511500b0040eb6d082d8mr1030534wms.88.1706065210383;
        Tue, 23 Jan 2024 19:00:10 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id dj17-20020a05640231b100b00559bb146ecbsm9637914edb.6.2024.01.23.19.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 19:00:09 -0800 (PST)
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
Subject: [PATCH v2 2/8] drm/lima: reset async_reset on gp hard reset
Date: Wed, 24 Jan 2024 03:59:41 +0100
Message-ID: <20240124025947.2110659-3-nunes.erico@gmail.com>
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

Lima gp jobs use an async reset to avoid having to wait for the soft
reset right after a job. The soft reset is done at the end of a job and
a reset_complete flag is expected to be set at the next job.
However, in case the user runs into a job timeout from any application,
a hard reset is issued to the hardware. This hard reset clears the
reset_complete flag, which causes an error message to show up before the
next job.
This is probably harmless for the execution but can be very confusing to
debug, as it blames a reset timeout on the next application to submit a
job.
Reset the async_reset flag when doing the hard reset so that we don't
get that message.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_gp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_gp.c
index 8dd501b7a3d0..b9a06e701a33 100644
--- a/drivers/gpu/drm/lima/lima_gp.c
+++ b/drivers/gpu/drm/lima/lima_gp.c
@@ -189,6 +189,13 @@ static int lima_gp_hard_reset(struct lima_ip *ip)
 	gp_write(LIMA_GP_PERF_CNT_0_LIMIT, 0);
 	gp_write(LIMA_GP_INT_CLEAR, LIMA_GP_IRQ_MASK_ALL);
 	gp_write(LIMA_GP_INT_MASK, LIMA_GP_IRQ_MASK_USED);
+
+	/*
+	 * if there was an async soft reset queued,
+	 * don't wait for it in the next job
+	 */
+	ip->data.async_reset = false;
+
 	return 0;
 }
 
-- 
2.43.0


