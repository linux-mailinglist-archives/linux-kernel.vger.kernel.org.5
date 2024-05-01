Return-Path: <linux-kernel+bounces-165503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5878B8D5E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B365B22054
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CA712FF65;
	Wed,  1 May 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j6aJ4JYp"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38912FB09
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714578202; cv=none; b=XWQclD5UWd7sOAVhRNLYgfzvnEeDGiKBmKRlX6dL5pgsimfWzEfO10ekv9HT4LmaGcMGfQs7TBwN3MyhjFUQorCU4UtPJKXmceOg+Kh71/te7b2mbeqKIuAwt/HFmyo1E47DgXGLqRCXLpHJ+NKlNDxN75HMa+BUtV2XSdnrg6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714578202; c=relaxed/simple;
	bh=CHn6dd9juJ7QU5kf8EIUTCmIhfjE5Sww12t5qi+aUgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tP9WV0/PBdoV2+1B1HSMim47lzMWVnQB55Ul1mvGClwwKtRZqW6KCLNrL6PjM5EIGFHNMo2xmZr1g4VQIFsGeVKLpEm6fyjLUSHgwVkFP059fbD/x0jm2vy4E762JWINs1G4g5aXRfK/5wdZzoHqWkJpCTQh9vP3Mri/Mz2Eg2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j6aJ4JYp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so5978443b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 08:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714578200; x=1715183000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqSRaJ+I/NgAMp1CRzQlMWp8eVTN4Fv5wLPbhbxPoyI=;
        b=j6aJ4JYpowemZ8CpNRS0SWwYCLoo4QD+CzHSz+cmugY7cc/mT/YsotZ1lAj9ZCKnrJ
         tqKTqwUiUmlY9J+08bC/UbYrZ7ZYSU7i5dtvdNFcj4BX6Rio06/WItBIklS3UvifuvSA
         9ROBBay844DA2zQjkNu/R4SlhR7TWJea0W2a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714578200; x=1715183000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqSRaJ+I/NgAMp1CRzQlMWp8eVTN4Fv5wLPbhbxPoyI=;
        b=TeFLjENDBrGZtdgmiH9YARhoUfYdGsb9rkXNxyAlSlO3rqfuLfIKhFgzv4MWCTYIts
         HDCjWWoi8NR2lUGBW6uIXieNCOnH9XqOSOWrfLOZLpwE844tYsEKuwjxKVy3IQ4wJQdC
         g0JAaDJYR3UP2hRVfIi8v6rfsQwAt5omsKIPMLrdwAem+XQJHuu0Wvtxy/OP43wK0xHD
         vGJ2p97WibMMidGbhsX9BPdPQ05tLtGhcyrjYX+VHXUtq6cxx20g+mA+bqUOHHZgZhF5
         iqea4NzCAeZpAEnT/zntOdIoXDnXbG9dqhHjsj1VCKJMSk6aXjW4GvoKuIPTS6WscJYp
         U/rA==
X-Forwarded-Encrypted: i=1; AJvYcCUnJ1+WLBL1iK+Qnh87VhU5A1A5BAknbxrbVwfUdje3J0rrDDJWVJXi1wVhLpmKqdPFbAeGlgFXqKAuB4+SuMEowwg1roh/0vGNlBo0
X-Gm-Message-State: AOJu0YwFvMCdUogMRD5hVWLAQqgmP8ztVwtsMTcEO1OOHxfip19vsYwZ
	B52nhr4pb5Pz9fM5FWjknftQWW0u8dxfMYcO1ye7mKP46dVAD8UDT/FgToVQwg==
X-Google-Smtp-Source: AGHT+IFI0XRKl4xlF9oA6mVlSbPDXsPwloqxxCaCX7TyGbZ6xYS649sCJKaSQ+96XKkEBKOMHdGtmg==
X-Received: by 2002:a05:6a20:2593:b0:1a9:8251:41ba with SMTP id k19-20020a056a20259300b001a9825141bamr3504545pzd.51.1714578200409;
        Wed, 01 May 2024 08:43:20 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:e886:8de:19a2:55b0])
        by smtp.gmail.com with ESMTPSA id fb12-20020a056a002d8c00b006f3ec69bc09sm7717924pfb.75.2024.05.01.08.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:43:19 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Hsin-Yi Wang <hsinyi@google.com>,
	Brian Norris <briannorris@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Joel Selvaraj <jo@jsfamily.in>,
	lvzhaoxiong@huaqin.corp-partner.google.com,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_dcs_write_seq()
Date: Wed,  1 May 2024 08:41:04 -0700
Message-ID: <20240501084109.v3.1.I30fa4c8348ea316c886ef8a522a52fed617f930d@changeid>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
In-Reply-To: <20240501154251.3302887-1-dianders@chromium.org>
References: <20240501154251.3302887-1-dianders@chromium.org>
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

Changes in v3:
- Use %zd in print instead of casting errors to int.

Changes in v2:
- New

 include/drm/drm_mipi_dsi.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 82b1cc434ea3..70ce0b8cbc68 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -333,18 +333,18 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
  * @cmd: Command
  * @seq: buffer containing data to be transmitted
  */
-#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...)                           \
-	do {                                                               \
-		static const u8 d[] = { cmd, seq };                        \
-		struct device *dev = &dsi->dev;                            \
-		int ret;                                                   \
-		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));    \
-		if (ret < 0) {                                             \
-			dev_err_ratelimited(                               \
-				dev, "sending command %#02x failed: %d\n", \
-				cmd, ret);                                 \
-			return ret;                                        \
-		}                                                          \
+#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...)                            \
+	do {                                                                \
+		static const u8 d[] = { cmd, seq };                         \
+		struct device *dev = &dsi->dev;                             \
+		ssize_t ret;                                                \
+		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));     \
+		if (ret < 0) {                                              \
+			dev_err_ratelimited(                                \
+				dev, "sending command %#02x failed: %zd\n", \
+				cmd, ret);                                  \
+			return ret;                                         \
+		}                                                           \
 	} while (0)
 
 /**
-- 
2.45.0.rc0.197.gbae5840b3b-goog


