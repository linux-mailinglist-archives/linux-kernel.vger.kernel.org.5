Return-Path: <linux-kernel+bounces-113947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE38B888787
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7281C26551
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147C41EF7F1;
	Sun, 24 Mar 2024 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/+tJD4C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35F1EFE4B;
	Sun, 24 Mar 2024 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321052; cv=none; b=fCqk0OSVUPz8ekABfHX1LlUDb2Dl/vA4fYd+CgtuK6EYXe2Y/YMhS1hyI54FrL7/mMsdSl2BcqYZ2Xkmknukm4gjeYRcFoGhRe+Yv0d/noteiKFmmKHydOyjNHn6w2ROKEK5KXy1FlPQh9CpUnahmZkF3vMGgVFTqyyiN5DC/oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321052; c=relaxed/simple;
	bh=EKeavYQEZFDvRJNtVtMfsm98ElmzCnmdX0039Xcx5Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMlHqzwDUmgkxoe1f6OszOX0+6rR4sHctIwkuWn7dIFnV/yXw7/g+m889HeFfPz8qGm9can4/xHiWWB5veIJ+uKPH5Xc4cJz5XOIZXo23/1unaUdIZO4lQzlz4KPdHsL9of4p1+mSJHaK1f+3+j/IdbQEAkmsH4gm67TQAV2qyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/+tJD4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50885C433F1;
	Sun, 24 Mar 2024 22:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321051;
	bh=EKeavYQEZFDvRJNtVtMfsm98ElmzCnmdX0039Xcx5Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/+tJD4CJmSCms+JYlZSUWM+bgPZ+At36FnekqBs33XG+8sURgz4JEKwl77KF5JQW
	 84cBv/jFPybKWJozkOwZkUH1Bz7bh2zK0OkrTGlsb0SXmC2sPcQrSZcGtwc8ES2lwb
	 oEXkjtjkxBj7C5ZGZknoNIZ4O33XqHeEscbA/cWz38aGrMpuulFjIrAZiBv+2ByruS
	 3uZakUsJOx9vB1IH3cWvVzn+LNkWyQtgRrA59QGMxMa8f+hWZlySJbQwAUivNHYZAJ
	 4ufUsPKTfQNosC1XBE+5bOSKnquoSWVUJZKq6wRE4TGm1gU0D1xcv9TDkybNt5S/FG
	 Cr7L3TfbHNtlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.7 615/713] bcachefs: Fix BTREE_ITER_FILTER_SNAPSHOTS on inodes btree
Date: Sun, 24 Mar 2024 18:45:41 -0400
Message-ID: <20240324224720.1345309-616-sashal@kernel.org>
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

commit 204f45140faa0772d2ca1b3de96d1c0fb3db8e77 upstream.

If we're in FILTER_SNAPSHOTS mode and we start scanning a range of the
keyspace where no keys are visible in the current snapshot, we have a
problem - we'll scan for a very long time before scanning terminates.

Awhile back, this was fixed for most cases with peek_upto() (and
assertions that enforce that it's being used).

But the fix missed the fact that the inodes btree is different - every
key offset is in a different snapshot tree, not just the inode field.

Fixes:
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/bcachefs/btree_iter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/btree_iter.c b/fs/bcachefs/btree_iter.c
index da594e0067697..816ecc3375196 100644
--- a/fs/bcachefs/btree_iter.c
+++ b/fs/bcachefs/btree_iter.c
@@ -2094,7 +2094,9 @@ struct bkey_s_c bch2_btree_iter_peek_upto(struct btree_iter *iter, struct bpos e
 		 * isn't monotonically increasing before FILTER_SNAPSHOTS, and
 		 * that's what we check against in extents mode:
 		 */
-		if (k.k->p.inode > end.inode)
+		if (unlikely(!(iter->flags & BTREE_ITER_IS_EXTENTS)
+			     ? bkey_gt(k.k->p, end)
+			     : k.k->p.inode > end.inode))
 			goto end;
 
 		if (iter->update_path &&
-- 
2.43.0


