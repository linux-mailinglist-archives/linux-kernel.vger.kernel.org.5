Return-Path: <linux-kernel+bounces-7497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9B281A8E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC045B22F18
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14384AF80;
	Wed, 20 Dec 2023 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kf1WrFjb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4914AF66
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3ac87553bso1683415ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703110471; x=1703715271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZD3VpyHhC0C+pwwNEc0NgWoPlzlh6lpsOAPY3FHREss=;
        b=Kf1WrFjb1PqpB9MFOq9VrDarI1CznPtHkhB1SJO3zDbPKNTLdtRHcWBlwjwmE1eV4j
         +z8xHDxSsXZv+17LAUzkI48jbdM52Vhos4B6tYPdi6GEiOgkrtPxWdfxBzdCt3fbHZc1
         hR2F779yiEhsalGWFiKM8LxsNECs1Kt8mWusE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703110471; x=1703715271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZD3VpyHhC0C+pwwNEc0NgWoPlzlh6lpsOAPY3FHREss=;
        b=cMWn8LZMmSbBoTskxP8Tdy9sQZYgoBsZdWAc4+3odcYsKtscUyTxgxa9azOmuziHBV
         MdmYi+dgLAZfv4ftoSojWZbewdF9BahVmOPPFNifFnzEG998S43kUJgtFlp5xl0g8QOn
         GToEYJSh5v/N2eg7jUlPIhrtviPp1k5sBMyQUeLn/aTLCu/MyKFuNR/SfiPEsJUQRdSL
         rw8fX3IBWRNz/iVe2DuBStdkm8/NtM7JLs0bZr+VJUXRzLtwrXqZGIVsLx68W8e7P76c
         xHgc8Uhn8pJhlQNLCBroFaaFjxud4QspsqF10yAMFada4+MSd36ocdXkgTgJ5BwLUd2X
         sDoA==
X-Gm-Message-State: AOJu0Yx2Ok1z61/dpkdATycdOhrKr8XNbBi2ao+6dXhDBW/nsWg29kQ9
	k0zLcIhAaeRcb/26Wsom5MoAeg==
X-Google-Smtp-Source: AGHT+IE49xQhoPUy1M+E8LWgCI2XEpW3zeBU1Pxn4Yw80hEdINh2bomR+e06vtYbgIK0Lmg8RUeSPA==
X-Received: by 2002:a17:903:1cc:b0:1d3:5f99:17df with SMTP id e12-20020a17090301cc00b001d35f9917dfmr8812369plh.38.1703110471046;
        Wed, 20 Dec 2023 14:14:31 -0800 (PST)
Received: from hsinyi.sjc.corp.google.com ([2620:15c:9d:2:8e1f:dd12:809:b2c8])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902aa8e00b001bf52834696sm203086plr.207.2023.12.20.14.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:14:30 -0800 (PST)
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
	Linus Walleij <linus.walleij@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-edp: use put_sync in unprepare
Date: Wed, 20 Dec 2023 14:13:11 -0800
Message-ID: <20231220221418.2610185-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some edp panel requires T10 (Delay from end of valid video data transmitted
by the Source device to power-off) less than 500ms. Using autosuspend with
delay set as 1000 violates this requirement.

Use put_sync_suspend in unprepare to meet the spec. For other cases (such
as getting EDID), it still uses autosuspend.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Fixes: 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of panel-simple")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index cd05c76868e3..7d556b1bfa82 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -429,8 +429,7 @@ static int panel_edp_unprepare(struct drm_panel *panel)
 	if (!p->prepared)
 		return 0;
 
-	pm_runtime_mark_last_busy(panel->dev);
-	ret = pm_runtime_put_autosuspend(panel->dev);
+	ret = pm_runtime_put_sync_suspend(panel->dev);
 	if (ret < 0)
 		return ret;
 	p->prepared = false;
-- 
2.43.0.472.g3155946c3a-goog


