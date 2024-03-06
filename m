Return-Path: <linux-kernel+bounces-94533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BC587411C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF6287131
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B82E1448D9;
	Wed,  6 Mar 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KzNvzn26"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C03140E23
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755443; cv=none; b=tN69KCBM1TG9vMktX198V+H6u8HRXeuiiMYIpsDWoh4Dz2TqLvogbhVZeubwy7mTyDUyTH4SsJBi6ANFaQzX4NnrAFnklKwHmXe7e6N1yH4liKDrt1BYukoha/j+0uZOzRqiehT30j5SPeRh8oKKg/ywfAg/s7SkA8cL6+V7vDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755443; c=relaxed/simple;
	bh=lrGPAvL5ujSKUvsLCktpA1LbY+Wsz6CFM+NUlFd6JMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZce8WDQ0A9KA/2B9TGhocHbx2OCuck/zYrGS8SjYNhh0toty3MN+jVI0eh49Miekaoalmh3BMAvKwqSrxhRt60VJcvIsHKqX3YZNJiVStHNp0QsFtjkYaQj29oeoZ3YyTrk3RE7nlDPsxqdx3GHbVWqw39msKcdy2fwN3Hm3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KzNvzn26; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e5b1c6daa3so105989b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709755441; x=1710360241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5q7RSLprSn1rt1j4rdHGaFDAMNSTGJDra0FF/HsNmOM=;
        b=KzNvzn2651fnj33UhdKQBDgQau8SDv6cqeXWLC5TZGe75lPnEhV2BO5C2N8guL06aq
         GCx/IxBhM3+sFJstVFIPWyYNANdoznaZVsNt2XT4qcFM0WHdGzA+PYuKp59cVn7zrBSP
         fqdxgEuHnhG3nQ8fe6rpJNt8uZ1LDX7hMPxh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755441; x=1710360241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5q7RSLprSn1rt1j4rdHGaFDAMNSTGJDra0FF/HsNmOM=;
        b=KC94ue+B3Zmzabtk4Y5RFB0CpCG5OfUG0wDd5h/VKjGUe2pKoOTkFnI95CJPKf6avz
         pRU3tFvFqAACJmbCA4EnFSd77P92xKRj6mR1x3dpwTYXnZOLzz+hiXShz2/Icq5OQkt/
         5jaL83Y/xlr0fXdoop2rpXkYHVvp8OPSCQqF4i/2grspUYADKfYwMI9Cx3oMXliiV0j4
         4jegrocHgBb9tjBFnS7d76DpBQ4MSzm8oIzCoF3/D/Zpkv5FZXyve8W4lGU0efAVtJxp
         dEYJQBm9JUpD/aVaLW1nBTnMfvQVPBpwlb0X9x7dDrQSSkZ2/y7dKKba2KIAs92EN1Zc
         7LDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvvJ1xDgnGBFlwS8V9Yma6alTn9RQdMySxw9PQG5mosYxqKmXnaC256DB/beWNUcQnWiqH8q+8O4WISrGpndFYfoDrmZz28BXmnm0R
X-Gm-Message-State: AOJu0Yz7PsH2vrINbgxZXePUBzcc3sHhoJTBtxEuiFliIjRAzaxYSM4j
	8z49smHLBlvUMQQAmzp4wTftlQAspkXm1oL80gWLhxgxYlIpHWIZ8TgAyK+B7A==
X-Google-Smtp-Source: AGHT+IEvpr4QV5mPBpt2sxAyZS+vMLVhwGwjJwhB/E1OupG/ADEUdABJiDL7NbFUKKyTsEDER6dy8A==
X-Received: by 2002:a05:6a20:8e09:b0:1a1:4e68:30db with SMTP id y9-20020a056a208e0900b001a14e6830dbmr7188437pzj.12.1709755441698;
        Wed, 06 Mar 2024 12:04:01 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:a215:f6c0:3224:5460])
        by smtp.gmail.com with ESMTPSA id e3-20020aa79803000000b006e5667793d4sm11124241pfl.66.2024.03.06.12.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:04:01 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
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
Subject: [PATCH v5 6/6] drm/panel-edp: Fix AUO 0x405c panel naming and add a variant
Date: Wed,  6 Mar 2024 11:55:56 -0800
Message-ID: <20240306200353.1436198-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240306200353.1436198-1-hsinyi@chromium.org>
References: <20240306200353.1436198-1-hsinyi@chromium.org>
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
v5: no change
---
 drivers/gpu/drm/panel/panel-edp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 772bf6011d79..e3de55314bda 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1009,6 +1009,19 @@ static const struct panel_desc auo_b101ean01 = {
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
@@ -1990,7 +2003,9 @@ static const struct edp_panel_entry edp_panels[] = {
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
2.44.0.278.ge034bb2e1d-goog


