Return-Path: <linux-kernel+bounces-38710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE2783C46F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229601F24440
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E4633ED;
	Thu, 25 Jan 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZZ9mgTO"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB05B5D3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191977; cv=none; b=U3ZGwjJYZqethfkT8SoqvG9p+q4zK1gS+DAB829v1rIGm8LfzVC/I2PkxYfepwIf4pqMSfIUg/yCHhH17fKTvSqCUQT84CLs+XB6r4xY2KxDiSUd3xSnlUZaWyr+4qmypDnBXIHEea8xT9zD5+7sbQKnhQfqW5iw7cEiDhyXwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191977; c=relaxed/simple;
	bh=JqcjX3z0Zb1Exbaz2pCLGgsi3I1ibVsNbwmXI9s58zg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQEg8pvaXr+hLac7qFPuY6VhnNqHBTzN1jT1J35yiaWRwVnNYCjmzkBg5pqs9YHmJiM43EpZil3uf9mulCedxvvc+UbChzQX7Dvf3hMf4DV2gDNMnM35Se7rUwvN5GBAnpONLsMZfJauU7kFgUzTkazxTZRdFSR8FtfIx0g9hM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZZ9mgTO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29041f26e28so3517822a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706191975; x=1706796775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpJ1rdy+AQtCeVIbXtSCjUkJttMieQSTgjPiqYZd+FA=;
        b=RZZ9mgTOefbLVjiHWf71j/T46GexGIb2IbD3fqVpUHQteur37qZmT7mQDOwVZ+xhzu
         UUtI3aMOD/txQet2/5gqMH7E4WdJ/SHQkSlsVuB7x4lCxcNjkTlSugo1Rj+cVsb5en36
         cfJGUGWjSuklsMOhTgxQ71Qo/R09/INPu7SRu995uDWaJzgcgQbqwuX6XB+W2Dp/1x1r
         js311HqaK9JAoyfItP4ooSFQD5AevRXcrR3++1m0N7FXNaHhC8yOeZKyRr6HXl+kVvXQ
         E9AnX0BdEsluhXX7Au/njEw2XZvrEbuJ9yo091VELtyVvRe5t2C2vpEqbb9JwO9dxJOE
         v+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706191975; x=1706796775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpJ1rdy+AQtCeVIbXtSCjUkJttMieQSTgjPiqYZd+FA=;
        b=E9gJ6xusCU7Q45+XUQTVSVNP3s777RvHInaCPbL0o+cAkMYlKHN9BtyYGTaOwuz27n
         E7+CG8cyGJZNO4qmqzUwfdWYfoT9Yyt1/n8tOyjE8S0YcW4i+33W2MCafm8RCrMSNKyi
         KzI64NbYSMEsFsMdD4C2bdKg6g7Tlh2/d4dN67YHMeK4kvS9gq2hSVqINyEQ0fPixtsL
         9xuEYlyMOFC2WazcqP4HHoJdWbWM4NS7f7TBdzUrBbTBtM7xdqNEyG48wGcsGzcJyMhK
         0NqHhHhS5sqTM2KBfYgTV+pwJJ+tzYyqyEL9lQ+2toOtl0LffTqPL2pn9hAO1U4ys1Th
         buJw==
X-Gm-Message-State: AOJu0YwjYr2idD7kjme5saSFJZyapCGiYyoz2fu/LW/rqbMxYXbeY+Fx
	5EfroIXcYFs/I3lM9WqhU8U3xarJSPQRnv30lBscoXGFPigLZ0e5
X-Google-Smtp-Source: AGHT+IHr1RzpEFGjMeQUHPWvxUxyVQQQC1cwSXzNxT0dg1BVheiKgFJTUoXXDPXWXYJ76knu2rJIpw==
X-Received: by 2002:a17:90a:fa08:b0:28e:8bb7:d373 with SMTP id cm8-20020a17090afa0800b0028e8bb7d373mr616918pjb.50.1706191974337;
        Thu, 25 Jan 2024 06:12:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVuK+UU9W6xHqNkW2tj5AFhw2CsQxHTXewyocJL+tmXJlZrtyILdxMzENgIMGp6o31/3FsyHRW4zOn0coY3zpHq/DmQtPl9M0x8EOYM
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id pw11-20020a17090b278b00b002930639ad2fsm714394pjb.56.2024.01.25.06.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:12:54 -0800 (PST)
Date: Thu, 25 Jan 2024 22:12:48 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: fix infinite loop due to a race of filling
 compressed_bvecs
