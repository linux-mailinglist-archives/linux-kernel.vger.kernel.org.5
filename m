Return-Path: <linux-kernel+bounces-15097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D415822737
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B581F230DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C16B4A14;
	Wed,  3 Jan 2024 02:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IBcYPolr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F94A13
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704250440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jKg88EOc19Ldtm/CDT5Vvu/qnifyLXpVN7rl8hsod6M=;
	b=IBcYPolrqPHkbUIAacMiHDSykXqfpBH/JtWC+mGENXrqYgL+J+GAviTeW33XVK+uKQ1aUS
	ej/JQPXJgzMZ1yzFAgvVC05anwGGffEMZwtKkv0a2HHKQVnbVTS0baW3X1EC0h9bgW5f+f
	OMbJajn+6efsgCyejh9OuK9uc6Zqufo=
From: Yajun Deng <yajun.deng@linux.dev>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	przemyslaw.kitszel@intel.com,
	rmk+kernel@armlinux.org.uk,
	kabel@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next v2 0/2] net: phy: Use is_phy_driver() and is_phy_device()
Date: Wed,  3 Jan 2024 10:53:32 +0800
Message-Id: <20240103025334.541682-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There is only one flag that can be set in struct mdio_driver_common and
mdio_device. We can compare the probe of the driver or the type of the
device to implement it. Hence, these flags in struct mdio_driver_common
and mdio_device can be removed.

Introduce is_phy_driver() and is_phy_device(). Use them test the driver
or device.

v1 -> v2:
remove redundant parens and the exported.

Yajun Deng (2):
  net: phy: Cleanup struct mdio_driver_common and introduce
    is_phy_driver()
  net: phy: Introduce is_phy_device()

 drivers/net/dsa/b53/b53_mdio.c          |  2 +-
 drivers/net/dsa/dsa_loop.c              |  2 +-
 drivers/net/dsa/lan9303_mdio.c          |  2 +-
 drivers/net/dsa/microchip/ksz8863_smi.c |  2 +-
 drivers/net/dsa/mt7530-mdio.c           |  2 +-
 drivers/net/dsa/mv88e6060.c             |  2 +-
 drivers/net/dsa/mv88e6xxx/chip.c        |  2 +-
 drivers/net/dsa/qca/ar9331.c            |  2 +-
 drivers/net/dsa/qca/qca8k-8xxx.c        |  2 +-
 drivers/net/dsa/realtek/realtek-mdio.c  |  2 +-
 drivers/net/dsa/xrs700x/xrs700x_mdio.c  |  2 +-
 drivers/net/phy/mdio_bus.c              |  7 ++--
 drivers/net/phy/mdio_device.c           | 21 +++++-------
 drivers/net/phy/phy_device.c            | 44 ++++++++++++++-----------
 drivers/net/phy/xilinx_gmii2rgmii.c     |  2 +-
 drivers/phy/broadcom/phy-bcm-ns-usb3.c  |  8 ++---
 drivers/phy/broadcom/phy-bcm-ns2-pcie.c |  8 ++---
 include/linux/mdio.h                    | 19 ++---------
 include/linux/phy.h                     | 10 +++---
 19 files changed, 62 insertions(+), 79 deletions(-)

-- 
2.25.1


