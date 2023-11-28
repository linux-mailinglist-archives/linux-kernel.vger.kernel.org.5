Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679757FB08A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjK1Cma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbjK1Cm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:42:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120E018E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:42:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D72DC433C8;
        Tue, 28 Nov 2023 02:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701139355;
        bh=2dvgtHHX3mS1iRK8Z6Pf8GW437Nns93TnuD/Y1DQVW8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VIhrBaLpqmLcDjVkkPKkX8uNUl5Gt5g1ZFcbeTH9mU/L1qlDNttqRFiFI+H0dpLS2
         zWTVQbv42GLLEkEShGP1u6nxjocAPGvXTmjLnTx0YVvvFPU+Z8mInF+IthuKBAKI55
         9Gh4irLY8uNY2iJJpKF8kkdeha+1Smh67pIFVs2a2Q7LW+xgMp354UhYHBw+JLxMbe
         1DmH6FSDD3/wQEznc2F/r9sdfTJxOo7+obaDQxMgtQTKWSq3dJaYwF/Z5tRYpHHIII
         5XihRSyWDtHZVbZjwOjqHwHCLhQI3GDXDyMTwFTIUJLfvYEEcJjNciMU68icwzJh6j
         /sbjhEF2sI7RQ==
Message-ID: <bcacb482-5496-0a86-2e6a-a58d310cb0dc@kernel.org>
Date:   Tue, 28 Nov 2023 10:42:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] f2fs: add support for an i_version counter
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20231120095410.3604801-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231120095410.3604801-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/20 17:54, Yangtao Li wrote:
> NFSv4 mandates a change attribute to avoid problems with timestamp
> granularity, which Linux implements using the i_version counter. This is
> particularly important when the underlying filesystem is fast.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/f2fs.h  | 1 +
>   fs/f2fs/inode.c | 1 +
>   fs/f2fs/super.c | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9043cedfa12b..68fd2ef35104 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -28,6 +28,7 @@
>   
>   #include <linux/fscrypt.h>
>   #include <linux/fsverity.h>
> +#include <linux/iversion.h>
>   
>   struct pagevec;
>   
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 560bfcad1af2..2604fa4a0704 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -32,6 +32,7 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
>   	if (f2fs_inode_dirtied(inode, sync))
>   		return;
>   
> +	inode_inc_iversion(inode);

For the case f2fs is not used by nfs as backend storage, there will be overhead for
iversion update logic.

So what about introducing a new mount option to enable the iversion functionality,
and disabling it by default?

Thanks,

>   	mark_inode_dirty_sync(inode);
>   }
>   
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 033af907c3b1..2bddccd47e3a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2204,6 +2204,7 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
>   	set_opt(sbi, MERGE_CHECKPOINT);
>   	F2FS_OPTION(sbi).unusable_cap = 0;
>   	sbi->sb->s_flags |= SB_LAZYTIME;
> +	sbi->sb->s_flags |= SB_I_VERSION;
>   	if (!f2fs_is_readonly(sbi))
>   		set_opt(sbi, FLUSH_MERGE);
>   	if (f2fs_sb_has_blkzoned(sbi))
