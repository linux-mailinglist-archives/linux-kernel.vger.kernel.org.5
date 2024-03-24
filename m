Return-Path: <linux-kernel+bounces-113667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B5E888E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F027428EF74
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD077126F2F;
	Sun, 24 Mar 2024 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXe9vofX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6162114430E;
	Sun, 24 Mar 2024 22:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320660; cv=none; b=umTaGDmE/5ZKNWPlLTfoPJM9PjBPAn0CARuXbc/zX3Iz4C0tgDO9qT+gXUocRShQ1XTaKbzBjMORZOn/E2jh2U2AWdnT/7I77OnUR7mkOk605g1es7GhfEQnhIhiRorAHOQJgWNrZ27ifaWWfEaulRIZuXuEqYtB6nQ5FmqJCMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320660; c=relaxed/simple;
	bh=RN/Gjmnw+EceYASHDrod4BrDl4PiVcldLWDVe0b9138=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/9UsjaYPuvJFWz1M5NJYtEtgJL3fYva87iEHTdjCOBrDfhfwL0lH5oqnwOOUwWTnwG6pVZ8/++XjVX2jYPbyWVNY0f3tF+Nv/ZKYOHmsjiHnAvZwOKe47w7hbjXNjtNtou387ri1OkmcnoP9RS2QVIZX0Nsqyi7nxYuLHEmHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXe9vofX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EA7C433F1;
	Sun, 24 Mar 2024 22:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320659;
	bh=RN/Gjmnw+EceYASHDrod4BrDl4PiVcldLWDVe0b9138=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXe9vofXqNG3pBqxy3jcDMPibKXY/VKf4JotUeK4jrpG1ZxZSN8B3N6qTmf13jKyi
	 JHWr4N85OliICnRLTHz2kSg7ihHQj0zTLJu1nqMSARyOLKVF9zuGealaaWLvvqVDaH
	 2ZztYYIvA5i/9Q0hzlzQ2OR3HFQ5DyhtFfqaXhCLB3GmO9N9TYUC356RJTvwK/V9KL
	 EAY2pRrcZgLMvKizYOmF6zoifvFgmiN9ZwVrfEzfE3Piyi3iWD31wtOgUembSluS5c
	 W3nnyBD7uz6DvuuykhJfChnz4deZs0LmVZlwifFy3FWg3qXCNFCRsyr6BCi0fRo1R2
	 Yq0oOunGtOjAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 221/713] printk: ringbuffer: Skip non-finalized records in panic
Date: Sun, 24 Mar 2024 18:39:07 -0400
Message-ID: <20240324224720.1345309-222-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit b1c4c67a5e90db8fbdb5b5504fe16e17b564cca8 ]

Normally a reader will stop once reaching a non-finalized
record. However, when a panic happens, writers from other CPUs
(or an interrupted context on the panic CPU) may have been
writing a record and were unable to finalize it. The panic CPU
will reserve/commit/finalize its panic records, but these will
be located after the non-finalized records. This results in
panic() not flushing the panic messages.

Extend _prb_read_valid() to skip over non-finalized records if
on the panic CPU.

Fixes: 896fbe20b4e2 ("printk: use the lockless ringbuffer")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240207134103.1357162-11-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk_ringbuffer.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 97ec25d227976..3d98232902cfd 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -2087,6 +2087,10 @@ u64 prb_next_reserve_seq(struct printk_ringbuffer *rb)
  *
  * On failure @seq is updated to a record that is not yet available to the
  * reader, but it will be the next record available to the reader.
+ *
+ * Note: When the current CPU is in panic, this function will skip over any
+ *       non-existent/non-finalized records in order to allow the panic CPU
+ *       to print any and all records that have been finalized.
  */
 static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			    struct printk_record *r, unsigned int *line_count)
@@ -2109,8 +2113,28 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			(*seq)++;
 
 		} else {
-			/* Non-existent/non-finalized record. Must stop. */
-			return false;
+			/*
+			 * Non-existent/non-finalized record. Must stop.
+			 *
+			 * For panic situations it cannot be expected that
+			 * non-finalized records will become finalized. But
+			 * there may be other finalized records beyond that
+			 * need to be printed for a panic situation. If this
+			 * is the panic CPU, skip this
+			 * non-existent/non-finalized record unless it is
+			 * at or beyond the head, in which case it is not
+			 * possible to continue.
+			 *
+			 * Note that new messages printed on panic CPU are
+			 * finalized when we are here. The only exception
+			 * might be the last message without trailing newline.
+			 * But it would have the sequence number returned
+			 * by "prb_next_reserve_seq() - 1".
+			 */
+			if (this_cpu_in_panic() && ((*seq + 1) < prb_next_reserve_seq(rb)))
+				(*seq)++;
+			else
+				return false;
 		}
 	}
 
-- 
2.43.0


