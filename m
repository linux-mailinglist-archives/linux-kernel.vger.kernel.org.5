Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC76176DEB6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjHCDII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjHCDID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:08:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAAFED;
        Wed,  2 Aug 2023 20:08:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 341AC61BB3;
        Thu,  3 Aug 2023 03:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1EBC433C8;
        Thu,  3 Aug 2023 03:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691032081;
        bh=tTG+FA9CILiueGgXhaHmfU9jVZoLyJhrIURNGRvYhqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrQgqtQVXHCrO2JX5EBqbkNgIfEYfirBcABkhqDJ43iH8cn/4Puk74nwis9a3j+lb
         gCQ8IsjNMJrqALXZhxyErdDHr2nNCYy5K2XNK6vj9klWRr//47/A8RuLV5f8kKJyVk
         WogDtyXJK9+WpEGFuFfr08OSnmQV416r2Hswjfb6kb2+y/PWuBJr8x00+HpBWQBo2O
         dO2c9ADdixH8OPOnyCiKcKovsRVbkQfxU5r3kCigPrIQq1T9u5DUCATqaa7t2b45h8
         SMDnxvbaCay6ndRbfjVFNade7hinDAAAFYlx3pE6j8BNNDmwVAHUQ2aIXqOUqJxgsq
         yCg4sd0uphnJA==
Date:   Wed, 2 Aug 2023 20:08:00 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the block tree with the djw-vfs tree
Message-ID: <20230803030800.GJ11377@frogsfrogsfrogs>
References: <20230803112830.21c805a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803112830.21c805a7@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 11:28:30AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the block tree got a conflict in:
> 
>   fs/super.c
> 
> between commit:
> 
>   880b9577855e ("fs: distinguish between user initiated freeze and kernel initiated freeze")
> 
> from the djw-vfs tree and commit:
> 
>   4a8b719f95c0 ("fs: remove emergency_thaw_bdev")
> 
> from the block tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc fs/super.c
> index edc588bca7fc,bc666e7ee1a9..000000000000
> --- a/fs/super.c
> +++ b/fs/super.c
> @@@ -1029,8 -1029,10 +1029,10 @@@ static void do_thaw_all_callback(struc
>   {
>   	down_write(&sb->s_umount);
>   	if (sb->s_root && sb->s_flags & SB_BORN) {
> - 		emergency_thaw_bdev(sb);
> + 		if (IS_ENABLED(CONFIG_BLOCK))
> + 			while (sb->s_bdev && !thaw_bdev(sb->s_bdev))
> + 				pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
>  -		thaw_super_locked(sb);
>  +		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);

Looks correct to me!  Thanks for the heads up.

--D

>   	} else {
>   		up_write(&sb->s_umount);
>   	}


