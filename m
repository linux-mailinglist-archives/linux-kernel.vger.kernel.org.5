Return-Path: <linux-kernel+bounces-163008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494EC8B6358
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58FF2B2107A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990C21411F2;
	Mon, 29 Apr 2024 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AN1ExH19"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A501411F7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421684; cv=none; b=eUgYZrLc+p+/0Y8cgjiKtgJx/PuLFLd3Xkho6NqfTn+iDeF732+BhpuZxVN4HaxdohxGq6W/VMv1LF2xcx8dOW/8/+qpmTQlXV3asXQ4Cajnkw62XSTmAeOqMuqwnazQ26id2c639eTrHsQWVp2VLBZfPfKfCLRyPA8A4wxczl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421684; c=relaxed/simple;
	bh=pzWtP8kr7lgSEV6tOy+qZ54glXeeWEPyNWM+bjA9ewA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ij0G0jN+cQwI5wUw8KIk+KpfqNa6/2NkbQL9EM8W7uDlx2JRTbdgjllMYhvfKEUYVhszGdfmq3z5qTYYPgaQTzcuPyqjV/oSzyM77z0zHL06rWG0leIAZ8Z+cnpjqD2GnquQN6Qq+b2VpEvCr5PQJwjV1WyDdTGyKeXQeyTyYWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AN1ExH19; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714421682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+deoMmPQLG+DLEK4zq4CzULvuFLJy4sLMw5MAgkMKuA=;
	b=AN1ExH19JZcWYULSnT4CdcYWwNZMGhekK1X/FO0utsCCaRAfsdmlbcaQK83pMq/7XqlfUT
	qTSeAdQ75/vMC0pP8b01dAirin1UODZqBJtopiTHMhZnyrjCmpc+q6k+eAR3Enj5+gKZHb
	MTVJXIvWfxllVeann3I2y39Ox2Nnpbg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-ixkVsYALML-f3PrTOJW1LQ-1; Mon, 29 Apr 2024 16:14:41 -0400
X-MC-Unique: ixkVsYALML-f3PrTOJW1LQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34b5bece899so3445686f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421680; x=1715026480;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+deoMmPQLG+DLEK4zq4CzULvuFLJy4sLMw5MAgkMKuA=;
        b=LfCW5az1S89YIOVTVXf2M9330LDdC0pLx8qzE+LfHna1Vk2Owtu2RCIi8xuTt9GgnI
         EhbpzNh4uFbAFM3Z+Wyil02khprZpImdKNHysRS0X4jiQ5TQxc273eiSJilBIE+UCXRO
         rsuqhAHi1XoPSvum8eOAOcG/yEFNE0/gf0wmFqi0sRsdwUv33HOzy07MgiCTDUY/Gvot
         8u7V8xNm4LK4+//8b13D7+a2rmb7rd7k+uVSVkql7B2yT40uTzMmOTm0VZgH/kZ4ADQc
         kkettWDTsX1LsodNAIhMquFhVkn0Ge2ufmJLv6E7scXJ2MteLHo5Eb6O/ZQ3tTZvxOyz
         37pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu41H3NsUWUAZEk8KIhYmchWfHni1p+pDToJd+1z5m8XLxQHWe9EpYdlzhxrX87FbL9WqQlnS3WpEUVAbPDYQMHj+30ysATtf4nPJl
X-Gm-Message-State: AOJu0YzdcEhDizWUn/J1mYqNkjCAbIUcxZGgy/5DcXCs6hRBp31EEsK1
	rNjR2fcdWLxDZriM/lXBK96LQx0yIizmvMgmmYodBc9vvCwbHLN9Gaxy3MDF4+KzG4FFNuEGj1K
	WH5fHRPNuCceNQOyUwPrrdxVJE4F0+7uUmO4iFgCk2eUJ4sRlkglqnJ6X0O1usw==
X-Received: by 2002:adf:f1cb:0:b0:34c:e47a:c0ec with SMTP id z11-20020adff1cb000000b0034ce47ac0ecmr3962235wro.1.1714421679921;
        Mon, 29 Apr 2024 13:14:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEz6SGFYqfUR2YOGE4FsoobYH1oyz8xWZzhOFj9WXmFKOjnkBVP3G06cW91bof5O7SDUrppyQ==
X-Received: by 2002:adf:f1cb:0:b0:34c:e47a:c0ec with SMTP id z11-20020adff1cb000000b0034ce47ac0ecmr3962218wro.1.1714421679563;
        Mon, 29 Apr 2024 13:14:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d6442000000b003479bec98cesm30306324wrw.115.2024.04.29.13.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 13:14:38 -0700 (PDT)
Message-ID: <e29f22c5-3d65-4d60-af0b-a440b6746dba@redhat.com>
Date: Mon, 29 Apr 2024 22:14:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Allocation APIs
From: Danilo Krummrich <dakr@redhat.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Zhi Wang <zhiw@nvidia.com>,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
 Wedson Almeida Filho <walmeida@microsoft.com>, ajanulgu@redhat.com,
 Andy Currid <acurrid@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>
References: <Zip4dFpt8xhk7UBL@cassiopeiae>
 <74cbdaf7-360e-47e3-bda4-4661422a11ae@proton.me> <ZiqkIQTHe9apd-LW@pollux>
 <f71c4e07-9f6f-4709-a3bb-012e644c4845@proton.me>
 <Zirfyp_NiYCRQYvk@cassiopeiae>
 <71dd99fe-0d64-47cc-b367-8fdd4fcdbdca@proton.me> <ZiuCm4VtFiCfzTPI@pollux>
Content-Language: en-US
Organization: RedHat
In-Reply-To: <ZiuCm4VtFiCfzTPI@pollux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/24 12:31, Danilo Krummrich wrote:
> On Fri, Apr 26, 2024 at 06:32:26AM +0000, Benno Lossin wrote:

<snip>

>> So aside from being able to use `Vec` and `Box` etc, I don't think there
>> are any advantages to using `allocator_api`. The disadvantages are that
>> it's another unstable feature that we need to get stabilized in some
>> form. So it increases the amount of time it takes for us to be able to
>> support multiple versions of Rust.
>>
>> I think it's fine for you to experiment with the `allocator_api` and see
>> where that leads you. But when we discuss merging patches that enable
>> unstable features, we should be sure that the feature is truly needed.
>> And that it cannot be replaced by custom code (it also depends on how
>> complicated it is, but I think `allocator_api` would be simple enough).
> 
> I agree, though I'm not asking to re-enable allocator_api necessarily.
> 
> My original question regarding this series was what's the plan on how to
> implement alternative allocators given the changes of this series.
> 
> This series clearly is a huge improvement, however, before it was quite clear
> how to implement alternative allocators. Now it's rather unclear.
> 
> It's good that we discuss the options now and I'm also happy to contribute to
> the implementation, but I also think that within the context of this series we
> should give an answer to this question.

In order to get a little closer to an answer I sketched up a patch series [1] to
support alternative allocators again and added, besides the KernelAllocator itself,
VmAllocator as an example. The patches can also be found in this tree [2].

Please let me know what you think.

- Danilo

[1] https://lore.kernel.org/rust-for-linux/20240429201202.3490-1-dakr@redhat.com/T/#u
[2] https://gitlab.freedesktop.org/drm/nova/-/tree/topic/allocator


