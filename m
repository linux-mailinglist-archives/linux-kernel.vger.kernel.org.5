Return-Path: <linux-kernel+bounces-104925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D88D87D5F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A771F22AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E023154901;
	Fri, 15 Mar 2024 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t4qE5XXz"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F834548F0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710537129; cv=none; b=LTQF6iFiKD80JkJwlnMps4rwHfDULtUL9D2+Hv0YZxeLUJ+sQHdiIBxNx1jjhC5VnjL+9734PH+0jN3aiE1im8HYsyWBQZGlCCF/4i5oeJdoUmNvx1IJcwF254phVpSVgT05ojnKbSGFbOJjo9kDMBRt+qto6YgNtdh795INVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710537129; c=relaxed/simple;
	bh=n/ul0ogx7iwzi5n9hjSGc4kclaFxVnfk7TjW0NiHHcU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ve/d8XeVgWpgWmM/LLAAvJwNn+ZGWIT3a9blLRCxS8WPF0UYZbF5PXxf4hWv9/6G9TrszhkaXdJDyEsFpy1ij40igecBDf5cdeiFdT8dJlNGjJWSydt9Dp8dDRStgqutHxVYplBIh2N+Vfo3LXx5x6NIgmccAk3o0TewA0FpE4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t4qE5XXz; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5f450439-3400-45cb-bb62-4559bd6e088e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710537124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOAHpfzXDspbl58UkIknw9ZqxHAdHjN22/pRm7dUv/A=;
	b=t4qE5XXzsRE50gGpMBjUHqk5Bu4EZG4MzUQBEyCuL5dXlhgz0ShnsZPiF6CtWiV+W1m7xj
	M2yCNnU7rX1uVEIErJHuaNgglF/wVvku1w7OW6Ye7fMWu320FPJZjouURI7uFEu2Sbw/6T
	qXnUkC8vJnpGnHHnnsupyN0I6GBMr1U=
Date: Fri, 15 Mar 2024 14:11:51 -0700
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
In-Reply-To: <55151dc9-8edf-4c75-b1d0-1cc0437816c3@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/15/24 1:55 PM, Martin KaFai Lau wrote:
> On 3/15/24 10:06 AM, Christophe Leroy wrote:
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 43356faaa057..ca1d9b87c475 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -742,8 +742,11 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map 
>> *map, void *key,
>>           if (err)
>>               goto reset_unlock;
>>       }
>> -    for (i = 0; i < st_map->image_pages_cnt; i++)
>> -        arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
>> +    for (i = 0; i < st_map->image_pages_cnt && !err; i++)
>> +        err = arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
>> +
>> +    if (err)
>> +        goto reset_unlock;
> 
> This part does not look right. The "if (err)" check should be inside the for loop.

ah. Please ignore. missed the "!err" in the for loop.

