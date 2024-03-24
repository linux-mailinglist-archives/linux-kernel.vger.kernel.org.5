Return-Path: <linux-kernel+bounces-113483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AE18884A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5DBC1F23715
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88B1B6755;
	Sun, 24 Mar 2024 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3FVCFEG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A29E13CF8C;
	Sun, 24 Mar 2024 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320284; cv=none; b=ZZa1NSjRi0oNdSolYymclITkU/A0VmBqgZ7Iol3rksfHim+s4cF2XyHUiKDowN0go1MbI/s/+RL2fi5urT8LHIfH+7bN6KGhQrDokefEFvdJP/BDRl9xvXy//yHYq0Cyl+yfPieOB6foUnj+DYUns2419iFfBArBnBnADyiIIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320284; c=relaxed/simple;
	bh=Zkv4uBQK8eMbRPj/TMoLQKTy5qtiJb0tBI+C77mgZrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMGPs/zuWef6vt6cz724nY63Q3aYHqJsv7H8LJLmcwSNnqDtdl4Dt9PRMY+IgEOu++KFX82pSqTkcnUeZ0M79wSkLjtLhzFlZHvLw65srK64nLX8qbbiF926g6CUKMAQJNFCkbaY23cn1cIj+oHiQwzV4oRY/gCrDlvYetmi7Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3FVCFEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BA6C433C7;
	Sun, 24 Mar 2024 22:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320284;
	bh=Zkv4uBQK8eMbRPj/TMoLQKTy5qtiJb0tBI+C77mgZrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3FVCFEGOmC9APnRXtcPcGR3c5Vzvt9h/slUECQuxhoQQ9itkHtvVxBMQf4J4VXkA
	 PL68gGgdURg5YESjNQ/VonKSOL+/VohLpyeqo2uMzc5W2gMG/rRNojPb7/9mzzRIVU
	 qfln6IAoHrKNmGZuILD4tXFI8dVxcyVeUAPlBVpTcXGuve2oVt6PgbrFFIIpsS+A63
	 DgEzIITkhSmsrahLxhM/beGSXXzewH5iHxk3xzCrCw8hZCUdYmX+ITvhK/fPnVJOsa
	 y99afm/wdnDugDDPI3YESaF2cb+nq4fUODQIuNIbdAJIRZ/JTTIG7Jh9LsUhGsxEE6
	 OS8FdjjeI/bFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 592/715] NFS: Fix an off by one in root_nfs_cat()
Date: Sun, 24 Mar 2024 18:32:51 -0400
Message-ID: <20240324223455.1342824-593-sashal@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 698ad1a538da0b6bf969cfee630b4e3a026afb87 ]

The intent is to check if 'dest' is truncated or not. So, >= should be
used instead of >, because strlcat() returns the length of 'dest' and 'src'
excluding the trailing NULL.

Fixes: 56463e50d1fc ("NFS: Use super.c for NFSROOT mount option parsing")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfsroot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
index 7600100ba26f0..432612d224374 100644
--- a/fs/nfs/nfsroot.c
+++ b/fs/nfs/nfsroot.c
@@ -175,10 +175,10 @@ static int __init root_nfs_cat(char *dest, const char *src,
 	size_t len = strlen(dest);
 
 	if (len && dest[len - 1] != ',')
-		if (strlcat(dest, ",", destlen) > destlen)
+		if (strlcat(dest, ",", destlen) >= destlen)
 			return -1;
 
-	if (strlcat(dest, src, destlen) > destlen)
+	if (strlcat(dest, src, destlen) >= destlen)
 		return -1;
 	return 0;
 }
-- 
2.43.0


