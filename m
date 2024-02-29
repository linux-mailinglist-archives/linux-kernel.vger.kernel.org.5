Return-Path: <linux-kernel+bounces-87476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5AF86D4E0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA79F2849C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B18161B55;
	Thu, 29 Feb 2024 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEDAHzp4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0A0161B75;
	Thu, 29 Feb 2024 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239211; cv=none; b=ml/9C6OgWI02jFasnDFGW+ovCeUvCZWTEgrLd9gm0cCk3tNTRHyWJT2jZi6tjC1SJ3eKkeR0pwcS1hNA0o46r291hw1VHAyjiUL6zxicfzVJmAXtPAIIsKHeNqUfOYTmgket8ghiCs+wcJTc8ul3MnHMcGDFgecIQNh4eBU2KGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239211; c=relaxed/simple;
	bh=/trDRVjr/rl5P+VDqa4+Jil5XnsArhakGC5pLLP4Hss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ko+okbecbnsuzvYjYrBPU3i5Gahi0bUDv4d7ChRuWM0iueAUd+5nclycELloHvALX+ld5T2h4Jb5aZ41vC0cfgzRMwQXAMLnuReB6Rb6czAvHQSFOyv2bj/2G5U1uZNvPHth/I+uxYiUVx+bL+UQgmS8xAoRkFWkTwMJNS8cmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEDAHzp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1461C43394;
	Thu, 29 Feb 2024 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239209;
	bh=/trDRVjr/rl5P+VDqa4+Jil5XnsArhakGC5pLLP4Hss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEDAHzp4PC/i0bipTRkrWTxvQG9vWj17OSP7nTtUaDaIlS1JtSDWlIgvvo7dn0MP0
	 jJCV1OClR40oMjvVF8N/gmccvWKgIOqi6xEs9oLsVQx0jZVPV/tZDZ2jpLR62L5T8i
	 pIIk2gsjy1q04UvxoyrsQoSTT6eUJGB0tKZZ7euQ0QPfDDYXz3/UgGoQDzrTHtnMs1
	 QE5CyQNL9MF5J0hI2QFX56Rs9/5GpFMgEGB9CiAKHyDbkDqedv6za1Ccz3NATnEAL2
	 kYqz+5cYvQp3W8odx9iu7kMSq/2rhE8KLP8RflAhIILYVaL0qqtrV898nPln+C1blj
	 7+k/sEY097zAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	agk@redhat.com,
	dm-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 17/22] dm-verity, dm-crypt: align "struct bvec_iter" correctly
Date: Thu, 29 Feb 2024 15:39:10 -0500
Message-ID: <20240229203933.2861006-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203933.2861006-1-sashal@kernel.org>
References: <20240229203933.2861006-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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
index 1a539ec81bacc..a230b0639f81b 100644
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


