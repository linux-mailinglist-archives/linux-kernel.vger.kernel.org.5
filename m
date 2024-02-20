Return-Path: <linux-kernel+bounces-72974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E7785BB52
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816E728231E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9D167C61;
	Tue, 20 Feb 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfYlWj0j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB167C49
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430578; cv=none; b=dsDFM1YmHAA71/3MXYMZ59/OG3QiC7L7GZQFtn9xndZOv5zJjFUq+fRXo6mOmGJQCKKfCWijPOG4htDomqdrof43sARFJdvOn4B1zH8cpxDA9dy0X6AAmS80OlYWiMzsu4RiBMpwwJ9XdxXb6rGxoz5vRj9/ntWUC2QSlhGY/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430578; c=relaxed/simple;
	bh=Qwei00/D5+DhbgFyfiZlK9K80IEw6DOD6oSgL5igAM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lw6lnaz+ojG82xVxipic96jBT3gbF8b60bZaM+xt7a2NXFlboxGbiCynKAq+9kvXGMhk9zOVmTQ+E/Wup7Bsf4O5RdhT4muZhpt1O6RrlmiPeTO/6pF/H7Rcg48gr6AZdQ5LHfYMacJZBtLQ7RCpsDrM1e7h8dEKikJ5bEYknOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfYlWj0j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708430575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ymRHd/JZiWlQ7BK0HpkEMNKkAfVIgEXtX8VQjIGxto=;
	b=NfYlWj0j7mzeoHCVrmwRs73F63JwbsoU+4YOrPAms669R3LJKPTw3PlfjVqVQiLgIyE+O7
	ZkPqHQbOL4vOYMakGSTpSRvXApK8I1ylWV1OhXtzz2XIKdNFE/r3682qcXow3+vB16tq3x
	18DGFbmyQY/JnvlPvr/ZX8ErLQX+YHo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-61yHECyrMeuRlDRliabLBA-1; Tue, 20 Feb 2024 07:02:54 -0500
X-MC-Unique: 61yHECyrMeuRlDRliabLBA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51161adad50so5472432e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708430572; x=1709035372;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ymRHd/JZiWlQ7BK0HpkEMNKkAfVIgEXtX8VQjIGxto=;
        b=BlAV6tUgZR/tjE7/4bytV4sQ4iiHPVuv7ZlETLD80XYcDOu/hNFY0gsg1ck1bYxme5
         1aA+cpJpGOV+01a9l+fpkJcdR6kj7K20WDyfMVztkOe882QM0jxgF7t/XCvFvGLM6HFd
         Iu73TXWcwPmBtvHt/Y8cDK8ZOLQk4FVoehsOyz1I/6hod1660RyjgqkBslAyVg+lNjNa
         BRVnyFlvw/gUfFhp1lZRB0CZ+nVxDFS0E90GrcbsD+TNjgo56br+IsWpIxRlrqQiVZoD
         9ZIhRlbasczFxNNpS5q8YX1NXWEL+KfxG3rSYFPzphsJmM83tBDPv+bo0yOCaufzW9uR
         qmXg==
X-Forwarded-Encrypted: i=1; AJvYcCVNkD1AqxB67Gsf6uHg+YAMvSno52MzVTap+ybzUmM5NHZBhS+NATHs2hW50fuLs47ML4asbgB5U1C2MLLMoV8kk1RnDk+nnrnmQE9G
X-Gm-Message-State: AOJu0YyBQZ38o7DvKUoIpQ+q5ZcOA+3nYoaf0I/8LE+QqZFChmWFK7ZJ
	BjyNR2fKEnMFF4/IwJP5GZKESLHeoCJZi+5hf3QccGq06eL+vgbQp4yNqI/zntTSsi24ZjKc1Tx
	PfJDCs6GQwQ5++PAqgnMmuIufrdc2HS+S2YQAhfAIDO3k9UmTWt32zX1aKn3d3g==
