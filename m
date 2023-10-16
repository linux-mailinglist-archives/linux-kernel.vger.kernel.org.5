Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48B07C9FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjJPGdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjJPGdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:33:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1092197
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 23:33:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FD4C433C7;
        Mon, 16 Oct 2023 06:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697437992;
        bh=+Owi4dHO/M4f1OwrwqDow7OigSWRG5/BMlw4FIabhvQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=muaGOCdbAeE393slNe/CMYYTTkBMGihz7xw+znVrPhlxMRVElmU+aXI6BBXN+/MM9
         GJ+WAD+ya4zUG7HPfjmwwd1fq/l8Z8KVzOcjuBJVlTRcyoym2qeYm/Q6FmsA3gnfsz
         lGaVLbUE0+KU+Xt+J9exl16ErejhDqC+3GKgaD9FdWgv/4orpCs84Rx17svhv6efk+
         RTSgK1e9GH3zGlL84Llm87A5wstZQymkXmePBd56wa52Q11LRCxIfupmSDJRrZcBCd
         8tDDaNzRgvypEO45lJ6e7zNBDTVr1KS8GmUOvubxtqeFIW1qI4tBJ6dkj4dcw9kuEp
         0WSQx+TysgD2Q==
Message-ID: <b16ea8fb-b3f2-4ae9-c543-cd84e0f3fa48@kernel.org>
Date:   Mon, 16 Oct 2023 14:33:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: initialize allocated node area
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20231013222453.240961-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231013222453.240961-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/14 6:24, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Need to initialize allocated node areas after memory allocation.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fsck/node.c       | 1 +
>   include/f2fs_fs.h | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/fsck/node.c b/fsck/node.c
> index 3761470..6508340 100644
> --- a/fsck/node.c
> +++ b/fsck/node.c
> @@ -127,6 +127,7 @@ block_t new_node_block(struct f2fs_sb_info *sbi,
>   
>   	node_blk = calloc(BLOCK_SZ, 1);

calloc() has already initialized memory w/ zero, it doesn't need to reinitialize
it again?

>   	ASSERT(node_blk);
> +	memset(node_blk, 0, BLOCK_SZ);
>   
>   	F2FS_NODE_FOOTER(node_blk)->nid = cpu_to_le32(dn->nid);
>   	F2FS_NODE_FOOTER(node_blk)->ino = F2FS_NODE_FOOTER(f2fs_inode)->ino;
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index 3c7451c..7e22278 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -1826,6 +1826,8 @@ static inline void show_version(const char *prog)
>   static inline void f2fs_init_inode(struct f2fs_super_block *sb,
>   		struct f2fs_node *raw_node, nid_t ino, time_t mtime, mode_t mode)
>   {
> +	memset(raw_node, 0, F2FS_BLKSIZE);

Ditto,

Thanks,

> +
>   	F2FS_NODE_FOOTER(raw_node)->nid = cpu_to_le32(ino);
>   	F2FS_NODE_FOOTER(raw_node)->ino = cpu_to_le32(ino);
>   	F2FS_NODE_FOOTER(raw_node)->cp_ver = cpu_to_le64(1);
