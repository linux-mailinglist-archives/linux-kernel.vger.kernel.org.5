Return-Path: <linux-kernel+bounces-14692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF678220C2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4802B283A35
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87EE156E6;
	Tue,  2 Jan 2024 18:08:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E43156C3;
	Tue,  2 Jan 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4T4LSM3qWKz9srQ;
	Tue,  2 Jan 2024 19:08:19 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Check the correct flag before starting a scan
Date: Tue,  2 Jan 2024 19:08:08 +0100
Message-ID: <20240102180810.54515-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T4LSM3qWKz9srQ

There's a very confusing mistake in the code starting a HCI inquiry: We're
calling hci_dev_test_flag() to test for HCI_INQUIRY, but hci_dev_test_flag()
checks hdev->dev_flags instead of hdev->flags. HCI_INQUIRY is a bit that's
set on hdev->flags, not on hdev->dev_flags though.

HCI_INQUIRY equals the integer 7, and in hdev->dev_flags, 7 means
HCI_BONDABLE, so we were actually checking for HCI_BONDABLE here.

The mistake is only present in the synchronous code for starting an inquiry,
not in the async one. Also devices are typically bondable while doing an
inquiry, so that might be the reason why nobody noticed it so far.

Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c920de0a2..4a5949a0e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5554,7 +5554,7 @@ static int hci_inquiry_sync(struct hci_dev *hdev, u8 length)
 
 	bt_dev_dbg(hdev, "");
 
-	if (hci_dev_test_flag(hdev, HCI_INQUIRY))
+	if (test_bit(HCI_INQUIRY, &hdev->flags))
 		return 0;
 
 	hci_dev_lock(hdev);
-- 
2.43.0


