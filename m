Return-Path: <linux-kernel+bounces-36370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD2B839FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0571C26A31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7107B63A8;
	Wed, 24 Jan 2024 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkIFnIGN"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A1A524C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065212; cv=none; b=N2IzPlEsDfkHKlH9ZcRxmIaeHgoljUVCUoc2USWiJukfibkpb6M3pZu1DgU26gEK5zzCGGI7+ExI9iuM6+otgbcbgKiCW2UX/d8dBzb6bSeLkI9aKRCiwHmog4zBjcVVZhChKs/gJnIv7niBaEnGo0vsTEWoSfdrJa3h9JWl1U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065212; c=relaxed/simple;
	bh=WBAYWOzQrbynmcMq5FlSAIF+vKVyihci8yxoGQ6j4w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsE4DAMry/peMyitQTGKg7cjoTP58KZTgZQZEFD+cdjsMyBCQYfhBibTrtUVWnKrP3CUFs6YWpAljkwTSaX8GIVGEaVpB3qJGFoQToC7jK/in0VrFFmNwvkPceuUOueEpicGccuZar7rjFPwRREmwI9l8WkqHUOH4WoXkZR2edk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkIFnIGN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so4567033f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706065209; x=1706670009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lKvsANFUcNVxLXJxZjgiBTj8Zdtr64bBDmNrQ/dGYc=;
        b=DkIFnIGNQDtfNae+yjEMkg7iZZtj7u2TmhVHPZWJAwHA8SpJZD4FvhhjRnOyvsMG/Y
         lONFa96d1POwZD9IypxrjK4d3aiMP4m07E1KIfCsmF8iEI2nVAJW0r4TlOK6THfqAldJ
         zSmz6RGIkz3BKRuHWu35izLVeEleQrSAA5T7eorQ8380FORBqnf/zoi4fVetydQrsSK2
         s9VclITpziQ7/HpWTJjZVH0515gO0x9vcgDy49S5jZogvOEa2u1EvUNQbERJGbqa4PdQ
         rbM0Ta5O/zWUAhjU9HlHVexKQbj7N5yasAQUM8Yd6hb15++gaOQ3+G8TIStouI8JeQsa
         r+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065209; x=1706670009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lKvsANFUcNVxLXJxZjgiBTj8Zdtr64bBDmNrQ/dGYc=;
        b=o9QTAeZOtHwSjLjbbbCBn0cn0x7T3XMB8XWsmqCI2rkt/8z+cViUyzbZUxsaoXDlbm
         QIM0sRDL4doNVyFTPoB/MjRhhl23YkX2TW29/+jEfE0BibxbDq+vNZvXofKBnkmcND2Z
         By+rWX5uuZCX2WMwkFMgsWigE13OVngWym7gLp2IjRsU5ABOwQ0SjvPK6cQZQvpcMLm2
         N/9e3bD2zvztOJxJCBh0dhsrH0dmFKldQOL6VCXrLQ269scB7WoVE0JUQkE9uCl68Xde
         khZ22E4ydH1u2UoEQ0i7Dkhk1fOHFVTzC+50ndaKYmIyrCbPkIikLzzCTcL9QSM+Q9wm
         MEYw==
X-Gm-Message-State: AOJu0YxM0MvuxBk/G0tua7hJtTaCAkmyroKR4RiDINm1dcLZwNK5rrZt
	N5XIA9Oc6dq4wlJSTFqBB72VL9tOhlD6TDw1crjx7NUAMgk58wyg
X-Google-Smtp-Source: AGHT+IFZ8JyJ3TC2xfMqcNV5Q5aHuhj3gsNkRM4/2otX+tMjwjVWKRVsJK9h8YN3NMi+Ch1oqtildg==
X-Received: by 2002:a05:600c:5399:b0:40e:9675:8416 with SMTP id hg25-20020a05600c539900b0040e96758416mr721099wmb.169.1706065209410;
        Tue, 23 Jan 2024 19:00:09 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id dj17-20020a05640231b100b00559bb146ecbsm9637914edb.6.2024.01.23.19.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 19:00:08 -0800 (PST)
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
Subject: [PATCH v2 1/8] drm/lima: reset async_reset on pp hard reset
Date: Wed, 24 Jan 2024 03:59:40 +0100
Message-ID: <20240124025947.2110659-2-nunes.erico@gmail.com>
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

Lima pp jobs use an async reset to avoid having to wait for the soft
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
Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/lima/lima_pp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_pp.c
index a5c95bed08c0..a8f8f63b8295 100644
--- a/drivers/gpu/drm/lima/lima_pp.c
+++ b/drivers/gpu/drm/lima/lima_pp.c
@@ -191,6 +191,13 @@ static int lima_pp_hard_reset(struct lima_ip *ip)
 	pp_write(LIMA_PP_PERF_CNT_0_LIMIT, 0);
 	pp_write(LIMA_PP_INT_CLEAR, LIMA_PP_IRQ_MASK_ALL);
 	pp_write(LIMA_PP_INT_MASK, LIMA_PP_IRQ_MASK_USED);
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


