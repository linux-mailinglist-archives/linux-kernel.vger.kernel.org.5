Return-Path: <linux-kernel+bounces-115548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E9488A016
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EF17B370C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C484D24AE8C;
	Mon, 25 Mar 2024 02:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2VGmOR/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F191EFE38;
	Sun, 24 Mar 2024 22:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321048; cv=none; b=AFH+U1Jp6pdCOStVVpz2z28z9AAEW0ub1OX9DKaqWRzQzqEs3IAmsdQllGiJBZV+KM0+8OEJlksRRWCLohkvm3FSdhRxXbxt0Dg2jhHZ2uSrNvpGgq2qSu8sicBL7IBphrwSHdNGWIF/4D/3uwtsaNHR1cldmMrZ3PD7m3gxxa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321048; c=relaxed/simple;
	bh=fRJ1NF/0Po2lrONLXrVy0VfghTonH8e7OtvZdiYNLv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPlAxRbLO+bNs+hcLNg9U7MpgDRCYetDUfZUTZWd9fpCsLY3qixOnjmg4kj6eFleCd9gEElccZVB8nR9uPZrZ1uAupHW1LEQDtk97qCXpiyKXGw9J9nixzn3PykHBoRUQUxNzF5TUfq69xaUC361c1RTQshMmsnmPGakz/D4gJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2VGmOR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04D5C43390;
	Sun, 24 Mar 2024 22:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321047;
	bh=fRJ1NF/0Po2lrONLXrVy0VfghTonH8e7OtvZdiYNLv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2VGmOR/Qr+MnoRHcfPLW+YL9DGCidgoLeBSCo8pRdzrFkDtmXqWy9dGeSRFd9Oif
	 OAAKeUyzi42tECGJvIYMj3xkyFPV5aGydKIZFD/KZdLwPbf5G4PlIc9zLp0GggABSl
	 tjycVTKFHy3vLdpzDJUm1SJgLFpNfJ/A5fccgZuaslvm/ebU0LtD94yAF5IkcebazC
	 61tBPJ+GDs2/AzwK1EvlJpPfik11FLgRp/YN02QQq2J1petxtxdR9kYoTGiSKeLQEF
	 +xoT5BvzUwwWM3D21Oma7ktEQLvYR2VQ4S0HQisHM8hOA5OiF4Sz0Z5BYnO9JmHYcN
	 LSroyV9ORMRog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 610/713] io_uring/net: correct the type of variable
Date: Sun, 24 Mar 2024 18:45:36 -0400
Message-ID: <20240324224720.1345309-611-sashal@kernel.org>
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


