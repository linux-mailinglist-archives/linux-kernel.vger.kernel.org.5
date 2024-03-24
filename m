Return-Path: <linux-kernel+bounces-113638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BEF888E33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340961C2AEB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1249A82D61;
	Sun, 24 Mar 2024 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5oqHkhH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241AC1D4C4F;
	Sun, 24 Mar 2024 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320559; cv=none; b=slkts+7j9JAFXzq0ZMDsCL3ZrnR4DQzlTWnaAcxN+BW0jjomGIZqRWiEMhh0c0VBqvZFmhjVy6OX/6lDZsJ4dckSpH7uI5SpInAZYxZSn9rukVLbWsVLglYO5UNcML8HwIpo9YJ2H+aSoetUGaoM9R39fMrhMD+SWJ3yE54TXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320559; c=relaxed/simple;
	bh=+mRypTj2AN+uFrmsMst73xXavbGCXAj069qIzrAjzZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPKgdKQ9OB1jXxDbtTf+7VMGn6bPTo1YhV/yv35utsjEUZvfxiX9eFVgxITd9IK3iujO1kLmnM+/ehj+csqbmjcN0a+mLc+TEjdvi8toXUNyfOjVE0DhtGX0zlESyA1B4v0uZOvv+ku6J5YAC5TkKABQERSzEwVbvIC8n16tL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5oqHkhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A8BC43399;
	Sun, 24 Mar 2024 22:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320558;
	bh=+mRypTj2AN+uFrmsMst73xXavbGCXAj069qIzrAjzZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5oqHkhHzqpEzalmSV2L/2/UrEEHfrVzgUCMrD214a7xumiqKkbpAkxzOcPQHlpIv
	 kJx12VoiC/m0/qMD+Cgl5vQSJ6Wvtkfa+1zqj3abjuL0AIG5kXLSj6elMcuqhx5Xns
	 /NwpCBtfsa5Kzfyik5HI/+orDCsauA50/WMSOoMBwrcdtCLvXXefMYsMC5KvtprmAD
	 BoCWF4o2Bw/qFnzHbHNJallWGyUH8tppEImA6r/cC9LHvhwc+AXdPfPjh79JA3DdlC
	 wvOIQ9sUZ0V7kgpXDq1MBqJqen9l/N4ru6a8mGSSEjPgy/tqNlk2E5s/AmcaJVZ1UW
	 Ww7v7xJIa92cA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 119/713] io_uring/net: fix overflow check in io_recvmsg_mshot_prep()
Date: Sun, 24 Mar 2024 18:37:25 -0400
Message-ID: <20240324224720.1345309-120-sashal@kernel.org>
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


