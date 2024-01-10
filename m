Return-Path: <linux-kernel+bounces-15130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E925C822784
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 04:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4F81F23BC2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9158CA71;
	Wed,  3 Jan 2024 03:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="vDboQI1M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from buaa.edu.cn (unknown [202.112.128.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA084A1C;
	Wed,  3 Jan 2024 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=ZT4f7RGcP8
	9s2PD4GqbxF1IDMNpMzEJiOuxSzUjnO2Q=; b=vDboQI1MjVVPsWBhP8xgQM8D60
	3axFhSUn9Z7AGSybcRhaQTvRNWYKfaJBOrMAAVvm/HBmpsW5xWTQZqfWputqsun1
	mTlT+f/9f/9b8XYL3RNbVJ3E3AUTSK+4fva7dwsz7VR4S+ppFf9hBZpqTtskXZBI
	rowjW0Lrf69bZthIo=
Received: from localhost.localdomain (unknown [10.130.147.18])
	by coremail-app1 (Coremail) with SMTP id OCz+CgAnVlgh0ZRlzISiAA--.48024S2;
	Wed, 03 Jan 2024 11:14:41 +0800 (CST)
From: Yuxuan Hu <20373622@buaa.edu.cn>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	sy2239101@buaa.edu.cn,
	20373622@buaa.edu.cn,
	buaazhr@buaa.edu.cn
Subject: [PATCH V2] Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security
Date: Wed,  3 Jan 2024 11:14:10 +0800
Message-Id: <20240103031410.3262524-1-20373622@buaa.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:OCz+CgAnVlgh0ZRlzISiAA--.48024S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyDGF1xXr18Aw4UCw4rXwb_yoW8tFyfpF
	ZFya4xGFn7ur15Arn7AF4kuFyrZr1v9r15Kw4ku3yY93s5Wwn7trWSyr1jvay5CFs0y343
	ZF18Xw4DGrnru37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
	AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS
	14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26F
	1DJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAxhLUUUUU=
X-CM-SenderInfo: ysqtljawssquxxddhvlgxou0/

During our fuzz testing of the connection and disconnection process at the
RFCOMM layer,we discovered this bug.By comparing the packetsfrom a normal
connection and disconnection process with the testcase that triggered a
KASAN report, we analyzed the cause of this bug as follows:

1. In the packets captured during a normal connection, the host sends a
`Read Encryption Key Size` type of `HCI_CMD` packet(Command Opcode: 0x1408)
to the controller to inquire the length of encryption key.After receiving
this packet, the controller immediately replies with a Command Complete
packet (Event Code: 0x0e) to return the Encryption Key Size.

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
---
V1 -> V2: Removed the direct check for `conn` being null in rfcomm_check_security

 net/bluetooth/rfcomm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 053ef8f25fae..1d34d8497033 100644
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
2.25.1


