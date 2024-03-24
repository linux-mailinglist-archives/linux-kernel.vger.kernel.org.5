Return-Path: <linux-kernel+bounces-114050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 277CC888F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00171F34972
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BFA1FDA05;
	Sun, 24 Mar 2024 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwKKtf4H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25441FD12A;
	Sun, 24 Mar 2024 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321331; cv=none; b=eiSCxOHr7u5ixB6am2tBDCMjWRRGfUOztsZHY+DoTl6t5V6yejxp4JbMi3ktAQTz8433CqYH8grPvgGUMp1HeHNPBONDa8/k/NE0JmmVhxKKy279n9EcjXQTXx2svl2HS60faNHCQBe+4pJ8v3UAuxaL6t/Yo0O6ETPio6bz1ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321331; c=relaxed/simple;
	bh=ee4JVX+b0jEgqSk/X+DrWDhtXvtITEYxbWllb2TfOyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQC3qCkYHaIGIhHauwX+e611l6GuaotsRTx87ZamqcYVIMAgyTu2ikPI0IXfTZChXUuHs96rUC1D0Uag2S8qw2yQlH0DUMn8Chh6bfHUpPJ5ESRw7rVsJN/saVgKRLEKvWHyA+6tuUBbf3PxzZecFaE8BLgWPvyg4utiqSlBDwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwKKtf4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAD3C433F1;
	Sun, 24 Mar 2024 23:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321330;
	bh=ee4JVX+b0jEgqSk/X+DrWDhtXvtITEYxbWllb2TfOyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SwKKtf4HdpKbp4HrjrPwXWQhA/XKFkijugYajkdMmBWHBUgKMegGMfUZnN6FPU+sd
	 31sz3Y/b8oh24ma9Lr/MLD+Cr897ttdusoqxC3rvBBHcNMJSZAEjFbSuZzInwYsAyz
	 532XZDEibnizEvlXaRalTfKmrx7O4JlHhQ1mpiYVH25B92yRU7qf7krHIKahBA8gK5
	 Z4umELK9N2bhigkmp3QhS6KLk1UBFC5sNVdqCk9OiSMjx29A3fSVFYUnFl1X2WMRAb
	 ErEyrvx4srNUbo8LzVU66CU3vGSck23fr/oC5DGQJR8+rLTFrLCc7KMmbZthONjdha
	 L25Nm8sVZ9GZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 054/638] Bluetooth: mgmt: Fix limited discoverable off timeout
Date: Sun, 24 Mar 2024 18:51:31 -0400
Message-ID: <20240324230116.1348576-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis@collabora.com>

[ Upstream commit 0bd1fb586235224048c726922db048d1bce6354a ]

LIMITED_DISCOVERABLE flag is not reset from Class of Device and
advertisement on limited discoverable timeout. This prevents to pass PTS
test GAP/DISC/LIMM/BV-02-C

Calling set_discoverable_sync as when the limited discovery is set
correctly update the Class of Device and advertisement.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9dd815b6603fe..2448a154a4069 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1045,6 +1045,8 @@ static void rpa_expired(struct work_struct *work)
 	hci_cmd_sync_queue(hdev, rpa_expired_sync, NULL, NULL);
 }
 
+static int set_discoverable_sync(struct hci_dev *hdev, void *data);
+
 static void discov_off(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
@@ -1063,7 +1065,7 @@ static void discov_off(struct work_struct *work)
 	hci_dev_clear_flag(hdev, HCI_DISCOVERABLE);
 	hdev->discov_timeout = 0;
 
-	hci_update_discoverable(hdev);
+	hci_cmd_sync_queue(hdev, set_discoverable_sync, NULL, NULL);
 
 	mgmt_new_settings(hdev);
 
-- 
2.43.0


