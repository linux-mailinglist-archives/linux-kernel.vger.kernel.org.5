Return-Path: <linux-kernel+bounces-152980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2398AC709
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FEDFB20AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86244502A8;
	Mon, 22 Apr 2024 08:32:44 +0000 (UTC)
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD5433C2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774764; cv=none; b=XWAz1BP8GWCDSqIpyzPtjr/dJhJG1aZVYdLnZjFGwiXRekeHdN7Xy7rPUIlKqtykkuY5iOWh58gWXK6tDesL3cqXnAnGXaoYqsz4ioyxW3sM8jpc6lcYiSLNjVVYfxGwDx5if/L0sSoyk1JT9HJaojnppP72KHAZG4zbjQAP8ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774764; c=relaxed/simple;
	bh=psC1NXyYFFU81tuyqjnY6lvR07j1XHlE3uIZYen4cbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9mrfluke6nrUWU3IDuY/vqQrz5PqXe1ZDPCVzWmdFsaKy1E3bWIxL1CqNFNvPMqMNEgC/3REMRkQAw0LJoX2msM5iGkknr36/tcZ/LY+B/XVMyv6vldH3WV5rJkK5jzRusfR5oUfjDNwl4F7FeUX1eesiigycwYM8jFPSIukcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id e0d47807-0082-11ef-a9de-005056bdf889;
	Mon, 22 Apr 2024 11:32:39 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] serial: 8250_pnp: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Mon, 22 Apr 2024 11:32:37 +0300
Message-ID: <20240422083237.207447-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The SIMPLE_DEV_PM_OPS() is deprecated, replace it with the
DEFINE_SIMPLE_DEV_PM_OPS() and use pm_sleep_ptr() for setting
the driver's PM routines.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/tty/serial/8250/8250_pnp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 8f72a7de1d1d5..9188902fa5b35 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -10,6 +10,7 @@
  */
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm.h>
 #include <linux/pnp.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -506,7 +507,7 @@ static void serial_pnp_remove(struct pnp_dev *dev)
 		serial8250_unregister_port(line - 1);
 }
 
-static int __maybe_unused serial_pnp_suspend(struct device *dev)
+static int serial_pnp_suspend(struct device *dev)
 {
 	long line = (long)dev_get_drvdata(dev);
 
@@ -516,7 +517,7 @@ static int __maybe_unused serial_pnp_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused serial_pnp_resume(struct device *dev)
+static int serial_pnp_resume(struct device *dev)
 {
 	long line = (long)dev_get_drvdata(dev);
 
@@ -526,14 +527,14 @@ static int __maybe_unused serial_pnp_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(serial_pnp_pm_ops, serial_pnp_suspend, serial_pnp_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(serial_pnp_pm_ops, serial_pnp_suspend, serial_pnp_resume);
 
 static struct pnp_driver serial_pnp_driver = {
 	.name		= "serial",
 	.probe		= serial_pnp_probe,
 	.remove		= serial_pnp_remove,
 	.driver         = {
-		.pm     = &serial_pnp_pm_ops,
+		.pm     = pm_sleep_ptr(&serial_pnp_pm_ops),
 	},
 	.id_table	= pnp_dev_table,
 };
-- 
2.44.0


