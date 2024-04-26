Return-Path: <linux-kernel+bounces-160791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC998B42F1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32731C21ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE74640854;
	Fri, 26 Apr 2024 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WZIFEwFN"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECB33E49E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175951; cv=none; b=LfVyXvxafDUFPCd7uKKpDvTfZQMD9vSbOABUpdWOE7pBJ9tcjff2IHdEsfsrOmNleQ9wb9sFvvR/5KvA93RPOSeVQ0pbhBAuW0rFyRMkSx1K8jGlr77g6Z/xzFvfwEeZ5mJIvagjMPSeYvLk23TELrTAxrJTghHmjIQtJx8Zbn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175951; c=relaxed/simple;
	bh=WqPuE563UwzkUYg+A+e/tOkF12emw0r8vHcGZy9u70I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8ysSgmgn+1sgumy7kNN8pDsBOvQyaxyMEG1/+ntzWw5ZWTNJpUYqKt304N0G3Ik6sw+10yJ5J7pKjw3X5FNfhiHwjlytw38PaE0RJ0ACvEcs6A+zOpjJRqACum3pcs75slKgLlQnhz0i3B0+ovQPszEemoeTvZpQ8kPf7LFB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WZIFEwFN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2abf9305afcso2011220a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714175949; x=1714780749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qxb7o7HPo8viKRZLe9p4BQ5iqFreL178XpJGb/dU1Y=;
        b=WZIFEwFNOliVwUKSJMy/cBtv09XIqNAJQsXZQT6FCLWtv2ZbkpmcW+knTdt2NZojuh
         8k7OsysNboGGnrrHCPrTppWgi41/B4QkqztVmdABCyn1w4+zA5cMzSAp6vHL30x3sdND
         nqn43T4N+mnGaIfTZhliA4PEFUI+coxVy7c0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714175949; x=1714780749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qxb7o7HPo8viKRZLe9p4BQ5iqFreL178XpJGb/dU1Y=;
        b=ljxN8SH02YIWs/7ER9/5colTVXqZwSC/fidLFifa+lO87aYD5QMTyPA2xSyv76Rjih
         A7oyJt3PJ7f0F8VJHNvpwBoHR4R+Hq0JyutVjCjF6/3dXp3l0s248NV+Dmds2Ee6HtB4
         jWUJtpaRNg6rQs99jfCMX0g0XPkWG5M+B8liCaZDuDs8BqTMwpiY2mYQypPnXJ0iiTZr
         ceVssMcQqkgMNj0jK4Q5hynl2OUBGRnbuvfX5HExKtLBWF7WmBuKc3VAgjkLwTR6XDua
         zlckvMfg9hFunjhm29B8GK7oUx9QckUWi7gSUk2S8Q71H4pmO+8u4LvtI5nUtDDLPUeV
         zyWg==
X-Forwarded-Encrypted: i=1; AJvYcCU5yP7KdlgTK4T1Cx6TW2VHPR9NLdT2VrVofhvmwCxMaupErrpGSTnaKt8jYF9UI1cChwIdv4PC/HqWLpR7f2jhO9ldHkpX8JC4mS+K
X-Gm-Message-State: AOJu0YxtX64IemZJjqPnD2bUCFfYvTZ5NP2inzGE0M2KmUalylGjH+1c
	RWxsfyLKeE4AvyQufMkYCij3kuzVsIFDSi1zJkUx8OTy2ZsCCCUJdmgFufP/Lg==
X-Google-Smtp-Source: AGHT+IFdpJhiAC1+tnidCuTWvB9wh2OGWr9Jkzg34ey8UBJO1FSWr0ht1iKJrR93nvquMsaf0LtUPg==
X-Received: by 2002:a17:90a:af83:b0:2a5:733c:3105 with SMTP id w3-20020a17090aaf8300b002a5733c3105mr1149099pjq.26.1714175949151;
        Fri, 26 Apr 2024 16:59:09 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fca:3ae2:20e6:82bb])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090aab8400b002af41bd563esm5111939pjq.33.2024.04.26.16.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 16:59:08 -0700 (PDT)
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
Subject: [PATCH v2 2/8] drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_generic_write_seq()
Date: Fri, 26 Apr 2024 16:58:35 -0700
Message-ID: <20240426165839.v2.2.Iadb65b8add19ed3ae3ed6425011beb97e380a912@changeid>
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

The mipi_dsi_generic_write_seq() macro makes a call to
mipi_dsi_generic_write() which returns a type ssize_t. The macro then
stores it in an int and checks to see if it's negative. This could
theoretically be a problem if "ssize_t" is larger than "int".

To see the issue, imagine that "ssize_t" is 32-bits and "int" is
16-bits, you could see a problem if there was some code out there that
looked like:

  mipi_dsi_generic_write_seq(dsi, <32768 bytes as arguments>);

..since we'd get back that 32768 bytes were transferred and 32768
stored in a 16-bit int would look negative.

Though there are no callsites where we'd actually hit this (even if
"int" was only 16-bit), it's cleaner to make the types match so let's
fix it.

Fixes: a9015ce59320 ("drm/mipi-dsi: Add a mipi_dsi_dcs_write_seq() macro")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- New

 include/drm/drm_mipi_dsi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index b3576be22bfa..5de2bd62448b 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -318,11 +318,11 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
 	do {                                                                   \
 		static const u8 d[] = { seq };                                 \
 		struct device *dev = &dsi->dev;                                \
-		int ret;                                                       \
+		ssize_t ret;                                                   \
 		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));           \
 		if (ret < 0) {                                                 \
 			dev_err_ratelimited(dev, "transmit data failed: %d\n", \
-					    ret);                              \
+					    (int)ret);                         \
 			return ret;                                            \
 		}                                                              \
 	} while (0)
-- 
2.44.0.769.g3c40516874-goog


