Return-Path: <linux-kernel+bounces-105017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5375187D7B1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3F51C210D9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9634D1FA6;
	Sat, 16 Mar 2024 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BH7hxmhU"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEE910FD;
	Sat, 16 Mar 2024 00:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550599; cv=none; b=hgyUZvMUZSvOY7QMLz/XzRSjMbirLF+CHsDLcFvbX91GksF+0K3h9LSay1d1gmtcP1wb/GD6FKvjsZwC/3a73xw0iwutO/4+s0YKRmHrBxZ7AQY0Bu591nZ2dczaU3Ak8a5gPytDSFTq+JLteu7zhDIB9rcM+RUk9ixWWjtm1bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550599; c=relaxed/simple;
	bh=bPfFJhVHE2biA6KUtBwzGPzy4ZeiHLm2xIIVTFfgees=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=X7gVVmaoZBB2ZvuHIVrlgcPPPrAtvk9PYn02L7wvNauIUre51JA+a2CKQ+hS6xjlDr9xHx8ydpGRMuS9Dt/XjtgFkcTRpkv5NiEoNqIP8oZAz+7OcFqtiKO9nIjxGfsXB1a6NrnxtT7WcOBninxUvJP575iLIx6xIn6v7RLUhRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BH7hxmhU; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3ddb16ca-83b8-42dc-9c28-4527905e5fe3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710550595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPI3Clq/u50XsFhM58woftYSJqswXV/yKNjzVYbfKKU=;
	b=BH7hxmhUmfkNhC8dV/0vdk9tlDmosGsONe+WwzojsKS6Ku+LtEAwqvZ9s6Pp0JvEteNJF+
	SMnWEKs+/te50m7J3C/gVXOoYZ1XMShmeUNJEOtTbTtkKo0z+OsSeokZEOEDB2x58ij+Cr
	Q3DpY2yzRt65b5dZAnxekGAxBHujrxk=
Date: Fri, 15 Mar 2024 17:56:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Check return from set_memory_rox()
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Kees Cook <keescook@chromium.org>
References: <2b9fdb119ef73cfa4516572026ba4936e86aedca.1710522112.git.christophe.leroy@csgroup.eu>
 <4d7cc25e937403ac61ae61be06f998f27e631a65.1710522112.git.christophe.leroy@csgroup.eu>
 <55151dc9-8edf-4c75-b1d0-1cc0437816c3@linux.dev>
 <5f450439-3400-45cb-bb62-4559bd6e088e@linux.dev>
In-Reply-To: <5f450439-3400-45cb-bb62-4559bd6e088e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/15/24 2:11 PM, Martin KaFai Lau wrote:
> On 3/15/24 1:55 PM, Martin KaFai Lau wrote:
>> On 3/15/24 10:06 AM, Christophe Leroy wrote:
>>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>>> index 43356faaa057..ca1d9b87c475 100644
>>> --- a/kernel/bpf/bpf_struct_ops.c
>>> +++ b/kernel/bpf/bpf_struct_ops.c
>>> @@ -742,8 +742,11 @@ static long bpf_struct_ops_map_update_elem(struct 
>>> bpf_map *map, void *key,
>>>           if (err)
>>>               goto reset_unlock;
>>>       }
>>> -    for (i = 0; i < st_map->image_pages_cnt; i++)
>>> -        arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
>>> +    for (i = 0; i < st_map->image_pages_cnt && !err; i++)

I was about to apply but I still think checking "&& !err" is not right given how 
"err" is used in the earlier code of this function.

The err may not be 0 in the first iteration of this for loop. Take a look at the 
"if (err > 0)" check in the "for_each_member(i, t, member)" loop above.

>>> +        err = arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
>>> +
>>> +    if (err)
>>> +        goto reset_unlock;
>>
>> This part does not look right. The "if (err)" check should be inside the for 
>> loop.

Instead of adding an extra "err = 0;" before the for loop. It is better to move 
this "if (err) goto reset_unlock;" into the for loop and remove the "&& !err" 
test above.

> 
> ah. Please ignore. missed the "!err" in the for loop.




