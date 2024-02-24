Return-Path: <linux-kernel+bounces-79630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDF78624E5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A500E1F21FA1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034CF3CF73;
	Sat, 24 Feb 2024 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUfeJxt1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7911701;
	Sat, 24 Feb 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708776754; cv=none; b=VvYOUj1K/zemSFPF7LmFY6QpxjauePXbNMmdmPBUUlQLpQoskc4GhAIAqvxeQCFgqu90okvxWxxmqPtbwrvwX41oo7ooth56H72ieiM2x5zu/TM2HdS74EFRAIa8EHM/7BCGNbvDN+lbWHvIXASvH8ktv7CfV8yA5wg5N0UWdtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708776754; c=relaxed/simple;
	bh=W9xsZJD7YcnkkKcjvki79L57zBBOz+m+R5LU7SHYrDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D08n5cttzVVp0EucHGJ4L5c50B9aTsXg5fOhc+v7uZcbdTV7xjoW16yh3fn3kYIjm9n6efMFJyGwoTxaBirygOjt9FtImFeTZToKMeMG6sfGFlKRH8EPw164D8a0u8CJKlfglCb0ZUDBdzV6U3MArZ10uE7V5YDufgU8TdxaLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUfeJxt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6FDC433F1;
	Sat, 24 Feb 2024 12:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708776753;
	bh=W9xsZJD7YcnkkKcjvki79L57zBBOz+m+R5LU7SHYrDw=;
	h=From:To:Cc:Subject:Date:From;
	b=qUfeJxt12Jdebx8coAIJDJOyRJqGwCkqVkxgZNDbQsTJcRxeFkrOZuATpQQGORb7A
	 7oOfrFj/4H8y0Zzhp2UTT/0QJkERtrkGXEae4cKkp3D6scSOqjtBI8EkurqiPu2bkw
	 Woat3gWsXQ5FjV+k1ROaGfnfSHiKHw63AlAhhAiisZQHFoyVBqAFHNhIfAgAZQ7ZjP
	 YDVdeCO/zrSYZa8X0jdajG/sX05ElV9ajOzY1ScIhHd5S7/+lRRFE1eqkIHMA0j+cE
	 isKJJBLaMTrvwbi8SXIxw2J3agKR/kdICuj/kDWoZcT+0f0DqpXwpWMOR8s5T8b1pU
	 N1Ejmp4etFQ5Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev
Cc: Arnd Bergmann <arnd@arndb.de>,
	Eric Biggers <ebiggers@google.com>,
	Yu Zhe <yuzhe@nfschina.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dm-integrity: reduce stack usage for recheck
Date: Sat, 24 Feb 2024 13:12:14 +0100
Message-Id: <20240224121228.1904859-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added integrity_recheck() function has another larger stack
allocation, just like its caller integrity_metadata(). When it gets
inlined, the combination of the two exceeds the warning limit for 32-bit
architectures and possibly risks an overflow when this is called from
a deep call chain through a file system:

drivers/md/dm-integrity.c:1767:13: error: stack frame size (1048) exceeds limit (1024) in 'integrity_metadata' [-Werror,-Wframe-larger-than]
 1767 | static void integrity_metadata(struct work_struct *w)

Since the caller at this point is done using its checksum buffer,
just reuse the same buffer in the new function to avoid the double
allocation.

Fixes: c88f5e553fe3 ("dm-integrity: recheck the integrity tag after a failure")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/md/dm-integrity.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 143f6c223b0e..82023f1f3df0 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1691,14 +1691,13 @@ static void integrity_sector_checksum(struct dm_integrity_c *ic, sector_t sector
 	get_random_bytes(result, ic->tag_size);
 }
 
-static void integrity_recheck(struct dm_integrity_io *dio)
+static void integrity_recheck(struct dm_integrity_io *dio, char *checksum)
 {
 	struct bio *bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
 	struct dm_integrity_c *ic = dio->ic;
 	struct bvec_iter iter;
 	struct bio_vec bv;
 	sector_t sector, logical_sector, area, offset;
-	char checksum_onstack[max_t(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 	struct page *page;
 	void *buffer;
 
@@ -1735,8 +1734,8 @@ static void integrity_recheck(struct dm_integrity_io *dio)
 			}
 
 			integrity_sector_checksum(ic, logical_sector, buffer,
-						  checksum_onstack);
-			r = dm_integrity_rw_tag(ic, checksum_onstack, &dio->metadata_block,
+						  checksum);
+			r = dm_integrity_rw_tag(ic, checksum, &dio->metadata_block,
 						&dio->metadata_offset, ic->tag_size, TAG_CMP);
 			if (r) {
 				if (r > 0) {
@@ -1851,7 +1850,7 @@ static void integrity_metadata(struct work_struct *w)
 						checksums_ptr - checksums, dio->op == REQ_OP_READ ? TAG_CMP : TAG_WRITE);
 			if (unlikely(r)) {
 				if (r > 0) {
-					integrity_recheck(dio);
+					integrity_recheck(dio, checksums);
 					goto skip_io;
 				}
 				if (likely(checksums != checksums_onstack))
-- 
2.39.2


