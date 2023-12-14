Return-Path: <linux-kernel+bounces-70-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B56813B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671B21C21450
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CFA2207D;
	Thu, 14 Dec 2023 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WkhLss09"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ECF28F4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ce7632b032so4814239b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702585950; x=1703190750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f60jMhHn2NrJuxYV7wfhO+MfVtVZGHjXqg7DUtfV+AE=;
        b=WkhLss09q6ld69lCWrpU/MweZ5W3Lpm+T/eYqJsyDzgkD4ptmXJX0E4It5HBaCqrEI
         XPG2G6awBhL/E/AsM5h+QgbLVLEFItHh3C4SUTiyCu22vPMZJ/PUx5SasScD1q0196cf
         +lsWHbXM0PeSJrRJw7TJuQmPi9wH1xzgYwZCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702585950; x=1703190750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f60jMhHn2NrJuxYV7wfhO+MfVtVZGHjXqg7DUtfV+AE=;
        b=oriX9cVOgJP1POZKbpjRURrS2P6kgz7f4hkZwA9HWSs3YWRskG1raU5mMzHwzPRb64
         yXWxL7Lc04sxXVzMwB8w6zoeUNq2F0yPOMcIdMCioMTEMj0ZW6bt2gVIzmDBOHlFn/SJ
         5vlXa8pHdKg81ZFBVWTSB8CZHDADu2qIM/CYZeGjpvrwPNt2WkpIyuijoL7khv8QOwx/
         kSqjmkGNnBcHs9khx4x1TGlTKmSdr+qYgfSGNm9eMHLhAQU1EXDgLVE1ZaOmRAPhNdZa
         Pl45Hau/k7zjFCDBkFHOZ+SDVK+tp1suL0H/kPKnQ1LHWI8hdwqILyQAuK2qZahDbHhn
         vp/A==
X-Gm-Message-State: AOJu0Yxem0ixALJ1UVeIAf7WIz5N9vYngPwCfjhJYie0PgBHKAAh0GWv
	O1ST3BWQVRXPW4GDcwv2eU0zsQ==
X-Google-Smtp-Source: AGHT+IEGOaFAhYexjfwieKxbwPZ2Kk2OttwK4zxJvf+kkUnKqypsKNE1O7AnNxvzBqtTxzEABU/lKA==
X-Received: by 2002:a05:6a21:19c:b0:187:8bd4:e1b6 with SMTP id le28-20020a056a21019c00b001878bd4e1b6mr6533286pzb.31.1702585949943;
        Thu, 14 Dec 2023 12:32:29 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9d0c:9bd0:17f6:8236])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a018500b0028658657e9csm14636228pjc.46.2023.12.14.12.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:32:29 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Guenter Roeck <groeck@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Philip Chen <philipchen@chromium.org>,
	Robert Foss <rfoss@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/bridge: parade-ps8640: Never store more than msg->size bytes in AUX xfer
Date: Thu, 14 Dec 2023 12:32:05 -0800
Message-ID: <20231214123205.v2.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While testing, I happened to notice a random crash that looked like:

  Kernel panic - not syncing: stack-protector:
  Kernel stack is corrupted in: drm_dp_dpcd_probe+0x120/0x120

Analysis of drm_dp_dpcd_probe() shows that we pass in a 1-byte buffer
(allocated on the stack) to the aux->transfer() function. Presumably
if the aux->transfer() writes more than one byte to this buffer then
we're in a bad shape.

Dropping into kgdb, I noticed that "aux->transfer" pointed at
ps8640_aux_transfer().

Reading through ps8640_aux_transfer(), I can see that there are cases
where it could write more bytes to msg->buffer than were specified by
msg->size. This could happen if the hardware reported back something
bogus to us. Let's fix this so we never write more than msg->size
bytes. We'll still read all the bytes from the hardware just in case
the hardware requires it since the aux transfer data comes through an
auto-incrementing register.

NOTE: I have no actual way to reproduce this issue but it seems likely
this is what was happening in the crash I looked at.

Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX channel")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Still read all the bytes; just don't write them all to the buffer.

 drivers/gpu/drm/bridge/parade-ps8640.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 8161b1a1a4b1..dfb97fbb5be6 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -330,7 +330,8 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
 				return ret;
 			}
 
-			buf[i] = data;
+			if (i < msg->size)
+				buf[i] = data;
 		}
 	}
 
-- 
2.43.0.472.g3155946c3a-goog


