Return-Path: <linux-kernel+bounces-158158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A1A8B1C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A45A281E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFAC6EB67;
	Thu, 25 Apr 2024 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pctJuYQ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E067A1A;
	Thu, 25 Apr 2024 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714031763; cv=none; b=PGckPVOi1WSQy2bwE/StrM+XHWjh2g2xwNOR9BRhFrRWFp/dUtNRbMXyFHi/7bXImH8NRg6Gzqzm/HKW8IfDrQluJJR8Yj5167CVXbK/BtTNZW7VLQVkO3Nke5qAB5Su2Q5OZVK8X6zICxjwSsbYvjTwdkwfqOHzb1ZBFa6qb1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714031763; c=relaxed/simple;
	bh=FbilVvwlenLgeiFq6bKzJ8zy6ljmHZoUoBSejCx9WMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/uaanyTB/YKlv28BmSyZg1sFN8dNeJFKVCwVwLA+Khe7pBR1nPDKvhXB/oNeQGE2KJ1jBBviJpNOohQWuTFW9JodhOT2qB91h7FLngYsf7mO/eE8L0kEfxZMTrwqMj8XRRTkHQAUxI639h8UerNvX2mhFPFbc0my2a/bgSAAbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pctJuYQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520FCC113CC;
	Thu, 25 Apr 2024 07:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714031762;
	bh=FbilVvwlenLgeiFq6bKzJ8zy6ljmHZoUoBSejCx9WMg=;
	h=From:To:Cc:Subject:Date:From;
	b=pctJuYQ8pjN/iOl9OiJoGq/5tMceS3K58mDHUL2521Sko39SPcBrT4oTNNROs3NGa
	 28KY82pxVQGtSoZgMpUuddTdjpjEhSGktT3uegc//Nuaq84yTOw5OtBiYEmgUk++D6
	 O3zI09xrPaSrmk6sw2+nRxQ0xzej4ZXkd47/xCLrGHsKuwrCiRRY+E2euNPWr9N1ck
	 ESUoA6t8nBQFGy756uMBALGFDBuWlkmbYd0Bbxq7RCV79kSBo177kaphMdWFGFCPhb
	 RXaDDivf5E8e3EyDNOkbc4LsW/haQitICqSgP4i6/Ey9c2xMJgVhtJ8lrSPqdwJR6C
	 Qv4WPlPzVzgcw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rztxZ-000000006Lk-32dS;
	Thu, 25 Apr 2024 09:56:01 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Subject: [PATCH] Bluetooth: qca: fix wcn3991 device address check
Date: Thu, 25 Apr 2024 09:55:03 +0200
Message-ID: <20240425075503.24357-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm Bluetooth controllers may not have been provisioned with a
valid device address and instead end up using the default address
00:00:00:00:5a:ad.

This address is now used to determine if a controller has a valid
address or if one needs to be provided through devicetree or by user
space before the controller can be used.

It turns out that the WCN3991 controllers used in Chromium Trogdor
machines use a different default address, 39:98:00:00:5a:ad, which also
needs to be marked as invalid so that the correct address is fetched
from the devicetree.

Qualcomm has unfortunately not yet provided any answers as to whether
the 39:98 encodes a hardware id and if there are other variants of the
default address that needs to be handled by the driver.

For now, add the Trogdor WCN3991 default address to the device address
check to avoid having these controllers start with the default address
instead of their assigned addresses.

Fixes: 00567f70051a ("Bluetooth: qca: fix invalid device address check")
Cc: stable@vger.kernel.org      # 6.5
Cc: Doug Anderson <dianders@chromium.org>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


Luiz and Doug,

As the offending commit is now on its way into 6.9, let's just add the
default address that the Trogdor machines uses to the address check.

We can always amend this when/if Qualcomm provides some more details,
or, in the worst case, when users report that they need to re-pair their
Bluetooth gadgets if there are further variations of the default
address.

Johan



diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 216826c31ee3..cfa71708397b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -16,6 +16,7 @@
 #define VERSION "0.1"
 
 #define QCA_BDADDR_DEFAULT (&(bdaddr_t) {{ 0xad, 0x5a, 0x00, 0x00, 0x00, 0x00 }})
+#define QCA_BDADDR_WCN3991 (&(bdaddr_t) {{ 0xad, 0x5a, 0x00, 0x00, 0x98, 0x39 }})
 
 int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version *ver,
 			 enum qca_btsoc_type soc_type)
@@ -638,8 +639,10 @@ static int qca_check_bdaddr(struct hci_dev *hdev)
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, QCA_BDADDR_DEFAULT))
+	if (!bacmp(&bda->bdaddr, QCA_BDADDR_DEFAULT) ||
+	    !bacmp(&bda->bdaddr, QCA_BDADDR_WCN3991)) {
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+	}
 
 	kfree_skb(skb);
 
-- 
2.43.2


