Return-Path: <linux-kernel+bounces-116320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB0E889E38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9F429829C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DC83D3AFA;
	Mon, 25 Mar 2024 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWybTXkQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76C818442E;
	Sun, 24 Mar 2024 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324275; cv=none; b=i3ucFLlYNvdqdmxsAuxhCdq7+5S9VMdLdCk83ZFcROuWak89KEXeSOy+yC9AFEgjAa7aX60LDJW/X8FX75e7Xd7gep+gifMy340W7w/MMmCoUiIRobcyo6E+6SurhYyO2vX/V8g+sAcs+QfEB1SjnLI2bI0K/rbVP9tDsYAqL+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324275; c=relaxed/simple;
	bh=KqsAUPQeP4Ko1impn9N/u7BwalSitQSSqAyxjHQ428A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Su2BP/gmZnkgy5o+OuIGmOinsTJE/6fHxEOAS39oPHAi+To2dGWkkKd7RAdB4nucWj10GH8AOfrdqXrqJbW5H37lIBstZu6yV1DEOg4Iw/KSdNj4u0bGQKTVbWyWHMP3EqiGsnqknYe4oz383GOmEXd3wc+upp6G993DQHNQX2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWybTXkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6880C43390;
	Sun, 24 Mar 2024 23:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324273;
	bh=KqsAUPQeP4Ko1impn9N/u7BwalSitQSSqAyxjHQ428A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWybTXkQKMBQ4FvM/t4+D7+NTzmDE9usaD7XyMyAAqx4r8Li5M3RlQfGDsnld3a0i
	 qsK4Mqr3TIL2d94uAmaaVJ5jC/LqwnQJV54ISSWxwdQ85OlQHRDgBohqAQkUIh9EHO
	 6dHoHrPpK6LvhgN6p3eJptr3gDuw6uJE7VGuIy+i/irT0y7jQFhqu0BiEV1mA/KrOn
	 8Z33nLh/URZ4JgzH8HRDVjqjdRbhULIvCOWjY0DM8zeZpC0uI2wNnj3X1A6jwM/OoN
	 ksA1MIIh2sdvsXufprJEGFNBFEGyM3paD1j/VdXMzyeASJBXGUp7EAibsJkW30kt/q
	 3d12zqHdBrwrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 052/148] Bluetooth: Remove superfluous call to hci_conn_check_pending()
Date: Sun, 24 Mar 2024 19:48:36 -0400
Message-ID: <20240324235012.1356413-53-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 4811855259267..0e9325057b3a9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2777,8 +2777,6 @@ static void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	hci_conn_check_pending(hdev);
-
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-- 
2.43.0


