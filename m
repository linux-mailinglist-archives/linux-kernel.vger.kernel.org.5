Return-Path: <linux-kernel+bounces-104769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCB087D362
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DD91C21A79
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377114E1DB;
	Fri, 15 Mar 2024 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBpNPuvQ"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2688D52F67;
	Fri, 15 Mar 2024 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526272; cv=none; b=IxhJPbzC4E26CMfZapolTUk3xy4xg6OdSlGk661qJpOSwJC0Bw9vSt1NWJC+FuR/1myzDWb9wMzyikK3reBaYL6t/Fm1luj/sbN3EcLjIgqpewVoajrrSVgS1jA/xvk0pDh7q/hyFEA6fEU+wRnkSn34cJmyFZp6hyHuXgDj5HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526272; c=relaxed/simple;
	bh=j9QIo+jCdhoiNtOSD/8EpbL+Ms0m/c15WxP70y159+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFmCCzJGN00rkbJ9cxh2AcLpPh2E6/XqkwInhalNuK1P2GqM8m6lL+AbzJOS+HoFgkzy3CbPkNKtGx3YsAlfrhXTb7qUpL+07WD/vT5+nXQ46/jhcglo3AQAZdHQ/zziSczJSYDQ26urmycUT6bQHM6+D/IYk/Y0pUVZeL6IjK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBpNPuvQ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso2111583276.0;
        Fri, 15 Mar 2024 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710526268; x=1711131068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wns2fwvyNkdEZZpKRyhgpab3kcINnCYinHWwLelxHhU=;
        b=jBpNPuvQZT9S5VXRP3CFm8YBGsJnh8Nj0b/X/UTIFhTMe2VmrtLE5RVia/2+rS+46s
         Xxwow0tkI3VzYhbFKs1USbqK1jKF7ejAZyCCbwMWG+2cvUhH8MW3hYw6vQjiaH/+eig7
         uBk7E8+YZtC5ysHHFyv7toHJgtMjLxSAuIfW4ICEn7QEaZ6fbQQ1JIeZiPlRVrJ0tS/q
         SDk0Fmnjk8k6DcFaxQWlLdl1MvcEskpKK4H6aMcPengVRF3RlzsRve+7dwHw0f9N1M5e
         gUBOBQ8NXelHYPCzfS6UjxhPYT+pofQvUgm9NaIuhCl58MVKosCiUydUaoEwuK5GpYL9
         9wFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710526268; x=1711131068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wns2fwvyNkdEZZpKRyhgpab3kcINnCYinHWwLelxHhU=;
        b=ZUlSvA1xmv6lMUsi3S5Dl/FaWWaCeWYLAIobD226YQARy5cb+07cHzsfQlefMjzTf1
         0k+Kz45WSsvWiQvRHz4hnaUIF1arptm/e3Zz4LT2QELkbo8g5aavYEYmpJiFotUT1uve
         2Oxb6PkQ/5OAnU26nDmoGYdVy75Q6wggCMn2cy1E14vrqvoDpNrsVJ8icKJ4N+TSV7PF
         tkZAMj+cMPHF6p7ptL5Y8/d6qkWh8lrJlrPvSqvV+gYtHHZBkbIFdENSCD6WN5CRJO/t
         lffjPb8NFXdcSiFsxXEV5qIHisGAJGZsHNA3KOl24+u6M79FVYTtQdn89JEhBeKmq2dn
         XRBw==
X-Forwarded-Encrypted: i=1; AJvYcCV64ect8wW/Om1jk2b3pbydxdV5zGaaSdGpg3e7nRNC/uHF+6oVib9bu7xnJS0ge9pdEoHZgq4vUWhdKRLRQwD3RnJm2f7nu/Ux9GFqMikXHjGwRmmQuVVLiTYe5ifc92CcExH4
X-Gm-Message-State: AOJu0Yw4+brweKmC8ZR6Quiget/FR9MuEFxWBegXMeJBCuRDGMAqoPMq
	Q0//C46UcyparZkzXD2eI0Yb+1tWfsICdDypz29o7YBQCE0S7UG2
