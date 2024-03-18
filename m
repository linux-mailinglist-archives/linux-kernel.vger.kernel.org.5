Return-Path: <linux-kernel+bounces-105790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4671B87E481
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FAC2816A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D323B249F9;
	Mon, 18 Mar 2024 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ayo13BD7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F62261D;
	Mon, 18 Mar 2024 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748665; cv=none; b=AhTrntp7zsFBWSaenTpl9j2ojDO5hySijO8PhmjMObbsKEetdJwcpLDJDgqr90SzpXjkkne+1/3tIkDhZPhJVKaiBJ+OzotMX9wPPgoXvMieuQCimpwbbdpx8rbwrCgzYKdvpKsUDFkAt/UoMf2GRVCbEpt6UIY+g77phXAkT2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748665; c=relaxed/simple;
	bh=vG0ILHc3WEdGfPTWFb0roc26USlSLGUmrwQf6d5DJ6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KXkmZ9sCIg0CeeyH3CFeUxZ/lm9NOe45C3/L9CMCnxozE0r3vgA7jlm5mCuTony8sCs/uE+rShaXv3sACDjtA4W6//HkgJbkAbSK+kgqOFtsiJFL5Zqw8fqDCWCk8wdcN0WPZGl78z2vVDCMiER23HfNmDoitRpCxQ/DNuSn+O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ayo13BD7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710748664; x=1742284664;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vG0ILHc3WEdGfPTWFb0roc26USlSLGUmrwQf6d5DJ6o=;
  b=Ayo13BD7POjinRAYxQJGSvM+uHoWDxtU/znybITAQZlcqRSP5dyjSiyK
   mDX7LTE5q5DKx42GpyABaPHEOSXF6oNc3hVtC8PZUqKSR4EBBtK3nTwp6
   TryLGUXWOCDzYvYyuKg8MSuTVkdUrSNhq7hs8qmN/QHWKgYJGEdeyt20s
   3Bs7S+ULYCNNV+deoEWQWHSMzRrr3w+UwId7V/7gwm/fZoZdeMm2+J+iB
   rfjKL/3HD4HRiEKJaU7vWgAUVnvUWdFIjCMcCXDslh+eNJBTc1ym0Jm7e
   AcYlI7Awn0VQnrI/8hb7ID35fjCKHCwuNOMT2o5Vdc/dc8UpKC7fMIK/D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="23063846"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="23063846"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 00:57:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="44431172"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 00:57:41 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id F186B11F853;
	Mon, 18 Mar 2024 09:57:38 +0200 (EET)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1rm7sI-00Bnsy-36;
	Mon, 18 Mar 2024 09:57:38 +0200
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wentong Wu <wentong.wu@intel.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 6.8 1/1] mei: vsc: Don't use sleeping condition in wait_event_timeout()
Date: Mon, 18 Mar 2024 09:57:28 +0200
Message-Id: <20240318075728.2813360-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit b8b19acfafdeacbedd4e2795cb18c81c4d8bb6cc upstream.

vsc_tp_wakeup_request() called wait_event_timeout() with
gpiod_get_value_cansleep() which may sleep, and does so as the
implementation is that of gpio-ljca.

Move the GPIO state check outside the call.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-and-Reviewed-by: Wentong Wu <wentong.wu@intel.com>
Link: https://lore.kernel.org/r/20240219195807.517742-3-sakari.ailus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/misc/mei/vsc-tp.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 55f7db490d3b..03486bebae09 100644
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


