Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5BF80E0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345681AbjLLBjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjLLBjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:39:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE54CF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:39:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47166C433C8;
        Tue, 12 Dec 2023 01:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702345146;
        bh=TeIu+bH7xeWWjKF8B1+cGXjZicTzj7xMKbF2/jnTZ2M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=loDQXDK05uWNQeoH1AEDOy1imWruiJEWZStOtDJukZcRHzpIv/S7837qsuctYeuPP
         +MaVlDRQlGG5WLQJX1HuUP61rFck97nhULJSlHq91KJFG0x1IaN3WahKFFtbCxcF06
         jL6hG5hc8Nvg+C4Tp4uteWYfKtTpieabVw3TYKx+n5oEODrfML2KuVnDQ/4gyq+5dp
         Y9ERMajnwbgdYgtRm2/egQNZETX97gs/zr98kt/sYDOt+cMyGh0u8RSpZiJTF+ohYu
         9Yn2qpLxjpoQYe2xOtd8+PUDA875+V0oWyOXDuLlhmh5hH7/9ITlLW62PktpgitH5R
         Xu3H5aKhkalXg==
Message-ID: <3478e715-3fe2-4686-aa9d-8fa2f4083dac@kernel.org>
Date:   Tue, 12 Dec 2023 09:39:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix to check return value of
 f2fs_recover_xattr_data
To:     Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
        ke.wang@unisoc.com
References: <1702025433-5860-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1702025433-5860-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/8 16:50, Zhiguo Niu wrote:
> Should check return value of f2fs_recover_xattr_data in
> __f2fs_setxattr rather than doing invalid retry if error happen.
> 
> Also just do set_page_dirty in f2fs_recover_xattr_data when
> page is changed really.
> 
> Fixes: 50a472bbc79f ("f2fs: do not return EFSCORRUPTED, but try to run online repair")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/node.c  |  6 +++---
>   fs/f2fs/xattr.c | 12 +++++++-----
>   2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index e50a093..93bf724 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2754,11 +2754,11 @@ int f2fs_recover_xattr_data(struct inode *inode, struct page *page)
>   	f2fs_update_inode_page(inode);
>   
>   	/* 3: update and set xattr node page dirty */
> -	if (page)
> +	if (page) {
>   		memcpy(F2FS_NODE(xpage), F2FS_NODE(page),
>   				VALID_XATTR_BLOCK_SIZE);
> -
> -	set_page_dirty(xpage);
> +		set_page_dirty(xpage);
> +	}
>   	f2fs_put_page(xpage, 1);
>   
>   	return 0;
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 47e88b4..de92891 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -660,11 +660,13 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>   	here = __find_xattr(base_addr, last_base_addr, NULL, index, len, name);
>   	if (!here) {
>   		if (!F2FS_I(inode)->i_xattr_nid) {
> -			f2fs_notice(F2FS_I_SB(inode),
> -				"recover xattr in inode (%lu)", inode->i_ino);
> -			f2fs_recover_xattr_data(inode, NULL);
> -			kfree(base_addr);
> -			goto retry;
> +			error = f2fs_recover_xattr_data(inode, NULL);

How about printing here?

f2fs_notice(F2FS_I_SB(inode),
	"recover xattr in inode (%lu), error: %d", inode->i_ino, error);

Thanks,

> +			if (!error) {
> +				f2fs_notice(F2FS_I_SB(inode),
> +					"recover xattr in inode (%lu)", inode->i_ino);
> +				kfree(base_addr);
> +				goto retry;
> +			}
>   		}
>   		f2fs_err(F2FS_I_SB(inode), "set inode (%lu) has corrupted xattr",
>   								inode->i_ino);
