Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC607BC5A8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbjJGHkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343690AbjJGHkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:40:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F6BB9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 00:40:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BF4C433C7;
        Sat,  7 Oct 2023 07:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696664439;
        bh=QNdP6CzhDYNi4kZoC6kQSoWNk4vaR0KoYKoMwwnfCk0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ZD6BHLVLeAO36MPjUMFZlQ3Ecnh8qiTLRZdfejreYwLcgJmWLK9rR7NhpFwqBrau8
         4oFjd8xleln0VttlWWN0zcesnyf1iDRE59q82+INdEIFVpY2ZpxCBQDubDevB/sCpE
         J+45YDh/Bg8prgEqziRTMus8rCDdN2/KsipcCnJNfSk33of/M6NsoOdE1V8yiVBkrr
         SfG1CMPMpG0/Wbovjo1oy5iKFxY5sj5nJ8WfcjbbNJ4m50CTQN1rMOpj/UllFVvAs2
         ExA8ZJPV6VqYdzEetODqywayAPc1DJEV5uZEjw0bPTz2CBiE/hR2nBbg46URxq1ig9
         xQVMrZL075N0A==
Message-ID: <c70b330a-b5f5-72d9-1190-fe1a6872919d@kernel.org>
Date:   Sat, 7 Oct 2023 15:40:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: stop iterating f2fs_map_block if hole
 exists
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20231003225208.1936359-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231003225208.1936359-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/4 6:52, Jaegeuk Kim wrote:
> Let's avoid unnecessary f2fs_map_block calls to load extents.
> 
>   # f2fs_io fadvise willneed 0 4096 /data/local/tmp/test
> 
>    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 386, start blkaddr = 0x34ac00, len = 0x1400, flags = 2,
>    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 5506, start blkaddr = 0x34c200, len = 0x1000, flags = 2,
>    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 9602, start blkaddr = 0x34d600, len = 0x1200, flags = 2,
>    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 14210, start blkaddr = 0x34ec00, len = 0x400, flags = 2,
>    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 15235, start blkaddr = 0x34f401, len = 0xbff, flags = 2,
>    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 18306, start blkaddr = 0x350200, len = 0x1200, flags = 2
>    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 22915, start blkaddr = 0x351601, len = 0xa7d, flags = 2
>    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 25600, start blkaddr = 0x351601, len = 0x0, flags = 0
>    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 25601, start blkaddr = 0x351601, len = 0x0, flags = 0
>    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 25602, start blkaddr = 0x351601, len = 0x0, flags = 0
>    ...
>    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 1037188, start blkaddr = 0x351601, len = 0x0, flags = 0
>    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 1038206, start blkaddr = 0x351601, len = 0x0, flags = 0
>    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 1039224, start blkaddr = 0x351601, len = 0x0, flags = 0
>    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 2075548, start blkaddr = 0x351601, len = 0x0, flags = 0

Jaegeuk,

Not sure, but it looks it's due to f2fs_precache_extents() will traverse file
w/ range [0, max_file_blocks), since data which exceeds EOF will always be zero,
so it's not necessary to precache its mapping info, so we'd better adjust upper
boundary to i_size rather than max_file_blocks().

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 161826c6e200..2403fd1de5a0 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3270,7 +3270,7 @@ int f2fs_precache_extents(struct inode *inode)
>   		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
>   		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRECACHE);
>   		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> -		if (err)
> +		if (err || !map.m_len)
Well, if there is a hole in the head of file, it may break here rather
than precaching following valid map info.

What about passing parameter offset|len from f2fs_file_fadvise() to
f2fs_precache_extents(), and then precaching mapping info on demand.

Thanks,

>   			return err;
>   
>   		map.m_lblk = m_next_extent;
