Return-Path: <linux-kernel+bounces-114409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5607888FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3451F2B210
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5484417555A;
	Sun, 24 Mar 2024 23:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUJUFkYu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892F11553AA;
	Sun, 24 Mar 2024 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321823; cv=none; b=Hc3BfAJb+0xI/SAFmJJJBcvaqeGxPFsEyKnq4zgPaVOdRNPsCgRP7CXoN+pq5qvuLOqefk0ZYZ1LcSQ1QDPtjVSAcicmfO4mHgQp5zOxe1VY8hYRbZO9Mm+y40s8iL7o+NoLIX4Z+5W+KjFY4f6R8yfC2dTHamjqKsbvgLQhrPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321823; c=relaxed/simple;
	bh=YX8Z8BJUtfENCL/jyq44+9MHVwDZARIZ54pob2CmVr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoZVvALyr+ohLUEwEGm4VfGuvTXtiBC8q3vOSGTUQZz2wGeld09oThK8n9tJwoZ3EHObeWyQ2EPOXnEFzyuPbgwZQgG2F13eewSn3zT+M328alHthIKn8uTMO7a2PzS3Y8MbFTojQh1MLIp0muF2PNPlPsSYoJGymXXU0VtFZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUJUFkYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B71C43394;
	Sun, 24 Mar 2024 23:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321822;
	bh=YX8Z8BJUtfENCL/jyq44+9MHVwDZARIZ54pob2CmVr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUJUFkYuoFVUO/ouIQqHpcJOcwrf5dcXkevCCmK3DUvgg74WWBXWIWU+92TZDvrwU
	 olTxgb8wP6KDdU4YlA7s1LsyepIEQYCZ72FfLIefDtuZ1k2sm+e5PBDrarKp4fWE5n
	 kUj5wqLOMoOeERwX69WhaE4g7lT9ZbSbDKWhAu3Q1pQRRzmIDZB4mutyt7Iovygvxb
	 dk1evO2N8Y/7/gg+naci9TRmTSYdWZI3eshLiJwQvZfQS1jjSCL/fUSJWwUItydaTF
	 R2qxptnNffmmrzavkYplspLy8ldtkjLX13PKQIOzV3+TazAevk9Mc1HZ60Gwxs0n/T
	 3MW+EtBNQsncA==
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
Subject: [PATCH 6.6 550/638] afs: Revert "afs: Hide silly-rename files from userspace"
Date: Sun, 24 Mar 2024 18:59:47 -0400
Message-ID: <20240324230116.1348576-551-sashal@kernel.org>
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
index e222fa68be847..5219182e52e1a 100644
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


