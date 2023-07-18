Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B75757295
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGRD5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjGRD5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:57:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC9118C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA97561388
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 03:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B2DC433C7;
        Tue, 18 Jul 2023 03:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689652628;
        bh=NYrYHBhUhSrGSV8daixGuOC87c6t5hd72Ghpf6rRueo=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=LU4U46ReOyGBloy747KuT7hUNDtCzoXoXxV0OWSqVQ3DIPuvIlO8fv5JOsx65MscZ
         D4cb3MIkWuLC2rLuUXKMd8bvmxqTCQAch8VmtZDxp8p8yNaFVOb0jrN9XxmHnDIDd8
         2q63OL7dbvCTE7kmRUQ5HEgqA7CU3FJBmmz5wj4Uuy8E6Z+Ei6H4hZxxPCGUUtMdFF
         97PlVbNjshZs8swggXUExkhebz3W2vrY87Iz7PsmU9CDFWD66fAIqGDcJk2F2uH7Y2
         pM0ZpXXVXpYAJ8OXTBQzsg4Sd4jca3BTJwpcULdgKAFUe8j/uKrzrvQUKa40gEmi0d
         /Hgnq4q2ddimQ==
Message-ID: <e84a88a6-ff2f-1c52-ffb7-8e34a14590b5@kernel.org>
Date:   Tue, 18 Jul 2023 11:57:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: do not issue small discard commands
 during checkpoint
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230613203947.2745943-1-jaegeuk@kernel.org>
 <ZInmkgjDnAUD5Nk0@google.com>
 <50d5fa8c-4fe9-8a03-be78-0b5383e55b62@kernel.org>
 <ZKP6EJ5dZ4f4wScp@google.com>
 <65143701-4c19-ab66-1500-abd1162639cd@kernel.org>
 <ZKWovWZDiHjMavtB@google.com>
 <cadfb8d7-f5d0-a3ec-cafb-a0c06ad7d290@kernel.org>
 <ZK2FT9CUjxXvQ2K5@google.com>
 <330c96f7-fbad-dd17-6368-f1378b3b5375@kernel.org>
 <ZK7M6EkLkV8UbqUl@google.com>
 <87acf602-1587-0615-909d-6e60c66c3cda@kernel.org>
In-Reply-To: <87acf602-1587-0615-909d-6e60c66c3cda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comments?

