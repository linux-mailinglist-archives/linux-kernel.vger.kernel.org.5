Return-Path: <linux-kernel+bounces-99108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E943878386
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8BE1F25180
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11AB664BA;
	Mon, 11 Mar 2024 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WewZ5WiV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A216664A3;
	Mon, 11 Mar 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170076; cv=none; b=HdoxydN6DrOySj3n2ACthm89urja+bBtvh3yTr++QcUJGqzxavuu14EGlKmpXBFatSON32kklQYaodSG+A2P3acbSpA6YgkDJCDCng8nGUGRx7z6EX8l8X1t96P9mD2EP8zQ2jGg/Kbg6Iue1YW9dpXkQj2T8vjVMm56TVTTvAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170076; c=relaxed/simple;
	bh=Du80a8081lcmLcIyq1r2JOmgELaCBxEoYXMTEtF6bGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxl1OpXE4MGN7zy0jVaBxbsCM5ALtJaBh+d8ZVImguSVLTYZuSozJI+CRDruD951M91GxTQkN9umTopD5289tItivexCfKO9jLJlevp8QSJS1M6kZdVBZWT/kLbGON96Ec9XhWBMrZ13+heKtf2zGEIc+0QfnsKs15Ln/y+OjpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WewZ5WiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC88C43399;
	Mon, 11 Mar 2024 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170075;
	bh=Du80a8081lcmLcIyq1r2JOmgELaCBxEoYXMTEtF6bGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WewZ5WiV1Dy5BOtlDxCSjDaacAXUbXJ7DzSQpjpyqIPzWSF3zHu1ap9AcbvIqoT+l
	 kmLghfpKe8hXzxiTiyBO0eGiCZiZ5HFdCLvyBKNYXa2+wzrwQK+FoZG26Xe56jOCr9
	 lFa1rfvAF4j5vQHD7gyeqay4a5C7H0JyjuLmsgrsO8wwzPnoy03zRbNlcwCo4bIFFA
	 cRZUUEm8dHAObwn7dxdXI6tN+98Dg76jwjoz+OZPSXtT20H6ePV4rBjcUH+QCIdvhs
	 CCc62ruF4S5yS1X6JTs1c5hNEe8+zp4tS8EgGFzOop8DVtr96PN/pAo8Q4bIzKRfan
	 Z7qmzqWDSQTVQ==
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
Subject: [PATCH AUTOSEL 5.15 4/5] Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security
Date: Mon, 11 Mar 2024 11:14:20 -0400
Message-ID: <20240311151424.318621-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151424.318621-1-sashal@kernel.org>
References: <20240311151424.318621-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.151
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


