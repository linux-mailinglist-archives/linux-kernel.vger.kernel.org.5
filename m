Return-Path: <linux-kernel+bounces-79415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5EB8621BD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6ED62867F6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB242C129;
	Sat, 24 Feb 2024 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOIqvMcy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1833AD5E;
	Sat, 24 Feb 2024 01:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737413; cv=none; b=OWy40jXb9vlNUomKA3F9CtRoi8AvfYDQ1vLJ/wfWUat/LGjcI/puX0Yk2luGxC4FJAH74T2tR2vx1CUAvSVVOMvCygHbCDZ0NOrZITyCbXf1riyuMPYvM5cJnjOkWlsvTjlQy9W2403Y/T0d2x0T0EhALH4/28AeSSdJ0auuGKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737413; c=relaxed/simple;
	bh=9DdYqFD9SCt6Bs3yagJsGZvwLwjDk5KJDyGnik7FRVc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fe5zGy/V0Qfw0I8PZAHZ0jwNM0/wBH8tRrQLSjLObRwFouTOMoIJR3Up+ExpFkUHLUGpDOVunzrx7Pi4NXXrNjjVyd8HtLMUxLvvZKVvV/upy2oc4xnSATYra85Y0bDtk1/86He0em9aMJz8FXpzfMgQEfOa8QCb+JH1ynmVagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOIqvMcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9A2C433F1;
	Sat, 24 Feb 2024 01:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737412;
	bh=9DdYqFD9SCt6Bs3yagJsGZvwLwjDk5KJDyGnik7FRVc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=vOIqvMcyt+32zXP2UCe88hRtJCelg0FwZfmQBcvXE9j0z1IgTAdoOaFQkHQ/l0rbU
	 9CjbeiD3ZXFQCIS3hoMbSDyXnuBNdd39egbSvfLmJu1dMSdhN90Bcw09VbzxGQtom+
	 QUQxqWjLykes47at+0dAhupRIlXPhwsUi8KZ2+0nYbvQ1qGBl4DyCKOIAC8K4U8BM8
	 nzr5mOYLCybLbmxcUfE+0gHR967oE8lDZ2y1zw3fE2P6qVP1Qzc2dieZ2I4tirC876
	 0BH4yRRXChejM2VlctRB7MxbZDnLTeUnk1Jqch48Ey488lGOTdo6rORdxFLpryBOvW
	 ztmTQ55BtRteQ==
Date: Fri, 23 Feb 2024 17:16:52 -0800
Subject: [PATCH 2/5] thread_with_file: fix various printf problems
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873669433.1861696.1893338653788145361.stgit@frogsfrogsfrogs>
In-Reply-To: <170873669390.1861696.14195299906744951144.stgit@frogsfrogsfrogs>
References: <170873669390.1861696.14195299906744951144.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Experimentally fix some problems with stdio_redirect_vprintf by creating
a MOO variant with which we can experiment.  We can't do a GFP_KERNEL
allocation while holding the spinlock, and I don't like how the printf
function can silently truncate the output if memory allocation fails.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/thread_with_file.h |    4 +--
 lib/thread_with_file.c           |   55 ++++++++++++++++++++++++++------------
 2 files changed, 39 insertions(+), 20 deletions(-)


diff --git a/include/linux/thread_with_file.h b/include/linux/thread_with_file.h
index 5f7e85bc8322b..7b133a15d3540 100644
--- a/include/linux/thread_with_file.h
+++ b/include/linux/thread_with_file.h
@@ -68,7 +68,7 @@ int run_thread_with_stdout(struct thread_with_stdio *,
 int stdio_redirect_read(struct stdio_redirect *, char *, size_t);
 int stdio_redirect_readline(struct stdio_redirect *, char *, size_t);
 
-__printf(3, 0) void stdio_redirect_vprintf(struct stdio_redirect *, bool, const char *, va_list);
-__printf(3, 4) void stdio_redirect_printf(struct stdio_redirect *, bool, const char *, ...);
+__printf(3, 0) ssize_t stdio_redirect_vprintf(struct stdio_redirect *, bool, const char *, va_list);
+__printf(3, 4) ssize_t stdio_redirect_printf(struct stdio_redirect *, bool, const char *, ...);
 
 #endif /* _LINUX_THREAD_WITH_FILE_H */
diff --git a/lib/thread_with_file.c b/lib/thread_with_file.c
index 71028611b8d59..70a805ef017f9 100644
--- a/lib/thread_with_file.c
+++ b/lib/thread_with_file.c
@@ -108,49 +108,68 @@ int stdio_redirect_readline(struct stdio_redirect *stdio, char *ubuf, size_t len
 EXPORT_SYMBOL_GPL(stdio_redirect_readline);
 
 __printf(3, 0)
-static void darray_vprintf(darray_char *out, gfp_t gfp, const char *fmt, va_list args)
+static ssize_t darray_vprintf(darray_char *out, gfp_t gfp, const char *fmt, va_list args)
 {
-	size_t len;
+	ssize_t ret;
 
 	do {
 		va_list args2;
+		size_t len;
+
 		va_copy(args2, args);
-
 		len = vsnprintf(out->data + out->nr, darray_room(*out), fmt, args2);
-	} while (len + 1 > darray_room(*out) && !darray_make_room_gfp(out, len + 1, gfp));
+		if (len + 1 <= darray_room(*out)) {
+			out->nr += len;
+			return len;
+		}
 
-	out->nr += min(len, darray_room(*out));
+		ret = darray_make_room_gfp(out, len + 1, gfp);
+	} while (ret == 0);
+
+	return ret;
 }
 
-void stdio_redirect_vprintf(struct stdio_redirect *stdio, bool nonblocking,
-			    const char *fmt, va_list args)
+ssize_t stdio_redirect_vprintf(struct stdio_redirect *stdio, bool nonblocking,
+			       const char *fmt, va_list args)
 {
 	struct stdio_buf *buf = &stdio->output;
 	unsigned long flags;
+	ssize_t ret;
 
-	if (!nonblocking)
-		wait_event(buf->wait, stdio_redirect_has_output_space(stdio));
-	else if (!stdio_redirect_has_output_space(stdio))
-		return;
-	if (stdio->done)
-		return;
-
+again:
 	spin_lock_irqsave(&buf->lock, flags);
-	darray_vprintf(&buf->buf, nonblocking ? GFP_NOWAIT : GFP_KERNEL, fmt, args);
+	ret = darray_vprintf(&buf->buf, GFP_NOWAIT, fmt, args);
 	spin_unlock_irqrestore(&buf->lock, flags);
 
+	if (ret < 0) {
+		if (nonblocking)
+			return -EAGAIN;
+
+		ret = wait_event_interruptible(buf->wait,
+				stdio_redirect_has_output_space(stdio));
+		if (ret)
+			return ret;
+		goto again;
+	}
+
 	wake_up(&buf->wait);
+	return ret;
+
 }
 EXPORT_SYMBOL_GPL(stdio_redirect_vprintf);
 
-void stdio_redirect_printf(struct stdio_redirect *stdio, bool nonblocking,
-			   const char *fmt, ...)
+ssize_t stdio_redirect_printf(struct stdio_redirect *stdio, bool nonblocking,
+			      const char *fmt, ...)
 {
 
 	va_list args;
+	ssize_t ret;
+
 	va_start(args, fmt);
-	stdio_redirect_vprintf(stdio, nonblocking, fmt, args);
+	ret = stdio_redirect_vprintf(stdio, nonblocking, fmt, args);
 	va_end(args);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(stdio_redirect_printf);
 