X-Received: by 2002:ac2:5e33:0:b0:512:bdcd:f22b with SMTP id o19-20020ac25e33000000b00512bdcdf22bmr1981484lfg.64.1708430572606;
        Tue, 20 Feb 2024 04:02:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6w/fhcXDPnyA798UBa/GUqFRWQbgOG8VGTCfHDbaR2CAZ7+y/U97oxneA3LSvOcgBNEXS6w==
X-Received: by 2002:ac2:5e33:0:b0:512:bdcd:f22b with SMTP id o19-20020ac25e33000000b00512bdcdf22bmr1981470lfg.64.1708430572227;
        Tue, 20 Feb 2024 04:02:52 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id et5-20020a056402378500b00561c666991csm3546875edb.73.2024.02.20.04.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 04:02:51 -0800 (PST)
Message-ID: <e543b270-dea7-477a-b83d-62129d4ac708@redhat.com>
Date: Tue, 20 Feb 2024 13:02:50 +0100
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
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240220093541.280140-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/20/24 10:35, Alice Ryhl wrote:
>> Add functions to convert a CString to upper- / lowercase, either
>> in-place or by creating a copy of the original CString.
>>
>> Naming followes the one from the Rust stdlib, where functions starting
>> with 'to' create a copy and functions starting with 'make' perform an
>> in-place conversion.
>>
>> This is required by the Nova project (GSP only Rust successor of
>> Nouveau) to convert stringified enum values (representing different GPU
>> chipsets) to strings in order to generate the corresponding firmware
>> paths. See also [1].
>>
>> [1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/String.20manipulation.20in.20kernel.20Rust
>>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> 
> This looks good to me, so you may add my
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Thanks for reviewing this patch.

> 
> However, it looks like this patch has some clippy warnings that need to
> be fixed before it can be merged.

It seems that those warnings are treated as fatal even, although, given the
rationale for these warnings, I'm not even sure those should be warnings at
all.

> 
> $ make LLVM=1 CLIPPY=1
> error: unneeded `return` statement

I fail to see why being explicit is a bad thing in this context, and even more
why this is treated as error.

>     --> rust/kernel/str.rs:267:9
>      |
> 267 |         return Ok(s);
>      |         ^^^^^^^^^^^^
>      |
>      = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#needless_return

Following this link the given rationale is:

"Removing the return and semicolon will make the code more rusty."

That's the worst rationale I could think of. Without further rationale what that
should mean and why this would be good, it's entirely meaningless.

Instead, I'd argue that keeping it gives kernel people, who necessarily need to
deal with both, Rust *and* C, more consistency in kernel code.

At least, this shouldn't be fatal IMHO.

>      = note: `-D clippy::needless-return` implied by `-D clippy::style`
>      = help: to override `-D clippy::style` add `#[allow(clippy::needless_return)]`
> help: remove `return`
>      |
> 267 -         return Ok(s);
> 267 +         Ok(s)
>      |
> 
> error: unneeded `return` statement
>     --> rust/kernel/str.rs:284:9
>      |
> 284 |         return Ok(s);
>      |         ^^^^^^^^^^^^
>      |
>      = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#needless_return
> help: remove `return`
>      |
> 284 -         return Ok(s);
> 284 +         Ok(s)
>      |
> 
> error: deref which would be done by auto-deref

Similar story here. Why is it bad, and even *fatal*, to be explicit?

The answer from the link below: "This unnecessarily complicates the code."

Again, not a great rationale, this is entirely subjective and might even depend
on the context of the project. Again, for kernel people who need to deal with Rust
*and* C continuously it might be better to be explicit.

>     --> rust/kernel/str.rs:677:58
>      |
> 677 |         unsafe { CStr::from_bytes_with_nul_unchecked_mut(&mut *self.buf) }
>      |                                                          ^^^^^^^^^^^^^^ help: try: `&mut self.buf`
>      |
>      = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#explicit_auto_deref
>      = note: `-D clippy::explicit-auto-deref` implied by `-D clippy::complexity`
>      = help: to override `-D clippy::complexity` add `#[allow(clippy::explicit_auto_deref)]`
> 
> error: aborting due to 3 previous errors
> 
> Alice
> 


