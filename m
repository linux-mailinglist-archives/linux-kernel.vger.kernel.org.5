Return-Path: <linux-kernel+bounces-114066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E76C5888834
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A82287AAE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D172E14D45B;
	Sun, 24 Mar 2024 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deCH9EC8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE901FEC4C;
	Sun, 24 Mar 2024 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321356; cv=none; b=e5+w6s+oox1DL5EvOdxn+EnByQh+Jv5UK3CC6nzJhjTBxM5hb9JngiXJDxDAhTsgr34/VdfBBoMIwXss0y1P3DJ2I9N+iZTFt+ThJa0OFF4PlLW6l6arZUYY+E8BawiRrbsVjbin5PFkPjZSiRxWXtUniLT8vH/HapniG7pRLH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321356; c=relaxed/simple;
	bh=onkvyguq4HFdPtigEVPnPbofRG4g4WsxNdnGYH6yWSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhiUSztAHFXcbBhwBMdBmHq6cSs5cujUMOTFwfc+IbxcF3IoTV/EJD8vmE40byvN63QOn0pjnGhjbONX9YNI+CGfnIZ81nodRHSuLbCIv1BQG3W5caMVFXLdnQDmQP/7yhEYgrmxm/9InxSWD/gv4cleQbSDFA440g9sby4gvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deCH9EC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2407C433A6;
	Sun, 24 Mar 2024 23:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321354;
	bh=onkvyguq4HFdPtigEVPnPbofRG4g4WsxNdnGYH6yWSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=deCH9EC8/2r3bZH56nxV6fBCbWeqtLX2Lk6IFsUK5IECz6PtvYwexwsbnOFfFAVcT
	 FzWNlVqg20Gko6PQe1cI0dIETzlhuWTvYCnaMqPA+lO2gyS5/GFHYZv6jXBRRCRs2r
	 s+z5M32zTwb8LmYR7QrCvPoJl/RWI5sVA7ZFxn36XwDUKkzAGYoqchmOSkHlQQQ+WT
	 MzjVAeTk/LX9A+VUj9zw8yXDl3DHvtjdGVjgYP4sYIfVnYg++4ij9bFS0izncJ4nHh
	 /TKtk2nUWbiCUcly/dOm1oIZzB5lv+/8EFMR+ztU2nJZ5R/D2ES6YujRP/L0LekFgn
	 jrmIaPJzcpMoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 079/638] fs: Fix rw_hint validation
Date: Sun, 24 Mar 2024 18:51:56 -0400
Message-ID: <20240324230116.1348576-80-sashal@kernel.org>
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

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit ec16b147a55bfa14e858234eb7b1a7c8e7cd5021 ]

Reject values that are valid rw_hints after truncation but not before
truncation by passing an untruncated value to rw_hint_valid().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 5657cb0797c4 ("fs/fcntl: use copy_to/from_user() for u64 types")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20240202203926.2478590-2-bvanassche@acm.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fcntl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index e871009f6c889..9f606714d081b 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -268,7 +268,7 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 }
 #endif
 
-static bool rw_hint_valid(enum rw_hint hint)
+static bool rw_hint_valid(u64 hint)
 {
 	switch (hint) {
 	case RWH_WRITE_LIFE_NOT_SET:
@@ -288,19 +288,17 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 {
 	struct inode *inode = file_inode(file);
 	u64 __user *argp = (u64 __user *)arg;
-	enum rw_hint hint;
-	u64 h;
+	u64 hint;
 
 	switch (cmd) {
 	case F_GET_RW_HINT:
-		h = inode->i_write_hint;
-		if (copy_to_user(argp, &h, sizeof(*argp)))
+		hint = inode->i_write_hint;
+		if (copy_to_user(argp, &hint, sizeof(*argp)))
 			return -EFAULT;
 		return 0;
 	case F_SET_RW_HINT:
-		if (copy_from_user(&h, argp, sizeof(h)))
+		if (copy_from_user(&hint, argp, sizeof(hint)))
 			return -EFAULT;
-		hint = (enum rw_hint) h;
 		if (!rw_hint_valid(hint))
 			return -EINVAL;
 
-- 
2.43.0


