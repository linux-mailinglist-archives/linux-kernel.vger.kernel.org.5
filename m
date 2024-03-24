Return-Path: <linux-kernel+bounces-115668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FD28896FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6BA1F35E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C446209CDD;
	Mon, 25 Mar 2024 02:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP6kGj5T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F4A137C50;
	Sun, 24 Mar 2024 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321573; cv=none; b=d9drQOu95JK3Y3L6/bXDStaquB0/CJcznOpRKlSKEpGXaeWEO5XJ9bIJfQ+UP9l1Xs3KA2UCYOpsmbMRfNvn/7H4QLg8u4+60um1SdJhvee/1+PWd25Ge6JHT/zX3o/2JonUfxoeOZqmEOXttmuyj0caymhOZFsWwQJb5phAB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321573; c=relaxed/simple;
	bh=7x2qa7Ur4GD7/JcMySOCNNILoDMJyQqY7Lk2tRcGAc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gL+KU3cqGOzszTBiwMjbmYqKY7er1lF4yxV1bP6S+aLWyDxFkahFP8hnRcP54AK7lIrL5N7WezVdehS9gz6Sm5CfBeTrnu+WrgjLeMIRzqXTzsl1htZYrA/Htf0w6tmzu/MqRZYbpZroY9ZVju2OdWONIkzHsnUXArMMY0EtMCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP6kGj5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F217DC43390;
	Sun, 24 Mar 2024 23:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321572;
	bh=7x2qa7Ur4GD7/JcMySOCNNILoDMJyQqY7Lk2tRcGAc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XP6kGj5T4HUHJ38jkw/Z94ltToiWk++mUA0VnROTomoT9Ov+58bV8IzupbG3vtaJ4
	 7aYN4sRnHq2DNuQEbpG+3OPjDgD9KclbKcEjM+BnfgX1U1XU7aOb6RtoXSAdbJ0RSk
	 L/AJqAoK/slXUFmHDucM6t1G8YPI9XmRBF4ZrkZGDaZ1dMIDsgH9P2Z5fLDIiDpfOJ
	 3i9rkezrrrdyuCRDZH/9WlXAjuWB/bXyU94r/9rz8TqjDOq8hYDBlGEV27mFq8T7W1
	 3KOmHqYI6ZbHt2uaPIwDIxFt9n2U22wX/W3ED2ofhemehVnUj+CLKGSerpvYqOQHB4
	 tDzKrX+X5MKhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 300/638] Bluetooth: Remove superfluous call to hci_conn_check_pending()
Date: Sun, 24 Mar 2024 18:55:37 -0400
Message-ID: <20240324230116.1348576-301-sashal@kernel.org>
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

[ Upstream commit 78e3639fc8031275010c3287ac548c0bc8de83b1 ]

The "pending connections" feature was originally introduced with commit
4c67bc74f016 ("[Bluetooth] Support concurrent connect requests") and
6bd57416127e ("[Bluetooth] Handling pending connect attempts after
inquiry") to handle controllers supporting only a single connection request
at a time. Later things were extended to also cancel ongoing inquiries on
connect() with commit 89e65975fea5 ("Bluetooth: Cancel Inquiry before
Create Connection").

With commit a9de9248064b ("[Bluetooth] Switch from OGF+OCF to using only
opcodes"), hci_conn_check_pending() was introduced as a helper to
consolidate a few places where we check for pending connections (indicated
by the BT_CONNECT2 flag) and then try to connect.

This refactoring commit also snuck in two more calls to
hci_conn_check_pending():

- One is in the failure callback of hci_cs_inquiry(), this one probably
makes sense: If we send an "HCI Inquiry" command and then immediately
after a "Create Connection" command, the "Create Connection" command might
fail before the "HCI Inquiry" command, and then we want to retry the
"Create Connection" on failure of the "HCI Inquiry".

- The other added call to hci_conn_check_pending() is in the event handler
for the "Remote Name" event, this seems unrelated and is possibly a
copy-paste error, so remove that one.

Fixes: a9de9248064b ("[Bluetooth] Switch from OGF+OCF to using only opcodes")
Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bc383b680db87..f731b8fea19f5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3556,8 +3556,6 @@ static void hci_remote_name_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
-	hci_conn_check_pending(hdev);
-
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-- 
2.43.0


