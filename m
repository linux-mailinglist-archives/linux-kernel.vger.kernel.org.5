Return-Path: <linux-kernel+bounces-116208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B00889D89
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A221F36ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89714291B91;
	Mon, 25 Mar 2024 03:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnEPUnxW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4372853D5;
	Sun, 24 Mar 2024 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323825; cv=none; b=tkVVlwvOhJrMnzv8UsHiq3LHCoeFfKqq4LsL/ijvQ0hDQ0ILtyS2IeXM1eE5I1oQ42AvlUiFrek0Kw5cfBmNHGd2sippjH4hqYViDJV0DKXo0A4gT8i/T4F4zlOER8qduNWpefGoZRSGUbaXiqU58urZ9325UweQRxOR8e5Mang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323825; c=relaxed/simple;
	bh=FsAsu3Rw+37tte4cZ220/4DO2pAOdj6r1oAecyz+6cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=np6suZsfFOSJxqsGyN6WKjiPqWQP69goGc18XQ+bHsIU7rF1Q8U5cgig1MyT3FLKzu7d+NqdwzPlJnmrfV3O/klR40F0TVTtfZ6xk8k6Hoe1QuSu2GDcLEsPj0F7yU9oWFQkOxM8yKyurPv4un1ZPLpUs1DFc69NzkYuscIFgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnEPUnxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECF2C43394;
	Sun, 24 Mar 2024 23:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323824;
	bh=FsAsu3Rw+37tte4cZ220/4DO2pAOdj6r1oAecyz+6cA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BnEPUnxWpGMoHlEjuHXNchEqgDtqcJp9c6DBl2Gj9KD/LqmoA6zZ5AjIJ0WrmInQ/
	 z9Fc/7YK610BEhHVGueScvySyEzSv6MSY8smiig0Xs73UEMEFoht87T6eo2sIiKC8/
	 IrCjiBdyLwIWBjwR2ZKMUcvyLa1pBAhi4VWK82kR9utaM9HTY7Bif8dkMdEvKV3LAo
	 fd3vkE9pA4ltjDQX7chnhteFxVNkwn+G/6StcvXWdkSgxxsZd1zAvGOzSDRgQ5/HX1
	 S1irvyr5lsQj5H1+/O/XbvKgZ4VNBrYsbvQ0YKcGGGWjq6qYxOrIRKme1kx+om2/E5
	 Ngla5p8Xgk0Kw==
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
Subject: [PATCH 5.10 203/238] afs: Revert "afs: Hide silly-rename files from userspace"
Date: Sun, 24 Mar 2024 19:39:51 -0400
Message-ID: <20240324234027.1354210-204-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 88f0e719c6ac0..a59d6293a32b2 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -418,16 +418,6 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
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


