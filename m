Return-Path: <linux-kernel+bounces-168282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CAA8BB628
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DC41F20F8C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC78130E4D;
	Fri,  3 May 2024 21:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XQbib2HF"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D0A130E20
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772229; cv=none; b=c4aPRQG3jSPiC6aBlqLoe0IH4yxzqEO1PSzLmz3/eKxcGOSYBrToHWk/MB40bfRu8XgqW2nZG4wqvt/KM6Vn3octFf+irE+fNT0haCWz1mCr/QAkB/P2nAhXQYdJfvQVAqcHcZbgy6OKQRUexMO6nCzYKsF2MsbsbseNmPPF9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772229; c=relaxed/simple;
	bh=r3hVR3bIOaoHmCPi1HOlyW0Sq7NKBMDtJZVIfjucJFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laBCkI6c7X+mCKCd0apYPYQGjTvR9H+eP3t1+Um9HmU7YZiOqmQ4PIazSk2/PUpMIUZY+Td1xxcYaTupZyeoBPa77t3ZvMO0bqSjii+WGuzS90PzJpWQ4KzUfz9PqKfbTy9kZgPKm8+Gkx3YGe+r50+lh0hTVqiKAWAYAylwzik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XQbib2HF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ecff927a45so1151025ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 14:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714772227; x=1715377027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+/1qUyCdCzkVssOOJ1mxYlZquUA9CwegGnK+VEhW+o=;
        b=XQbib2HF7I8X3w4PLUxh7JO9jwaLs+j7O9ZZ1QjWZ8snEC3alv4tjehBVPS2IkqcH+
         O7QHIjCXBf/nXKehm9cyUYSHaQ3OiN1LcP2NQ6k+oSJDTpXq3VVAti4nUJqAhoKAYuj2
         FrQjXfqWwRke5ufMFoMN48jg/y/A2+mdNC3K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772227; x=1715377027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+/1qUyCdCzkVssOOJ1mxYlZquUA9CwegGnK+VEhW+o=;
        b=bvd8cigxgFGLE7lHXVvXY9f7t6grc3+gsedrDCUicStb6DJtP0AAgYGn1BZwoXPfHP
         1KclzIC0kpjucKvPDPWgu/llmtLtHzZqwQbgUqbl+A/kvGc3M9lVRWkFWPF75xkSCvI4
         VihOs7pQPLdyEdC1J1ScydvvB9fwFrcZjuONRjCd5bZvby8pUrqNDSb9RjV/Gwp8+GHN
         H3vUlL0JUsr3aiCFlnGilU2K1BDEQseHU/iJucOg1IquswZD61yvY9WWkhGzcT1GGn2X
         f7O8pk30DAe1RNSoND32nmrubHO/8RzlbH92/sNdMPrkVv7fSzLoXewcx1A+th5g/DwG
         XLDA==
X-Forwarded-Encrypted: i=1; AJvYcCX26UKmfOWwKImNkqu/md/MZXfo/1r3qsGA0pl8WvmxGINCf345jKsarYxCR7YTsDccJ0R8v5KxQcmzlunVpY8W18kH5HnbbXbnf0mw
X-Gm-Message-State: AOJu0YwoTnYWhyjZush9afGqRpXu0v7bG4ZsKRjp3GsJv3jyxkmM9RAZ
	T3ykx1joPxzMjnvuziXRG2TS2+iGC6n5l1PyryzuJVcgVdcvPJKW8DavvzOzJg==
X-Google-Smtp-Source: AGHT+IGTWXuB+YR8b+Za+D7wJjlj72NgkCjkNj7UREApXr3TOavCp/wlhNUfEqh97guBF+8UAksjJg==
X-Received: by 2002:a17:903:2344:b0:1ec:2bca:5aa8 with SMTP id c4-20020a170903234400b001ec2bca5aa8mr5189630plh.6.1714772227116;
        Fri, 03 May 2024 14:37:07 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fb6a:b54b:7580:64f3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001eb51a46f5bsm3729134plh.43.2024.05.03.14.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:37:06 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benni Steini <bennisteinir@gmail.com>,
	Joel Selvaraj <jo@jsfamily.in>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 18/48] drm/panel: novatek-nt36672a: Stop tracking prepared
Date: Fri,  3 May 2024 14:32:59 -0700
Message-ID: <20240503143327.RFT.v2.18.I13a06b9e6f5920659b1e5d12543b3cd9066383b8@changeid>
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

As talked about in commit d2aacaf07395 ("drm/panel: Check for already
prepared/enabled in drm_panel"), we want to remove needless code from
panel drivers that was storing and double-checking the
prepared/enabled state. Even if someone was relying on the
double-check before, that double-check is now in the core and not
needed in individual drivers.

Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Benni Steini <bennisteinir@gmail.com>
Cc: Joel Selvaraj <jo@jsfamily.in>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Only handle 1 panel per patch.
- Split removal of prepared/enabled from handling of remove/shutdown.

 drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
index 3886372415c2..35aace79613a 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
@@ -72,8 +72,6 @@ struct nt36672a_panel {
 	struct regulator_bulk_data supplies[ARRAY_SIZE(nt36672a_regulator_names)];
 
 	struct gpio_desc *reset_gpio;
-
-	bool prepared;
 };
 
 static inline struct nt36672a_panel *to_nt36672a_panel(struct drm_panel *panel)
@@ -119,9 +117,6 @@ static int nt36672a_panel_unprepare(struct drm_panel *panel)
 	struct nt36672a_panel *pinfo = to_nt36672a_panel(panel);
 	int ret;
 
-	if (!pinfo->prepared)
-		return 0;
-
 	/* send off cmds */
 	ret = nt36672a_send_cmds(panel, pinfo->desc->off_cmds,
 				 pinfo->desc->num_off_cmds);
@@ -147,8 +142,6 @@ static int nt36672a_panel_unprepare(struct drm_panel *panel)
 	if (ret < 0)
 		dev_err(panel->dev, "power_off failed ret = %d\n", ret);
 
-	pinfo->prepared = false;
-
 	return ret;
 }
 
@@ -179,9 +172,6 @@ static int nt36672a_panel_prepare(struct drm_panel *panel)
 	struct nt36672a_panel *pinfo = to_nt36672a_panel(panel);
 	int err;
 
-	if (pinfo->prepared)
-		return 0;
-
 	err = nt36672a_panel_power_on(pinfo);
 	if (err < 0)
 		goto poweroff;
@@ -221,8 +211,6 @@ static int nt36672a_panel_prepare(struct drm_panel *panel)
 
 	msleep(120);
 
-	pinfo->prepared = true;
-
 	return 0;
 
 poweroff:
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


