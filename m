Return-Path: <linux-kernel+bounces-113549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6C6888537
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673862859F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202F11C3A0C;
	Sun, 24 Mar 2024 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6B3Ass3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD7A1C3237;
	Sun, 24 Mar 2024 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320351; cv=none; b=la0ke5XqFFVp26w86ROar5LzB+7UzQALNQhJx4DQhy5WAMxZ4kvW8n4820Ryx+j1hy8IDhEkYefhwCNqYgtqop8/D9U99VE91OhLJt4SN2uwjVjatjUBAXPWxW7izKWSk2DB/qUpJaWiJy07nRmn1PORNoo1gCiEPkXFH7DgTu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320351; c=relaxed/simple;
	bh=6QcKVKhsz0yjOBwDP43BJ3uYz5U/2b6YPqh6YIwd6xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gE5ohuXC5gc1YsNbI3Lcu0phZ6Al+EXTOTfitsPdSiZah9kUfV3EK1W1rEdi3HII2xZ6iRiy+fwwwGC6I+9QlJKUO3WH2H/M5YTnqUwos+mhj50GZvpZjAKgo5gs9taqltZW2s/lTX+z8eb9mTxXBB1tcOlbph6SkycJIDZQjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6B3Ass3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9A1C433F1;
	Sun, 24 Mar 2024 22:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320351;
	bh=6QcKVKhsz0yjOBwDP43BJ3uYz5U/2b6YPqh6YIwd6xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o6B3Ass3md6dF7AupIkfpu0JirEJv4F0/QWOvkEvsW1Cv0v39RE46zuJWdQyCxDOF
	 bpxQHNwdpwuJt3GqLBPsacSSfVwLLKwJKTS7nwS43yHm136ziucJ1nXBLa8/lA2d24
	 ox86kVTHlWDXVkEvT6M4h3IZofzjX79v0dtdYB6/A1rU7+hNzi489UoxI8XZqMb1nU
	 rTsNyf1Bt92nu8Ee/3C53SA2ifR7foKwHr7wCs6V+pQDoPF9yKFXrWr2a2bmYCuNTa
	 sGkdFSgZ/tY69ghQt/eCVkqTb4fjeFEARHClHz0tP8OzEVhkQhUUt8ZvtShTutLtIy
	 xgqXuu0bG9Uxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Dhruva Gole <d-gole@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 658/715] spi: spi-mem: add statistics support to ->exec_op() calls
Date: Sun, 24 Mar 2024 18:33:57 -0400
Message-ID: <20240324223455.1342824-659-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Théo Lebrun <theo.lebrun@bootlin.com>

[ Upstream commit e63aef9c9121e5061cbf5112d12cadc9da399692 ]

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

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://msgid.link/r/20240216-spi-mem-stats-v2-1-9256dfe4887d@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 29895ce18311 ("spi: Fix error code checking in spi_mem_exec_op()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mem.c | 49 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 2dc8ceb85374b..c9d6d42a88f55 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -297,6 +297,49 @@ static void spi_mem_access_end(struct spi_mem *mem)
 		pm_runtime_put(ctlr->dev.parent);
 }
 
+static void spi_mem_add_op_stats(struct spi_statistics __percpu *pcpu_stats,
+				 const struct spi_mem_op *op, int exec_op_ret)
+{
+	struct spi_statistics *stats;
+	u64 len, l2len;
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
+	len = op->cmd.nbytes + op->addr.nbytes;
+	len += op->dummy.nbytes + op->data.nbytes;
+	u64_stats_add(&stats->bytes, len);
+	l2len = min(fls(len), SPI_STATISTICS_HISTO_SIZE) - 1;
+	u64_stats_inc(&stats->transfer_bytes_histo[l2len]);
+
+	/* Only account for data bytes as transferred bytes. */
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
@@ -339,8 +382,12 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
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
-- 
2.43.0


