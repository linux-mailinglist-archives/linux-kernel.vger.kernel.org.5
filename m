Return-Path: <linux-kernel+bounces-28492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EE082FF2B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2CB1C23E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAF9AD4B;
	Wed, 17 Jan 2024 03:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnQvR32z"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10129747C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705461145; cv=none; b=GlNk+8B6p211COcX/TUldP6Q20yzRwOhxnZrSeWRG2bWJBEnKG6YVq0a9xchFftX7eKdC3hduITh7kyj0uubTyY4tao9/9AgeBHBnJMJllAu6+LkVw0MAejR+4RVlLbZHfDT1fu874E0JWuvs6yi3zgrIIhGN/JbScL5euzB3HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705461145; c=relaxed/simple;
	bh=djlcKgyEyqOlS1ZcosV4oA+RPSmY4qGvY5oxUuQxO/A=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=jq37CYr7bkTgIlZ2J2Ir0/gDt+GcDsAcWQTQXvOs6nxajQywgQUGDsodEt6hRqXXM0JtHwmiBfOWKTaSN3A4yEHT32WkwyQOXx4QQlOhcfFZbEHYhFH0haGXjAb3ERoL6baHVUKBpsnEYCabwcV5WYw6GqyQbMy1ieDmA6YgW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnQvR32z; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ccb4adbffbso119606591fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705461142; x=1706065942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADVa6dhhX6uOMOvbI9YDxuD3rJvLmpM0F1zxHrfGnwk=;
        b=RnQvR32zXpuzNZiLFIEX1+08oXZAIkN6jWbD3BDWBjzNJU/GPj1HryAvxUnv4NXsnC
         JugDcJyc9yq6tqjYTW2bmOoyfVBkSF4FxtACFxcUjy9T6bkPX0jULqqGPTzqZcBrrFYY
         TM8llUPOH/lg+r+31oaeK0mERp7Gs/2f109Lso1y8ojg/18rzGbO/c2ka6onpOlrCNr5
         D0xZm9BFidqs+7pm3eSkSxQRr0mn9JI95/PrjL/5Q61bztGaANdrWRCzxUZz3hzPmWlf
         26ZFEi2FPVr9sGQoT59vvnjJINynelT/K2HFUTorc2HSdh7ejVDTl6FQJyWfrS7zdB/i
         olTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705461142; x=1706065942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADVa6dhhX6uOMOvbI9YDxuD3rJvLmpM0F1zxHrfGnwk=;
        b=IBYflR0eMhEJkOoB7fYXqtyZpc55JXyqoCJ1Tp8alKnCWTdLBnBmlSw78mxbehJf7Q
         MUDVpkgGrlU8DcNtKhMT7CCy8I5V5SDzIcsmroJ25rO5x3TMEy23WXFgrqtdgf9nzIPy
         Adqot3ntMjNB/JYptbjL3peYOmn9/dKo1NcO/O3xeBgl5t7vZNmPFCaoQijcxsNKremL
         TF/LPcL2gyiobCtSLmiDVaGCduOiZ6DCqvQxd44/wmxAm0W9+jaHhayd9hpsg9OMWch8
         n+Lmw/lgkBAXEUJAi582hh9g8WYJ0Kr6aSrozs0uZb2TcikhucMBwU+Zrqn7BHSlRqHv
         NBCw==
X-Gm-Message-State: AOJu0YwEQp+EUqHgFlOb2M6Ve8Z9O4yaTogdSxWQSIX9I5QgBZuZiXq6
	nkzx0+jYupZkEXU0OgPVqD0=
X-Google-Smtp-Source: AGHT+IGCAEkQUMLR8zU3CI9B7qiwHLI4EvlgyFIpxwO2sNzIS13NtZgB6xC9DpCIDhBUMxK9jw7ADQ==
X-Received: by 2002:a2e:3a12:0:b0:2cd:fea:65bd with SMTP id h18-20020a2e3a12000000b002cd0fea65bdmr3776646lja.28.1705461142008;
        Tue, 16 Jan 2024 19:12:22 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640204cd00b0055971af7a23sm2258418edw.95.2024.01.16.19.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 19:12:21 -0800 (PST)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: anarsoul@gmail.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	christian.koenig@amd.com,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH v1 3/6] drm/lima: set bus_stop bit before hard reset
Date: Wed, 17 Jan 2024 04:12:09 +0100
Message-ID: <20240117031212.1104034-4-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117031212.1104034-1-nunes.erico@gmail.com>
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
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


