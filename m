Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6617785B61
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjHWPFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjHWPFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:05:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952EAFB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:05:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 310B864B78
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C97C433C7;
        Wed, 23 Aug 2023 15:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692803107;
        bh=qBKXIAnu1/odz4PaihcIa0HE5DjNqy0JS4BP2Zup4fI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iaSZSvnmLDiEbLZY7VdasdIeW7cYyDUVYjqF8sBl7KxxC2ZhrwivbyGGHOzznpTEH
         2NNltLtPF1dyejk+cMnqLls7XI/f47EiJ9nHSjvhmoKyZszTWfHwhCMFt9Q6YmmYDz
         kbc8bBnLdSsLgJ0PK/l/AAt0IRDUnMCy5o/JmJlKFb9+G1Rq0mE1hwiT8gxWW50z5j
         3MFwO12K0hveL4ncF96kwGb4E4Am2ekfpCSlFklK2sgQ9JYbxLj2DfHbvukuDwpfbB
         +PkvyBgYaghDFOmRdACJCvro6XFiyVaj9p7JsfFj0HpZJaXFG8BpzRqsOnW7+liDgd
         mPcUtAQRbDL/Q==
Message-ID: <48235010-25e4-341f-77a3-a3399af3b6be@kernel.org>
Date:   Wed, 23 Aug 2023 23:05:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/8] erofs: move preparation logic into
 z_erofs_pcluster_begin()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
 <20230817082813.81180-3-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230817082813.81180-3-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/17 16:28, Gao Xiang wrote:
> Some preparation logic should be part of z_erofs_pcluster_begin()
> instead of z_erofs_do_read_page().  Let's move now.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/zdata.c | 59 +++++++++++++++++++++---------------------------
>   1 file changed, 26 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 4ed99346c4e1..30ecdfe41836 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -852,7 +852,10 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
>   static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>   {
>   	struct erofs_map_blocks *map = &fe->map;
> +	struct super_block *sb = fe->inode->i_sb;
> +	erofs_blk_t blknr = erofs_blknr(sb, map->m_pa);
>   	struct erofs_workgroup *grp = NULL;
> +	void *mptr;
>   	int ret;
>   
>   	DBG_BUGON(fe->pcl);
> @@ -861,8 +864,7 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>   	DBG_BUGON(fe->owned_head == Z_EROFS_PCLUSTER_NIL);
>   
>   	if (!(map->m_flags & EROFS_MAP_META)) {
> -		grp = erofs_find_workgroup(fe->inode->i_sb,
> -					   map->m_pa >> PAGE_SHIFT);
> +		grp = erofs_find_workgroup(sb, blknr);
>   	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
>   		DBG_BUGON(1);
>   		return -EFSCORRUPTED;
> @@ -881,9 +883,24 @@ static int z_erofs_pcluster_begin(struct z_erofs_decompress_frontend *fe)
>   	} else if (ret) {
>   		return ret;
>   	}
> +
>   	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
>   				Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
> -	/* since file-backed online pages are traversed in reverse order */
> +	if (!z_erofs_is_inline_pcluster(fe->pcl)) {
> +		/* bind cache first when cached decompression is preferred */
> +		z_erofs_bind_cache(fe);
> +	} else {

Nitpick, mptr can be defined here.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> +		mptr = erofs_read_metabuf(&map->buf, sb, blknr, EROFS_NO_KMAP);
> +		if (IS_ERR(mptr)) {
> +			ret = PTR_ERR(mptr);
> +			erofs_err(sb, "failed to get inline data %d", ret);
> +			return ret;
> +		}
> +		get_page(map->buf.page);
> +		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
> +		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
> +	}
> +	/* file-backed inplace I/O pages are traversed in reverse order */
>   	fe->icur = z_erofs_pclusterpages(fe->pcl);
>   	return 0;
>   }
> @@ -982,39 +999,15 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>   		err = z_erofs_map_blocks_iter(inode, map, 0);
>   		if (err)
>   			goto out;
> -	} else {
> -		if (fe->pcl)
> -			goto hitted;
> -		/* didn't get a valid pcluster previously (very rare) */
> -	}
> -
> -	if (!(map->m_flags & EROFS_MAP_MAPPED) ||
> -	    map->m_flags & EROFS_MAP_FRAGMENT)
> +	} else if (fe->pcl) {
>   		goto hitted;
> +	}
>   
> -	err = z_erofs_pcluster_begin(fe);
> -	if (err)
> -		goto out;
> -
> -	if (z_erofs_is_inline_pcluster(fe->pcl)) {
> -		void *mp;
> -
> -		mp = erofs_read_metabuf(&fe->map.buf, inode->i_sb,
> -					erofs_blknr(inode->i_sb, map->m_pa),
> -					EROFS_NO_KMAP);
> -		if (IS_ERR(mp)) {
> -			err = PTR_ERR(mp);
> -			erofs_err(inode->i_sb,
> -				  "failed to get inline page, err %d", err);
> +	if ((map->m_flags & EROFS_MAP_MAPPED) &&
> +	    !(map->m_flags & EROFS_MAP_FRAGMENT)) {
> +		err = z_erofs_pcluster_begin(fe);
> +		if (err)
>   			goto out;
> -		}
> -		get_page(fe->map.buf.page);
> -		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page,
> -			   fe->map.buf.page);
> -		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
> -	} else {
> -		/* bind cache first when cached decompression is preferred */
> -		z_erofs_bind_cache(fe);
>   	}
>   hitted:
>   	/*
