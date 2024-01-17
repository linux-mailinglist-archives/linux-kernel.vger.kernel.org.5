Return-Path: <linux-kernel+bounces-29322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A36830CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC7E1C240BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE90223748;
	Wed, 17 Jan 2024 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RCj9hkDV"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00122EE3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516537; cv=none; b=J9s40ybWDAbiau3zvc3PBN1UJfEo5d6jLTryCpwudXf/EAQpgN23fGSZ9zM+uKHjbt/4WZHuOiL9otpZPQDl8OCGvvI2lKtrr3RTLm78QFy4F9JyriHd5/SB5wbGlFTgtheZjU3YSOtXHNuaeZceJL2kXG3ILpyB8G/75Z/0Qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516537; c=relaxed/simple;
	bh=tugHWeY5jAaSBGspVjSdqKXVWtqduV8QmkpnxiUidqw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=SzRrd+yT7BBfK7yfddjK320h4pSHfnVk5BEEOfQv3hPywg9MWrQoESm4FP6n+9r7Raul/wyTVe1ViZUgSnxObhaqSgC3ld5T/ADvjpe5QNkhzVnKSsx44xXwa0CuzxO7ZniD+jj+KZ0kwNC1bJKMZYpNBjWqYxgVYJrkrldAKDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RCj9hkDV; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ddf1e88e51so5526360a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705516534; x=1706121334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGYRtDKlKnGOQduq4VNWov4UOWEDuy3ZPEgEUd75zZg=;
        b=RCj9hkDV2f4FaPshDzZz2wXBHJRCnQUA64oQRebW8lCbOn1Qf6xNXaWy+CF9w6ytDv
         M/RtDaJT1xt8MrKKr7U/uF5E9AqYNgVZ61iqknH60uYjJwrPSx/EtAYtONsS7tAm8Y0G
         jHi6ehK8P5M3w2czPtk5oaIGNWSOS+lFcUHxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705516534; x=1706121334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGYRtDKlKnGOQduq4VNWov4UOWEDuy3ZPEgEUd75zZg=;
        b=iVWgsHFWOOBpQnQQYMcMvOtbOk9b200b8x8WhxQqyHHozL7W2mdBjV9z5b5dH8Na2L
         DiOk0IoEiIfq1MGSl/meQLHKWotRI3gtDNc/Vzu3RB0QfTzcliWc5ObLcMuuUjNH7JyM
         vXrZ9EAdgBtZli6+l33Tw+Oaeu2XeuWqcXC1D5osiq5k9NFv+bP48McVrELjulRK4XnV
         vIIgIaueA3CTVLCCX2FVD5o3uOYvLewJI6DCdBA1lcvW6N7IrKPC9y/voUCsI4TwkanY
         wkj2She84Ulv0y5Gh/G4IxFO3zhrGze09zVlJ1rtAUyM28l9pDyTyDYDL0xgs2b5HKj0
         08aQ==
X-Gm-Message-State: AOJu0Yzpgw4iFiPhOcrzt6W+1tXp7mQ97ZWhOEJ4i4caqVKe2oj4bR1D
	qEL1JgSFbd9YR6B3+Z87O1V16CWjPhPe
X-Google-Smtp-Source: AGHT+IFZnL0+bJFVTkL8YnbJPonvdMeWIW2tBeoi/pmAtih3evTSdKFPj5YogL3HK+ZLXPIM8Jrk8w==
X-Received: by 2002:a05:6358:5398:b0:175:b906:8c87 with SMTP id z24-20020a056358539800b00175b9068c87mr7650557rwe.21.1705516534518;
        Wed, 17 Jan 2024 10:35:34 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:bcd0:3985:867:5ea4])
        by smtp.gmail.com with ESMTPSA id ko18-20020a056a00461200b006dab0d72cd0sm1762215pfb.214.2024.01.17.10.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 10:35:34 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
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
	Pin-yen Lin <treapking@chromium.org>,
	Robert Foss <rfoss@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: parade-ps8640: Make sure we drop the AUX mutex in the error case
Date: Wed, 17 Jan 2024 10:35:03 -0800
Message-ID: <20240117103502.1.Ib726a0184913925efc7e99c4d4fc801982e1bc24@changeid>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 26db46bc9c67 ("drm/bridge: parade-ps8640: Ensure bridge
is suspended in .post_disable()"), if we hit the error case in
ps8640_aux_transfer() then we return without dropping the mutex. Fix
this oversight.

Fixes: 26db46bc9c67 ("drm/bridge: parade-ps8640: Ensure bridge is suspended in .post_disable()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Sorry for missing this in my review! :( Given that this is really
simple and I'd rather the buggy commit not be there for long, if I can
get a quick Reviewed-by tag on this patch I'll land it without the
typical stewing period.

 drivers/gpu/drm/bridge/parade-ps8640.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 166bfc725ef4..14d4dcf239da 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -351,11 +351,13 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
 	ret = _ps8640_wait_hpd_asserted(ps_bridge, 200 * 1000);
 	if (ret) {
 		pm_runtime_put_sync_suspend(dev);
-		return ret;
+		goto exit;
 	}
 	ret = ps8640_aux_transfer_msg(aux, msg);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
+
+exit:
 	mutex_unlock(&ps_bridge->aux_lock);
 
 	return ret;
-- 
2.43.0.381.gb435a96ce8-goog


