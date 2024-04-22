Return-Path: <linux-kernel+bounces-153886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567FC8AD477
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113F0283B05
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7311552E1;
	Mon, 22 Apr 2024 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFzpjZ54"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04D154BFF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812366; cv=none; b=KNCZC7QY3b/aVkwMevsDuS9Feb/sGz1pKmV3lFRnEcekHFH6GhjmXguh1CP28Ge4urdfK5zsLlB6xE5p1TxRovZHTAXok9gJAFI12osRV8w+jDhbXuG3oE03Yiw7ndXRmuM65MdbqYyby3T95jeZwPkVOjdVq2AbXCYCK3gGQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812366; c=relaxed/simple;
	bh=+yT1cKHrMfv6BIVPIWySVlA2i3fir6luGW5GOp0DQ/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbL2we9V9QERodexLPjDh7zHdvCvwun952KjFrUsbohZxmqdJaNWeFCFYroPmNUeJXGzVrTh20njGqlUo4156ZynZ7b/5o3EPwUKftvWkxzHVuLOpKr+dWbQJRmVIAte4rFA3InptWtJHVRcZhJNaqovQa/lKz4MyKVkpqf8BVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFzpjZ54; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713812363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2IoiI1CKWdxT08QT1d5cFnQm5ub6rZ7mUR7ZdEDYUaU=;
	b=XFzpjZ54TrAzbpS2ZIJOKFsSDWXNwUux+HdMdxFG/eQMUFDIg3RrDbj2aRcO7+jdNhNyKG
	p1qQI7YuJOwFd/uWNqq9r5CWdEdig5Fu5gtAMkw3jiX2kEsZlkcG4izjO9hGjPFKwHjctJ
	8NSljwC+M+RUnDfWfpMZJOyHA/vlYKw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-3rersuA5N82dY3sVCvgRXw-1; Mon, 22 Apr 2024 14:59:21 -0400
X-MC-Unique: 3rersuA5N82dY3sVCvgRXw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34b0b409775so716535f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713812360; x=1714417160;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IoiI1CKWdxT08QT1d5cFnQm5ub6rZ7mUR7ZdEDYUaU=;
        b=UrIe/Rdm5gP2pKGSnKrmLozsl31wK4m78Q6QEdIz+c7jnY/kUy0h7D7X7U/eLQhNTn
         fR4WVO0ngxx42ZUuxMdpCmvUOqSrWwG58UpCCkMQQzTBg8c1b5/mjDEJCl1zOpObJUK1
         qWdsdrinroTSd6AuYTDTlLbHlQZvzVuzZbMi7QxFG3ayAEvYGGq8tSbsDW3Tu/I93j+v
         ndhkQl+5a+xYty2GEIkMedgeeld66zjetP9Ms/6LiaFJ2YwXbWbAhQCPar0zh5YbqStV
         S3iFE5yLHO73lpJoMTVphcKPcKxuPDnOI2VecBtUZKfUIMh4xftpt7HYXO4YnfvjwaOv
         EeGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRESvH2IaNiBg/8Xp2qfYWJQOh+CDORPpQoUwqOTJPKOS5AvriTne8Pm/ocBUkIXPvty5h4kf0yx1E6C+FyFbk62Khb/4oMoZOhmJb
X-Gm-Message-State: AOJu0YyAFo47LcvPwdUzCjOhZtIuqJagZoe2Raaj1lXw5a+cA5TW7v0o
	oOxVNIybZ361lwB12JRTfvKotAoIORVtCZcSMqM4+Ovs8lAz1b4ijXzJl7VyBLZZgGJv4wk9A44
	kKM78qLIQrkSUDnL8ZxN1lyHUjqhhADEYffZqPJ7HzH3aL2wnpAdVCxxfoRVanA==
X-Received: by 2002:adf:f18b:0:b0:34a:1a7a:9d60 with SMTP id h11-20020adff18b000000b0034a1a7a9d60mr7523613wro.62.1713812359958;
        Mon, 22 Apr 2024 11:59:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNKCmunCBazTILyGjfr5rWb+/K9AQV1aT5p5NciF5x/JFNmo9F3sRr7Zd9nkNX47cX5twwkw==
X-Received: by 2002:adf:f18b:0:b0:34a:1a7a:9d60 with SMTP id h11-20020adff18b000000b0034a1a7a9d60mr7523598wro.62.1713812359499;
        Mon, 22 Apr 2024 11:59:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:600:d2fb:3a8a:9944:7910? (p200300cbc7390600d2fb3a8a99447910.dip0.t-ipconnect.de. [2003:cb:c739:600:d2fb:3a8a:9944:7910])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d40d0000000b00346406a5c80sm12771752wrq.32.2024.04.22.11.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 11:59:19 -0700 (PDT)