X-Google-Smtp-Source: AGHT+IFtmPNyk9mDjkdenKEr/0G1s9O0oEqpdjREeK39S3zOuolNugAqBE58cIP4upNCEGPS1v7kKA==
X-Received: by 2002:a25:ab34:0:b0:dc2:a46:3d29 with SMTP id u49-20020a25ab34000000b00dc20a463d29mr4429807ybi.9.1710526267974;
        Fri, 15 Mar 2024 11:11:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:6c5d:5b71:895e:beb6? ([2600:1700:6cf8:1240:6c5d:5b71:895e:beb6])
        by smtp.gmail.com with ESMTPSA id c11-20020a25f30b000000b00dc74d5e3ff7sm773061ybs.31.2024.03.15.11.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 11:11:07 -0700 (PDT)
Message-ID: <81492d37-47b2-4fca-ba2f-9528c2d41029@gmail.com>
Date: Fri, 15 Mar 2024 11:11:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/2] bpf: Check return from set_memory_rox()
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Kees Cook <keescook@chromium.org>
References: <2b9fdb119ef73cfa4516572026ba4936e86aedca.1710522112.git.christophe.leroy@csgroup.eu>
 <4d7cc25e937403ac61ae61be06f998f27e631a65.1710522112.git.christophe.leroy@csgroup.eu>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <4d7cc25e937403ac61ae61be06f998f27e631a65.1710522112.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/15/24 10:06, Christophe Leroy wrote:
> arch_protect_bpf_trampoline() and alloc_new_pack() call
> set_memory_rox() which can fail, leading to unprotected memory.
> 
> Take into account return from set_memory_rox() function and add
> __must_check flag to arch_protect_bpf_trampoline().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
> v3:
> - Rebased and handled conflict in kernel/bpf/bpf_struct_ops.c
> 
> v2:
> - Move list_add_tail(&pack->list, &pack_list) at the end of alloc_new_pack()
> - Split 2 lines that are reported longer than 80 chars by BPF patchwork's checkpatch report.
> ---
>   arch/arm64/net/bpf_jit_comp.c  |  3 ++-
>   arch/x86/net/bpf_jit_comp.c    |  3 ++-
>   include/linux/bpf.h            |  2 +-
>   kernel/bpf/bpf_struct_ops.c    |  7 +++++--
>   kernel/bpf/core.c              | 29 ++++++++++++++++++++++-------
>   kernel/bpf/trampoline.c        |  8 +++++---
>   net/bpf/bpf_dummy_struct_ops.c |  4 +++-
>   7 files changed, 40 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 132c8ffba109..bc16eb694657 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2176,8 +2176,9 @@ void arch_free_bpf_trampoline(void *image, unsigned int size)
>   	bpf_prog_pack_free(image, size);
>   }
>   
> -void arch_protect_bpf_trampoline(void *image, unsigned int size)
> +int arch_protect_bpf_trampoline(void *image, unsigned int size)
>   {
> +	return 0;
>   }
>   
>   int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 7a56d2d84512..4900b1ee019f 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3004,8 +3004,9 @@ void arch_free_bpf_trampoline(void *image, unsigned int size)
>   	bpf_prog_pack_free(image, size);
>   }
>   
> -void arch_protect_bpf_trampoline(void *image, unsigned int size)
> +int arch_protect_bpf_trampoline(void *image, unsigned int size)
>   {
> +	return 0;
>   }
>   
>   int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d89bdefb42e2..17843e66a1d3 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1116,7 +1116,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   				void *func_addr);
>   void *arch_alloc_bpf_trampoline(unsigned int size);
>   void arch_free_bpf_trampoline(void *image, unsigned int size);
> -void arch_protect_bpf_trampoline(void *image, unsigned int size);
> +int __must_check arch_protect_bpf_trampoline(void *image, unsigned int size);
>   int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>   			     struct bpf_tramp_links *tlinks, void *func_addr);
>   
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 43356faaa057..ca1d9b87c475 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -742,8 +742,11 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   		if (err)
>   			goto reset_unlock;
>   	}
> -	for (i = 0; i < st_map->image_pages_cnt; i++)
> -		arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
> +	for (i = 0; i < st_map->image_pages_cnt && !err; i++)
> +		err = arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
> +
> +	if (err)

