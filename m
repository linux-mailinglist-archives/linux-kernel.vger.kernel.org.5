Return-Path: <linux-kernel+bounces-114147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180D4888F52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F981C2B959
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA1116192C;
	Sun, 24 Mar 2024 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aL6cVoIF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B741E88ED;
	Sun, 24 Mar 2024 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321460; cv=none; b=CbeJOMX6UM1GJ0Mu2c98wXwU2NSucXx6LyEXc/v85P9bFUP4jO3qga//gdNT9gWVSUh9uSnwdMp9qWV+2hkJpuocbDmU9VXU/rpSJ9Ck9gtu/FeMThPcAvm0wbzUDWkRf6hS8JClo1h9lhoEAwW+Dxemcj7k4LdEki5zk6eiWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321460; c=relaxed/simple;
	bh=Un5M0+Yy9i5pV1czleybjGf4TKM5KEaVe8OK7vHagJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axIJV2pLqBt74n9ur6YkDWT1XszlVlPWlnViRoYoAsZS3T7CPSiqAfEZgjp+nUZEuO4I1qb2D2ykbtrkvCYougmroSGLaihLWY0dzOpNW+iparOBXL1KGo5uhEbBK3IX0ATFf3THp+CiiGNNj6n9yLGBWZkPybmsY1ArTHRkKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aL6cVoIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34495C43390;
	Sun, 24 Mar 2024 23:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321459;
	bh=Un5M0+Yy9i5pV1czleybjGf4TKM5KEaVe8OK7vHagJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aL6cVoIFib3WvKTBTvE+4pGpAfK42x6MWZx9+5kksTS2D4IN1u0SH4IwokkXpapxk
	 VHMeVuToto6M2lURyXyozNpzzaJZzkUXzRN0fQqCAaafI9R6oa702OaadNYcg7GoXn
	 RJ37f7aRpQqaJCzo1VRlFbMF3S+0FBOhgD4nxymP+ZlnBM+HDFeM9dw1N/Q58ob4B6
	 0gGfb/G9KYnmeqEUvoa/Z1ebXVXGE12Pw3EiPEhP7gTdz9WUokEFD/eFWoWC/Dh1Nr
	 eB++5lK2VObwYwUQGbyZOKuimOhFX/bTbd0Y1W1PmiLPUjXEvKDy5/flcTQaPb9DRa
	 dpDHJNDtmEIOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 184/638] libbpf: Use OPTS_SET() macro in bpf_xdp_query()
Date: Sun, 24 Mar 2024 18:53:41 -0400
Message-ID: <20240324230116.1348576-185-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


