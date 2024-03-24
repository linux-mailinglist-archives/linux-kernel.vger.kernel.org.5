Return-Path: <linux-kernel+bounces-114981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A91888C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABC0299073
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E8217B4F0;
	Mon, 25 Mar 2024 00:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spqAvSSx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515CA17AF99;
	Sun, 24 Mar 2024 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323714; cv=none; b=rol78EEOH+KURFjOlMsKSM4uVy6UpZrORTfvnGCda8ctK9CIMDTAcELk4MAIZyfX/VQ6XIXYvt4X9Lpp1KC540uArpEWBvZsnnxgbUHf3RAjtliTYlpXSpE3cdjUVTd9ZucR4by314LDvxl/2ben9saZ0OxlpxmK4FEzlIKTuk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323714; c=relaxed/simple;
	bh=CSsMMAzPnslDQ8GvwXxlXfce+dOErRVaZ+P4AxHsZE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcheSd+U/n9dDLfxTOdtho50ARRxgD+DL7/8m0f5h5zL9mQJBTcT0bZBzDY6fitQphxO4+WZNZZ+dWPJzeArNBUtIy/vsFiPYqbO4GUR+EdDfGCmk57FKWCFJTA+L8zZRvGz/xFEGIAYRIVk5SHVHuGdFSQsWz6DHDZ2QkyLnDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spqAvSSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96096C43394;
	Sun, 24 Mar 2024 23:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323713;
	bh=CSsMMAzPnslDQ8GvwXxlXfce+dOErRVaZ+P4AxHsZE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spqAvSSxhBP5M47SQ+m6w9GBiWmdja5LlJ8MR3K2WhEeR9L2bNP4jTC2cy9oA7PgE
	 KhWLtXWx9ARBQnfxJwif5qVu/th0SLXz++noQ9W/culskGNj8A9w6QgmAgOvPeo3NM
	 2O3ZiTduIZ2t9/27uE0l9rxot2hwcsRGkB1Kq2eE0JvSyCd7oGus+FlepzdWazqQTn
	 k0ezG8lmOtJZ3cDc6pfwHv9YqPglpRZZn4OXhjPyfxkzuHEHqEEF+Y/1yOoCaKPk82
	 T3Sc5Znk9rwXvEshScYFRQAfW/31IgI66YLoED/qQQ+HX3/7Hs8TzLpqhoRCZpbsPn
	 lySVn/KkMw9WQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 086/238] Bluetooth: Remove superfluous call to hci_conn_check_pending()
Date: Sun, 24 Mar 2024 19:37:54 -0400
Message-ID: <20240324234027.1354210-87-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 47f37080c0c55..a0d9bc99f4e14 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2979,8 +2979,6 @@ static void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	BT_DBG("%s", hdev->name);
 
-	hci_conn_check_pending(hdev);
-
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-- 
2.43.0


