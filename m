Return-Path: <linux-kernel+bounces-115336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC42889ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36101F22D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F071E5874;
	Mon, 25 Mar 2024 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhhUi1aM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523F41D1D58;
	Sun, 24 Mar 2024 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320533; cv=none; b=FmjcuAa4WLeIRNrWfRAFVH3QfbuPmIxcmkYFxSBw3W7PJC1+Ht9PnFVDeEQj6FOtoEvtEvmy8tLB13+9XavQeLsWWuC5cLwYqVO0jiK6NXvnPeb0/0UOplqbVbRE2DpTpzS9qoK1BeI5DmYOeGv6xt2SMySFSY94psxZe32Xl1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320533; c=relaxed/simple;
	bh=76vkGyrV3hb3aWyw3PS3hSUigT9JbLaVi74F4EZkltQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0B/jWAokJ6zVUNNl4fFtNN6987Jh1zYVYndi3ExrePfPmyfGk7VOdxCOOYUac+kNqnx2oFOMEaoLzVH643ZBzqjVeHoVc8yoyc65pLkQjtv1vaQ/C8BlcrfR86Et5C232ILqf/AgPMGwYF+WIJSB/YcI/p5veBlX0+tSrdO2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhhUi1aM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC5CC43330;
	Sun, 24 Mar 2024 22:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320531;
	bh=76vkGyrV3hb3aWyw3PS3hSUigT9JbLaVi74F4EZkltQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhhUi1aMyE7ukx0oD9AQLBK26vBN1cxtCHxI2jm7b4YPq91TmcDIf3Z2Jur/s69iz
	 utO6U/71LXy+B6m+9ZA32wjh+eiNeOjaq7gs+lu39sAek3ewyCbp9cu3fU+aWSXTxy
	 9HB4zu7rlzh7zW0dV0xIqDmd8Lyh/C7WrBfTkoaCsQ5+1wfBkhItO/ok8qNYh1+ddn
	 9Dd65Nx8Ym2N3bE8UjRX9T44LXMq0Mm9FMzhddy/+WjwBS+lQWzOL6M9MxKKDzBH1T
	 62OKs4LVF+Hs56nml2634Sw9UolD6rwhyL7Icrz2Rbox1Y+aVhaxFbS9RUJsh2D03/
	 LJyHohE8OAXPg==
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
Subject: [PATCH 6.7 093/713] fs: Fix rw_hint validation
Date: Sun, 24 Mar 2024 18:36:59 -0400
Message-ID: <20240324224720.1345309-94-sashal@kernel.org>
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
index c80a6acad742f..3ff707bf2743a 100644
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


