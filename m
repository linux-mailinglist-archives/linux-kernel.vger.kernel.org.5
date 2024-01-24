Return-Path: <linux-kernel+bounces-36372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B891E839FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE6B1C26B86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3634C8F1;
	Wed, 24 Jan 2024 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IryTTyXO"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7025C98
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065214; cv=none; b=i0EfzCOXk3SsS1yKd1Uy5U3hMR9hN6XA69/P04qA3WMlNlv+jVAWlGGM9X51URRhhAQOZpJZtN+Gv9dH03/0oJv4ZkKBWL3IRJSTPeyjH/sokTcFnvMq5GJgayWniYUF6bPC/yZnYF3BoEbQTFtCKtTVO2QrjrqbeswB9ZNY+fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065214; c=relaxed/simple;
	bh=CVjjsZ0uumGs6h3s4OXvwxAu5l8bqVGMKkJlDxOzz48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dV6hDrwnq1NDkEy1WU7AJwJCbmscXl5HIyVj+GI3uzrKgKliG09Sl1yBwHx3LoZTgANt3pOkqNOY0Bq/FOj4rEEjGlXIA3yZJSihJTSdUmji0LIHSkhj+bjXhJ6EXZbmsBdHcqQbv6U2+M0mgoFMI0ti7v14mK260E9sRYboMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IryTTyXO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso5581164a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706065211; x=1706670011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZ2AGx4llgOQpbQHqy+lTWRZ3MYwi41F2EIG/DZLPtI=;
        b=IryTTyXOKcvmtZ/HLDzcIzXxh/NPXOSwSXlnGENKTXpqUSSU/U3vVpEG5AaVZxrQcx
         bNqdZbY8iTGSUAn3IbehOmm+ffLqa8nJLxkxiyK47ZMqA173KAyTYeKVW+ILltsC047F
         oARyxMt7IiPSgmjOf8errj30giDwAPPGtZPPqz8TMrikUUuNB9m2fevwavWx8CYMJb1f
         iiZFLPVcyJwI0QzwcCMtCOqlyCdlWBRy1RnEEmqF2tBhxvF+EM6gCiJ8gWiSXD5yG4yA
         eUyBcRCzC1XnjRPlN3nqyjR9YuuqOwX4CI/toED72e02I5ZpJB2eXSjuMt+SiE9wyLcx
         QpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065211; x=1706670011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZ2AGx4llgOQpbQHqy+lTWRZ3MYwi41F2EIG/DZLPtI=;
        b=jtzBpwXaakCYMU4Ug89HKpce4o8VVMNqKfU8Uncr6RhVVTtZjFdQKZoc7+GRFLlBUq
         bZRSTsqs+tQ34epB4jbiYjKEG6lzMjjRn1bXdlc+6ufsuturXE7HTVkD6PnHbtyocyXV
         OO20xQLJqModYt0GX3nfbGYC1V3ncGOmxpQpCkiLQGRiPuBQMsF1Yo0tFM9JIiMStNvO
         ey1dXnh4flOXVQhtzjeHRyiRLN83NX6tZPBgwxycpfDUClqCmGRZnR+Q/JX8Mu1M4URR
         Ps1MLNx69tMTU9dSQ5bEskcnVg9G8Y66Z6o8a/5JLVqpZFqvyfvkDJpVGAg4jiguUIFk
         79xg==
X-Gm-Message-State: AOJu0YxbAhp9P6BRD+w+IRKPEUfOY4lLOmxtk7qbRHkA9LpdsTyCV+zo
	fmeePF7Nj1QMlXwImJmpOK+1LVbvCJJwWKCcr8LIvtN8WeIzfzdT
X-Google-Smtp-Source: AGHT+IFY/xUjRd5C81Nvba31ogUlvGsjSOuyHLhEZHoYYl7MqACrgkHcV+dOKD+vbkGVhH1TYy4G0w==
X-Received: by 2002:a50:ee03:0:b0:559:70d5:5dd9 with SMTP id g3-20020a50ee03000000b0055970d55dd9mr1494752eds.67.1706065211426;
        Tue, 23 Jan 2024 19:00:11 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id dj17-20020a05640231b100b00559bb146ecbsm9637914edb.6.2024.01.23.19.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 19:00:10 -0800 (PST)
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
Subject: [PATCH v2 3/8] drm/lima: set pp bus_stop bit before hard reset
Date: Wed, 24 Jan 2024 03:59:42 +0100
Message-ID: <20240124025947.2110659-4-nunes.erico@gmail.com>
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
Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/lima/lima_pp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_pp.c
index a8f8f63b8295..ac097dd75072 100644
--- a/drivers/gpu/drm/lima/lima_pp.c
+++ b/drivers/gpu/drm/lima/lima_pp.c
@@ -168,6 +168,11 @@ static void lima_pp_write_frame(struct lima_ip *ip, u32 *frame, u32 *wb)
 	}
 }
 
+static int lima_pp_bus_stop_poll(struct lima_ip *ip)
+{
+	return !!(pp_read(LIMA_PP_STATUS) & LIMA_PP_STATUS_BUS_STOPPED);
+}
+
 static int lima_pp_hard_reset_poll(struct lima_ip *ip)
 {
 	pp_write(LIMA_PP_PERF_CNT_0_LIMIT, 0xC01A0000);
@@ -181,6 +186,14 @@ static int lima_pp_hard_reset(struct lima_ip *ip)
 
 	pp_write(LIMA_PP_PERF_CNT_0_LIMIT, 0xC0FFE000);
 	pp_write(LIMA_PP_INT_MASK, 0);
+
+	pp_write(LIMA_PP_CTRL, LIMA_PP_CTRL_STOP_BUS);
+	ret = lima_poll_timeout(ip, lima_pp_bus_stop_poll, 10, 100);
+	if (ret) {
+		dev_err(dev->dev, "pp %s bus stop timeout\n", lima_ip_name(ip));
+		return ret;
+	}
+
 	pp_write(LIMA_PP_CTRL, LIMA_PP_CTRL_FORCE_RESET);
 	ret = lima_poll_timeout(ip, lima_pp_hard_reset_poll, 10, 100);
 	if (ret) {
-- 
2.43.0


