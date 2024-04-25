Return-Path: <linux-kernel+bounces-158202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965908B1CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75F41C21B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965BF7C085;
	Thu, 25 Apr 2024 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="twvjcBTS"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE674416
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714034227; cv=none; b=gr7w8LG7H2byiSMitS6qwbleSaVueVN0LW6zlwXc8l3Eu2vYtN9VAyjKJjPEIS4ZeCrc5Wp6shBV90htsOOExqNWbLpIhff4LZtz8G0avynaQqzDy6jKb5vVbyUoHhAaSlO+Tvs4J8JMqtZ+rxIuiO1K57QLFUo0TlLVrandJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714034227; c=relaxed/simple;
	bh=JizmCAqR2AD7zZZ2PmQ4NLKtsj6pjsjNTKBWvGZfPI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8ZUoZxNejlKPPC6Rliw4EeC7sr8VBtyM6yq53+jZaOCfkkdygzsfiY8vTl2UvrC7PnkI3KiTQwvYtfTW70DzmRjL4mIscz46EMfQZuvUuZ+KW9w25j2pvdrEwrAtrLjFUDZ7637hIXHvM8/2AYzm8lE62Jb2SgQ5LrbGakzo24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=twvjcBTS; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f9c133a9-8886-4c86-a24f-4778997547f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714034221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8Dv8ja4cI4A7RuODPGz/1zq0mfPiA4Ztqb9IZnHmtE=;
	b=twvjcBTST93NpvA3XgZgY6DoXLHBuOSyuy7O4G4p72MyO+AU4mK+Q4ipfbgJaTOxqwi+wB
	As0Sh3j+b8vDzwF2a3828/eq19a5mm3hIlNBT8qT1hI8c1kzyI5lZ/QPHD81rOQ6h1iowR
	DjdeZG/S09zYpPqYB6KVqVxu7dPBLjQ=
Date: Thu, 25 Apr 2024 16:36:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] slub: Fixes freepointer encoding for single free
To: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
References: <Zij_fGjRS_rK-65r@archlinux>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <Zij_fGjRS_rK-65r@archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/4/24 20:47, Nicolas Bouchinet wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> Commit 284f17ac13fe ("mm/slub: handle bulk and single object freeing
> separately") splits single and bulk object freeing in two functions
> slab_free() and slab_free_bulk() which leads slab_free() to call
> slab_free_hook() directly instead of slab_free_freelist_hook().

Right.

> 
> If `init_on_free` is set, slab_free_hook() zeroes the object.
> Afterward, if `slub_debug=F` and `CONFIG_SLAB_FREELIST_HARDENED` are
> set, the do_slab_free() slowpath executes freelist consistency
> checks and try to decode a zeroed freepointer which leads to a
> "Freepointer corrupt" detection in check_object().

IIUC, the "freepointer" can be checked on the free path only when
it's outside the object memory. Here slab_free_hook() zeroed the
freepointer and caused the problem.

But why we should zero the memory outside the object_size? It seems
more reasonable to only zero the object_size when init_on_free is set?

Thanks.

> 
> Object's freepointer thus needs to be properly set using
> set_freepointer() after init_on_free.
> 
> To reproduce, set `slub_debug=FU init_on_free=1 log_level=7` on the
> command line of a kernel build with `CONFIG_SLAB_FREELIST_HARDENED=y`.
> 
> dmesg sample log:
> [   10.708715] =============================================================================
> [   10.710323] BUG kmalloc-rnd-05-32 (Tainted: G    B           T ): Freepointer corrupt
> [   10.712695] -----------------------------------------------------------------------------
> [   10.712695]
> [   10.712695] Slab 0xffffd8bdc400d580 objects=32 used=4 fp=0xffff9d9a80356f80 flags=0x200000000000a00(workingset|slab|node=0|zone=2)
> [   10.716698] Object 0xffff9d9a80356600 @offset=1536 fp=0x7ee4f480ce0ecd7c
> [   10.716698]
> [   10.716698] Bytes b4 ffff9d9a803565f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [   10.720703] Object   ffff9d9a80356600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [   10.720703] Object   ffff9d9a80356610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [   10.724696] Padding  ffff9d9a8035666c: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [   10.724696] Padding  ffff9d9a8035667c: 00 00 00 00                                      ....
> [   10.724696] FIX kmalloc-rnd-05-32: Object at 0xffff9d9a80356600 not freed
> 
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>  mm/slub.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 3aa12b9b323d9..71dbff9ad8f17 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4342,10 +4342,16 @@ static __fastpath_inline
>  void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>  	       unsigned long addr)
>  {
> +	bool init = false;
> +
>  	memcg_slab_free_hook(s, slab, &object, 1);
> +	init = slab_want_init_on_free(s);
>  
> -	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
> +	if (likely(slab_free_hook(s, object, init))) {
> +		if (init)
> +			set_freepointer(s, object, NULL);
>  		do_slab_free(s, slab, object, object, 1, addr);
> +	}
>  }
>  
>  static __fastpath_inline

