Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEF5772FF5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjHGTzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjHGTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:55:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2442210F8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:55:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7BD0621BB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16EFC433C8;
        Mon,  7 Aug 2023 19:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691438131;
        bh=B7bvlj514nf25uE0E4eqZHoMG7i/L04k6cyUl8PvZ24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+lJXacWUiobGozvqdrEAMYiOMt8R4+yBBZqy6SWXHdTeqrHM6WAPMzkCsF+Zw1iR
         GhIULEGMS/NZV7dDG+ySn2m6PG4Ug/lhIfzDDp76er1dIodjsgrPyxKfGBQhIoFnY8
         5Fzsjzp2yQzvxTEslzqqi0A0FtGsWFPDMtZ5sq+5AfNaBrL5RXtyweezGgLzY4BBTO
         LE54naW/GD3fv9WHwUG9ZlSCQK/I69H3WHUeQiEPlEo/XzJKiSw9eBSarKIdKlEgDe
         UKLcZlyHzvBtOtdsAnoam/4DiqNjLvXCxooNBavd5tlohXpnLEg7Y+1DaLJHSBrm13
         Oco9qHi/srrBA==
Date:   Mon, 7 Aug 2023 12:55:29 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Daejun Park <daejun7.park@samsung.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: do not issue small discard commands
 during checkpoint
Message-ID: <ZNFMMT962olIl7y9@google.com>
References: <ZKWovWZDiHjMavtB@google.com>
 <cadfb8d7-f5d0-a3ec-cafb-a0c06ad7d290@kernel.org>
 <ZK2FT9CUjxXvQ2K5@google.com>
 <330c96f7-fbad-dd17-6368-f1378b3b5375@kernel.org>
 <ZK7M6EkLkV8UbqUl@google.com>
 <87acf602-1587-0615-909d-6e60c66c3cda@kernel.org>
 <ZLrpMAaOkmrKQFv+@google.com>
 <5e5f830b-1b13-4893-fbb0-4c7e99ec9f32@kernel.org>
 <ZM1lJPQcV+FjGnaI@google.com>
 <bab7ab2f-b02c-a547-b4dc-7f26919ee019@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bab7ab2f-b02c-a547-b4dc-7f26919ee019@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07, Chao Yu wrote:
