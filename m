Return-Path: <linux-kernel+bounces-67204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 032A9856800
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74291F2EEFB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96104134733;
	Thu, 15 Feb 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CDJn+Zj6"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA913340F;
	Thu, 15 Feb 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011408; cv=none; b=XcULDlBI9gjpIGHGHiI2UTyDbGJZ5ENVSFUdhu9RAHrvM0prp4ArqoNLSI7MwTi7XO2gaWq1Rpet4EJUFiV5Cbrs3ziuv87GpCAB69o4xsqOKDWTUJWWtlUCV0dMVI/BskSR1tehZiAR9Gcq8PuDgh3SViUd8PHIY/RfTgyoLQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011408; c=relaxed/simple;
	bh=tySSyhctcJeEq9pwA1Mg9ZwgdQxeizWcyX96KTc+4Y8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HsIzMdoQ53WOvKX++LqMHVgl7ltMx+sGBxmt2lcWTboXJjXlYbVNT+0up1KwYmqFS27giK551eR0ZgBlmvodtAqNrgpT6N2vbsAROtpfWE/IQuDCL+rgxkSVz7RJQVlkRo7wJsvX05ODb/wJSKnDIlCrZDEmKgroZ7JGzJgmVUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CDJn+Zj6; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 5D992C8769;
	Thu, 15 Feb 2024 15:36:39 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61B34FF804;
	Thu, 15 Feb 2024 15:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708011390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iYpBy2pOkbObWUArx2aSecO+YI6aKHJRe0UxQNbEakU=;
	b=CDJn+Zj6JNC+vwzOl7OkOaWZNiubzo69dYM2ZlpacMrYvTUPpdhSBkpnN5Jxbw36gMPJ9s
	97aPZ0wgSuOeH8bglwkDO5QG4dOF84AZoKW0cqd6tl53w333SjnG02IwbBGsWNUR/wwYNA
	llIj8O1Tdq+oKxIi4vwPpUsFKm067gG9hT4bQzDlbJ+xAICW2fxyqpcflppdlTWesGcUQ9
	cnpS2d3JkCf+ULAL2zcF3zRe7d2yUXrXdqv8hPtxuayT5kMBbiEotiNLqdpGRBrNE2/zIv
	pitt5sZ/9KAWUa/Q+QK8V8j9Qr+SraoMXbP19o3BrA9cn35evIfNKR70iCa8GA==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH 0/4] wifi: wilc1000: fix RCU usage
Date: Thu, 15 Feb 2024 16:36:17 +0100
Message-Id: <20240215-wilc_fix_rcu_usage-v1-0-f610e46c6f82@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHEvzmUC/x2MXQqAIBAGryL7XKD289BVIiTssxaiQrGC6O4tP
 Q7MzEMJkZGoUw9FnJx43wRMocgv4zaj5EmYrLa1NpUpL169C3y76LPLaRQDrYafQgBsQxIeESL
 803543w90WGXmZAAAAA==
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

This small series aims to fix multiple warnings observed when enabling
CONFIG_PROVE_RCU_LIST:
- add missing locks to create corresponding critical read sections
- fix mix between RCU and SRCU API usage

While at it, since SRCU API is already in use in the driver, any fix done
on RCU usage was also done with the SRCU variant of RCU API. I do not
really get why we are using SRCU in this driver instead of classic RCU, as
it seems to be done in any other wireless driver. My understanding is that
primary SRCU use case is for compatibility with realtime kernel, which
needs to be preemptible everywhere. Has the driver been really developped
with this constraint in mind ?
If you have more details about this, feel free to educate me.

To: <linux-wireless@vger.kernel.org>
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: <linux-kernel@vger.kernel.org>

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
Ajay Singh (1):
      wifi: wilc1000: add missing read critical sections around vif list traversal

Alexis Lothoré (3):
      wifi: wilc1000: split deeply nested RCU list traversal in dedicated helper
      wifi: wilc1000: use SRCU instead of RCU for vif list traversal
      wifi: wilc1000: fix declarations ordering

 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  2 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      | 70 ++++++++++++----------
 drivers/net/wireless/microchip/wilc1000/netdev.c   | 51 +++++++++-------
 drivers/net/wireless/microchip/wilc1000/netdev.h   |  6 ++
 drivers/net/wireless/microchip/wilc1000/wlan.c     |  2 +-
 5 files changed, 75 insertions(+), 56 deletions(-)
---
base-commit: f4adde5c2f875c491670bc19f6abae91ae364ed6
change-id: 20240131-wilc_fix_rcu_usage-e60ecdffee25

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


