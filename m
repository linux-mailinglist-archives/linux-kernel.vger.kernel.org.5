Return-Path: <linux-kernel+bounces-113492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B038884BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00AF31C24005
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978AA1B8834;
	Sun, 24 Mar 2024 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UllH1hKt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D599C73165;
	Sun, 24 Mar 2024 22:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320293; cv=none; b=Z8ZIndfNWAb8YCJdWINEOkH6+KRjlX9CcqydhRwxkLargEbkqNQooADqjBKjzIls2cFFmsLeMwrUkf+n0Zyww02nl+K15ixHMM5VNajbPA+F3QbiqkyY5ZUMx/ail6SjE1TH/FDwmKJ1KVC/S+8Hto55AQjBp5FaMYU/Q3cX6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320293; c=relaxed/simple;
	bh=T6b3Fv6mmNPJPoSNNqMGnljWRi4bRwAQRXwzeaqDve8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocUY2vgda1X2WlfaKzzU95d+5tX8ItctbwgVtD/E1RnoKuLZ8rC3qLDcJHehdxq3PGIH2OrPVGfMH2QE1tfWUN0VHf90+3bAzPfqiHvFv/FNVY2cyXLE/7SeYjw5hWp9RvLjhviMAHUjEmPmf7UdaFsuJB5LHzQav/YRHe3iNQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UllH1hKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBE3C433F1;
	Sun, 24 Mar 2024 22:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320293;
	bh=T6b3Fv6mmNPJPoSNNqMGnljWRi4bRwAQRXwzeaqDve8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UllH1hKtLvMZrMnEolWWyBHkWlnfsQ2LvYInsCBufF+zHPzM3lDBBiovFM0xueK3A
	 HVGWhO/5yZk4L9uvMoKRMhKooxfOehn5geEclMzuKgZzcYvPjYI/dMWlbMSgQi01RY
	 brzB5jUIuOYO9wkMZu97X0Bb1iMxmPTpVNIQop9PwkWJD7IoS7vDMAkL0Jba9Vh+Y5
	 FCUKOHXkHbEtjpzC3+O/98sTGUV4YoGNWYWNQiRajgrNWmQ07HEMltnSp6SeRPaFPO
	 WRlJMNlMEPzsarZSY/mvB2zYyQvk6BAo57e6QkzLMtqSu0HXw7JkvXZhMh2/YouNDg
	 AQ/Z/Jv+2E8vA==
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
Subject: [PATCH 6.8 601/715] afs: Revert "afs: Hide silly-rename files from userspace"
Date: Sun, 24 Mar 2024 18:33:00 -0400
Message-ID: <20240324223455.1342824-602-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 8a67fc427e748..67afe68972d5c 100644
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


