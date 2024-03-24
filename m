Return-Path: <linux-kernel+bounces-114226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818D8888F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE461C2BC90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A13115A481;
	Sun, 24 Mar 2024 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWaYO1iQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6F1DCC81;
	Sun, 24 Mar 2024 23:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321572; cv=none; b=VEelyXSozs6mW5dxsXAkR+fIBcneFBq8rMdF5uS2s9X7do9v1n7XIL/4wq9uWsxFKbz/AxQpTcWwbBnmK+3uxQ8QDTHTqqzGqUiS7pW8PK0RIaIfVVITsWH56L8e10HWWjG7snmyOhtnIyaDnxSqB65rzzczhTnOCbpEnLlBjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321572; c=relaxed/simple;
	bh=fxh2FzIss8jfV/LFAffOsp5nCtgdW3PvQ5ctpWMXbPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6CwacSqG9mJcrnQRorx+G0FAyrOO6+T7blNSZ45chwdp7kr1zs0iS9DT+8dzR+1oHVEUDf54bd1+994O4Go3fC6YyQxtcRLninjFrqkAJno7GOynCjRtYy2Y18AMEvL1PBSL2GqWBwbUev6O4I3DfJtMLwwNbg0ROLw8O7BAlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWaYO1iQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F36C433C7;
	Sun, 24 Mar 2024 23:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321571;
	bh=fxh2FzIss8jfV/LFAffOsp5nCtgdW3PvQ5ctpWMXbPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EWaYO1iQx1LawQu51vqRURydQox6+RrIxzJvbFbnVr466ZLVi+hq9Cq4R6Flcm0K8
	 nmdzwj0sW6SAjlVeoWe3QMZpeYgZzSLkQ/V6f+Rb57sd+993HxdqoVjT6XQbiBaLcV
	 Cj/DTf67hZM/GDkWwSW22ZlKQ7Ulym//EP9RiJjjn6j57pBuwROPClkdQljbyrl4P5
	 84gIdNzNgoFSkjoTNoEMiczbwrgVxdFOI9OeugnwFYnHaEg19sMguJbjkd0iU6sgBG
	 UPl8rzxXH1LaMuE3KdAKB5gdtdD5tyUUE5/i6ZQJeea5Y7MLHnj7aalNTGL4d96ihI
	 5nkUj6+22286Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 299/638] Bluetooth: mgmt: Remove leftover queuing of power_off work
Date: Sun, 24 Mar 2024 18:55:36 -0400
Message-ID: <20240324230116.1348576-300-sashal@kernel.org>
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

From: Jonas Dreßler <verdre@v0yd.nl>

[ Upstream commit fee054b7579fe252f8b9e6c17b9c5bfdaa84dd7e ]

Queuing of power_off work was introduced in these functions with commits
8b064a3ad377 ("Bluetooth: Clean up HCI state when doing power off") and
c9910d0fb4fc ("Bluetooth: Fix disconnecting connections in non-connected
states") in an effort to clean up state and do things like disconnecting
devices before actually powering off the device.

After that, commit a3172b7eb4a2 ("Bluetooth: Add timer to force power off")
introduced a timeout to ensure that the device actually got powered off,
even if some of the cleanup work would never complete.

This code later got refactored with commit cf75ad8b41d2 ("Bluetooth:
hci_sync: Convert MGMT_SET_POWERED"), which made powering off the device
synchronous and removed the need for initiating the power_off work from
other places. The timeout mentioned above got removed too, because we now
also made use of the command timeout during power on/off.

These days the power_off work still exists, but it only seems to only be
used for HCI_AUTO_OFF functionality, which is why we never noticed
those two leftover places where we queue power_off work. So let's remove
that code.

Fixes: cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")
Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2448a154a4069..324f06e2e9ddb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9766,14 +9766,6 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	struct mgmt_ev_device_disconnected ev;
 	struct sock *sk = NULL;
 
-	/* The connection is still in hci_conn_hash so test for 1
-	 * instead of 0 to know if this is the last one.
-	 */
-	if (mgmt_powering_down(hdev) && hci_conn_count(hdev) == 1) {
-		cancel_delayed_work(&hdev->power_off);
-		queue_work(hdev->req_workqueue, &hdev->power_off.work);
-	}
-
 	if (!mgmt_connected)
 		return;
 
@@ -9830,14 +9822,6 @@ void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 {
 	struct mgmt_ev_connect_failed ev;
 
-	/* The connection is still in hci_conn_hash so test for 1
-	 * instead of 0 to know if this is the last one.
-	 */
-	if (mgmt_powering_down(hdev) && hci_conn_count(hdev) == 1) {
-		cancel_delayed_work(&hdev->power_off);
-		queue_work(hdev->req_workqueue, &hdev->power_off.work);
-	}
-
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 	ev.status = mgmt_status(status);
-- 
2.43.0


