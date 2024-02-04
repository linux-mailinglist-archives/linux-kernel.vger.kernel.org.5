Return-Path: <linux-kernel+bounces-51399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF32848ACE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA43F2847E0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6771864;
	Sun,  4 Feb 2024 03:24:37 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686B87493;
	Sun,  4 Feb 2024 03:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707017076; cv=none; b=GJzvJUGq46i+Bp6fTG9NyppS4LBe7kXYksNTsj4HF/Sx8+K+GcQnw+0mpaAlWmBU0fqHQ4SEWgYKE6sp9FlnTPvL8ja5ecOTbpkVh97oPD1AUdRZWn0K2pqPrsXrh1RYj20xP/0aCPEE81JjJX3osURRRV9Ok22u3sEGpaphsrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707017076; c=relaxed/simple;
	bh=yDtEU9udkSi9sX7/bNnaQ8KwNv6DdunABj3WnokyXc0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DeAWfcW7xV4Nj3+sLUw5f/ES4/ngN+pJqVimgky1bLvshnwKfJ1Bf8THXTJ5pxOtrqyid0Y4p447mhHFBLzgdUv9SfILDaLCwKtCr0z+iQxGYBgYm8lp5zOMNjKbrcr0dujV1KV3DXzzYgBVzPkTYtcbS4c/SJ6hnvrHY+FKC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TSFFs0mWZz1xnB5;
	Sun,  4 Feb 2024 11:23:13 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 121CA1A016C;
	Sun,  4 Feb 2024 11:24:17 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 11:24:16 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <tony@atomide.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
CC: <john.ogness@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
	<tglx@linutronix.de>, <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH] serial: port: Don't suspend if the port is still busy
Date: Sun, 4 Feb 2024 11:19:57 +0800
Message-ID: <20240204031957.58176-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)

From: Yicong Yang <yangyicong@hisilicon.com>

We accidently met the issue that the bash prompt is not shown after the
previous command done and until the next input if there's only one CPU
(In our issue other CPUs are isolated by isolcpus=). Further analysis
shows it's because the port entering runtime suspend even if there's
still pending chars in the buffer and the pending chars will only be
processed in next device resuming. We are using amba-pl011 and the
problematic flow is like below:

Bash                                         kworker
tty_write()
  file_tty_write()
    n_tty_write()
      uart_write()
        __uart_start()
          pm_runtime_get() // wakeup waker
            queue_work()
                                             pm_runtime_work()
                                               rpm_resume()
                                                status = RPM_RESUMING
                                                serial_port_runtime_resume()
                                                  port->ops->start_tx()
                                                    pl011_tx_chars()
                                                      uart_write_wakeup()
        […]
        __uart_start()
          pm_runtime_get() < 0 // because runtime status = RPM_RESUMING
                               // later data are not commit to the port driver
                                                status = RPM_ACTIVE
                                                rpm_idle() -> rpm_suspend()

This patch tries to fix this by checking the port busy before entering
runtime suspending. A runtime_suspend callback is added for the port
driver. When entering runtime suspend the callback is invoked, if there's
still pending chars in the buffer then request an runtime resume for
handling this.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/tty/serial/serial_port.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 88975a4df306..60d1eec6b6b7 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -46,8 +46,28 @@ static int serial_port_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int serial_port_runtime_suspend(struct device *dev)
+{
+	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
+	struct uart_port *port;
+	unsigned long flags;
+
+	port = port_dev->port;
+
+	if (port->flags & UPF_DEAD)
+		return 0;
+
+	spin_lock_irqsave(&port->lock, flags);
+	if (__serial_port_busy(port))
+		pm_request_resume(dev);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return 0;
+}
+
 static DEFINE_RUNTIME_DEV_PM_OPS(serial_port_pm,
-				 NULL, serial_port_runtime_resume, NULL);
+				 serial_port_runtime_suspend,
+				 serial_port_runtime_resume, NULL);
 
 static int serial_port_probe(struct device *dev)
 {
-- 
2.24.0


