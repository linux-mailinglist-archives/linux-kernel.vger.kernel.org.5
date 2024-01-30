Return-Path: <linux-kernel+bounces-44772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033DD842731
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3653F1C261FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71E17CF37;
	Tue, 30 Jan 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LN0qj8HA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBA182D93;
	Tue, 30 Jan 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626361; cv=none; b=PFbOzvprX/49qSV2n/Y9XcANeO6nWUccQSkWforrAljVRWeXhTgpysa9l+l9pQ3JEwz4L2tpocn+7MfCp8RgjCu4UrUm+gZJhwrN1VN5HFuqXzMwESr+Nfd0zPokQH7JLQoJc1n+qeIDeMoDTx9aYr4Qp4mq7x0MxcagqKJrIy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626361; c=relaxed/simple;
	bh=luIPTT9ucV8TGKHJ9MflOF0EHUFroE6No1+xpuWNnbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tStatmvrVHQBKQvild28eshli6FT6roco+yd1H9xZCJFd0Acl8saPoLERB/mVJjz84uDeE2eOrRXQMYPBhtudglD2ULGoHdZOPh4J3dkVUqagzUlLAL7fYsQamJhKH1smrHw6VW/bhpmM1fZi7EcLrYZoNKDFMOXJWohKEi2lDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LN0qj8HA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706626359; x=1738162359;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=luIPTT9ucV8TGKHJ9MflOF0EHUFroE6No1+xpuWNnbM=;
  b=LN0qj8HAMcBBv5cJ9j1Uf1v0ZN1yeh3M8Igb544+AOpi2dO+iEHxai+7
   arKWtWB9+5hX6dFLl6CNujSHMPH46tO78675udOeoLPPUx1VL49PHtcFP
   6XGVAK1kv2U/FuIR79NP/caMgGwyU05g2i5U5jUW8M6McaJ1+zs4gtgaF
   E5XEc4W88oViC2Y8zs+8DGyI8/003DJsG0FIQwjY1OXttwuLt3lD7woOU
   cpx3y1jfzRB+cifCixgOSj5VafPjSyp+rx4XmIPEEMa3LPKrRgnx81hq8
   OxO7t/xQ7RT8r3HhlOkQXsZpMaTW8gTKS5H69la6ZtZhDwn+E5/F8LqYI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3149927"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3149927"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 06:52:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="30180161"
Received: from skofoed-mobl.ger.corp.intel.com (HELO [10.249.254.21]) ([10.249.254.21])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 06:52:34 -0800
Message-ID: <90b41ce3-0eca-4bc9-bc04-ad68ba91d7ee@linux.intel.com>
Date: Tue, 30 Jan 2024 15:52:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Enable -Wstringop-overflow globally
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 David Laight <David.Laight@ACULAB.COM>,
 'Linus Torvalds' <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Lucas De Marchi
 <lucas.demarchi@intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 intel-xe@lists.freedesktop.org,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <Za6JwRpknVIlfhPF@work>
 <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
 <4907a7a3-8533-480a-bc3c-488573e18e66@embeddedor.com>
 <202401261423.7AF702239@keescook>
 <CAHk-=wiaaCatzmF6GXxP97pa8oEX7e4rBpd4JgsbKex3Ek1_9A@mail.gmail.com>
 <f00e15fcba05497a87e91182a33c888f@AcuMS.aculab.com>
 <0c4cc1a7-f409-4597-b110-81f9e45d1ffe@embeddedor.com>
From: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
In-Reply-To: <0c4cc1a7-f409-4597-b110-81f9e45d1ffe@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 1/27/24 20:53, Gustavo A. R. Silva wrote:
>
>
> On 1/27/24 09:11, David Laight wrote:
>> From: Linus Torvalds
>>> Sent: 26 January 2024 22:36
>>>
>>> On Fri, 26 Jan 2024 at 14:24, Kees Cook <keescook@chromium.org> wrote:
>>>>
>>>> I think xe has some other weird problems too. This may be related 
>>>> (under
>>>> allocating):
>>>>
>>>> ../drivers/gpu/drm/xe/xe_vm.c: In function 'xe_vma_create':
>>>> ../drivers/gpu/drm/xe/xe_vm.c:806:21: warning: allocation of 
>>>> insufficient size '224' for type
>>> 'struct xe_vma' with size '368' [-Walloc-size]
>>>>    806 |                 vma = kzalloc(sizeof(*vma) - sizeof(struct 
>>>> xe_userptr),
>>>>        |                     ^
>>>
>>> That code is indeed odd, but there's a comment in the xe_vma definition
>>>
>>>          /**
>>>           * @userptr: user pointer state, only allocated for VMAs 
>>> that are
>>>           * user pointers
>>>           */
>>>          struct xe_userptr userptr;
>>>
>>> although I agree that it should probably simply be made a final
>>> variably-sized array instead (and then you make that array size be
>>> 0/1).
>>
>> That entire code is odd.
>> It isn't obvious that the flag values that cause the short allocate
>> are the same ones that control whether the extra data is accessed.
>>
>> Never mind the oddities with the 'flags |= ' assignments int the
>> 'remap next' path.
>>
>> Anyone know how many of these actually get allocated (and their
>> lifetimes)?
>> How much difference would it make to allocate 368 (maybe 384?)
>> bytes instead of 224 (likely 256).
>
> [CC+ xen list and maintainers]
>
> Probably the xen maintainer can help us out here.

Unfortunately the number of these can be quite large, and with a long 
lifetime which I guess was the reason that size optimization was done in 
the first place.

Ideally IMO this should've been subclassed to an xe_userptr_vma, but 
until we have a chance to clean that up, We can look at the 
variable-sized array or simply allocate the full size until we get to that.

Thanks,

Thomas


>
> -- 
> Gustavo
>
>>
>>     David
>>
>> -
>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, 
>> MK1 1PT, UK
>> Registration No: 1397386 (Wales)

