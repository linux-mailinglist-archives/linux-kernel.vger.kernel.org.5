Return-Path: <linux-kernel+bounces-144866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F618A4BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95972882AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6BA46424;
	Mon, 15 Apr 2024 09:51:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47AA40868;
	Mon, 15 Apr 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174693; cv=none; b=VoxzuI8Z5/EghP5H0bIE+DTxK0VmQjXnPd1KurtiKEEJjQQKJI8sKOvTwRnY3LQpmkquESPfPwLNs7ADOz+2lYN9ZVf5wbWmnxFLBnxLUI1F49IgI+Br7UQ1a5ErHAUn0c+XN1lJ3rtQ1oJdCjwM7m+LXiP4dM2ijXuorTzRHRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174693; c=relaxed/simple;
	bh=8lRDM+nAraAQJSBUKR+WqTVlUNZqbzoULQPWARmPl5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fs4GJII25XsbSCIxrHUy3mLA1DL3av/HVGEGVG7s+gdZT9qxbrvtfRYMRk++hjif17v+UE2jYdyHT6nKqsDHyT1+xT4Hdb4UEO/llPDu6jT8FLu8OYKO4ez1O0qiD6mbc4zwFHv3BdVR2pZHVL9V3lfNRVenwVNxD6PwaSEyIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7FBC113CC;
	Mon, 15 Apr 2024 09:51:32 +0000 (UTC)
Message-ID: <3f8660b0-e29c-47e2-b877-10da058388f9@xs4all.nl>
Date: Mon, 15 Apr 2024 11:51:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] media: dvb: Fix dtvs_stats packing.
Content-Language: en-US, nl
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240410-pack-v1-0-70f287dd8a66@chromium.org>
 <20240410-pack-v1-2-70f287dd8a66@chromium.org>
 <f7ca4107-0341-4631-8d8d-b9677782ac2f@xs4all.nl>
 <CANiDSCvkRWZXuG7dfw0WXvgT+LHQqG3fx9F1M2P0_9dkB9VOKA@mail.gmail.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <CANiDSCvkRWZXuG7dfw0WXvgT+LHQqG3fx9F1M2P0_9dkB9VOKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 12/04/2024 17:00, Ricardo Ribalda wrote:
> Hi Hans
> 
> On Fri, 12 Apr 2024 at 16:21, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>>
>> On 10/04/2024 14:24, Ricardo Ribalda wrote:
>>> The structure is packed, which requires that all its fields need to be
>>> also packed.
>>>
>>> ./include/uapi/linux/dvb/frontend.h:854:2: warning: field  within 'struct dtv_stats' is less aligned than 'union dtv_stats::(anonymous at ./include/uapi/linux/dvb/frontend.h:854:2)' and is usually due to 'struct dtv_stats' being packed, which can lead to unaligned accesses [-Wunaligned-access]
>>>
>>> Explicitly set the inner union as packed.
>>>
>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>>> ---
>>>  include/uapi/linux/dvb/frontend.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/linux/dvb/frontend.h b/include/uapi/linux/dvb/frontend.h
>>> index 7e0983b987c2d..8d38c6befda8d 100644
>>> --- a/include/uapi/linux/dvb/frontend.h
>>> +++ b/include/uapi/linux/dvb/frontend.h
>>> @@ -854,7 +854,7 @@ struct dtv_stats {
>>>       union {
>>>               __u64 uvalue;   /* for counters and relative scales */
>>>               __s64 svalue;   /* for 0.001 dB measures */
>>> -     };
>>> +     }  __attribute__ ((packed));
>>>  } __attribute__ ((packed));
>>
>> This is used in the public API, and I think this change can cause ABI changes.
>>
>> Can you compare the layouts? Also between gcc and llvm since gcc never warned
>> about this.
> 
> The pahole output looks the same in both cases:
> 
> https://godbolt.org/z/oK4desv7Y
> vs
> https://godbolt.org/z/E36MjPr7v
> 
> And it is also the same for all the compiler versions that I tried.
> 
> 
> struct dtv_stats {
> uint8_t                    scale;                /*     0     1 */
> union {
> uint64_t           uvalue;               /*     1     8 */
> int64_t            svalue;               /*     1     8 */
> };                                               /*     1     8 */
> 
> /* size: 9, cachelines: 1, members: 2 */
> /* last cacheline: 9 bytes */
> } __attribute__((__packed__));
> 
> 
> 
> struct dtv_stats {
> uint8_t scale; /* 0 1 */
> union {
> uint64_t uvalue; /* 1 8 */
> int64_t svalue; /* 1 8 */
> }; /* 1 8 */
> 
> /* size: 9, cachelines: 1, members: 2 */
> /* last cacheline: 9 bytes */
> } __attribute__((__packed__));
> 
> 
>>
>> I'm not going to accept this unless it is clear that there are no ABI changes.
> 
> Is there something else that I can try?

No, that's what I needed. I also found some clang discussions here:

https://github.com/llvm/llvm-project/issues/55520

I propose that I add the following sentence to these three packing patches:

"Marking the inner union as 'packed' does not change the layout, since the
whole struct is already packed, it just silences the clang warning. See
also this llvm discussion: https://github.com/llvm/llvm-project/issues/55520"

If you are OK with that, then I can add that to your patches.

Related to this: I added CEC and DVB support to the ABI checks in the build
scripts. And fixed a bunch of mistakes there (e.g. 'false=true' where I meant
to write 'fail=true'!) that made the ABI checks useless.

I updated the abi/* files accordingly as well.

Regards,

	Hans

> 
> Regards!
> 
>>
>> Note that the ABI test in the build scripts only tests V4L2 at the moment,
>> not the DVB API.
>>
>> Regards,
>>
>>         Hans
>>
> 
> 


