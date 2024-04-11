Return-Path: <linux-kernel+bounces-140133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CC98A0BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7143AB26A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D5B1411FE;
	Thu, 11 Apr 2024 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD62E+FE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3D3142629
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826314; cv=none; b=XuW5WPaGPFzBeVUHuOwo6p6kHINplOtj6OJXh6y+WV2UdAQNDbVk3V0FiIjG6mGYb0JAHUv1REP0AZoRA0k1O2B9NYsFBnlDq+gQsYm61YSupvYhV9T5aSdJ/bHOcfg3vS63EO8QY/pdNlwIT8iJVJVvPpqubLPPOV2DtBGFf4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826314; c=relaxed/simple;
	bh=kMvhQuZC30TP4MfIzzmEHSrl3gDxXwvdJvDmpU7NQxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bDyQ+jiwnZmZZx4Kl3gU1EgSAWXA+igZk6oMuILs+acUlh37XVNzRdS+3D7lIo+S0XKuvgaED+CXwgWcsgO6cYZjEL4KaRoN+XnUiD1p71vJC4AqYBqL4gq1JiFCvm+UtotHYcSccdF4CAY/hxq+nM6BHsAocLrUNxg1O9u3WLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD62E+FE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078E6C433F1;
	Thu, 11 Apr 2024 09:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712826313;
	bh=kMvhQuZC30TP4MfIzzmEHSrl3gDxXwvdJvDmpU7NQxk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PD62E+FEblbbBz7OCHJPMaWWym+ESOgLHoVMpc4GgJqQ7M2yIgiCPstpZ6hems4lm
	 Nhy3CGAiGKrSioCgdmHfFgssfuOJ2+BKog0Ihtlu4ds4Qkxfjy8wd/W7GPsWjGvlJp
	 VUhHStomiR5R8z6HyNhDCWS2smUx5zF6nqreamLWUrMMCWhS02XV1CY89RP42Co5HR
	 xsR4zw1h2F8lIeK/HFQZd4x7QybXLgCdfLbkb4HmoMj6GY0th29FWgjPMvPYjrIwvb
	 dQwQol3rQfel1e6iO/035uIaGHdRwdFZkEwisz0vqkQaqYTU023fHs7mBuziJqUTSj
	 AGCMnzL/0cIVw==
Message-ID: <59414941-a15f-4eb0-8574-3b2a27d8ae69@kernel.org>
Date: Thu, 11 Apr 2024 17:05:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: clear writeback when compression
 failed
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240409203411.1885121-1-jaegeuk@kernel.org>
 <20240409203411.1885121-2-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240409203411.1885121-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/10 4:34, Jaegeuk Kim wrote:
> Let's stop issuing compressed writes and clear their writeback flags.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/compress.c | 33 +++++++++++++++++++++++++++++++--
>   1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index d67c471ab5df..3a8ecc6aee84 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1031,6 +1031,25 @@ static void set_cluster_writeback(struct compress_ctx *cc)
>   	}
>   }
>   
> +static void cancel_cluster_writeback(struct compress_ctx *cc, int submitted)
> +{
> +	int i;
> +
> +	for (i = 0; i < cc->cluster_size; i++) {
> +		if (!cc->rpages[i])
> +			continue;
> +		if (i < submitted) {
> +			if (i)
> +				f2fs_wait_on_page_writeback(cc->rpages[i],
> +						DATA, true, true);
> +			inode_inc_dirty_pages(cc->inode);
> +			lock_page(cc->rpages[i]);
> +		}
> +		clear_page_private_gcing(cc->rpages[i]);
> +		end_page_writeback(cc->rpages[i]);
> +	}
> +}
> +
>   static void set_cluster_dirty(struct compress_ctx *cc)
>   {
>   	int i;
> @@ -1232,7 +1251,6 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>   		.page = NULL,
>   		.encrypted_page = NULL,
>   		.compressed_page = NULL,
> -		.submitted = 0,
>   		.io_type = io_type,
>   		.io_wbc = wbc,
>   		.encrypted = fscrypt_inode_uses_fs_layer_crypto(cc->inode) ?
> @@ -1358,7 +1376,15 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>   			fio.compressed_page = cc->cpages[i - 1];
>   
>   		cc->cpages[i - 1] = NULL;
> +		fio.submitted = 0;
>   		f2fs_outplace_write_data(&dn, &fio);
> +		if (unlikely(!fio.submitted)) {
> +			cancel_cluster_writeback(cc, i);
> +
> +			/* To call fscrypt_finalize_bounce_page */
> +			i = cc->valid_nr_cpages;

*submitted = 0; ?

Thanks,

> +			goto out_destroy_crypt;
> +		}
>   		(*submitted)++;
>   unlock_continue:
>   		inode_dec_dirty_pages(cc->inode);
> @@ -1392,8 +1418,11 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>   out_destroy_crypt:
>   	page_array_free(cc->inode, cic->rpages, cc->cluster_size);
>   
> -	for (--i; i >= 0; i--)
> +	for (--i; i >= 0; i--) {
> +		if (!cc->cpages[i])
> +			continue;
>   		fscrypt_finalize_bounce_page(&cc->cpages[i]);
> +	}
>   out_put_cic:
>   	kmem_cache_free(cic_entry_slab, cic);
>   out_put_dnode:

