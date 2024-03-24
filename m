Return-Path: <linux-kernel+bounces-115164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4F688932C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07BD81C2D609
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62AC305DFC;
	Mon, 25 Mar 2024 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNS0mxck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FCA1836E7;
	Sun, 24 Mar 2024 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324224; cv=none; b=W4bi0tnzGQVNp7ZpV642BYIfFZhFdtBksxEJUcyGks/82JI5T39xEeF12f9LLBX3uUzzlzGgoYF0pX7lGhPNlwXA5e+wp9pcB0POGZLoJLW8Ya82lxI1pfgV74eVQde8qZcMAxW2wddAXhtlWgV8emD/AzWXUohzYpKH+3Iufcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324224; c=relaxed/simple;
	bh=+Edrx2XfKxPuOmgT1J/mjBl3Z5EuYP0xs8ERWYUbd6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWn/IOHFq430TfAc0Ex+nCeVd8PwTM2TR3FhrmKa4GsKUzHHmdRKvUWBlX1jrZKmpKVUV0AqN7m4pTy/za5ai0VJnUBtyQUZBoiCJ+YcS2AbpRvGZrcb+Lpu/lBbnQTZtTHAiqkEG+yKXCQcNIWPo1I78ygEG1VZUyVxaLS4YNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNS0mxck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13E8C43399;
	Sun, 24 Mar 2024 23:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324224;
	bh=+Edrx2XfKxPuOmgT1J/mjBl3Z5EuYP0xs8ERWYUbd6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNS0mxckh3PhX2JDY5jWMgjJbWcTx56fzVMebAPiewHrTFhlzUhm5xs4fjHCqjWQ3
	 8fkhOdJnjZHz8oNCl3DkHtNvAkXzgBuHF2DyYs5uWoBtbtXrbL0skUigub4biKyA92
	 1Z3wSohXXRhIDcWeZRuzwO2ieqG5AwGUlqAECt62J08VIfhwcyXGp6YCdPpsoxE1E2
	 gy415X1l+Nsqk9+UcsLNvCJEEtf7TkYAUAQcZ4m12xSDXB2CIoB0p87xg+8CN5L2Qw
	 UkCD1mCAwVzFsiNsunBbiko9gu108pJf10HSbyw87D63Mt08OdS+78magn1//8fY9z
	 TL2LULP10uJFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuxuan Hu <20373622@buaa.edu.cn>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 008/148] Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security
Date: Sun, 24 Mar 2024 19:47:52 -0400
Message-ID: <20240324235012.1356413-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 86edf512d4971..b2e69500439c9 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1939,7 +1939,7 @@ static struct rfcomm_session *rfcomm_process_rx(struct rfcomm_session *s)
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


