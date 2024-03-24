Return-Path: <linux-kernel+bounces-113039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F948880FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50601C213C9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEBC13B2AD;
	Sun, 24 Mar 2024 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9nz3ABa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C8D13F00A;
	Sun, 24 Mar 2024 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319849; cv=none; b=rrHxXx2DzWK4lxJ1PlrKaqUYBbrIffeDru6yyJL2rH/PYIZNSkMymGUXk08aThHbYTJxJS6UjnvrIctDhWtEUgd2+v1Yy7P0k0X+Ln9KNp1q1PP50Z6rF+nGuypT/0uhLEp2DAVszrYtWbOl6Wg3yo3+pi7d3iGZ3Md0KEfW9ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319849; c=relaxed/simple;
	bh=Un5M0+Yy9i5pV1czleybjGf4TKM5KEaVe8OK7vHagJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDB/J8Eh9ZcM5rLxMl1rQWb0rxVVw2FoGe9Bac4tdsoBasAtXwg+xOzm9QeYw83fUESPbocUG13+1ga1Gkw4s+Y60U1qqzkhvpVyDxfsfn2cdNfeA66Eh7Z+vKzfTYRZZMhR1O65oZFTm/BnSrNP+fV7AOEaK+WUpiC6Y+FEtmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9nz3ABa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F56C433F1;
	Sun, 24 Mar 2024 22:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319849;
	bh=Un5M0+Yy9i5pV1czleybjGf4TKM5KEaVe8OK7vHagJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9nz3ABaaQJu2OpYQU4ApEUihX2TJ9if3E5UbBPMGal3Dc6J2YbkXSPy4RTDwgIdy
	 0RAVRdn8hc4CF2WCF21DeP6dLvkARn97groFW/RDiPbPsRDp78Zt0K6jtuYmCfHnPl
	 sFocEJ4RcRQf3aNtbj/AZvwAS+eJypx9N07l3wXQrcUbx1ZfR4GwACMyKmjO7qNdvN
	 fFq/GtD1NBl3L0BPuUSQ11xvDu4WTPu6N66JIaUs286WqC18KDE+N7Gd6J4jBP8m0S
	 IwoR0WdGiKiwLa4YJ+feQ3rW6G5UpC83feYFAXqjS1lPvFkFQg034ufsdsskonIFeO
	 oh987lS4aRTXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 152/715] libbpf: Use OPTS_SET() macro in bpf_xdp_query()
Date: Sun, 24 Mar 2024 18:25:31 -0400
Message-ID: <20240324223455.1342824-153-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


