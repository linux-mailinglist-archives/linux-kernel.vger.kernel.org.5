Return-Path: <linux-kernel+bounces-32570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BBD835D55
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29512812A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73AC3A8EB;
	Mon, 22 Jan 2024 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="h08WuhIX"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0E3987D;
	Mon, 22 Jan 2024 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913390; cv=none; b=gt1ll7kWqY0yCjWm89O78swzHPcLxzwJwkGN8CrT8IT9/3FGT/sjHpzq86I2opB/TDd/kPjSRmQHkcBffo8yoxRCvWWSTcREwlJh3ODdFgM+vx5lZtZwOUJCdTcUxm7cr4g9kedLmUP7SIlB8ma/+CAdMqK9h4WlRa9OqG9TyvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913390; c=relaxed/simple;
	bh=6ipTFW19SsGxZbI2l0X1rvEIY26wje19A4UbQtxlQTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HazgQ1NnZ1e5OOp4h630frDmN7CSvsMYC0MfSUI9l3zkrcL81fcU5KLRd8SeLH4d2GpNpbgRGEWqGr2aA1q0B505w/1zj7TNlXmJANJDwTcIuTthk0HumK+6QnyR6VV+axyVVLNUwn5JneUhQMZbWs401P8m+Ip7/bi3Vt4oULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=h08WuhIX; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TJP6b62fFz67tb;
	Mon, 22 Jan 2024 09:49:43 +0100 (CET)
Received: from andreas.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4TJP6b2Hygz67wS;
	Mon, 22 Jan 2024 09:49:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1705913383;
	bh=9XXrcrmw+2MKD2v7K/RcBLkXjOChbZMqTOF3cEVBhRU=;
	h=From:To:Cc:Subject:Date;
	b=h08WuhIXQolwPgCNDCU3iEJDkKIR0ph8vwUtV2DsgR1U7oUZ7a1Q0rAeXf3uDymot
	 9umqz2Uj2ezq25284w9SZBqiBKFkNLk8HKLcwtY8zVzMNzsGB+j6gM9S19YSxDegyC
	 V9TBjaGr4LymxEc2HaZiasWWKxPyqopXioDJAsdM=
From: Andreas Larsson <andreas@gaisler.com>
To: Alan Stern <stern@rowland.harvard.edu>,
	linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	software@gaisler.com
Subject: [PATCH] usb: uhci-grlib: Explicitly include linux/platform_device.h
Date: Mon, 22 Jan 2024 09:22:25 +0100
Message-Id: <20240122082225.984523-1-andreas@gaisler.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes relying upon linux/of_platform.h to include
linux/platform_device.h, which it no longer does, thereby fixing
compilation problems like:

In file included from drivers/usb/host/uhci-hcd.c:850:
drivers/usb/host/uhci-grlib.c: In function 'uhci_hcd_grlib_probe':
drivers/usb/host/uhci-grlib.c:92:29: error: invalid use of undefined type 'struct platform_device'
   92 |  struct device_node *dn = op->dev.of_node;
      |                             ^~

Fixes: 0d18bcdebb2f ("of: Stop circularly including of_device.h and of_platform.h")
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/usb/host/uhci-grlib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/uhci-grlib.c b/drivers/usb/host/uhci-grlib.c
index ac3fc5970315..cfebb833668e 100644
--- a/drivers/usb/host/uhci-grlib.c
+++ b/drivers/usb/host/uhci-grlib.c
@@ -22,6 +22,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 static int uhci_grlib_init(struct usb_hcd *hcd)
 {
-- 
2.34.1


