Return-Path: <linux-kernel+bounces-99069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4697587831B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAD24B2370A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC6757864;
	Mon, 11 Mar 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSw49wIo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173D957314;
	Mon, 11 Mar 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169983; cv=none; b=cw4x59O28vifSnYkEYRslCBQLNdiWVrLcwGLiBRF8eZQebSCI3Iz8o+3uB0ZsWPPd2o2BavK4e2XJlUo6hwne8tU456wQJnRkCvYpmdhZ0xEUSl6lJmbUKmLU7wC666vHQp5fwrzGICFGqPbRr8pkcSbiUYuqg2qWkChCB5mSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169983; c=relaxed/simple;
	bh=rd9CTn5d36v+u366AsJVE1eQgwQIsnkSjg/Q6MfoA3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrUQMtkVOYK3oPRv+WOhATYAxg8ds7wyNfVpo4y/b/2fRhB9YpfCoYKENpzifMFZSGCV6CEavUoTpUs88/YvAZkBxZwAJ2FdJsPwGiNSf8jzyNLnrigEIdf7oZnpD+Hr5KptxXpCA4eamcjPGiiNw6/Yy29Uf6MjN1ei10u98zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSw49wIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9059C43390;
	Mon, 11 Mar 2024 15:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169983;
	bh=rd9CTn5d36v+u366AsJVE1eQgwQIsnkSjg/Q6MfoA3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SSw49wIo38D9e4GQwFY7FYotR2tZkgtj4o5KDd88K5w0AWQuE9Shi0UKjxXef3tmE
	 9sve6gs9Cpm5Xe44OhBSYs63iigaJGWMHi7z6bDloOpsAKX2em6ggrIDH4MvDJ4glK
	 jsXnYczy+OP+k2m7FBWmu7oQq8UkHyqIbppdDITNRsipFcxN9YT53Y7hnSG6fLuaQt
	 kKJZaA8lyat3sINHqMODWW0+zGVzF7Gj/ghxYqLZkGJC7O/wqbr+X8xq71wl/RO9EM
	 q2NC+pinKd8aIrMB6/5BHYspGsVsHcsMYsDa4Q7p+qWN5VWMOC6AOz50KtyO70h29T
	 3yYk9+js0kc+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuxuan Hu <20373622@buaa.edu.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 20/23] Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security
Date: Mon, 11 Mar 2024 11:12:00 -0400
Message-ID: <20240311151217.317068-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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
index 053ef8f25fae4..1d34d84970332 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1941,7 +1941,7 @@ static struct rfcomm_session *rfcomm_process_rx(struct rfcomm_session *s)
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


