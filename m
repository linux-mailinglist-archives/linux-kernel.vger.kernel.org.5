Return-Path: <linux-kernel+bounces-26153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0654782DC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935031F22810
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC8D1798F;
	Mon, 15 Jan 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e1hVGCI9"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0B17753;
	Mon, 15 Jan 2024 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 0F6F8C645D;
	Mon, 15 Jan 2024 14:59:20 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF135FF80D;
	Mon, 15 Jan 2024 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705330752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GdcSrLKbLAmb0XpITjqnJYgkexmBzBybbdlQo4fjEDw=;
	b=e1hVGCI9pE4AL27h/yoR5e7uuInLL603ej3OwM6ucH6Qim117sAFBJ5bm9SJfyOUKW1i0g
	Ve+yeupLm37+ePGCMeJZ6iUjkausiT6KLS/kXOQ0f08mb0vvVv471azWhYWia3h2cpEGqt
	uNgjP08caW4Hdu/Mb84BlG8UWskn6edUZGNiWZ++Ek6qf3LUxnQg5xFi3bP/gdkopTnQ/4
	RolG+zrYYFK6Cgjc+3yvg8CW8PqG4gRh7Z/32uh45wX+xexmQKzviNjqt55c2Ic6zx8TY4
	ZU5w3TaLjIsGpm0ESlHNBUz6eh6xrowz2nwDZeEDnBt/Ujmi6LIEEvmPXK8mNA==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH 0/5] wifi: wilc1000: minor fixes
Date: Mon, 15 Jan 2024 15:56:29 +0100
Message-Id: <20240115-wilc_1000_fixes-v1-0-54d29463a738@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJ1HpWUC/x3L0QpAMBSA4VfRubY6Z2aTV5GWODgltBVKe3fL5
 dff/0LkIByhLV4IfEmUY8+gsoBxHfaFlUzZoFEbJKrVLdvoCRH9LA9HNRmqXeWsMbaBfJ2B/5C
 nrk/pA+0bFyZhAAAA
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 David Mosberger-Tang <davidm@egauge.net>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,
this series aims to bring some minor fixes on WILC1000 driver. Those fixes
already live in Microchip internal tree and had been initiated by Ajay
- some initial firmware configuration adjustments, no visible impact on
  user
- a workqueue leak when dealing with multiple VIF
- a multi-vif fix (adding and removing a vif currently breaks the first
  one)
- a power down sequence fix to prevent "Fw not responding" errors on next
  boot

Those have been tested on SAMA5D2 with WILC1000 SD. All those fixes are
independent from each other.

---
Ajay Singh (5):
      wifi: wilc1000: set preamble size to auto as default in wilc_init_fw_config()
      wifi: wilc1000: fix driver_handler when committing initial configuration
      wilc: wifi: do not realloc workqueue everytime an interface is added
      wifi: wilc1000: fix incorrect power down sequence
      wifi: wilc1000: fix multi-vif management when deleting a vif

 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 12 ++++++--
 drivers/net/wireless/microchip/wilc1000/netdev.c   | 14 ++-------
 drivers/net/wireless/microchip/wilc1000/wlan.c     | 33 +++++++++++++---------
 drivers/net/wireless/microchip/wilc1000/wlan.h     |  6 ++++
 4 files changed, 38 insertions(+), 27 deletions(-)
---
base-commit: 03b2a1757348d2e8b62d4e8cbcbcd3ff59413d01
change-id: 20240115-wilc_1000_fixes-d41573764468

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


