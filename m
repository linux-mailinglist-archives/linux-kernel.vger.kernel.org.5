Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC8C7E41F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjKGOjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjKGOjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:39:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C05183
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:39:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86140C433C7;
        Tue,  7 Nov 2023 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699367978;
        bh=pvLfmhyTPv0yZa8MpxDOVBvvq48uuUUWcsn2a9XiUrk=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=gvZqUZQ5ZP7y2V5NzTJQ8nko7/3ZfNKnY+vWtEb2wkOtzfatxLHzM7WSYrqqOlheY
         8sers6zfZgier7VHx7mysRb1O4jbIVOeTTDo016M2XRPd3MIEztyPEeqvGUeet6NYt
         6ugsTXku985ejMqjPnK3L8DGsvYeA3Bslo++6hq5cNoS8XDwxnOpzwvVtFKfHRM3Pk
         UEJI5FyGMYos1GRuAXNnzJGYCWI5CmNcOfnTbPWWEszjVk8VM/BqJ8JnO0pBSsWHjl
         Wiu6Y29Uk9/TWAzUrgytf6CGjV5x56H0OIavpAC0o9pcdo17oGjq+C5WxEBRl+ro7B
         nffU5CSiMIV+g==
Message-ID: <c181256e-9f6e-d43e-4d02-a7d8d5286d56@kernel.org>
Date:   Tue, 7 Nov 2023 22:39:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Wu Bo <wubo.oduw@gmail.com>
References: <20231030094024.263707-1-bo.wu@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/1] f2fs: fix fallocate failed under pinned block
 situation
In-Reply-To: <20231030094024.263707-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/30 17:40, Wu Bo wrote:
> If GC victim has pinned block, it can't be recycled.
> And if GC is foreground running, after many failure try, the pinned file
> is expected to be clear pin flag. To enable the section be recycled.
> 
> But when fallocate trigger FG_GC, GC can never recycle the pinned
> section. Because GC will go to stop before the failure try meet the threshold:
> 	if (has_enough_free_secs(sbi, sec_freed, 0)) {
> 		if (!gc_control->no_bg_gc &&
> 		    total_sec_freed < gc_control->nr_free_secs)
> 			goto go_gc_more;
> 		goto stop;
> 	}
> 
> So when fallocate trigger FG_GC, at least recycle one.

Hmm... it may break pinfile's semantics at least on one pinned file?
In this case, I prefer to fail fallocate() rather than unpinning file,
in order to avoid leaving invalid LBA references of unpinned file held
by userspace.

Thoughts?

Thanks,

> 
> This issue can be reproduced by filling f2fs space as following layout.
> Every segment has one block is pinned:
> +-+-+-+-+-+-+-----+-+
> | | |p| | | | ... | | seg_n
> +-+-+-+-+-+-+-----+-+
> +-+-+-+-+-+-+-----+-+
> | | |p| | | | ... | | seg_n+1
> +-+-+-+-+-+-+-----+-+
> ...
> +-+-+-+-+-+-+-----+-+
> | | |p| | | | ... | | seg_n+k
> +-+-+-+-+-+-+-----+-+
> 
> And following are steps to reproduce this issue:
> dd if=/dev/zero of=./f2fs_pin.img bs=2M count=1024
> mkfs.f2fs f2fs_pin.img
> mkdir f2fs
> mount f2fs_pin.img ./f2fs
> cd f2fs
> dd if=/dev/zero of=./large_padding bs=1M count=1760
> ./pin_filling.sh
> rm padding*
> sync
> touch fallocate_40m
> f2fs_io pinfile set fallocate_40m
> fallocate -l 41943040 fallocate_40m
> 
> fallocate always fail with EAGAIN even there has enough free space.
> 
> 'pin_filling.sh' is:
> count=1
> while :
> do
>      # filling the seg space
>      for i in {1..511}:
>      do
>          name=padding_$count-$i
>          echo write $name
>          dd if=/dev/zero of=./$name bs=4K count=1 > /dev/null 2>&1
>          if [ $? -ne 0 ]; then
>                  exit 0
>          fi
>      done
>      sync
> 
>      # pin one block in a segment
>      name=pin_file$count
>      dd if=/dev/zero of=./$name bs=4K count=1 > /dev/null 2>&1
>      sync
>      f2fs_io pinfile set $name
>      count=$(($count + 1))
> done
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>   fs/f2fs/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ca5904129b16..e8a13616543f 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1690,7 +1690,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
>   			.init_gc_type = FG_GC,
>   			.should_migrate_blocks = false,
>   			.err_gc_skipped = true,
> -			.nr_free_secs = 0 };
> +			.nr_free_secs = 1 };
>   	pgoff_t pg_start, pg_end;
>   	loff_t new_size;
>   	loff_t off_end;
