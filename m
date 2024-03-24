Return-Path: <linux-kernel+bounces-113050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2088B888112
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9EAE1F237B7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA0A143C5B;
	Sun, 24 Mar 2024 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUBADQqw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF0F14291E;
	Sun, 24 Mar 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319859; cv=none; b=fYEZr+/BgXux6t9CpGyXNdyQJgGWw2visRYiugLrctVBysHqOn+AlWeg7pa5R0MtwtEWpYLAu/AoKeR1k3qiG7TA33rJ9B8W4Vy4HZo7UxmtbXF7xM4MEdoQWzNlPs/bVB0vmlRP7/oNXG49PiEFtPHI+ZDfEN+T/yI/CJagZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319859; c=relaxed/simple;
	bh=55Nb6Gl3zSs4ji63PyDfoyTChWWBkNx9WldkUmv7yW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7xVmEKaaUkP1JVfCBgrGRmC00lvhR0uChXPYbHfhUOpY3piWv+nz04FGuhHJEBsqeIodk5K7OZ1wvFgNbFp4BwBi64PSDea9Z3LmCyQnqP7GDYgqRPmoRA8CJyEeEFA3pdGJR1MvxdOJRscUh0wsNlybyPBdyMzXeI6vssGA54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUBADQqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE80AC433C7;
	Sun, 24 Mar 2024 22:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319859;
	bh=55Nb6Gl3zSs4ji63PyDfoyTChWWBkNx9WldkUmv7yW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUBADQqwRLKG+vXVYhERb1zum9zrX9TybyH5boR+RRfIq+tLMwBny/bzmjGK6lm3Y
	 V+vfh035uVcG753ETbTySi7zrVyPtzewpTvS7t6ZBK0edzIdG6DQM3RVDNvSo8GZwP
	 i/hY6nvFSQ7PPL7eOOLNEJXWUkim7pCt1Mw6hbgEUMEBO+sq01jHWZ3VPuRJkqKF66
	 a6eLXrlTWx65c66yz20zHX/xD4WpISkPitw8miLdI3SEuH8iM8JuQWik48TsPIa5PU
	 T99dLola3GB+NymK2FP3N7jMVbDeZ87Vr+9o4bA8xhW1lrfQPnLuJ+WNQO4KEJMlNi
	 S07FV2ypsB8yw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 163/715] printk: ringbuffer: Cleanup reader terminology
Date: Sun, 24 Mar 2024 18:25:42 -0400
Message-ID: <20240324223455.1342824-164-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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

[ Upstream commit 584528d621459d1a5c31da7a591218ad3bb96d6c ]

With the lockless ringbuffer, it is allowed that multiple
CPUs/contexts write simultaneously into the buffer. This creates
an ambiguity as some writers will finalize sooner.

The documentation for the prb_read functions is not clear as it
refers to "not yet written" and "no data available". Clarify the
return values and language to be in terms of the reader: records
available for reading.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240207134103.1357162-9-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
Stable-dep-of: b1c4c67a5e90 ("printk: ringbuffer: Skip non-finalized records in panic")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk_ringbuffer.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d152b6bd35c9a..97ec25d227976 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -2080,11 +2080,13 @@ u64 prb_next_reserve_seq(struct printk_ringbuffer *rb)
 }
 
 /*
- * Non-blocking read of a record. Updates @seq to the last finalized record
- * (which may have no data available).
+ * Non-blocking read of a record.
  *
- * See the description of prb_read_valid() and prb_read_valid_info()
- * for details.
+ * On success @seq is updated to the record that was read and (if provided)
+ * @r and @line_count will contain the read/calculated data.
+ *
+ * On failure @seq is updated to a record that is not yet available to the
+ * reader, but it will be the next record available to the reader.
  */
 static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			    struct printk_record *r, unsigned int *line_count)
@@ -2103,7 +2105,7 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			*seq = tail_seq;
 
 		} else if (err == -ENOENT) {
-			/* Record exists, but no data available. Skip. */
+			/* Record exists, but the data was lost. Skip. */
 			(*seq)++;
 
 		} else {
@@ -2136,7 +2138,7 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
  * On success, the reader must check r->info.seq to see which record was
  * actually read. This allows the reader to detect dropped records.
  *
- * Failure means @seq refers to a not yet written record.
+ * Failure means @seq refers to a record not yet available to the reader.
  */
 bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
 		    struct printk_record *r)
@@ -2166,7 +2168,7 @@ bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
  * On success, the reader must check info->seq to see which record meta data
  * was actually read. This allows the reader to detect dropped records.
  *
- * Failure means @seq refers to a not yet written record.
+ * Failure means @seq refers to a record not yet available to the reader.
  */
 bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 			 struct printk_info *info, unsigned int *line_count)
-- 
2.43.0


