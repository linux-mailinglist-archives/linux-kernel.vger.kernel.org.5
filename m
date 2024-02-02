Return-Path: <linux-kernel+bounces-50373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D20AE84785D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9900BB2998A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13FF130AC9;
	Fri,  2 Feb 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+LH42N+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41C12D768;
	Fri,  2 Feb 2024 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899225; cv=none; b=I9PzBmV6QkWrc74iHQ+NpOY/4glCYCWwSOLK5PKVcz9vlYeVccXlsyaETcMSCNqzl5Njp8e2VFu6s/dCe8raHdMTSUUAmjODC6Qt9CM36MUTvKQiHdjBRmZ2aqywIsCUaJXxTkUkNp+1QxuI3Z8wYbms3Bwx4/J8S1Gp9NWnDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899225; c=relaxed/simple;
	bh=hEolJWW5a1lph0S8RFrcDZqur1Gf3rwiQM4LYvwAYeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTBzJWaLzAbcvi6Jj5POo9/TOC8d1NpbVEWB9+HbJLDUDv+2H8hzOW+82neiDqFkJgn0axQtI1wPLeit/T4tp/Qg90Ce+cMkcewrvOvI2aDn05g7OImdi3L3VXV0KGQPaic05hnRnhQ+s5gTPLXTs5nftaLxrdy1O14q3fl+KW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+LH42N+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8420EC433F1;
	Fri,  2 Feb 2024 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899225;
	bh=hEolJWW5a1lph0S8RFrcDZqur1Gf3rwiQM4LYvwAYeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F+LH42N+IvidnHXy8itIBP3i6QsA86crPccH1cZaZxf1rk77Jz9e43HJ2L9Sjw2ya
	 EjbMxcMhTrj9ICbqF9lYQwg9usGh3ABaCudGhvfs506OGxP8LX83n9VuZpuGTomLLG
	 KU7Mu5JerW9vrQJ7kSha6FiTFTtHehTb+T0pGNlM7BnB9/cU0H1PTZFaHJ4bYoekwx
	 r6vN5vIiahhNlzn6SoEy1vzQWIRt5Ax+Mw4gPLZ1zV6HuKzVdiJLU/Dn2cbFsa/zav
	 M9z+8yMbZaxHoVbMTp/80yFl7zUSHiknLrW70b5R+Otdu2RbppR016wo1sO51yyZ1j
	 BFrlCvGOR7SBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liming Sun <limings@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	vadimp@nvidia.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/21] platform/mellanox: mlxbf-tmfifo: Drop Tx network packet when Tx TmFIFO is full
Date: Fri,  2 Feb 2024 13:39:52 -0500
Message-ID: <20240202184015.540966-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184015.540966-1-sashal@kernel.org>
References: <20240202184015.540966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
Content-Transfer-Encoding: 8bit

From: Liming Sun <limings@nvidia.com>

[ Upstream commit 8cbc756b802605dee3dd40019bd75960772bacf5 ]

Starting from Linux 5.16 kernel, Tx timeout mechanism was added
in the virtio_net driver which prints the "Tx timeout" warning
message when a packet stays in Tx queue for too long. Below is an
example of the reported message:

"[494105.316739] virtio_net virtio1 tmfifo_net0: TX timeout on
queue: 0, sq: output.0, vq: 0×1, name: output.0, usecs since
last trans: 3079892256".

This issue could happen when external host driver which drains the
FIFO is restared, stopped or upgraded. To avoid such confusing
"Tx timeout" messages, this commit adds logic to drop the outstanding
Tx packet if it's not able to transmit in two seconds due to Tx FIFO
full, which can be considered as congestion or out-of-resource drop.

This commit also handles the special case that the packet is half-
transmitted into the Tx FIFO. In such case, the packet is discarded
with remaining length stored in vring->rem_padding. So paddings with
zeros can be sent out when Tx space is available to maintain the
integrity of the packet format. The padded packet will be dropped on
the receiving side.

Signed-off-by: Liming Sun <limings@nvidia.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240111173106.96958-1-limings@nvidia.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 67 ++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index ab7d7a1235b8..39828eb84e0b 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -47,6 +47,9 @@
 /* Message with data needs at least two words (for header & data). */
 #define MLXBF_TMFIFO_DATA_MIN_WORDS		2
 
