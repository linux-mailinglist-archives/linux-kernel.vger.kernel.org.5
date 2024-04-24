Return-Path: <linux-kernel+bounces-156891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10428B09FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A06B25007
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353DF15959E;
	Wed, 24 Apr 2024 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="Cku/hBbx"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD1219EA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962907; cv=none; b=ZPEoV5K4diA0AxO5yCpm2fQ6DAMcYFPSOCuEIJVdXSi4EDDslsgJVOVpWsjHrqpCkhUnTgazMRaU9Usp8DylsLxMiS0ILo18189a5AakDADJR57gelJq3ZlflUVGHl2uHbiGzATAb72mp92RLQrxFMhK1R6wCcodYydhpnAlQv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962907; c=relaxed/simple;
	bh=XLeh9ge2I9Js+5MqYRN9Wl/goxigSOvbR1wEfUTK7TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qiDlekwIBQLAZPnqyKZstIQLjEFGIBJUe0WBXn3izrRdtSrFYr+9uJF84bjiiGlx6TRxt1mZ4sEDsu1SYyx5O6Um3t3MhC4Hp/I1MIC/YdY9yoNTioGuMz7RlrmMEMg1AGDc8n+V8vS3JHraB7Rq5RWWvNCar7ocuPq/NwsOT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=Cku/hBbx; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id A793E2000B;
	Wed, 24 Apr 2024 12:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1713962897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=9hAHncHB70jAgUx7BmR+WCk2XyvtNxvWkUnIfZWUNwo=;
	b=Cku/hBbxGarI7ndhP7LA7wjMbwm2Ozo1qjccwHT2xh0bDfI/isbJn42/xgvrbPAAqnxIw7
	8CrjV/ph6Z24DX4r5iidCt46E377vJ8nzge1IwVlSFk1PSRIyQcs0kmvSQpVUPryuKd4HC
	3Qo178gvN+jXjGPK5KhwxjAVJwrPrZ6tr2/Iy/R2usy4JZ02b8WXcUV0RGixFwnAnGMOvK
	dxophpoj5bURnDhkwLsuJDLZLAubUeOjY2XIwHpqWZ2l0wiomiYt31M7/XXfgNZa7GXBdP
	Mq0L0c2/1dIG+Okzve6CdmJARE8bNbQzkRbvUR50P3wnZI71sguN6UAnUJ8l3g==
Date: Wed, 24 Apr 2024 14:47:56 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Subject: [PATCH] slub: Fixes freepointer encoding for single free
Message-ID: <Zij_fGjRS_rK-65r@archlinux>
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

Object's freepointer thus needs to be properly set using
set_freepointer() after init_on_free.

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

Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 mm/slub.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3aa12b9b323d9..71dbff9ad8f17 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4342,10 +4342,16 @@ static __fastpath_inline
 void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	       unsigned long addr)
 {
+	bool init = false;
+
 	memcg_slab_free_hook(s, slab, &object, 1);
+	init = slab_want_init_on_free(s);
 
-	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
+	if (likely(slab_free_hook(s, object, init))) {
+		if (init)
+			set_freepointer(s, object, NULL);
 		do_slab_free(s, slab, object, object, 1, addr);
+	}
 }
 
 static __fastpath_inline
-- 
2.44.0


