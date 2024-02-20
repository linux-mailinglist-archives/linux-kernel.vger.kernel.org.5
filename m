Return-Path: <linux-kernel+bounces-73198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FAD85BF26
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF15CB20EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133F473172;
	Tue, 20 Feb 2024 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxMOEn5E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06156DCE4
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440815; cv=none; b=MryvjX/TNwcWTQp76nJApB+YO1QTzV5rE5MkLBwJwSLQfFECIyEAHVqke7Gj0quKr+pYO8xRNRFR+KM8t4hScOxY021KpHr5zj6Q/qq2Jnartat2Yj6vmm2fDYb7XTNr0RkDqi+BA7Km2aqxd4rMWQ55aSevpWNTxK/sYgNafhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440815; c=relaxed/simple;
	bh=8nTMlKnTgb82Orr2ipMOW+HsrZwnONSw5TCFBH21dpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZ5eU9VsJjczRpHFlVlMurUcQFX4FZtGry8eckB7D8ECJt3IFbSCzzaULj4jSvflukgW6Cxm+kJp0rvN7i8pGUdtzlGiawm1+t5O8r/S2wIAqoKKoPdVDTvHo9X0mAkmIX8WmK0HQzYLdudjLkm+SfVjnEmVwxJGjAtACk94q1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gxMOEn5E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708440812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIoZ4CrpCT0yQRhe9YS3Ujue6aQteM4IkhqX2Ucv/KE=;
	b=gxMOEn5EATbIPRZj0mmEiNG1cq2EIMVDDPAOi6zNmHD9zwKUU7wtlyIJVActQJ3yVhKVRA
	d9zSTi0wlK5w+TRS+hqz0SeMgVWl3K8CHCUCrXolwqj6rK9JFcNhZlE4fVGUA7IPNJYx6D
	Nd+HdensmTJtfxnNrLrOVzkVHFI7PYo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-M86qkiEIOtChyHIivSPNWw-1; Tue, 20 Feb 2024 09:53:31 -0500
X-MC-Unique: M86qkiEIOtChyHIivSPNWw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-558aafe9bf2so3832053a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708440809; x=1709045609;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIoZ4CrpCT0yQRhe9YS3Ujue6aQteM4IkhqX2Ucv/KE=;
        b=bj5MtJNlu59LMWdW/DXwEKaNNdcsg/wW+/ei2mdOgKjFeynnQP/XIfnvkTCw0vGdds
         pCBZVClTAMwE+lqjNyJ6w61ys4OvjK1YvS9RpqHvD91z56WUR/zgz17xVlPVw4vR/hWF
         kToxx9lUW6Mx0zO3U7jvvfdoBGg1wq2/msGaBr2/Faq5kVy56icq2s1cKbLO5WgECxqf
         5i49/SwSyRCb60LpcFAXv+t90+4ztymmjmBvZDiW9iX5CKPglzOGExZyLBxTOZCgx1i7
         LBuWu9RR4WJr8oftwP6yRBOogV+8LAoQSa6nuuMQ+R4lJqG4xCD3MjMkWUeDvR2x9cq9
         CA+w==
X-Forwarded-Encrypted: i=1; AJvYcCVHq58NCvYmMuJzcwHnQuGHls6bSMcXus4ug04SXXeTM42JOoDmhFGdQujUKFohw0FCzKfyNSKrpoCBTocqDD9qhouFI+K/idaSMjSS
X-Gm-Message-State: AOJu0YwJbll41VbIQ8TR4/xPr4rS/GSgn5pRQ35ATds9v7YlBQHHiZ9K
	O2nnfzS7Px0njNFDfVf2t5olGzkqITtEoGMPWzGScwHIJ9nfj4zKFZizZ4GtAl0yk4kC9mkd+77
	TeUZZqKRqkmYN7kcCth9k73I9/yaEDd4wQWVZrwtUF32gsJwVVphh5vBLj1FrvA4w15Ezug==
X-Received: by 2002:a05:6402:3593:b0:563:fc1d:4568 with SMTP id y19-20020a056402359300b00563fc1d4568mr10218772edc.10.1708440809690;
        Tue, 20 Feb 2024 06:53:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgncS/XDGlrnCRYFDb4cyJLLdkJYTnjGk8oU+I3xRmlGS5TbjJClcmYfutXRXPKx1rPOuBAg==
