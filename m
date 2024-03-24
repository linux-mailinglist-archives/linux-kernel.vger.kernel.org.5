Return-Path: <linux-kernel+bounces-114656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158CF888B94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C493528E5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8E62ADE05;
	Sun, 24 Mar 2024 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDALPIkP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD46123658D;
	Sun, 24 Mar 2024 23:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322301; cv=none; b=VRN1aI4uuyW4mbKOgWKPPlFZ0L5244zkqvV9ZUs5JXtmnSwPISmxpJsJk4OtRxb6uZFYhrxtokoqtkBmKw2dUGS/1O/DbOTAZ3nyr3gvI/ail5tgr00C4iad+aJ4VXfDSFznykQ+XUmsrzG2MmyeE8cS81jVuHi7wIEsL/IOxos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322301; c=relaxed/simple;
	bh=9yBopZLIM8OSzLqA9Go3tW6gVjKypeyx/Oz0X+ZwDLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3pIzh2JVZQcqJKVhhAKnb0NK3scUNaYfQ/jK8yyvwexJIZSSlnYng9rrEDY62nxc1sHv82rU3f4IbVrP/6HGxCFTm2kjzl4VO/qP79bSMQYHKAsoGnuuSLekINj/0ivo7LfBOF+Y1COQ5Qj+fU7GMuFT2p+AYal4SUB4DXncxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDALPIkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3B0C43399;
	Sun, 24 Mar 2024 23:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322301;
	bh=9yBopZLIM8OSzLqA9Go3tW6gVjKypeyx/Oz0X+ZwDLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rDALPIkP9f294eutb+y1fb0FR8PnGOpn1q0TL71jzxbxmVQDkHFODcC2TFI59zpDE
	 0uT7ZapB22EvoI1owXmVB18dLT/Qgiz/2D4CpF1epBlE8LUWM//swUqEYhi8Q6xV6N
	 qTPJpUePl+ElkNxTKRdb0bOssk1ec9dlkwfs+hZ+o97vk/hiQW+nNz5MTBA7ldNGcH
	 Aqdyeq4Ga+z5Y9lJTDEEkKfzng37q1Wzhdv46/Z4fksr3P+qBOT84B85QzZ/XNW/rk
	 4qYitvokSN9CTHYSel4kdZ9FYlstqxCDmtzHpWd34jGUvzR36f9ZdQqFqHYmHUrkMf
	 fEy7riNocLRbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 384/451] io_uring/net: correct the type of variable
Date: Sun, 24 Mar 2024 19:11:00 -0400
Message-ID: <20240324231207.1351418-385-sashal@kernel.org>
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

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

[ Upstream commit 86bcacc957fc2d0403aa0e652757eec59a5fd7ca ]

The namelen is of type int. It shouldn't be made size_t which is
unsigned. The signed number is needed for error checking before use.

Fixes: c55978024d12 ("io_uring/net: move receive multishot out of the generic msghdr path")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/r/20240301144349.2807544-1-usama.anjum@collabora.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 9fc0ffb0b6c12..0d4ee3d738fbf 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -516,7 +516,7 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 
 static int io_recvmsg_mshot_prep(struct io_kiocb *req,
 				 struct io_async_msghdr *iomsg,
-				 size_t namelen, size_t controllen)
+				 int namelen, size_t controllen)
 {
 	if ((req->flags & (REQ_F_APOLL_MULTISHOT|REQ_F_BUFFER_SELECT)) ==
 			  (REQ_F_APOLL_MULTISHOT|REQ_F_BUFFER_SELECT)) {
-- 
2.43.0


