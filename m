Return-Path: <linux-kernel+bounces-79656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BAA862540
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11915B2189A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5A5487A9;
	Sat, 24 Feb 2024 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlAMW9fj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED5A47F4A
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782493; cv=none; b=IXUlylArJcOUjIX58Zqcoyp7P9uVTESkp2KaO+Y9x7RTtfOWrxMxiZrIGJdMZySL4FHUUn/ZBvkjVFOD2D+6t1P/8Qw1A/aDr3TBfKTrI0JvjDBge707SGm1TsnvUbSjE1gtwsTyn11pmi7SYcD9revmcQleVCjoec23rTv/jzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782493; c=relaxed/simple;
	bh=uslCR6xIQ8gDe1woXzL0AS9BNpN7HRFFLfmLa1PMqmE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rVY/1AarN+9LqE+CTeW4Sz4yqDfLzstBrFRxr5TWzWcDz46bQLkArp3n8kDRV3EFjcQ6X9+uRh4oV5BtAKBmh91R9pbfXW7Ze0xg5ZBLHwgAH4W81W7R8OvZa+3cde99tfNYcHwe/nYkSVq3XSRLlj1QYWCwCtzcS/MrP9qkgk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlAMW9fj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708782490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tQGHJ/Uox2/MreygoVm4hqlwrCJbOV6priRfkP9HzFM=;
	b=NlAMW9fjgnKDE1yRS7pPyqZ23E0StOzPzwJNtcI54QGCplezf8rxhgfqKx+eqrVWfBIZQ8
	pLlH+s2SKI0U9lEEZQFef/ICVl75cpkVfAcQXjUWmF+IlLhaGAT65aLM5j4AKQDRXpLZ3h
	TSlyAvhyFFy1YbEm66p7R7/mlIkVdEs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-JY0Nyy--NKOCkikVaOKUIg-1; Sat, 24 Feb 2024 08:48:04 -0500
X-MC-Unique: JY0Nyy--NKOCkikVaOKUIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADE3F862CC1;
	Sat, 24 Feb 2024 13:48:03 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A032A20;
	Sat, 24 Feb 2024 13:48:03 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 87D4630C1B8F; Sat, 24 Feb 2024 13:48:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 86F6C3FB4E;
	Sat, 24 Feb 2024 14:48:03 +0100 (CET)
Date: Sat, 24 Feb 2024 14:48:03 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Alasdair Kergon <agk@redhat.com>, Arnd Bergmann <arnd@kernel.org>, 
    Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev, 
    Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>, 
    Yu Zhe <yuzhe@nfschina.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] dm-integrity: reduce stack usage for recheck
In-Reply-To: <b36796cd-e6f-b964-fe0-5a77114aa710@redhat.com>
Message-ID: <32883d32-afa6-78fb-d431-93bbb3a9fce8@redhat.com>
References: <20240224121228.1904859-1-arnd@kernel.org> <b36796cd-e6f-b964-fe0-5a77114aa710@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

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

Mikulas: I also added "noinline" to integrity_recheck and verity_recheck. 
These functions are only called on error, so they shouldn't bloat the 
stack frame or code size of the caller.

Fixes: c88f5e553fe3 ("dm-integrity: recheck the integrity tag after a failure")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/md/dm-integrity.c     |    9 ++++-----
 drivers/md/dm-verity-target.c |    4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/md/dm-integrity.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-integrity.c	2024-02-24 13:53:02.000000000 +0100
+++ linux-2.6/drivers/md/dm-integrity.c	2024-02-24 13:54:17.000000000 +0100
@@ -1691,14 +1691,13 @@ failed:
 	get_random_bytes(result, ic->tag_size);
 }
 
-static void integrity_recheck(struct dm_integrity_io *dio)
+static noinline void integrity_recheck(struct dm_integrity_io *dio, char *checksum)
 {
 	struct bio *bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
 	struct dm_integrity_c *ic = dio->ic;
 	struct bvec_iter iter;
 	struct bio_vec bv;
 	sector_t sector, logical_sector, area, offset;
-	char checksum_onstack[max_t(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 	struct page *page;
 	void *buffer;
 
@@ -1735,8 +1734,8 @@ static void integrity_recheck(struct dm_
 			}
 
 			integrity_sector_checksum(ic, logical_sector, buffer,
-						  checksum_onstack);
-			r = dm_integrity_rw_tag(ic, checksum_onstack, &dio->metadata_block,
+						  checksum);
+			r = dm_integrity_rw_tag(ic, checksum, &dio->metadata_block,
 						&dio->metadata_offset, ic->tag_size, TAG_CMP);
 			if (r) {
 				if (r > 0) {
@@ -1851,7 +1850,7 @@ again:
 						checksums_ptr - checksums, dio->op == REQ_OP_READ ? TAG_CMP : TAG_WRITE);
 			if (unlikely(r)) {
 				if (r > 0) {
-					integrity_recheck(dio);
+					integrity_recheck(dio, checksums);
 					goto skip_io;
 				}
 				if (likely(checksums != checksums_onstack))
Index: linux-2.6/drivers/md/dm-verity-target.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-verity-target.c	2024-02-24 13:52:21.000000000 +0100
+++ linux-2.6/drivers/md/dm-verity-target.c	2024-02-24 13:55:42.000000000 +0100
@@ -491,8 +491,8 @@ static int verity_recheck_copy(struct dm
 	return 0;
 }
 
-static int verity_recheck(struct dm_verity *v, struct dm_verity_io *io,
-			  struct bvec_iter start, sector_t cur_block)
+static noinline int verity_recheck(struct dm_verity *v, struct dm_verity_io *io,
+				   struct bvec_iter start, sector_t cur_block)
 {
 	struct page *page;
 	void *buffer;


