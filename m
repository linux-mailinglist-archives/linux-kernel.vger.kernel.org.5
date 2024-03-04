Return-Path: <linux-kernel+bounces-91194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAA0870B0B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977DA287C91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2817BAFB;
	Mon,  4 Mar 2024 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SiHLQ+YM"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104137AE47
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581943; cv=none; b=dm6RsBiT3xs6c2J5746uloJt+MP5UW89rzNxlUo1im4k2RvX/hYJtgbd23RoyE/XCKxxWoDBqlBSMTves4xNqZCDyV8552X4+hZwpPLAdJAkCN9O2E9TWGNcTUgGEC8XnP/If1M7pvryjm/PaqKTxgGtRkLZeShQmHp+G2j/5fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581943; c=relaxed/simple;
	bh=8OuDlLGurFFp9VxyciJz45RtYgLMl6l5MFaKGdW8p1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=da//bk7k4IcisUIu2PaLBvRnNCILer/RhiHit80i7ddqnwlVzYPdMGC0lTOjF2ERKceyFuYZLk98JDOt9j3GbfsO4bVxQ0dQMxK2bTPyRVGI06dMDxxcAGgfOZaWI/mi7AWwkFggXRv3R4RLijR2pfMMXndMltG4BrGty+nE7QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SiHLQ+YM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e56d594b31so2547827b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 11:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709581941; x=1710186741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMSlD4D61SNUMtl55lAIMxqBblJYN3jwwZ/l0KMGCh0=;
        b=SiHLQ+YMyChL5yT9Cus6F9bysVDRaojtjFLsZkD7hHiRIM5K+k0SZDrFCiSSBcS5Ue
         8zqbSfdi/SXAOMOQCQHBbYukohUOwGtf+J4UpO9Gktj3jI4zFkECaRVclHV6iFkcpTi0
         4PFDgzWA36YpOtv0OdQpxGhpuqftK9uhEUY90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581941; x=1710186741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMSlD4D61SNUMtl55lAIMxqBblJYN3jwwZ/l0KMGCh0=;
        b=c7Q1kN92xMjiHpV0E9dusUhkbHk1ZemvqKAusX+WwqfJTHfO11qlYAEkKhCN6gWRlJ
         di5GT7fHKBqUmihCRk20awMznx1xyCMs8CU3NDzEUdMTucUOgjXCnFcf7hfbeMu1lnWJ
         tb0AGrqVXKAoIKXt4F3xzWIW0ycircn1yj1iu5CDH5IYmPniTOnmblo4QLaj8FO/F+Ln
         tGLzxiGvuCeE35cD8MRQ74FLKbBa6ogEXbgk7uOdwERm4lJLRuaKfR+q/tzimROatHF2
         F8Ra+gatElsN9aPS2ZyjQmlIIwH4yBo09BfhcPVrzpB/QNSOYDoKFpFklnUoZ4J8KLKS
         Mdhw==
X-Forwarded-Encrypted: i=1; AJvYcCUscnrlG9kIpqJkKJvSGHsI3tYJ+0Nbe0Xd2UwJcyxOJI1YmOsp9pqhJotf1ItHAPuDzEgmmgMiXF4Hx0buGZWLejzYOiHslfA8cq+z
X-Gm-Message-State: AOJu0Yxc3Dnm44mSpjHtuhz01KLqLjCgrw1wTIv3+LucU4uBR/04eTJ8
	qnsoUMKDQYJTwRXB2g9SndQWLvETK2vl/V2OTIng2vOePxMyW2G6oLAHp4owqg==
X-Google-Smtp-Source: AGHT+IHPtFpxTAyxqYpM+QvUFmcFVeN7dHU0wEyqkEdqd7zuA4ef1jTJ4eEAL4kK24nK/EHKqXAQdw==
X-Received: by 2002:a05:6a20:e11a:b0:1a1:4d8b:8cf9 with SMTP id kr26-20020a056a20e11a00b001a14d8b8cf9mr1728648pzb.11.1709581941402;
        Mon, 04 Mar 2024 11:52:21 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:bcf3:25da:25cd:199])
        by smtp.gmail.com with ESMTPSA id r27-20020aa7845b000000b006e04d2be954sm7600820pfn.187.2024.03.04.11.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:52:21 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] drm/panel: panel-edp: Fix AUO 0x405c panel naming and add a variant
Date: Mon,  4 Mar 2024 11:44:59 -0800
Message-ID: <20240304195214.14563-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240304195214.14563-1-hsinyi@chromium.org>
References: <20240304195214.14563-1-hsinyi@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 2 different AUO panels using the same panel id. One of the
variants requires using overridden modes to resolve glitching issue as
described in commit 70e0d5550f5c ("drm/panel-edp: Add auo_b116xa3_mode").
Other variants should use the modes parsed from EDID.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v2->v3: no change.
---
 drivers/gpu/drm/panel/panel-edp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index e3044e34c5f8..d2e181efff98 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1011,6 +1011,19 @@ static const struct panel_desc auo_b101ean01 = {
 	},
 };
 
+static const struct drm_display_mode auo_b116xa3_mode = {
+	.clock = 70589,
+	.hdisplay = 1366,
+	.hsync_start = 1366 + 40,
+	.hsync_end = 1366 + 40 + 40,
+	.htotal = 1366 + 40 + 40 + 32,
+	.vdisplay = 768,
+	.vsync_start = 768 + 10,
+	.vsync_end = 768 + 10 + 12,
+	.vtotal = 768 + 10 + 12 + 6,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
 static const struct drm_display_mode auo_b116xak01_mode = {
 	.clock = 69300,
 	.hdisplay = 1366,
@@ -1966,7 +1979,9 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B116XAN06.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B116XTN02.5"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B140HAN04.0"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAN04.0"),
+	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0 ",
+			 &auo_b116xa3_mode),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x435c, &delay_200_500_e50, "Unknown"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
-- 
2.44.0.rc1.240.g4c46232300-goog


