Return-Path: <linux-kernel+bounces-41695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5187C83F696
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833B81C21EA6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464144C615;
	Sun, 28 Jan 2024 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxYhznaE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31E4C635;
	Sun, 28 Jan 2024 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458315; cv=none; b=EeqNz0c5xSL/DyAWjqwQmBJErI1VQ7vbdtQ2wFfMU0QkxI1DUk/Z77B/AL5mZPsDCQ5GHdUaB7kbIXJmH6gdB33WgHlfjIUdc2OBU1B10DIulmYLlair9QeNQ+ZDO+e40jWT4tvWj7LBGfgMe+olW6IgBzA54b9JVV3g2MYFn+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458315; c=relaxed/simple;
	bh=EEZSc3WaQHYQ6VwPB/6c5iwSlWTgnNytXtNgRzN8WzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIZ0sX6cTuI6/B3+VQg++ou+Vbuok8BO/Tlxn83cKQu53BUhOa0F1R40Ax8cvxRNNVp9rH56OFUa19OeZ2Q+0fTyVGjYsxSf2VIjhJULW6gebEOqen6G1AtFZPZ7zKcHU5KO2X9df/0l5fEvVvKxabnsFWTxFjI9MRzLFfkzfvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxYhznaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BCCC43390;
	Sun, 28 Jan 2024 16:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458315;
	bh=EEZSc3WaQHYQ6VwPB/6c5iwSlWTgnNytXtNgRzN8WzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KxYhznaEgrd2wRE8SmEjHcV3A5UANnauRgi2/A1xaZ40gHR74N/4ZroLfRQY0gXDG
	 5mg69tbdM2nsKVkfhKJP3TKUmPgZj2W6D6ZniETlQBCgS9wOTWdg9+4a6ajDXmnlWQ
	 56Fz/lzIN3ewSVPAId01j10N22yoo+I2oWJOfWQoPS95gqutUEgeAMFrp52+22pR0C
	 30xwYts8AdEoGBGpbqgwt5CM7kuMf/ottdH1GnDBOOW/u93ZuP6VGHOeRFLdzLIWZb
	 raUtbH+qL2HC8x/s8/92iqLINdQfxi54AkizkHo7RxyzsDPzz8p0tHpH85pgE/hgsn
	 Az43ZHUH9TeOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 13/39] ring-buffer: Do no swap cpu buffers if order is different
Date: Sun, 28 Jan 2024 11:10:33 -0500
Message-ID: <20240128161130.200783-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

[ Upstream commit b81e03a24966dca0b119eff0549a4e44befff419 ]

As all the subbuffer order (subbuffer sizes) must be the same throughout
the ring buffer, check the order of the buffers that are doing a CPU
buffer swap in ring_buffer_swap_cpu() to make sure they are the same.

If the are not the same, then fail to do the swap, otherwise the ring
buffer will think the CPU buffer has a specific subbuffer size when it
does not.

Link: https://lore.kernel.org/linux-trace-kernel/20231219185629.467894710@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9286f88fcd32..f9d9309884d1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5461,6 +5461,9 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
 		goto out;
 
+	if (buffer_a->subbuf_order != buffer_b->subbuf_order)
+		goto out;
+
 	ret = -EAGAIN;
 
 	if (atomic_read(&buffer_a->record_disabled))
-- 
2.43.0


