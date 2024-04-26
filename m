Return-Path: <linux-kernel+bounces-160790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B698D8B42EC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1097F284474
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E033E470;
	Fri, 26 Apr 2024 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OfM7t9HQ"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B87D3BBF7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175948; cv=none; b=j33qkRLJKy7zopBr8o3RgRMTewxcx6F6VBdOoQiREfz/ocXteVMf7LZTpmOUSvemaOwK/98bAQxMY5Re3dLgVJnhku+7SAefmTzN2l6W+fIqf9wz3GPeqauyuWFs+gi/2mUImvHti+hSp62zQYMWw3/x7t1vywSHEqwn3pWV/H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175948; c=relaxed/simple;
	bh=pjcvWuzCy6xoTHSAqk88pHgPJcX+90n8EGDGZPTH4b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO6HohEpUU41zY113e31wIjdUgNy2qfYIh5/gwbn1PtAc7uz/0XE4avZ0JqufsDzynbZjKKNnRomGBTXXt/pZwCX4EaGMjvltHA9Tv4i9w7fNYFOI2i4IbPtdvGloe54bDy7YOTIAxCO9iLz3ejEkLsGdL/z8zTSJdqh8I6E5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OfM7t9HQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a55a3d0b8eso1991360a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714175947; x=1714780747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeW0pSyEBhS0ojeIyWBVzu7M8GLRFtARAotr9ut3TYg=;
        b=OfM7t9HQDyxMxmzxmHClkOP4Ik3WvzSl/qFYsmNQ9h3prM4oFE92pn9IXX6zncuerK
         FkFEiv3lGxHy6IP/dey0qeYuVDcOcwgs0nNg9FSbPKDZmsuOkroyyMhKj4nedA8k0LkS
         xB83gCpr38MThJStJw/PneomVQw9OIceVTFWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714175947; x=1714780747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeW0pSyEBhS0ojeIyWBVzu7M8GLRFtARAotr9ut3TYg=;
        b=lHoebaq681A09aKjWFcnGk0CMU4r2QDnEB8fsgL2q0UT4oic0U1sPGbLT0ltudCXBh
         /HW4blA80idguWaCZ9H1n727ZvarDNzOnwE1Z+6OvNFKOLNxCikZUgdpsKDG1fqi1dfv
         j3t3G3qwkVH5aHR+C0bdTvxcalh7LxZ1lG/WXK55VYLwQ/FdLBrsJitDQwbIrnX92elr
         Qo2gXzfMPzIv8hXlLCJM/n8JvZeFTxHuVtr8HPlgV6DehgXZGDVe5aMQ/TzE++253B4O
         mFVWwz9J9E+mDnbdBJRofRH8jw7L2VI+Yk6ugywvA1q/rM939V9v2mbKNImLb/YlWXQH
         wUKw==
X-Forwarded-Encrypted: i=1; AJvYcCXONRyeOnYudwAsi4cWuDvlffw+qLryIRMMqmSPK8cNdQjGRq+A/AsZGiqxe8ILYBXfNSZ5Sxu0AlowFS7ZSe/GuPW1VvKCgSH4yyUZ
X-Gm-Message-State: AOJu0YyftyR7B3IVRfXbyaE5tm+/1TDeM+cMGXrAB6AicyTy5L/2ywnt
	wam0vw3P+AoEmfk6V5IC1yAujWjTTMt9UCPrXIqnQfeI8kvWNUP0N5k0HqOL3g==
X-Google-Smtp-Source: AGHT+IH6XTJ9QQDWPzgo8X8I8bDLXm7/WGqdQG4aZWPTMylSuC2+pMH0ddw57O7ZuDywVmWBbG/TSg==
X-Received: by 2002:a17:90a:1f88:b0:2aa:8130:e3eb with SMTP id x8-20020a17090a1f8800b002aa8130e3ebmr1501128pja.11.1714175946787;
        Fri, 26 Apr 2024 16:59:06 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fca:3ae2:20e6:82bb])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090aab8400b002af41bd563esm5111939pjq.33.2024.04.26.16.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 16:59:06 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	lvzhaoxiong@huaqin.corp-partner.google.com,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Hsin-Yi Wang <hsinyi@google.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Joel Selvaraj <jo@jsfamily.in>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_dcs_write_seq()
Date: Fri, 26 Apr 2024 16:58:34 -0700
Message-ID: <20240426165839.v2.1.I30fa4c8348ea316c886ef8a522a52fed617f930d@changeid>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240426235857.3870424-1-dianders@chromium.org>
References: <20240426235857.3870424-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mipi_dsi_dcs_write_seq() macro makes a call to
mipi_dsi_dcs_write_buffer() which returns a type ssize_t. The macro
then stores it in an int and checks to see if it's negative. This
could theoretically be a problem if "ssize_t" is larger than "int".

To see the issue, imagine that "ssize_t" is 32-bits and "int" is
16-bits, you could see a problem if there was some code out there that
looked like:

  mipi_dsi_dcs_write_seq(dsi, cmd, <32767 bytes as arguments>);

..since we'd get back that 32768 bytes were transferred and 32768
stored in a 16-bit int would look negative.

Though there are no callsites where we'd actually hit this (even if
"int" was only 16-bit), it's cleaner to make the types match so let's
fix it.

Fixes: 2a9e9daf7523 ("drm/mipi-dsi: Introduce mipi_dsi_dcs_write_seq macro")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- New

 include/drm/drm_mipi_dsi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 82b1cc434ea3..b3576be22bfa 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -337,12 +337,12 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
 	do {                                                               \
 		static const u8 d[] = { cmd, seq };                        \
 		struct device *dev = &dsi->dev;                            \
-		int ret;                                                   \
+		ssize_t ret;                                               \
 		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));    \
 		if (ret < 0) {                                             \
 			dev_err_ratelimited(                               \
 				dev, "sending command %#02x failed: %d\n", \
-				cmd, ret);                                 \
+				cmd, (int)ret);                            \
 			return ret;                                        \
 		}                                                          \
 	} while (0)
-- 
2.44.0.769.g3c40516874-goog


