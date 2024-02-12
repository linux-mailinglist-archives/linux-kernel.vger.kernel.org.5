Return-Path: <linux-kernel+bounces-61257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 522EC850FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCBC284226
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA1417C71;
	Mon, 12 Feb 2024 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EccJ0nYs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A117BA5
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731188; cv=none; b=e+nVrQd61t/qL8W7BSL04iPr3sNsLnHBckVPYC7skjZntpT4s5hiKEjoxtkxh4FYKNvHGvXPJiCy+lzBvHCEEpFTsUBqXLEhMiqnEcjwcsGqeVfSqFSyyxmdjsjDgmcTKvyycF0ENPVDtrgXBfrLngUP2enhk2YnFIE6BrPWsow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731188; c=relaxed/simple;
	bh=AGYbs9qPmL9iRZGFK1NI5ZkY1cRcPzC4LVGVT1LS1wE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LiHebThg3kP5m1nNverwXH9BSgK3AZDRx3SHTp0NLoXUsQeTf9+j+DowtqW3uDzddvr65aoksltgGP8je/O4SOz1PlNsQMgFx+b64eEMmGw1OMVsHe86fTDPjwDOvICcpgx6iVf8y70DCnFw13cyqw2HRXn8PrJr9rLGAOZtvQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EccJ0nYs; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707731187; x=1739267187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AGYbs9qPmL9iRZGFK1NI5ZkY1cRcPzC4LVGVT1LS1wE=;
  b=EccJ0nYsrdcWMyFqk64oFuLw8d4atLS0NMzkngiFTIdiKMoykcf4caO6
   dX0Vf0Aw4mP6PzwewO+X7L0E2TnR+hP11CK8bvfqrg9z83GoISydYFdLN
   QI9NkRtd1AFLoo5oeK8dYc7UHXRBsZ3xexBkqS5hmMXHvCThUVmf8OZqe
   ev8t3iGSBFVm6tXzqxmVc5Xl0i6fMUB7XSkOaxBZNwxMrK4P0Wa5RG1ft
   7uw+npbHZNxNlNynKSCFU6YfTFic1tKyi03s/UPk6uZEmhGEXvFzcL0h5
   zBXq+c+6tMmbJgn2bBdAHyBcPTi9Hketxka3ftEP09KoH+36TvRNddW9h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="12335879"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="12335879"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 01:46:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="2502539"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 01:46:23 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 9C6DB11FA12;
	Mon, 12 Feb 2024 11:46:20 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wentong Wu <wentong.wu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/3] mei: vsc: Don't use sleeping condition in wait_event_timeout()
Date: Mon, 12 Feb 2024 11:46:17 +0200
Message-Id: <20240212094618.344921-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212094618.344921-1-sakari.ailus@linux.intel.com>
References: <20240212094618.344921-1-sakari.ailus@linux.intel.com>
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
index 264ece72f0bf..200af14490d7 100644
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
@@ -103,13 +104,15 @@ static int vsc_tp_wakeup_request(struct vsc_tp *tp)
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


