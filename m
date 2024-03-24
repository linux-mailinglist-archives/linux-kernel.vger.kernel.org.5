Return-Path: <linux-kernel+bounces-112928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B718887FD2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D810D1F210B2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580BC46B91;
	Sun, 24 Mar 2024 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuEoHIDY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907CD7172B;
	Sun, 24 Mar 2024 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319740; cv=none; b=qtjTdWF7+Rzz/LSHkvGSXzPpgy2qpBP6shg6wOfLEtQtaxlevTjy8bYmPPd6hfaXbO+1TYU/+5sSpuRUuZk1rNMp7rbw3d49FU8eRM/PsSpqT6QdH9vH7doCTV6O1f9kYZGbaVLefrzzy/UBsBJo9A5IvIz9e8d+ZVigPGWeRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319740; c=relaxed/simple;
	bh=+mRypTj2AN+uFrmsMst73xXavbGCXAj069qIzrAjzZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqm0uwJ4YiwHDVJOzWiPtmaM4bApbk1tJHN7tzRBWU9ftmBA/mlwEVINIEaV5y5Ulq/wgBgjaP2P4kDcNpPqU/ZAamxsd9IdJy3fjFqKrO3ebtZ0SCmAMt8Qfn08OAFn7T9VhBprokill125pHghTcjY/MRz49gZ1uSG78nKZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuEoHIDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66339C43399;
	Sun, 24 Mar 2024 22:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319740;
	bh=+mRypTj2AN+uFrmsMst73xXavbGCXAj069qIzrAjzZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fuEoHIDYd2Et/hDtJ+r072Bm7rwYTo+R/HhliPb+cUeIqtXCx9/iXMkuOhwR0klEL
	 7Q1OzTI/4SLjKAdEaLTHq075nh94Vr/s3SRPAxPYqkK6ES1Xg/5HKxn2g2juMEzWfM
	 4+QSH0ZuO+7YI1Vfy3Qc6ePZWtbnws972UKVARKY6gSIoaAh3+yG6IAyGy5K8dzCbe
	 AL++iwPTgn/Me7uMHLNPbRz126NpClBzrOoZEHcibRPSvb99NUJK74bwOavMCZ9D9O
	 ObnAOMRNWpI4cg6QrzhrMtaFySmQ2mlxy5rQZ0GouF7xnHEbRGicG1etF69mcMlmBr
	 C8qDfR8EPiv2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 041/715] io_uring/net: fix overflow check in io_recvmsg_mshot_prep()
Date: Sun, 24 Mar 2024 18:23:40 -0400
Message-ID: <20240324223455.1342824-42-sashal@kernel.org>
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


