Return-Path: <linux-kernel+bounces-160351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C6A8B3C56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4D61C2315C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1F514D431;
	Fri, 26 Apr 2024 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z5AT4aCH"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EB514900B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147402; cv=none; b=Lj/N7b1CsqiqPAkfZXokuWwo+KSkBaVHkeDzBe4OnVjftC/RNYDttjiA2X9GCUR2RX5LULP+LC/aNe9iG6TzJq1YFY48bDpKOHb1m8/mGkaYKcbum+4JI2fEZbs4/G73eD89yrikCiYfKjFoFA73AUCI71tCKcIeiUwuQZIZ/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147402; c=relaxed/simple;
	bh=2bqLUBm8g+fTErDsw3AoG3Opk8G6JUruHIHjkz0DdlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ete0vWOOcY8qvxzqFP4TQT2/Vap8csdYlzKTNWJNlFsUO+lfe3ZGd7ym0qbyREZvlvJ3E/Rsnz3FTlDH3bLFAHaPFigN65/Odk8wF1P2r7ZFSxyRPgMzdZM+rw1AksK/HNrOK2RoZv5Rx1fWk3S4Wg0miVr7muVCzVMk54IysgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z5AT4aCH; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso32363551fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714147398; x=1714752198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vAUdsTCR2PnKMamTrwyk474FOGzS7dCZMJ7/drYNGg=;
        b=Z5AT4aCHoBvguMKkTs6KXr+8+LTUEjiBNAwHSFecPU/kd7gLrWW7lp0JDRvqx/1f/L
         /0jPTFgYi4kW+yebvfSudvvb9tUiBuhBqz3spdV1zAIaozUAQlIC+s/jzEV7+/LaVpKY
         XPYlE3m8BbNZEKQWK/5Fp2cDEdCmfe3jBJIqshR9CMZjqf/u15x3xyvIQb53Wx8Ytzsr
         eopmEnv+/qQXraePb28MdtoQI6oLPDqL1yw8ST+OO5BYCqfCJ09bWn4fOzHQ8Yv57mcP
         51q3gS/+IqrkFOloeqkji/yUSlTnse/ec7pFI7ZAVY+YMrS5AQ2d8FrsECRtWd6sH4UD
         44JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714147398; x=1714752198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vAUdsTCR2PnKMamTrwyk474FOGzS7dCZMJ7/drYNGg=;
        b=Xg1CHu+hjdySx5IdypVGfAuYcu4Krzry8EgikH/cdN++ALtUsAVjhGapTwVYGZz0qC
         Sa6W/4P4p36Y6IZaYIVaI9HpNhZwmmZKxBpXyp/VFdRtYRMx9Ao8sxtoiqmRMFiWKFfG
         AQUMCvcUwmTOym/QmDfAa8NvrOIgUr0VYMPwUW//427mWBcD0mWR8IyL6dWO8LyUDniT
         GtL1oZmk2kqFLy/gFfVH6EhFDZRL7R69aIBZZcfRIL+lR8og7U8Smjv98SrwMIf5UO2B
         BoWiXO5TEYDMDKHjvmwF96lNPbeldKBpRFt2MKlnGC+5F+ihXNdAIDsqOe4j/VkUdd1n
         ezuw==
X-Forwarded-Encrypted: i=1; AJvYcCV9jO8WsxYmbg3ATheIzD8G5zcIPIfdHzPN33JVGfaYmZbHMRn2Z/5Y8pmawOyxvbRSu06ea++lUML3MiPrtC+oyH3ra3dn4f14Y1Aw
X-Gm-Message-State: AOJu0Ywfkt4UuFxCp/+HSYwiEqYcwLt4CEnKU01fo2CGk5Z2eC+o9Zq0
	zJx94xXClHAy8YmpTHwW9chbhHOGZVTkBaVihhfrn9UnkHOJ23NsG0MS2UIUnAY=
X-Google-Smtp-Source: AGHT+IFZVBNi2xUBOvk7vvZqb2k5iPH7tOf6qAZxXIoF5HheGesLAylF10j55jmXO8j3H5I/limBAw==
X-Received: by 2002:a2e:92c2:0:b0:2d7:1323:6792 with SMTP id k2-20020a2e92c2000000b002d713236792mr2751149ljh.43.1714147397625;
        Fri, 26 Apr 2024 09:03:17 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1926:f73e:8b99:1c0a])
        by smtp.googlemail.com with ESMTPSA id p14-20020a05600c1d8e00b0041bab13cd74sm1271408wms.17.2024.04.26.09.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 09:03:17 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/meson: fix hdmi auxiliary system operation without display
Date: Fri, 26 Apr 2024 18:02:52 +0200
Message-ID: <20240426160256.3089978-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

CEC and ARC should work even when HDMI is not actively used for the
display but it is not the case with Amlogic HDMI.

This is important for devices such as sound bars which may use DSI
to display a UI and HDMI for CEC/ARC. A display is not required for these
functions

This patchset fixes the problem.

Jerome Brunet (2):
  drm/meson: dw-hdmi: power up phy on device init
  drm/meson: dw-hdmi: add bandgap setting for g12

 drivers/gpu/drm/meson/meson_dw_hdmi.c | 70 ++++++++++++---------------
 1 file changed, 31 insertions(+), 39 deletions(-)

-- 
2.43.0