+/* Tx timeout in milliseconds. */
+#define TMFIFO_TX_TIMEOUT			2000
+
 /* ACPI UID for BlueField-3. */
 #define TMFIFO_BF3_UID				1
 
@@ -62,12 +65,14 @@ struct mlxbf_tmfifo;
  * @drop_desc: dummy desc for packet dropping
  * @cur_len: processed length of the current descriptor
  * @rem_len: remaining length of the pending packet
+ * @rem_padding: remaining bytes to send as paddings
  * @pkt_len: total length of the pending packet
  * @next_avail: next avail descriptor id
  * @num: vring size (number of descriptors)
  * @align: vring alignment size
  * @index: vring index
  * @vdev_id: vring virtio id (VIRTIO_ID_xxx)
+ * @tx_timeout: expire time of last tx packet
  * @fifo: pointer to the tmfifo structure
  */
 struct mlxbf_tmfifo_vring {
@@ -79,12 +84,14 @@ struct mlxbf_tmfifo_vring {
 	struct vring_desc drop_desc;
 	int cur_len;
 	int rem_len;
+	int rem_padding;
 	u32 pkt_len;
 	u16 next_avail;
 	int num;
 	int align;
 	int index;
 	int vdev_id;
+	unsigned long tx_timeout;
 	struct mlxbf_tmfifo *fifo;
 };
 
@@ -819,6 +826,50 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct mlxbf_tmfifo_vring *vring,
 	return true;
 }
 
+static void mlxbf_tmfifo_check_tx_timeout(struct mlxbf_tmfifo_vring *vring)
+{
+	unsigned long flags;
+
+	/* Only handle Tx timeout for network vdev. */
+	if (vring->vdev_id != VIRTIO_ID_NET)
+		return;
+
+	/* Initialize the timeout or return if not expired. */
+	if (!vring->tx_timeout) {
+		/* Initialize the timeout. */
+		vring->tx_timeout = jiffies +
+			msecs_to_jiffies(TMFIFO_TX_TIMEOUT);
+		return;
+	} else if (time_before(jiffies, vring->tx_timeout)) {
+		/* Return if not timeout yet. */
+		return;
+	}
+
+	/*
+	 * Drop the packet after timeout. The outstanding packet is
+	 * released and the remaining bytes will be sent with padding byte 0x00
+	 * as a recovery. On the peer(host) side, the padding bytes 0x00 will be
+	 * either dropped directly, or appended into existing outstanding packet
+	 * thus dropped as corrupted network packet.
+	 */
+	vring->rem_padding = round_up(vring->rem_len, sizeof(u64));
+	mlxbf_tmfifo_release_pkt(vring);
+	vring->cur_len = 0;
+	vring->rem_len = 0;
+	vring->fifo->vring[0] = NULL;
+
+	/*
+	 * Make sure the load/store are in order before
+	 * returning back to virtio.
+	 */
+	virtio_mb(false);
+
+	/* Notify upper layer. */
+	spin_lock_irqsave(&vring->fifo->spin_lock[0], flags);
+	vring_interrupt(0, vring->vq);
+	spin_unlock_irqrestore(&vring->fifo->spin_lock[0], flags);
+}
+
 /* Rx & Tx processing of a queue. */
 static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 {
@@ -841,6 +892,7 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 		return;
 
 	do {
+retry:
 		/* Get available FIFO space. */
 		if (avail == 0) {
 			if (is_rx)
@@ -851,6 +903,17 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 				break;
 		}
 
+		/* Insert paddings for discarded Tx packet. */
+		if (!is_rx) {
+			vring->tx_timeout = 0;
+			while (vring->rem_padding >= sizeof(u64)) {
+				writeq(0, vring->fifo->tx.data);
+				vring->rem_padding -= sizeof(u64);
+				if (--avail == 0)
+					goto retry;
+			}
+		}
+
 		/* Console output always comes from the Tx buffer. */
 		if (!is_rx && devid == VIRTIO_ID_CONSOLE) {
 			mlxbf_tmfifo_console_tx(fifo, avail);
@@ -860,6 +923,10 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
 		/* Handle one descriptor. */
 		more = mlxbf_tmfifo_rxtx_one_desc(vring, is_rx, &avail);
 	} while (more);
+
+	/* Check Tx timeout. */
+	if (avail <= 0 && !is_rx)
+		mlxbf_tmfifo_check_tx_timeout(vring);
 }
 
 /* Handle Rx or Tx queues. */
-- 
2.43.0


