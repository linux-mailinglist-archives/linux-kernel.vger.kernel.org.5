Return-Path: <linux-kernel+bounces-115827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF025889825
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7211C31546
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B642101A1;
	Mon, 25 Mar 2024 03:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pE01mjdJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BEB145B08;
	Sun, 24 Mar 2024 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322002; cv=none; b=jM3oX5ydLXmvoyB0M0ly5xLlZmS5ogi7oPsMdAhCdYLx3K5OiuVQmoMck5NWCwLtZhrpNiUusiujNNfVGYFTqnuNUB7Yo6URLXSpSjRGrBxHd+4k6mr4zYNfogup+NMQaaT24qus25T0KGUXXfoaIFr3ZbGNuS+6rXjfQnopfcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322002; c=relaxed/simple;
	bh=YM583JOqL3MJ6EuDsJhsm1gHhxEzlRG5GuE0LdoPFlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjJx5H3BfgvVg0JPkOofCoLiip1zHS5aOMLIsL9BdVxbkMAjh67xygTYQOkfM68MZkm8CtiYoKkiJxrCua0vDsFU6x1cSnuygRwUQyX24hJeBq7tXvjjANWC0j8ZQNdRNNO5aWNaSXnbooLpyVmjNW5GclV4kwzxaTYaRwF96HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pE01mjdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC44C433F1;
	Sun, 24 Mar 2024 23:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322002;
	bh=YM583JOqL3MJ6EuDsJhsm1gHhxEzlRG5GuE0LdoPFlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pE01mjdJmwDetu2cNrCunVvujklWghdQ5wO5DBL9AUByYCSRFDLPUxfZAn+UGNRn7
	 Sf6J/zQ57tc9hrVwkdSVBgxZ/yhE66orPwYL59adc6obosTIyUZBvRGW7dJifeaA07
	 1Fb/Q1v8sni88VNX2mZXrTUFdo8TGBp5kcy9dyrbZ7dyrLUknpBRxs85x6gKrsWySQ
	 lN6w2e0ephzxeUyGLNBLQA/m3bttvn+rHZ8rIOhwKrerYWqKW0d/1fdGpmSET/hmOj
	 k9y2zbvW5EJ8x0NCm7qHIB1mZsm9bEdvXDzFD/FyA65iGFhOYT0NNt7F4mDCDk0i1v
	 Gl03l+am1YBkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 074/451] io_uring/net: fix overflow check in io_recvmsg_mshot_prep()
Date: Sun, 24 Mar 2024 19:05:50 -0400
Message-ID: <20240324231207.1351418-75-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index b273914ed99f0..9fc0ffb0b6c12 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -524,10 +524,10 @@ static int io_recvmsg_mshot_prep(struct io_kiocb *req,
 
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


