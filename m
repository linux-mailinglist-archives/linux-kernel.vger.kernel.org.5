Return-Path: <linux-kernel+bounces-91752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEEA871614
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D61286CB2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178507C085;
	Tue,  5 Mar 2024 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="hLwFKGu1"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AB643AC5;
	Tue,  5 Mar 2024 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709621565; cv=none; b=BTNDV7Ap7xPAXfRwNruWcx2CY2LKStOb0F0hAyEVpiI9RrqzP05MXmfal5erxIX4t5ubuKGY8Oj+z2VFkqpFmVm0HMuAR+S2jOSjNoZsZjLEbEI62xyVMc7iz3EfZk+8rqOQtPqUj44VyvEecO/Grg7MKUn3Khm7u3rFg0VX958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709621565; c=relaxed/simple;
	bh=Xl+NCBuHbQxBZioSRlhLg3TlowiKCzujKqHgkDS3MS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PPKemSZW4VaHKJeaPpaEADQf/ZhFDmFhazDjYrgrSyGPfjLlCKLIqCFKttjAlfcWpDGztRz+PlaXbi6IxSnZ3+EhJy4I8gv3RiiVv+zdvdP2o1l+SnZvV89wevN1iQEo+IaHfB6MQ3WhxFQWLk2hV7ctEl4B9JpqkzdCcNiRSis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=hLwFKGu1; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E276A3F2AE;
	Tue,  5 Mar 2024 06:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1709621555;
	bh=hOacwtkHqQDUtoSDhM1+VFe2+ipCciOvzGFqmRzEolQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=hLwFKGu1voOVMAkHhJ7o5DqJ98eJqAaJ4/PaMQSRtS4EZrFd6vxEfF99vM39fb9I6
	 cQUq7Bpr3MsOvX+aMqiFTcPW1dLDjOhZ9T5cE5b1RFNzclLjMN4wRnL0DZEfGm0daL
	 YmI5L8VAvu5XfFy4DifBZyZNgiyjbyzEEkJPuQCfl/pnzTAJ7zprWrEcyEgh4ttd30
	 2okyz/IlHxD2b41YHIVD0WTomccmIOyUdl158o6crllkJcxkSQqXasYCCxwf4Yr5X6
	 KGGSUy93vs1Rt0dUs9GkQfrI52j8v2pip3KcIngRf97J8MGaRhCxdcPiSGvsDKN8Bx
	 w0jONP9etUJhA==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: gregkh@linuxfoundation.org
Cc: stern@rowland.harvard.edu,
	mathias.nyman@linux.intel.com,
	oneukum@suse.com,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Roy Luo <royluo@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: Disable USB3 LPM at shutdown
Date: Tue,  5 Mar 2024 14:51:38 +0800
Message-Id: <20240305065140.66801-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SanDisks USB3 storage may disapper after system reboot:

usb usb2-port3: link state change
xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x2c0
usb usb2-port3: do warm reset, port only
xhci_hcd 0000:00:14.0: xhci_hub_status_data: stopping usb2 port polling
xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2b0, return 0x2b0
usb usb2-port3: not warm reset yet, waiting 50ms
xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2f0, return 0x2f0
usb usb2-port3: not warm reset yet, waiting 200ms
..
xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x6802c0, return 0x7002c0
usb usb2-port3: not warm reset yet, waiting 200ms
xhci_hcd 0000:00:14.0: clear port3 reset change, portsc: 0x4802c0
xhci_hcd 0000:00:14.0: clear port3 warm(BH) reset change, portsc: 0x4002c0
xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x2c0
xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x2c0, return 0x2c0
usb usb2-port3: not enabled, trying warm reset again...

This is due to the USB device still cause port change event after xHCI is
shuted down:

xhci_hcd 0000:38:00.0: // Setting command ring address to 0xffffe001
xhci_hcd 0000:38:00.0: xhci_resume: starting usb3 port polling.
xhci_hcd 0000:38:00.0: xhci_hub_status_data: stopping usb4 port polling
xhci_hcd 0000:38:00.0: xhci_hub_status_data: stopping usb3 port polling
xhci_hcd 0000:38:00.0: hcd_pci_runtime_resume: 0
xhci_hcd 0000:38:00.0: xhci_shutdown: stopping usb3 port polling.
xhci_hcd 0000:38:00.0: // Halt the HC
xhci_hcd 0000:38:00.0: xhci_shutdown completed - status = 1
xhci_hcd 0000:00:14.0: xhci_shutdown: stopping usb1 port polling.
xhci_hcd 0000:00:14.0: // Halt the HC
xhci_hcd 0000:00:14.0: xhci_shutdown completed - status = 1
xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x1203, return 0x203
xhci_hcd 0000:00:14.0: set port reset, actual port 2-3 status  = 0x1311
xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x201203, return 0x100203
xhci_hcd 0000:00:14.0: clear port3 reset change, portsc: 0x1203
xhci_hcd 0000:00:14.0: clear port3 warm(BH) reset change, portsc: 0x1203
xhci_hcd 0000:00:14.0: clear port3 link state change, portsc: 0x1203
xhci_hcd 0000:00:14.0: clear port3 connect change, portsc: 0x1203
xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x1203, return 0x203
usb 2-3: device not accepting address 2, error -108
xhci_hcd 0000:00:14.0: xHCI dying or halted, can't queue_command
xhci_hcd 0000:00:14.0: Set port 2-3 link state, portsc: 0x1203, write 0x11261
xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x1263, return 0x263
xhci_hcd 0000:00:14.0: set port reset, actual port 2-3 status  = 0x1271
xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x12b1, return 0x2b1
usb usb2-port3: not reset yet, waiting 60ms
ACPI: PM: Preparing to enter system sleep state S5
xhci_hcd 0000:00:14.0: Get port status 2-3 read: 0x12f1, return 0x2f1
usb usb2-port3: not reset yet, waiting 200ms
reboot: Restarting system

The port change event is caused by LPM transition, so disabling LPM at shutdown
to make sure the device is in U0 for warmboot.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/port.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index c628c1abc907..c50266d7ce9d 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -418,8 +418,10 @@ static void usb_port_shutdown(struct device *dev)
 {
 	struct usb_port *port_dev = to_usb_port(dev);
 
-	if (port_dev->child)
+	if (port_dev->child) {
 		usb_disable_usb2_hardware_lpm(port_dev->child);
+		usb_unlocked_disable_lpm(port_dev->child);
+	}
 }
 
 static const struct dev_pm_ops usb_port_pm_ops = {
-- 
2.34.1


