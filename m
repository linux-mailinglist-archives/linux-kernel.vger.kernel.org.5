Return-Path: <linux-kernel+bounces-116309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77625889E27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838A22C1E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6031C2987AC;
	Mon, 25 Mar 2024 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2H8Sf6L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86671836E0;
	Sun, 24 Mar 2024 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324224; cv=none; b=BZ1euEApya7vBR5rl8wDoC4dU2+BK2UVyYcnoz/WyAhPGFuEMqfOoRRH92GmBD807V4HHIhwLqdPOsQ1DEdixSsZt65Puwb4nuGL09Sv+FNlwk6PJd/4zCowQkOiwCd0wVCjBQVCAwQi6w6rsc4M8xZyX7l5CyAlnMATbK+fz+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324224; c=relaxed/simple;
	bh=cubP+c0OUfdvbOgQY+o8BUv8QtzcIjoJECvSJtCfpII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRlG1G0TJqGVhzV1FrsP1gzkzH4gP8AQ/DL/l8ErVR1uKd5h+tpFaYWGYSyhLtkpqffnHx9koglQZFrhGvfOMADKPARmm5WWI4E3IDbx+jXeCGo3GkMPq7B44NKIxxifd8NKRjuLeLWAzNwQpwf2a9OOsirIfsPk56ouEL6OciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2H8Sf6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9A2C43394;
	Sun, 24 Mar 2024 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324222;
	bh=cubP+c0OUfdvbOgQY+o8BUv8QtzcIjoJECvSJtCfpII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s2H8Sf6L1lXL7fSB+i5LCydkU2jTvxVNVj6pPUuTqAuKleLggK3SocDvpXqAdaxBg
	 hlnhlLDT8amTicB27C5gGTMh+GJiv6SpRH7Tx2/Y6U2LJepo3HJrVWUO/pxioNyeZW
	 RtsGgfDFVVvn6HsFjBlw6OoaousjNBvDUPhOaNT4A7x6YMm/v3IimSnxjazjrQe1RZ
	 6kHnKw0z35XNcpv6qvb76KixR4jmeStVd0QTmetY1Q9EMirIgqVJobtWniX2UHzgQX
	 b20W5Q+PNE/XxTty7hOt+TZdem2qSj0usxLFaZ0bjQVzSJD7rPYzOWkp1YD+uEEjgL
	 DY0t+Gw0cZ1eg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 006/148] dm-verity, dm-crypt: align "struct bvec_iter" correctly
Date: Sun, 24 Mar 2024 19:47:50 -0400
Message-ID: <20240324235012.1356413-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 569904f73994a..95ed46930a90e 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -46,11 +46,11 @@
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
index 6e65ec0e627a6..04ef89e318564 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -72,11 +72,11 @@ struct dm_verity_io {
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


