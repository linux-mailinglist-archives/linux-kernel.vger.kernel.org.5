Return-Path: <linux-kernel+bounces-115085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248CB889302
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4201F323EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FD82F7862;
	Mon, 25 Mar 2024 01:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI6DvK/L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A1226197;
	Sun, 24 Mar 2024 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324070; cv=none; b=C9mZ0QNzj/uFLwpMImpDMZzUMSd2P8kng6j3WIQ+FThsLnzrqIrBz6KOzHe285Ew82P0dBAAI1vKmLdJS83JSPw4+PC3uqra2WiJ3I1za3H/9kWNwh0oCLGfn8fOgCaKp4XZDh9kZD4IKX5B2paMQjB325MGhl/8G+cvkU/pgM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324070; c=relaxed/simple;
	bh=t0VzECWIqPRM1v7GnYR0cuG7jLghPB7QZOe9b1XZQRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qah2SiyBl2FS+jmkXAjXIEYT5RwOWCod7ho3VoRVnMRqKiW/Olxhq6acQ4Sai1SSvzCINeJgdLe4tzDnjfsK3KdqHq38dhupkFF22PRKjwfGGK5mzo1PBdYOeT3vnIdziwsBEFnxRmaiqZ+N9WBfO3oumako3/c8q9Tgc4WoV7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI6DvK/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484B8C433F1;
	Sun, 24 Mar 2024 23:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324068;
	bh=t0VzECWIqPRM1v7GnYR0cuG7jLghPB7QZOe9b1XZQRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XI6DvK/LMnb9LDF6U3K2VqnSkFa8YxMYjvXwV1EF/5YQrfznYRisiqLfgOOyuokzT
	 2Yeye8l1Eba1f2pNJvEdBc83z4ff1Pu1JS5nhLUqX4nPi/1+rkQCL6WToVHnB4vU6e
	 i7WZmW08PjCslWgL5IH+ZtBXwT3OTNhrB93OrE0otNQCniVFjtq2gjf9qnHGf5VaDi
	 B+qdp6kxt6kJC6HCvzp3BDXHRVnmWMte7Z45Q0bg5PbcXAwOEu8r9AHlytK0r9bcU8
	 JEI/AkvTTEe3dq2wW0iHpbXiJ5AiuJCE95krsRQjx1FixbxSKEYnG77UuRcmD5R4++
	 02g1jJrdQsHIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 069/183] Bluetooth: Remove superfluous call to hci_conn_check_pending()
Date: Sun, 24 Mar 2024 19:44:42 -0400
Message-ID: <20240324234638.1355609-70-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 32793d22ba61c..2125421ad7465 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2861,8 +2861,6 @@ static void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	hci_conn_check_pending(hdev);
-
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-- 
2.43.0


