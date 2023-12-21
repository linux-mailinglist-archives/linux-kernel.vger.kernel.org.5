Return-Path: <linux-kernel+bounces-8025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A156D81B0C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF4F1F23ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6C21C687;
	Thu, 21 Dec 2023 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mt+sTEfa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B0538FA0;
	Thu, 21 Dec 2023 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703148879; x=1734684879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ba7Ldspb0L81io7WDsMQs1X2A/thFBlYyfgOhF/Vgg=;
  b=Mt+sTEfatZuHk+IlePDpUOOnyVhjOkOfworYqugNOlqHob/DXbNeUB8g
   I4pd/u7Q44CF4D/AChwmvw76ZswXoOliwei352toJz+hxmyh2eg2yHocy
   hXgeiZPK97mf72Ho4xMaArBjvEpr+aPyiS/ubvG2hVl1uBJDIB5k8dUjc
   S7lZlycmwZzmdU+sG3Q7a+EyECWT06mP1IzkxfGLRl7JMg8fVRteK2G6O
   P5qYe4uesbC2vPKO/P35TkuJF8Wr/8Yn/DUMKlnQfR8f8GRFb/o6LjKb/
   iJpIDNLFJsFkPAZVlAaz7Q8wvtJG2IKNOilJHXRS8AdoMrXQoED8lAf2i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2793693"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="2793693"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 00:54:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="842568329"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="842568329"
Received: from ssid-ilbpg3-teeminta.png.intel.com (HELO localhost.localdomain) ([10.88.227.74])
  by fmsmga008.fm.intel.com with ESMTP; 21 Dec 2023 00:54:32 -0800
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
Subject: [PATCH net v2 1/2] driver.h: add helper macro for module_exit() boilerplate
Date: Thu, 21 Dec 2023 16:51:08 +0800
Message-Id: <20231221085109.2830794-2-yi.fang.gan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221085109.2830794-1-yi.fang.gan@intel.com>
References: <20231221085109.2830794-1-yi.fang.gan@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the modules need a module_init() but don't need to do
anything special in module_exit() might need to have an empty
module_exit(). This patch add a new macro module_exit_stub() to
replace the empty module_exit(). The macro is useful to remove
the module_exit() boilerplate.

Cc: <stable@vger.kernel.org> # 6.1+
Suggested-by: Lobakin, Aleksander <aleksander.lobakin@intel.com>
Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
---
 include/linux/device/driver.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 7738f458995f..7d322eef501e 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -288,4 +288,18 @@ static int __init __driver##_init(void) \
 } \
 device_initcall(__driver##_init);
 
+/**
+ * module_exit_stub() - Helper macro for drivers that have init but don't
+ * do anything in exit. This eliminates some boilerplate.
+ * Each module may only use this macro once, and calling it replaces
+ * module_exit().
+ *
+ * @__driver: driver name
+ */
+#define module_exit_stub(__driver) \
+static void __exit __driver##_exit(void) \
+{ \
+} \
+module_exit(__driver##_exit)
+
 #endif	/* _DEVICE_DRIVER_H_ */
-- 
2.34.1


