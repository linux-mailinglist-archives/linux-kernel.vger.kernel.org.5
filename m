Return-Path: <linux-kernel+bounces-115672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564178896FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8BC1F35DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED86B355A2B;
	Mon, 25 Mar 2024 02:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpV0dwVU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1FF209E23;
	Sun, 24 Mar 2024 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321581; cv=none; b=DmVx9kLte3byEahAuz+taGzOzhf1CUIjNQLf1REOe+85On3k7WntzIdDc7bSsfQuf3IwQmSBroWmabQELSMe/wOjvM187b2ntvVP1gZTVdiRP3IEblBDjg8JDpPmTMGDcSzrylRX2C1Wuuqis3wKRWmt0/Ku+UiEZiZuT7r9QB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321581; c=relaxed/simple;
	bh=eZ8P3VvFJh8AOiFHtetE+vSb5xhTtJgCpVECyeF04SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aolw926tptvAry5ikPsFtDVES0n3uLdqZ56RH5Fb6t4IPnDbqeAE5sg2CCOc94Z34vQ3ZWGPOP0QPGBcn16EY6DyYlAJDcRL32HSxpKu7FNUGSGnca5wV6/2zlcdcqQKAmqNsQgB9oPIQ2lvu5tXZfBb3mXou8MpLbYT5XocoKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpV0dwVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82420C433C7;
	Sun, 24 Mar 2024 23:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321581;
	bh=eZ8P3VvFJh8AOiFHtetE+vSb5xhTtJgCpVECyeF04SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpV0dwVU1K8mimf10YWJBUcvabNItLokDs5VqCPjaYngt+UunPEwaNfsvzLioVfCb
	 lsdiIw/IYgUte6u3ibnGYbaes4Lb4yAnPYb5/gu28Pqz/v0FZXwnv9Kd2yZp0p84L3
	 Gwr3kPm5uUpZTdeWS0Lqa/Jk0nKuYTgyYZ5w3AKniye4XwwpNbt0UIR+5bBIp5vIPM
	 zKjzxpnXXAexT3hnIBUMdjRF8b++vS4ICIY4Sz5chRTRpan+gicXmS6qbX+q6fgr7C
	 y4NjrEAJUqISXzYuyO/bc6jiOBJJcu0YjMPss7WfI8avWampQGE80qZpkeVto6omIy
	 0Sf33djHh0FZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 310/638] Bluetooth: msft: Fix memory leak
Date: Sun, 24 Mar 2024 18:55:47 -0400
Message-ID: <20240324230116.1348576-311-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit a6e06258f4c31eba0fcd503e19828b5f8fe7b08b ]

Fix leaking buffer allocated to send MSFT_OP_LE_MONITOR_ADVERTISEMENT.

Fixes: 9e14606d8f38 ("Bluetooth: msft: Extended monitor tracking by address filter")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/msft.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index 630e3023273b2..9612c5d1b13f6 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -875,6 +875,7 @@ static int msft_add_address_filter_sync(struct hci_dev *hdev, void *data)
 		remove = true;
 		goto done;
 	}
+
 	cp->sub_opcode           = MSFT_OP_LE_MONITOR_ADVERTISEMENT;
 	cp->rssi_high		 = address_filter->rssi_high;
 	cp->rssi_low		 = address_filter->rssi_low;
@@ -887,6 +888,8 @@ static int msft_add_address_filter_sync(struct hci_dev *hdev, void *data)
 
 	skb = __hci_cmd_sync(hdev, hdev->msft_opcode, size, cp,
 			     HCI_CMD_TIMEOUT);
+	kfree(cp);
+
 	if (IS_ERR(skb)) {
 		bt_dev_err(hdev, "Failed to enable address %pMR filter",
 			   &address_filter->bdaddr);
-- 
2.43.0


