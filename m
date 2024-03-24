Return-Path: <linux-kernel+bounces-115784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E15F889C01
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E48BEB34EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA0836F350;
	Mon, 25 Mar 2024 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqSVzmoZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30414532C;
	Sun, 24 Mar 2024 23:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321977; cv=none; b=Et4nBMO7cDAlj/SdNY08YacvfMi2Kjc1asAtXk4wkHiN40G17Rd/wbxeaopUzDRMLLQRCVxREPyjTsg6V9m9hYqWUL+4nOsQ/7NikpPbCjKM4zQBho/AmB1Mz07qGK/6KOBI7UmP11r3K8KYyeYdIIlL4fLLOpbORrfk56WY5TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321977; c=relaxed/simple;
	bh=Du80a8081lcmLcIyq1r2JOmgELaCBxEoYXMTEtF6bGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cV/AHK5mCMev5+8lSsYYJKADcERMphzuDor9A1b/XE4y0Jb3fFhjZ+Iq4Z7RqGnCvGI91qN4+VRTnGaAiqLTP9hX2jF/v9kzRu8UDLUwSHHU2VVLXWy/ElGSEkoC+usFOYalXBKaSOnNX6RYz0dg15gNe7R/KlEU+IzQMCAfdRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqSVzmoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C15C43390;
	Sun, 24 Mar 2024 23:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321976;
	bh=Du80a8081lcmLcIyq1r2JOmgELaCBxEoYXMTEtF6bGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JqSVzmoZN0I5HGiqp0EDf24LkW0QyWV5eDuMJRbNzJW1qlQF7JAin/icYMtk84n5b
	 3TkbOrwDhauKVJz9Vy+J0Ynta5g1qjDnMxL3kE4c52GLyWFBoS1Yhx2LiBctKdjy+7
	 NGvKfweCUgpIZESR5Hk3WGctnLKqzdzygk5xjm5Z68PVR9QDPZosqPJTOwBis+ZO/I
	 815i36AvhNMKwYGKomfdkSe+9+CXDxSQAVynfNfXjPnExpiQ7j8CGCXwLaAg9tm2Tq
	 4bX0C+ul/wTb4RrPoVz72wIn9sGzGzzGHJ5X21fygn+x53TOVwsmhJV/Pfofi7Wp+R
	 nbWkPy6kjgvDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuxuan Hu <20373622@buaa.edu.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 049/451] Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security
Date: Sun, 24 Mar 2024 19:05:25 -0400
Message-ID: <20240324231207.1351418-50-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yuxuan Hu <20373622@buaa.edu.cn>

[ Upstream commit 2535b848fa0f42ddff3e5255cf5e742c9b77bb26 ]

During our fuzz testing of the connection and disconnection process at the
RFCOMM layer, we discovered this bug. By comparing the packets from a
normal connection and disconnection process with the testcase that
triggered a KASAN report. We analyzed the cause of this bug as follows:

1. In the packets captured during a normal connection, the host sends a
`Read Encryption Key Size` type of `HCI_CMD` packet
(Command Opcode: 0x1408) to the controller to inquire the length of
encryption key.After receiving this packet, the controller immediately
replies with a Command Completepacket (Event Code: 0x0e) to return the
Encryption Key Size.

2. In our fuzz test case, the timing of the controller's response to this
packet was delayed to an unexpected point: after the RFCOMM and L2CAP
layers had disconnected but before the HCI layer had disconnected.

3. After receiving the Encryption Key Size Response at the time described
in point 2, the host still called the rfcomm_check_security function.
However, by this time `struct l2cap_conn *conn = l2cap_pi(sk)->chan->conn;`
had already been released, and when the function executed
`return hci_conn_security(conn->hcon, d->sec_level, auth_type, d->out);`,
specifically when accessing `conn->hcon`, a null-ptr-deref error occurred.

To fix this bug, check if `sk->sk_state` is BT_CLOSED before calling
rfcomm_recv_frame in rfcomm_process_rx.

Signed-off-by: Yuxuan Hu <20373622@buaa.edu.cn>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/rfcomm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 8d6fce9005bdd..4f54c7df3a94f 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1937,7 +1937,7 @@ static struct rfcomm_session *rfcomm_process_rx(struct rfcomm_session *s)
 	/* Get data directly from socket receive queue without copying it. */
 	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
 		skb_orphan(skb);
-		if (!skb_linearize(skb)) {
+		if (!skb_linearize(skb) && sk->sk_state != BT_CLOSED) {
 			s = rfcomm_recv_frame(s, skb);
 			if (!s)
 				break;
-- 
2.43.0


