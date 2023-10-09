Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B527BE8C1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377263AbjJIR4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376891AbjJIR4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:56:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB87E94
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:56:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC9EC433C7;
        Mon,  9 Oct 2023 17:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696874203;
        bh=4MAFR8eRn/jRjp4WwCXLLtnADd0TxOn+fdtPOWOfo7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V2sw+VQv8f0ozr2rncMF7mI6tyJRl5QaqR2TC6GSo7A46dLZWJfthNAfmMJPf2pzs
         LnkTwKxODVo0wJPr9zWjy/9DzNSr1GdbFBxM49MC9kbCTGnS2gVAUmxNTrKwwCFjez
         5Wzcx/ZFFu6UD1dBBwH9OLFFgSOvBazQLPUZodcV2Y1XAnrdh5i61qGvluVxkrAgvb
         Gh3392etim9H6xDIBoo83BngdlVLuBPzwR3kXPM40jG2XyuXtJ8Y9hyjnY/8Kl7cIm
         ELuUvZRTewhsRPf95y1sFBxzaD6Ez73MZGX5BugS6xiEXOoBKvUlk5ttjEjv7mAHPh
         YQXwK1lGvVZEA==
Date:   Mon, 9 Oct 2023 10:56:41 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: stop iterating f2fs_map_block if hole
 exists
Message-ID: <ZSQ-2aH7qN_ILfEg@google.com>
References: <20231003225208.1936359-1-jaegeuk@kernel.org>
 <c70b330a-b5f5-72d9-1190-fe1a6872919d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c70b330a-b5f5-72d9-1190-fe1a6872919d@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07, Chao Yu wrote:
> On 2023/10/4 6:52, Jaegeuk Kim wrote:
> > Let's avoid unnecessary f2fs_map_block calls to load extents.
> > 
> >   # f2fs_io fadvise willneed 0 4096 /data/local/tmp/test
> > 
> >    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 386, start blkaddr = 0x34ac00, len = 0x1400, flags = 2,
> >    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 5506, start blkaddr = 0x34c200, len = 0x1000, flags = 2,
> >    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 9602, start blkaddr = 0x34d600, len = 0x1200, flags = 2,
> >    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 14210, start blkaddr = 0x34ec00, len = 0x400, flags = 2,
> >    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 15235, start blkaddr = 0x34f401, len = 0xbff, flags = 2,
> >    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 18306, start blkaddr = 0x350200, len = 0x1200, flags = 2
> >    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 22915, start blkaddr = 0x351601, len = 0xa7d, flags = 2
> >    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 25600, start blkaddr = 0x351601, len = 0x0, flags = 0
> >    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 25601, start blkaddr = 0x351601, len = 0x0, flags = 0
> >    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 25602, start blkaddr = 0x351601, len = 0x0, flags = 0
> >    ...
> >    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 1037188, start blkaddr = 0x351601, len = 0x0, flags = 0
> >    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 1038206, start blkaddr = 0x351601, len = 0x0, flags = 0
> >    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 1039224, start blkaddr = 0x351601, len = 0x0, flags = 0
> >    f2fs_map_blocks: dev = (254,51), ino = 85845, file offset = 2075548, start blkaddr = 0x351601, len = 0x0, flags = 0
> 
> Jaegeuk,
> 
> Not sure, but it looks it's due to f2fs_precache_extents() will traverse file
> w/ range [0, max_file_blocks), since data which exceeds EOF will always be zero,
> so it's not necessary to precache its mapping info, so we'd better adjust upper
> boundary to i_size rather than max_file_blocks().
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/file.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 161826c6e200..2403fd1de5a0 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -3270,7 +3270,7 @@ int f2fs_precache_extents(struct inode *inode)
> >   		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
> >   		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRECACHE);
> >   		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > -		if (err)
> > +		if (err || !map.m_len)
> Well, if there is a hole in the head of file, it may break here rather
> than precaching following valid map info.
> 
> What about passing parameter offset|len from f2fs_file_fadvise() to
> f2fs_precache_extents(), and then precaching mapping info on demand.

I'd rather stop reading metadata if it meets a hole within i_size, since this
gives benefits when reading the entire non-hole case, FWIW. Rather than that,
I think generic readahead flow can hide the metadata loading.

> 
> Thanks,
> 
> >   			return err;
> >   		map.m_lblk = m_next_extent;
