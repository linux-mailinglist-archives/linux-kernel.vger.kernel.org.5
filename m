Return-Path: <linux-kernel+bounces-120437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF588D75C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212301F28F91
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CD328E17;
	Wed, 27 Mar 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhIgEMST"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530281D530
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525119; cv=none; b=qQrY1icYcSmFUhxH/n445kTr+hr29GnHSiqUNkw8vKS2CRn9ej/dQjYYsOG3/1ebyhSr7k5pn6nDtFZrLdec0NJ2n3SHwGBDQeS1+UDMUVoD2RycGmE0FAl1rYkPUO/o2CpITWb5hdDS/szIlfPXifgHe80/SKLFN5rDcTtzhAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525119; c=relaxed/simple;
	bh=vOZBAan2Cx/wF+uoGUYShV+giAfOXpqrqoKkEy8CSw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ik3ln5rhkBhqdckqK8inuZw66eRilzIqDPIl63uGg5T4AYOBZF64WCnDfIGKS8PtoLYtgmqsvU/Y6byQRCL6CAI4LqCAc4ITFbVZoP1JH/wT/HKTrn0fVr/BgmbIxfjOECtuzYChZr1IiwH5GBLNGOp+mL+RWApHyrQqzrjQRuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhIgEMST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2177AC433C7;
	Wed, 27 Mar 2024 07:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711525118;
	bh=vOZBAan2Cx/wF+uoGUYShV+giAfOXpqrqoKkEy8CSw4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YhIgEMST9xtsM1kuUIFnjNtUlS4bDEW6Xe7XuLJyuMAL4l/C4BzzYnGQMLFFSXifX
	 T56E0U7fOGPEpCT4v+pukG+27VYedgBlhWMHVpQlr93mo0dY/Q+ej62gxaIikCMki8
	 KhU7sjFmeAmQV36czX5Hn8OXp3TjilAKWrpY3cHVgF0/RBujgNRK5n9iK/g0VuLORF
	 vpEjbeC/UKNdlxboX4DNdbe2e3zVW3wAfYHNwqeS7eNDLVB5B3la2e2Eh4GRddXHSL
	 G6VsUI32rqktTFO3wyhcsxnL3IB36I/CRR2tH+POgAyBYaYrpjp6K2HWktfBvNZqdC
	 +l1RPXcC3DBUw==
Message-ID: <0ed07576-256c-4ed7-8ddc-33ed788a45ac@kernel.org>
Date: Wed, 27 Mar 2024 15:38:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] f2fs: fix to adjust appropirate defragment pg_end
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1711346195-24555-1-git-send-email-zhiguo.niu@unisoc.com>
 <8a6b2768-8ab6-4275-8c4e-05b4eca83987@kernel.org>
 <CAHJ8P3J3xK2uz7egvShyCeAjGFJ87AvqKxVN=NFiKDgMLMJDPg@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3J3xK2uz7egvShyCeAjGFJ87AvqKxVN=NFiKDgMLMJDPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/3/27 9:26, Zhiguo Niu wrote:
> On Tue, Mar 26, 2024 at 7:11 PM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/3/25 13:56, Zhiguo Niu wrote:
>>> A length that exceeds the real size of the inode may be
>>> specified from user, although these out-of-range areas
>>> are not mapped, but they still need to be check in
>>> while loop, which is unnecessary.
>>>
>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> ---
>>> v2: check i_size within inode lock according to Chao's suggestions
>>> ---
>>> ---
>>>    fs/f2fs/file.c | 11 +++++++----
>>>    1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 128e53d..cf63db7 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -2608,9 +2608,6 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>>>        bool fragmented = false;
>>>        int err;
>>>
>>> -     pg_start = range->start >> PAGE_SHIFT;
>>> -     pg_end = (range->start + range->len) >> PAGE_SHIFT;
>>> -
>>>        f2fs_balance_fs(sbi, true);
>>>
>>>        inode_lock(inode);
>>> @@ -2629,10 +2626,16 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>>
>> pg_start = range->start >> PAGE_SHIFT;
>> pg_end = min_t(pgoff_t, (range->start + range->len) >> PAGE_SHIFT,
>>                          DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
>>
>>>
>>>        /* writeback all dirty pages in the range */
>>>        err = filemap_write_and_wait_range(inode->i_mapping, range->start,
>>> -                                             range->start + range->len - 1);
>>> +                                             min_t(loff_t, range->start + range->len - 1,
>>> +                                             i_size_read(inode) - 1));
>>
>> , pg_start << PAGE_SHIFT - 1, pg_end << PAGE_SHIFT - 1); ?
> should be  pg_start << PAGE_SHIFT , pg_end << PAGE_SHIFT - 1)??

Oh, yes. :)

Thanks,

> if range.start=0, pg_start is also 0, lstart in
> filemap_write_and_wait_range is 0,
> but pg_start << PAGE_SHIFT - 1 will get lstart=-1?
> thanks！
>>
>> Thanks,
>>
>>>        if (err)
>>>                goto out;
>>>
>>> +     pg_start = range->start >> PAGE_SHIFT;
>>> +     pg_end = min_t(pgoff_t,
>>> +                             (range->start + range->len) >> PAGE_SHIFT,
>>> +                             DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
>>> +
>>>        /*
>>>         * lookup mapping info in extent cache, skip defragmenting if physical
>>>         * block addresses are continuous.

