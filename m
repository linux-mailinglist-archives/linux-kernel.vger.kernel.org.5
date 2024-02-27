Return-Path: <linux-kernel+bounces-82973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6204868C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E870E1C23109
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399CB7BAE7;
	Tue, 27 Feb 2024 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TxJJHgRB"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565513699A;
	Tue, 27 Feb 2024 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026812; cv=none; b=kE7p7+sex8DLj5DNbPYLwvZTbkLEb/5v8df2g5AAjnkztPWmw/T19nq8naD5HWHHigKJVs8RtIfHkOVFSF71yYEj4j3QB9In8jyTtJjlGMunBRKvnebP40F3LykM+9REkctzqcGmBzxSu8cTVPum4yIUweujyWQW9YQrUYWywEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026812; c=relaxed/simple;
	bh=8r24iKPhibOS40zxMGUMNspSc4hHZnzNSAnmzkFnOuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5wupXkC8BC1x4zgsJl/LkEHziJWfIt889GUNw6ZVROqogDNYlHDkF6WP/CQaglQdH893uv1IoN6PmqS2Sgq0bKyXSB4MV+HkaeqTdeXTFdEdqymuHKZVG4wUf/LUJCyfurOolMbfrB1qHfXx0rSqpod/1tEJvkG6fsbWBV6hTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TxJJHgRB; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2F16A1BF20D;
	Tue, 27 Feb 2024 09:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709026801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6AJf+zzN7UHsiDVB1kdGMfmPws28cjDW3HCy8ItyxK8=;
	b=TxJJHgRBlziCllHZOJT4RWWHW7gaP3x6pfe/Ui3GaJsL45Xar59xbK+U5IWRw5W6t1GCid
	AWjoJB8O5pXFF4NIjfuHb78p/K/JgkOXAufKjW49BLNuqZh1GQ2wikgW6rNTmxI38A8JaY
	ZqYTfx5rN4nrh4g/g0URnJ0majjlVNsVROBWVtca43tea+0oTmnuZSZ5JGQYFs2+jWYJGy
	fCxZpLdrQq1IshfWDlv/xP3ZDKNM8TZAhVmiDgZobjyMehuPRfb6I0ySq7bCSOffyDnaWM
	rQBbkukWN3Fi3ElTonkCO4jDt6Ng1pELeivZsBhXiptLzCW1Fxno7sHuy6aghA==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	maxime.chevallier@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH v2 0/6] net: phy: Add TI's DP83640 device tree binding
Date: Tue, 27 Feb 2024 10:39:39 +0100
Message-ID: <20240227093945.21525-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi everyone,

This patch series adds small features to the TI PHY DP83640 :
  - Add LED handling through /sys/class/leds to use the three
    configuration modes offered by PHY.
  - Add Energy Detect Mode handling through ethtool's
    {get/set}_phy_tunable()
  - Add a device tree attribute to be able to override the hardware
    strap configuration if needed. This attribute allows to
    enable/disable fiber mode.

Change log v1 -> v2 :
  - LED Configuration is now done through /sys/class/leds insted of DT
  - Energy Detect Mode is done from {set/get}_phy_tunable() instead of DT
  - The DT property to enable/disable PHY control frames is dropped,
    the feature is disabled directly in driver as it is not handled
    anyway.
  - The CLK_OUT pin handling has been dropped.

Bastien Curutchet (6):
  dt-bindings: net: Add bindings for PHY DP83640
  leds: trigger: Create a new LED netdev trigger for collision
  net: phy: DP83640: Add LED handling
  net: phy: DP83640: Add EDPD management
  net: phy: DP83640: Explicitly disabling PHY Control Frames
  net: phy: DP83640: Add fiber mode enabling/disabling from device tree

 .../testing/sysfs-class-led-trigger-netdev    |  11 +
 .../devicetree/bindings/net/ti,dp83640.yaml   |  77 +++++
 drivers/leds/trigger/ledtrig-netdev.c         |   4 +
 drivers/net/phy/dp83640.c                     | 299 ++++++++++++++++++
 drivers/net/phy/dp83640_reg.h                 |  24 ++
 include/linux/leds.h                          |   1 +
 6 files changed, 416 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,dp83640.yaml

-- 
2.43.0


