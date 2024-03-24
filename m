Return-Path: <linux-kernel+bounces-113946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE27888785
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDD51C26623
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435CA2197D6;
	Sun, 24 Mar 2024 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXJKB/ND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589A71EFE45;
	Sun, 24 Mar 2024 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321051; cv=none; b=OvrPmN/H1N6NUCrdVKcElvhWwqPrDLMJtbTGA32jhRKBrUFRSIyk0P5kFI+iG7/DguQXpEl+1X94hbEKyp4vv2qwIMM2oOUc2F1yzl+ZEXtVFRcfSsRUjR+4f+SUOzbdUeWtkeECr4Lx5tQ6QDBqFzdyYo535t5eiSi4xhtd1BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321051; c=relaxed/simple;
	bh=OI0MhnP9tdk+ah8gS0aeDAoyALnz4x1bX8FCZo03PYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcfUw9bYM20j/3DH/xJe9+IHrtGS51/3mZeTqKdleixjXkwyNpW/L8jepLn9zqhWenc1+v4jiXUyKpUpYQbXxRHHdyWCCi/p8pEDAiH061Bq8dK45SfBkXrAoOXEg9gXCq0XAhTdGYljXZZ+xkFKsG6wH5Ux6frRdaB7NKzqzpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXJKB/ND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD86AC433C7;
	Sun, 24 Mar 2024 22:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321050;
	bh=OI0MhnP9tdk+ah8gS0aeDAoyALnz4x1bX8FCZo03PYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gXJKB/ND6JjMggNbvPK7t/B90N+4YnKbmzz4+lstB67pE3QkQBdkE6WWPjIORKnQQ
	 pbbF5hMEk77obZ+lsD32k3zUGLbypLn47xT7fPaWUyEURU1AZ8d9RkOz8tfpDLrpp2
	 IgbltoR+xaalKak7STIglNVysfd69Yr5+2zuH0geU3z6Eimy+C37yHgYzm19JfEpRK
	 mWb9cZIhTb8qlIb0LlAD61IRWSxKIAu5BILx/kI7DaDSu4tKE6VxufGVabxFCceJb7
	 G5tyb99ar2xNM1L8NKGbdyHZkv753Zx+jjQZ5Pjnk9J9GRio8Wjw47I783QXhiwo1+
	 uKzywNZX/c/tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.7 613/713] bcachefs: check for failure to downgrade
Date: Sun, 24 Mar 2024 18:45:39 -0400
Message-ID: <20240324224720.1345309-614-sashal@kernel.org>
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

From: Kent Overstreet <kent.overstreet@linux.dev>

commit 447c1c01051251853e851bd77f26546488cbc7b7 upstream.

With the upcoming member seq patch, it's now critical that we don't ever
write to a superblock that hasn't been version downgraded - failure to
update member seq fields will cause split brain detection to fire
erroniously.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/bcachefs/errcode.h  |  1 +
 fs/bcachefs/super-io.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/bcachefs/errcode.h b/fs/bcachefs/errcode.h
index 9ce29681eec96..ac90faccdcb22 100644
--- a/fs/bcachefs/errcode.h
+++ b/fs/bcachefs/errcode.h
@@ -224,6 +224,7 @@
 	x(BCH_ERR_invalid,		invalid_bkey)				\
 	x(BCH_ERR_operation_blocked,    nocow_lock_blocked)			\
 	x(EIO,				btree_node_read_err)			\
+	x(EIO,				sb_not_downgraded)			\
 	x(BCH_ERR_btree_node_read_err,	btree_node_read_err_fixable)		\
 	x(BCH_ERR_btree_node_read_err,	btree_node_read_err_want_retry)		\
 	x(BCH_ERR_btree_node_read_err,	btree_node_read_err_must_retry)		\
diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index 4c98d8cc2a797..6405cc1d651fd 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -966,6 +966,18 @@ int bch2_write_super(struct bch_fs *c)
 	if (!BCH_SB_INITIALIZED(c->disk_sb.sb))
 		goto out;
 
+	if (le16_to_cpu(c->disk_sb.sb->version) > bcachefs_metadata_version_current) {
+		struct printbuf buf = PRINTBUF;
+		prt_printf(&buf, "attempting to write superblock that wasn't version downgraded (");
+		bch2_version_to_text(&buf, le16_to_cpu(c->disk_sb.sb->version));
+		prt_str(&buf, " > ");
+		bch2_version_to_text(&buf, bcachefs_metadata_version_current);
+		prt_str(&buf, ")");
+		bch2_fs_fatal_error(c, "%s", buf.buf);
+		printbuf_exit(&buf);
+		return -BCH_ERR_sb_not_downgraded;
+	}
+
 	for_each_online_member(ca, c, i) {
 		__set_bit(ca->dev_idx, sb_written.d);
 		ca->sb_write_error = 0;
-- 
2.43.0


