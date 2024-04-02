Return-Path: <linux-kernel+bounces-128617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133F2895D1B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FED288F1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A2415E810;
	Tue,  2 Apr 2024 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AL625d/P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C871C15E210;
	Tue,  2 Apr 2024 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087602; cv=none; b=V16Ic0gCcevljtM7Z6HoELImx21Wu5WP9mJ9cEjkoHJDENkotWova2fN/KD9TiYaRxU9YE8Z+cHc1tALYVbkVBDE49LSqGNrcZm3hEA7hW3m+fMwhqyB6Fqg9FPd4OYnBlwk+0nXz4vbu2Fwy5n1jmNW4oKC1vhAUeMfQwRoTGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087602; c=relaxed/simple;
	bh=FRoH8PTNS0jkAV8BXxBX4MyiYJGH6z8PP4TdQp9eq98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7cSaXHENfVAT76l+xHj7RL+M6mO0uVSYth4oLDtHhgwcrWaEzkkbOXkMKXIXHPhETXc2ItU/NwpgI6GPLXzTawAn1BysqpjMwCLYJWXt0U2TcQg5mBafsUEDaopXl06TNY25gGCfXhElCAdiunSkQR7aofMm3m/ZCEw5fqW37A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AL625d/P; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087601; x=1743623601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FRoH8PTNS0jkAV8BXxBX4MyiYJGH6z8PP4TdQp9eq98=;
  b=AL625d/Puf00EMryrPJ90ec9I6THgBWyL8lbzLtnqejuflZxTrQccv5p
   sfazKW2U+TsrHEnDKXXZ5/D3OWEBDFFQfBjmEu/7Jo8DxL2gsgShgiHzs
   mtO4pbl32W7nKqd2SeGPova7JuSMiv9dQ0VQdmhf1Q0oz+yR/6XIm2nN7
   ocixye9Nf7rOk6upauRVdTQB2UzqKu4vIp+g/kSdeLOaVmiacRsO8Rwpz
   xmPNTx8lHjqwpAexzydL5EA3jA7HdlcRylGy8pEsYxt+7bx8koJ7T7Er9
   f+g21n3qq2zVOW+vH9gmVicBS0vQdehA1KNbalBDMYOMNEZ9G5ktnSlb6
   A==;
X-CSE-ConnectionGUID: rBCBXVpVSAGc/pGleVxvXQ==
X-CSE-MsgGUID: cUO1b6gGTkOP01OA51vEeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7151034"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7151034"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083794"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083794"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3192F1567; Tue,  2 Apr 2024 22:53:10 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 11/16] serial: max3100: Replace MODULE_ALIAS() with respective ID tables
Date: Tue,  2 Apr 2024 22:50:38 +0300
Message-ID: <20240402195306.269276-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
References: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MODULE_ALIAS() in most cases is a pure hack to avoid placing ID tables.
Replace it with the respective ID tables.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index d287fb377523..7cbb8c096b47 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/serial_core.h>
@@ -842,13 +843,27 @@ static SIMPLE_DEV_PM_OPS(max3100_pm_ops, max3100_suspend, max3100_resume);
 #define MAX3100_PM_OPS NULL
 #endif
 
+static const struct spi_device_id max3100_spi_id[] = {
+	{ "max3100" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, max3100_spi_id);
+
+static const struct of_device_id max3100_of_match[] = {
+	{ .compatible = "maxim,max3100" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max3100_of_match);
+
 static struct spi_driver max3100_driver = {
 	.driver = {
 		.name		= "max3100",
+		.of_match_table	= max3100_of_match,
 		.pm		= MAX3100_PM_OPS,
 	},
 	.probe		= max3100_probe,
 	.remove		= max3100_remove,
+	.id_table	= max3100_spi_id,
 };
 
 module_spi_driver(max3100_driver);
@@ -856,4 +871,3 @@ module_spi_driver(max3100_driver);
 MODULE_DESCRIPTION("MAX3100 driver");
 MODULE_AUTHOR("Christian Pellegrin <chripell@evolware.org>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("spi:max3100");
-- 
2.43.0.rc1.1.gbec44491f096


