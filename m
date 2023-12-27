Return-Path: <linux-kernel+bounces-11948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1C681EE12
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB9D1F21C35
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7852CCDC;
	Wed, 27 Dec 2023 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE5gY3Rg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731F42D602;
	Wed, 27 Dec 2023 10:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F71C433C8;
	Wed, 27 Dec 2023 10:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703671849;
	bh=HNX2qe5wIUjgAOE0bih0cYXbYbw77i5qRYAGTFhWf8Q=;
	h=From:To:Cc:Subject:Date:From;
	b=OE5gY3RgSNMMNpr/DemitpLvv8B5KUxkea+huKa97KhEilNAbl/OG/gZPSswoI3kl
	 ifwN2LiGgFt8jyQh8hVsCoIrrOOGgiqeJ9ivyZI86fxAmaICglCBVc65vzpPozQdYn
	 YsryqO/D6A6i3egHRr7G52DifE/DihYN9uZqhAIHTY+ESsr/mJvwodvV8HNt60TaF9
	 dFeWSj4rAgt/QaclFNs1wznkamzzJ3UloOq2NJbzC3F6ILEsWfuPRm8iKBlgwdNTZ+
	 bn4JmN3Zh0Mr2uaTVg902uWeLcZ93sY9BmqH1AOBDEXTlUvPd7n6xVrSnOLfdlTR5k
	 O5JKLTyyjvyTQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rIQs7-0002kc-0u;
	Wed, 27 Dec 2023 11:10:44 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Felix Zhang <mrman@mrman314.tech>
Subject: [PATCH] Bluetooth: hci_bcm4377: do not mark valid bd_addr as invalid
Date: Wed, 27 Dec 2023 11:10:03 +0100
Message-ID: <20231227101003.10534-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent commit restored the original (and still documented) semantics
for the HCI_QUIRK_USE_BDADDR_PROPERTY quirk so that the device address
is considered invalid unless an address is provided by firmware.

This specifically means that this flag must only be set for devices with
invalid addresses, but the Broadcom BCM4377 driver has so far been
setting this flag unconditionally.

Fortunately the driver already checks for invalid addresses during setup
and sets the HCI_QUIRK_INVALID_BDADDR flag, which can simply be replaced
with HCI_QUIRK_USE_BDADDR_PROPERTY to indicate that the default address
is invalid but can be overridden by firmware (long term, this should
probably just always be allowed).

Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
Cc: stable@vger.kernel.org      # 6.5
Reported-by: Felix Zhang <mrman@mrman314.tech>
Link: https://lore.kernel.org/r/77419ffacc5b4875e920e038332575a2a5bff29f.camel@mrman314.tech/
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/hci_bcm4377.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index a61757835695..9a7243d5db71 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -1417,7 +1417,7 @@ static int bcm4377_check_bdaddr(struct bcm4377_data *bcm4377)
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
 	if (!bcm4377_is_valid_bdaddr(bcm4377, &bda->bdaddr))
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &bcm4377->hdev->quirks);
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &bcm4377->hdev->quirks);
 
 	kfree_skb(skb);
 	return 0;
@@ -2368,7 +2368,6 @@ static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	hdev->set_bdaddr = bcm4377_hci_set_bdaddr;
 	hdev->setup = bcm4377_hci_setup;
 
-	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 	if (bcm4377->hw->broken_mws_transport_config)
 		set_bit(HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG, &hdev->quirks);
 	if (bcm4377->hw->broken_ext_scan)
-- 
2.41.0


