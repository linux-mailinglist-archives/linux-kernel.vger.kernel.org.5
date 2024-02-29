Return-Path: <linux-kernel+bounces-87513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E86BE86D55B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824472869A9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555131504FB;
	Thu, 29 Feb 2024 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHUeyqQw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E7716B048;
	Thu, 29 Feb 2024 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239304; cv=none; b=PTbaefoSrZAvFsEBdMEOxRxVtihR9C3h9v7KkZaEkmHJ2WssX2b0nRR7qRmn6SV3aebszgNjAyiEXcj6t7Vd1wM/Pbfeg3dOEYpcOkYP1sWPcjvz4AZOinIgXXfvkL8QObJoOXycJESLlQod6GP+cJo+TWxFJTSiGGl3/bXrXFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239304; c=relaxed/simple;
	bh=ZxIx9z3r2Fy0pXEj0UY8qczYhkBfaOAySFHgWRpmokM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkRi3go6f2oelgxXt1jp4goYkUzFg1mtejCCJ1dyaILqW8GhodEtyeDQHJIzkQFFk6liDxmUUIjwhzbDHjJRRzVFluR2Tf7B0f/d6TGabXtu1NEQqr+Hzioo0zc5Wylh0wybL2E2rwW5hDkjf6AINDpGCn23YSNTIen6PiFFPrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHUeyqQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8934FC433C7;
	Thu, 29 Feb 2024 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239304;
	bh=ZxIx9z3r2Fy0pXEj0UY8qczYhkBfaOAySFHgWRpmokM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHUeyqQw3m+TB+h7Y//gUzemdleBCdrx0jnQ2yEoOS/+azD3WFpmAE210MRdbjGmX
	 RvVXeCwnQ0nVoOxYEOWRGIRSF6ptwlomcVJW02cIaypZERqGd0e4NP+GmAyRn/3L74
	 6vvaS0+lrpzsMcSSZNEp6rw8Hda5qvYss9pFYYo1QHucX3C94l3Aq1T9TpYHPuBElN
	 mYOGCrwg+1AlfEMcF6y7X3fWJANRoRMyBh6VYgQ0iwQ3FnlCok5kSYnQzl1SD4hMFN
	 2yymtQyRF1wSJo2cN5U0vbSb7dxY8KqWvSQ9D3TiyVOI67W2W+pgSlbtjkbG29wJS7
	 H9Bq3ISQ/ydZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	agk@redhat.com,
	dm-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 8/8] dm-verity, dm-crypt: align "struct bvec_iter" correctly
Date: Thu, 29 Feb 2024 15:41:25 -0500
Message-ID: <20240229204127.2861980-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204127.2861980-1-sashal@kernel.org>
References: <20240229204127.2861980-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.210
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 787f1b2800464aa277236a66eb3c279535edd460 ]

"struct bvec_iter" is defined with the __packed attribute, so it is
aligned on a single byte. On X86 (and on other architectures that support
unaligned addresses in hardware), "struct bvec_iter" is accessed using the
8-byte and 4-byte memory instructions, however these instructions are less
efficient if they operate on unaligned addresses.

(on RISC machines that don't have unaligned access in hardware, GCC
generates byte-by-byte accesses that are very inefficient - see [1])

This commit reorders the entries in "struct dm_verity_io" and "struct
convert_context", so that "struct bvec_iter" is aligned on 8 bytes.

[1] https://lore.kernel.org/all/ZcLuWUNRZadJr0tQ@fedora/T/

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-crypt.c  | 4 ++--
 drivers/md/dm-verity.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 5d772f322a245..bed685969ad49 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -48,11 +48,11 @@
 struct convert_context {
 	struct completion restart;
 	struct bio *bio_in;
-	struct bio *bio_out;
 	struct bvec_iter iter_in;
+	struct bio *bio_out;
 	struct bvec_iter iter_out;
-	u64 cc_sector;
 	atomic_t cc_pending;
+	u64 cc_sector;
 	union {
 		struct skcipher_request *req;
 		struct aead_request *req_aead;
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index 78d1e51195ada..f61c89c79cf5b 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -74,11 +74,11 @@ struct dm_verity_io {
 	/* original value of bio->bi_end_io */
 	bio_end_io_t *orig_bi_end_io;
 
+	struct bvec_iter iter;
+
 	sector_t block;
 	unsigned n_blocks;
 
-	struct bvec_iter iter;
-
 	struct work_struct work;
 
 	/*
-- 
2.43.0


