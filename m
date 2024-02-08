Return-Path: <linux-kernel+bounces-57577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE6784DAEA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 130F5B218B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821F769E1B;
	Thu,  8 Feb 2024 07:56:40 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513E669E00;
	Thu,  8 Feb 2024 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707379000; cv=none; b=o634+OJ+hgj5PGzoszPpkPGmRhlt3gCD5MuAPE98zShwfsiuXCUgeEykKYHUNZH31bqWpmNgFIQga9Bvc1up9ET6hq0dzurgEfL5T5TCXu4aa9FwTUH5u9J0ExYxXvMLFN0PKwAGP68JqDMlAAPlO0fJtWwMoxqmStiKWZuuIOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707379000; c=relaxed/simple;
	bh=2STkhIj0WFVqUpOVShUJc9z+p/pw7S2gBImDUWUPLXk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V/jkllYu+tgUyToT6aOzNoa/i4peqzcB2xsOOc+fU68HqDc/k2RXjRNnrCwZu4WcYesG2ZqdTXTOL8K0XYcKv+EoyegpCdMNO1OEBCVdE3a71WX804XYeNgIxcCeK/jkXsInnb/lY6AtAtqJWLhubK+xa3kMM7hdiU9pz0iMoZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TVq6t0K9kz1vsbR;
	Thu,  8 Feb 2024 15:56:06 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B845140444;
	Thu,  8 Feb 2024 15:56:34 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 15:56:27 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <tony@atomide.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
CC: <john.ogness@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
	<tglx@linutronix.de>, <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH v3] serial: port: Don't suspend if the port is still busy
Date: Thu, 8 Feb 2024 15:52:15 +0800
Message-ID: <20240208075216.48915-1-yangyicong@huawei.com>
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

Cc: Tony Lindgren <tony@atomide.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
---
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

 drivers/tty/serial/serial_port.c | 36 +++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
index 88975a4df306..8d72f7d95009 100644
--- a/drivers/tty/serial/serial_port.c
+++ b/drivers/tty/serial/serial_port.c
@@ -19,8 +19,13 @@
 /* Only considers pending TX for now. Caller must take care of locking */
 static int __serial_port_busy(struct uart_port *port)
 {
-	return !uart_tx_stopped(port) &&
-		uart_circ_chars_pending(&port->state->xmit);
+	if (uart_tx_stopped(port))
+		return 0;
+
+	if (uart_circ_chars_pending(&port->state->xmit))
+		return -EBUSY;
+
+	return 0;
 }
 
 static int serial_port_runtime_resume(struct device *dev)
@@ -46,8 +51,33 @@ static int serial_port_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int serial_port_runtime_suspend(struct device *dev)
+{
+	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
+	struct uart_port *port;
+	unsigned long flags;
+	int ret;
+
+	port = port_dev->port;
+
+	if (port->flags & UPF_DEAD)
+		return 0;
+
+	uart_port_lock_irqsave(port, &flags);
+	ret = __serial_port_busy(port);
+	if (ret)
+		port->ops->start_tx(port);
+	uart_port_unlock_irqrestore(port, flags);
+
+	if (ret)
+		pm_runtime_mark_last_busy(dev);
+
+	return ret;
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