On 2023/7/13 9:31, Chao Yu wrote:
> On 2023/7/12 23:55, Jaegeuk Kim wrote:
>> On 07/12, Chao Yu wrote:
>>> On 2023/7/12 0:37, Jaegeuk Kim wrote:
>>>> On 07/06, Chao Yu wrote:
>>>>> On 2023/7/6 1:30, Jaegeuk Kim wrote:
>>>>>> On 07/04, Chao Yu wrote:
>>>>>>> On 2023/7/4 18:53, Jaegeuk Kim wrote:
>>>>>>>> On 07/03, Chao Yu wrote:
>>>>>>>>> On 2023/6/15 0:10, Jaegeuk Kim wrote:
>>>>>>>>>> If there're huge # of small discards, this will increase checkpoint latency
>>>>>>>>>> insanely. Let's issue small discards only by trim.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>>       Change log from v1:
>>>>>>>>>>        - move the skip logic to avoid dangling objects
>>>>>>>>>>
>>>>>>>>>>       fs/f2fs/segment.c | 2 +-
>>>>>>>>>>       1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>>>>>>> index 8c7af8b4fc47..0457d620011f 100644
>>>>>>>>>> --- a/fs/f2fs/segment.c
>>>>>>>>>> +++ b/fs/f2fs/segment.c
>>>>>>>>>> @@ -2193,7 +2193,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>>>>>>>>>>                   len = next_pos - cur_pos;
>>>>>>>>>>                   if (f2fs_sb_has_blkzoned(sbi) ||
>>>>>>>>>> -                (force && len < cpc->trim_minlen))
>>>>>>>>>> +                    !force || len < cpc->trim_minlen)
>>>>>>>>>>                       goto skip;
>>>>>>>>>
>>>>>>>>> Sorry for late reply.
>>>>>>>>>
>>>>>>>>> We have a configuration for such case, what do you think of setting
>>>>>>>>> max_small_discards to zero? otherwise, w/ above change, max_small_discards
>>>>>>>>> logic may be broken?
>>>>>>>>>
>>>>>>>>> What:           /sys/fs/f2fs/<disk>/max_small_discards
>>>>>>>>> Date:           November 2013
>>>>>>>>> Contact:        "Jaegeuk Kim" <jaegeuk.kim@samsung.com>
>>>>>>>>> Description:    Controls the issue rate of discard commands that consist of small
>>>>>>>>>                     blocks less than 2MB. The candidates to be discarded are cached until
>>>>>>>>>                     checkpoint is triggered, and issued during the checkpoint.
>>>>>>>>>                     By default, it is disabled with 0.
>>>>>>>>>
>>>>>>>>> Or, if we prefer to disable small_discards by default, what about below change:
>>>>>>>>
>>>>>>>> I think small_discards is fine, but need to avoid long checkpoint latency only.
>>>>>>>
>>>>>>> I didn't get you, do you mean we can still issue small discard by
>>>>>>> fstrim, so small_discards functionality is fine?
>>>>>>
>>>>>> You got the point.
>>>>>
>>>>> Well, actually, what I mean is max_small_discards sysfs entry's functionality
>>>>> is broken. Now, the entry can not be used to control number of small discards
>>>>> committed by checkpoint.
>>>>
>>>> Could you descrbie this problem first?
>>>
>>> Oh, alright, actually, I've described this problem literally, but maybe it's not
>>> clear, let me give some examples as below:
>>>
>>> echo 0 > /sys/fs/f2fs/vdb/max_small_discards
>>> xfs_io -f /mnt/f2fs/file -c "pwrite 0 2m" -c "fsync"
>>> xfs_io /mnt/f2fs/file -c "fpunch 0 4k"
>>> sync
>>> cat /proc/fs/f2fs/vdb/discard_plist_info |head -2
>>>
>>> echo 100 > /sys/fs/f2fs/vdb/max_small_discards
>>> rm /mnt/f2fs/file
>>> xfs_io -f /mnt/f2fs/file -c "pwrite 0 2m" -c "fsync"
>>> xfs_io /mnt/f2fs/file -c "fpunch 0 4k"
>>> sync
>>> cat /proc/fs/f2fs/vdb/discard_plist_info |head -2
>>>
>>> Before the patch:
>>>
>>> Discard pend list(Show diacrd_cmd count on each entry, .:not exist):
>>>    0         .       .       .       .       .       .       .       .
>>>
>>> Discard pend list(Show diacrd_cmd count on each entry, .:not exist):
>>>    0         3       1       .       .       .       .       .       .
>>>
>>> After the patch:
>>> Discard pend list(Show diacrd_cmd count on each entry, .:not exist):
>>>    0         .       .       .       .       .       .       .       .
>>>
>>> Discard pend list(Show diacrd_cmd count on each entry, .:not exist):
>>>    0         .       .       .       .       .       .       .       .
>>>
>>> So, now max_small_discards can not be used to control small discard number
>>> cached by checkpoint.
> 
> Let me explain more:
> 
> Previously, we have two mechanisms to cache & submit small discards:
> 
> a) set max small discard number in /sys/fs/f2fs/vdb/max_small_discards, and checkpoint
> will cache small discard candidates w/ configured maximum number.
> 
> b) call FITRIM ioctl, also, checkpoint in f2fs_trim_fs() will cache small discard
> candidates w/ configured discard granularity, but w/o limitation of number. FSTRIM
> interface is asynchronized, so it won't submit discard directly.
> 
> Finally, discard thread will submit them in background periodically.
> 
> So what I mean is the mechanism a) is broken, since no matter how we configure the
> sysfs entry /sys/fs/f2fs/vdb/max_small_discards, checkpoint will not cache small
> discard candidates any more.
> 
> So, it needs to fix max_small_discards sysfs functionality? or just drop the
> functionality?
> 
>>
>> Since we do not submit small discards anymore during checkpoint. Why not relying
>> on the discard thread to issue them?
> 
> Sorry, I'm not sure I get your point, do you mean max_small_discards functionality
> is obsoleted, so it recommended to use fstrim to cache & submit small discards?
> 
> Let me know, if I'm missing something or misunderstanding the point.
> 
> Thanks,
> 
>>
>>>
>>> Thanks,
>>>
>>>>
>>>>>
>>>>> I think there is another way to achieve "avoid long checkpoint latency caused
>>>>> by committing huge # of small discards", the way is we can set max_small_discards
>>>>> to small value or zero, w/ such configuration, it will take checkpoint much less
>>>>> time or no time to committing small discard due to below control logic:
>>>>>
>>>>> f2fs_flush_sit_entries()
>>>>> {
>>>>> ...
>>>>>             if (!(cpc->reason & CP_DISCARD)) {
>>>>>                 cpc->trim_start = segno;
>>>>>                 add_discard_addrs(sbi, cpc, false);
>>>>>             }
>>>>> ...
>>>>> }
>>>>>
>>>>> add_discard_addrs()
>>>>> {
>>>>> ...
>>>>>     while (force || SM_I(sbi)->dcc_info->nr_discards <=
>>>>>                 SM_I(sbi)->dcc_info->max_discards) {
>>>>>
>>>>> It will break the loop once nr_discards is larger than max_discards, if
>>>>> max_discards is set to zero, checkpoint won't take time to handle small discards.
>>>>>
>>>>> ...
>>>>>         if (!de) {
>>>>>             de = f2fs_kmem_cache_alloc(discard_entry_slab,
>>>>>                         GFP_F2FS_ZERO, true, NULL);
>>>>>             de->start_blkaddr = START_BLOCK(sbi, cpc->trim_start);
>>>>>             list_add_tail(&de->list, head);
>>>>>         }
>>>>> ...
>>>>>     }
>>>>> ...
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>     From eb89d9b56e817e3046d7fa17165b12416f09d456 Mon Sep 17 00:00:00 2001
>>>>>>>>> From: Chao Yu <chao@kernel.org>
>>>>>>>>> Date: Mon, 3 Jul 2023 09:06:53 +0800
>>>>>>>>> Subject: [PATCH] Revert "f2fs: enable small discard by default"
>>>>>>>>>
>>>>>>>>> This reverts commit d618ebaf0aa83d175658aea5291e0c459d471d39 in order
>>>>>>>>> to disable small discard by default, so that if there're huge number of
>>>>>>>>> small discards, it will decrease checkpoint's latency obviously.
>>>>>>>>>
>>>>>>>>> Also, this patch reverts 9ac00e7cef10 ("f2fs: do not issue small discard
>>>>>>>>> commands during checkpoint"), due to it breaks small discard feature which
>>>>>>>>> may be configured via sysfs entry max_small_discards.
>>>>>>>>>
>>>>>>>>> Fixes: 9ac00e7cef10 ("f2fs: do not issue small discard commands during checkpoint")
>>>>>>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>>>>>>> ---
>>>>>>>>>      fs/f2fs/segment.c | 4 ++--
>>>>>>>>>      1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>>>>>> index 14c822e5c9c9..0a313368f18b 100644
>>>>>>>>> --- a/fs/f2fs/segment.c
>>>>>>>>> +++ b/fs/f2fs/segment.c
>>>>>>>>> @@ -2193,7 +2193,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>>>>>>>>>                  len = next_pos - cur_pos;
>>>>>>>>>
>>>>>>>>>                  if (f2fs_sb_has_blkzoned(sbi) ||
>>>>>>>>> -                    !force || len < cpc->trim_minlen)
>>>>>>>>> +                (force && len < cpc->trim_minlen))
>>>>>>>>>                      goto skip;
>>>>>>>>>
>>>>>>>>>                  f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
>>>>>>>>> @@ -2269,7 +2269,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>>>>>>>>>          atomic_set(&dcc->queued_discard, 0);
>>>>>>>>>          atomic_set(&dcc->discard_cmd_cnt, 0);
>>>>>>>>>          dcc->nr_discards = 0;
>>>>>>>>> -    dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
>>>>>>>>> +    dcc->max_discards = 0;
>>>>>>>>>          dcc->max_discard_request = DEF_MAX_DISCARD_REQUEST;
>>>>>>>>>          dcc->min_discard_issue_time = DEF_MIN_DISCARD_ISSUE_TIME;
>>>>>>>>>          dcc->mid_discard_issue_time = DEF_MID_DISCARD_ISSUE_TIME;
>>>>>>>>> -- 
>>>>>>>>> 2.40.1
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>                   f2fs_issue_discard(sbi, entry->start_blkaddr + cur_pos,
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