Message-ID: <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>
Date: Mon, 22 Apr 2024 20:59:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
To: Guillaume Morin <guillaume@morinfr.org>
Cc: oleg@redhat.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, muchun.song@linux.dev
References: <ZiK50qob9yl5e0Xz@bender.morinfr.org>
 <b70a3d3a-ea8b-4b20-964b-b019c146945a@redhat.com>
 <ZiaoZlGc_8ZV3736@bender.morinfr.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZiaoZlGc_8ZV3736@bender.morinfr.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.04.24 20:11, Guillaume Morin wrote:
> (Dropping Mike Kravetz as CC since he has retired and his email is no
> longer valid, adding Muchun since he's the current hugetlb maintainer,
> as well as linux-trace-kernel)
> 
> On 22 Apr 11:39, David Hildenbrand wrote:
>>
>> On 19.04.24 20:37, Guillaume Morin wrote:
>>> libhugetlbfs, the Intel iodlr code both allow to remap .text onto a
>>> hugetlb private mapping. It's also pretty easy to do it manually.
>>> One drawback of using this functionality is the lack of support for
>>> uprobes (NOTE uprobe ignores shareable vmas)
>>>
>>> This patch adds support for private hugetlb mappings.  It does require exposing
>>> some hugetlbfs innards and relies on copy_user_large_folio which is only
>>> available when CONFIG_HUGETLBFS is used so I had to use an ugly #ifdef
>>>
>>> If there is some interest in applying this patch in some form or
>>> another, I am open to any refactoring suggestions (esp getting rid the
>>> #ifdef in uprobes.c) . I tried to limit the
>>> amount of branching.
>>
>> All that hugetlb special casing .... oh my. What's the benefit why we should
>> be interested in making that code less clean -- to phrase it in a nice way
>> ;) ?
> 
> I do appreciate the nice phrasing. Believe me, I did try to limit the
> special casing to a minimum :-).
> 
> Outside of __replace_page, I added only 3-ish branches so I do not think
> it's *too* bad. The uprobe code is using PAGE_{SHIFT,MASK} quite liberally so I
> had to add calls to retrieve these for the hugetlb vmas.
> 
> __replace_page has a lot of special casing. I certainly agree (and
> unfortunately for me it's at the beginning of the patch :)).  It's doing
> something pretty uncommon outside of the mm code so it has to make a
> bunch of specific hugetlb calls. I am not quite sure how to improve it
> but if you have suggestions, I'd be happy to refactor.

See below.

> 
> The benefit - to me - is very clear. People do use hugetlb mappings to
> run code in production environments. The perf benefits are there for some
> workloads. Intel has published a whitepaper about it etc.
> Uprobes are a very good tool to do live tracing. If you can restart the
> process and reproduce, you should be able to disable hugetlb remapping
> but if you need to look at a live process, there are not many options.
> Not being able to use uprobes is crippling.

Please add all that as motivation to the patch description or cover letter.

> 
>> Yes, libhugetlbfs exists. But why do we have to support uprobes with it?
>> Nobody cared until now, why care now?
> 
> I think you could ask the same question for every new feature patch :)

I have to, because it usually indicates a lack of motivation in the 
cover-letter/patch description :P

People will have to maintain that code, and maintaining hugetlb code in 
odd places is no fun ...

> 
> Since the removal a few releases ago of the __morecore() hook in glibc,
> the main feature of libhugetlbfs is ELF segments remapping. I think
> there are definitely a lot of users that simply deal with this
> unnecessary limitation.
> 
> I am certainly not shoving this patch through anyone's throat if there
> is no interest. But we definitely find it a very useful feature ...

Let me try to see if we can get this done cleaner.

One ugly part (in general here) is the custom page replacement in the 
registration part.

We are guaranteed to have a MAP_PRIVATE mapping. Instead of replacing 
pages ourselves (which we likely shouldn't do ...) ... maybe we could 
use FAULT_FLAG_UNSHARE faults such that we will get an anonymous folio 
populated. (like KSM does nowadays)

Punching FOLL_PIN|FOLL_LONGTERM into GUP would achieve the same thing, 
but using FOLL_WRITE would not work on many file systems. So maybe we 
have to trigger an unsharing fault ourselves.

That would do the page replacement for us and we "should" be able to 
lookup an anonymous folio that we can then just modify, like ptrace would.

But then, there is also unregistration part, with weird conditional page 
replacement. Zapping the anon page if the content matches the content of 
the original page is one thing. But why are we placing an existing 
anonymous page by a new anonymous page when the content from the 
original page differs (but matches the one from the just copied page?)?

I'll have to further think about that one. It's all a bit nasty.


One thing to note is that hugetlb folios don't grow on trees. Likely, 
Many setups *don't* reserve extra hugetlb folios and you might just 
easily be running out of free hugetlb folios that you can use to break 
COW here (replace a file hugetlb by a fresh anon hugetlb page). Likely 
it's easy to make register or unregister fail.

-- 
Cheers,

David / dhildenb


