Return-Path: <linux-kernel+bounces-62687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3E8852464
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E622B21B47
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36660768FC;
	Tue, 13 Feb 2024 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSO6cXP5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7599E74E25;
	Tue, 13 Feb 2024 00:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783761; cv=none; b=FWDR/Wbe223mOKE0PcW20EgzKgNTl0xbiAYe8rjv3gnpl0wi0G0jeG7RdYbZoUQMRYuapY3cg4Oy5qm+0wsDwIggF0tDgzeyQdGzykTw6xLJ/OL40zGV2w/Wheq7WuXDhvDPOQB+J7nb8mdE7hRuKsF6DxR4hI+qvfNq2l67U/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783761; c=relaxed/simple;
	bh=dh8OhucC/BjL6q7utBgUUWgc9gRocKPR4IaU13t7+Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpPxnzL4lBEms0qY85gu8wA16NQYr+Od/iffCooybidRLNJZOV4QfYEoZVuSZ1EbDXgfGV2fbeXeWEr5oB0Pp8/6/aDUZ4xYw1JpqpVJWP/zitMIfH8dkHnmMRUTONIRvhJAJ7/qSDoaH4+eUa9fBXgGddfTvwKmZw2UIJZkrUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSO6cXP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C73C433C7;
	Tue, 13 Feb 2024 00:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783761;
	bh=dh8OhucC/BjL6q7utBgUUWgc9gRocKPR4IaU13t7+Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JSO6cXP5xpGK7DMMi5qzubLOEWqyvPDNtvVs/s89OcOtb6wawUcb8kcNbAiUxbPNB
	 IPFQIBvNNlscOZCRuZdjR+SiB6qOF8tuHjn8IIZR5GHaJWOT7mS/tp49rcOieLAFeA
	 2MAbfJ1kE94+vW7quu7ZuSagcaPc6dN6qaL3hKA2f9N3ZiLKc/rNW6S+BHB3mjl22x
	 aeHK+iwbEhdC2GMyZDm7KmCf+RsTAPo3SGv3iINl6VdnynqX8Cm7xabHNErUR1e80U
	 OuG1IWS80QERTx/oikRwnJhn9ubh0xXn7+xIT4Jv85AyxZBFPKvXCh0cvobbZhrgY7
	 J8xz2Yff1fnew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 04/28] fs/ntfs3: Print warning while fixing hard links count
Date: Mon, 12 Feb 2024 19:22:02 -0500
Message-ID: <20240213002235.671934-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 85ba2a75faee759809a7e43b4c103ac59bac1026 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index dc937089a464..42dd9fdaf415 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -402,7 +402,6 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		goto out;
 
 	if (!is_match && name) {
-		/* Reuse rec as buffer for ascii name. */
 		err = -ENOENT;
 		goto out;
 	}
@@ -417,6 +416,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 
 	if (names != le16_to_cpu(rec->hard_links)) {
 		/* Correct minor error on the fly. Do not mark inode as dirty. */
+		ntfs_inode_warn(inode, "Correct links count -> %u.", names);
 		rec->hard_links = cpu_to_le16(names);
 		ni->mi.dirty = true;
 	}
-- 
2.43.0


