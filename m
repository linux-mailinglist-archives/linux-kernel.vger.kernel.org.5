Return-Path: <linux-kernel+bounces-99907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BFB878F05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A0428270F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47E069959;
	Tue, 12 Mar 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EtyZDW4v"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACFC3236
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710227769; cv=none; b=Pkl2OaR5f9Jvl7PP1scRwyc54XpYgt4GwEpHxNrDQXxy7ut2dvt/AFAfJ1q+N9psqLAI/PrpXz3CtfBAdmZuELnId3KpRvietXoM9mO+HKwfIUxp8/D6T9L22zR885dejJ7o0Xj7CQV2HQ4ZN8KPURLe/fCEsZpYSTn5BKvkJx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710227769; c=relaxed/simple;
	bh=emW0M3FKBvoz37Qj9hHkGiFe9VwEqstLXzaRCqVisYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eCDDPU7LZSn44i2PgMw59Zk8oXlAEOmA9dzGcN8tQ0poXbeMfbU+OSbkHZaF4hP5fdLbBhpaJkBFIpnAOowXVfAVZLbugmvs4Zl4+m/Rs+kEgJ7lykivuv1591pk1sZ5I9Vohil9o40mpSN8VdPPNWJZwzAnnSmW5G4JHMMMIpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EtyZDW4v; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso4091149a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710227762; x=1710832562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PFX7WVCFYMo7B4UNiqmgghk8AAJ2gObVtvPhC7KXN2c=;
        b=EtyZDW4varAMMMgSEbJ0t5MIqPJMh1e7ssTbVKmroXiJ/88AsAE0AEjT8bhTWMg1nA
         lwwn4mBYYwAgL3HqX0mSMhMeNds8Pd3jTy4e3jJjbkAocPi53du/zwYYVOfr8H9v0ZP+
         NBRSmRsBSeSM2BB35+nfqjhuu8zsiUNOxVAcQgWFoCyE7Ajoeac8m5LQqqsOJ9F4+xe6
         d2aHjLO8TdbmBTHWONuQnn2jc+yMxH8m0JgiBhXHqM9t3KWhNI+h+QvylgjmUt0ubXSb
         +oy5hFlQGqKmE5fNUYQZ9LUo49VPlle97AMBFWfDMr8YHnnXNrd8/l9921psdfpAdFjV
         kk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710227762; x=1710832562;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PFX7WVCFYMo7B4UNiqmgghk8AAJ2gObVtvPhC7KXN2c=;
        b=kajKyCAwPOzbKRwcmEkB2L/wjwmhwJfuAnUeYulghHyHWS44fGqrNb07QEcBlCRKub
         todXS0E6s5WK5cX95KHPO2D/N0mNyDRzhPhR6EY8zQpJt61PZ2EFYL4YdGVTCPcOpAU5
         FFSoKooa0ZNAoGI69aMCN2jApSkgN3AkohbTemqFUxCJMqeQ1fACyZZYc25EjzxDRsFh
         eBlsfhGKRj/dn8Pj1oeNpydl2XX+SGe0NiEmQ3XOqRBgTaHpqsMksGf9sP8Qv81Uc4tW
         yWoJXmgm6MfYvT7aKrL+tuwCsAKzIB9p2UEXcmcKCL8f2y9Kv+BcYs5n+ixkeJhKau+o
         1D5g==
X-Forwarded-Encrypted: i=1; AJvYcCUayS7zf+NZpu7CS5acWgBqBH4/oqwkdyWE3jddt7uCz//sLCHEy4k3tO/dgPLhx28SXWizoEEMUR06lfUjA4fBjG72zX/PcQaY36Ps
X-Gm-Message-State: AOJu0YxxR3EMumKPQGQ8CobYFSojYhd4ManJgMl4d1EOH3lpIxjHc9dX
	UWCDPbFB4sypzKbVNrFTjhTF/ikPgxOSotBaYQoh+LOOQ7+BzX+w1CWUgB4r7Y0+hWbbst/Qje8
	bF8Y=
X-Google-Smtp-Source: AGHT+IE5WUL116u7UYmsqos/5VhGIqIltaH8tT346J7cULaj5yrkVB38VABENxK+t2dKeB4ps74g3g==
X-Received: by 2002:a17:907:d40a:b0:a45:2f1b:c07d with SMTP id vi10-20020a170907d40a00b00a452f1bc07dmr6413274ejc.10.1710227761705;
        Tue, 12 Mar 2024 00:16:01 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:73a8:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:73a8:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id h16-20020a1709067cd000b00a45f63d2959sm3538740ejp.210.2024.03.12.00.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 00:16:01 -0700 (PDT)
Message-ID: <f5105c5d-59fb-4bca-af70-353e480f2b12@suse.com>
Date: Tue, 12 Mar 2024 09:15:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 06/14] fork: zero vmap stack using clear_page() instead of
 memset()
Content-Language: en-US
To: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org, bp@alien8.de,
 brauner@kernel.org, bristot@redhat.com, bsegall@google.com,
 dave.hansen@linux.intel.com, dianders@chromium.org,
 dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
 hch@infradead.org, hpa@zytor.com, jacob.jun.pan@linux.intel.com,
 jgg@ziepe.ca, jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com,
 kent.overstreet@linux.dev, kinseyho@google.com,
 kirill.shutemov@linux.intel.com, lstoakes@gmail.com, luto@kernel.org,
 mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com,
 mingo@redhat.com, mjguzik@gmail.com, mst@redhat.com, npiggin@gmail.com,
 peterz@infradead.org, pmladek@suse.com, rick.p.edgecombe@intel.com,
 rostedt@goodmis.org, surenb@google.com, tglx@linutronix.de,
 urezki@gmail.com, vincent.guittot@linaro.org, vschneid@redhat.com
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-7-pasha.tatashin@soleen.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240311164638.2015063-7-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.03.24 г. 18:46 ч., Pasha Tatashin wrote:
> In preporation for dynamic kernel stacks do not zero the whole span of
> the stack, but instead only the pages that are part of the vm_area.
> 
> This is because with dynamic stacks we might have only partially
> populated stacks.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   kernel/fork.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 6a2f2c85e09f..41e0baee79d2 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -263,8 +263,8 @@ static int memcg_charge_kernel_stack(struct vm_struct *vm)
>   static int alloc_thread_stack_node(struct task_struct *tsk, int node)
>   {
>   	struct vm_struct *vm_area;
> +	int i, j, nr_pages;
>   	void *stack;
> -	int i;
>   
>   	for (i = 0; i < NR_CACHED_STACKS; i++) {
>   		vm_area = this_cpu_xchg(cached_stacks[i], NULL);
> @@ -282,7 +282,9 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
>   		stack = kasan_reset_tag(vm_area->addr);
>   
>   		/* Clear stale pointers from reused stack. */
> -		memset(stack, 0, THREAD_SIZE);
> +		nr_pages = vm_area->nr_pages;
> +		for (j = 0; j < nr_pages; j++)
> +			clear_page(page_address(vm_area->pages[j]));

Can't this be memset(stack, 0, nr_pages*PAGE_SIZE) ?
>   
>   		tsk->stack_vm_area = vm_area;
>   		tsk->stack = stack;

