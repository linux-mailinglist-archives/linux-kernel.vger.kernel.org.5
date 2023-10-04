Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257207B98AD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240859AbjJDX0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjJDX0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:26:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ECAC9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 16:26:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8973C433C7;
        Wed,  4 Oct 2023 23:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696461978;
        bh=x42U3iy9flrgCAqJT8UpF1tyjAUqScY4VU/d4Aqd980=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjxgppsdA5lqstSvuMiI+b8noAmOjk2cYb0FcYpfV5w4J76IvO18ArPv82SUBpTst
         ykhyYoD+cZArt2H72ylPSggAbpCfLPO2Az0ZtkyIvOBkHGzkfOKn3UY5553Z9e5tQ3
         UF1hhRpJTi3G8k+L2dPswl/gEnPCb0NCX7GQdK/kiQ0Pv9L8HZ/HDW9BzBqfnFVF9W
         R8qS/YcP3uSIn4fnWZwWe/yrFqimAKRb+sSjxAyb/KNolDtVFHvTefgJ5nL30DPVBt
         96nRdo9RdNcvC7yL0Dpb/xeFnl/2fQYOWNlLPDKC9buyG/fJ0Z7lCYKkHbi82Vr+ch
         AHQjux+A3k8Ng==
Date:   Wed, 4 Oct 2023 16:26:16 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs-tools: use proper address entry count for direct
 nodes
Message-ID: <ZR30mNQEyRjzr0jm@google.com>
References: <20231003230155.355807-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003230155.355807-1-daeho43@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> For direct nodes, we have to use DEF_ADDRS_PER_BLOCK.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fsck/fsck.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 78ffdb6..56a7d31 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -2894,7 +2894,7 @@ static void fsck_failed_reconnect_file_dnode(struct f2fs_sb_info *sbi,
>  	fsck->chk.valid_blk_cnt--;
>  	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
>  
> -	for (i = 0; i < ADDRS_PER_BLOCK(&node->i); i++) {
> +	for (i = 0; i < DEF_ADDRS_PER_BLOCK; i++) {

It seems we need to use the inode block passing by fsck_failed_reconnect_file().

>  		addr = le32_to_cpu(node->dn.addr[i]);
>  		if (!addr)
>  			continue;

3012                         fsck->chk.valid_blk_cnt--;
3013                         if (addr == NEW_ADDR)

And, we also need to skip if addr == COMPRESS_ADDR here?

3014                                 continue;
3015                         f2fs_clear_main_bitmap(sbi, addr);
3016                 }

> -- 
> 2.42.0.582.g8ccd20d70d-goog
