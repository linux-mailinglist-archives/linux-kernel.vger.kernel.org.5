Return-Path: <linux-kernel+bounces-115381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDE9889B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5267E1F380A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFE71F9C16;
	Mon, 25 Mar 2024 02:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQIdKa6q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2301D8BDD;
	Sun, 24 Mar 2024 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320648; cv=none; b=pQNjz+Mm6FdZFLl9g6wIysNxIUfFdHIsmi6KJzCBvoHgBOSL0bdhynvBO5Axb0IbGD5kyi3kojvWCIBuqrj1awDEVbRQo5tu3Jqkv/wtEV0bt8DRF7WVGOOZ+cTr0lvIPG81enngHAwf2NEvcElBXX/QyQ//RGX69Atp1W/nbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320648; c=relaxed/simple;
	bh=Un5M0+Yy9i5pV1czleybjGf4TKM5KEaVe8OK7vHagJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2m4Gu4CQZMm0GtDKO9+DREwCMDZlYaMJWK+6cPe101f5YzdxsAscvgGOjIeXMrNVN2KWa4IcLU/dBOyFN5XCVCGTVu+Aox+kNZWDthArUrvxX69eJjS09JxWAecae9KpvIrg64NM0Vg8VqanwWRzYdoT4hmQKeUH1GrJjhyX54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQIdKa6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A21DC43399;
	Sun, 24 Mar 2024 22:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320648;
	bh=Un5M0+Yy9i5pV1czleybjGf4TKM5KEaVe8OK7vHagJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQIdKa6qbb9D9Z6cuiaOcm463tqU2T0fk0dIcL8s4GfD4kUZa2BKOkOeq06qcOmZ7
	 NBKFQDjK+ekMSil8piXrpY4Uq3Epc45DRZhAh92Ihd0QUQFyGd6XsGXDVo4gkjjiB0
	 baFRU9a82I83OnJIfn1PXFpgiP8YFK5gtAEtVwzrZGUw5cwH8V3uvVkmy9bRU3G4UK
	 KWVKPuh1Y306SnkaKvLTX+mdlIvWNVotV+N22RNmPHm0n+fEOUxyCGO/dq6ivJ0L20
	 0gxakiYJhJN/KcISfl68mLhsDjh9hpBH/9LeKWqBCL/o6P3h9G5rTCdammXY2LNn+G
	 YuXS/OdhAu+8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 209/713] libbpf: Use OPTS_SET() macro in bpf_xdp_query()
Date: Sun, 24 Mar 2024 18:38:55 -0400
Message-ID: <20240324224720.1345309-210-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 92a871ab9fa59a74d013bc04f321026a057618e7 ]

When the feature_flags and xdp_zc_max_segs fields were added to the libbpf
bpf_xdp_query_opts, the code writing them did not use the OPTS_SET() macro.
This causes libbpf to write to those fields unconditionally, which means
that programs compiled against an older version of libbpf (with a smaller
size of the bpf_xdp_query_opts struct) will have its stack corrupted by
libbpf writing out of bounds.

The patch adding the feature_flags field has an early bail out if the
feature_flags field is not part of the opts struct (via the OPTS_HAS)
macro, but the patch adding xdp_zc_max_segs does not. For consistency, this
fix just changes the assignments to both fields to use the OPTS_SET()
macro.

Fixes: 13ce2daa259a ("xsk: add new netlink attribute dedicated for ZC max frags")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240206125922.1992815-1-toke@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 090bcf6e3b3d5..68a2def171751 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -496,8 +496,8 @@ int bpf_xdp_query(int ifindex, int xdp_flags, struct bpf_xdp_query_opts *opts)
 	if (err)
 		return libbpf_err(err);
 
-	opts->feature_flags = md.flags;
-	opts->xdp_zc_max_segs = md.xdp_zc_max_segs;
+	OPTS_SET(opts, feature_flags, md.flags);
+	OPTS_SET(opts, xdp_zc_max_segs, md.xdp_zc_max_segs);
 
 skip_feature_flags:
 	return 0;
-- 
2.43.0