> On 2023/8/5 4:52, Jaegeuk Kim wrote:
> > On 07/25, Chao Yu wrote:
> > > On 2023/7/22 4:23, Jaegeuk Kim wrote:
> > > > On 07/13, Chao Yu wrote:
> > > > > On 2023/7/12 23:55, Jaegeuk Kim wrote:
> > > > > > On 07/12, Chao Yu wrote:
> > > > > > > On 2023/7/12 0:37, Jaegeuk Kim wrote:
> > > > > > > > On 07/06, Chao Yu wrote:
> > > > > > > > > On 2023/7/6 1:30, Jaegeuk Kim wrote:
> > > > > > > > > > On 07/04, Chao Yu wrote:
> > > > > > > > > > > On 2023/7/4 18:53, Jaegeuk Kim wrote:
> > > > > > > > > > > > On 07/03, Chao Yu wrote:
> > > > > > > > > > > > > On 2023/6/15 0:10, Jaegeuk Kim wrote:
> > > > > > > > > > > > > > If there're huge # of small discards, this will increase checkpoint latency
> > > > > > > > > > > > > > insanely. Let's issue small discards only by trim.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > >         Change log from v1:
> > > > > > > > > > > > > >          - move the skip logic to avoid dangling objects
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > >         fs/f2fs/segment.c | 2 +-
> > > > > > > > > > > > > >         1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > > > > > > > > > > > > index 8c7af8b4fc47..0457d620011f 100644
> > > > > > > > > > > > > > --- a/fs/f2fs/segment.c
> > > > > > > > > > > > > > +++ b/fs/f2fs/segment.c
> > > > > > > > > > > > > > @@ -2193,7 +2193,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
> > > > > > > > > > > > > >         			len = next_pos - cur_pos;
> > > > > > > > > > > > > >         			if (f2fs_sb_has_blkzoned(sbi) ||
> > > > > > > > > > > > > > -			    (force && len < cpc->trim_minlen))
> > > > > > > > > > > > > > +					!force || len < cpc->trim_minlen)
> > > > > > > > > > > > > >         				goto skip;
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Sorry for late reply.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > We have a configuration for such case, what do you think of setting
> > > > > > > > > > > > > max_small_discards to zero? otherwise, w/ above change, max_small_discards
> > > > > > > > > > > > > logic may be broken?
> > > > > > > > > > > > > 
> > > > > > > > > > > > > What:           /sys/fs/f2fs/<disk>/max_small_discards
> > > > > > > > > > > > > Date:           November 2013
> > > > > > > > > > > > > Contact:        "Jaegeuk Kim" <jaegeuk.kim@samsung.com>
> > > > > > > > > > > > > Description:    Controls the issue rate of discard commands that consist of small
> > > > > > > > > > > > >                       blocks less than 2MB. The candidates to be discarded are cached until
> > > > > > > > > > > > >                       checkpoint is triggered, and issued during the checkpoint.
> > > > > > > > > > > > >                       By default, it is disabled with 0.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Or, if we prefer to disable small_discards by default, what about below change:
> > > > > > > > > > > > 
> > > > > > > > > > > > I think small_discards is fine, but need to avoid long checkpoint latency only.
> > > > > > > > > > > 
> > > > > > > > > > > I didn't get you, do you mean we can still issue small discard by
> > > > > > > > > > > fstrim, so small_discards functionality is fine?
> > > > > > > > > > 
> > > > > > > > > > You got the point.
> > > > > > > > > 
> > > > > > > > > Well, actually, what I mean is max_small_discards sysfs entry's functionality
> > > > > > > > > is broken. Now, the entry can not be used to control number of small discards
> > > > > > > > > committed by checkpoint.
> > > > > > > > 
> > > > > > > > Could you descrbie this problem first?
> > > > > > > 
> > > > > > > Oh, alright, actually, I've described this problem literally, but maybe it's not
> > > > > > > clear, let me give some examples as below:
> > > > > > > 
> > > > > > > echo 0 > /sys/fs/f2fs/vdb/max_small_discards
> > > > > > > xfs_io -f /mnt/f2fs/file -c "pwrite 0 2m" -c "fsync"
> > > > > > > xfs_io /mnt/f2fs/file -c "fpunch 0 4k"
> > > > > > > sync
> > > > > > > cat /proc/fs/f2fs/vdb/discard_plist_info |head -2
> > > > > > > 
> > > > > > > echo 100 > /sys/fs/f2fs/vdb/max_small_discards
> > > > > > > rm /mnt/f2fs/file
> > > > > > > xfs_io -f /mnt/f2fs/file -c "pwrite 0 2m" -c "fsync"
> > > > > > > xfs_io /mnt/f2fs/file -c "fpunch 0 4k"
> > > > > > > sync
> > > > > > > cat /proc/fs/f2fs/vdb/discard_plist_info |head -2
> > > > > > > 
> > > > > > > Before the patch:
> > > > > > > 
> > > > > > > Discard pend list(Show diacrd_cmd count on each entry, .:not exist):
> > > > > > >      0         .       .       .       .       .       .       .       .
> > > > > > > 
> > > > > > > Discard pend list(Show diacrd_cmd count on each entry, .:not exist):
> > > > > > >      0         3       1       .       .       .       .       .       .
> > > > > > > 
> > > > > > > After the patch:
> > > > > > > Discard pend list(Show diacrd_cmd count on each entry, .:not exist):
> > > > > > >      0         .       .       .       .       .       .       .       .
> > > > > > > 
> > > > > > > Discard pend list(Show diacrd_cmd count on each entry, .:not exist):
> > > > > > >      0         .       .       .       .       .       .       .       .
> > > > > > > 
> > > > > > > So, now max_small_discards can not be used to control small discard number
> > > > > > > cached by checkpoint.
> > > > > 
> > > > > Let me explain more:
> > > > > 
> > > > > Previously, we have two mechanisms to cache & submit small discards:
> > > > > 
> > > > > a) set max small discard number in /sys/fs/f2fs/vdb/max_small_discards, and checkpoint
> > > > > will cache small discard candidates w/ configured maximum number.
> > > > > 
> > > > > b) call FITRIM ioctl, also, checkpoint in f2fs_trim_fs() will cache small discard
> > > > > candidates w/ configured discard granularity, but w/o limitation of number. FSTRIM
> > > > > interface is asynchronized, so it won't submit discard directly.
> > > > > 
> > > > > Finally, discard thread will submit them in background periodically.
> > > > > 
> > > > > So what I mean is the mechanism a) is broken, since no matter how we configure the
> > > > > sysfs entry /sys/fs/f2fs/vdb/max_small_discards, checkpoint will not cache small
> > > > > discard candidates any more.
> > > > 
> > > > Ok, it seems what I encountered before was adding this small discard even
> > > > after issuing it by checkpoint. Thoughts?
> > > 
> > > Do you mean: in f2fs_clear_prefree_segments(), small discard may overlap
> > > segment granularity discard?
> > 
> > I didn't dig enough tho, don't think so. Somehow I got a loop as below which
> > said the same LBA was issued and added back repeatedly, not seen this short log
> > unfortunately.
> > 
> > > 
> > > e.g.
> > > - f2fs_clear_prefree_segments
> > >   - f2fs_issue_discard(0, 512)  --- segment granularity discard
> > >   - f2fs_issue_discard(0, 1)  --- small discard
> > >   - f2fs_issue_discard(5, 1)  --- small discard
> > > 
> > > Thanks,
> 
> [snip]
> 
> > > >    f2fs_discard-25-752     [003] .....  9744.173111: f2fs_issue_discard: dev = (254,51), blkstart = 0x18c0ca, blklen = 0x1
> > > >    f2fs_discard-25-752     [004] .....  9744.175348: f2fs_remove_discard: dev = (254,51), blkstart = 0x18c0ca, blklen = 0x1
> 
> I don't see any loop via above log, am I missing something?
> 
> The traces were printed in below call paths, and it printed the same LBAs as
> expected?

