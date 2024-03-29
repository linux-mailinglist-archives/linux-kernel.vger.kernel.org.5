Return-Path: <linux-kernel+bounces-124603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F06891A78
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529FA2866DB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11447159583;
	Fri, 29 Mar 2024 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2F7YUM4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6CF159568;
	Fri, 29 Mar 2024 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715508; cv=none; b=ccRqHAJWQpeMg68yokTvJV9bNxM71pA1fKpNO+yz+z4Oi2GhESHndDOro4Cyob7Np19fp1tLXzN+73YfY/yh/yDIe7h/u9+iat/DGUzg3vr7hIUfeCSZSZd6Gy8/aaRP5zQSmopL8sXmNNEGZT6Az1S6P7BUPQx9FKgP8ThGwTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715508; c=relaxed/simple;
	bh=APwdEwsa+dUpIWkjzeVZLkCgNGfC9AIm/WhrEoYtNsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1gWZajXsB1rL3Ht1HSvUlrvCOhL4T3mHY5D3IH5QE4rqywyvTJ+PiqOhCtTgi0hw8vhQM2FRs1k0Wyt1s9iFan79CySL8Bd7k8woU+9daEn4FRoRyOdmPJl5rsN3Ju8/umFnIGjqS3N14czvJB1scmr6NjX4VwOzwLFKOL6Wtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2F7YUM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E170C433F1;
	Fri, 29 Mar 2024 12:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715508;
	bh=APwdEwsa+dUpIWkjzeVZLkCgNGfC9AIm/WhrEoYtNsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2F7YUM4dCLsNx83GuA51YVB5/EILbbbBYCTQReKDnJjWxCfHpgyxD/K9b5kzlF2Q
	 x5ZKDU6d0d3hE4cle9bR/LUFatO/GPHWJulkimgbfIf+Zxg+LlbIMAFVjNHAoMdEG7
	 MHnU8jTlvB3BnxBT7TrGAb6a1xe5i84QYw+m5SXSwzTtlS9CInz4WvSjRBxRe1NdCu
	 /6T/r8YCj2NcXEmvvPlpV/l3lZBv64ykPCPr0ywg6q//yPmiPJyyYnzEu3jrx51YUG
	 1C0GOf7GPMaGKEuofuOZt78M6ZNqf/lhh31qGngy5cnwp+y6ka7vogAy9zQQHobl/i
	 bIJocg/XNx46g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vinicius Peixoto <nukelet64@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 52/52] Bluetooth: Add new quirk for broken read key length on ATS2851
Date: Fri, 29 Mar 2024 08:29:22 -0400
Message-ID: <20240329122956.3083859-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Vinicius Peixoto <nukelet64@gmail.com>

[ Upstream commit 48201a3b3f398be6a01f78a14b18bd5d31c47458 ]

The ATS2851 controller erroneously reports support for the "Read
Encryption Key Length" HCI command. This makes it unable to connect
to any devices, since this command is issued by the kernel during the
connection process in response to an "Encryption Change" HCI event.

Add a new quirk (HCI_QUIRK_BROKEN_ENC_KEY_SIZE) to hint that the command
is unsupported, preventing it from interrupting the connection process.

This is the error log from btmon before this patch:

> HCI Event: Encryption Change (0x08) plen 4
        Status: Success (0x00)
        Handle: 2048 Address: ...
        Encryption: Enabled with E0 (0x01)
< HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2
        Handle: 2048 Address: ...
> HCI Event: Command Status (0x0f) plen 4
      Read Encryption Key Size (0x05|0x0008) ncmd 1
        Status: Unknown HCI Command (0x01)

Signed-off-by: Vinicius Peixoto <nukelet64@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c   | 1 +
 include/net/bluetooth/hci.h | 8 ++++++++
 net/bluetooth/hci_event.c   | 3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 66080fae072f2..efa22335d75d7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4475,6 +4475,7 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks);
 	}
 
 	if (!reset)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bdee5d649cc61..8c36e094ec99f 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -330,6 +330,14 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_BROKEN_LE_CODED,
+
+	/*
+	 * When this quirk is set, the HCI_OP_READ_ENC_KEY_SIZE command is
+	 * skipped during an HCI_EV_ENCRYPT_CHANGE event. This is required
+	 * for Actions Semiconductor ATS2851 based controllers, which erroneously
+	 * claim to support it.
+	 */
+	HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bc383b680db87..45286ef6c528f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3660,7 +3660,8 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 		 * controller really supports it. If it doesn't, assume
 		 * the default size (16).
 		 */
-		if (!(hdev->commands[20] & 0x10)) {
+		if (!(hdev->commands[20] & 0x10) ||
+		    test_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks)) {
 			conn->enc_key_size = HCI_LINK_KEY_SIZE;
 			goto notify;
 		}
-- 
2.43.0


