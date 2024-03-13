Return-Path: <linux-kernel+bounces-101782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A3287AB89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86CC0B22796
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28AA62A0E;
	Wed, 13 Mar 2024 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdaXyNFd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9262A00;
	Wed, 13 Mar 2024 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347611; cv=none; b=mP0datuylvY172RjNiZPKG4fLjBsE8fvJ5sFTl52YEtx7NEQa8qeKtn/QvP9Wkh56Z6gLuBcDNBsLoXGCz2wHi6Ai3qyVoyyeV19WNHZgki9y8ZHvezo0XcLQubCIJ+0XdRndEDqr+vcwKs44QkXBcZCphztFl7SWBEHL1DDmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347611; c=relaxed/simple;
	bh=1ayRbnay81uQwaBNVQbQadvJau2LtCm8yMXjEqr/Yic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWfGrKiVoUqKAk4wHWiDQ8R/lcuqLyAVF/fSmAuFv4ZIYl3aHACswMZ0NkAqNscfUKvpGJjFpygCObtv9dPd4TWhwz+bNW5wQeJFnvZnpoP5960Nbf9/pH6DKbXTmhRYpdoexyivY0mMchwggyIaVAHcZZYvTaBxZbImq1sUwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdaXyNFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33207C433C7;
	Wed, 13 Mar 2024 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347610;
	bh=1ayRbnay81uQwaBNVQbQadvJau2LtCm8yMXjEqr/Yic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdaXyNFdNNEKcGbboNwJT5gc+/iMnIMB88zdN1rlQaLFZlGwD9ckqakEPpgpas1KM
	 piGBC0OmpAGNGpJWPVjRAgU0JarrmmAHByu8pwQXIHRDxz7VNi68hfAcf0z6bpiVlf
	 qP76Janv32XxCePVet8bffiQ1/J0a5KeFKMmxE/uhAWJ9XAc1fXk+7hzl3RI3uydyA
	 cBrRYZ5OFt/2nn4S/Lty5c6OYo7mnJFlwqEi2K3c+IMW8uJ2jXyjyclJ6+vdUUkGMx
	 KcQI/IhSZTUFcPo93guJCkbcnP6D5QAMpm7+Km5DSB8A77Fe0CHBVrimoC4Bc5wGHz
	 C8pkc6iXxXknQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 43/61] netrom: Fix a data-race around sysctl_netrom_default_path_quality
Date: Wed, 13 Mar 2024 12:32:18 -0400
Message-ID: <20240313163236.613880-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit 958d6145a6d9ba9e075c921aead8753fb91c9101 ]

We need to protect the reader reading sysctl_netrom_default_path_quality
because the value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index baea3cbd76ca5..6f709fdffc11f 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -153,7 +153,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		nr_neigh->digipeat = NULL;
 		nr_neigh->ax25     = NULL;
 		nr_neigh->dev      = dev;
-		nr_neigh->quality  = sysctl_netrom_default_path_quality;
+		nr_neigh->quality  = READ_ONCE(sysctl_netrom_default_path_quality);
 		nr_neigh->locked   = 0;
 		nr_neigh->count    = 0;
 		nr_neigh->number   = nr_neigh_no++;
-- 
2.43.0


