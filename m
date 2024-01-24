Return-Path: <linux-kernel+bounces-36373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A7F839FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B5B28319D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835CCE55E;
	Wed, 24 Jan 2024 03:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/hGtN9j"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C392AD4F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065215; cv=none; b=ER+ctGAGrUaTOXUTi9r0TA7eKfuWK5CcN9oxL06MClLbrh3ke5JFyWVQGtIg0cvsTQRceHkERGXxIG4TEgMKFr1A7fCdhy8fRVpzUc9uUFTi3ZT8wTEnIgrHo9dLFvi8ffOWnBJbSDyUBOIbNEzUxz5aNw5z2CCRzoh1wNjfccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065215; c=relaxed/simple;
	bh=tjzpl8DTYuIIfNlzPxH7Jx6xrDkUHp92OzBp4ixJk0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNKcMmrPk46SxjZcUhQrsr7hMo00pBPjfnI/JJWJfdBGBJgcZFp7leWDkKHeRGlyocsNBjeEpJ4wImjJ24xIE/r67WfBTrBJ2vDSuHbDHrp66b9kLpgSz2w4RNz/aMiRWugi2oOuhAqi754Zvtz1uqru75jMbwEARanX5/ZSQiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/hGtN9j; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eb99a72dcso14183085e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706065212; x=1706670012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsH0t0Mo3703I7xwFyS+NhUyDq/CWLVJL75Yu+tXQAA=;
        b=X/hGtN9jqGEdQHHjl+NgUasnrircYSwZXay74lpXWXjMBzagF4fXnQ1eTqIzY1nijY
         sB13vZTDh167/eVEMWtqADv/CgTlXDflcY92PaIEEcqhX6yzUCvL70ggJPLwU3zAaAAZ
         qleyvDhZ3xy75ojeEtBxF+nqjKS5g2bsYFK7kRk2NGPlnn+nVxvhLDtDq/N3oIL6LFAQ
         adK6Ef9V92kDwPoJBxWusfZMhzsq/8Z4TKAVKWcVI/YVYxRodOJ6G/rzlajwGgXB0c8G
         kchmpPPNx2e/uXJEdRThrh5AxL1bdwMuOp2LAeKxVhwk6yS4gQKj42veTyQJVmZoG6Qd
         LQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065212; x=1706670012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsH0t0Mo3703I7xwFyS+NhUyDq/CWLVJL75Yu+tXQAA=;
        b=MbHotWVg8moO+xTq4vRMFPh2UemYW/0XDejzwB+09vioLBjTAQ5noqZGulsdZdTvSf
         7gDg52gFtxJeC+i4bvHFtSOhb4oUC7ahasY/52fG4r33eLYid6qCJ+Ds+XNnx74+LNqW
         veunGsaADgT9S83xpFvLdg0tAhxqwDmcfaR90580ZZUjTzsBgpERrDh8918bpC62AkIh
         krNergSg4zmjtC8VhMJYPwREh4OGrtRuJCWhI2mq81SBYbFj/rDVlVfABaoBcVKcg4Ac
         cOjeg+ultf2ZE+M6MLOPSolf474rdhYW/voeRnMXPFLXziYa3JdgcH0NADOHvJgIxvEr
         /kPA==
X-Gm-Message-State: AOJu0YzJoEFBlpcsJLuL65A9cH7dhTK3gOGxLUNyWcxNpZez/qL/3mvZ
	FfEIKkcC5FDWncTsnX2Bd6jmXXKC2jlReeVdSnDAdLdC9Li1Hwjy
X-Google-Smtp-Source: AGHT+IG56fGRQ4TmapP4DZAXI1KdXrMXihzbtQnGB0VIMwwJOsKunjx1HQl/TwRycRUsmO8GmBJLiw==
X-Received: by 2002:a05:600c:4214:b0:40e:afa6:5e00 with SMTP id x20-20020a05600c421400b0040eafa65e00mr620087wmh.168.1706065212421;
        Tue, 23 Jan 2024 19:00:12 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id dj17-20020a05640231b100b00559bb146ecbsm9637914edb.6.2024.01.23.19.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 19:00:11 -0800 (PST)
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
Subject: [PATCH v2 4/8] drm/lima: set gp bus_stop bit before hard reset
Date: Wed, 24 Jan 2024 03:59:43 +0100
Message-ID: <20240124025947.2110659-5-nunes.erico@gmail.com>
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

This is required for reliable hard resets. Otherwise, doing a hard reset
while a task is still running (such as a task which is being stopped by
the drm_sched timeout handler) may result in random mmu write timeouts
or lockups which cause the entire gpu to hang.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_gp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_gp.c
index b9a06e701a33..4355fa7b17f4 100644
--- a/drivers/gpu/drm/lima/lima_gp.c
+++ b/drivers/gpu/drm/lima/lima_gp.c
@@ -166,6 +166,11 @@ static void lima_gp_task_run(struct lima_sched_pipe *pipe,
 	gp_write(LIMA_GP_CMD, cmd);
 }
 
+static int lima_gp_bus_stop_poll(struct lima_ip *ip)
+{
+	return !!(gp_read(LIMA_GP_STATUS) & LIMA_GP_STATUS_BUS_STOPPED);
+}
+
 static int lima_gp_hard_reset_poll(struct lima_ip *ip)
 {
 	gp_write(LIMA_GP_PERF_CNT_0_LIMIT, 0xC01A0000);
@@ -179,6 +184,13 @@ static int lima_gp_hard_reset(struct lima_ip *ip)
 
 	gp_write(LIMA_GP_PERF_CNT_0_LIMIT, 0xC0FFE000);
 	gp_write(LIMA_GP_INT_MASK, 0);
+
+	gp_write(LIMA_GP_CMD, LIMA_GP_CMD_STOP_BUS);
+	ret = lima_poll_timeout(ip, lima_gp_bus_stop_poll, 10, 100);
+	if (ret) {
+		dev_err(dev->dev, "%s bus stop timeout\n", lima_ip_name(ip));
+		return ret;
+	}
 	gp_write(LIMA_GP_CMD, LIMA_GP_CMD_RESET);
 	ret = lima_poll_timeout(ip, lima_gp_hard_reset_poll, 10, 100);
 	if (ret) {
-- 
2.43.0


