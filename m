Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA707FAFF5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 03:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjK1CNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1CNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:13:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AE2C3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:13:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD33C433C8;
        Tue, 28 Nov 2023 02:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701137594;
        bh=K00S5Yanj+6jxErg6y5RpnCOWOcJmkZS0lfYvqVWtPA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NdRuarqJvq8z+crp6qrhaQpkPN2NcSRbz5Xu4gr1Kyv5alhOCAAlO6VsauwkTCO6S
         mnkwiYAZBv00rorYRmfU5cnCsojjOZKeLgife0IlNYlJ3noepmE7K0dI7ioiyhO3TJ
         WcZcLIxPbEIq3m8IuTc+ukoNB7jeGKf9hwdQ+AsLPn8vpDrgJCgxGHVFj4GULVCm5x
         /MV824/mn7ORoBJbYT2yWMWs30agJdVNrPnbeaq0FkfTiVMx9YCNg5fygqvcIqayym
         YXhWFwFTw/iskvvATb0aXrLcyszoiuyR7HTZsxQlWTkdTY0rt+kE/IgL7IK+eUNUbi
         nzPtP0Gq0TvFg==
Message-ID: <a9d45834-1ccf-8387-6b90-a88e0cc0772e@kernel.org>
Date:   Tue, 28 Nov 2023 10:13:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] f2fs: show more discard stat by sysfs
Content-Language: en-US
To:     Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
        hongyu.jin@unisoc.com
References: <1700788128-29002-1-git-send-email-zhiguo.niu@unisoc.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1700788128-29002-1-git-send-email-zhiguo.niu@unisoc.com>
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

On 2023/11/24 9:08, Zhiguo Niu wrote:
> The current pending_discard attr just only shows the discard_cmd_cnt
> information, which is not very meaningful. More discard information
> can be shown so that we can check them through sysfs when needed.

What about adding this entry to /sys/fs/f2fs/<dev>/stat/?

> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/sysfs.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 417fae96..f98e680 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -134,13 +134,22 @@ static ssize_t cp_status_show(struct f2fs_attr *a,
>   	return sysfs_emit(buf, "%x\n", le32_to_cpu(F2FS_CKPT(sbi)->ckpt_flags));
>   }
>   
> -static ssize_t pending_discard_show(struct f2fs_attr *a,
> +static ssize_t discard_stat_show(struct f2fs_attr *a,
>   		struct f2fs_sb_info *sbi, char *buf)
>   {
> -	if (!SM_I(sbi)->dcc_info)
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +
> +	if (!dcc)
>   		return -EINVAL;
> -	return sysfs_emit(buf, "%llu\n", (unsigned long long)atomic_read(
> -				&SM_I(sbi)->dcc_info->discard_cmd_cnt));

It's better to keep the old one for any potential user.

> +
> +	return sysfs_emit(buf, "%llu, %llu, %llu, %u\n",
> +			(unsigned long long)atomic_read(
> +				&dcc->discard_cmd_cnt),
> +			(unsigned long long)atomic_read(
> +				&dcc->issued_discard),
> +			(unsigned long long)atomic_read(
> +				&dcc->queued_discard),
> +			dcc->undiscard_blks);
>   }
>   
>   static ssize_t gc_mode_show(struct f2fs_attr *a,
> @@ -1016,7 +1025,7 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
>   F2FS_GENERAL_RO_ATTR(encoding);
>   F2FS_GENERAL_RO_ATTR(mounted_time_sec);
>   F2FS_GENERAL_RO_ATTR(main_blkaddr);
> -F2FS_GENERAL_RO_ATTR(pending_discard);
> +F2FS_GENERAL_RO_ATTR(discard_stat);

It needs to adjust Documentation/ABI/testing/sysfs-fs-f2fs.

Thanks,

>   F2FS_GENERAL_RO_ATTR(gc_mode);
>   #ifdef CONFIG_F2FS_STAT_FS
>   F2FS_GENERAL_RO_ATTR(moved_blocks_background);
> @@ -1074,7 +1083,7 @@ static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
>   	ATTR_LIST(discard_urgent_util),
>   	ATTR_LIST(discard_granularity),
>   	ATTR_LIST(max_ordered_discard),
> -	ATTR_LIST(pending_discard),
> +	ATTR_LIST(discard_stat),
>   	ATTR_LIST(gc_mode),
>   	ATTR_LIST(ipu_policy),
>   	ATTR_LIST(min_ipu_util),
