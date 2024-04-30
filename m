Return-Path: <linux-kernel+bounces-163849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA658B7496
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCB61C22AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F16912D768;
	Tue, 30 Apr 2024 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="nM0URJ6x"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB06612C47A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476912; cv=none; b=tmRCH57LEnZqU6gSme6bb8Eetzr/5oRWL9KTv59Fyot3uwRZwhHtWSqwE7MtSMXcWoHMF4vFUyJ81DoI3jEWqymW/xK6YsrPrnimVfQ4t7Kzo2NjmD21LkecTrWRs6W1NCUIiyIIS8xBRL/xFxUPzkNdBh1W7THlyik5Q+Akhs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476912; c=relaxed/simple;
	bh=Ro5C4SltTDmGHIqKcwc8eY9OizlrYbgNyQfowKhQ2Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GRFgcn2fpMXZvWq+pz+o9/hxxpbiOXBWCWgnHAwiAVQNXfRHHgimU4s5mJdIibuA96u4cVNh2JDErvVYW2bhVTThN1Z/twjrTmQNBKV4BwKC6IH+y4bT2uCsBWQ6HfmlnJeQ/Y5xk3Y/mL0+TJPI3ZRNSgFUFK3t0FmpJ4nL1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=nM0URJ6x; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 560CF60007;
	Tue, 30 Apr 2024 11:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1714476902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=M0gCyZUgKj7iV3h/gwYac96jecnR+4EjQmwFBZXj584=;
	b=nM0URJ6xiUOjlSg9J/l+2jP270ghHlvF+mpUuOm4n3R6s7J4d88Qx6Bg1Tx6+nyYwYexaP
	5g7NiwAQ1S/X4G5VFVYSZHIr9Ky1615t2aUuYAGOulK9Qq3Uc8gp+fSzsYHyqOVZmHeMuZ
	69eiP8stHv8cRpBpzTwjyU7Q5k6zQ1KwtnpnHuTjzzGe7TvF49shxJVREcZRoSjTbT6/N5
	KBR459cNEASDd2k+pLdFaEod9GWNS+Y0HjS9qPpA/labyVLo2e8TAn9SQEFtJQcDkorLX5
	m87rGXS34s+kA/NLRGbMlBwJcOAJzvTX8FsU4K4yfUGZ8mgTLEzJBMRYOjv+tA==
Date: Tue, 30 Apr 2024 13:34:59 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH v3] slub: Fixes freepointer encoding for single free
Message-ID: <ZjDXY74yS6UyQPxv@archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GND-Sasl: nicolas.bouchinet@clip-os.org

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

Commit 284f17ac13fe ("mm/slub: handle bulk and single object freeing
separately") splits single and bulk object freeing in two functions
slab_free() and slab_free_bulk() which leads slab_free() to call
slab_free_hook() directly instead of slab_free_freelist_hook().

If `init_on_free` is set, slab_free_hook() zeroes the object.
Afterward, if `slub_debug=F` and `CONFIG_SLAB_FREELIST_HARDENED` are
set, the do_slab_free() slowpath executes freelist consistency
checks and try to decode a zeroed freepointer which leads to a
"Freepointer corrupt" detection in check_object().

During bulk free, slab_free_freelist_hook() isn't affected as it always
sets it objects freepointer using set_freepointer() to maintain its
reconstructed freelist after `init_on_free`.

For single free, object's freepointer thus needs to be avoided when
stored outside the object if `init_on_free` is set. The freepointer left
as is, check_object() may later detect an invalid pointer value due to
objects overflow.

To reproduce, set `slub_debug=FU init_on_free=1 log_level=7` on the
command line of a kernel build with `CONFIG_SLAB_FREELIST_HARDENED=y`.

dmesg sample log:
[   10.708715] =============================================================================
[   10.710323] BUG kmalloc-rnd-05-32 (Tainted: G    B           T ): Freepointer corrupt
[   10.712695] -----------------------------------------------------------------------------
[   10.712695]
[   10.712695] Slab 0xffffd8bdc400d580 objects=32 used=4 fp=0xffff9d9a80356f80 flags=0x200000000000a00(workingset|slab|node=0|zone=2)
[   10.716698] Object 0xffff9d9a80356600 @offset=1536 fp=0x7ee4f480ce0ecd7c
[   10.716698]
[   10.716698] Bytes b4 ffff9d9a803565f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[   10.720703] Object   ffff9d9a80356600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[   10.720703] Object   ffff9d9a80356610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[   10.724696] Padding  ffff9d9a8035666c: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[   10.724696] Padding  ffff9d9a8035667c: 00 00 00 00                                      ....
[   10.724696] FIX kmalloc-rnd-05-32: Object at 0xffff9d9a80356600 not freed

Co-developed-by: Chengming Zhou <chengming.zhou@linux.dev>
Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
Changes since v2:
https://lore.kernel.org/all/ZjCxZfD1d36zfq-R@archlinux/

* Reword commit message in order to clarify the patch approach
as suggested by Vlastimil Babka

Changes since v1:
https://lore.kernel.org/all/Zij_fGjRS_rK-65r@archlinux/

* Jump above out of object freepointer if init_on_free is set
instead of initializing it with set_freepointer() as suggested
by Vlastimil Babka.

* Adapt maybe_wipe_obj_freeptr() to avoid wiping out of object
on alloc freepointer as suggested by Chengming Zhou.

* Reword commit message.
---
 mm/slub.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3aa12b9b323d..173c340ec1d3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2102,15 +2102,20 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
 	 *
 	 * The initialization memset's clear the object and the metadata,
 	 * but don't touch the SLAB redzone.
+	 *
+	 * The object's freepointer is also avoided if stored outside the
+	 * object.
 	 */
 	if (unlikely(init)) {
 		int rsize;
+		unsigned int inuse;
 
+		inuse = get_info_end(s);
 		if (!kasan_has_integrated_init())
 			memset(kasan_reset_tag(x), 0, s->object_size);
 		rsize = (s->flags & SLAB_RED_ZONE) ? s->red_left_pad : 0;
-		memset((char *)kasan_reset_tag(x) + s->inuse, 0,
-		       s->size - s->inuse - rsize);
+		memset((char *)kasan_reset_tag(x) + inuse, 0,
+			s->size - inuse - rsize);
 	}
 	/* KASAN might put x into memory quarantine, delaying its reuse. */
 	return !kasan_slab_free(s, x, init);
@@ -3789,7 +3794,7 @@ static void *__slab_alloc_node(struct kmem_cache *s,
 static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
 						   void *obj)
 {
-	if (unlikely(slab_want_init_on_free(s)) && obj)
+	if (unlikely(slab_want_init_on_free(s)) && obj && !freeptr_outside_object(s))
 		memset((void *)((char *)kasan_reset_tag(obj) + s->offset),
 			0, sizeof(void *));
 }
-- 
2.44.0


