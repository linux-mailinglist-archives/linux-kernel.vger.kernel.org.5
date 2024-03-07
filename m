Return-Path: <linux-kernel+bounces-96351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E87875ADF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162011C20FE2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71474D5AC;
	Thu,  7 Mar 2024 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LpYD4zuJ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9601D47F6B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709852824; cv=none; b=SFYuME+guFd5Ts6maUY3Br9z87lFW/vC0zur9Vy1xG9Y4/KVSyN1AJMgAabRsa1MzChBAUQi7D/yPj0RI+SprTW66AMAllhwhLB5t4+OUNrtbZKUCMyTUeJSA10K0IbJTVi9BYEBcFE2rSmnKAtiS2De781b8ujyDl/rdR9qZno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709852824; c=relaxed/simple;
	bh=82Xm1OUy3Pwr9GyVUKBDPccvDca/D/PxTSR2Lol/SRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMWBv6/BshadG0uOl6M7+TBRSbVSRSuB5k3uw0zGWlN4wGathy83NadkkXz2NSwxqtM1Xsvf6QCD8UL1NULRJVwbQx5918/tLcMCj2jRs3vo9fm5C/r8y1bC4MN6nlY4MNTCuVZW9CMXO044bvw0sXh9EK/802VzwJX4k3TFAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LpYD4zuJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dd178fc492so9975775ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 15:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709852822; x=1710457622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiUQw1ZTVNc5PMf1jcXsUl5pNMmYncCeRdBmheYnxcM=;
        b=LpYD4zuJjiByG/rlfuvItgBudWRyyB30ePQu1fmCW1xb/Am4LqbJ/YM+DawfNUaoB4
         H7fh0+pxnX1GHieC1Mc8NjVrOGg5BGIb9f5DAgYhYqxS5YlUTvK6GmWlTwTnazNehiGM
         vOmMe/WVZZuJkw4Gqn2RDYe9bLuJCZugTm0I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709852822; x=1710457622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiUQw1ZTVNc5PMf1jcXsUl5pNMmYncCeRdBmheYnxcM=;
        b=Yxa5S3WQGZPQE4CTfpR3oMqWBwg/ip5t1NneCqwndp5zQT6cf7j+1OaDzO7FFl+V66
         w0n9x+ZYPajgZ1mAoAyGFEhuiVf3zE1qHTwwyTa2VOpjTnplQ0BbIRkOmp1SUirryWML
         DemAn/seTnIW2HsmFPo6AgXOQCkKAvbFGiTnfwU6pLgUnq1ecIsSixUD3t4Q6hr8efmx
         B8Vj/vENEbDfCHJFCajtx9xjN+jU4XyMio0nB8pKRU8HQaKwHsEd39XHEdTb+o7lnmhB
         k9N5iqJfj+W9YX4CLfnoOdmpSlNKhMprf2yaFvhiWWY8TCkOsTh3VP7mjuMVFNhvY6Om
         boag==
X-Forwarded-Encrypted: i=1; AJvYcCVGRfVBVcMLvP4qPSpv/9DRbroThfU5YvkUhOwsMPC/U2BSEPlEQrv9jhxN+iaawkLCbnNqkWVgLsUYX1oer7n0+nUZP6emU/Nqt9aV
X-Gm-Message-State: AOJu0YxgDLrS4+HR2QnjqIMe8D4Qb8+9elET7TJQxGiwK1TCpODmL46G
	0sQKbYfrqaxoayVxklCRAqGaoaX5elfcUZv8r6Pu2m0vBlV+H9pRCc/Oasc16w==
X-Google-Smtp-Source: AGHT+IHoYt0E9CsIcSAwhLVXdVdiYr8vP/Y4N6g58/0g0X9YeIdqoKrM/CVpefcc0EVSlKAUOt/Mmg==
X-Received: by 2002:a17:902:f690:b0:1dd:46ca:be1 with SMTP id l16-20020a170902f69000b001dd46ca0be1mr4634856plg.55.1709852821963;
        Thu, 07 Mar 2024 15:07:01 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:bf8f:10d4:f877:bee3])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f2d300b001db63cfe07dsm15196654plc.283.2024.03.07.15.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 15:07:01 -0800 (PST)
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
Subject: [PATCH v6 5/5] drm/panel-edp: Fix AUO 0x405c panel naming and add a variant
Date: Thu,  7 Mar 2024 14:57:45 -0800
Message-ID: <20240307230653.1807557-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
In-Reply-To: <20240307230653.1807557-1-hsinyi@chromium.org>
References: <20240307230653.1807557-1-hsinyi@chromium.org>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
v5->v6: remove trailing white space.
---
 drivers/gpu/drm/panel/panel-edp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 7f749b17df85..c7f81dd9023f 100644
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
+	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0",
+			 &auo_b116xa3_mode),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x435c, &delay_200_500_e50, "Unknown"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
-- 
2.44.0.278.ge034bb2e1d-goog


