Return-Path: <linux-kernel+bounces-72392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B80A85B2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718FBB20A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C56A5914F;
	Tue, 20 Feb 2024 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGi9zuZF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091235822D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409645; cv=none; b=fcuTRazhClp6iHXWicCiwkJ2iNRGQZOUjTmnxCkOwSDRgnf2AkTmxUC9UmhTvyKRbicHG0qJEpfHesWxBtHL7oBfzKexMvgG0+YMiFcOtCGqXGfZ3pf0ss4KSGqLjHWPgGX+TpzCh7oB+d/Rm2nmlcn0IBHCQnFbCInJWcbMGow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409645; c=relaxed/simple;
	bh=im/xk8WtovhJ/os0s4GcpOv9OZ51L0bRmgYqEcvT6vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cmNVXlfCJCSHxeaiMlCunwMmfgezAGQlYO9GxGEz77lUuiNAmTc+vc0qTnfPsAtg5uCZ9Ilroxe9Ch2dbKan90Uy+36v+8SAqdfG/bDn+xDZkSHkheKvF0z4EYHnsOjsvCEG4oSsMjvA4vsR8SSbFyJcxjK7Ks8HmpHHJ+/OsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGi9zuZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11421C433C7;
	Tue, 20 Feb 2024 06:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708409644;
	bh=im/xk8WtovhJ/os0s4GcpOv9OZ51L0bRmgYqEcvT6vo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IGi9zuZFET8P9j2g0MUwu3V1H5u2I53toTuls49nsgr8KPPmo7gT428SUePHCtLgl
	 11E4N7Y8t+7nwp1qh5R4yWcog80dCcCIq4OsYGWbbabkGg5621LUAhGkHWdSrxtCqd
	 OvrgY2L4zbzRuvIb0J1oNBnyRvoFxJjhJQJd2CXJQr6rTsiwlFgyVWnlfCXnWtIZJN
	 0HMw0ldBpMlQPDgFAziT99ZatOnHtzZFupMBXG3Z1RuQDYlu9FutWuwQHxm1RVweh8
	 mXDl3ZyYFX2M2PIdtm2U64KXYmsSVNPewpM0ruChyhjTErLL6oAQXfgVa6mIBAHyHe
	 bYVKjHCuJGeBw==
Message-ID: <c2bc04b6-be23-426f-ad6c-1d47dad7259b@kernel.org>
Date: Tue, 20 Feb 2024 14:13:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: unify the error handling of
 f2fs_is_valid_blkaddr
Content-Language: en-US
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 hongyu.jin@unisoc.com, Zhiguo Niu <zhiguo.niu@unisoc.com>
References: <1707103845-17220-1-git-send-email-zhiguo.niu@unisoc.com>
 <e2680238-9e9c-422a-adf3-bcee71dfe0a8@kernel.org>
 <ZcGoWAsl08d5-U0g@google.com>
 <6f01fe1b-d580-4a2a-adc5-7eb3baebeb7a@kernel.org>
 <CAHJ8P3J6CrYeBHUHmk4rQXRr=V0jHkLWOKHjdC+xuLgb4a+NQQ@mail.gmail.com>
 <17c9e85a-54b6-4e1c-b95f-262c771b0f1d@kernel.org>
 <4bcf0a1c-b21d-4735-bf57-b78439a65df5@kernel.org>
 <CAHJ8P3+25FxdpqWNW53yyiLLG8J7LnMAeYr_DV3ARF9-3LCUUg@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3+25FxdpqWNW53yyiLLG8J7LnMAeYr_DV3ARF9-3LCUUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/20 13:34, Zhiguo Niu wrote:
> On Tue, Feb 20, 2024 at 10:36 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/2/19 22:36, Chao Yu wrote:
>>>>>> Please think about how to optimize this, which is really ugly now
>> ---
>>    fs/f2fs/checkpoint.c | 12 ++++++++----
>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 87b7c988c8ca..089c26b80be3 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -135,7 +135,7 @@ struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index)
>>    }
>>
>>    static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>> -                                                       int type)
>> +                                               int type, bool *record_error)
>>    {
>>          struct seg_entry *se;
>>          unsigned int segno, offset;
>> @@ -160,6 +160,7 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>>                           blkaddr, exist);
>>                  set_sbi_flag(sbi, SBI_NEED_FSCK);
>>                  dump_stack();
>> +               *record_error = true;
>>          }
>>
>>          return exist;
>> @@ -209,10 +210,13 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>                          dump_stack();
>>                          goto err;
>>                  } else {
>> -                       valid = __is_bitmap_valid(sbi, blkaddr, type);
>> -                       if ((!valid && type != DATA_GENERIC_ENHANCE_UPDATE) ||
>> -                               (valid && type == DATA_GENERIC_ENHANCE_UPDATE))
>> +                       bool record_error = false;
>> +
>> +                       valid = __is_bitmap_valid(sbi, blkaddr, type,
>> +                                                       &record_error);
>> +                       if (!valid || record_error)
> if   type == DATA_GENERIC_ENHANCE_UPDATE && bitmap check invalid,  it
> is a OK case, but !valid
> will goto do error handling.

Yes, it looks we need to remove !valid condition to avoid error handling,
and assign record_error correctly inside __is_bitmap_valid() for all the
cases.

> I think do f2fs_handle_error in __is_bitmap_valid is a good way.

Let me revise the diff patch for comments.

Thanks,

> 
>>                                  goto err;
>> +                       return valid;
>>                  }
>>                  break;
>>          case META_GENERIC:
>> --
>> 2.40.1
>>