nit: Can it be more specific? I mean to check err < 0, so we can reason
that this function never returns a positive value other than 0.

> +		goto reset_unlock;
>   
>   	if (st_map->map.map_flags & BPF_F_LINK) {
>   		err = 0;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 63f100def31b..1e761c3c66db 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -908,23 +908,31 @@ static LIST_HEAD(pack_list);
>   static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_insns)
>   {
>   	struct bpf_prog_pack *pack;
> +	int err;
>   
>   	pack = kzalloc(struct_size(pack, bitmap, BITS_TO_LONGS(BPF_PROG_CHUNK_COUNT)),
>   		       GFP_KERNEL);
>   	if (!pack)
>   		return NULL;
>   	pack->ptr = bpf_jit_alloc_exec(BPF_PROG_PACK_SIZE);
> -	if (!pack->ptr) {
> -		kfree(pack);
> -		return NULL;
> -	}
> +	if (!pack->ptr)
> +		goto out;
>   	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
>   	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
> -	list_add_tail(&pack->list, &pack_list);
>   
>   	set_vm_flush_reset_perms(pack->ptr);
> -	set_memory_rox((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
> +	err = set_memory_rox((unsigned long)pack->ptr,
> +			     BPF_PROG_PACK_SIZE / PAGE_SIZE);
> +	if (err)
> +		goto out_free;
> +	list_add_tail(&pack->list, &pack_list);
>   	return pack;
> +
> +out_free:
> +	bpf_jit_free_exec(pack->ptr);
> +out:
> +	kfree(pack);
> +	return NULL;
>   }
>   
>   void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
> @@ -939,9 +947,16 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
>   		size = round_up(size, PAGE_SIZE);
>   		ptr = bpf_jit_alloc_exec(size);
>   		if (ptr) {
> +			int err;
> +
>   			bpf_fill_ill_insns(ptr, size);
>   			set_vm_flush_reset_perms(ptr);
> -			set_memory_rox((unsigned long)ptr, size / PAGE_SIZE);
> +			err = set_memory_rox((unsigned long)ptr,
> +					     size / PAGE_SIZE);
> +			if (err) {
> +				bpf_jit_free_exec(ptr);
> +				ptr = NULL;
> +			}
>   		}
>   		goto out;
>   	}
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 04fd1abd3661..cc50607f8d8c 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -456,7 +456,9 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>   	if (err < 0)
>   		goto out_free;

Same here

>   
> -	arch_protect_bpf_trampoline(im->image, im->size);
> +	err = arch_protect_bpf_trampoline(im->image, im->size);
> +	if (err)
> +		goto out_free;
>   
>   	WARN_ON(tr->cur_image && total == 0);
>   	if (tr->cur_image)
> @@ -1072,10 +1074,10 @@ void __weak arch_free_bpf_trampoline(void *image, unsigned int size)
>   	bpf_jit_free_exec(image);
>   }
>   
> -void __weak arch_protect_bpf_trampoline(void *image, unsigned int size)
> +int __weak arch_protect_bpf_trampoline(void *image, unsigned int size)
>   {
>   	WARN_ON_ONCE(size > PAGE_SIZE);
> -	set_memory_rox((long)image, 1);
> +	return set_memory_rox((long)image, 1);
>   }
>   
>   int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
> diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
> index de33dc1b0daa..25b75844891a 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -133,7 +133,9 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>   	if (err < 0)
>   		goto out;
>   
> -	arch_protect_bpf_trampoline(image, PAGE_SIZE);
> +	err = arch_protect_bpf_trampoline(image, PAGE_SIZE);
> +	if (err)

Same here.

> +		goto out;
>   	prog_ret = dummy_ops_call_op(image, args);
>   
>   	err = dummy_ops_copy_args(args);

