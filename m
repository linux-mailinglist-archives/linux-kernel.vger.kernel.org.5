Return-Path: <linux-kernel+bounces-115576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4B4889C85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62E329B1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AF224EDBB;
	Mon, 25 Mar 2024 02:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1MbBpuu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5161F30C8;
	Sun, 24 Mar 2024 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321127; cv=none; b=U4+hA0yji6sWSYMe6dT76k/beRHRL/QeWK7vPxNdRNVMtNl+9Y9BaLQq5LN6F9NW/55ecOvsg2uYQUWdAz/bnbmH7GFy9L6wNtRnWUuXUzyDX4X+glPg4KV2Ld9m1Wd+CnxylRDFXWzuwhEgwbl6h9oJpvvYVWkUufEe4kKZD48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321127; c=relaxed/simple;
	bh=2VIL+MLt/7XqLixGaICvTuQvPKug+Yb+u6KBIUa/lxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pd/ndxiJ1H+WMKQWkOGAOU55JGWIk9LMG0WRzdxieKWjwXsjOsEku/B9Y9NmmwOKGA1ALdXrgWQEs8OvKzGRbTVcpnktWGp14LR8iJuK8VA4dfVsl7d0p/6Em8ilhhBEzqjzSEFVR5duwNCHpL4znr2FMM1Jq96FZl9uHzwUyIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1MbBpuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877B1C43394;
	Sun, 24 Mar 2024 22:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321126;
	bh=2VIL+MLt/7XqLixGaICvTuQvPKug+Yb+u6KBIUa/lxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1MbBpuulXhgJ9AVapaug+DJ23p7j+QpPp1WRgdfXBCCfYPukHnAZAHemnLxj7zmp
	 a2zUJbu7jhF+byKDnLuUXfSsRty+6Yo+awqghasEF5iG2ovedodekHQdX0WKvXVc3V
	 dpWJFk4x4h5oaLh6julMZ+CeQm68DADXkTy5Ioc0HDZs8qnWpV8tEKelRGPFYePqnY
	 vgMgZM8248b74nPCHLF5TRC36JRVi5sokGfOpOhcBJhEcbYsZbrZpkBfFAnsFWC8Bv
	 SqXjGMuo+iPetGR3Ol3jTl57o/5mThDNKPYJ4CKt2a+x33lul6rlxpiRQd+nOGcBoE
	 6LHO5BMuiLB/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 687/713] dm-integrity: fix a memory leak when rechecking the data
Date: Sun, 24 Mar 2024 18:46:53 -0400
Message-ID: <20240324224720.1345309-688-sashal@kernel.org>
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

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 55e565c42dce81a4e49c13262d5bc4eb4c2e588a ]

Memory for the "checksums" pointer will leak if the data is rechecked
after checksum failure (because the associated kfree won't happen due
to 'goto skip_io').

Fix this by freeing the checksums memory before recheck, and just use
the "checksum_onstack" memory for storing checksum during recheck.

Fixes: c88f5e553fe3 ("dm-integrity: recheck the integrity tag after a failure")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index e8e8fc33d3440..cc834c8423bcf 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1848,12 +1848,12 @@ static void integrity_metadata(struct work_struct *w)
 			r = dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio->metadata_offset,
 						checksums_ptr - checksums, dio->op == REQ_OP_READ ? TAG_CMP : TAG_WRITE);
 			if (unlikely(r)) {
+				if (likely(checksums != checksums_onstack))
+					kfree(checksums);
 				if (r > 0) {
-					integrity_recheck(dio, checksums);
+					integrity_recheck(dio, checksums_onstack);
 					goto skip_io;
 				}
-				if (likely(checksums != checksums_onstack))
-					kfree(checksums);
 				goto error;
 			}
 
-- 
2.43.0


