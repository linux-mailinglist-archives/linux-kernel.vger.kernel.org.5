Return-Path: <linux-kernel+bounces-91038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072EF8708C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6341283BEA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825BF62142;
	Mon,  4 Mar 2024 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kf171TZ3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689984CE1F;
	Mon,  4 Mar 2024 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574819; cv=none; b=rpubvf6aK4HF6p91e3oqnBay40ZNp08dUDGQ566UNAsIKqvIswlbl3LcP8eTBtFWyd85nb58XuuEjEdgumNRR3oq4y4myDyS8lULk1FliI1GJzGaZY0fH9Cebee0uZrvKZz6BSNFwehKuc87HBLDccYNYB2Ny58LzVLo88u5bR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574819; c=relaxed/simple;
	bh=VmPBQAo+O4pSeKZpfQTbNLjLkFoqxXjZB3tUorREFJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kgnG/1qkkzYY4QCSLWJwCiNYW5TfBvB27d2JfhhBEWoX+kFN4QGkOMiWSPdKWyf2EmFKMD4IYTeR5d40lE+ky62JQK4iXj5PnMzy7QkBGR0B1Q2+AzlVbnkvkxIUgo14oaJNEJNr0ULzFaSl6s7eedqzI7TIvkKmWoGB9vMhMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kf171TZ3; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709574818; x=1741110818;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VmPBQAo+O4pSeKZpfQTbNLjLkFoqxXjZB3tUorREFJA=;
  b=kf171TZ3n9lVKgc4yM1cM4AvPdtv431CbBeG2+O/57ef2acykkmM00nB
   Xm0CanldwkxaiUWBg0TJsh6vVHbiyokNvtdfZypZ8sKPdY6kdWKAf/HE3
   Npv8YC35h/mHh02O56yKHEF8Ffe1vJnw2aEXBjWBK5Ea6tdAZtq7vUJyj
   JRp+xTqPLo1B6Kns7YeIKa4TlFiA4whL8bNMnmoDsSAPxnHMAklBGpGBh
   WM1uKSq3AweVBxk+tFYK2ZAdrmzE7Gs2G8ZbKuvlAyGwRnCyLNVvPSVEP
   Gn+EJAMACMr/7iRxUtPZaRspFNH2yR2AYrzJsTYu93SzOJQD9haQXgiHY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4210015"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4210015"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 09:53:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937040906"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="937040906"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 09:53:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3C80915C; Mon,  4 Mar 2024 19:53:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] ieee802154: mcr20a: Remove unused of_gpio.h
Date: Mon,  4 Mar 2024 19:53:20 +0200
Message-ID: <20240304175320.1199496-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ieee802154/mcr20a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index efb1be3c644e..433fb5839203 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -12,7 +12,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/skbuff.h>
-#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/ieee802154.h>
 #include <linux/debugfs.h>
-- 
2.43.0.rc1.1.gbec44491f096


