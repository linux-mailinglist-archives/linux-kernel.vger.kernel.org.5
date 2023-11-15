Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54187EC674
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344267AbjKOO5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343929AbjKOO5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:57:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838568E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:57:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2EEC433C8;
        Wed, 15 Nov 2023 14:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700060222;
        bh=DbC/RlTt46G/vcvasCDLPs0jylhf+xjP8xII2Uu+weU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dQvpWSOrDccdTNU5lSrfOvUM+KXPgaQi7dD9rDxVqWyXDm8+3FCwtvWBBnkhGd7tb
         E9ys82d1mwVUOpFIU0jD1fAoD9Rfb8zCq8ASsam/ughEJcjPmZ4JidyDpNkFFn0/Tu
         PvC/2GXhU+Js1Rwy9KBlBSvT84+nXc28Hh9tgctemyHC/+wif8Sxx0Tv6yScPwyXbv
         XpI9Dr/3r6TNrAIm/7drMX2N+Pw4KJqrT65mBlvB8UMmUUq5gO4Yw/t/CSn07UEhZK
         tKcmoOGalwISoNvbKitf/4WuU51De92NLjLk3NcIKExqSibc3RU1s0GP3kxeRyS8Wg
         hjURTfRCxS/kA==
Message-ID: <f2d4f2d9-ab6a-de4f-e950-a37502be01d0@kernel.org>
Date:   Wed, 15 Nov 2023 22:56:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: do not put CP_UMOUNT_FLAG for roll
 forward recovery
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20231027154935.1384979-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231027154935.1384979-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/27 23:49, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> If we write CP_UMOUNT_FLAG in fsck, f2fs will not do foll forward recovery

:s/foll/roll

Otherwise, it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> even though it has to do.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fsck/fsck.c       | 3 ++-
>   fsck/mount.c      | 5 ++++-
>   include/f2fs_fs.h | 1 +
>   3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index f1a55db..126458c 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -2526,7 +2526,8 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
>   	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
>   	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
>   	unsigned long long cp_blk_no;
> -	u32 flags = c.alloc_failed ? CP_FSCK_FLAG: CP_UMOUNT_FLAG;
> +	u32 flags = c.alloc_failed ? CP_FSCK_FLAG :
> +			(c.roll_forward ? 0 : CP_UMOUNT_FLAG);
>   	block_t orphan_blks = 0;
>   	block_t cp_blocks;
>   	u32 i;
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 3b02d73..805671c 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -3218,7 +3218,7 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
>   	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
>   	block_t orphan_blks = 0;
>   	unsigned long long cp_blk_no;
> -	u32 flags = CP_UMOUNT_FLAG;
> +	u32 flags = c.roll_forward ? 0 : CP_UMOUNT_FLAG;
>   	int i, ret;
>   	uint32_t crc = 0;
>   
> @@ -3837,6 +3837,9 @@ static int record_fsync_data(struct f2fs_sb_info *sbi)
>   	if (ret)
>   		goto out;
>   
> +	if (c.func == FSCK && inode_list.next != &inode_list)
> +		c.roll_forward = 1;
> +
>   	ret = late_build_segment_manager(sbi);
>   	if (ret < 0) {
>   		ERR_MSG("late_build_segment_manager failed\n");
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index abd5abf..faa5d6b 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -1513,6 +1513,7 @@ struct f2fs_configuration {
>   	unsigned int feature;			/* defined features */
>   	unsigned int quota_bits;	/* quota bits */
>   	time_t fixed_time;
> +	int roll_forward;
>   
>   	/* mkfs parameters */
>   	int fake_seed;
