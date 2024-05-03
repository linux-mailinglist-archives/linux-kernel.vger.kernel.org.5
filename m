Return-Path: <linux-kernel+bounces-168313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E898BB650
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252561F23FFA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1FA137C26;
	Fri,  3 May 2024 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nlNk1Alg"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895913793F
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772300; cv=none; b=TBM0GwwGsFpss642XpXQVgkQLexrkwtyQNoI7UAcNryQ0OYhoT+8wae0ldOwUSjDsiHQNgo55xizUmdkWGRrFha6to+mxsOfQKiflC9ZykFagCOd7031is7ZPPysArHN52xwcFaYh/yqOkoeNaw0SehuLVTkRl+GNU9UraV0I9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772300; c=relaxed/simple;
	bh=EaWtWEnAFoVYQQ7NdwPJMqMdWOvHRnxTyipd/TFLpqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlUaUhfS2QxvrvxMaw8ES0PsthHizPjQKIHP950OtONxv9mnmCpWRgnDZKmSNovJrTJlmT0yNP6mxUFcjQz3eAY60Hpz9oFFlAPgdxs/zwVD5CHcmA0SmvWyPHsyCZrbxFwUyNKlAB64+DeYURsKA/Bo2Q1IUGl6/E4QxZ/WOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nlNk1Alg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b27c660174so132440a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772297; x=1715377097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkS+rg5OKiFoHCGrecPUpnEeRZJMeWyJ+snKafgy5vs=;
        b=nlNk1Alg9L0OtkB8zxq3JA6tAKSLOHp6f15vm5koUH9FP5DyEm6Dg6BXgAdntsrdWi
         avR5+u0SMT8Tl9+KVjdPN1txM+DeSEUVl1q4siPnjm0p5NGFVgm+Fpm/Zu3UQO6kvwDW
         1g8heKyPmEo6JvdjTVzP0b5+CbBvPte2wS4lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772297; x=1715377097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkS+rg5OKiFoHCGrecPUpnEeRZJMeWyJ+snKafgy5vs=;
        b=FOGW2LQNmWdJx7YAVpfV/GEbiGPxFVmhTe2PcM1iMFg6EszADJ5Slx1MMFXN1etwDl
         uSXIMnk3DV+UTJhFW9fD/hE5oT/OYg8rLkxDCu30ApL5+iYQTBTvo+eTWjPLRL4JoiWW
         UDJfnd68dti+aYoiFFSIApA5M14bfXUYu6piLOZfdY2vJ+CT++vbMsSiHgYUZZZr9AKq
         uNVQXTMDgJ2BPY8bVcmqNtlzz6lyznydCasv3Oj9AlBHUhpcGawKhKFyzqhuCrfCyLpQ
         AexZwtqUirKO/RLXPtXpVOlWJpiiGgXB1IRDS0RNTHF6S8yUbfDBBfSJpMcYn+Yx9y9p
         sHcw==
X-Forwarded-Encrypted: i=1; AJvYcCW4a8Kla4/Z8txnulw6BfuQsqI19fPtT7vkV0ST/Iw9NoM5V8RhF32cMPj0N3+i1/XKXDAZZonBYSggzyqmoOLWUL8SapYtgoBoi8sG
X-Gm-Message-State: AOJu0YwyrAGcgsEmQONJU8FTOY+JZVPcCeIio2TiDOo7gKSkzmmQiUCT
	t5J86U7anjB6I1pyXLKDLyvgGkr5iOV8cRJmXvr3cOi7ITGEV92MLcCikfk5HA==
X-Google-Smtp-Source: AGHT+IHkW28tWyRIV7NmgOtGvUD0tFuJ+wrkeXjluxHwAroLQKxUR2uvyN5Qr5JmQy9q9YdYC6JW1Q==
X-Received: by 2002:a17:90a:6081:b0:2a2:8ed7:da34 with SMTP id z1-20020a17090a608100b002a28ed7da34mr3992252pji.1.1714772297001;
        Fri, 03 May 2024 14:38:17 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:38:16 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 48/48] drm/panel: Update TODO list item for cleaning up prepared/enabled tracking
Date: Fri,  3 May 2024 14:33:29 -0700
Message-ID: <20240503143327.RFT.v2.48.I104cdece7324b0c365e552a17f9883414ffaea01@changeid>
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

Now that most panels have been updated not to track/double-check their
prepared/enabled state update the TODO with next steps.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v1)

 Documentation/gpu/todo.rst | 47 +++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index e2a0585915b3..4063bc45bbd3 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -469,30 +469,35 @@ Contact: Thomas Zimmermann <tzimmermann@suse.de>
 
 Level: Starter
 
-Clean up checks for already prepared/enabled in panels
-------------------------------------------------------
-
-In a whole pile of panel drivers, we have code to make the
-prepare/unprepare/enable/disable callbacks behave as no-ops if they've already
-been called. To get some idea of the duplicated code, try::
-
-  git grep 'if.*>prepared' -- drivers/gpu/drm/panel
-  git grep 'if.*>enabled' -- drivers/gpu/drm/panel
-
-In the patch ("drm/panel: Check for already prepared/enabled in drm_panel")
-we've moved this check to the core. Now we can most definitely remove the
-check from the individual panels and save a pile of code.
-
-In adition to removing the check from the individual panels, it is believed
-that even the core shouldn't need this check and that should be considered
-an error if other code ever relies on this check. The check in the core
-currently prints a warning whenever something is relying on this check with
-dev_warn(). After a little while, we likely want to promote this to a
-WARN(1) to help encourage folks not to rely on this behavior.
+Remove disable/unprepare in remove/shutdown in panel-simple and panel-edp
+-------------------------------------------------------------------------
+
+As of commit d2aacaf07395 ("drm/panel: Check for already prepared/enabled in
+drm_panel"), we have a check in the drm_panel core to make sure nobody
+double-calls prepare/enable/disable/unprepare. Eventually that should probably
+be turned into a WARN_ON() or somehow made louder, but right now we actually
+expect it to trigger and so we don't want it to be too loud.
+
+Specifically, that warning will trigger for panel-edp and panel-simple at
+shutdown time because those panels hardcode a call to drm_panel_disable()
+and drm_panel_unprepare() at shutdown and remove time that they call regardless
+of panel state. On systems with a properly coded DRM modeset driver that
+calls drm_atomic_helper_shutdown() this is pretty much guaranteed to cause
+the warning to fire.
+
+Unfortunately we can't safely remove the calls in panel-edp and panel-simple
+until we're sure that all DRM modeset drivers that are used with those panels
+properly call drm_atomic_helper_shutdown(). This TODO item is to validate
+that all DRM modeset drivers used with panel-edp and panel-simple properly
+call drm_atomic_helper_shutdown() and then remove the calls to
+disable/unprepare from those panels. Alternatively, this TODO item could be
+removed by convincing stakeholders that those calls are fine and downgrading
+the error message in drm_panel_disable() / drm_panel_unprepare() to a
+debug-level message.
 
 Contact: Douglas Anderson <dianders@chromium.org>
 
-Level: Starter/Intermediate
+Level: Intermediate
 
 
 Core refactorings
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


