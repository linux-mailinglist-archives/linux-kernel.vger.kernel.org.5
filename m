Return-Path: <linux-kernel+bounces-10820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DFB81DC55
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 21:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A521C21535
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA46DDDD;
	Sun, 24 Dec 2023 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mrman314.tech header.i=@mrman314.tech header.b="hFt2K9xd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx.mrman314.tech (unknown [135.0.77.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7700ADF46;
	Sun, 24 Dec 2023 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mrman314.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mrman314.tech
Received: from mail.mrman314.tech (localhost [127.0.0.1])
	by mx.mrman314.tech (Postfix) with ESMTPSA id 17F672F491CF;
	Sun, 24 Dec 2023 15:30:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mrman314.tech;
	s=default; t=1703449801;
	bh=HLhCanTpi2kJGYS9gLHHc1vwS5SyQPA78Qz2/DkYtL0=;
	h=Date:From:To:Cc:Subject;
	b=hFt2K9xdAQiZ5g4qvVy0S57ck54wT/JuFPLlt90Mw2yc9QCpIJnIGTTQ8eq1CpRZG
	 Vc4ZVhJa9/k+Tdu0e15h75z94QrIVuYvm/J/QPE+5FonBULXAnBoQow3pDMifIpGCf
	 4JEkYrpvPhcX6CLE42MF8ZMT5mVtMOC7ciwt9/Qo=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 24 Dec 2023 15:29:59 -0500
From: Felix Zhang <mrman@mrman314.tech>
To: linux-bluetooth@vger.kernel.org
Cc: marcan@marcan.st, bagasdotme@gmail.com, sven@svenpeter.dev,
 alyssa@rosenzweig.io, marcel@holtmann.org, johan.hedberg@gmail.com,
 luiz.dentz@gmail.com, orlandoch.dev@gmail.com, kekrby@gmail.com,
 admin@kodeit.net, j@jannau.net, gargaditya08@live.com,
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel MacBooks
Message-ID: <c9dd2a5e99e032dc181344fd0359aac9@mrman314.tech>
X-Sender: mrman@mrman314.tech
Organization: MrMan
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Starting v6.5, Bluetooth does not work at all on my T2 MacBookAir9,1 
with
the BCM4377 chip.  When I boot up the computer, go into bluetoothctl, 
and
then try to run commands like scan on, show, list, it returns "No 
default
controller available."  I have tried reloading the kernel module, in 
which
the log outputs "{Added,Removed} hci0 (unconfigured)."  With this patch, 
I
am able to use Bluetooth as normal without any errors regarding hci0 
being
unconfigured.  However, an issue is still present where sometimes
hci_bcm4377 will have to be reloaded in order to get bluetooth to work.  
I
believe this was still present before the previously mentioned commit.

Due to the bit HCI_QUIRK_USE_BDADDR_PROPERTY being always set in
drivers/bluetooth/hci_bcm4377.c(line 2371), the chip would be left
unconfigured on kernels compiled after commit 6945795bc81a ("Bluetooth:
fix use-bdaddr-property quirk") due to a change in its logic.  On the M1
Macs, the device would be configured in the devicetree.  However, that 
is
not the case on T2 Macs.  Because the bluetooth adapter is left
unconfigured, it is not usable in the operating system.  In order to
circumvent this issue, a flag is added to prevent the bit from being set 
on
the BCM4377, while setting it on the other devices.

Because I do not have an M1 device to test this patch on, I am not sure
whether the patch breaks anything for said devices.  I would be very
grateful if anyone is willing to test this patch on their M1 device.

I would also like to thank Kerem Karabay <kekrby@gmail.com> for 
assisting
me with this patch.

Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
Signed-off-by: Felix Zhang <mrman@mrman314.tech>
---
  drivers/bluetooth/hci_bcm4377.c | 6 +++++-
  1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c 
b/drivers/bluetooth/hci_bcm4377.c
index a61757835695..5c6fef1aa0f6 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -513,6 +513,7 @@ struct bcm4377_hw {
  	unsigned long broken_ext_scan : 1;
  	unsigned long broken_mws_transport_config : 1;
  	unsigned long broken_le_coded : 1;
+	unsigned long use_bdaddr_property : 1;

  	int (*send_calibration)(struct bcm4377_data *bcm4377);
  	int (*send_ptb)(struct bcm4377_data *bcm4377,
@@ -2368,7 +2369,8 @@ static int bcm4377_probe(struct pci_dev *pdev, 
const struct pci_device_id *id)
  	hdev->set_bdaddr = bcm4377_hci_set_bdaddr;
  	hdev->setup = bcm4377_hci_setup;

-	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+	if (bcm4377->hw->use_bdaddr_property)
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
  	if (bcm4377->hw->broken_mws_transport_config)
  		set_bit(HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG, &hdev->quirks);
  	if (bcm4377->hw->broken_ext_scan)
@@ -2465,6 +2467,7 @@ static const struct bcm4377_hw 
bcm4377_hw_variants[] = {
  		.has_bar0_core2_window2 = true,
  		.broken_mws_transport_config = true,
  		.broken_le_coded = true,
+		.use_bdaddr_property = true,
  		.send_calibration = bcm4378_send_calibration,
  		.send_ptb = bcm4378_send_ptb,
  	},
@@ -2479,6 +2482,7 @@ static const struct bcm4377_hw 
bcm4377_hw_variants[] = {
  		.clear_pciecfg_subsystem_ctrl_bit19 = true,
  		.broken_mws_transport_config = true,
  		.broken_le_coded = true,
+		.use_bdaddr_property = true,
  		.send_calibration = bcm4387_send_calibration,
  		.send_ptb = bcm4378_send_ptb,
  	},
--
2.43.0

