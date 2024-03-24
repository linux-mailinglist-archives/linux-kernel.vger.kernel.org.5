Return-Path: <linux-kernel+bounces-113523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEFD888503
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244D81F227EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076FE13DDDC;
	Sun, 24 Mar 2024 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l61SKecK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB513DDC0;
	Sun, 24 Mar 2024 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320325; cv=none; b=INAUmq97LBYpnS84HN4EnmGEWRz6M3nmfOUXrfREU+8Apls1JevQHpL6hxIsyxBlldhla4quo/sdDM2p/MEO1vQVQj8CM/c8ZmvGz3snQxZF74wxa271zNzzCAcFgUJ3DysBYhg2j+/oGBhwqRrQaBTdfe9YChAcNqLKv+V5zAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320325; c=relaxed/simple;
	bh=ArYKYqU7frp1Dl3+qp4fleofAfeQEKMgQdDiu9ogk3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHBh9rv3RazB3Dt6npL3qUZ9zGgCiUUc9u4zmlTgTjN2LCRsLvdnFIFIwHJLY3pFeblOXU3ywwCKLuGhIxnXiBI7/DVy4JmhZLPYZlfpSmrsxiQm3OmxBXjqsHnfB+gPZm4UMDrpogg4MaqlENI0v8yp42l1vS/cpAaJGBSZjxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l61SKecK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48ACDC43390;
	Sun, 24 Mar 2024 22:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320325;
	bh=ArYKYqU7frp1Dl3+qp4fleofAfeQEKMgQdDiu9ogk3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l61SKecKlk8xQXzmBT/Wx0Sm/ntin+nbic2k1nIvHMG4R6+aeg18lTdcn0JBq+azP
	 3CyFdsGmpS6deF9dtaciqJN5OpZywQ5x/7OkN+c4BO/CISu4yUN+/yHda7TlzAWNHJ
	 mj0xZcpgf8S6AyXxiBKoWFBUCOPYLd+9pxx4aHksN90flqTxZSMRB39NukrpaooUNV
	 zrVNGtlXEdNbZbIAFAxYtDbch2sRdiUMW1en7VwREbvRGZJKQzoexbDWmxSlcD4XXJ
	 MCE28FSGYuxG7S4FS9Lz1LkSGTZY27gM93T5x1uya5q1l8PV35HQ0Oj8vxo9Tjq/Dh
	 caVLZDGDgKnfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Wentong Wu <wentong.wu@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 632/715] mei: vsc: Don't use sleeping condition in wait_event_timeout()
Date: Sun, 24 Mar 2024 18:33:31 -0400
Message-ID: <20240324223455.1342824-633-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit b8b19acfafdeacbedd4e2795cb18c81c4d8bb6cc ]

vsc_tp_wakeup_request() called wait_event_timeout() with
gpiod_get_value_cansleep() which may sleep, and does so as the
implementation is that of gpio-ljca.

Move the GPIO state check outside the call.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-and-Reviewed-by: Wentong Wu <wentong.wu@intel.com>
Link: https://lore.kernel.org/r/20240219195807.517742-3-sakari.ailus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/mei/vsc-tp.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 0e623700c3b0e..682c62c635b63 100644
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
2.43.0