X-Received: by 2002:a05:6402:3593:b0:563:fc1d:4568 with SMTP id y19-20020a056402359300b00563fc1d4568mr10218757edc.10.1708440809403;
        Tue, 20 Feb 2024 06:53:29 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id r21-20020a50d695000000b00563f3ee5003sm3910730edi.91.2024.02.20.06.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 06:53:28 -0800 (PST)
Message-ID: <19d0a4a9-85bb-4b9e-96b0-338adebc90e5@redhat.com>
Date: Tue, 20 Feb 2024 15:53:27 +0100
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
To: Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, benno.lossin@proton.me,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 linux-kernel@vger.kernel.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
References: <20240219163915.2705-1-dakr@redhat.com>
 <20240220093541.280140-1-aliceryhl@google.com>
 <e543b270-dea7-477a-b83d-62129d4ac708@redhat.com>
 <CAH5fLggXiXGA_UWCxqqLhMpXe1kepDv2vMG+1jLGaDSzdRHvSw@mail.gmail.com>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <CAH5fLggXiXGA_UWCxqqLhMpXe1kepDv2vMG+1jLGaDSzdRHvSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/24 14:17, Alice Ryhl wrote:
> On Tue, Feb 20, 2024 at 1:02 PM Danilo Krummrich <dakr@redhat.com> wrote:
>>
>> On 2/20/24 10:35, Alice Ryhl wrote:
>>>> Add functions to convert a CString to upper- / lowercase, either
>>>> in-place or by creating a copy of the original CString.
>>>>
>>>> Naming followes the one from the Rust stdlib, where functions starting
>>>> with 'to' create a copy and functions starting with 'make' perform an
>>>> in-place conversion.
>>>>
>>>> This is required by the Nova project (GSP only Rust successor of
>>>> Nouveau) to convert stringified enum values (representing different GPU
>>>> chipsets) to strings in order to generate the corresponding firmware
>>>> paths. See also [1].
>>>>
>>>> [1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/String.20manipulation.20in.20kernel.20Rust
>>>>
>>>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
>>>
>>> This looks good to me, so you may add my
>>>
>>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>
>> Thanks for reviewing this patch.
>>
>>>
>>> However, it looks like this patch has some clippy warnings that need to
>>> be fixed before it can be merged.
>>
>> It seems that those warnings are treated as fatal even, although, given the
>> rationale for these warnings, I'm not even sure those should be warnings at
>> all.
> 
> The build currently succeeds with zero warnings. That's a very useful
> property, and I would not like to give it up.

Just to clarify, I did not say anything else. As mentioned, I think those
should not even be warnings.

> 
> You could submit a patch to silence these specific warnings. The

I'm happy to do that. We should define the scope for that though. I think this
should be set globally, or at least not per crate. However, I don't really know
what's the best way to do that. We could pass '-Aclippy::' to the compiler...

> clippy::explicit_auto_deref warning is not one I care for, but I would
> object to silencing clippy::needless_return. Using return statements
> when you are not doing an early-return really is extremely unidiomatic
> Rust.

Unfortunately, that's just a different version of:

"Removing the return and semicolon will make the code more rusty." [1]

Hence, I still fail to see why being explicit is a bad thing in this context.
Is there any objective reason not to be allowed to be explicit here?

> 
> Ultimately, I think there is a lot of value of just applying the code
> formatters and linters and following them to zero warnings. It ensures
> that the Rust code is relatively idiomatic, helps avoid long
> unproductive discussions, and makes it easy for me to fix formatting
> issues in my own patches (just run clippy and rustfmt on everything,
> and it lists only things that are my own fault).

Well, I generally agree. However, I'm clearly against *blindly* following
formatters and linters.

We should carefully pick the rules we follow, and we should do that for objective
reasons.

Forcing guidelines we don't have objective reasons for will otherwise just annoy
people and lead to less ideal code for the project. And I intentionally say "for
the project", since this context is important.

[1] https://rust-lang.github.io/rust-clippy/master/index.html#/needless_return
> 
> Alice
> 


