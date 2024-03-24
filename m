Return-Path: <linux-kernel+bounces-115929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D26F68898B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723411F32073
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FE638CE42;
	Mon, 25 Mar 2024 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP3T+FV4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A688227E03;
	Sun, 24 Mar 2024 23:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322121; cv=none; b=FCxF0bXwLCIvh1VVkunL7ClNYzylANV0Hzd5n1+nqcE2878Z0gPq+uyTeRxKYnjUbYz6I9e1vGWzk6RNlheITGoD/Fcsyqi0vUDkc9nZCTdh4zr3Ao3T4wSCMGcV0yals/OclJ2RflSqq+uc7eVXoHc+5SKOLGP38Wn/hEhk3/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322121; c=relaxed/simple;
	bh=QMTB5ty4wAWaaMauawzTLJGbHPTq/VgmxTmQY9eNAD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtGsI6/ZVf8EMBsCfMHXO5CJvmrWDYct5mHWlguhcO1db338pM7oPGfWq26Iz+6K6hZCcdKerO5zHXglw9pCj3/tMAsfpD3hOT4kqxYsjJJ8b3tHEy5ZrswGDgoTSkr7ic5tOzR+FYmYpqVP3nuKLif7GlLZVE4pbwSgXTzokj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP3T+FV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C969DC43399;
	Sun, 24 Mar 2024 23:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322120;
	bh=QMTB5ty4wAWaaMauawzTLJGbHPTq/VgmxTmQY9eNAD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YP3T+FV4S1cirIhpj4MLtjZEFnqaWsEvmMIoVjgXgigF8jtpHis2aReq+4r/Vk8bo
	 u6xQTnxNZ2tKmE6XwpdjlrDwA8IGux5rdDC8QEKilzrqbT9sCiASo3JT8kEb6dI5vl
	 y1LDUJbJGoBR5CuKELCAvgpXxmePZssDw9SEpHeb8UwH3z5zv0jDMWUAxoooy091pr
	 fxca7G6JciCKL4iTm5uB2zASdp/SEBqhwcmwNIwsl9f5zvNq6MprQR5Py3CEmpamRz
	 rTsSAFkoPsujeW4vOiy9sqlGEOiJK7Z0U5VEiTbRAAuBpp+a/XtyKR+I6Aa77IRxsm
	 IFCjPZ2GV3PbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 195/451] Bluetooth: mgmt: Remove leftover queuing of power_off work
Date: Sun, 24 Mar 2024 19:07:51 -0400
Message-ID: <20240324231207.1351418-196-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index ab63f807e3c80..a80bf9c42c2ef 100644
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


