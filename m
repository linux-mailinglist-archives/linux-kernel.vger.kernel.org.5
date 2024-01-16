Return-Path: <linux-kernel+bounces-26774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAA582E60D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E4D1F22336
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51E757872;
	Tue, 16 Jan 2024 00:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+rMC4Wb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0257864;
	Tue, 16 Jan 2024 00:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCCFC433F1;
	Tue, 16 Jan 2024 00:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364826;
	bh=b80f0fsZfvrwsPL/+xFih/b958KCU5SyV61Nsicuec4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+rMC4WbnhMJYUuwBsJZEK/BmjaFYSv9pht78pNf1kv2N524iLtP+wlR8lITura6N
	 e+gCUgxv8R56jIDqXRZTH/pcCrU/EgFFv+oDpMHjeYbwvD2mVjYdEH14eFql18g5QP
	 XayI5ztpuudMRlTZoJmcfH1kmbyiTnY7PvPK6DEXzH++HFzAl9Sv33nFgUAOlXk10D
	 5+c2v0PQOUDiGKbVzT8TjVZZqheG25o3ss+/mbsx+UelYkkNHsRPty/4QdQJE54Vu6
	 llzCHklTXObgkFrW8EUexgN2icOONrmXjKS07ht+tVHl1LHyXozKaWxeJTWjziUanW
	 4IS0ZbcJSNfpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manas Ghandat <ghandatmanas@gmail.com>,
	syzbot+411debe54d318eaed386@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	juntong.deng@outlook.com,
	wonguk.lee1023@gmail.com,
	andrew.kanner@gmail.com,
	yogi.kernel@gmail.com,
	code@siddh.me,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.10 06/12] jfs: fix shift-out-of-bounds in dbJoin
Date: Mon, 15 Jan 2024 19:26:31 -0500
Message-ID: <20240116002649.216260-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002649.216260-1-sashal@kernel.org>
References: <20240116002649.216260-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 9b6849b9bfdb..d6fca059e688 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2827,7 +2827,9 @@ static int dbBackSplit(dmtree_t *tp, int leafno, bool is_ctl)
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
@@ -2854,6 +2856,10 @@ static int dbJoin(dmtree_t *tp, int leafno, int newval, bool is_ctl)
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


