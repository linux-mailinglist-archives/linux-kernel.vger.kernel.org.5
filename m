Return-Path: <linux-kernel+bounces-115569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83817889C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2C41C23AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBAE2ECFD7;
	Mon, 25 Mar 2024 02:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwreHUGw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9783CA7;
	Sun, 24 Mar 2024 22:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321110; cv=none; b=YEk3S0AlmhnOUGw2nE+k7mwslz0tBM7H4j3M5dSxhU+pxC8NgnMRIzvPP1fbcTj4s31gY8FfCdvdIVgAIGVfluqj6g7VfJisLilt4At1jvtyK6VUQnATPNV4a2wGsiUk/Er9U+K5fTwOdu82y8u7/4pT1DMQB1INPmAQzidSWUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321110; c=relaxed/simple;
	bh=IPQUPry+ITtcAdi3zYmL9JlqymXhYmP6surBfz44xq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHrOsKrDJ+RQDvdiJnR9qjt0OiT2XJ252NkNJN6OahALQhliq25LnP9HjomgIgOXKYtDt0ecsS2pQnAemGg5hYyoFMUaSxdcAPTCxvPju7IU2HdVWq9ARU0vvnNDPdNlWEccbqQ9QQfH0P2JwwWAAZsZ5I9gvI7c4eYs2uF87pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwreHUGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E2DC43390;
	Sun, 24 Mar 2024 22:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321110;
	bh=IPQUPry+ITtcAdi3zYmL9JlqymXhYmP6surBfz44xq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwreHUGwzQffQbBvgp6oPebceT42PxFLF1bpHTpj2sBRA9xH5YaLhzn7Bi0kAOswM
	 7aFegeJkoBaJvu5GXUtGstSleDOXnvEKfAt0IoSpqStyPRVe4TgR4tQMx7hcmGJc3R
	 GzYkOTOuQFqUre1nxPyDg8a73E7biXbYCTFcIFNRN2eD1Upfjwtbetf84Z3PBjS0ev
	 4WZLHDHyEiH2c+RboUlKhS2U3wPD0l3o4fKBQK2fI05/kStIZNm+tZMiL+tyRjgHmC
	 PbZDv885qFDmGmjGpmExhiTNHOB7fJ1pZxh6TThSCPO06SnB9Wvw6ETAKFTutv9Oza
	 4toIQ8NE64Zfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 672/713] xfrm: Allow UDP encapsulation only in offload modes
Date: Sun, 24 Mar 2024 18:46:38 -0400
Message-ID: <20240324224720.1345309-673-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit 773bb766ca4a05bf363203030b72b10088869224 ]

The missing check of x->encap caused to the situation where GSO packets
were created with UDP encapsulation.

As a solution return the encap check for non-offloaded SA.

Fixes: 983a73da1f99 ("xfrm: Pass UDP encapsulation in TX packet offload")
Closes: https://lore.kernel.org/all/a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 653e51ae39648..6346690d5c699 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -407,7 +407,8 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 	struct net_device *dev = x->xso.dev;
 
-	if (!x->type_offload)
+	if (!x->type_offload ||
+	    (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED && x->encap))
 		return false;
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||
-- 
2.43.0


