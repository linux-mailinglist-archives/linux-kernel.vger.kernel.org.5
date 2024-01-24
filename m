Return-Path: <linux-kernel+bounces-37208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EF283AC8D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31CE29D8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486E141745;
	Wed, 24 Jan 2024 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pj2mKTRr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F2532C88
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108078; cv=none; b=W6LD1rUvRn2pHuH5WYZiSH52c9xiQrDI8c7zYkc24gdyybkx/VjG3ykgo3Apmu43RTw696YTq2L+PbTx9RGZ+usHf6aVNtZG0WWlGKSGkmo3IrOF56U5ZyYpM1geme4TGpfwSpcYGumG8U+pW43QXOKKAxhEixD2mrhnGfgntxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108078; c=relaxed/simple;
	bh=EN20Jf/orEGnGWTKkhnrX0y5TE3fu6bVQexb33h8Zgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLP0HEykKo3EAMG5cQupvw6wyc5WtQm0YH95aVMXj8o2eUTvIJU62ZtqVTOncrmXiR+wz58punnmxCCowo6XU5cSZ4AyxVVoz+pK+OUUD7e2Uwdt15+lTOVbJUSk3BtWbpIXnyQTwr8GNufPJSgURuSPP01bvVUu0rBGyWtHndU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pj2mKTRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52974C433C7;
	Wed, 24 Jan 2024 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706108078;
	bh=EN20Jf/orEGnGWTKkhnrX0y5TE3fu6bVQexb33h8Zgw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pj2mKTRrqqjBqq6BhTCRwxiKp3s55N2msA2nDLK63aWZfe2O8x6viPZ/yif0dl/Dr
	 JMc6d/ZkZsn3hTGXrUzMeP8J2hsGCg98Gp/1wJKphm4jVpS4nT/q/nmH+h18dxx6W+
	 OQ9sPxQvy680F1F2F/eQNG/sYDTltLIaT6lGYIj2xZ7CI76GgK1FoIHMHWZFMerHEa
	 gZ/1AXmwmGmdnXlMPMib4a+5S0dZ+UlgUH4jm0J7W5LlOf3IyU3enU+F3Yz1hTpKHf
	 onsLVNDxC52CNR38XMGgRQS/XdVDIAFnkC1abKhIrCvAre0cVzD/Is+daLc9kySpj4
	 dKIQfZjFKBQNQ==
Message-ID: <b2a3268a-7087-4ff5-9148-dcbc7c95e2bb@kernel.org>
Date: Wed, 24 Jan 2024 22:54:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] f2fs: fix potentail deadloop issue in do_recover_data
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com
References: <1703502715-11936-1-git-send-email-zhiguo.niu@unisoc.com>
 <74243f43-c129-4530-970c-4de2afcd307e@kernel.org>
 <CAHJ8P3KmnN3rc5yXh2ecg21Eu61srUJsJP8=TbPxfSu4dY91EQ@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3KmnN3rc5yXh2ecg21Eu61srUJsJP8=TbPxfSu4dY91EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Zhiguo,

Can you please check below version? Is it fine to you?

https://lore.kernel.org/linux-f2fs-devel/20240124144915.19445-1-chao@kernel.org

On 2024/1/22 13:46, Zhiguo Niu wrote:
> Hi Chao
> 
> On Mon, Jan 22, 2024 at 11:46 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2023/12/25 19:11, Zhiguo Niu wrote:
>>> There is a potentail deadloop issue in the corner case of
>>> CONFIG_F2FS_FAULT_INJECTION is enabled and the return value
>>> of f2fs_reserve_new_block is error but not -ENOSPC, such as
>>> this error case:
>>> if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
>>>                return -EPERM;
>>
>> I don't see any path to trigger this error? am I missing something?
>>
>>> besides, the mainly error -ENOSPC has been handled as bug on,
>>> so other error cases can be proecssed normally without looping.
>>
>> commit 975756c41332bc5e523e9f843271ed5ab6aaaaaa
>> Author: Jaegeuk Kim <jaegeuk@kernel.org>
>> Date:   Thu May 19 11:57:21 2016 -0700
>>
>>       f2fs: avoid ENOSPC fault in the recovery process
>>
>>       This patch avoids impossible error injection, ENOSPC, during recovery process.
>>
>> Please check above patch, I guess intention of adding such loop is
>> to avoid mount failure due to fault injection was triggered in
>> f2fs_reserve_new_block().
>>
>> What about change as blew?
>> - keep the loop to avoid mount failure.
>> - remove bug_on() to avoid panic due to fault injection error.
>>
>> #define DEFAULT_RETRY_COUNT             8
>>
>>                  for (loops = DEFAULT_RETRY_COUNT; loops > 0; loops--) {
>>                          err = f2fs_reserve_new_block(&dn);
>>                          if (!err ||
>>                                  !IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION))
>>                                  break;
>>                  }
> 
> Thanks for your detailed explanation and I understand.
> It seems that the original process is also reasonable,
> so it’s okay to keep it as it is.
>>
>> Thanks,
>>
>>>
>>> Fixes: 956fa1ddc132 ("f2fs: fix to check return value of f2fs_reserve_new_block()")
>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> ---
>>>    fs/f2fs/recovery.c | 26 ++++++++------------------
>>>    1 file changed, 8 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>>> index 21381b7..5d658f6 100644
>>> --- a/fs/f2fs/recovery.c
>>> +++ b/fs/f2fs/recovery.c
>>> @@ -710,15 +710,10 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>>>                 */
>>>                if (dest == NEW_ADDR) {
>>>                        f2fs_truncate_data_blocks_range(&dn, 1);
>>> -                     do {
>>> -                             err = f2fs_reserve_new_block(&dn);
>>> -                             if (err == -ENOSPC) {
>>> -                                     f2fs_bug_on(sbi, 1);
>>> -                                     break;
>>> -                             }
>>> -                     } while (err &&
>>> -                             IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
>>> -                     if (err)
>>> +                     err = f2fs_reserve_new_block(&dn);
>>> +                     if (err == -ENOSPC)
>>> +                             f2fs_bug_on(sbi, 1);
>>> +                     else if (err)
>>>                                goto err;
>>>                        continue;
>>>                }
>>> @@ -727,15 +722,10 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>>>                if (f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
>>>
>>>                        if (src == NULL_ADDR) {
>>> -                             do {
>>> -                                     err = f2fs_reserve_new_block(&dn);
>>> -                                     if (err == -ENOSPC) {
>>> -                                             f2fs_bug_on(sbi, 1);
>>> -                                             break;
>>> -                                     }
>>> -                             } while (err &&
>>> -                                     IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
>>> -                             if (err)
>>> +                             err = f2fs_reserve_new_block(&dn);
>>> +                             if (err == -ENOSPC)
>>> +                                     f2fs_bug_on(sbi, 1);
>>> +                             else if (err)
>>>                                        goto err;
>>>                        }
>>>    retry_prev:

