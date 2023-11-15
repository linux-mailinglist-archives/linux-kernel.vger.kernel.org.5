Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211687EBD10
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 07:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbjKOG3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 01:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjKOG3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 01:29:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70E5D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 22:29:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0F8C433C7;
        Wed, 15 Nov 2023 06:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700029741;
        bh=L8aS70wCeZHXd9bSYTpdvYQwgG0Gn4rLS8gBbZvlwHY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BrdbpUmo27fDVhHtmSsHprxs9HvkdzIYcfuhcpJ0Ab63OtZ+7RLbCS/zTCqwT8phM
         ijNqjG7lzVSgmePPnk6eoerp5tCWJRNoCIk/q9gXPeFAoV04nxFkc61lmQLYcTXsse
         qKr3tB8bSIEEL49kQC/xHLIAjOUMc2dxD+yOnNBI5JyJUlFa1SC25mgXQgv8Ndd08X
         yxSkolJujqdwQEOfMx5ZV5bamvDrE0gR8y4EZbZ8z0ZC59e9iRZEew3rNlVPCYSgBP
         xFN5MpMoQK4v4I0q+XRnPH4VOqf0YFP54FfVZONyuQ3/h83zmZmdpej4N31vDBNL0n
         fT99yXCMww4eA==
Message-ID: <236866a2-41b0-2ad0-db77-4c377367c80e@kernel.org>
Date:   Wed, 15 Nov 2023 14:28:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip adding a discard command if exists
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20231114212414.3498074-1-jaegeuk@kernel.org>
 <4a0e1c6f-12c4-f3dd-bb26-4bf0aee6be4b@kernel.org>
 <ZVQwz5ubx9LojzEf@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZVQwz5ubx9LojzEf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/15 10:45, Jaegeuk Kim wrote:
> On 11/15, Chao Yu wrote:
>> On 2023/11/15 5:24, Jaegeuk Kim wrote:
>>> When recovering zoned UFS, sometimes we add the same zone to discard multiple
>>> times. Simple workaround is to bypass adding it.
>>
>> What about skipping f2fs_bug_on() just for zoned UFS case? so that the check
>> condition can still be used for non-zoned UFS case.
> 
> Hmm, I've never seen this bug_on before, but even this really happens, it does

I've never seen it was been triggered as well.

> not make sense to move forward to create duplicate commands resulting in a loop.

Agreed.

It looks those codes were copied from extent_cache code base, do we need to fix
all cases to avoid loop?

> 
> So, the question is, do we really need to check this? Have we hit this before?
Not sure, just be worry about that flaw of newly developed feature can make
code run into that branch.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>    fs/f2fs/segment.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 727d016318f9..f4ffd64b44b2 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1380,7 +1380,8 @@ static void __insert_discard_cmd(struct f2fs_sb_info *sbi,
>>>    			p = &(*p)->rb_right;
>>>    			leftmost = false;
>>>    		} else {
>>> -			f2fs_bug_on(sbi, 1);
>>> +			/* Let's skip to add, if exists */
>>> +			return;
>>>    		}
>>>    	}
