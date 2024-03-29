Return-Path: <linux-kernel+bounces-123976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35FA891092
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5E8D1C26B79
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B0C1DA4D;
	Fri, 29 Mar 2024 01:51:02 +0000 (UTC)
Received: from sgoci-sdnproxy-3.icoremail.net (sgoci-sdnproxy-3.icoremail.net [129.150.43.208])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AA5182A1;
	Fri, 29 Mar 2024 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.43.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677061; cv=none; b=Cdbp6rW0AiBh4iT0TgVYytdUZLjL+B/rCrgi7Jq1cqkoA1IHcadEFFNw9ZlpaCIPIPYcqZTn0UR8RMxdQw+MwjRXXrGRrdLkN8LEQewd+Tqs3pYSjJPKmJIeom5xy2x9ZP6tZqKzMEC6QPCQFLa87R+bJvWaKz9GWLpgq1mDAh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677061; c=relaxed/simple;
	bh=kdQyyQBMIEjlK+X0qlZWblq2x6AYDkJPK7XzD/A9dp0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Ql7rDGZKlcOwY2krqCJDUXiu3W+pNviORyNlZDIIuA26pqDBLBw3q6/1VIIQSyQo6GX8RnweUnjQyt0TjZ6ssA5v0JFnW/77x7FoVr232DhTYGEAE0Eo6AjdDoFRV16+77UpeG2s5FnL3J+2t2dxIdHdMSH4AqK80Sqqp3m/+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.43.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.17.138])
	by mail-app4 (Coremail) with SMTP id cS_KCgDXZ7tgHgZmtKiBAQ--.26409S2;
	Fri, 29 Mar 2024 09:50:33 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hams@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	jreuter@yaina.de,
	horms@kernel.org,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net v2] ax25: fix use-after-free bugs caused by ax25_ds_del_timer
Date: Fri, 29 Mar 2024 09:50:23 +0800
Message-Id: <20240329015023.9223-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cS_KCgDXZ7tgHgZmtKiBAQ--.26409S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GFykXFWUCFW7GFW3Kr18Grg_yoW8JF1rpF
	WqgF17AFZ7ZryUKa1kWFn7Wr1UAryjq3ykCFy8CF4S9wn7Xa4DJFy8K3yvqFW7GFZ5Jr1k
	Cw18Ww45uFn09F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwUPAWYFdZkKbgADsg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When the ax25 device is detaching, the ax25_dev_device_down()
calls ax25_ds_del_timer() to cleanup the slave_timer. When
the timer handler is running, the ax25_ds_del_timer() that
calls del_timer() in it will return directly. As a result,
the use-after-free bugs could happen, one of the scenarios
is shown below:

      (Thread 1)          |      (Thread 2)
                          | ax25_ds_timeout()
ax25_dev_device_down()    |
  ax25_ds_del_timer()     |
    del_timer()           |
  ax25_dev_put() //FREE   |
                          |  ax25_dev-> //USE

In order to mitigate bugs, when the device is detaching, use
timer_shutdown_sync() to stop the timer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Call timer_shutdown_sync() in ax25_dev_device_down().

 net/ax25/ax25_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index c5462486dbc..282ec581c07 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -105,7 +105,7 @@ void ax25_dev_device_down(struct net_device *dev)
 	spin_lock_bh(&ax25_dev_lock);
 
 #ifdef CONFIG_AX25_DAMA_SLAVE
-	ax25_ds_del_timer(ax25_dev);
+	timer_shutdown_sync(&ax25_dev->dama.slave_timer);
 #endif
 
 	/*
-- 
2.17.1


