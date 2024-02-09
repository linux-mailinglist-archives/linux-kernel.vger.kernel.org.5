Return-Path: <linux-kernel+bounces-59387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A55BA84F631
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD701F238FC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5074CE11;
	Fri,  9 Feb 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ETBDqY2w"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838CC4CB50;
	Fri,  9 Feb 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486716; cv=none; b=a9hkqvkqvvBrTrVUHDOHnY5uEAV6MRixS3OVjSxuwleO3+fpLlK4H96GyEcNfqOM7YOiExXo1gCuS3jZlaadddZ00vS9mPn/ktt5jK/Z17NlNR+674jHSgjGs7owBzhYk6CTEP7wjCWSrkGTjt//9Hu+wBXy2A8awk+b0Vs8ssA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486716; c=relaxed/simple;
	bh=0bD1Yt7GaMWvgagUDRUd142oKOAha2Uum7epnkYDwYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ESGfy75wSIMA286Yq0/RhFBqyrScWuNFSXpS6raLKCCQU0aBpvCev4GN0ZxBjgj86MyvY5OkdwHc/hMD0vRdU7oNPrFwzFgM0tupmCGsrpcY+5/QDZ0OdOpcE9JraVe+oyEPPonN5GrAJqzI8nCtyijCLaK/bQT56Pij0tnlSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ETBDqY2w; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 4F523C386D;
	Fri,  9 Feb 2024 13:51:46 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E403C0006;
	Fri,  9 Feb 2024 13:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707486697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AUYRGdnXj82lH9bL33wM3PM4HJIHlriE6TD1Z3Nt0sI=;
	b=ETBDqY2wPkcGTEGRxzebBkunFGckdAZ804L/mgWOjGLEwhXdfrfZsC1Lo4bpwlQEtpenTc
	SQbuIBUO1JJ1Oktdw+aRH0j8OYDhXSQMhGu/SlXI+oENT0tA7jl0pn739yIqJgr2Svw/mB
	EKJNmaCqj2wnnxGN69xlpwa4NSAgaW50GacDj0IYhM455+2IdpIEHfq4F1LVRB1MUVwE7W
	UNryUU/48r46YzAJFc4sY+/bLMmIVpSWVR5J+FSQbZQsmVfr+uCcLM4gtNAhu02O6ep605
	YJeriIHtnOAYVCVYFMiyI7V63hJiYBB8KC2P2B/rR2dO/YdN2LyN8qyJjMsZfg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 14:51:23 +0100
Subject: [PATCH] spi: spi-mem: add statistics support to ->exec_op() calls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-spi-mem-stats-v1-1-dd1a422fc015@bootlin.com>
X-B4-Tracking: v=1; b=H4sIANotxmUC/x3MMQqAMAxA0auUzAZqEaReRRy0JprBWhoRQXp3i
 +Mb/n9BKQspDOaFTLeonLGibQyEfY4boazV4KzrrLMeNQkedKBe86XI7Bf2bbDcE9QmZWJ5/t8
 4lfIB4wjtUV8AAAA=
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dhruva Gole <d-gole@ti.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Current behavior is that spi-mem operations do not increment statistics,
neither per-controller nor per-device, if ->exec_op() is used. For
operations that do NOT use ->exec_op(), stats are increased as the
usual spi_sync() is called.

The newly implemented spi_mem_add_op_stats() function is strongly
inspired by spi_statistics_add_transfer_stats(); locking logic and
l2len computation comes from there.

Statistics that are being filled: bytes{,_rx,_tx}, messages, transfers,
errors, timedout, transfer_bytes_histo_*.

Note about messages & transfers counters: in the fallback to spi_sync()
case, there are from 1 to 4 transfers per message. We only register one
big transfer in the ->exec_op() case as that is closer to reality.

This patch is NOT touching:
 - spi_async, spi_sync, spi_sync_immediate: those counters describe
   precise function calls, incrementing them would be lying. I believe
   comparing the messages counter to spi_async+spi_sync is a good way
   to detect ->exec_op() calls, but I might be missing edge cases
   knowledge.
 - transfers_split_maxsize: splitting cannot happen if ->exec_op() is
   provided.

Testing this patch:

   $ cd /sys/devices/platform/soc
   $ find . -type d -path "*spi*" -name statistics
   ./2100000.spi/spi_master/spi0/statistics
   ./2100000.spi/spi_master/spi0/spi0.0/statistics
   $ cd ./2100000.spi/spi_master/spi0/statistics

   $ for f in *; do printf "%s\t" $f; cat $f; done | \
         grep -v transfer_bytes_histo | column -t
   bytes                    240745444
   bytes_rx                 240170907
   bytes_tx                 126320
   errors                   0
   messages                 97354
   spi_async                0
   spi_sync                 0
   spi_sync_immediate       0
   timedout                 0
   transfers                97354
   transfers_split_maxsize  0

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-mem.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 2dc8ceb85374..171fe6b1c247 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -297,6 +297,50 @@ static void spi_mem_access_end(struct spi_mem *mem)
 		pm_runtime_put(ctlr->dev.parent);
 }
 
+static void spi_mem_add_op_stats(struct spi_statistics __percpu *pcpu_stats,
+				 const struct spi_mem_op *op, int exec_op_ret)
+{
+	struct spi_statistics *stats;
+	int len, l2len;
+
+	get_cpu();
+	stats = this_cpu_ptr(pcpu_stats);
+	u64_stats_update_begin(&stats->syncp);
+
+	/*
+	 * We do not have the concept of messages or transfers. Let's consider
+	 * that one operation is equivalent to one message and one transfer.
+	 */
+	u64_stats_inc(&stats->messages);
+	u64_stats_inc(&stats->transfers);
+
+	/* Use the sum of all lengths as bytes count and histogram value. */
+	len = (int)op->cmd.nbytes + (int)op->addr.nbytes;
+	len += (int)op->dummy.nbytes + (int)op->data.nbytes;
+	u64_stats_add(&stats->bytes, len);
+	l2len = min(fls(len), SPI_STATISTICS_HISTO_SIZE) - 1;
+	l2len = max(l2len, 0);
+	u64_stats_inc(&stats->transfer_bytes_histo[l2len]);
+
+	/* Only account for data bytes as xferred bytes. */
+	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
+		u64_stats_add(&stats->bytes_tx, op->data.nbytes);
+	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN)
+		u64_stats_add(&stats->bytes_rx, op->data.nbytes);
+
+	/*
+	 * A timeout is not an error, following the same behavior as
+	 * spi_transfer_one_message().
+	 */
+	if (exec_op_ret == -ETIMEDOUT)
+		u64_stats_inc(&stats->timedout);
+	else if (exec_op_ret)
+		u64_stats_inc(&stats->errors);
+
+	u64_stats_update_end(&stats->syncp);
+	put_cpu();
+}
+
 /**
  * spi_mem_exec_op() - Execute a memory operation
  * @mem: the SPI memory
@@ -339,8 +383,12 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		 * read path) and expect the core to use the regular SPI
 		 * interface in other cases.
 		 */
-		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP)
+		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP) {
+			spi_mem_add_op_stats(ctlr->pcpu_statistics, op, ret);
+			spi_mem_add_op_stats(mem->spi->pcpu_statistics, op, ret);
+
 			return ret;
+		}
 	}
 
 	tmpbufsize = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;

---
base-commit: 19b50f80b3a4865bd477aa5c026dd234d39a50d2
change-id: 20240209-spi-mem-stats-ff9bf91c0f7e

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


