Return-Path: <linux-kernel+bounces-168312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 141148BB64E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957AF1F213B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50C8137933;
	Fri,  3 May 2024 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gNeb0pjk"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AE137903
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772296; cv=none; b=PwrukfyYLrtLvzZhT03rvyKBfe3kJZ8pOO8H1T9mR4kuCsI8c8Yv6JOdj0iWOozD3RLOsSQFVx30NAs1fDsKi+bcNHModoJnqvEEyNyRo43olGF6MkcUaqCvpzEomOks5QbX2ALXhlcgJjaaYLgXCe2L9PPBipxIKgG1JI3TWi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772296; c=relaxed/simple;
	bh=bvpX+7DrauxoowAu53h9wDnzFvPQ6Wo3F4LQXvo7Tc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr+ELV6NhSpHSbEACKGK44dJog87JhpXcjzxfTRHRGFDHIj21lJHTNMwt7UB6tfBAAj3ugSpbhHjWEu0EJJ38abOUQHxInPS77PNNXTKo3ScCPwud2iP80RA1zYc3l7nmDRfP92H/MTNosszINxhZGYrTi9TnWe4BMYZCAozd0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gNeb0pjk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4266673bbso1052365ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772294; x=1715377094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekjI+s+uLAWB4kUzVZhMVrRRrlC73fq00flN601bwaM=;
        b=gNeb0pjkTHcQzHrBJ635ULp2Qlm4aYXdrCoabN60QZTi0IJqhBXLAybQFAMh0+RFX/
         ASe9hxqF0o+6BiglGhglu9DNM0juSHsQ2rZdB/16PZxMifm1aGiKKjLB7rjNMFzsiAZ8
         l/Rmk+ro8bTVhWT++hh9A7KlVNlSzSJOwTDSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772294; x=1715377094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekjI+s+uLAWB4kUzVZhMVrRRrlC73fq00flN601bwaM=;
        b=O+e13Sm/RrmRze0DhOmEamL0BYMI8gS99C7oLIB6sJ/ByvnAFJHfuVHHYKOqtAXw7K
         8XJFByWU6T3Rvsbs7we937bqkdp8ky0AvH0Zja/HD2k7etMHA1buMlqD6glcu2qC4+PK
         Zr+m0OHAxl00jYkqOmT7FTe3NlagxbcMY2X236dKSYnCLAPSkAJTzuRabJSEInw4Wx4e
         52iSSUU6iqOsiWlwxzO9wzGJCEaAxFveKa46/wzfypLqNuM3qODDELBKeHvvJIoaBvfV
         FW/3pIJbJshI1ooEx5Tvvv1+axuGiTBiL1fseazLDCnm53Rl86JQSAlxm98wAmmGSI4c
         1I9A==
X-Forwarded-Encrypted: i=1; AJvYcCXD4Hh/z34wvwoYJxAfXSxGPkfEJ7SDxmLJ9qIilQKpgRxK+A5cPWDRcXqcXZSoXsjTe8MRGzCFYWVqjWlV4ftaRIfiM3wX8M0lEGrz
X-Gm-Message-State: AOJu0YwCLmsZKP3hnZ/pHv8KtDowpn47B7jGtEshR7NffvmRwXel6jJi
	e+cyqyk1d56/we+uGO7KJQSntFMif0OUbOWo++86/DC1rGeuhp6Ok1W/7pNolg==
X-Google-Smtp-Source: AGHT+IFguT0/xs4KCtngccJNg5AiVarM5W9ebMgGc4GgQxudEnwAFv+ycO9TzXkPPacW4rwdnnJR0g==
X-Received: by 2002:a17:902:bb17:b0:1e9:470:87e6 with SMTP id im23-20020a170902bb1700b001e9047087e6mr3553894plb.23.1714772294293;
        Fri, 03 May 2024 14:38:14 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:38:13 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 47/48] drm/panel: sony-acx565akm: Don't call disable at remove
Date: Fri,  3 May 2024 14:33:28 -0700
Message-ID: <20240503143327.RFT.v2.47.I2513fd6824929a17c1ccd18a797b98a1a1063559@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240503213441.177109-1-dianders@chromium.org>
References: <20240503213441.177109-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's the responsibility of a correctly written DRM modeset driver to
call drm_atomic_helper_shutdown() at shutdown time and that should be
disabling / unpreparing the panel if needed. Panel drivers shouldn't
be calling these functions themselves.

A recent effort was made to fix as many DRM modeset drivers as
possible [1] [2] [3] and most drivers are fixed now.

A grep through mainline for compatible strings used by this driver
indicates that it is used by TI OMAP boards. The TI OMAP driver
appears to be correctly calling drm_atomic_helper_shutdown() so we can
remove the calls.

[1] https://lore.kernel.org/r/20230901234015.566018-1-dianders@chromium.org
[2] https://lore.kernel.org/r/20230901234202.566951-1-dianders@chromium.org
[3] https://lore.kernel.org/r/20230921192749.1542462-1-dianders@chromium.org

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-sony-acx565akm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sony-acx565akm.c b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
index a9a545a56404..73ba93ff00fe 100644
--- a/drivers/gpu/drm/panel/panel-sony-acx565akm.c
+++ b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
@@ -652,9 +652,6 @@ static void acx565akm_remove(struct spi_device *spi)
 
 	if (lcd->has_bc)
 		acx565akm_backlight_cleanup(lcd);
-
-	drm_panel_disable(&lcd->panel);
-	drm_panel_unprepare(&lcd->panel);
 }
 
 static const struct of_device_id acx565akm_of_match[] = {
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


