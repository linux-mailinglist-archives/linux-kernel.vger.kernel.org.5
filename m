Return-Path: <linux-kernel+bounces-42507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF694840256
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210D31C22391
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5321D56469;
	Mon, 29 Jan 2024 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RNlgWAFy"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02C5644B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706522296; cv=none; b=JBawX9jIVxAFXv03BMy2FwAlJrrr0QbnoQDreLG65X+LKKLw8YlMgervOSE6vV+Ts9GebkFgG1keIG8Ixm5BUXOL6he50IbCaDD3+pdxnQfowD2bCZP3WJXQ/Bv4xkIVWTC3YiUVtS+W2a88XiMrZqW8U1M+qN+kcMfrFnSgu74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706522296; c=relaxed/simple;
	bh=0nRlWJibNBWrP/2+ulbYIt6Yw5St4sDPPbMGqESeuNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aERLLInfLypFKOacq3qz3vkbFW8sWPI5dwcLcoY+jVdy8uFA330QQT2QmFX4WHHTs5DJKmS4WWCbGtYGZ6FsdUFJKofqQS9iVPgJaIj3dzGJv/SrLppZghS4QuuMzB9HLAppu4wB0EPk8HmIgYocv0iJJjA5r7kTlfDSdCsDNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RNlgWAFy; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso1792318a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706522293; x=1707127093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y/yj2cF4QFPTINMOJ5Odb3ijjKjStQFfbkPQ+E8TM9k=;
        b=RNlgWAFymMFKB1KEo7jH+RHIQNT28ekJbYNTSENDaalXis+6y1iBW0fOQGnGryBZXF
         M37I1DmiNkwo2xfZEUvv5UjtDudZxeTfY64M0FfKOsN8CR+HQs2iRVdDU1wliwQ5G42I
         mscyRe8fUxTacV0U0bRBYktI7S6ERHfZtlpZtzAEQ9YcK4k7/bRnolmOt871rpLoBBD+
         hbPnBEsbbDsPe21lwfmufus032ca4lvxuEFyQ/c+4lXGmGQXTAq1l5CiuWctE2CtxKva
         v6sz2k2ORTC7QkDb2POt2tn0J4GpfrecWoBjBPFEnyCs7SbanydC8Kh1Ao8/PJPe4uPV
         RTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706522293; x=1707127093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/yj2cF4QFPTINMOJ5Odb3ijjKjStQFfbkPQ+E8TM9k=;
        b=rIuaq8qToIXIJbDJqSe0aDleUqoGtU+3DpdjLd0yceIrlzoRmF2arWDA+GD15t7ulI
         afXKRIWIaaifFa2g+JAcb7BacZr8GbHJ6dipNZ0+1FiSNxm9kinfpxDWjw33Dyxj35Jp
         BwFh4+KMr+U11iALjgOm3YbQMQx4unhVzy1CAPs/O/OLhc6xPOYsu8HJxh8IR9vDY6GU
         FlaZqxgHhAu7d5W/JEWjM7g02xK535l+XZWp4cwlyIHEFtIKpyFxBMACpzQu1mWI8nhn
         7CPysJzlruRhXK+Ob4maxDl4/k3RFTN7M6MPs9qRSJjaaIgMvXw8W4Bte5qQrhHtAjyT
         h6ow==
X-Gm-Message-State: AOJu0YztAjecFXSra1zcQPEZ/HJXYSJqnUhtHMrF4pIfIzLlWysmLTtI
	hMUB/8L0T/cvWpnmTwaWY9WOK/JMBLpR/sv5w+X6HKCRtagXfXmOceno1Bo7GX4=
X-Google-Smtp-Source: AGHT+IGLLoxO4r2cecG2riTmnlc0oiwaiM2/Qa304+OOrXxvULSm26H9zFdDAUUlmZA6ogAFjHFqxA==
X-Received: by 2002:a05:6a20:9591:b0:19c:b4ef:3fa5 with SMTP id iu17-20020a056a20959100b0019cb4ef3fa5mr241147pzb.29.1706522293506;
        Mon, 29 Jan 2024 01:58:13 -0800 (PST)