I said the log was cut to show the loop enoughly. I'll try to reproduce this
later locally.

> 
> - issue_discard_thread
>  - __issue_discard_cmd
>   - __submit_discard_cmd
>    - trace_f2fs_issue_discard
> 9744.173111: f2fs_issue_discard: dev = (254,51), blkstart = 0x18c0ca, blklen = 0x1
>  - __wait_all_discard_cmd
>   - __wait_discard_cmd_range
>    - __remove_discard_cmd
>     - trace_f2fs_remove_discard
> 9744.175348: f2fs_remove_discard: dev = (254,51), blkstart = 0x18c0ca, blklen = 0x1
> 
> Thanks,
> 
> > > > 
> > > > > 
> > > > > So, it needs to fix max_small_discards sysfs functionality? or just drop the
> > > > > functionality?
> > > > > 
> > > > > > 
> > > > > > Since we do not submit small discards anymore during checkpoint. Why not relying
> > > > > > on the discard thread to issue them?
> > > > > 
> > > > > Sorry, I'm not sure I get your point, do you mean max_small_discards functionality
> > > > > is obsoleted, so it recommended to use fstrim to cache & submit small discards?
> > > > > 
> > > > > Let me know, if I'm missing something or misunderstanding the point.
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > 
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > I think there is another way to achieve "avoid long checkpoint latency caused
> > > > > > > > > by committing huge # of small discards", the way is we can set max_small_discards
> > > > > > > > > to small value or zero, w/ such configuration, it will take checkpoint much less
> > > > > > > > > time or no time to committing small discard due to below control logic:
> > > > > > > > > 
> > > > > > > > > f2fs_flush_sit_entries()
> > > > > > > > > {
> > > > > > > > > ...
> > > > > > > > > 			if (!(cpc->reason & CP_DISCARD)) {
> > > > > > > > > 				cpc->trim_start = segno;
> > > > > > > > > 				add_discard_addrs(sbi, cpc, false);
> > > > > > > > > 			}
> > > > > > > > > ...
> > > > > > > > > }
> > > > > > > > > 
> > > > > > > > > add_discard_addrs()
> > > > > > > > > {
> > > > > > > > > ...
> > > > > > > > > 	while (force || SM_I(sbi)->dcc_info->nr_discards <=
> > > > > > > > > 				SM_I(sbi)->dcc_info->max_discards) {
> > > > > > > > > 
> > > > > > > > > It will break the loop once nr_discards is larger than max_discards, if
> > > > > > > > > max_discards is set to zero, checkpoint won't take time to handle small discards.
> > > > > > > > > 
> > > > > > > > > ...
> > > > > > > > > 		if (!de) {
> > > > > > > > > 			de = f2fs_kmem_cache_alloc(discard_entry_slab,
> > > > > > > > > 						GFP_F2FS_ZERO, true, NULL);
> > > > > > > > > 			de->start_blkaddr = START_BLOCK(sbi, cpc->trim_start);
> > > > > > > > > 			list_add_tail(&de->list, head);
> > > > > > > > > 		}
> > > > > > > > > ...
> > > > > > > > > 	}
> > > > > > > > > ...
> > > > > > > > > 
> > > > > > > > > Thanks,
> > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > Thanks,
> > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > > 
> > > > > > > > > > > > >       From eb89d9b56e817e3046d7fa17165b12416f09d456 Mon Sep 17 00:00:00 2001
> > > > > > > > > > > > > From: Chao Yu <chao@kernel.org>
> > > > > > > > > > > > > Date: Mon, 3 Jul 2023 09:06:53 +0800
> > > > > > > > > > > > > Subject: [PATCH] Revert "f2fs: enable small discard by default"
> > > > > > > > > > > > > 
> > > > > > > > > > > > > This reverts commit d618ebaf0aa83d175658aea5291e0c459d471d39 in order
> > > > > > > > > > > > > to disable small discard by default, so that if there're huge number of
> > > > > > > > > > > > > small discards, it will decrease checkpoint's latency obviously.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Also, this patch reverts 9ac00e7cef10 ("f2fs: do not issue small discard
> > > > > > > > > > > > > commands during checkpoint"), due to it breaks small discard feature which
> > > > > > > > > > > > > may be configured via sysfs entry max_small_discards.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Fixes: 9ac00e7cef10 ("f2fs: do not issue small discard commands during checkpoint")
> > > > > > > > > > > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >        fs/f2fs/segment.c | 4 ++--
> > > > > > > > > > > > >        1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > > > > > > > 
> > > > > > > > > > > > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > > > > > > > > > > > index 14c822e5c9c9..0a313368f18b 100644
> > > > > > > > > > > > > --- a/fs/f2fs/segment.c
> > > > > > > > > > > > > +++ b/fs/f2fs/segment.c
> > > > > > > > > > > > > @@ -2193,7 +2193,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
> > > > > > > > > > > > >        			len = next_pos - cur_pos;
> > > > > > > > > > > > > 
> > > > > > > > > > > > >        			if (f2fs_sb_has_blkzoned(sbi) ||
> > > > > > > > > > > > > -					!force || len < cpc->trim_minlen)
> > > > > > > > > > > > > +			    (force && len < cpc->trim_minlen))
> > > > > > > > > > > > >        				goto skip;
> > > > > > > > > > > > > 
> > > > > > > > > > > > >        			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
> > > > > > > > > > > > > @@ -2269,7 +2269,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
> > > > > > > > > > > > >        	atomic_set(&dcc->queued_discard, 0);
> > > > > > > > > > > > >        	atomic_set(&dcc->discard_cmd_cnt, 0);
> > > > > > > > > > > > >        	dcc->nr_discards = 0;
> > > > > > > > > > > > > -	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
> > > > > > > > > > > > > +	dcc->max_discards = 0;
> > > > > > > > > > > > >        	dcc->max_discard_request = DEF_MAX_DISCARD_REQUEST;
> > > > > > > > > > > > >        	dcc->min_discard_issue_time = DEF_MIN_DISCARD_ISSUE_TIME;
> > > > > > > > > > > > >        	dcc->mid_discard_issue_time = DEF_MID_DISCARD_ISSUE_TIME;
> > > > > > > > > > > > > -- 
> > > > > > > > > > > > > 2.40.1
> > > > > > > > > > > > > 
> > > > > > > > > > > > > 
> > > > > > > > > > > > > 
> > > > > > > > > > > > > >         			f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
