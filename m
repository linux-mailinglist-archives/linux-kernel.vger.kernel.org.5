Return-Path: <linux-kernel+bounces-25290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D14682CCC5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 14:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A16F284A2D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 13:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EF921119;
	Sat, 13 Jan 2024 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="v5HYG+Ks"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30753F500;
	Sat, 13 Jan 2024 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705151834; x=1736687834;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nbm89IVPwSbs+XUOYfVbDyLJJ83rqgMv2JmnBE8fqic=;
  b=v5HYG+KsQMaS5OXTbiirFtaDb4wUKzk6g5GOVpdt9nQznzcPjZJSQgt4
   goMUvXcJ6ZouT5VnWLDvllgmwb+rOuDgA6GI+qfYRCtW0ls1NTUm+MQlB
   cR+M+RBBuIUR+MBiG/eBuyO+kGM+F4TDGiwmfqQ/iYL09L4OGtmA8sOeY
   8EKzlG+CFFaNYaDqHSs16MSbTZF/ZcU2i9kCO8mw6FlFuz2IhydYPI3wK
   xlmcUInei2J9P6RFN3Xhh5bzI0wIWmEITweN/srPHI6OaPgbmxf59croe
   mv2kQ0JTNg6sZtbEQlHU92cK5YDEAgbruPC5nslxNLH4hoIOFM0hKgfLF
   Q==;
X-CSE-ConnectionGUID: XyTF/spfTOquMExVK+Xxwg==
X-CSE-MsgGUID: pd9Sgua7S4+9kq9oS414rw==
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="14724191"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jan 2024 06:17:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 13 Jan 2024 06:17:04 -0700
Received: from DEN-DL-M31836.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sat, 13 Jan 2024 06:17:01 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>,
	<Divya.Koppera@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net 0/2] net: micrel: Fixes for PHC for lan8814
Date: Sat, 13 Jan 2024 14:15:19 +0100
Message-ID: <20240113131521.1051921-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

There are different issues with the PHC of lan8814.
First issue is similar with the one on lan8841 which it has enabled by
default the check regarding minorVersionPTP in the PTP header frame.
So all the frames compliant to 8021AS will not be timestamped.
The second issue is with setting and getting the time of the PHC. The
issue is seen only when setting a time which is bigger than 2^32.

Horatiu Vultur (2):
  net: micrel: Fix PTP frame parsing for lan8814
  net: micrel: Fix set/get PHC time for lan8814

 drivers/net/phy/micrel.c | 68 +++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

-- 
2.34.1