Received: from [10.255.192.107] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id ju11-20020a170903428b00b001d8ead3d805sm1027576plb.58.2024.01.29.01.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 01:58:12 -0800 (PST)
Message-ID: <d900f0fd-a586-404d-8568-0d2511908067@bytedance.com>
Date: Mon, 29 Jan 2024 17:58:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 5.10 000/286] 5.10.209-rc1 review
To: "Michael S. Tsirkin" <mst@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, llvm@lists.linux.dev, keescook@chromium.org,
 arei.gonglei@huawei.com, jasowang@redhat.com,
 virtualization@lists.linux.dev, linux-crypto@vger.kernel.org
References: <20240122235732.009174833@linuxfoundation.org>
 <6b563537-b62f-428e-96d1-2a228da99077@roeck-us.net>
 <2024012636-clubbed-radial-1997@gregkh>
 <2f342268-8517-4c06-8785-96a588d20c63@roeck-us.net>
 <20240126203436.GA913905@dev-arch.thelio-3990X>
 <0a194a79-e3a3-45e7-be98-83abd3e1cb7e@roeck-us.net>
 <20240126223554.GA1320833@dev-arch.thelio-3990X>
 <bef7737e-4b8e-4a89-b538-cd8e75874fd2@roeck-us.net>
 <20240129034304-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <20240129034304-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/24 16:46, Michael S. Tsirkin wrote:
