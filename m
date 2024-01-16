Return-Path: <linux-kernel+bounces-26747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AC482E5CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119B41F262FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5218328BA;
	Tue, 16 Jan 2024 00:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYILsqZG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3842328D5;
	Tue, 16 Jan 2024 00:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD7AC433F1;
	Tue, 16 Jan 2024 00:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364730;
	bh=ohUlZKSVhQsXwfAbF+M6xgIn4IIGKmrGp4BYKOIxanA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FYILsqZG7OGx8GkZ0tFYymCTMlz42tTTyMCVg6GhXvEcbvx5YagH81ezHKDM6o+S7
	 UOeUPtXXe4UJ0tcBRf94QM8iWHMA5WpPJz0032//3mEXW7HLrvWWWTdBoXY8in+Ahs
	 gwC9GQyH32X3+oVZnOFbaVa+o4PRwy+NOTFP1Q77oJn80PiWFWqoY0ZFdUnoJlE1zn
	 QRXVsyHltO/2ttP02Fdqv7RIXoSkPGKXHg5Og1MiAPi6Q6KBe3dcv68ydgK22YjV8s
	 lwCN7TF8rWaFGbh2+7bTMOnyPHfhHqunUIP0kMZC51Efh/7hFmTSU0KxsgSYDAoISp
	 IzsIGIQO77mGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manas Ghandat <ghandatmanas@gmail.com>,
	syzbot+411debe54d318eaed386@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	juntong.deng@outlook.com,
	yogi.kernel@gmail.com,
	wonguk.lee1023@gmail.com,
	code@siddh.me,
	andrew.kanner@gmail.com,
	osmtendev@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 06/14] jfs: fix shift-out-of-bounds in dbJoin
Date: Mon, 15 Jan 2024 19:24:48 -0500
Message-ID: <20240116002512.215607-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002512.215607-1-sashal@kernel.org>
References: <20240116002512.215607-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Manas Ghandat <ghandatmanas@gmail.com>

[ Upstream commit cca974daeb6c43ea971f8ceff5a7080d7d49ee30 ]

Currently while joining the leaf in a buddy system there is shift out
of bound error in calculation of BUDSIZE. Added the required check
to the BUDSIZE and fixed the documentation as well.

Reported-by: syzbot+411debe54d318eaed386@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=411debe54d318eaed386
Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 4462274e325a..8d064c9e9605 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2763,7 +2763,9 @@ static int dbBackSplit(dmtree_t *tp, int leafno, bool is_ctl)
  *	leafno	- the number of the leaf to be updated.
  *	newval	- the new value for the leaf.
  *
- * RETURN VALUES: none
+ * RETURN VALUES:
+ *  0		- success
+ *	-EIO	- i/o error
  */
 static int dbJoin(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 {
@@ -2790,6 +2792,10 @@ static int dbJoin(dmtree_t *tp, int leafno, int newval, bool is_ctl)
 		 * get the buddy size (number of words covered) of
 		 * the new value.
 		 */
+
+		if ((newval - tp->dmt_budmin) > BUDMIN)
+			return -EIO;
+
 		budsz = BUDSIZE(newval, tp->dmt_budmin);
 
 		/* try to join.
-- 
2.43.0


