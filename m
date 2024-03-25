Return-Path: <linux-kernel+bounces-118070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAF488B64E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBFDAB2F56E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A11A73527;
	Mon, 25 Mar 2024 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JAYDDz3e"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AF71747
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403823; cv=none; b=mRsvHwZnuJP9sj6C1fNhNdKjjbtmkyM0LaXisbBWYUf4nId9dRyuPO/SSv6FzxhGyjmd3YUCIte7fzRuj3WZRYgpTsC6StcHTwyGnV893IdNjNe0USX0/KHwGusk8zwLO2HKb8XfT09hfGruJMYOwUTywlkitPjmCzNcOL1Qa04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403823; c=relaxed/simple;
	bh=QXZtCnxajIycS0ei9wcpf46OHw52iRlyjFfwysUM+vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smzywLRbKB54my/8w9eKAEf8K/6iKKxVSc0PKzaaIba7GhJQihlq/OJ9C2183ByZohiScljBW5VkLvegvQy1PND0LhPpvmLAB0cAI416fPdOA59lx1ytuOZJYHhgY7wUgN9SUqKfNUvEg5IyY101cQVtXIHswSUkVtrzTJfTu54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JAYDDz3e; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e0eaf81dabso799135ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711403821; x=1712008621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYCN6skM6Cit5WksDlDniZ8/1IrFMtsoAd0yueuyJuk=;
        b=JAYDDz3eDFrsWRKGq2R6r9W0/2O/2KLZQz2ZSUAKa3Oq2qxFWXSQqHiK6915uF0pIw
         S5Q1N1PFqvTBbNxNUmJp8foE2P6VVpzf/yrQ538SbS9lX+NO9Zfs31e6ZXFUHfPwzVIO
         qVzbGh3bzLJNTOXLTUEt+acEAs2cEDlcy2QUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711403821; x=1712008621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYCN6skM6Cit5WksDlDniZ8/1IrFMtsoAd0yueuyJuk=;
        b=G3oD01vTi+3LQSz7CHVl9MzaamCHcmKmrZARfnhUHQwspvQNFfuLGKHygXdnKsaDCz
         fPv5rY7lbpE1nWLiX6CtHbGeVJyri0obVFz/dZj5pbU2r99Iy/6SacfNfqA0EyUX4eR5
         5SyGBGbP7uVW8NcnsaR7t3P0iSLIByBV0fBoQ1vxkE1ZTAUlvi3RPf2MrkF3Opk1i6Ph
         zbXBEgqMlAciuRp1QqDrztEvzYumIAlh1Hieu6F0Q1DTyOSXTDjd7/V2sjC9vuzoW5r6
         0JNAwWFZ7LaNbVNSQXDV9dv9fchfPpZ4z5LqW2M581r8iXQ77gBP9zucf4va1rl+VwFW
         1HwA==
X-Forwarded-Encrypted: i=1; AJvYcCXgWWnkEQEhJjWvrGfuOD7+TzOljGIp1PHyprn2b1f1VoallW7zp2Ey6a87dxnfB1P/mBoT8bzlY9N45zL6K586dKttKSWERrvSPOlj
X-Gm-Message-State: AOJu0Yx3SOwrGGf0nPiKqnxbk4hcS2CG8hJ2W/FbZk6zVrkdXNqF92jp
	vQuzVOC0rVtOnb1/84Pc19VsThhRK8/PnT0ODaRvJcMmtyjDpaWs9jFyjP6+2w==
X-Google-Smtp-Source: AGHT+IEh+en9BRxmGIP3JNI1cG6+0j/qIqp4F0gaYXJA4luV0U4Ir1VjAwt2ENf87iBuWCJ8iqhbqQ==
X-Received: by 2002:a17:903:987:b0:1e0:cd8a:58c with SMTP id mb7-20020a170903098700b001e0cd8a058cmr1285329plb.1.1711403821345;
        Mon, 25 Mar 2024 14:57:01 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:f21b:7dde:93cc:b987])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001def0897284sm5207866plf.76.2024.03.25.14.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 14:57:00 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Pin-yen Lin <treapking@chromium.org>,
	Prahlad Kilambi <prahladk@google.com>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/panel-edp: If we fail to powerup/get EDID, use conservative timings
Date: Mon, 25 Mar 2024 14:56:26 -0700
Message-ID: <20240325145626.2.Ia7a55a9657b0b6aa4644fd497a0bc595a771258c@changeid>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240325215631.3804796-1-dianders@chromium.org>
References: <20240325215631.3804796-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If at boot we fail to power up the eDP panel (most often happens if
the eDP panel never asserts HPD to us) or if we are unable to read the
EDID at bootup to figure out the panel's ID then let's use the
conservative eDP panel powerup/powerdown timings but _not_ fail the
probe.

It might seem strange to _not_ fail the probe in this case since we
were unable to powerup the panel and confirm it's there. However,
there is a reason to do this. Specifically, if we fail to probe the
panel then it really throws the whole display pipeline for loop. Most
DRM subsystems are written so that they wait until all components
(including the panel) have probed before they set everything up. When
the panel doesn't come up then this never happens. As a side effect of
not setting everything up then other display adapters don't get
initialized. As a practical example, I can see that if I open up a
sc7180-trogdor based Chromebook that's using the generic "edp-panel"
and unplug the eDP panel that it causes the _external_ DP monitor not
to function. This is obviously bad because it means that a device with
a dead eDP panel becomes e-waste when it could instead still be given
useful life with an external display.

NOTES:
- When we fail to probe like this, boot is a bit slow because we try
  several times to power the panel up. This doesn't feel horrible
  because it'll eventually work and the retries are known to help
  bring some panels up.
- In the case where we hit the condition of failing to power up, the
  display will likely _never_ have a chance to work again until
  reboot. Once the panel-edp pm_runtime resume function fails it
  doesn't ever seem to retry. This is probably for the best given that
  we don't have any real timing/modes. eDP isn't expected to be
  "hotplugged" so this makes some sense.
- It turns out that this makes panel-edp behave more similarly for
  users of the generic "edp-panel" compatible string and the old fixed
  panel compatible string. With the old fixed panel compatible string
  we don't talk to the panel during probe so we'd actually behave much
  the same way that we'll now behave for the generic "edp-panel".

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-edp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 8a19fea90ddf..607cdd6feda9 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -808,7 +808,10 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 	/* Power the panel on so we can read the EDID */
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
-		dev_err(dev, "Couldn't power on panel to read EDID: %d\n", ret);
+		dev_err(dev,
+			"Couldn't power on panel to ID it; using conservative timings: %d\n",
+			ret);
+		panel_edp_set_conservative_timings(panel, desc);
 		goto exit;
 	}
 
@@ -816,8 +819,8 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 	if (base_block) {
 		panel_id = drm_edid_get_panel_id(base_block);
 	} else {
-		dev_err(dev, "Couldn't identify panel via EDID\n");
-		ret = -EIO;
+		dev_err(dev, "Couldn't read EDID for ID; using conservative timings\n");
+		panel_edp_set_conservative_timings(panel, desc);
 		goto exit;
 	}
 	drm_edid_decode_panel_id(panel_id, vend, &product_id);
@@ -844,12 +847,11 @@ static int generic_edp_panel_probe(struct device *dev, struct panel_edp *panel)
 		desc->delay = *panel->detected_panel->delay;
 	}
 
-	ret = 0;
 exit:
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
-	return ret;
+	return 0;
 }
 
 static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
-- 
2.44.0.396.g6e790dbe36-goog


