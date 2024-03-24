Return-Path: <linux-kernel+bounces-114811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A67188916E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263D4292B29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CC5272EE2;
	Mon, 25 Mar 2024 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvAOv1o1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C076175CBE;
	Sun, 24 Mar 2024 23:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323427; cv=none; b=fnIr1ps6umrmTD3nqRKAqIRFfMjq/yAdPMhmABRyCPXYKNgBQ1mZwo8MS8d8HH+dYnDVxN8I+aZ9mRXB83KR3zjj/WDz1JmloAlEU4AO8lvmpZc/V2cB1LxPqWqkIqm6CTR+lX99uhLsT5EK9TawLSz4sCGnWFoZZsuQaxMj+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323427; c=relaxed/simple;
	bh=T3mMur1V4rYkoOdESozqVTv0V5FfDJwKwHBIEEDsft8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlXY4NQ/DCgEDOS/3PskC2XiyzaPiSy/qL6K2Yh2mMgd/RfaP7oXZn5mUTWdNKO3Skt+T1pDL+6fmh02vcJ2xCkdEJdIU8ucZAMFyt2UE7PtRc/uNUUWb3CBKiB8ulNVdUTYyV0YBX8IA1jdsdJ3ZiAoMfcEkhHf0d9Xyli+qCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvAOv1o1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB18C433F1;
	Sun, 24 Mar 2024 23:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323426;
	bh=T3mMur1V4rYkoOdESozqVTv0V5FfDJwKwHBIEEDsft8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvAOv1o1e6TSedEk3/RzyMyReFlTOe6Ys8aZtXa/Qe+JbL5oKwBfiNl/MO+Y/1p2u
	 a/EVrKggK2lgKpOggXc5RJU+Ite6mm0J1ml1jECFWWNN1mG2HCrU6xpZs3XEmFgrqr
	 suHSYrxZIibY8aisUVjFcql4AEjrov2vUe9XYbKGixQgpCLvcCENrpcTwxUUXl59PB
	 PzE+oeunSxgrdgq9+bnzvpDqb2Qn5cuHRsQljot6DwxVZ0grlSOEGJdt05uMKSuMki
	 tiTD1egpt3B5phHTLKkPrBUkHSd81aYCR7j+6heAGfZ+7Xq4Cj9Ze2vDJmDn9tch1X
	 YUtwk320XfN9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 128/317] Bluetooth: Remove superfluous call to hci_conn_check_pending()
Date: Sun, 24 Mar 2024 19:31:48 -0400
Message-ID: <20240324233458.1352854-129-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index ba7242729a8fb..0be37a5c1c0c2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3072,8 +3072,6 @@ static void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	hci_conn_check_pending(hdev);
-
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-- 
2.43.0


