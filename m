Return-Path: <linux-kernel+bounces-73625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5158285C541
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57321F21B71
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8BA36135;
	Tue, 20 Feb 2024 19:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGPzNIMK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31D6BFB8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458949; cv=none; b=Xo5BS58//gsIs+x/JGsKXN8hUkICCstX0hI+kHshBfO8dm/bB4a2lpReMrElHF2zgPOb91L4HgIiBXENwm8a1qpHRF9/gAcwmPaUm6pZHBM+IDOn1zanEbTJx0nnLn9LDENR/fVPPMaD9nHYeEaC2DjSzC29ru3Ba3CF8+6Ocuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458949; c=relaxed/simple;
	bh=jNhccb+0ZR17ZrC6MAi8IIrh6pLgRr5dVBLtuJ71LwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3XdGJ4z8XU28rUJEMEmLZLclMzh7FAfs3Ph56M+UE9b5b+2nHKgC8XMHDXPKahlbgWNdiLD8TdS1g8pMEaWKDJm345y8bA35cSOz0LusPxP0rfDhXvp3VLClyPPncIf50QwCoyHoZGPlpE62WgPpPlDyxluB0AVYG4YslRmEH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGPzNIMK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708458946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uf3VCsI0LJvkwUzUw1IFtw2xE/8bIN/j3JeX0X/tj0=;
	b=VGPzNIMKPtXEdJkl2lbOhOb1Fb3izKlHRsI41o/DzxC+u19iUHPV9ZwfMkeCuf+MfeR6G1
	AFKXvGhZyl00dsdWNFz/xUahaZ/R1AlXlNE8uqV5PFIjefPgMu/0vgfDSQgMOHkkpm9Lf8
	r56MsY/1Iu40aqggcRG2udWIqFiklTc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-Hcgb-5hvMPe2MiPbRX65tQ-1; Tue, 20 Feb 2024 14:55:45 -0500
X-MC-Unique: Hcgb-5hvMPe2MiPbRX65tQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3ed1fb115eso125783066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708458944; x=1709063744;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5uf3VCsI0LJvkwUzUw1IFtw2xE/8bIN/j3JeX0X/tj0=;
        b=soOW5VFjkxlIq/jX0IYNS98p9RwxLE/TfK/EG6k8eq4pSZGVDs63if417wl+PMnnWc
         9vlh8i1AfJxQHmPRK8c7F6SvmSU27trpD5RUd5YensB2Zn+JGyV90J3v5LVvz/SwpcRp
         MPLpcSdnRFJJHzHYROPo18o2hM7xhQYELhw6dVzlTsRDNZqSLt1MSCEg+qw0LB5xtM2w
         UbXOkVtd/pgB7lnEDB0BfN9NRibR78+n7MaTLwDAklAwrulCswYhRjMSqbqJS4Rgj0zW
         s9XnPxYzknSnMfqwUDtFv/G2aFEC0d8ZWQVliguCNjYUkhBA4utM4qGydSwnXbHp/xpx
         RMPA==
X-Forwarded-Encrypted: i=1; AJvYcCXbP/qn49OM7RZm2yNRnxXfE4/h+CPsR0GA9bSt05hmqLdFpyXoXMXiCvbOgJtiH8lc9ZQIsmGPCgUSaRoKNC0ohuts/LjjpGtnI9Eu
X-Gm-Message-State: AOJu0YwVZN3BBi23mmhu/OTSV8/dvjzl0CdFKzB3010apOkBzAEI4ZD1
	uOAZ/PMAhWgPZ2xhUTEHHB/CgkfrMXkFsJy19VdiHRqbSsz2EzIg/LtoFKgpZySXkRoR3WbzbjD
	bsoK2LXxAIq9XOAIAtl181+Q/P0CozugOyTRV41ZtDu7eALbfywuGs/gJXMqarw==
X-Received: by 2002:a17:907:37a:b0:a3e:3633:cf91 with SMTP id rs26-20020a170907037a00b00a3e3633cf91mr6310431ejb.48.1708458943921;
        Tue, 20 Feb 2024 11:55:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIDwn8hJWvA6Ffqzhz8nZ/kVsYYySVwZv2l/GGSLSF0QD1OOD1TDTDmy29j5s6yuvTkP//Gg==
X-Received: by 2002:a17:907:37a:b0:a3e:3633:cf91 with SMTP id rs26-20020a170907037a00b00a3e3633cf91mr6310410ejb.48.1708458943545;
        Tue, 20 Feb 2024 11:55:43 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id lu16-20020a170906fad000b00a3d5efc65e0sm2941765ejb.91.2024.02.20.11.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 11:55:43 -0800 (PST)
Message-ID: <d88bfe23-6fbd-4bb9-8878-3ccc63b97ddd@redhat.com>
Date: Tue, 20 Feb 2024 20:55:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] rust: str: add {make,to}_{upper,lower}case() to
 CString
Content-Language: en-US
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, a.hindborg@samsung.com,
 alex.gaynor@gmail.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, linux-kernel@vger.kernel.org,
 ojeda@kernel.org, rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
References: <20240219163915.2705-1-dakr@redhat.com>
 <20240220093541.280140-1-aliceryhl@google.com>
 <e543b270-dea7-477a-b83d-62129d4ac708@redhat.com>
 <CAH5fLggXiXGA_UWCxqqLhMpXe1kepDv2vMG+1jLGaDSzdRHvSw@mail.gmail.com>
 <19d0a4a9-85bb-4b9e-96b0-338adebc90e5@redhat.com>
 <CANiq72n06BCWuHoWbQBrODqgfH8ZGEc6rLhMu86UiYpKdjO3PA@mail.gmail.com>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <CANiq72n06BCWuHoWbQBrODqgfH8ZGEc6rLhMu86UiYpKdjO3PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/24 16:45, Miguel Ojeda wrote:
> On Tue, Feb 20, 2024 at 3:53 PM Danilo Krummrich <dakr@redhat.com> wrote:
>>
>> Just to clarify, I did not say anything else. As mentioned, I think those
>> should not even be warnings.
> 
> Well, for things like the `return` one, I find it unlikely it will change.
> 
> And for other things that there are 2 ways of doing it, what we
> typically want is to have one way of doing it, rather than allowing
> both ways.
> 
>> I'm happy to do that. We should define the scope for that though. I think this
>> should be set globally, or at least not per crate. However, I don't really know
>> what's the best way to do that. We could pass '-Aclippy::' to the compiler...
> 
> The scope is already defined -- it is global, precisely because we
> want to keep all kernel code as consistent as possible.> 
>> Is there any objective reason not to be allowed to be explicit here?
> 
> What is not objective about wanting to be consistent? How is your
> argument objective if ours isn't?

Nothing, but I also never wrote that wanting to be consistent is not objective.

I wrote that omitting the return statement is more "rusty" isn't an objective
argument in my opinion.

Maybe the misunderstanding is that consistent doesn't necessarily mean to do what
everyone else does. Consistency has a scope. For instance, we can also be consistent
with something that everyone else does differently, like linked lists throughout the
kernel.

> 
>> Well, I generally agree. However, I'm clearly against *blindly* following
>> formatters and linters.
>>
>> Forcing guidelines we don't have objective reasons for will otherwise just annoy
>> people and lead to less ideal code for the project. And I intentionally say "for
>> the project", since this context is important.
> 
> Who is *blindly* following formatters and linters? We don't have
> objective reasons?

This doesn't seem to be a "straight up" question. Hence, for the following I will
assume that you feel like I said those things about you.

First of all, I said that *we* (as a community) should not blindly follow formatters
and linters and should have objective reasons for language restrictions in general.
I never said anyone specific is doing that. Claiming that I did so, *would* be a straw
man.

Furthermore I was questioning two of the restrictions we already have and was asking
for an objective rationale for those, since the clipply documentation does not provide
an objective rationale in my opinion.

Generally speaking, I don't think there is anything wrong in saying that I think some
argument isn't objective (even if I'd be proven wrong). This is by far not the
same as saying someone has no objective reasons (in general). This would be a straw man
as well.

> 
> I don't appreciate the way you are wording things here.

I already had the feeling from your answer in the other thread. But, unfortunately,
I don't understand why. If the above did not convince you otherwise, can you please
explain?

> 
> Does it actually lead to "less ideal code", or the opposite?
> 
> Cheers,
> Miguel
> 


