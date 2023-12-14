Return-Path: <linux-kernel+bounces-77-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6361813B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790B3B21946
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EF765EDE;
	Thu, 14 Dec 2023 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iduOy+Fy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E695A2112
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d307cf18fdso31313485ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702586290; x=1703191090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CEbYOeExhWxrQcvIrSnW0dzfFwJIoL+EWRTjsEQRQR4=;
        b=iduOy+FypuQQ7pXz+XyjB+/lRThjfh9ttCsMv8zreqNCWM5WTv2La6OOI45l7Y13sg
         RoW6l87zpZB0Y/jmLzcpXM6pPlPYEo1bG6yen4KwUri8ELKBdeHBwhCXk2zffU9trDE2
         YNhbh1i/KL1vomXJzonBC2PQweZVQMNCqkNiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586290; x=1703191090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CEbYOeExhWxrQcvIrSnW0dzfFwJIoL+EWRTjsEQRQR4=;
        b=thyTXEuI9nUGXyffmrj+e70HfHXX3tG+zACETkFEvyZ/xhkz29z/pg0AAnbZH1JstF
         X8995G9IFWCCdqusQ+RArU92G+72euy/8toIxLxRWyhAhMfBaPlDlXLvBVVNgkgfEgu1
         xiXRzcZ0X0nIlpVRGndAxZXKarF/0chqmPW0HQS8iU8xr+nSS38mQPt1ifMqqRj79SVx
         NDlq+rjs8ImigIeMxXev+QD/hjOQm1R59Zqw7hO22Vvm9D1WvdVjycA2fRIPcoGYvdft
         yEsCPPwC/Iu+1p0/t+YeOrroJUtpqBM42D/N9deI1XgdIfCqeOZJfwye9FrH0ugL88Z9
         L3Eg==
X-Gm-Message-State: AOJu0Yx6lvACBIjLeEC8z6UqYUJfXzmjT6+gVhivMS7QHaVJFZdYrRmL
	jsSHE3Pdqn1dzXsKh+Okd/f4Lw==
X-Google-Smtp-Source: AGHT+IGcoNWWmuS7W3F8Oa3UUyu1se2mbBEQgXS9YTTmt+8tUfR2PUem9ww3SQz2i2gofIRWMOARSg==
X-Received: by 2002:a17:902:ec89:b0:1d0:c26d:e509 with SMTP id x9-20020a170902ec8900b001d0c26de509mr6417151plg.108.1702586290186;
        Thu, 14 Dec 2023 12:38:10 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9d0c:9bd0:17f6:8236])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001cfc2e0a82fsm12799081plr.26.2023.12.14.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:38:09 -0800 (PST)
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
Subject: [PATCH v3 1/2] drm/bridge: parade-ps8640: Never store more than msg->size bytes in AUX xfer
Date: Thu, 14 Dec 2023 12:37:51 -0800
Message-ID: <20231214123752.v3.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
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

Changes in v3:
- Never return more than msg->size as the number of bytes we read.

Changes in v2:
- Still read all the bytes; just don't write them all to the buffer.

 drivers/gpu/drm/bridge/parade-ps8640.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 8161b1a1a4b1..d264b80d909d 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -330,11 +330,12 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp_aux *aux,
 				return ret;
 			}
 
-			buf[i] = data;
+			if (i < msg->size)
+				buf[i] = data;
 		}
 	}
 
-	return len;
+	return min(len, msg->size);
 }
 
 static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
-- 
2.43.0.472.g3155946c3a-goog


