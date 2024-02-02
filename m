Return-Path: <linux-kernel+bounces-50350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F348477DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230B11C2532F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6245155A4D;
	Fri,  2 Feb 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofpEUZS3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7C2154C0B;
	Fri,  2 Feb 2024 18:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899177; cv=none; b=pZvEjvlKwINGlxeHAkolFis2m0WvsYepKYhQc2GbOnGo7ct9vddxvP1t6JG3mVINbzYmNlq8tMG+DPrY1/alxbBGMrB8gCKSZIho8ed7U41SOQPJGFkHlrEpk4Qlg/N1hD0tp/VfWMztvtshbFkYZDepZKvwm1FhCz4qlaUMWhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899177; c=relaxed/simple;
	bh=ExESEhOhbCKNtC+LyM0a/+hRPRQCztg9cxoSU4APgLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7BM8bupk2fcGv9s+mK4CVQEfl93X3AzN2DjfOspVYh1T/l9vNxEw4ghRIBk5hWg+7hnj52G57pyletVy22OwgfGrcXOz+2R8SaUT5mqqvJxFfeVf0K9cEC82DBDiOa4JvCMzvfrv47C/yFuboJ2rT1M8XUsD8WE3hb4b4CTf64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofpEUZS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5203DC43142;
	Fri,  2 Feb 2024 18:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899177;
	bh=ExESEhOhbCKNtC+LyM0a/+hRPRQCztg9cxoSU4APgLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ofpEUZS3Whyh8I8SspDfk5vo87zBKRIYX1kj6tvcrWfOMDcXxVpx9ote2qBqZW7Qx
	 ZDHOwz/V5t1AsQS91oEsOP1NoNVvS+YAIrW2sStEUN3vQsoLYDq8UNGZNo4diPwaZO
	 aoSpUp77WGi3awgoFXau58GMRNUujYJB9L2kSN5kWsnSxYkmDq2mKcbJqHO0QCS/bO
	 WR6jToWIq226mW662AqTMgcfLnYzhHHry6c+Jn5JUGC8D9Gehzzda5P+AqHt8oxghO
	 hSg5Mcm+bXFmWhQQk3SAdmsSIzE9B2vte7lHRKefgKezgrYZceky0KZ4s4jVcalsNO
	 7ytfGiGpEivgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liming Sun <limings@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	vadimp@nvidia.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 06/23] platform/mellanox: mlxbf-tmfifo: Drop Tx network packet when Tx TmFIFO is full
Date: Fri,  2 Feb 2024 13:39:02 -0500
Message-ID: <20240202183926.540467-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
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
index 5c683b4eaf10..f39b7b9d2bfe 100644
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