Message-ID: <20240125221248.00005540.zbestahu@gmail.com>
In-Reply-To: <20240125120039.3228103-1-hsiangkao@linux.alibaba.com>
References: <20240125120039.3228103-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 20:00:39 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> I encountered a race issue after lengthy (~594647 sec) stress tests on
> a 64k-page arm64 VM with several 4k-block EROFS images.  The timing
> is like below:
> 
> z_erofs_try_inplace_io                  z_erofs_fill_bio_vec
>   cmpxchg(&compressed_bvecs[].page,
>           NULL, ..)
>                                         [access bufvec]
>   compressed_bvecs[] = *bvec;
> 
> Previously, z_erofs_submit_queue() just accessed bufvec->page only, so
> other fields in bufvec didn't matter.  After the subpage block support
> is landed, .offset and .end can be used too, but filling bufvec isn't
> an atomic operation which can cause inconsistency.
> 
> Let's use a spinlock to keep the atomicity of each bufvec.  More
> specifically, just reuse the existing spinlock `pcl->obj.lockref.lock`
> since it's rarely used (also it takes a short time if even used) as long
> as the pcluster has a reference.
> 
> Fixes: 192351616a9d ("erofs: support I/O submission for sub-page compressed blocks")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 74 +++++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 583c062cd0e4..c1c77166b30f 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -563,21 +563,19 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
>  			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
>  	unsigned int i;
>  
> -	if (i_blocksize(fe->inode) != PAGE_SIZE)
> -		return;
> -	if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED)
> +	if (i_blocksize(fe->inode) != PAGE_SIZE ||
> +	    fe->mode < Z_EROFS_PCLUSTER_FOLLOWED)
>  		return;
>  
>  	for (i = 0; i < pclusterpages; ++i) {
>  		struct page *page, *newpage;
>  		void *t;	/* mark pages just found for debugging */
>  
> -		/* the compressed page was loaded before */
> +		/* Inaccurate check w/o locking to avoid unneeded lookups */
>  		if (READ_ONCE(pcl->compressed_bvecs[i].page))
>  			continue;
>  
>  		page = find_get_page(mc, pcl->obj.index + i);
> -
>  		if (page) {
>  			t = (void *)((unsigned long)page | 1);
>  			newpage = NULL;
> @@ -597,9 +595,13 @@ static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe)
>  			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
>  			t = (void *)((unsigned long)newpage | 1);
>  		}
> -
> -		if (!cmpxchg_relaxed(&pcl->compressed_bvecs[i].page, NULL, t))
> +		spin_lock(&pcl->obj.lockref.lock);
> +		if (!pcl->compressed_bvecs[i].page) {
> +			pcl->compressed_bvecs[i].page = t;
> +			spin_unlock(&pcl->obj.lockref.lock);
>  			continue;
> +		}
> +		spin_unlock(&pcl->obj.lockref.lock);
>  
>  		if (page)
>  			put_page(page);
> @@ -718,31 +720,25 @@ int erofs_init_managed_cache(struct super_block *sb)
>  	return 0;
>  }
>  
> -static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
> -				   struct z_erofs_bvec *bvec)
> -{
> -	struct z_erofs_pcluster *const pcl = fe->pcl;
> -
> -	while (fe->icur > 0) {
> -		if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
> -			     NULL, bvec->page)) {
> -			pcl->compressed_bvecs[fe->icur] = *bvec;
> -			return true;
> -		}
> -	}
> -	return false;
> -}
> -
>  /* callers must be with pcluster lock held */
>  static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
>  			       struct z_erofs_bvec *bvec, bool exclusive)
>  {
> +	struct z_erofs_pcluster *pcl = fe->pcl;
>  	int ret;
>  
>  	if (exclusive) {
>  		/* give priority for inplaceio to use file pages first */
> -		if (z_erofs_try_inplace_io(fe, bvec))
> +		spin_lock(&pcl->obj.lockref.lock);
> +		while (fe->icur > 0) {
> +			if (pcl->compressed_bvecs[--fe->icur].page)
> +				continue;
> +			pcl->compressed_bvecs[fe->icur] = *bvec;
> +			spin_unlock(&pcl->obj.lockref.lock);
>  			return 0;
> +		}
> +		spin_unlock(&pcl->obj.lockref.lock);
> +
>  		/* otherwise, check if it can be used as a bvpage */
>  		if (fe->mode >= Z_EROFS_PCLUSTER_FOLLOWED &&
>  		    !fe->candidate_bvpage)
> @@ -1423,23 +1419,26 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>  {
>  	gfp_t gfp = mapping_gfp_mask(mc);
>  	bool tocache = false;
> -	struct z_erofs_bvec *zbv = pcl->compressed_bvecs + nr;
> +	struct z_erofs_bvec zbv;
>  	struct address_space *mapping;
> -	struct page *page, *oldpage;
> +	struct page *page;
>  	int justfound, bs = i_blocksize(f->inode);
>  
>  	/* Except for inplace pages, the entire page can be used for I/Os */
>  	bvec->bv_offset = 0;
>  	bvec->bv_len = PAGE_SIZE;
>  repeat:
> -	oldpage = READ_ONCE(zbv->page);
> -	if (!oldpage)
> +	spin_lock(&pcl->obj.lockref.lock);
> +	zbv = pcl->compressed_bvecs[nr];
> +	page = zbv.page;
> +	justfound = (unsigned long)page & 1UL;
> +	page = (struct page *)((unsigned long)page & ~1UL);
> +	pcl->compressed_bvecs[nr].page = page;
> +	spin_unlock(&pcl->obj.lockref.lock);
> +	if (!page)
>  		goto out_allocpage;
>  
> -	justfound = (unsigned long)oldpage & 1UL;
> -	page = (struct page *)((unsigned long)oldpage & ~1UL);
>  	bvec->bv_page = page;
> -
>  	DBG_BUGON(z_erofs_is_shortlived_page(page));
>  	/*
>  	 * Handle preallocated cached pages.  We tried to allocate such pages
> @@ -1448,7 +1447,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>  	 */
>  	if (page->private == Z_EROFS_PREALLOCATED_PAGE) {
>  		set_page_private(page, 0);
> -		WRITE_ONCE(zbv->page, page);
>  		tocache = true;
>  		goto out_tocache;
>  	}
> @@ -1459,9 +1457,9 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>  	 * therefore it is impossible for `mapping` to be NULL.
>  	 */
>  	if (mapping && mapping != mc) {
> -		if (zbv->offset < 0)
> -			bvec->bv_offset = round_up(-zbv->offset, bs);
> -		bvec->bv_len = round_up(zbv->end, bs) - bvec->bv_offset;
> +		if (zbv.offset < 0)
> +			bvec->bv_offset = round_up(-zbv.offset, bs);
> +		bvec->bv_len = round_up(zbv.end, bs) - bvec->bv_offset;
>  		return;
>  	}
>  
> @@ -1471,7 +1469,6 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>  
>  	/* the cached page is still in managed cache */
>  	if (page->mapping == mc) {
> -		WRITE_ONCE(zbv->page, page);
>  		/*
>  		 * The cached page is still available but without a valid
>  		 * `->private` pcluster hint.  Let's reconnect them.
> @@ -1503,11 +1500,15 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>  	put_page(page);
>  out_allocpage:
>  	page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
> -	if (oldpage != cmpxchg(&zbv->page, oldpage, page)) {
> +	spin_lock(&pcl->obj.lockref.lock);
> +	if (pcl->compressed_bvecs[nr].page) {
>  		erofs_pagepool_add(&f->pagepool, page);
> +		spin_unlock(&pcl->obj.lockref.lock);
>  		cond_resched();
>  		goto repeat;
>  	}
> +	pcl->compressed_bvecs[nr].page = page;
> +	spin_unlock(&pcl->obj.lockref.lock);
>  	bvec->bv_page = page;
>  out_tocache:
>  	if (!tocache || bs != PAGE_SIZE ||
> @@ -1685,6 +1686,7 @@ static void z_erofs_submit_queue(struct z_erofs_decompress_frontend *f,
>  
>  			if (cur + bvec.bv_len > end)
>  				bvec.bv_len = end - cur;
> +			DBG_BUGON(bvec.bv_len < sb->s_blocksize);
>  			if (!bio_add_page(bio, bvec.bv_page, bvec.bv_len,
>  					  bvec.bv_offset))
>  				goto submit_bio_retry;

Looks good to me.

Reviewed-by: Yue Hu <huyue2@coolpad.com>

