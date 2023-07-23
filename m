Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157AA75E220
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 15:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjGWNkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 09:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 09:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E654CA
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 06:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30B1160C80
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 13:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16372C433C8;
        Sun, 23 Jul 2023 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690119606;
        bh=2qiqpZSaIvnpVHGoHfxzcoxZzo7pPhHH90rg5KQtN4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1yo4Fl2HH7IPz/IInGuugHIsALAAk24qu2ZxhUeKLg3LvE5RoNUq1Xb52PD/KYhPd
         GVJ0UPQfZjdRQm7uK5t2saiCcidQNRlMG2UZ9YWSvJ1TCVPAXS34dWXtTfN8gFvg5d
         xGHUjup09WZQ6IWk2ps6FLlnU5wvPOtkwBYxAUPg=
Date:   Sun, 23 Jul 2023 15:40:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aleksei Filippov <halip0503@gmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org,
        syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] jfs: validate max amount of blocks before allocation.
Message-ID: <2023072335-penniless-coleslaw-3aac@gregkh>
References: <2023072318-semantic-payee-0162@gregkh>
 <20230723132959.4945-1-halip0503@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723132959.4945-1-halip0503@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 04:29:59PM +0300, Aleksei Filippov wrote:
> From: Alexei Filippov <halip0503@gmail.com>
> 
> The lack of checking bmp->db_max_freebud in extBalloc() can lead to
> shift out of bounds, so this patch prevents undefined behavior, because
> bmp->db_max_freebud == -1 only if there is no free space.
> 
> Signed-off-by: Aleksei Filippov <halip0503@gmail.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-and-tested-by: syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=01abadbd6ae6a08b1f1987aa61554c6b3ac19ff2
> ---
>  fs/jfs/jfs_extent.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
> index ae99a7e232ee..a82751e6c47f 100644
> --- a/fs/jfs/jfs_extent.c
> +++ b/fs/jfs/jfs_extent.c
> @@ -311,6 +311,11 @@ extBalloc(struct inode *ip, s64 hint, s64 * nblocks, s64 * blkno)
>  	 * blocks in the map. in that case, we'll start off with the
>  	 * maximum free.
>  	 */
> +
> +	/* give up if no space left */
> +	if (bmp->db_maxfreebud == -1)
> +		return -ENOSPC;
> +
>  	max = (s64) 1 << bmp->db_maxfreebud;
>  	if (*nblocks >= max && *nblocks > nbperpage)
>  		nb = nblks = (max > nbperpage) ? max : nbperpage;
> -- 
> 2.25.1
> 
> Fix commit message.

The --- information for the version goes below the first --- line, not
the last.  Look at the examples on the mailing lists for the proper
format.

thanks,

greg k-h
