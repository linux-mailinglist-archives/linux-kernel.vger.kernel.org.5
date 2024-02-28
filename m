Return-Path: <linux-kernel+bounces-84751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ACA86AB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345F9B2117D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBA82E85E;
	Wed, 28 Feb 2024 09:18:24 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B52E647;
	Wed, 28 Feb 2024 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111903; cv=none; b=hcrBRt9fxWTsH8+lj3q3h+sBd3T9ylXmYK3XO+oAVkCiMSq6AWNL07jHt3FO4odXsVxErM1ktJhkW+ZWs3J2bcjEEracym+DCtRsqqbMorPPDxRLa9MCsRoHhZLx2OwXS0avEC/LoJnKph2WnZ08uM8On7gTOTMOUhUdo2Hk+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111903; c=relaxed/simple;
	bh=IXOTBc5f94HS2SaQgqmZGk6o1ztIjX0y5NJHG2OrYQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuQ6aPnpJMhjDKcl2KfqQh0fS9i9NW7khryEtGzE7xeArEg3so57XxzU/DDEJUmH6FlEQuQ+Xh2xyijiL2/oqCnjBBgLFTtfRsfLNAMeeVWUZS3uDhn0UuYRVsG8Z5KargV34y2l9Ywk33axes7Kiuz91XPTl7tVnLexqEfb4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rfG4i-001COF-0i; Wed, 28 Feb 2024 17:18:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 28 Feb 2024 17:18:19 +0800
Date: Wed, 28 Feb 2024 17:18:19 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Ovidiu Panait <ovidiu.panait@windriver.com>,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH] crypto: sun8i-ce - Fix use after free in unprepare.
Message-ID: <Zd76W98Ypq5uJmqm@gondor.apana.org.au>
References: <20240226215358.555234-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226215358.555234-1-andrej.skvortzov@gmail.com>

On Tue, Feb 27, 2024 at 12:53:57AM +0300, Andrey Skvortsov wrote:
> sun8i_ce_cipher_unprepare should be called before
> crypto_finalize_skcipher_request, because client callbacks may
> immediately free memory, that isn't needed anymore. But it will be
> used by unprepare after free. Before removing prepare/unprepare
> callbacks it was handled by crypto engine in crypto_finalize_request.
> 
> Usually that results in a pointer dereference problem during a in
> crypto selftest.
>  Unable to handle kernel NULL pointer dereference at
>                                       virtual address 0000000000000030
>  Mem abort info:
>    ESR = 0x0000000096000004
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x04: level 0 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>  user pgtable: 4k pages, 48-bit VAs, pgdp=000000004716d000
>  [0000000000000030] pgd=0000000000000000, p4d=0000000000000000
>  Internal error: Oops: 0000000096000004 [#1] SMP
> 
> This problem is detected by KASAN as well.
>  ==================================================================
>  BUG: KASAN: slab-use-after-free in sun8i_ce_cipher_do_one+0x6e8/0xf80 [sun8i_ce]
>  Read of size 8 at addr ffff00000dcdc040 by task 1c15000.crypto-/373
> 
>  Hardware name: Pine64 PinePhone (1.2) (DT)
>  Call trace:
>   dump_backtrace+0x9c/0x128
>   show_stack+0x20/0x38
>   dump_stack_lvl+0x48/0x60
>   print_report+0xf8/0x5d8
>   kasan_report+0x90/0xd0
>   __asan_load8+0x9c/0xc0
>   sun8i_ce_cipher_do_one+0x6e8/0xf80 [sun8i_ce]
>   crypto_pump_work+0x354/0x620 [crypto_engine]
>   kthread_worker_fn+0x244/0x498
>   kthread+0x168/0x178
>   ret_from_fork+0x10/0x20
> 
>  Allocated by task 379:
>   kasan_save_stack+0x3c/0x68
>   kasan_set_track+0x2c/0x40
>   kasan_save_alloc_info+0x24/0x38
>   __kasan_kmalloc+0xd4/0xd8
>   __kmalloc+0x74/0x1d0
>   alg_test_skcipher+0x90/0x1f0
>   alg_test+0x24c/0x830
>   cryptomgr_test+0x38/0x60
>   kthread+0x168/0x178
>   ret_from_fork+0x10/0x20
> 
>  Freed by task 379:
>   kasan_save_stack+0x3c/0x68
>   kasan_set_track+0x2c/0x40
>   kasan_save_free_info+0x38/0x60
>   __kasan_slab_free+0x100/0x170
>   slab_free_freelist_hook+0xd4/0x1e8
>   __kmem_cache_free+0x15c/0x290
>   kfree+0x74/0x100
>   kfree_sensitive+0x80/0xb0
>   alg_test_skcipher+0x12c/0x1f0
>   alg_test+0x24c/0x830
>   cryptomgr_test+0x38/0x60
>   kthread+0x168/0x178
>   ret_from_fork+0x10/0x20
> 
>  The buggy address belongs to the object at ffff00000dcdc000
>   which belongs to the cache kmalloc-256 of size 256
>  The buggy address is located 64 bytes inside of
>   freed 256-byte region [ffff00000dcdc000, ffff00000dcdc100)
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Fixes: 4136212ab18e ("crypto: sun8i-ce - Remove prepare/unprepare request")
> ---
>  .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 34 +++++++++----------
>  1 file changed, 17 insertions(+), 17 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

