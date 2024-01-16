Return-Path: <linux-kernel+bounces-26709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A34E82E571
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30B91F22FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7960A11713;
	Tue, 16 Jan 2024 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD0erL1X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C5D111B6;
	Tue, 16 Jan 2024 00:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A405C433F1;
	Tue, 16 Jan 2024 00:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364608;
	bh=TfGqz+9mNc8TLCDD7CjkBiTWvD3k4F9rV0DvkkJu5ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iD0erL1X/xmlViJ6FJuVPNEw7lnGQ0YsDrFglBa+CDBEir2d47pSXhLh2Q9BDJIMj
	 HUn4aLw8t0bUcfH+eeLuCRGBTqQ3JJ7DOuE9Y8LAKBTfgRnHKoLKBG8R+a0n3w/HZK
	 sfYue1DFXizkS4IX8ZeuCRZ7WlcBYFJ/NIbvnmngyP2zWqntUq5DO9TTXQWvnTG1n8
	 dZZMEQRK7Fwj1zmaG1R9r+r8ca95MhSN4tNkIKpL68AZYsKQip3HmTlWyOviJZyuov
	 lUQg1gwGiObM1fT/NV/FzT+jFCqwygmMl1rDC3hgcyXvj7QrL3gdkTmDPCOYktxsnw
	 SD6eVj3/Rkm8Q==
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
	yogi.kernel@gmail.com,
	code@siddh.me,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.7 06/19] jfs: fix shift-out-of-bounds in dbJoin
Date: Mon, 15 Jan 2024 19:22:42 -0500
Message-ID: <20240116002311.214705-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002311.214705-1-sashal@kernel.org>
References: <20240116002311.214705-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index cb3cda1390ad..8eec84c651bf 100644
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


