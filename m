Return-Path: <linux-kernel+bounces-48594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA81845E91
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBB21C267C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B388403B;
	Thu,  1 Feb 2024 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KusMYAD+"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F32A8405D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808740; cv=none; b=OBNqcCDZj5h9nNGD2VLzhyRwmHpQyC6WisNR3U9xRCbV4tU+ooJFHu/445s8XbleyorqeYg5uVtLWrVF+LV3b205gOHguKJeMneFLaU5VUQ1PWTc0tcPYtNzLzYnTIrvJPZlhplC8AyVS5/lSpBLuzujI7JW+s7btv9xxBQwtGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808740; c=relaxed/simple;
	bh=gFYVkNhsWMZ0PZR7CfgH9n4zYqWey4gF7lfzOXaUXvQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rCQYStJtRPz5jSV/Dpn57Sz0HVtHz0k+A2P0YEpFVrfGMWPrfT7GndxpReyF0wmGNejPtQozrl1VdOGmcSlpUD8/myyCywJvkPq89/XxuHDmBQUIkqRZzTjwVirsLruvXBz3X+g5ETqV2KVWfi9xwbfO+Y31sCr2tHlSpWh+ETI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KusMYAD+; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98F1D1C000D;
	Thu,  1 Feb 2024 17:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706808731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VnJbjJTg4nEr9s3zhJjNFrJUiH61j50+UMrQv0IdY/o=;
	b=KusMYAD+N+4EtxtdQAf7yuRN3pKBtt/M/aF0WxpOadyZA6Q3/rkM83J2CXr9N/nmcu5rmP
	racJDueiAn1b5yw2A2cELbJq9nIHtOCp1cUtcN/yjbI93X2t0fHKQtWPZh2wVBzay69x4G
	HnsMyyMsPQfYjvmnBDMQ2P97kYHwJ8++w8qygWoZUPZRX9LW2297qBn9Zk76Qd/9P8E4Fp
	5hZfK7b4KiNrq+ahaDJ7gBZ5tLpvNMskx2/WPHLedR6D5hSXKloeK6mIV06s4dR3umTLKa
	dx/kwjPqBE5diw8bGdCBg++an1mvxdqT2ylP7LEAO9kKyLASJqWNfhWhLR4dew==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH 0/2] Better support for complex pixel formats
Date: Thu, 01 Feb 2024 18:31:30 +0100
Message-Id: <20240201-yuv-v1-0-3ca376f27632@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHLVu2UC/x2MWwqAIBAArxL7naD2oq4SfZhutRAWSlJId2/pc
 4ZhMkQMhBGGIkPARJEOz6DKAuxm/IqCHDNoqWuppRLPlYSqqs710vVN1wKXs4ko5mC83bj1176
 zPAMudP/rcXrfDwOFzAZqAAAA
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, marcheu@google.com, seanpaul@google.com, 
 nicolejadeyee@google.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>, thomas.petazzoni@bootlin.com, 
 miquel.raynal@bootlin.com
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=gFYVkNhsWMZ0PZR7CfgH9n4zYqWey4gF7lfzOXaUXvQ=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBlu9WYRQhES4EmjZZ7vAyXW1pFFRuarhPV03wlazy9
 DgoNLUSJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZbvVmAAKCRAgrS7GWxAs4tUFEA
 Cz/OyfGWoHhrtvANxCouKVTqA7kcf3dNHSbjLAohQb5ygAHwJJXFy4VlwPI+L3xEsKxM3fxQQzNu+J
 RnxxLGbfwxGqajmUcFZTjOG5Hrx0eZ2W3QAFjV0odo6bxK0SoGfHbLDaz+o7xWyxj/Ax5QRBIdWpJB
 eU/qf3QGSCzw1YFsAkaBZr6s+9rJg9PGS/lV6jtJtn2llm1MZQL2aEOWXzdlPW693uICE150G4sGWX
 WEDY73WHutJn2n+sMWvfnwv2Nt2bhXAfxUbiLCRtS6QjV46NuS+FBVKED9NRrHyEEb+41Emd+SzdOm
 xe7qkpTk6fNc9mt0JOCfNxhnrpy5A4CRq4iS/ySD1KwO0dYHkFcHvuwWW/AJuCE/9ke7fzcP34Ufo8
 4CtXcuHl0fSmjV2mXAhm0KAGlsrJM9PuCkJxPw6NdQ7dul6Vr5Oj/c0xb3cKC0fdpasYu9ocBQ2lLG
 wRqz6N2gjjBA3ZCw/CjRcOEUFT4ziXpmXig0/knZyMYE1vuCeID856H193SDWpOv2Ip+MXnjvCl6zH
 StkiiLhQwHmwYAG5UzU9zBga7kvosVhsh0ejk1h7Jufgubk+JvFvSibiu2SROCwIJSviq5SlTVrx7n
 sOvptZ+U9af+q+jRdTNOxGf8mrhx9DMQ2x85q9Ro0v7blG8qwM50hcfoESVg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

This patchset aims to solve issues I found in [1], and at the same time 
simplify the composition algorithm.

I sent more igt-gpu-tools test [2] to cover more things and detect the 
issues in [1].

This patchset is based on [1].

Patch 1/2: This patch is a no-op, but make the code more readable 
regarding the pixel_read functions.

Patch 2/2: This patch is more complex. My main target was to solve issues 
I found in [1], but as it was very complex to do it "in place", I choose 
to rework the composition function.
The main two advantages are:
- It's now possible to create conversion function for packed & grouped 
pixels. Some pixel formats need absolute x/y position and not only an 
offset in the buffer to extract the correct value. This part also solve 
the issues I found in [1].
- The rotation management is now way easier to understand, there is no 
more switch case in different places and instead of copy/pasting rotation 
formula I used drm_rect_* helpers.

[1]: https://lore.kernel.org/dri-devel/20240110-vkms-yuv-v2-0-952fcaa5a193@riseup.net/
[2]: https://lore.kernel.org/igt-dev/20240201-kms_tests-v1-0-bc34c5d28b3f@bootlin.com/T/#t

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Louis Chauvet (2):
      drm/vkms: Create a type to check a function pointer validity
      drm/vkms: Use a simpler composition function

 drivers/gpu/drm/vkms/vkms_composer.c |  97 ++++++++-----
 drivers/gpu/drm/vkms/vkms_drv.h      |  32 ++++-
 drivers/gpu/drm/vkms/vkms_formats.c  | 254 ++++++++++++++++++-----------------
 drivers/gpu/drm/vkms/vkms_formats.h  |   2 +-
 drivers/gpu/drm/vkms/vkms_plane.c    |  13 +-
 5 files changed, 236 insertions(+), 162 deletions(-)
---
base-commit: 5d189d57bb335a87ec38ea26fe43a5f3ed31ced7
change-id: 20240201-yuv-1337d90d9576

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


