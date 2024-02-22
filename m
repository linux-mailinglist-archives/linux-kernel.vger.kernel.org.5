Return-Path: <linux-kernel+bounces-75752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CD185EE71
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A73E1C213EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A02711CBC;
	Thu, 22 Feb 2024 01:07:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A398511724
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564034; cv=none; b=sbMa8/BCTStql4GAMZInksZEi3PdR8w9pf0DalpT3kiCUtLL15VEyXfIAKhQPbbWrhmCJopKIVtoTCjCBE6KCMt0hO88sfffGWrayw++rMUcL79tqXw3Y79KhFyUCl2KHqYYYoSTcMHJ4tBgNuGE/cvi6TnBQw7KcV8MZyPz/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564034; c=relaxed/simple;
	bh=1VaxxzkOjNlNPknS6Jq3eEShJah4/V3IV/jcUNjEdMc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PGtisDQAHJLMMkcfM1YteD8BLfwdLnjT34UJBTyGKDkxPubU9BSNPXNrHeHe6vwyWPBXm0u1+mCE3dnGLu07oZ0ug1r1CSmrdY66VgZkr6LLWie39cgp4xHHhBim/OnF4Vm6o0IVO/t3Zy9in4IlEUgxaEm/20FyS3OQH+CkLaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B01C433F1;
	Thu, 22 Feb 2024 01:07:13 +0000 (UTC)
Date: Wed, 21 Feb 2024 20:09:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [for-linus][PATCH] ring-buffer: Do not let subbuf be bigger than
 write mask
Message-ID: <20240221200901.242eb6e0@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The data on the subbuffer is measured by a write variable that also
contains status flags. The counter is just 20 bits in length. If the
subbuffer is bigger than then counter, it will fail.

Make sure that the subbuffer can not be set to greater than the counter
that keeps track of the data on the subbuffer.

Link: https://lore.kernel.org/linux-trace-kernel/20240220095112.77e9cb81@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 2808e31ec12e5 ("ring-buffer: Add interface for configuring trace sub buffer size")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fd4bfe3ecf01..0699027b4f4c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5877,6 +5877,10 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (psize <= BUF_PAGE_HDR_SIZE)
 		return -EINVAL;
 
+	/* Size of a subbuf cannot be greater than the write counter */
+	if (psize > RB_WRITE_MASK + 1)
+		return -EINVAL;
+
 	old_order = buffer->subbuf_order;
 	old_size = buffer->subbuf_size;
 
-- 
2.43.0


