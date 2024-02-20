Return-Path: <linux-kernel+bounces-73277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EFC85C060
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43874B2153B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F73776400;
	Tue, 20 Feb 2024 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaEojnFo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C386B76052
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444404; cv=none; b=mT9I9+NY87XSpy7ONZuJojHkxqweR937a8n+ZbZwmfqsuTUklXkIAT+efKpZZD9iPs+Foo6NWe1Z35aZjEms4sPzZHdFr0OqONANiZfE0iTu/Xb52Ya8+cFNwTJLsVFvdZp19eIbQJjpZqqUHZlF7gqDfCIb7PSOfqcsVfJS0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444404; c=relaxed/simple;
	bh=7pUGGbHmanfArsTQq4oLF7E9Dny2qvkMg9eaNQq7TSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G89QyMUnLKXoQjCm12yK9N7N9TAdK2VqRbPeleIUzclQwPupEB4dG2IWHySJ1r68ka3vaRJrW1HJ8snVk7iByEtgRGKQq+OAPdFRHdnKEvOKeywMInmR4ou30lfmMygxcXK+WiUXACrMJZJk+fuOsJpNsLNHh97GiYk5ffzJW0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaEojnFo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708444401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5UZE9uS05gdlK0V/0rg9HQXJ0ePcQG+CjltSSXcX1Fg=;
	b=JaEojnFoAVtoGtW3ZM2pm9oT6B8CQ5+H/XlRr+ebBoZE2rQVqJMu90d7FHwKl9eACq4mX8
	0Hqcm0KLI4Ln6k+va2kA2NL0xmI4NQvo+ufFMYn6kAMRYBqoOs2hAhPZ8dmNONnfcV3Kj6
	pjA0mbXMAwumSQ1Sy2vzRowXZleosF4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-7QPBncaaO26ZySGdyl_LDw-1; Tue, 20 Feb 2024 10:53:19 -0500
X-MC-Unique: 7QPBncaaO26ZySGdyl_LDw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-512aa50323cso3003456e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708444398; x=1709049198;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UZE9uS05gdlK0V/0rg9HQXJ0ePcQG+CjltSSXcX1Fg=;
        b=Fr3KIopLSUMnkASYHCEysrZmrMsoLN9QY8eJfa8RNqIox/B1tWUu5CmINHTVSRf/bt
         bNADnCPWeqYUQIP1ytZ0TGzOGmf4vbiXClizML12CpJa2PsCTc0nrZ1b8UVlBqP7yptX
         jrTuUcT3x1lR1jMCTs2VEC1g0IMC0eORGA3aaolx6r35+Zw3KDznCq4YWQG8ZI4NUkOB
         8WW6+DuwU4EzCrx+p46P3k1oBsbkxSzV82r+y1T8mI2DsUKYRMautGjn4alIC+oatuDH
         4wQ79lj6nDzBSzM86pCb1M7IVVfr+Yo009E5xJZj5ycNEs9/UhSU09SlKgzPqX+G5Tri
         hNXw==
X-Forwarded-Encrypted: i=1; AJvYcCWSnNxeZmwtgWDPyxnhjCFtZlyrp/slbbYe5UhzdRSTJONe0pevFitLw2EtlZB7hv7JI/mn8OLz7S4ZpIOGIJ+MYOgK2keX9fzE4kfq
X-Gm-Message-State: AOJu0YyXuSYTp7E0FW6G7rdxVyQRzvAjbn1QRwD6K83UNDZYc3E+cdvN
	oVVQ8km243V73VjVYAIYvXE3kOiqe3ua+o6SCJh5Df0A2oPI1u4zWPLQt912PQPbY8bA2ZeAD36
	265Gkski5neMvvwjDaKtiuRykUrjSUX4PDKl+AKSqOT6Xmmor+FWqy338WoG4Zg==
X-Received: by 2002:ac2:46f7:0:b0:512:a540:3c93 with SMTP id q23-20020ac246f7000000b00512a5403c93mr5701836lfo.66.1708444398324;
        Tue, 20 Feb 2024 07:53:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF54J7mdwb84LleWQUokDcQoJRwCWa6WeVbqxLcbYBXLZZYW0jQ3BQDD/WcJDPtAVFE85Y7oA==
