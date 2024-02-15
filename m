Return-Path: <linux-kernel+bounces-67541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638C4856D31
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC34288A89
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FB11386C2;
	Thu, 15 Feb 2024 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b="e08WsBox"
Received: from cmx-torrgo001.bell.net (mta-tor-001.bell.net [209.71.212.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C4A1EA7C;
	Thu, 15 Feb 2024 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.71.212.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023405; cv=none; b=H/5LmWO/Hhxy/bG2ay2ENlbwXT9urJvAtVqM1mZbTRqVGEGkO4ioEiMvpB5/iQqOduf/TwXvGx/LXLmD7y0fbo7Z5JN7cVOq7tEguUgHAarg5JDViMFtV67eJT2avj5SgKJmBX4L0y3lPbB6coGTGw5G6Bj7VpIFBDtoUQtQUb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023405; c=relaxed/simple;
	bh=gER4Vd+ai70jUG45UghcGjdobwH4FoQ8GObQlj7lTyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxuNt3/GU0/i16KQcwNtravBZp3eZ4JGiYQIo30QSCSICTIIYEb8JvANSsTktvTSUmELmQ8Ek7/IfJSrx617YKEnUJsfQGLNiZfxaA1vcoWl54e1urPCWANhIIB/2cT4cwCYmQ+mTUUUn8zFUUnEIbpf384ECmdPuauJ3kn/kkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net; spf=pass smtp.mailfrom=bell.net; dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b=e08WsBox; arc=none smtp.client-ip=209.71.212.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bell.net; s=selector1; t=1708023403; 
        bh=S3ZkdKdSM97Ryio1K95PdUfsu1Zs9FEuw3CMKBjbQ6k=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type;
        b=e08WsBoxyDP5aRShEqqYqaN9k67cVGBk4XZd4TMs1ptL9oHTsNw96gSJqWgCc4GM1fzp3Z+hVxuCxB9pfUBNJbPlAdxEjfwl6qVQ0smG7KW/M+JrOu73KLTH3fkJWW7IVe5LF48aOejnxVujVPQcLp08C/XJNy/qlXLWj3jNdfKNDIwTaKbPLRyGh/RzDFfVV1ICjxq8/wJS5zoaiq+qlNGMLpPQc+tiJZ53vgV6RoYSG8rHTzMSJK+rP6oyi8ZRboYbBD3UXZqaLrECjANpDOw9diLe0xigAT65pKU0F13zUKaa/bj6fU6dxQy8uxCduABCCgrUiKRrXp/cFmxPPA==
X-RG-SOPHOS: Clean
X-RG-VADE-SC: 0
X-RG-VADE: Clean
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 65CD68AA0011B80A
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuefgnffnpdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheplfhohhhnucffrghvihguucetnhhglhhinhcuoegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeelffffjeehgffgueehleegfeegueeigedtkeffgeduueetffegffejudekgfeunecukfhppedugedvrdduvdeirdduuddvrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddvrdeglegnpdhinhgvthepudegvddruddviedrudduvddrvdeffedpmhgrihhlfhhrohhmpegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepffgrvhhiugdrnfgrihhghhhtseetvegfnfetuedrvefqofdprhgtphhtthhopeflrghmvghsrdeuohhtthhomhhlvgihsehhrghnshgvnhhprghrthhnvghrshhhihhprdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopegurghvvgdrrghnghhlihhnsegs
	vghllhdrnhgvthdprhgtphhtthhopeguvghllhgvrhesghhmgidruggv
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.2.49] (142.126.112.233) by cmx-torrgo001.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 65CD68AA0011B80A; Thu, 15 Feb 2024 13:56:20 -0500
Message-ID: <405791f1-7e51-4ccd-8ec3-b0be6ee8f203@bell.net>
Date: Thu, 15 Feb 2024 13:56:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, David Laight
 <David.Laight@ACULAB.COM>, Charlie Jenkins <charlie@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net>
 <a7e9691432374000b9566a0201d004e6@AcuMS.aculab.com>
 <c22f28a2-b042-4abe-b9e4-a925b97073bb@roeck-us.net>
 <4723822c-2acf-4c41-899c-1e3d5659d1d8@bell.net>
 <1e302d8f-4e94-4278-b556-b8fc54956efb@roeck-us.net>
 <e73bdc36-5fb1-4ea8-9f96-608eb1a9b6af@bell.net>
 <34c8d6f6-3449-4a5f-b8c8-50faf1621714@roeck-us.net>
From: John David Anglin <dave.anglin@bell.net>
Autocrypt: addr=dave.anglin@bell.net; keydata=
 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
 T70V9SSrl2hiw38vRzsl
In-Reply-To: <34c8d6f6-3449-4a5f-b8c8-50faf1621714@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-15 1:17 p.m., Guenter Roeck wrote:
> On 2/15/24 09:25, John David Anglin wrote:
> [ ... ]
>>>>> Source:
>>>>>
>>>>> static bool pc_is_kernel_fn(unsigned long pc, void *fn)
>>>>> {
>>>>>         return (unsigned long)dereference_kernel_function_descriptor(fn) == pc;
>>>> This looks wrong to me.  Function descriptors should always be 8-byte aligned.  I think this
>>>> routine should return false if fn isn't 8-byte aligned.
>>>
>>> Below you state "Code entry points only need 4-byte alignment."
>>>
>>> I think that contradicts each other. Also, the calling code is,
>>> for example,
>>>     pc_is_kernel_fn(pc, syscall_exit)
>>>
>>> I fail to see how this can be consolidated if it is ok
>>> that syscall_exit is 4-byte aligned but, at the same time,
>>> must be 8-byte aligned to be considered to be a kernel function.
>> In the above call, syscall_exit is treated as a function pointer. It points to an 8-byte aligned
>> function descriptor.  The descriptor holds the actual address of the function.  It only needs
>> 4-byte alignment.
>>
>> Descriptors need 8-byte alignment for efficiency on 64-bit parisc. The pc and gp are accessed
>> using ldd instructions.
>>
>
> Maybe code such as
>     pc_is_kernel_fn(pc, syscall_exit)
> is wrong because syscall_exit doesn't point to a function descriptor
> but to the actual address. The code and comments in arch/parisc/kernel/unwind.c
It depends on how syscall_exit is declared.    unwind.c lies the type of handle_interruption, etc:

         extern void * const handle_interruption;
         extern void * const ret_from_kernel_thread;
         extern void * const syscall_exit;
         extern void * const intr_return;
         extern void * const _switch_to_ret;
#ifdef CONFIG_IRQSTACKS
         extern void * const _call_on_stack;
#endif /* CONFIG_IRQSTACKS */

This should yield actual addresses.
> is for sure confusing because it talks about not using
> dereference_kernel_function_descriptor() to keep things simple but then calls
> dereference_kernel_function_descriptor() anyway. Maybe it should just be
>     if (pc == syscall_exit)
> instead.
Looks like.
>
> The entire code is really odd anyway.
>
>         ptr = dereference_kernel_function_descriptor(&handle_interruption);
>         if (pc_is_kernel_fn(pc, ptr)) {
>
> and then pc_is_kernel_fn() dereferences it again. Weird.
>
> It looks like commit 8e0ba125c2bf ("parisc/unwind: fix unwinder when
> CONFIG_64BIT is enabled") might have messed this up. No idea how to fix
> it properly, though.
This is Helge's code...  I'll let him fix it.

Dave

-- 
John David Anglin  dave.anglin@bell.net