> On Fri, Jan 26, 2024 at 03:55:02PM -0800, Guenter Roeck wrote:
>> On 1/26/24 14:35, Nathan Chancellor wrote:
>>> (slimming up the CC list, I don't think this is too relevant to the
>>> wider stable community)
>>>
>>> On Fri, Jan 26, 2024 at 01:01:15PM -0800, Guenter Roeck wrote:
>>>> On 1/26/24 12:34, Nathan Chancellor wrote:
>>>>> On Fri, Jan 26, 2024 at 10:17:23AM -0800, Guenter Roeck wrote:
>>>>>> On 1/26/24 09:51, Greg Kroah-Hartman wrote:
>>>>>>> On Fri, Jan 26, 2024 at 08:46:42AM -0800, Guenter Roeck wrote:
>>>>>>>> On 1/22/24 15:55, Greg Kroah-Hartman wrote:
>>>>>>>>> This is the start of the stable review cycle for the 5.10.209 release.
>>>>>>>>> There are 286 patches in this series, all will be posted as a response
>>>>>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>>>>>> let me know.
>>>>>>>>>
>>>>>>>>> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
>>>>>>>>> Anything received after that time might be too late.
>>>>>>>>>
>>>>>>>> [ ... ]
>>>>>>>>
>>>>>>>>> zhenwei pi <pizhenwei@bytedance.com>
>>>>>>>>>          virtio-crypto: implement RSA algorithm
>>>>>>>>>
>>>>>>>>
>>>>>>>> Curious: Why was this (and its subsequent fixes) backported to v5.10.y ?
>>>>>>>> It is quite beyond a bug fix. Also, unless I am really missing something,
>>>>>>>> the series (or at least this patch) was not applied to v5.15.y, so we now
>>>>>>>> have functionality in v5.10.y which is not in v5.15.y.
>>>>>>>
>>>>>>> See the commit text, it was a dependency of a later fix and documented
>>>>>>> as such.
>>>>>>>
>>>>>>> Having it in 5.10 and not 5.15 is a bit odd, I agree, so patches are
>>>>>>> gladly accepted :)
>>>>>>>
>>>>>>
>>>>>> We reverted the entire series from the merge because it results in a build
>>>>>> failure for us.
>>>>>>
>>>>>> In file included from /home/groeck/src/linux-chromeos/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:10:
>>>>>> In file included from /home/groeck/src/linux-chromeos/include/linux/mpi.h:21:
>>>>>> In file included from /home/groeck/src/linux-chromeos/include/linux/scatterlist.h:5:
>>>>>> In file included from /home/groeck/src/linux-chromeos/include/linux/string.h:293:
>>>>>> /home/groeck/src/linux-chromeos/include/linux/fortify-string.h:512:4: error: call to __read_overflow2_field declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>>>>>>                            __read_overflow2_field(q_size_field, size);
>>>>>
>>>>> For what it's worth, this is likely self inflicted for chromeos-5.10,
>>>>> which carries a revert of commit eaafc590053b ("fortify: Explicitly
>>>>> disable Clang support") as commit c19861d34c003 ("CHROMIUM: Revert
>>>>> "fortify: Explicitly disable Clang support""). I don't see the series
>>>>> that added proper support for clang to fortify in 5.18 that ended with
>>>>> commit 281d0c962752 ("fortify: Add Clang support") in that ChromeOS
>>>>> branch, so this seems somewhat expected.
>>>>>
>>>>
>>>> That explains that ;-). I don't mind if the patches stay in v5.10.y,
>>>> we have them reverted anyway.
>>>>
>>>> The revert was a pure process issue, as you may see when looking into
>>>> commit c19861d34c003, so, yes, I agree that it is self-inflicted damage.
>>>> Still, that doesn't explain why the problem exists in 5.18+.
>>>>
>>>>>> I also see that upstream (starting with 6.1) when trying to build it with clang,
>>>>>> so I guess it is one of those bug-for-bug compatibility things. I really have
>>>>>> no idea what causes it, or why we don't see the problem when building
>>>>>> chromeos-6.1 or chromeos-6.6, but (so far) only with chromeos-5.10 after
>>>>>> merging 5.10.209 into it. Making things worse, the problem isn't _always_
>>>>>> seen. Sometimes I can compile the file in 6.1.y without error, sometimes not.
>>>>>> I have no idea what triggers the problem.
>>>>>
>>>>> Have a .config that reproduces it on upstream? I have not personally
>>>>> seen this warning in my build matrix nor has our continuous-integration
>>>>> matrix (I don't see it in the warning output at the bottom but that
>>>>> could have missed something for some reason) in 6.1:
>>>>>
>>>>
>>>> The following command sequence reproduces the problem for me with all stable
>>>> branches starting with 5.18.y (plus mainline).
>>>>
>>>> rm -rf /tmp/crypto-build
>>>> mkdir /tmp/crypto-build
>>>> make -j CC=clang-15 mrproper >/dev/null 2>&1
>>>> make -j O=/tmp/crypto-build CC=clang-15 allmodconfig >/dev/null 2>&1
>>>> make -j O=/tmp/crypto-build W=1 CC=clang-15 drivers/crypto/virtio/virtio_crypto_akcipher_algs.o
>>>>
>>>> I tried clang versions 14, 15, and 16. This is with my home system running
>>>> Ubuntu 22.04, no ChromeOS or Google specifics/internals involved. For clang-15,
>>>> the version is
>>>>
>>>> Ubuntu clang version 15.0.7
>>>> Target: x86_64-pc-linux-gnu
>>>> Thread model: posix
>>>> InstalledDir: /usr/bin
>>>
>>> Okay interesting, this warning is hidden behind W=1, which our CI does
>>> not test with. Looks like it has been that way since the introduction of
>>> these checks in f68f2ff91512 ("fortify: Detect struct member overflows
>>> in memcpy() at compile-time").
>>>
>>
>> Interestingly the warning is seen in chromeos-5.10, without this patch,
>> and without W=1. I guess that must have to do with the revert which is
>> finally biting us.
>>
>>> I think this is a legitimate warning though. It is complaining about the
>>> second memcpy() in virtio_crypto_alg_akcipher_init_session():
>>>
>>>     memcpy(&ctrl->u, para, sizeof(ctrl->u));
>>>
>>> where ctrl is:
>>>
>>>     struct virtio_crypto_op_ctrl_req {
>>>             struct virtio_crypto_ctrl_header header;         /*     0    16 */
>>>             union {
>>>                     struct virtio_crypto_sym_create_session_req sym_create_session; /*    16    56 */
>>>                     struct virtio_crypto_hash_create_session_req hash_create_session; /*    16    56 */
>>>                     struct virtio_crypto_mac_create_session_req mac_create_session; /*    16    56 */
>>>                     struct virtio_crypto_aead_create_session_req aead_create_session; /*    16    56 */
>>>                     struct virtio_crypto_akcipher_create_session_req akcipher_create_session; /*    16    56 */
>>>                     struct virtio_crypto_destroy_session_req destroy_session; /*    16    56 */
>>>                     __u8               padding[56];          /*    16    56 */
>>>             } u;                                             /*    16    56 */
>>>             union {
>>>                     struct virtio_crypto_sym_create_session_req sym_create_session; /*     0    56 */
>>>                     struct virtio_crypto_hash_create_session_req hash_create_session; /*     0    56 */
>>>                     struct virtio_crypto_mac_create_session_req mac_create_session; /*     0    56 */
>>>                     struct virtio_crypto_aead_create_session_req aead_create_session; /*     0    56 */
>>>                     struct virtio_crypto_akcipher_create_session_req akcipher_create_session; /*     0    56 */
>>>                     struct virtio_crypto_destroy_session_req destroy_session; /*     0    56 */
>>>                     __u8                       padding[56];          /*     0    56 */
>>>             };
>>>
>>>
>>>             /* size: 72, cachelines: 2, members: 2 */
>>>             /* last cacheline: 8 bytes */
>>>     };
>>>
>>> (so size and p_size_field should be 56) and the type of the para
>>> parameter in virtio_crypto_alg_akcipher_init_session() is 'void *' but
>>> the para passed by reference to
>>> virtio_crypto_alg_akcipher_init_session() in virtio_crypto_rsa_set_key()
>>> has a type of 'struct virtio_crypto_akcipher_session_para':
>>>
>>>     struct virtio_crypto_akcipher_session_para {
>>>             __le32                     algo;                 /*     0     4 */
>>>             __le32                     keytype;              /*     4     4 */
>>>             __le32                     keylen;               /*     8     4 */
>>>             union {
>>>                     struct virtio_crypto_rsa_session_para rsa; /*    12     8 */
>>>                     struct virtio_crypto_ecdsa_session_para ecdsa; /*    12     8 */
>>>             } u;                                             /*    12     8 */
>>>             union {
>>>                     struct virtio_crypto_rsa_session_para rsa;       /*     0     8 */
>>>                     struct virtio_crypto_ecdsa_session_para ecdsa;   /*     0     8 */
>>>             };
>>>
>>>
>>>             /* size: 20, cachelines: 1, members: 4 */
>>>             /* last cacheline: 20 bytes */
>>>     };
>>>
>>> (so q_size_field would be 20 if clang were able to do inlining to see
>>> through the 'void *'...?), which would result in the
>>>
>>>     __compiletime_lessthan(q_size_field, size)
>>>
>>> check succeeding and triggering the warning because 20 < 56, so it does
>>> seem like there is an overread of the source buffer here? Adding the
>>
>> Looks like it; I think either the passed 'para' should be of type
>> virtio_crypto_akcipher_create_session_req() or it should only copy
>> sizeof(struct virtio_crypto_akcipher_session_para) bytes.
>>
>> Anyway, how did you find that ? Is there a magic trick to find the
>> actual code causing the warning ? I am asking because we had seen
>> similar warnings before, and it would help to know how to find the
>> problematic code.
>>
>> Thanks,
>> Guenter
> 
> 
> 
> Cc: zhenwei pi <pizhenwei@bytedance.com>
> 
> Zhenwei I think you wrote most of the code here.
> Can you take a look please?
> Stack overflows are plus plus ungood.
> 
> 
> 
> 
>>> maintainers of the driver and subsystem in question.
>>>
>>> Cheers,
>>> Nathan
> 

I can also reproduce this warning by commands on ubuntu-2204:
make -j CC=clang-14 mrproper >/dev/null 2>&1
make -j O=/tmp/crypto-build CC=clang-14 allmodconfig >/dev/null 2>&1
make -j O=/tmp/crypto-build W=1 CC=clang-14 
drivers/crypto/virtio/virtio_crypto_akcipher_algs.o

so sorry on this issue, I think Guenter's suggestion is right(also test 
by these commands), I'll send a fix later.

-- 
zhenwei pi

