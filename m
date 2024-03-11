Return-Path: <linux-kernel+bounces-99115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E26087839A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC4A1C218F6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B285569979;
	Mon, 11 Mar 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ynl2yInw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E0F69968;
	Mon, 11 Mar 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170092; cv=none; b=lhZcZf+cy1FmKr/5irlN/gyDwpfX+3tYGRG+2NU+TzdS4nsmVtSNSZVh8gCpjCWfCQnauV7mX85rXP91Q2mdhuY1irPsK2++vitlqwC2/IAPCjFZOQFgE7/Xr4b0UXkqy3e6XQ/hVIWLwkwM3r10BJbVt0JEm41wCI5n3PkaO3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170092; c=relaxed/simple;
	bh=OJoDDSsYjtltlAlhmkFANMN+uZeJZlwsYuKJ5H4O1y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9Lxm7W8ZUHUXnHzphfJ0ldrwaPkzLeT7rR+tNYwSkS/V63A/bc7DTOyZyvC1X2RsNvUJXQV3Nf4LTvW+apcfUf1rm2UVrW7DVPOuzX59lg5zMQrwbrCdnCQuHa5M+tuQ7b+bT5LHVHlZHTcHKuHyHTL5wt7Wt3NudOQQT3VX0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ynl2yInw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931B4C433F1;
	Mon, 11 Mar 2024 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170091;
	bh=OJoDDSsYjtltlAlhmkFANMN+uZeJZlwsYuKJ5H4O1y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ynl2yInwR1DO6J6y6fPtqKvrs5UJiIoRFxV/axnqWiwBQb0QQ0207dfVZe0VDCBW4
	 EW3N8ViauIpA8M1wr6+59XZ+ka9i8pjV/VIgzlL5s9mlcgB3EBnDx2kURK9cfbAkM8
	 M+Wa9NBudaRHNV75pZrW5/SwBBsAx1vOFRUkK3K+TZzK9bvS1a1h86kzWwU7iF9M4B
	 Iq4HIa8AFwmgQn7FMs6pozUdAzF68/hu4HgmDfvhpQUzX2sk15KOdhxy2oAZ+4PIje
	 wDVAo6TK/jWDjGOhe0BYinjl6JfudQ//rklhhz7sCyeGXtiWlsRSQBrpSgZZRA7daF
	 bU+zPrat+jkiQ==
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
Subject: [PATCH AUTOSEL 5.4 3/4] Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security
Date: Mon, 11 Mar 2024 11:14:43 -0400
Message-ID: <20240311151445.318822-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151445.318822-1-sashal@kernel.org>
References: <20240311151445.318822-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.271
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


