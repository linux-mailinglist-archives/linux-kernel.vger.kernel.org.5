Return-Path: <linux-kernel+bounces-82831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACD8868A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8571F22691
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C195F55E71;
	Tue, 27 Feb 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="HOkk93Ix"
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7054F8A;
	Tue, 27 Feb 2024 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.28.160.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020373; cv=none; b=uB9UIi46qlpffNTUnXzaL6IZv/VLZKRaeZw1j2F/ZIIjN20lyuQEcanpD4zZEFAYsmSyZKVkxS78mzpL6kkEY8H6zb9SHz8gYctGaP3HmWQ6quEkPuMMsPhM8TkvStnlusAcdTaXRkE0txGUulh3E1+SYVm7miniPQoXMwjE3Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020373; c=relaxed/simple;
	bh=rM5Amilsj86n+rDVaxHQye/6y7/8IQuzFzrGrKh23Iw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hX+PxNI9IEqxnjOAMGRq4H6/Jg8wijVnXtXGnljXbX98NWxHUnTj3X/+dOWT/XoEBBsVw13VsV+9ZRMA4fdu2gpMOcTZVLomdXEu73/GRXfPmqL0G/5beBXOU5AUM984RNPKeD8XXgmmrcTYvIAYKSgFKXwB3vFjivez3kF+N5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name; spf=pass smtp.mailfrom=xen0n.name; dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b=HOkk93Ix; arc=none smtp.client-ip=115.28.160.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen0n.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
	t=1709020369; bh=rM5Amilsj86n+rDVaxHQye/6y7/8IQuzFzrGrKh23Iw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=HOkk93Ixf+EXfa+wrwsxgBtyXbhDpxeNtEqgk+dbNSORf5f65bzErFKW2k2zV4U8/
	 ZyYNW1jyQswLvGo85MKCzX2HaRC4DhQvcQ+OQoXyl+JxVrY+u0H56d6B+90h4EHGhY
	 gkf4UtRedo6hFBN5MPhxnzqdUZfpHnWNWiuh1/10=
Received: from [28.0.0.1] (unknown [101.230.251.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 9674C6012F;
	Tue, 27 Feb 2024 15:52:48 +0800 (CST)
Message-ID: <48fd3c4d-9b72-4515-9a95-d241857915b4@xen0n.name>
Date: Tue, 27 Feb 2024 15:52:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loongarch/crypto: Clean up useless assignment operations
Content-Language: en-US
From: WANG Xuerui <kernel@xen0n.name>
To: WangYuli <wangyuli@uniontech.com>, herbert@gondor.apana.org.au,
 davem@davemloft.net, chenhuacai@kernel.org
Cc: linux-crypto@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Guan Wentao <guanwentao@uniontech.com>
References: <20240226080328.334021-1-wangyuli@uniontech.com>
 <48afa638-9145-40ee-9868-fa82a1fce271@xen0n.name>
In-Reply-To: <48afa638-9145-40ee-9868-fa82a1fce271@xen0n.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/26/24 16:15, WANG Xuerui wrote:
> On 2/26/24 16:03, WangYuli wrote:
>> Both crc32 and crc32c hw accelerated funcs will calculate the
>> remaining len. Those codes are derived from
>> arch/mips/crypto/crc32-mips.c and "len -= sizeof(u32)" is not
>> necessary for 64-bit CPUs.

It's ultimately unrelated to the width of the running CPU, but rather 
the LoongArch ISA specification. You should mention that because the 
LoongArch ISA manual implies that CRC instructions are only available on 
LA64-compatible implementations, the code can assume 64-bit operation, 
so the 32-bit codepath can be guaranteed to execute only once.

>>
>> Removing it can make context code style more unified and improve
>> code readability.

"Remove it to improve readability." should do it?

>>
>> Suggested-by: Guan Wentao <guanwentao@uniontech.com>
>> Signed-off-by: WangYuli <wangyuli@uniontech.com>
>> ---
>>   arch/loongarch/crypto/crc32-loongarch.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/loongarch/crypto/crc32-loongarch.c 
>> b/arch/loongarch/crypto/crc32-loongarch.c
>> index a49e507af38c..3eebea3a7b47 100644
>> --- a/arch/loongarch/crypto/crc32-loongarch.c
>> +++ b/arch/loongarch/crypto/crc32-loongarch.c
>> @@ -44,7 +44,6 @@ static u32 crc32_loongarch_hw(u32 crc_, const u8 *p, 
>> unsigned int len)
>>           CRC32(crc, value, w);
>>           p += sizeof(u32);
>> -        len -= sizeof(u32);
>>       }
>>       if (len & sizeof(u16)) {
>> @@ -80,7 +79,6 @@ static u32 crc32c_loongarch_hw(u32 crc_, const u8 
>> *p, unsigned int len)
>>           CRC32C(crc, value, w);
>>           p += sizeof(u32);
>> -        len -= sizeof(u32);
>>       }
>>       if (len & sizeof(u16)) {
> 
> Sure, but IIRC Loongson still has hopes in having 32-bit-only models 
> support upstream? The possibility cannot be ruled out because from 
> public information (e.g. the 2023-11-28 news event), Loongson is known 
> to be actively licensing their reduced 32-bit-only IP cores to third 
> parties.
> 
> Ultimately whether we want to imply 64-bit operation with the crc32 
> module is up to Loongson to decide, and I think Huacai may have 
> something to add, but IMO at least we could gate the statement with 
> #ifdef's so we don't outright lose 32-bit compatibility with this code.
> 

I was wrong in assuming that LA32 must contain CRC insns that operate on 
at most 32 bits. In fact this is wrong -- the LA32 subset omits a lot of 
32-bit operations for no apparent reason (perhaps implementation 
simplicity but outsiders cannot confirm). So by definition the code 
cannot be ported to LA32, and the changes are correct.

But for the same reason, the commit message is misleading. See above.
And with the nits addressed:

Reviewed-by: WANG Xuerui <git@xen0n.name>

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/


