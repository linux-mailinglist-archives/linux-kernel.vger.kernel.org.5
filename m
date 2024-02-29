Return-Path: <linux-kernel+bounces-87451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4894D86D491
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9626B23F74
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEC2154C04;
	Thu, 29 Feb 2024 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9P2Lavh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB846154BE5;
	Thu, 29 Feb 2024 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239086; cv=none; b=iK197F4K1KscOYvEE2F3lKL9q7kkhc07xT5d/OPNlgJXwnwFbsrwxWhdNKZFDaQPGSIQssh9AHPE3Cbj/+6eMKp70I5pY8W1ucwzFxyUzc+CQI+som+t0YXJfZvX58wB3KKi+zlJruAvSHRVbhcamxAQI4Rs834dXsRoBCUiNsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239086; c=relaxed/simple;
	bh=kvxZTRzq6RWHp6uh5uC7CjlkZwvyFL2WKvxmXmYgUA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eI/+KIE7ig9ZXC2BEjipCGkQJgOcrTJ7jJqqn9Ot25stsjyO5FMIdoky1w+IhkHc6Ai1rClt8TBRQfOhGE2OymUW670MEXpqlS/fZyj4SFxQXBapAaAhAYEn+kxdujU30HAMiMRKLeXpHzy1eEkSRyJwNboxfuotkf+KmgHFcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9P2Lavh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4161CC43390;
	Thu, 29 Feb 2024 20:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239086;
	bh=kvxZTRzq6RWHp6uh5uC7CjlkZwvyFL2WKvxmXmYgUA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9P2Lavh5JlJgM1iZv9s81D2QHza7b6WEy8V9N7il+j9EoXqeP6Ea+vVjH997qEnU
	 3J+f/wEqZQlQL30VEZbw/XAP4gfma0TrLrCqHySkX9JD5uQPdYPtYTKFcrq1NC3HC3
	 Bu+ZCM1QS17NYNTlvrC4FoE3+l5oWmmPi3iTrN1v73OvwWv5oK5PTQ4CfA3z9ZtEEc
	 uIa8ZefaOaq5NSXUWhtHyyIQg1JpNA2kRdleQ92yL+DE9zq75b498kdZwmhJURWhZS
	 NywnWryjILxte127yQzA5la3s6Ab6ETOIuI6h61rLx/589oPO07uv72VQ+p0OEjMTN
	 0girl12iDuQIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	agk@redhat.com,
	dm-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 18/24] dm-verity, dm-crypt: align "struct bvec_iter" correctly
Date: Thu, 29 Feb 2024 15:36:58 -0500
Message-ID: <20240229203729.2860356-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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
index 08681f4265205..2c5c6c9ad7103 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -53,11 +53,11 @@
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
index f3f6070084196..5265b0d9ea37c 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -76,12 +76,12 @@ struct dm_verity_io {
 	/* original value of bio->bi_end_io */
 	bio_end_io_t *orig_bi_end_io;
 
+	struct bvec_iter iter;
+
 	sector_t block;
 	unsigned int n_blocks;
 	bool in_tasklet;
 
-	struct bvec_iter iter;
-
 	struct work_struct work;
 
 	/*
-- 
2.43.0


