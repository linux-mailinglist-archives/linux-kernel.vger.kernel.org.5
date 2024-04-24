Return-Path: <linux-kernel+bounces-156364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C328B01D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302BD1C21C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE57D15748D;
	Wed, 24 Apr 2024 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWTar0a8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26B336D;
	Wed, 24 Apr 2024 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940470; cv=none; b=RK45h0FMjlxoDnQ8nHmkR40BWcupKCs3d3LDCLIu3A2o/6K7yZUEW/Kin5+OYxqFBi0bWB5TbNNl8oP0URkExJ6t881TE44lhCVg5T1+ghRXzYXjGEMzs5/IhMqQSnqzLWpPMVvxxhtYyG+4AEHg++0I3ZY+2p/ToxKXeW2y0TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940470; c=relaxed/simple;
	bh=qhmThP7INdCC8VBW2wlRiFNJE/7ZEzBRMxYW6QhxoFA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PAQqmwtO/UBmiOlwZk+Vwa71VtOp6mbl39OK6blF6INqqFSGWeDzRpOW8As7oDc9HkCqoDPSCKUp4TP7ZPfKWbRDsM1+fgOG9jqt91ebtbDNX5UUbt1A4pSPnfzCcH7QVu53rwqIU2vPZnWfA4XXtawWyhdRED/PgmKkkpIiQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWTar0a8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8E8C113CE;
	Wed, 24 Apr 2024 06:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940469;
	bh=qhmThP7INdCC8VBW2wlRiFNJE/7ZEzBRMxYW6QhxoFA=;
	h=From:Subject:Date:To:Cc:From;
	b=RWTar0a8DvsCOmkBnZc1XtDy8jLSKLsyxGfEbMelOUS3FNkvVfyg2qLCEoAe/zejo
	 nch9CXCF+72DS5YL4G1/NBQlMwdkS4sVlYbtugJeG49a6h7jFiaoY9fT0ftBK7evGh
	 llHrzgHVTnex0e4DHzSv8KcDCZ8s4cHXklXGVJkA9f8gTpzOJGvvWzynoK9PFpyBcO
	 rDUstvFlFXN50vWY/6UyAOOtJe+QEpGVamnBKMC9RtCkLgPz2dYYcIov/28yfyLA1X
	 SRVq0lCvn0ndJ1+rtrXZrR2K3naOATxOjXXfEm7QIYD2wb4qtwg+FfCdFIWaKzQass
	 oUiKLou3u+ujg==
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 00/19] backlight: Constify lcd_ops
Date: Wed, 24 Apr 2024 08:33:26 +0200
Message-Id: <20240424-video-backlight-lcd-ops-v2-0-1aaa82b07bc6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALanKGYC/4WNTQqDMBBGryKz7hSNqX+r3qO4MMlEB8VIIqFFv
 HtTL9Dle/C974BAnilAlx3gKXJgtyYQtwz0NKwjIZvEIHIhc1lIjGzIoRr0vPA47bhog24LKOr
 KNLJsrVUNpPXmyfL7Kr/6xBOH3fnPdRSLn/3fjAXm2KqytlrZh6yG50x+peXu/Aj9eZ5fcJ8xu
 L8AAAA=
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-omap@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2739; i=krzk@kernel.org;
 h=from:subject:message-id; bh=qhmThP7INdCC8VBW2wlRiFNJE/7ZEzBRMxYW6QhxoFA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKfa2cwIQ6siUozSMkADWp+Mx0tCvS7bXKbhN
 kGbbX8WNSaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin2gAKCRDBN2bmhouD
 14E6D/4vCOuf8a/6KvYfDc5C87F/x5Tj0g6zD9S7ZKUXm6YoQPhQot7+GqfYpM80vLaVm9IkH7R
 nhERFkiurnMemsKWYDGZz8T9XskGMcNkH3tg/bnC6aP152F3HTC9WjrRZCjHFwCO+7gAUPt4p2i
 rG2kA1WgBrSWx/YZ9anVXuy4El/xkp1VQPfT8JfAEiWteQM3hnyT36vrzlm5kTwbGhV747+rMEf
 meeIhJ/nU/usE9ahohS1RDKIRlgeIKS79LJEppW8PnLZpeKCE+s7/0ANmN2vDujJ5W1nG53w5qx
 fu8a32llePUQOwx3ryJ6ZPOL+d70Xn+qupqHkL2yV7YDBQcPvK7YtTIxwErpcV3hkeFCA4j1LHm
 xUZf+sCmVr33GFFCPip+B2APJiVlJkPX4vevH7LFcHck/hoBYV2pdiWRnWS/SrE014rLC6v7GS1
 uwShpE6kyTgs7UfIMi/CoD5tSHLrH6Gh14uNRYxaydE0cXMw5Wz5Sjono2PdP9WX2W7gaXUORfR
 hu69i+67wp5rEQ9tYFOsf7PjpcQseQCCZ79Iklgi+NdKfb2zbAZooZ7QoUJiVLYOIu8CcpzxKCJ
 36tO34XyNIjlS8wILZfctqwOZHouL8Cj5ndg+NmB6b64GIVJTmeeX/W22nIelIBzqvOVDOhCAxW
 gJl0a+pdXCHlMFw==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Changes in v2:
- Collect tags, including wrongly places Thomas' tag (which requires me
  to manually edit 15 other patches to drop it).
- Combine here checkpatch patch:
  https://lore.kernel.org/all/20240414185440.288812-1-krzk@kernel.org/
- Link to v1: https://lore.kernel.org/r/20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org

Dependencies
============
All further patches depend on the first patch.  Therefore everything
could go via backlight tree (please ack) or via cross-tree pulls. Or
whatever maintainer choose, just coordinate this with backlight.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (19):
      backlight: Constify lcd_ops
      backlight: ams369fg06: Constify lcd_ops
      backlight: corgi_lcd: Constify lcd_ops
      backlight: hx8357: Constify lcd_ops
      backlight: ili922x: Constify lcd_ops
      backlight: ili9320: Constify lcd_ops
      backlight: jornada720_lcd: Constify lcd_ops
      backlight: l4f00242t03: Constify lcd_ops
      backlight: lms283gf05: Constify lcd_ops
      backlight: lms501kf03: Constify lcd_ops
      backlight: ltv350qv: Constify lcd_ops
      backlight: otm3225a: Constify lcd_ops
      backlight: platform_lcd: Constify lcd_ops
      backlight: tdo24m: Constify lcd_ops
      HID: picoLCD: Constify lcd_ops
      fbdev: clps711x: Constify lcd_ops
      fbdev: imx: Constify lcd_ops
      fbdev: omap: lcd_ams_delta: Constify lcd_ops
      const_structs.checkpatch: add lcd_ops

 drivers/hid/hid-picolcd_lcd.c            | 2 +-
 drivers/video/backlight/ams369fg06.c     | 2 +-
 drivers/video/backlight/corgi_lcd.c      | 2 +-
 drivers/video/backlight/hx8357.c         | 2 +-
 drivers/video/backlight/ili922x.c        | 2 +-
 drivers/video/backlight/ili9320.c        | 2 +-
 drivers/video/backlight/jornada720_lcd.c | 2 +-
 drivers/video/backlight/l4f00242t03.c    | 2 +-
 drivers/video/backlight/lcd.c            | 4 ++--
 drivers/video/backlight/lms283gf05.c     | 2 +-
 drivers/video/backlight/lms501kf03.c     | 2 +-
 drivers/video/backlight/ltv350qv.c       | 2 +-
 drivers/video/backlight/otm3225a.c       | 2 +-
 drivers/video/backlight/platform_lcd.c   | 2 +-
 drivers/video/backlight/tdo24m.c         | 2 +-
 drivers/video/fbdev/clps711x-fb.c        | 2 +-
 drivers/video/fbdev/imxfb.c              | 2 +-
 drivers/video/fbdev/omap/lcd_ams_delta.c | 2 +-
 include/linux/lcd.h                      | 6 +++---
 scripts/const_structs.checkpatch         | 1 +
 20 files changed, 23 insertions(+), 22 deletions(-)
---
base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
change-id: 20240414-video-backlight-lcd-ops-276d8439ffb8

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>


