Return-Path: <linux-kernel+bounces-38592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C383C2B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3815B28D613
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415E24EB24;
	Thu, 25 Jan 2024 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHu3Oq0m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE22748790
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706186683; cv=none; b=h1/IzSekpIzNrkVHlJZj3DJgf4i9wIzNmEc31/0Qn5f/FMrLoOWYmKcQPOhAmQ1RJRGTmG4nxW2J9uYKsBDeoK6lCZ5MHA7VcJiqJYXYbzA0mpd8+tI6NQ14I1kpackyZhoxv8ve6pHqQHycSieCtjhAZmCe+Esd1JKh4CaETvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706186683; c=relaxed/simple;
	bh=v2JEWl8bNUG4HwHJM6X8yxzYP2r+NlbjQNNHLxQIG4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4TNW2hQ1vY5jZxHNU0vXv3D9xVZh9cwqSPssVbJUn34yDWrkZpSRE5gITvVXmw34Grj29v4EWRa1PjKqgcL2DL6F14uLk7hbFRyGGnsKmvK9nqIwhAsZhOeAkjtme2+yR67RZ8D0NPlQFwW83IhE/bxN9faG3cIR3Ss807CvH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RHu3Oq0m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706186680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vJ3v/KQU8mhpg+xVM+s+t0D3ljY8OSdkZQx6o6VIzOU=;
	b=RHu3Oq0m5GB+iacaPQ0A4ciTV/CtWfS0YY6PEXv/GuDE/svE5tZrK1fiBPvTnymvth2EwV
	g4OK9f6dYBZwr0KlRu7rJcBkCHhP8zLY7AMhP/A4vVl677L53TkM864HXn5qpL5hGv9HL+
	H0lMR2/r8x7ZesbELS+R9PdjehE5SGM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-xmkQhy6gOcuR3zbDiOtnUg-1; Thu, 25 Jan 2024 07:44:39 -0500
X-MC-Unique: xmkQhy6gOcuR3zbDiOtnUg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e530b7596so63233365e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706186678; x=1706791478;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJ3v/KQU8mhpg+xVM+s+t0D3ljY8OSdkZQx6o6VIzOU=;
        b=B7eqLXDPRuJA66XyJ1bg/3Djba44N/ujX8+sVos5O6aQXodoJ5DV19E8lyZBIdpMlp
         sL7iuhO6GOF4O3MUHj5BWYgKWR9+Y5EPFrbqsOqsjqJ+8BiEMtpUIUQRVppaNdHY7DAJ
         1ngVRkaWRU/eIkfUMEHjjtui4X4fKfRRvpuTx84J1tjHzE6LzRMJ0nbvZjvLecypf2ny
         8Q8ekN/3l7RSg5At5b32N9RJZuuT7kbNzwThxlSe4HO6ZkHjXSNxJrHYTggvKOBVTsBc
         SN6Y2yllSJ6wgstz7u9gH8FL7TuL/FNqPN41okyhJ72VlwOcfVRLcfE1LZ+kZZZz13w+
         onjA==
X-Gm-Message-State: AOJu0Ywvs/tEjDmT9XDOOMX5QfAzL6gQGhmTROMzloGd0lhD/vZnWZF4
	L3njKkdaJpcD/bTtyqKXfSIA7ndtwdLlTxVB2IHc4iGknfrZ+XfmJ7pO9jwMxPJPWRi5FdLdosI
	PjVYdyMAfI70NZhsCofD4yF9oe/VjOCS6qVU1XcAukOn9Of1D57FfwqPgmv00lnEgqGlLCg==
X-Received: by 2002:a1c:7210:0:b0:40e:c257:ca4a with SMTP id n16-20020a1c7210000000b0040ec257ca4amr463285wmc.141.1706186678081;
        Thu, 25 Jan 2024 04:44:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlfRnM+/wHWtsZUbA5EixjFZvlJo6hu/9ZPPTgKH5Q5JCj6eRLE9Y/i5taZXPhThRMMJHPIw==
X-Received: by 2002:a1c:7210:0:b0:40e:c257:ca4a with SMTP id n16-20020a1c7210000000b0040ec257ca4amr463273wmc.141.1706186677657;
        Thu, 25 Jan 2024 04:44:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c70a:7600:9a0b:ceef:a304:b9a7? (p200300cbc70a76009a0bceefa304b9a7.dip0.t-ipconnect.de. [2003:cb:c70a:7600:9a0b:ceef:a304:b9a7])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b0040ecea22794sm2375607wmq.45.2024.01.25.04.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 04:44:37 -0800 (PST)
Message-ID: <c9b4dfc0-19b9-4e19-b681-e2fab63f41e8@redhat.com>
Date: Thu, 25 Jan 2024 13:44:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Issue] mprotect+madvise may be better than mmap for permission
 changes and page zeroing
Content-Language: en-US
To: Lance Yang <ioworker0@gmail.com>, linux-kernel@vger.kernel.org
Cc: Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org
References: <CAK1f24mZcxdxKA5hyNaMy-jX=dGtEoZEY8imXKrTnZ0EC61_gw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAK1f24mZcxdxKA5hyNaMy-jX=dGtEoZEY8imXKrTnZ0EC61_gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.01.24 13:28, Lance Yang wrote:
> Hello Everyone,
> 
> I've noticed that using mprotect(PROT_NONE) with
> madvise(MADV_DONTNEED) is much faster than
> mmap(PROT_NONE, MAP_FIXED) alone for changing
> permissions and zeroing pages.
> 
> I have maintained a chunk-allocator internally at the
> company. It allocates a chunk using
> mmap(PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE, -1, 0),
> releases a chunk using mmap(PROT_NONE, MAP_ANON|MAP_FIXED|MAP_PRIVATE, -1, 0),
> and reuses a chunk using mprotect(PROT_READ|PROT_WRITE).
> Recently, I replaced mmap(PROT_NONE, MAP_FIXED) with
> mprotect(PROT_NONE) + madvise(MADV_DONTNEED) to
> reduce the latency of releasing chunks.
> 
> Test code:
> https://github.com/ioworker0/mmapvsmprotect/blob/main/test2.c
> 
> Here are the test results on my machine:
> CPU: AMD EPYC 7R13 Processor
> Kernel: 6.2.0
> Elapsed Time for mprotect+madvise: 3670 nanoseconds
> Elapsed Time for mmap: 5520 nanoseconds

mprotect+madvise won't free page tables, mmap will. That's the biggest 
difference.

-- 
Cheers,

David / dhildenb


