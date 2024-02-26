Return-Path: <linux-kernel+bounces-81803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 165C7867A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38331F24172
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455BD12C520;
	Mon, 26 Feb 2024 15:28:30 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147FC12BE92;
	Mon, 26 Feb 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961309; cv=none; b=U+skVjTmpGOKwhTronKkO1PVH41TOfZccmu/WtH8CLAH3FL9tGuhd+HZzMmPMKA86pzv2gGKm4UqSBbpmLmfgLtWo92K3xCzzxz+GBiKAoNwzrqV3SbemdXl6IdprqAPfsso2N9rG6QyK2QY56OhSp0kCbSp/Ah+uK5im6xr7B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961309; c=relaxed/simple;
	bh=vQ+IFaWXgRCRA+uzfCOIXLaOPJBKy/2Ip4I8Pxm/Ja0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z8ONNhH0gfGPA50D/NOKIan/ROon5gL6xiVjidx6ihycz5uADEvhrIlP3QvXapOZVIvY342KtF0lUGYALFKOVLDOLc0QSAhd+VGlpltuAPcUO8un3B63RU1j+/XyKZFQidnnPCRRcyxAYu9ByBePtLBxqySHjdAzdES/FhnxjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Tk4Hc3BgqzLqKT;
	Mon, 26 Feb 2024 23:27:40 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id D867414011D;
	Mon, 26 Feb 2024 23:28:18 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 23:28:18 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <tony@atomide.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
CC: <john.ogness@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
	<tglx@linutronix.de>, <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH v5] serial: port: Don't suspend if the port is still busy
Date: Mon, 26 Feb 2024 23:23:51 +0800
Message-ID: <20240226152351.40924-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
still pending chars in the buffer then flush the buffer.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Reviewed-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Change since v4:
- Address the code style per Andy and add his tag
Thanks.
Link: https://lore.kernel.org/all/Zdi9X8qzQhNE3rGl@smile.fi.intel.com/

Change since v3:
- Drop non-fix change in __serial_port_busy()
- Use a boolen busy instead of ret per Jiri
Link: https://lore.kernel.org/all/20240208075216.48915-1-yangyicong@huawei.com/

Change since v2:
- Narrow the spinlock region per Andy
- Make __serial_port_busy() return -EBUSY if port has pending chars per Andy
Thanks.
Link: https://lore.kernel.org/all/20240206073322.5560-1-yangyicong@huawei.com/

Change since v1:
- Use port lock wrapper per John
- Flush the pending chars and return -EBUSY per Tony.
Thanks.
Link: https://lore.kernel.org/all/20240204031957.58176-1-yangyicong@huawei.com/

 drivers/tty/serial/serial_port.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 88975a4df306..72b6f4f326e2 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -46,8 +46,31 @@ static int serial_port_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int serial_port_runtime_suspend(struct device *dev)
+{
+	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
+	struct uart_port *port = port_dev->port;
+	unsigned long flags;
+	bool busy;
+
+	if (port->flags & UPF_DEAD)
+		return 0;
+
+	uart_port_lock_irqsave(port, &flags);
+	busy = __serial_port_busy(port);
+	if (busy)
+		port->ops->start_tx(port);
+	uart_port_unlock_irqrestore(port, flags);
+
+	if (busy)
+		pm_runtime_mark_last_busy(dev);
+
+	return busy ? -EBUSY : 0;
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


