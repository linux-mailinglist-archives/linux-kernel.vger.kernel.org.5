Return-Path: <linux-kernel+bounces-113498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3BB8884CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5C11C22361
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014A973175;
	Sun, 24 Mar 2024 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQIv4Yvu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDEF13D529;
	Sun, 24 Mar 2024 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320300; cv=none; b=CwNG0H6TmiDERxPN8HzF8dzJFmpK0LcubJbqkTHcQuYtN94BCZzIMxJmFg6ZZ5PW4ea3X0ZeTElbv+v60vCgT9RCspmgk0tfAT+Mv/fTUnPPCJtiiVt46Ntr+i39099K7C25NldQpLmtFPQ1PPjeFuONzqLy6l5fzQNKZjDn2+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320300; c=relaxed/simple;
	bh=fRJ1NF/0Po2lrONLXrVy0VfghTonH8e7OtvZdiYNLv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWj7rhqNaX9Q7abljw8/mlQAvhi+AoJqp57ryg4mSibVPpUFsq5wjbxVSuHM4Sp68hT5ZrGf4dOx6osr2KsDOAKWFawCLLVyLij533wqJolpWKVoHGh3u7nF0RyhptIzrEIvwPJwJgs/iA95Ixut2KqCFSUo5NipiDC2K4XgBM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQIv4Yvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33901C43394;
	Sun, 24 Mar 2024 22:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320299;
	bh=fRJ1NF/0Po2lrONLXrVy0VfghTonH8e7OtvZdiYNLv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SQIv4Yvuoog8DWovvBZ8/qr4wqXpsrZ8OcJjC/WZyB5ivfx07qN4aWK1d9SVG0v/H
	 +ZSfDO7yuuBbaz5GAoWghuTZHSXKEFnbBLX2k4JY07z+z2HS7ZfMVq+DvzVlkMj3Bn
	 ISenTu+lZfUbLROchT0Ef75hBKfllSpqNaC5vUfS6jLvVFivbWgIUcbBMd+o76pkPm
	 rt1I9h6XuTU9+zaP8CcmFcptN0WpJVfBXP1nLeOy0tFkHCBpFKeUxqShAkorVXht2c
	 B5FmAxo/YSolGN8jpq7K9aZVHcCUM1ZvL7ngtKMQpLxfd0VaUWX5xH3MhYhz8ILUg8
	 qAvDWB9sfKn8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 607/715] io_uring/net: correct the type of variable
Date: Sun, 24 Mar 2024 18:33:06 -0400
Message-ID: <20240324223455.1342824-608-sashal@kernel.org>
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
index 058e04ea68c04..4aaeada03f1e7 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -536,7 +536,7 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 
 static int io_recvmsg_mshot_prep(struct io_kiocb *req,
 				 struct io_async_msghdr *iomsg,
-				 size_t namelen, size_t controllen)
+				 int namelen, size_t controllen)
 {
 	if ((req->flags & (REQ_F_APOLL_MULTISHOT|REQ_F_BUFFER_SELECT)) ==
 			  (REQ_F_APOLL_MULTISHOT|REQ_F_BUFFER_SELECT)) {
-- 
2.43.0


