Return-Path: <linux-kernel+bounces-114081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B46888848
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836941C27504
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C37F2365BA;
	Sun, 24 Mar 2024 23:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9tnF1r1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32440130E2F;
	Sun, 24 Mar 2024 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321378; cv=none; b=F6jVQiv78XVOCXZVdmzv1D3yqK5KOPAFFdsrGaFLrUqaGk+KKYJ/odvg++B6+H5L4dSneZBeXQPI0Wz+rIbD4a8GdttWkiyZbREEpxS/b7yeb+RiH8GqB7Ezbd4E88Pev7AtHa+8pqG79deeWush2lzPehxCVoAvTMn5CwoAuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321378; c=relaxed/simple;
	bh=+mRypTj2AN+uFrmsMst73xXavbGCXAj069qIzrAjzZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTcDxpVu5cL1/zPS4lkI/X60JVQWaSBBFIZgM8cHbS9jTWHxP4vEGTSDllM5mDkCbYiswIWpShc4fFK8y3ISZ/ys1jjVLudwpFy4uqfhdcGCJcqiOiIUDGAS+/qtjTxTcm2Dc1Vtq6clirSniENqltaJ65tvQgtQRpoMkANd0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9tnF1r1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4DCC433F1;
	Sun, 24 Mar 2024 23:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321377;
	bh=+mRypTj2AN+uFrmsMst73xXavbGCXAj069qIzrAjzZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9tnF1r1584Y1EcuAt4aL7iexq9/ad6hKhe/88OJhjKRpHFsdLEdteAIlBIk8h5xA
	 09XJqwCkwpa3bPoBnk5ERj25eELiLAF6LOMJHnHbK0WQy+DTyr6cCaPpO2anx4DYig
	 UT0qi2mgh4sUP7Ba747SqVhlERLaIn1JZn0rTI5KdKJOiKK2sJ/CVkeZgso6VUO9Az
	 6GDGmle2hqbHChgpGw3nYvxBODFkv+bbb+vlOf5Bq7onLYnTyn0+5dEVYOE5eoG04G
	 Ypar0QQQqAHRWvZxIDQ0AjkgmgIYUZfYkx+23NRR2qutwhBD2lNkVTyoxuRGNsh7/f
	 x1pL3FA62wIpw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 101/638] io_uring/net: fix overflow check in io_recvmsg_mshot_prep()
Date: Sun, 24 Mar 2024 18:52:18 -0400
Message-ID: <20240324230116.1348576-102-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 8ede3db5061bb1fe28e2c9683329aafa89d2b1b4 ]

The "controllen" variable is type size_t (unsigned long).  Casting it
to int could lead to an integer underflow.

The check_add_overflow() function considers the type of the destination
which is type int.  If we add two positive values and the result cannot
fit in an integer then that's counted as an overflow.

However, if we cast "controllen" to an int and it turns negative, then
negative values *can* fit into an int type so there is no overflow.

Good: 100 + (unsigned long)-4 = 96  <-- overflow
 Bad: 100 + (int)-4 = 96 <-- no overflow

I deleted the cast of the sizeof() as well.  That's not a bug but the
cast is unnecessary.

Fixes: 9b0fc3c054ff ("io_uring: fix types in io_recvmsg_multishot_overflow")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/138bd2e2-ede8-4bcc-aa7b-f3d9de167a37@moroto.mountain
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 1d9bfde71809a..058e04ea68c04 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -544,10 +544,10 @@ static int io_recvmsg_mshot_prep(struct io_kiocb *req,
 
 		if (unlikely(namelen < 0))
 			return -EOVERFLOW;
-		if (check_add_overflow((int)sizeof(struct io_uring_recvmsg_out),
+		if (check_add_overflow(sizeof(struct io_uring_recvmsg_out),
 					namelen, &hdr))
 			return -EOVERFLOW;
-		if (check_add_overflow(hdr, (int)controllen, &hdr))
+		if (check_add_overflow(hdr, controllen, &hdr))
 			return -EOVERFLOW;
 
 		iomsg->namelen = namelen;
-- 
2.43.0


