Return-Path: <linux-kernel+bounces-113943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6634888FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5463DB31CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD0D13F427;
	Sun, 24 Mar 2024 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYaVSnMz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB77B1EFE2C;
	Sun, 24 Mar 2024 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321046; cv=none; b=lqVhj/c9mS0vqAuRG/EZ2vFoCqnQCjZADLqClJqGHUslrSOFvz78PzUs5eJ9UtSN1TxAYDgmCbtY2poQsFedMNJEooUPnx6bBfhurt8ufXOxmIMaECzrYJp9clcYe0yKBaa9DcSB5oHIlCMua1inySCEgBjNd6xsUlQmeeBevS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321046; c=relaxed/simple;
	bh=BroqL4wt3XGrSBh3ZgxA62aqbr1qN7CVe7ICPyVqjDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=je7ApIcHzj1da4x3RLL11TgQpUeEI6Zo+5kTclervQVxqLfD3KI28fuKZ4GrcYU4pfR+YMQGIIb4PD9BK8wenYDOS4r0aN/REZJCWt7Qe5Hy9ZEPhd0rcZw635CTDr84Sk7UplyRjLVC57bECI7+rF8MDdwN48aZL2GrpjsY8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYaVSnMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C3FC433C7;
	Sun, 24 Mar 2024 22:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321045;
	bh=BroqL4wt3XGrSBh3ZgxA62aqbr1qN7CVe7ICPyVqjDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lYaVSnMzF7a/ygFtB8iBQEzYC0+ClpX0nkfofNkLNTgq9BzocxK6ySWXLgxMOPa9W
	 7yI8ud6bw531YmGroGVjqVUQvWicl1EBhmcBmLmHe6VfLHkTymiBn/fVmJHuxJs0Yj
	 tzxR5hk7bKYZuCAuchocQpCGqOH/73oNQIcwd/uU5CA9kKkjb6ecOS5XGuEwyW2NmV
	 q3yqrmJ5cmpLissWMVruz7lAo/R5Fn4TJsbTO9EIr72EU2FKxRYr9FEv8bmU6FNmxz
	 SVJ5ZdyJW1uUDMWiG/5cZBfr0wd9y3lESA2sE0ZWg5B8xWd5978JCXnD4qrAMifFt1
	 VkHNLmjuugtCQ==
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
Subject: [PATCH 6.7 608/713] afs: Revert "afs: Hide silly-rename files from userspace"
Date: Sun, 24 Mar 2024 18:45:34 -0400
Message-ID: <20240324224720.1345309-609-sashal@kernel.org>
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
index c097da6e9c5b2..7761f25a77f39 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -474,16 +474,6 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
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


