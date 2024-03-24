Return-Path: <linux-kernel+bounces-116235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850D1889DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF652A471B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF4917F237;
	Mon, 25 Mar 2024 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab81gu64"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266B17EB9A;
	Sun, 24 Mar 2024 23:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324014; cv=none; b=j0BZ9FdOBbIyuqO7fttnci2yUgc2e+N2unx7KZI0OymQ6qApiQxuLSjAUtZoLpQ4MrfmYy2OV/ohPFJOTmU1jyqXrBgi3UwctI7wtvFVJGpBdebS2RHL+/Nsf5wpaI73RXrYNEn+a56F9Iby+SALCt1tlI9zdxKMvX47h85jBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324014; c=relaxed/simple;
	bh=OJoDDSsYjtltlAlhmkFANMN+uZeJZlwsYuKJ5H4O1y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhTvtU0ts90ftjQNU9utGhVFUAtZcA/C5GbPJKai3xF39Ao3ZMecgI5kWEmypKcFP64aQp4WMGiCdlGZ2WD111whP2EFUibxlpsIoJjGahh6LJldSDEm7oQhSj7rUlaoLmGvAwy7n0d/S8x3JSc+YY2kjrk1JyYmtm9RXEdlxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab81gu64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8832FC43399;
	Sun, 24 Mar 2024 23:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324014;
	bh=OJoDDSsYjtltlAlhmkFANMN+uZeJZlwsYuKJ5H4O1y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ab81gu64hhCY/1ldfueNp9q8tHJRf3M5y0pOE/XINstllmoQRKPTEIk76C27nnPq9
	 dZ1PLTqBJixWnlhE37sJJnprizRHV5xUNeOtzKEraryRRtMqZ2R1D4SIVsh5cGKclc
	 qI6PoUBNrdHoMOwZL2NYvoPkVj2zVgFnQkIxNa4l6d/agBAzsRlS9pqJY6nX799aSc
	 3uYUj+z2131mr81Y0OvZPSn185pwzGd33Vhzzlno3kj8DaqKrkvsT6gcKVzH9WsJzd
	 gNlcUQsW6xQB8DIi7P+xRErbZKHD6wuM4C5+EhG2ybJHS7PeYRr5xxWbqEBHWgojeY
	 Q0W6T3SDoi6Hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuxuan Hu <20373622@buaa.edu.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 015/183] Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security
Date: Sun, 24 Mar 2024 19:43:48 -0400
Message-ID: <20240324234638.1355609-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 2db9e285215c5..596fa3172642b 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1940,7 +1940,7 @@ static struct rfcomm_session *rfcomm_process_rx(struct rfcomm_session *s)
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


