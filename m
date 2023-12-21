Return-Path: <linux-kernel+bounces-8024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0775981B0C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393181C21689
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB5A24A1C;
	Thu, 21 Dec 2023 08:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWaeveQ9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3032F208B6;
	Thu, 21 Dec 2023 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703148870; x=1734684870;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nPqbnaHiW6+MXK3XW+N9OxQlTqrsdHfKbFZUo5uWY3g=;
  b=SWaeveQ9kJ1DJF8NJJ3PyVjUwBaVVq3eaJCwpFiA1QfV02ECPR9GSkDO
   9qy1egz+bnXEB+4p+4hWKuGFePb5NjazbTc1UXqKjpz1ccYF1eB8tvD2l
   jvE4b7Te/t2tf/fNVpYXLIkpFwHXICrUDTj8aAnNNDdU1X1rIab89eYh/
   aNCKjAUjGNR5Kr1PC602bcRBWCaAGOuAKtjqqgRsbPPL3/nL8cwXmIknI
   YYpPuiMQS18XuaJBEqPxIEZwrejEfDyw1umZLVE4siYuTv6gcnRh0G5AT
   3QDZyU89M6mdM8ZJiyCOyFWyG+tTVHoZ1BikXZnTuISaSNe6xiK+mDLgZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2793664"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="2793664"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 00:54:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="842568301"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="842568301"
Received: from ssid-ilbpg3-teeminta.png.intel.com (HELO localhost.localdomain) ([10.88.227.74])
  by fmsmga008.fm.intel.com with ESMTP; 21 Dec 2023 00:54:23 -0800
From: "Gan, Yi Fang" <yi.fang.gan@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	John Stultz <jstultz@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Gan Yi Fang <yi.fang.gan@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Looi Hong Aun <hong.aun.looi@intel.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Lai Peter Jun Ann <peter.jun.ann.lai@intel.com>,
	Choong Yong Liang <yong.liang.choong@intel.com>
Subject: [PATCH net v2 0/2] Fix phylink unloadable issue
Date: Thu, 21 Dec 2023 16:51:07 +0800
Message-Id: <20231221085109.2830794-1-yi.fang.gan@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add module_exit_stub() for phylink module.

Changes since v1:
- Introduce a helper macro for module_exit() boilerplate

This series is the combination of following:
v1 with empty phylink_exit():
https://lore.kernel.org/all/20231127101603.807593-1-yi.fang.gan@intel.com/
v1 of module_exit_stub():
https://lore.kernel.org/all/20231212094352.2263283-1-yi.fang.gan@intel.com/

Gan, Yi Fang (2):
  driver.h: add helper macro for module_exit() boilerplate
  net: phylink: Add module_exit_stub()

 drivers/net/phy/phylink.c     |  1 +
 include/linux/device/driver.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

-- 
2.34.1


