Return-Path: <linux-kernel+bounces-128610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C29895D0C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CBF286735
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436E815D5C7;
	Tue,  2 Apr 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jdlv6+1C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33BF15CD54;
	Tue,  2 Apr 2024 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087597; cv=none; b=gT1kBnCn807V7N7bHzCl7WhpUNZvpFPxytxeKNF8aWqSSP2yWzIMNyM5M0IefSwJRyVePQmCgoI+Fzq6yscuTG8Dir0qzgHI9VoQYaeMaPlow7AL3I+derxJa7B551/7GoN+wcI7zB7FMTkNhUyDPti+9/4GPzVYl96V3EokT1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087597; c=relaxed/simple;
	bh=xJUqvEi+qmStZVvR5xGTQUGRPj6WLU9SeicD1FyZC5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhWp+XtPKeVeJkEoBKbDzNm8R4Q0FchXvBadK7yBp6LOxe9FrO/QoiWVUtkBloWMvNSHFOIy8r2tAxu2FGVIbmQHfB3XQe0MHx3tgbA0ZpeRSyOmJnBXQSZHYuLxi+uStGNf1L3v7JleUI7TWf6pYC85VYjEmkQmUhCvG15tH3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jdlv6+1C; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087596; x=1743623596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xJUqvEi+qmStZVvR5xGTQUGRPj6WLU9SeicD1FyZC5Q=;
  b=Jdlv6+1C0esL8GwQnw+VoLUOTb+qnojQoFt4zsG7o+acVkOKhwLBdS98
   0jnOSCVXi8lR2fWGhKGcnMvQEfXXBE9JTYVbk0Z8lU3MgVRFwaH/6ZWV3
   39G5yiK02T/TO8xxGSqQET7lKmzDMCWLg0ShaAplaGZkKLaFPZUEb4icH
   h9TGePZVu8bI4WEbe3xSbIdSkKaSXjE79ZbGrAaPEq2aMkVkpxuZr1MQd
   ojmKa2R6TuK8+p/w/95kS79U+qDc1ayiPQqNIJYN/BEwD5dzhduVfOlaN
   /3te1HrsKwcXncbEJ6kOb9DcmWsItgR9Oo9wnmU9hDzqIiXLzc+tLdl8H
   w==;
X-CSE-ConnectionGUID: etxwTR86Qzyk4JW/0/dZ2w==
X-CSE-MsgGUID: lDMYPVjMSA6BFrTkCFnLJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7150984"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7150984"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083783"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083783"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C02BD506; Tue,  2 Apr 2024 22:53:09 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 02/16] serial: max3100: Update uart_driver_registered on driver removal
Date: Tue,  2 Apr 2024 22:50:29 +0300
Message-ID: <20240402195306.269276-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
References: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The removal of the last MAX3100 device triggers the removal of
the driver. However, code doesn't update the respective global
variable and after insmod — rmmod — insmod cycle the kernel
oopses:

  max3100 spi-PRP0001:01: max3100_probe: adding port 0
  BUG: kernel NULL pointer dereference, address: 0000000000000408
  ...
  RIP: 0010:serial_core_register_port+0xa0/0x840
  ...
   max3100_probe+0x1b6/0x280 [max3100]
   spi_probe+0x8d/0xb0

Update the actual state so next time UART driver will be registered
again.

Hugo also noticed, that the error path in the probe also affected
by having the variable set, and not cleared. Instead of clearing it
move the assignment after the successfull uart_register_driver() call.

Fixes: 7831d56b0a35 ("tty: MAX3100")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 45022f2909f0..b3e63b6a402e 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -749,13 +749,14 @@ static int max3100_probe(struct spi_device *spi)
 	mutex_lock(&max3100s_lock);
 
 	if (!uart_driver_registered) {
-		uart_driver_registered = 1;
 		retval = uart_register_driver(&max3100_uart_driver);
 		if (retval) {
 			printk(KERN_ERR "Couldn't register max3100 uart driver\n");
 			mutex_unlock(&max3100s_lock);
 			return retval;
 		}
+
+		uart_driver_registered = 1;
 	}
 
 	for (i = 0; i < MAX_MAX3100; i++)
@@ -841,6 +842,7 @@ static void max3100_remove(struct spi_device *spi)
 		}
 	pr_debug("removing max3100 driver\n");
 	uart_unregister_driver(&max3100_uart_driver);
+	uart_driver_registered = 0;
 
 	mutex_unlock(&max3100s_lock);
 }
-- 
2.43.0.rc1.1.gbec44491f096


