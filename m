Return-Path: <linux-kernel+bounces-79406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9DB8621AA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8956AB229B8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E4F4A12;
	Sat, 24 Feb 2024 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rabPkwEp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB403C39;
	Sat, 24 Feb 2024 01:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737288; cv=none; b=FekCrNqSVph9WfIYmitViIB/i/in7WN/1/RJdNlIEfDBtOYFE1ZzwQ6Eny6WMEPn3+uElO4oXq+ALdH+r+FtmW4UlPm57Li6/hli6lZSj52nJzsIcU62oOIlkP023yAZ3I47dfrfynG4CP9NK0WDWkag6FTtRmpUPLGSq+54Ktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737288; c=relaxed/simple;
	bh=WrJLvBrJN6c+u26aFr/AFgdi3noYUY58rrqupm7VACE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ta56BMH9rDbd5041QKwaYr/3h2/inTTipB9ckVAyVy+8Ze6QRW90oQpRH/UNWGrvhe3ftazB6hpLVUygdIxkWHI0AKPZXlD/ABpZLkKS1rIYy3Ved63/VdVhMdIgADtN1tVsBn1yW7oGcNeEOymS6ANTwyQDhwzJqH3w6bic+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rabPkwEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F876C433F1;
	Sat, 24 Feb 2024 01:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708737287;
	bh=WrJLvBrJN6c+u26aFr/AFgdi3noYUY58rrqupm7VACE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rabPkwEpUOEP551icQaUSJYixrIFwuCuW8iGr8AKhmy2rZdJYpmTS3ohjLNTTbbG+
	 bMjmqziTVJVe+MpL/FPOIkTqPh5KE6a2MDlfbHP8fw8ZiJDB4HLRR1xwtoVs2KN70+
	 Xw+YZ9HhnyOkVjTqqru1Csa/DkKwLFRu6m6Fdyq5xP/h1GsMjSebjrmzQXRVr+8V4J
	 iMt0fBR66fpj4EV1zdAIALki9SbXn/7wPVQHJCm0Rv/i6vU6lrH1pQyTDcgM4o7A+y
	 Kj1FAtnw09D5dsQOZr96iORae+EhMCkmFELaohq0mS+ILZo7xEAui1hry13DcuPij3
	 TAr3jv1rdC+hw==
Date: Fri, 23 Feb 2024 17:14:47 -0800
Subject: [PATCH 04/10] bcachefs: thread_with_stdio: fix
 bch2_stdio_redirect_readline()
From: "Darrick J. Wong" <djwong@kernel.org>
To: akpm@linux-foundation.org, daniel@gluo.nz, kent.overstreet@linux.dev,
 djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <170873668950.1861398.18421058347092974314.stgit@frogsfrogsfrogs>
In-Reply-To: <170873668859.1861398.2367011381778949840.stgit@frogsfrogsfrogs>
References: <170873668859.1861398.2367011381778949840.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Kent Overstreet <kent.overstreet@linux.dev>

This fixes a bug where we'd return data without waiting for a newline,
if data was present but a newline was not.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/bcachefs/thread_with_file.c |   33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)


diff --git a/fs/bcachefs/thread_with_file.c b/fs/bcachefs/thread_with_file.c
index eb8ab4c47a94b..830efb06ef0be 100644
--- a/fs/bcachefs/thread_with_file.c
+++ b/fs/bcachefs/thread_with_file.c
@@ -277,25 +277,36 @@ int bch2_stdio_redirect_read(struct stdio_redirect *stdio, char *ubuf, size_t le
 int bch2_stdio_redirect_readline(struct stdio_redirect *stdio, char *ubuf, size_t len)
 {
 	struct stdio_buf *buf = &stdio->input;
-
+	size_t copied = 0;
+	ssize_t ret = 0;
+again:
 	wait_event(buf->wait, stdio_redirect_has_input(stdio));
-	if (stdio->done)
-		return -1;
+	if (stdio->done) {
+		ret = -1;
+		goto out;
+	}
 
 	spin_lock(&buf->lock);
-	int ret = min(len, buf->buf.nr);
-	char *n = memchr(buf->buf.data, '\n', ret);
-	if (!n)
-		ret = min(ret, n + 1 - buf->buf.data);
-	buf->buf.nr -= ret;
-	memcpy(ubuf, buf->buf.data, ret);
+	size_t b = min(len, buf->buf.nr);
+	char *n = memchr(buf->buf.data, '\n', b);
+	if (n)
+		b = min_t(size_t, b, n + 1 - buf->buf.data);
+	buf->buf.nr -= b;
+	memcpy(ubuf, buf->buf.data, b);
 	memmove(buf->buf.data,
-		buf->buf.data + ret,
+		buf->buf.data + b,
 		buf->buf.nr);
+	ubuf += b;
+	len -= b;
+	copied += b;
 	spin_unlock(&buf->lock);
 
 	wake_up(&buf->wait);
-	return ret;
+
+	if (!n && len)
+		goto again;
+out:
+	return copied ?: ret;
 }
 
 __printf(3, 0)


