Return-Path: <linux-kernel+bounces-13124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC7C820006
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059E01F22531
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF24611C9D;
	Fri, 29 Dec 2023 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O2/kZo7k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6D911C8B;
	Fri, 29 Dec 2023 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TuPgDojPHKw6CupQJwG5ikeXW8l957Szqc5prQs1GYE=; b=O2/kZo7k8MHhbMITfFhsRHEtGN
	SSg362JTpWehiBgATb5XQbubnuuFcdIT5HYWMYgG/JMopjWjU3j2GAyLYm0Ktxl4fIFtdJJsUeTc2
	H56iyH8WAyeRr/Gfq8HgnK1dQOVoir4xBUeaddBW9U/Lr+Jt91O1rAKyVX/Fv+VhfC/qmwSyLW0Dj
	MSKBoRQQqMJMRJ12NMT2Li3XHY3Qm0ljB+hZ6anHWhRIuWP0UC9W2+0ERjW3727M6fZRrWqC2nO2F
	S/+M6rLLRc+rNz4m9UZwegWEG1DQrqE/3CXT6zE9QnFUAXo4MsvEFRkNtnKRxC+JzM8syg0KejMtL
	6hgvC5Ig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rJEDR-006HV8-I8; Fri, 29 Dec 2023 14:52:01 +0000
Date: Fri, 29 Dec 2023 14:52:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-mm@kvack.org, kernel-janitors@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hugetlbfs: Improve exception handling in
 hugetlbfs_fill_super()
Message-ID: <ZY7dEbRJb1dHkQPd@casper.infradead.org>
References: <9ce3f553-24bc-4ecd-ac5e-7ba27caeff57@web.de>
 <b109b7dc-3972-4b2e-ae4c-89bf8eecf8f2@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b109b7dc-3972-4b2e-ae4c-89bf8eecf8f2@web.de>

On Fri, Dec 29, 2023 at 12:40:12PM +0100, Markus Elfring wrote:
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 24401a5046dd..5687ec574dc4 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1483,7 +1483,7 @@ hugetlbfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  						     ctx->max_hpages,
>  						     ctx->min_hpages);
>  		if (!sbinfo->spool)
> -			goto out_free;
> +			goto free_sbinfo;
>  	}
>  	sb->s_maxbytes = MAX_LFS_FILESIZE;
>  	sb->s_blocksize = huge_page_size(ctx->hstate);
> @@ -1499,10 +1499,12 @@ hugetlbfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
>  	sb->s_root = d_make_root(hugetlbfs_get_root(sb, ctx));
>  	if (!sb->s_root)
> -		goto out_free;
> +		goto free_spool;
>  	return 0;
> -out_free:
> +
> +free_spool:
>  	kfree(sbinfo->spool);
> +free_sbinfo:
>  	kfree(sbinfo);
>  	return -ENOMEM;
>  }

This is more complex.  NACK.

