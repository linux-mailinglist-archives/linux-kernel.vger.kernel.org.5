Return-Path: <linux-kernel+bounces-63646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0118D8532BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4CC28564C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3377957867;
	Tue, 13 Feb 2024 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOdGpNyo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1457310
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833552; cv=none; b=UpQWHAw7lYhLwB0NI9hmbzO4Wy3eCjvg5VmZNa9C0s1x5l1g36nBhRmfUDE5U1l4Mr8eb6YveBkiTKp/3TqMqEEAM9x9uZzRshqOBnCQ/x1F+ztPkxfogO+rYbHdSw1khog47B+j+sl/Jhg3w10ES1wrG1nYGESNpdH2D4ziW90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833552; c=relaxed/simple;
	bh=AHP1+Eu4wYYx8Y5l74zyknWJRCFX6KetbcbD/GO0amU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sISTO4pKhfr9FQVdZs5tFgHKa0Hb0qqTe45UNmgS0ipdJ6u7dP5nDWHxZTX45F2R19HZsjF4N1Cr4uAbPn2gNtE+mvEUxgUSWJwyxGt++AqFQjoYRTgHoJJxDa7pnl/ADvGvxXzSrwbem5Pans9e+h6xDKCZ+BFY72gNWu8dFFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOdGpNyo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707833549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6rbkIwSAyIfqWRBUJKQNzVzIuH/yXueV7/fJUfX8mg=;
	b=WOdGpNyo97kz+KYg3WKGYu5ZzsUuQn3DMkOwwBr22ikGmX2ZFFQkzCtSc9/vT+6x/M55hC
	ujVxNAEGdYPkwjRoUggJUzwy8rQjn+jqNqxf5419EbAZw2YFFm5cWNB8Vj7NcKPleNTe36
	c2Rs7UmBqOJEaawLV1YLx/ev0rALTeo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-FlANUs6-PLCXY2gblo7aaQ-1; Tue, 13 Feb 2024 09:12:28 -0500
X-MC-Unique: FlANUs6-PLCXY2gblo7aaQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3ccb68f284so99545466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:12:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833547; x=1708438347;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6rbkIwSAyIfqWRBUJKQNzVzIuH/yXueV7/fJUfX8mg=;
        b=djD7i+YkyIzvvRS5UO9zIT1bJW/5pcelV2ozuxKjCzPEAxp2Igv80SpMDpK2MbFt2W
         PA5+YEwdiwL5sFJhJK3sdWgPd8I/RWO1pMMIlqNt8UYCqmqg7bd6+pU2OCn7eU1U5unx
         QJ8emEN3003StnandiN+nudkSLlMZ5Emn9lGASu6+Ro1u3dIr/8jIsotiIKSnn9diBE2
         xCE0OLmL1VsNiQ+qkAdrkOv254UTnxD2Erd2ES+wV0nLJNfSmMNY9Cf1xk90T15DQpsZ
         krywt0tCDgCnqPqwJ+ExF5zg61/vBodfxtw/i4S5jLcR7saTOAiLxPNZMK03fYvFdB36
         wyvA==
X-Forwarded-Encrypted: i=1; AJvYcCUnNY1IWHw42YjrwK+QxiciPTIsGymm3JTTaYjRL0IQsKGGStodergGi9iqPCUj+0SUZJmxUOOpIvQ+sme0Ew8dATXA3mS5rLO2BhtS
X-Gm-Message-State: AOJu0YyrXqvdqkcjFWQojoDWxpXp2NjC96oELeawWBxMqRQXsLwJgi1a
	KOtikNZ42cuIVETLmY9gMhA3x0n5lDf3hX3ZxX9y3GiQHCdjL4PsgQgeeFuaYUmNMTFTdooy+5S
	ndN5kr5qYNxRS4WmOlKKcLASjIKcqjh55n586ywQ6cQiK78zajXprc4fkBvq2Rg==
X-Received: by 2002:a17:906:fc03:b0:a3c:f575:a0f6 with SMTP id ov3-20020a170906fc0300b00a3cf575a0f6mr1354696ejb.72.1707833547061;
        Tue, 13 Feb 2024 06:12:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOU4GWx7MzZH5LrucmXe0l3gXVTQ/u1dam/m7zPrH+EliMJ0ZbAiCzOIwnGXMrkxraRNRbew==
X-Received: by 2002:a17:906:fc03:b0:a3c:f575:a0f6 with SMTP id ov3-20020a170906fc0300b00a3cf575a0f6mr1354684ejb.72.1707833546716;
        Tue, 13 Feb 2024 06:12:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMtjiFxFCsW8UEezOFIYW6WmsQzFHynb/J2ec1SjCJwZpVmAH9HXsfRJ4LGnz+yUxrPCHxLIehDivTNYW4gQZKl2ktVohyAFuGYy4FGezPnv374dQw+ncm8TuCyCdJWMy1wcV4BVTyo+UBxwuBgn1MQ6XFZrxpWMP4+eoZ310HbcXORzyee4eLIq9sdrMt3tpVcihWBpDPn0kzFEfWyW+S0+Y6qbGCVqf3vndxyYDmuDKIiBuwstyT8CwggQRlgHYnRdQRseGnjUD7EZGGr92cPRO3rNDPIf1tbI4UNn5cp2hflV8XjXzRtTdM3Dlm/rCn5DRcT9NID4EXL6wmU5I=
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id w22-20020a170906481600b00a3c5661c646sm1324520ejq.148.2024.02.13.06.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 06:12:26 -0800 (PST)
Message-ID: <04049a83-c757-4103-9d63-f303686d8dbf@redhat.com>
Date: Tue, 13 Feb 2024 15:12:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: str: add {make,to}_{upper,lower}case() to
 CString
Content-Language: en-US
To: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240130023843.11512-1-dakr@redhat.com>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240130023843.11512-1-dakr@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/24 03:35, Danilo Krummrich wrote:
> Add functions to convert a CString to upper- / lowercase, either
> in-place or by creating a copy of the original CString.
> 
> Naming followes the one from the Rust stdlib, where functions starting
> with 'to' create a copy and functions starting with 'make' perform an
> in-place conversion.
> 
> This is required by the Nova project (GSP only Rust successor of
> Nouveau) to convert stringified enum values (representing different GPU
> chipsets) to strings in order to generate the corresponding firmware
> paths. See also [1].
> 
> [1] https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/String.20manipulation.20in.20kernel.20Rust
> 
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

Ping.

> ---
> Changes in V2:
>    - expand commit message mentioning the use case
>    - expand function doc comments to match the ones from Rust's stdlib
>    - rename to_* to make_* and add the actual to_* implementations
> ---
>   rust/kernel/str.rs | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 7d848b83add4..758bb70d98e9 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -581,6 +581,66 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
>           // exist in the buffer.
>           Ok(Self { buf })
>       }
> +
> +    /// Converts this CString to its ASCII lower case equivalent in-place.
> +    ///
> +    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
> +    /// but non-ASCII letters are unchanged.
> +    ///
> +    /// To return a new lowercased value without modifying the existing one, use
> +    /// [`to_ascii_lowercase()`].
> +    ///
> +    /// [`to_ascii_lowercase()`]: #method.to_ascii_lowercase
> +    pub fn make_ascii_lowercase(&mut self) {
> +        self.buf.make_ascii_lowercase();
> +    }
> +
> +    /// Converts this CString to its ASCII upper case equivalent in-place.
> +    ///
> +    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
> +    /// but non-ASCII letters are unchanged.
> +    ///
> +    /// To return a new uppercased value without modifying the existing one, use
> +    /// [`to_ascii_uppercase()`].
> +    ///
> +    /// [`to_ascii_uppercase()`]: #method.to_ascii_uppercase
> +    pub fn make_ascii_uppercase(&mut self) {
> +        self.buf.make_ascii_uppercase();
> +    }
> +
> +    /// Returns a copy of this CString where each character is mapped to its
> +    /// ASCII lower case equivalent.
> +    ///
> +    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
> +    /// but non-ASCII letters are unchanged.
> +    ///
> +    /// To lowercase the value in-place, use [`make_ascii_lowercase`].
> +    ///
> +    /// [`make_ascii_lowercase`]: str::make_ascii_lowercase
> +    pub fn to_ascii_lowercase(&self) -> Result<CString, AllocError> {
> +        let mut s = (*self).to_cstring()?;
> +
> +        s.make_ascii_lowercase();
> +
> +        return Ok(s);
> +    }
> +
> +    /// Returns a copy of this CString where each character is mapped to its
> +    /// ASCII upper case equivalent.
> +    ///
> +    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
> +    /// but non-ASCII letters are unchanged.
> +    ///
> +    /// To uppercase the value in-place, use [`make_ascii_uppercase`].
> +    ///
> +    /// [`make_ascii_uppercase`]: str::make_ascii_uppercase
> +    pub fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
> +        let mut s = (*self).to_cstring()?;
> +
> +        s.make_ascii_uppercase();
> +
> +        return Ok(s);
> +    }
>   }
>   
>   impl Deref for CString {
> 
> base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3


