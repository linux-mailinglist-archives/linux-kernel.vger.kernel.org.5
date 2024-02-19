Return-Path: <linux-kernel+bounces-71933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CB085ACAE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B082A2865C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFF5535AB;
	Mon, 19 Feb 2024 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KseJSHvp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B24251C3B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372700; cv=none; b=Yjx/apO242M+IylS9M/Isl5rQjBApd25A42pVv7dTb2OKkMDwfXNvkazDEKefaWQfV7nRWTTRMscpTC+INmBj+YBJeXlrlRq88pEnfBMAuub1NxxzRaTTj89jWRJH0Lrzvxp1fwQDpmNVdLVqUbnw34h/UhVjucoGFVIIChv8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372700; c=relaxed/simple;
	bh=LQfcvhDhukePnMMEY/6b22ES5Z9aTSaVbHBODDBxTV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/SwLuo3IyrtkwH5zk2G/fWM+fbvb/HXLYLPFxddf1schAyvCCHCet1rEs7YGlhojZDzfhI/PQL3+BYTPxPBE4yZ56qEUoCL07TwteVsqItZ0694BkaUa0tJZeOEpobvVPHc7Dseal57cfNS5tpg/j9TO/g/EeqFf0N2B3yLCEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KseJSHvp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708372699; x=1739908699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LQfcvhDhukePnMMEY/6b22ES5Z9aTSaVbHBODDBxTV4=;
  b=KseJSHvpEc1wtknMgeWZqvKEV5RoHg64hxMw4ETuO6xp6gh3lsdchTtI
   yEU9KjXu3vG4EXmDcBdn5rcwsoAb+p9saUiJjc/rdNJ8yoPWts8XKijm+
   p6b8osnGKLGgh8Y9G6lRaKIXJeJSB5Q10ekxHVEKuIo6oTtP4N6uMGHqz
   fWuSvJ5qKtMgbs7xhuuyxCb3qCRSagyTac/CMZrJXNJ7Qoth6NEEi0pkq
   nwsinAcRy/8FlK5AtwROGMsmSYO1J4GCnOxIBBtS3LyVlOmmiYG+39/b7
   ypuWaHWyfcCTI/uW1JxaBeBzP9ETi1VmjIayqPZLMnOgC8Ir03qFrc2r1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="19893443"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19893443"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 11:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9239483"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 11:58:15 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 770F411FB11;
	Mon, 19 Feb 2024 21:58:10 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wentong Wu <wentong.wu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/3] mei: vsc: Don't use sleeping condition in wait_event_timeout()
Date: Mon, 19 Feb 2024 21:58:06 +0200
Message-Id: <20240219195807.517742-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
References: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vsc_tp_wakeup_request() called wait_event_timeout() with
gpiod_get_value_cansleep() which may sleep, and does so as the
implementation is that of gpio-ljca.

Move the GPIO state check outside the call.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/misc/mei/vsc-tp.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 2b69ada9349e..7b678005652b 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -25,7 +25,8 @@
 #define VSC_TP_ROM_BOOTUP_DELAY_MS		10
 #define VSC_TP_ROM_XFER_POLL_TIMEOUT_US		(500 * USEC_PER_MSEC)
 #define VSC_TP_ROM_XFER_POLL_DELAY_US		(20 * USEC_PER_MSEC)
-#define VSC_TP_WAIT_FW_ASSERTED_TIMEOUT		(2 * HZ)
+#define VSC_TP_WAIT_FW_POLL_TIMEOUT		(2 * HZ)
+#define VSC_TP_WAIT_FW_POLL_DELAY_US		(20 * USEC_PER_MSEC)
 #define VSC_TP_MAX_XFER_COUNT			5
 
 #define VSC_TP_PACKET_SYNC			0x31
@@ -101,13 +102,15 @@ static int vsc_tp_wakeup_request(struct vsc_tp *tp)
 	gpiod_set_value_cansleep(tp->wakeupfw, 0);
 
 	ret = wait_event_timeout(tp->xfer_wait,
-				 atomic_read(&tp->assert_cnt) &&
-				 gpiod_get_value_cansleep(tp->wakeuphost),
-				 VSC_TP_WAIT_FW_ASSERTED_TIMEOUT);
+				 atomic_read(&tp->assert_cnt),
+				 VSC_TP_WAIT_FW_POLL_TIMEOUT);
 	if (!ret)
 		return -ETIMEDOUT;
 
-	return 0;
+	return read_poll_timeout(gpiod_get_value_cansleep, ret, ret,
+				 VSC_TP_WAIT_FW_POLL_DELAY_US,
+				 VSC_TP_WAIT_FW_POLL_TIMEOUT, false,
+				 tp->wakeuphost);
 }
 
 static void vsc_tp_wakeup_release(struct vsc_tp *tp)
-- 
2.39.2


