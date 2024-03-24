Return-Path: <linux-kernel+bounces-115149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7666B888D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE4BB2C3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7817C303480;
	Mon, 25 Mar 2024 01:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUQd9zwo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DE328ECAE;
	Sun, 24 Mar 2024 23:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324167; cv=none; b=rxWEFAG0AazdQlSf9YDdSTG06LDdQNxs6O0XvteHKBunQell+jp8NCtQbL6s9NVJxXsDZJ5N4PkPaeRR7XBH59S7URpS9hbzZjhR8GwTQb7Ijnqut67xymQPw8cXYIImXvgsjPGZF6Yy2RTMzGmQBaesbee2oAOrPJ7ShJbC9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324167; c=relaxed/simple;
	bh=juqHyoMLptHEf1o3mC3pCq+KguM+yQrH8hvj9AyFJUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nx8qSCfzHz6DSmrk4wLOBz/3Tgct/IQJ0B+cfH9xJ1vnTlDmxIRnR8g57ED84AkHxk9Issi+6+db9yVEA5ZP1V8hgErbvvMB+edWsDH1Jbu4bwtMy1x+q+nVgeP3XtKLJ4EtmfJVUu9HCTazzdtA4JvYuMkxit7jTeuF3NuM7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUQd9zwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFF6C433F1;
	Sun, 24 Mar 2024 23:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324165;
	bh=juqHyoMLptHEf1o3mC3pCq+KguM+yQrH8hvj9AyFJUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUQd9zwoCIccnMdqcUsEDcrcCjyDgn9Qz5bi4h42OEdA8A2SezXCVT0oCpL0VB3+r
	 hIKMrCDVmZnvloIM0zulf1j8vrfPSHXq5hXz2/OUEIRp0dPWf9K08BAtKIqbQJ+Vsn
	 64zOcxHOuV3JPSo/JerzLiKQuHEia0ELJItfZarsnfcXv71L60LNfbJZjatYTTkSDh
	 xdJ2y2tgcL0bACua3lyqInUSi0vOFUOixhabBuV9hIz/eKYvoFdqw1OBlqABstvQJL
	 VPZKirF2Mu7qOWhiKQnuvC+yRBlmULFiuckgWNddM5RWP+JAhkS6/Ddi4Ibi3e49s6
	 Ya6Lrkdtmkdug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	Jeffrey E Altman <jaltman@auristor.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 159/183] afs: Revert "afs: Hide silly-rename files from userspace"
Date: Sun, 24 Mar 2024 19:46:12 -0400
Message-ID: <20240324234638.1355609-160-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 0aec3847d044273733285dcff90afda89ad461d2 ]

This reverts commit 57e9d49c54528c49b8bffe6d99d782ea051ea534.

This undoes the hiding of .__afsXXXX silly-rename files.  The problem with
hiding them is that rm can't then manually delete them.

This also reverts commit 5f7a07646655fb4108da527565dcdc80124b14c4 ("afs: Fix
endless loop in directory parsing") as that's a bugfix for the above.

Fixes: 57e9d49c5452 ("afs: Hide silly-rename files from userspace")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: https://lists.infradead.org/pipermail/linux-afs/2024-February/008102.html
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/3085695.1710328121@warthog.procyon.org.uk
Reviewed-by: Jeffrey E Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/dir.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 1ada9b9cb21ec..43f5b972fcead 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -421,16 +421,6 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
 			continue;
 		}
 
-		/* Don't expose silly rename entries to userspace. */
-		if (nlen > 6 &&
-		    dire->u.name[0] == '.' &&
-		    ctx->actor != afs_lookup_filldir &&
-		    ctx->actor != afs_lookup_one_filldir &&
-		    memcmp(dire->u.name, ".__afs", 6) == 0) {
-			ctx->pos = blkoff + next * sizeof(union afs_xdr_dirent);
-			continue;
-		}
-
 		/* found the next entry */
 		if (!dir_emit(ctx, dire->u.name, nlen,
 			      ntohl(dire->u.vnode),
-- 
2.43.0


