Return-Path: <linux-kernel+bounces-143338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AD18A375F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E160C1C232B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B6D482C1;
	Fri, 12 Apr 2024 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW+cMZoo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522C39FD5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955447; cv=none; b=qnDhenMb3NoAsndyf6Ov9YGt38XrMQ+/A5X2MQ0ub3zaIXHDB/m92ATUYP/j2nHiD8pO1kAKiFaLwq87XV+klInNFRAotOCHwhytPcLpwzKsg8w0muKtSWF+SnR9Xx5MIlGuwrdrJ8YHuoMsDCG7+NIKoLgX3uJX3pImQ4Nlyt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955447; c=relaxed/simple;
	bh=N557OwkcMRzWWTkVtHcBibqTIxbQIgFLHLWudntz+/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFjoeqVDCZSqHklzdwDfD/hLZT4sXW+ni6RVaBim7DQ/mbd2hbU3qPlfVAUfvbq6DWoslAeKWN4Cgp5JuWSnvscTxdRXr95zmk79dhcR1m0MdsJkTRmP/qCpAtrng48EA8LNX/AosUlFcguGBgVXL3lm+2p2B3Xq6zhyIAw/iaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MW+cMZoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5E5C113CC;
	Fri, 12 Apr 2024 20:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712955446;
	bh=N557OwkcMRzWWTkVtHcBibqTIxbQIgFLHLWudntz+/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MW+cMZoosDJKSB2cOLCkq7MkRggIbRTBeKR3ycmPur4UnWRKeCgOVtYKbKZ/bfvB5
	 XfIztRiqlQKc4zg5EITFk+mkch5AHSIL7EJhqRwcKvgrwgPoKHFNgQ7hDk4dCttDOz
	 3vaJr22oHJHxZvYMsSw5YSdEE/KilhCMRuB8ZRIPWr5Pw1njLmhsODQWPmGHf+H1Ti
	 debFilfMRLdVoNLcAj3KVYNuWRVEV8PSqvvUmHrOUQdA6kD31c8rEK9OzOzBKiOGI1
	 iOYSWQpXmUXbxK+NrHyKEckrN7g9oBZ+3oA/eMr5rRpxHRsP9zTl+AUPNXQxbV0qzO
	 r+nrs1TRE9uWQ==
Date: Fri, 12 Apr 2024 20:57:24 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: clear writeback when compression
 failed
Message-ID: <ZhmgNBozIPL-WFZR@google.com>
References: <20240409203411.1885121-1-jaegeuk@kernel.org>
 <20240409203411.1885121-2-jaegeuk@kernel.org>
 <59414941-a15f-4eb0-8574-3b2a27d8ae69@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59414941-a15f-4eb0-8574-3b2a27d8ae69@kernel.org>

On 04/11, Chao Yu wrote:
> On 2024/4/10 4:34, Jaegeuk Kim wrote:
> > Let's stop issuing compressed writes and clear their writeback flags.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/compress.c | 33 +++++++++++++++++++++++++++++++--
> >   1 file changed, 31 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index d67c471ab5df..3a8ecc6aee84 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -1031,6 +1031,25 @@ static void set_cluster_writeback(struct compress_ctx *cc)
> >   	}
> >   }
> > +static void cancel_cluster_writeback(struct compress_ctx *cc, int submitted)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < cc->cluster_size; i++) {
> > +		if (!cc->rpages[i])
> > +			continue;
> > +		if (i < submitted) {
> > +			if (i)
> > +				f2fs_wait_on_page_writeback(cc->rpages[i],
> > +						DATA, true, true);
> > +			inode_inc_dirty_pages(cc->inode);
> > +			lock_page(cc->rpages[i]);
> > +		}
> > +		clear_page_private_gcing(cc->rpages[i]);
> > +		end_page_writeback(cc->rpages[i]);
> > +	}
> > +}
> > +
> >   static void set_cluster_dirty(struct compress_ctx *cc)
> >   {
> >   	int i;
> > @@ -1232,7 +1251,6 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
> >   		.page = NULL,
> >   		.encrypted_page = NULL,
> >   		.compressed_page = NULL,
> > -		.submitted = 0,
> >   		.io_type = io_type,
> >   		.io_wbc = wbc,
> >   		.encrypted = fscrypt_inode_uses_fs_layer_crypto(cc->inode) ?
> > @@ -1358,7 +1376,15 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
> >   			fio.compressed_page = cc->cpages[i - 1];
> >   		cc->cpages[i - 1] = NULL;
> > +		fio.submitted = 0;
> >   		f2fs_outplace_write_data(&dn, &fio);
> > +		if (unlikely(!fio.submitted)) {
> > +			cancel_cluster_writeback(cc, i);
> > +
> > +			/* To call fscrypt_finalize_bounce_page */
> > +			i = cc->valid_nr_cpages;
> 
> *submitted = 0; ?

And, it seems this is not enough to address kernel hang on wait_on_writeback
while running fsstress + shutdown test. Stay tuned.

> 
> Thanks,
> 
> > +			goto out_destroy_crypt;
> > +		}
> >   		(*submitted)++;
> >   unlock_continue:
> >   		inode_dec_dirty_pages(cc->inode);
> > @@ -1392,8 +1418,11 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
> >   out_destroy_crypt:
> >   	page_array_free(cc->inode, cic->rpages, cc->cluster_size);
> > -	for (--i; i >= 0; i--)
> > +	for (--i; i >= 0; i--) {
> > +		if (!cc->cpages[i])
> > +			continue;
> >   		fscrypt_finalize_bounce_page(&cc->cpages[i]);
> > +	}
> >   out_put_cic:
> >   	kmem_cache_free(cic_entry_slab, cic);
> >   out_put_dnode:

