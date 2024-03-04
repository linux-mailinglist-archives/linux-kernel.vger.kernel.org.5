Return-Path: <linux-kernel+bounces-91077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2670E870949
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22CC1F21E7C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7C6626C0;
	Mon,  4 Mar 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="F3akSMUd"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AFE60261;
	Mon,  4 Mar 2024 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576076; cv=none; b=ZuAGbKAmbI+TDLmI01XBGfGJUWe2cpv8S+8Cbmhd3B+qDmrk0wpfPIMkMAmrcCjGYoVWCFjWDmn5WviihButQr6KmEcXAioz7gijTg2awQTcuzhGlrqpFFJ4BSx1D/oMFswFvDfMwjRLOfVgFZAkXXgUArQTtCFdHIkSVjigepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576076; c=relaxed/simple;
	bh=yCWM8ixm9Q5GJtAr9YxRI0nlBbJJJ+jn3PUBaQAZXt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EuSGTTwqlYbDg0q+qIJH+zvQe2jq5E4LFKnTTxHGBPnSy/OpweRhknpzwBmmk5UUMtOiSts/iTVV7zGpvZOR3RjcaUeOmUQg4qYbthNLlzsRHWy+jckFuGjH7FZLVAo7+RFG6VmvetMr3Q5X0ySsTk/e1emSRqHQco/PE/mX7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=F3akSMUd; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 7A4251F91A;
	Mon,  4 Mar 2024 19:14:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1709576069;
	bh=AG195yM7a11qN4a7vlK78xakfrw+QRDW32XY1+id4RI=; h=From:To:Subject;
	b=F3akSMUd2drSZbXyLgkMXFMLCzSUJhqLLfITyU5Nkzov1zsxr8Lw+cT3ZzwvNmLSt
	 tksLq0wk0LNiofR/WqPzc1u/oG6w/7Bl25BOV05/yQvVa/EvoytJbQqaHmCEtN0hlO
	 eiZEqcmpFlN7NdTkvOM00maD1AEwDp2YZVDJdhYPF8wdy4X2Z6ha4Qa6JzbkracCbo
	 H08/wuhDz7JRZFr0MfvoDHbtn6xOUZtsP6kS/n9T+yEswZpJDg2xxN4SY7yyF8OJvK
	 ECHJ7+TQx9nK/ghWDe3f7bxd6AnXB66XihXd01f05xaK+rxzVUNCIhLy6fxk2bPuO8
	 ivMyo8/OmYL4g==
From: Francesco Dolcini <francesco@dolcini.it>
To: Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2] Bluetooth: btnxpuart: Fix btnxpuart_close
Date: Mon,  4 Mar 2024 19:14:21 +0100
Message-Id: <20240304181421.14777-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix scheduling while atomic BUG in btnxpuart_close(), properly
purge the transmit queue and free the receive skb.

[   10.973809] BUG: scheduling while atomic: kworker/u9:0/80/0x00000002
..
[   10.980740] CPU: 3 PID: 80 Comm: kworker/u9:0 Not tainted 6.8.0-rc7-0.0.0-devel-00005-g61fdfceacf09 #1
[   10.980751] Hardware name: Toradex Verdin AM62 WB on Dahlia Board (DT)
[   10.980760] Workqueue: hci0 hci_power_off [bluetooth]
[   10.981169] Call trace:
..
[   10.981363]  uart_update_mctrl+0x58/0x78
[   10.981373]  uart_dtr_rts+0x104/0x114
[   10.981381]  tty_port_shutdown+0xd4/0xdc
[   10.981396]  tty_port_close+0x40/0xbc
[   10.981407]  uart_close+0x34/0x9c
[   10.981414]  ttyport_close+0x50/0x94
[   10.981430]  serdev_device_close+0x40/0x50
[   10.981442]  btnxpuart_close+0x24/0x98 [btnxpuart]
[   10.981469]  hci_dev_close_sync+0x2d8/0x718 [bluetooth]
[   10.981728]  hci_dev_do_close+0x2c/0x70 [bluetooth]
[   10.981862]  hci_power_off+0x20/0x64 [bluetooth]

Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Cc: stable@vger.kernel.org
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
[ fd: reword commit message ]
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2:
 - reword commit message
 - added rb neeraj
v1: https://lore.kernel.org/all/20231018145540.34014-2-marcel@ziswiler.com/
---
 drivers/bluetooth/btnxpuart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 55b6e3dcd4ec..0b93c2ff29e4 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1252,6 +1252,9 @@ static int btnxpuart_close(struct hci_dev *hdev)
 
 	ps_wakeup(nxpdev);
 	serdev_device_close(nxpdev->serdev);
+	skb_queue_purge(&nxpdev->txq);
+	kfree_skb(nxpdev->rx_skb);
+	nxpdev->rx_skb = NULL;
 	clear_bit(BTNXPUART_SERDEV_OPEN, &nxpdev->tx_state);
 	return 0;
 }
-- 
2.39.2


