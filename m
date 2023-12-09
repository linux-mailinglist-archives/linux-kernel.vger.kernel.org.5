Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA0A80B35D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 10:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjLIJHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 04:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjLIJHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 04:07:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C6AEB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 01:07:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0734C433C7;
        Sat,  9 Dec 2023 09:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702112867;
        bh=Te1ZPTeA2oHIZ2byR91guQ/ayXHNpwpIAlanhv07ZOU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RRPwawK4rvpOV2pZwrJeqH0X3XNptKQJkzNTH6wbV+i0ig+3DTK+UHREL6SbJYm6T
         kkeRVJUfRxVZt8MKkMFYw+0c+pZG7ky8erSmu9iBRV7lptUJwE2JLO/AvlTtt4c3Rt
         dR3kSiOVLELPHtYXGUFagJIKrdvmDrnEvfZRfuxr3ZUPVnuZIkzWryYhYedMi9sTRZ
         qQFs+h1IphJVvy4ay00aDrwcQLalnB/AesBq+nmb7CgsFKA+zGsTNPnrijvrKOcgxx
         vhV1inmCaO8iSIjY7/7Qw0M3GWQbjjgsjXWjfq/18uUsvKtDfKPuwuPFzlSYXnLB4Z
         OSAQTGir56Nng==
Message-ID: <1332b650-0415-47a0-b439-053060c869f1@kernel.org>
Date:   Sat, 9 Dec 2023 17:07:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: compress: do cleanup in
 f2fs_truncate_partial_cluster()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20231130092310.1297336-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231130092310.1297336-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/30 17:23, Yangtao Li wrote:
> Remove unnecessary code logic.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/compress.c | 30 +++++++++++++-----------------
>   1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 36e5dab6baae..de55c266509a 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1170,7 +1170,9 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
>   	int log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
>   	pgoff_t start_idx = from >> (PAGE_SHIFT + log_cluster_size) <<
>   							log_cluster_size;
> -	int err;
> +	struct page **rpages = fsdata;

fsdata is NULL here.

Thanks,

> +	int cluster_size = F2FS_I(inode)->i_cluster_size;
> +	int err, i;
>   
>   	err = f2fs_is_compressed_cluster(inode, start_idx);
>   	if (err < 0)
> @@ -1190,25 +1192,19 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
>   	if (err <= 0)
>   		return err;
>   
> -	if (err > 0) {
> -		struct page **rpages = fsdata;
> -		int cluster_size = F2FS_I(inode)->i_cluster_size;
> -		int i;
> -
> -		for (i = cluster_size - 1; i >= 0; i--) {
> -			loff_t start = rpages[i]->index << PAGE_SHIFT;
> +	for (i = cluster_size - 1; i >= 0; i--) {
> +		loff_t start = rpages[i]->index << PAGE_SHIFT;
>   
> -			if (from <= start) {
> -				zero_user_segment(rpages[i], 0, PAGE_SIZE);
> -			} else {
> -				zero_user_segment(rpages[i], from - start,
> -								PAGE_SIZE);
> -				break;
> -			}
> +		if (from <= start) {
> +			zero_user_segment(rpages[i], 0, PAGE_SIZE);
> +		} else {
> +			zero_user_segment(rpages[i], from - start,
> +							PAGE_SIZE);
> +			break;
>   		}
> -
> -		f2fs_compress_write_end(inode, fsdata, start_idx, true);
>   	}
> +
> +	f2fs_compress_write_end(inode, fsdata, start_idx, true);
>   	return 0;
>   }
>   
