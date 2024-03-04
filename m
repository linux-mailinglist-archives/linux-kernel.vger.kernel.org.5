Return-Path: <linux-kernel+bounces-91017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0E9870881
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0EE81C21A56
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FB5612D8;
	Mon,  4 Mar 2024 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRI8vrcT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3636025E;
	Mon,  4 Mar 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574151; cv=none; b=DwvZUmhgkIVjPOdAgvss99PZORKmLFHkuEnHlycr1gw2kn+9lNodDH8poNaOiGisT1h+0MDPwtDLemuDP8x0vp/jK+RmFAlolzUUFmD/2lXxLJ9GLmkmRyAEzrPz9vvsIbqnID+HFElRNWSiJj94ytvtV4CrXRNEQzWAeq/pKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574151; c=relaxed/simple;
	bh=h4x1z5kFcsXRs0S1/1xtxHnLDvLTTR1q1CynXjth2QY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DN5lHQyJF2AEGPTaZGIPihiy999yMsO26xagTccvJoba5dslBVKku5Ryjf1HRNbpVdZIod/hAC/7Ox1XNPnF6oCEB+q1TkQyPqPxK3leeDKhRdHrVH/i8GMR9zQNG/z0bql++x4Pn8AiH+oBQIR66E23DHxpNyCSoDPCMFXSYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRI8vrcT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709574150; x=1741110150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h4x1z5kFcsXRs0S1/1xtxHnLDvLTTR1q1CynXjth2QY=;
  b=kRI8vrcTR/5ddpBbCu98rxFZ1JcPkq8/hDa0bLfdMj77lNYhJqlVq3xk
   X4E23X8F3wmE03HDv6vGGGeTxuVjUjT/7f10Bo+EEoOm39lXpt8es48SN
   JB2x3zlgSQrQPMDNosdO2DGxW1/GjuOMZBveHD68D7EPgbeIiWO0Qmw+Z
   uvPEstj+d+/unf7gTV91A6px1DaUcp6TwGXrggPcndy8ZGVFzYkV0uqY/
   EBv33GFc/xpl4wwad/r9sOld/TBMQO/LjPFJYafx9ArhBIDUcKQGMN1S5
   w6gN66d36oYDR2ruEOXf0JCtJubgMpJV2cGjd3mO8VNI2U4QReya2y4y6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4208207"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4208207"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 09:42:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937040903"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="937040903"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 09:42:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AB22E15C; Mon,  4 Mar 2024 19:42:22 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] ieee802154: at86rf230: Replace of_gpio.h by proper one
Date: Mon,  4 Mar 2024 19:42:17 +0200
Message-ID: <20240304174218.1198411-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it directly, replace it
with what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ieee802154/at86rf230.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 6212164ffb36..f632b0cfd5ae 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -11,17 +11,16 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/hrtimer.h>
 #include <linux/jiffies.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/regmap.h>
 #include <linux/skbuff.h>
-#include <linux/of_gpio.h>
 #include <linux/ieee802154.h>
 
 #include <net/mac802154.h>
-- 
2.43.0.rc1.1.gbec44491f096