X-Received: by 2002:ac2:46f7:0:b0:512:a540:3c93 with SMTP id q23-20020ac246f7000000b00512a5403c93mr5701823lfo.66.1708444397932;
        Tue, 20 Feb 2024 07:53:17 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ot18-20020a170906ccd200b00a3ecdd0ba23sm1485564ejb.52.2024.02.20.07.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 07:53:17 -0800 (PST)
Message-ID: <462aad75-4f03-4f8b-ad58-eef429ed2b34@redhat.com>
Date: Tue, 20 Feb 2024 16:53:16 +0100
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
 <CANiq72nVkV3+1rt4Mi+Own6KGAzmvR2jf8fFsp9NBu_gy_ob5g@mail.gmail.com>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <CANiq72nVkV3+1rt4Mi+Own6KGAzmvR2jf8fFsp9NBu_gy_ob5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/24 16:04, Miguel Ojeda wrote:
> On Tue, Feb 20, 2024 at 1:03 PM Danilo Krummrich <dakr@redhat.com> wrote:
>>
>> That's the worst rationale I could think of. Without further rationale what that
>> should mean and why this would be good, it's entirely meaningless.
> 
> Probably whoever wrote that did not feel the need to explain further
> because it is the convention, but please feel free to open an issue/PR
> to Clippy about improving the wording of that text.

The rational for a convention can't be that it is a convention. Instead
it should be a convention for an objective reason.

> 
> The convention itself, however, you will find way harder to change
> everywhere else.

I'm not saying that we should enforce it otherwise, I just think that we
should have objective reasons for restrictions.

> 
>> Instead, I'd argue that keeping it gives kernel people, who necessarily need to
>> deal with both, Rust *and* C, more consistency in kernel code.
> 
> That sounds to me like trying to keep consistency in style/formatting
> between two languages, which is something we have discussed quite a
> few times in the past.

No, I didn't say, nor did I mean, that we should align with C in general,
nor should it be enforced.

However, I also don't see why we should disallow it as long as there is
no objective reason to do so.

> 
> We are keeping Rust code as idiomatic as possible, except where it may
> actually make sense to diverge for kernel reasons.
> 
> But this one does not seem to be the case:
> 
>    - It is inconsistent with most Rust code out there.
>    - It is inconsistent with all Rust kernel code.
>    - It is inconsistent with learning material, which kernel developers use too.>    - It introduces 2 ways for writing the same trivial thing.

That's actually what the language did already with early-return vs return at
the end of the function.

I admit that consistent inconsistency is also kinda consistent though. :-)

>    - Rust is a more expression-oriented language than C.

The language has various characteristics, maybe that's why it allows both?

> 
> And, by the way, your patch does use both ways. Why aren't you
> explicit when it is a single expression too?

See above.

> 
>> At least, this shouldn't be fatal IMHO.
> 
> For some of the compiler-based (i.e. not Clippy) and that may make
> prototyping a bad experience, I could agree (e.g. like missing
> documentation is already a warning).
> 
> But please note that patches must be warning free anyway, so it is not
> like this patch would have been OK.

Then it shouldn't be a warning either IMHO.

> 
>> Similar story here. Why is it bad, and even *fatal*, to be explicit?
> 
> This one is more arguable, and could be discussed.

That's great, although I really don't understand why you think this one is, but
the other one isn't. What's the difference?

> In fact, we planned
> going through some of the lints in a meeting to see, mostly, what
> extra lints could be enabled etc. You are welcome to join if that
> happens (I think Trevor wanted to drive that discussion).

Thanks for the invitation, I'm happy to join!

> 
>> Again, not a great rationale, this is entirely subjective and might even depend
>> on the context of the project. Again, for kernel people who need to deal with Rust
>> *and* C continuously it might be better to be explicit.
> 
> That is fine, but to decide on this like this, we need better examples
> and rationale than just "it might be better" (and please note that
> whatever Clippy says is not important, so complaining about their docs
> being lacking is not really an argument to change kernel code).

I agree, but I also think it should be the other way around. We should have good
examples and an objective rationale for things we restrict.

> 
> Cheers,
> Miguel
> 


