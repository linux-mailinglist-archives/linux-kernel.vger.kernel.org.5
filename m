Return-Path: <linux-kernel+bounces-148239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BE08A7FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5FF283EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4302613AD1A;
	Wed, 17 Apr 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WfOmZAiP"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4513AA2E;
	Wed, 17 Apr 2024 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346463; cv=none; b=UYDtpxTmFMlIPAOYJLL3/p29G3MLq1BJdTdXMWtnbKogsEy0IoSTMVi1aYlZz55iWk7UnL/2a3gFDdtA/AFGIq/GBdpMA/y2VaCZMkd9PlU0HkrTVY/BHeuJ8eVvt0jIgKkNe+4uBJYmKCmLk5wpx2+BRdjGhMJKwGA6xGla9Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346463; c=relaxed/simple;
	bh=IA6NeFKMpm8UaFyMn2FIPCKOpK3ratJvAaNDp/C02dw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D7XeiSfs5B/kcAJK0WzQvX0uNtBK2+rn8IYw5w5lwpoBkApWirA1VA3OJsMt6Jwuj9h/yMg0Q3NlVOGRCv8I09+nnxWAwHMT5nohLOs4B75FLStYpfA91HrzbEClIfY3d/wzKx8CcBQhy0swfnudUOCTbaAIRvBiiVGAa1hViXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WfOmZAiP; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C978BFF805;
	Wed, 17 Apr 2024 09:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713346454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g9mywsyvFR+b2b90l5RvO1Xzk1fJrXNUaUXrvGwRgyw=;
	b=WfOmZAiPZ7GcKuFhHLznzEDA8WJs5xUY6URYtJzb0IJIpMl4rA6slSAxNpfR1L53nOaEYh
	N9OC/6NmzFaANx3FAMDYw1kRpUIQ7DH4HEuftSXwruN3B/C2WpBeC/d38w5HnQeioqOdRC
	Uq36FPA2lwb85cQ89uuA+PSXm3h8eS5ouaOGso9LyZkpBJe/2OE5kzv1M3LfzxT+ob/Y0C
	McQpFBv53ooQLQ+NcYMtf/EdKSU5XiTMBEgMgfwW6m+a5D8XaIxKoV8L+MH08mU3sgLbEe
	7+xiNZLLvUOXOlxX4KSiXDYmdVCdHgtYuv1u44X6hMbP8BJyQUccrxDxdyhvWw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH 0/6] wifi: wilc1000: fix default mac address
Date: Wed, 17 Apr 2024 11:34:07 +0200
Message-Id: <20240417-mac_addr_at_probe-v1-0-67d6c9b3bc2b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI+XH2YC/x3MSQqAMAxA0atI1hZsHBZeRaR0iJqFVVIRoXh3i
 8u3+D9DImFKMFYZhG5OfMQCXVfgNxtXUhyKARtsNaJWu/XGhiDGXuaUw5FqvRuarnPY6wClO4U
 Wfv7nNL/vB+d/HQtjAAAA
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Heiko Thiery <heiko.thiery@gmail.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

This series aims to fix invalid mac address issue raised by Thiery Heiko
([1]). WILC1000 mac address is currently not set until device is opened, at
which point firmware is loaded and started. This results in default mac
address being 00:00:00:00:00:00.

This series, based on an initial patch from Ajay, reads the MAC address
from chip eFuse whenever we set the first interface (at probe time). To do
so, we need to ensure that any bus communication is properly initialized,
so the first commits slightly rearrange/fix initialization/registration
order to allow to read MAC address properly.
Based on the tests I did during this series adjustments, there are still a
few corner cased not properly handled, especially when dealing with two
interfaces on top of the same wphy, but it fixes at least the user-facing
mac address for those interfaces so user space network managers are not
confused anymore.

[1] https://lore.kernel.org/netdev/CAEyMn7aV-B4OEhHR4Ad0LM3sKCz1-nDqSb9uZNmRWR-hMZ=z+A@mail.gmail.com/

---
Ajay Singh (1):
      wifi: wilc1000: read MAC address from fuse at probe

Alexis Lothoré (5):
      wifi: wilc1000: set net device registration as last step during interface creation
      wifi: wilc1000: register net device only after bus being fully initialized
      wifi: wilc1000: set wilc_set_mac_address parameter as const
      wifi: wilc1000: add function to read mac address from eFuse
      wifi: wilc1000: make sdio deinit function really deinit the sdio card

 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 10 ---
 drivers/net/wireless/microchip/wilc1000/fw.h       | 13 ++++
 drivers/net/wireless/microchip/wilc1000/hif.c      |  4 +-
 drivers/net/wireless/microchip/wilc1000/hif.h      |  2 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   | 71 ++++++++++++----------
 drivers/net/wireless/microchip/wilc1000/netdev.h   |  2 +
 drivers/net/wireless/microchip/wilc1000/sdio.c     | 71 +++++++++++++++++++++-
 drivers/net/wireless/microchip/wilc1000/spi.c      | 17 +++++-
 drivers/net/wireless/microchip/wilc1000/wlan.c     | 48 +++++++++++++++
 drivers/net/wireless/microchip/wilc1000/wlan.h     |  1 +
 10 files changed, 191 insertions(+), 48 deletions(-)
---
base-commit: db5037bd459adeba309af1f97fd5c9b6a0788b2a
change-id: 20231221-mac_addr_at_probe-3cb6044b251d

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


