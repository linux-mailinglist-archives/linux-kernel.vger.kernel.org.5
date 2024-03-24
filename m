Return-Path: <linux-kernel+bounces-114653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6378888BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5077CB2C3A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C63E2ACB4B;
	Sun, 24 Mar 2024 23:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNYbjs4P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C701FEC6B;
	Sun, 24 Mar 2024 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322301; cv=none; b=ozYtNdHmIaqE3mFx32tYbukSk9owP/oC0zHmKSCVB4pXBkG5nO3Q3kBQ0gfzA2XK+2ijlVXsXDoa11CSvWOVXiDZtsWbd/kIs6hHmhVe40FdCVRzY/r0L6BJZRxz6t7oM8upOw/jkGaa4IHwICml1FUXD75SKpCUIDtE9r5OQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322301; c=relaxed/simple;
	bh=4WG5syGSUSvWMzXjHZoH1055UV3cQo4/qWbF4cAssk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8IFvPNY5xiglKNH9CVhUHCW7lNZOhkF3lBMpRH2SZt3//Ext+izqSsyfKl1/mm/AsN+YnvzqJuKjnepkT3Gc+y6feoeItAYQ7tFCWxPHOTUTkSCefx2WO+uRXydutwJT8fkVsSjeswyOdedcU+lYAKsPvfTRML/tXVzdV3K0rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNYbjs4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA19C43394;
	Sun, 24 Mar 2024 23:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322299;
	bh=4WG5syGSUSvWMzXjHZoH1055UV3cQo4/qWbF4cAssk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fNYbjs4Ps23E0RikUf5fVgBxQYPOwaXkP0fuH6Hi3wSWAFdv9JVFQwHCT/rMGv6f9
	 HJt6MFimCgL6Z4TrqH+CZ/z4gLOK4BueCX4a2MvMlS0Fqlo8wd/2wrXCJbHOQkS6LS
	 aOHSuoedV5uXnF/U45NxYAqL/jBKImRp46vaNLgxPQKPLjS1vJLFWMfPXfklm5jMFx
	 56Pi0NBWGYhob9b71cMy2lBpv8zNKxasXs2G0Mw1hPWlUwfUpIlcE7PLPPOr4MprlF
	 1+p7p63jiqYBkszaxONu+rs21EYx1uv1wpmc5mapw4879696AxYZcFlXV7fqGONiGd
	 XwZEar0onvxWg==
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
Subject: [PATCH 6.1 382/451] afs: Revert "afs: Hide silly-rename files from userspace"
Date: Sun, 24 Mar 2024 19:10:58 -0400
Message-ID: <20240324231207.1351418-383-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 6e2c967fae6fc..07dc4ec73520c 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -473,16 +473,6 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
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


