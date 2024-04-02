Return-Path: <linux-kernel+bounces-128256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C72895864
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5862870D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF96A134429;
	Tue,  2 Apr 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhRRKeZg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00C132C39;
	Tue,  2 Apr 2024 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072548; cv=none; b=WfAqcP8osRyOZPaR+UacYwkXBwB6fJxooLzj8Sx9B5LdxWOQ40KJMtYkwrYnXbo9qgAEeEkFK+bSnNqd9iKZkoRV3B99vV2+frvjYniI3KltNIZPiAd3iNabHT0DcdQrmhLOGAKPCKlKiMGtUEbtd9v0W9fx/KVayaZJ26ukyRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072548; c=relaxed/simple;
	bh=o78Fa752/ZOPs6iLperlSbDq86UPzIkFataSRBoiH5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjRj0BqSLS3ibp7ePEWLhmUNgNlQUCR8E51n7RtdMqPw/r5/32JZDAZDrAiQxIMfl4LbYlwdyFT9lYI7AO7WyloRDvt86VOjIFiVtMbPnW9mYHzb95AdnhTPusPFbGty2uJ4Ja9zZ4upGyyr8C5vzeGcSFIConENiJMeZO/shRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhRRKeZg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072546; x=1743608546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o78Fa752/ZOPs6iLperlSbDq86UPzIkFataSRBoiH5o=;
  b=JhRRKeZgk4TdfSlc/i8PRARSiAPC7EdrZF4A98iOdkLp7nedM49aAicx
   8BcCXCVQE0+DubNWlAldgI58xpIxFaBUSDLsbhUWw/NcabvPDd0f4/q+r
   +uGYI65LqCrrspLa5uf7aT8yDUqqdoAUqCk4JfXn2lZ2LVHoiEHERzVHK
   upVhcrn5sDpHekJMOsWF8qVslZ2NBZw4VNwVeglDxRWOKWR1+SEOdZ7R6
   2HxtXuy/UUV7hZlF9QqLHmDFvrbsNBJxIWVhXVL9FVmA9XvkQ2JMPIvnq
   VrixDaXGlDMU66mM1R6boHMJs8rwjFY1RwB5+xqHnptK0kaR3AZqOM4gQ
   A==;
X-CSE-ConnectionGUID: PV/v7GXrQkS+8xUl3pUVMg==
X-CSE-MsgGUID: cprVtvEMTNC684Nd5tUTtA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870055"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870055"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083636"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083636"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3506D506; Tue,  2 Apr 2024 18:42:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 02/16] serial: max3100: Update uart_driver_registered on driver removal
Date: Tue,  2 Apr 2024 18:38:08 +0300
Message-ID: <20240402154219.3583679-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
References: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
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

Fixes: 7831d56b0a35 ("tty: MAX3100")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 45022f2909f0..efe26f6d5ebf 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -841,6 +841,7 @@ static void max3100_remove(struct spi_device *spi)
 		}
 	pr_debug("removing max3100 driver\n");
 	uart_unregister_driver(&max3100_uart_driver);
+	uart_driver_registered = 0;
 
 	mutex_unlock(&max3100s_lock);
 }
-- 
2.43.0.rc1.1.gbec44491f096


