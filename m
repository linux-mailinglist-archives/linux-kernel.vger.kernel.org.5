Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF3080DE2A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjLKWIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345555AbjLKWIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:08:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043DAC7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:08:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5B2C433C9;
        Mon, 11 Dec 2023 22:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702332523;
        bh=iDewZAyJOxIOJgkget2tmiP/MAlk2VhzGLtGrH05aaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3Z4OEv/bQCRGBikvcKo6n6zysKC22iBZJFAOV4Q5sUkus013tBJ2R7dpS9Ujl4uO
         DvNriuKSqj1YuhXUgGY6Jtt4HeNFcgNHmQwwpgVZIsj5Fq3bd2zHsv70PMaXpD18SW
         wbKRGGr4gxZwGDqGGevLKqD7qrWRAY8b1k5RAu9DemcVqULnc4P886MT9SIZJmICuf
         dqFPoIo0vzPFnXk5nyP7RYEZERK7yfNacfklZVIv0sj26HA8Fc11Or9XmCxWvlZCTk
         6VEytIPHy3NkTea2rTsJlLy6R16JcyNBu8QYzplFVlo5aXqJLNKtVLvrO1a1WQk51R
         KkNf8E+5eMVag==
Date:   Mon, 11 Dec 2023 14:08:41 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 4/6] f2fs: don't set FI_PREALLOCATED_ALL for partial write
Message-ID: <ZXeIabjxfk8tN10r@google.com>
References: <20231210113547.3412782-1-chao@kernel.org>
 <20231210113547.3412782-4-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210113547.3412782-4-chao@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10, Chao Yu wrote:
> In f2fs_preallocate_blocks(), if it is partial write in 4KB, it's not
> necessary to call f2fs_map_blocks() and set FI_PREALLOCATED_ALL flag.
> 
> Cc: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 5c2f99ada6be..1a3c29a9a6a0 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4561,13 +4561,14 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
>  			return ret;
>  	}
>  
> -	/* Do not preallocate blocks that will be written partially in 4KB. */
>  	map.m_lblk = F2FS_BLK_ALIGN(pos);
>  	map.m_len = F2FS_BYTES_TO_BLK(pos + count);
> -	if (map.m_len > map.m_lblk)
> -		map.m_len -= map.m_lblk;
> -	else

		return 0;

We just need the above?

> -		map.m_len = 0;
> +
> +	/* Do not preallocate blocks that will be written partially in 4KB. */
> +	if (map.m_len <= map.m_lblk)
> +		return 0;
> +
> +	map.m_len -= map.m_lblk;
>  	map.m_may_create = true;
>  	if (dio) {
>  		map.m_seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
> -- 
> 2.40.1
