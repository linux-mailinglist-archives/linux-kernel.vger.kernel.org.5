Return-Path: <linux-kernel+bounces-73626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BC185C542
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B203C285D54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1506614A4CC;
	Tue, 20 Feb 2024 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOXg4eEd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB76BFB8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458959; cv=none; b=DuXz31qKQBTRU4g3jJ/n+OMtU76F5pjnZf5YMraE0Jq2D0PKOnoWqu518KviQ3RyEckZVCeTzixqOHm8lsQuIYUADJ+6pxdnLSLGkVz0w7R2sqibDNAfY+gYH96PO+T8P1KauSq56Rl3V5zBBLykq6FMzesDN5B+sjm8madgE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458959; c=relaxed/simple;
	bh=nyd+9GOMvavgqXZ0YaRqKHzUiavipX2Lbg12w9ySSEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkNTSXR+4V0clUKgxZxRqXOqCbXkloWh2b7OyqoTKEBmkt7oM/DDIC5Ob6CGry2lpFlQlD5ukh8NpWLUdL2Dw/m5IrJ20D35otmo/QOxuggT92a/cTKYPxsBirjWZfR6uZGH0Oy6IsJ3f7+LzmyQJu6Lwrp2eHudNejGwxLVF2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOXg4eEd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708458956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uyHevWF+0otpMjIyAgOTy4wZv/aTE0NbsvDAaIWioN0=;
	b=EOXg4eEd/Jy2MnrOFVQoG/3TKPeFf4xgbBv0vVxfUxXaeyx6qjxUEh2959SkFyVlPxgubu
	2hD05JXNggwnS7vbfwfLrARhGQmMwfaMq3C5pUS/tK0ZaGZblaT782irydmRfP/TmX5I03
	xRbkWfaBQPq46iqBQILygFoLFtwOIJs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-rZ4hg6IdMdi9COwp19Xltg-1; Tue, 20 Feb 2024 14:55:55 -0500
X-MC-Unique: rZ4hg6IdMdi9COwp19Xltg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a35a649c608so359175866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708458954; x=1709063754;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyHevWF+0otpMjIyAgOTy4wZv/aTE0NbsvDAaIWioN0=;
        b=SavaujQDXqpbpHgdssc4ce7y0gzqdZxFnEpsPBVAVsWHcMKoAV2iLN3k0dXosNjKPK
         1oPP5aNt4rM/r7q0UdfbsbAd9sbPKKF38JVf7AQDmkKw49Ya9yaQJx9P9NjAKxynEFgW
         DCfTOZN+b9n96n2L2AXnWAWllUoL9Hq8uJT9JvsKnssn7cfEPSY9aZEXuFNg4stTdku3
         +ukO98FWUYQi3IJbikdTs8/sPv9Bz/zuCMFeiiBtMaj/wKioYAXFpwhN8gEZrRre0jBe
         +zQQ6Q637iAuqsBG/6s/UIQCkkIMvSeF262jZEgOvYglkp5KfN67wwBGsXP6PL7GTdS5
         EoYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyzPjHB55zGgmsGZ0I+KNrkf0fz9M3Ge9q9P3KK6HP8BjnVwNl5cA6ao2dSxXfLc1CajteOPTd4rWd2Vxp26m3RlKhfrMEcF2ihvsn
X-Gm-Message-State: AOJu0YzTlBVucAMuo4+dCykR5ls+9oVeQSHPxf7L67zhYmElN7i/syBI
	A4tdzh+gcz1ArczhqCtHbfSTM6Rfbo1cnc2950gwXz3fvudoGiEwKMOQDDpwpMbhMHnpImY/MHG
	lNZjtlRrgv08eI8CjxZMvLhI+Y8iDpip7lv76UqVS19uAWPF1GEvvLVyHcOmFdw==
X-Received: by 2002:a17:906:564a:b0:a3f:29e1:1a77 with SMTP id v10-20020a170906564a00b00a3f29e11a77mr244746ejr.32.1708458954179;
        Tue, 20 Feb 2024 11:55:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZOzMGmty1Po3uqbF6oE2by9h3loAx1Hm2q3P4pQfPkYU06Yw+e7mXgpUgjQr4+aJ5fDgiVA==
X-Received: by 2002:a17:906:564a:b0:a3f:29e1:1a77 with SMTP id v10-20020a170906564a00b00a3f29e11a77mr244735ejr.32.1708458953907;
        Tue, 20 Feb 2024 11:55:53 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id lu16-20020a170906fad000b00a3d5efc65e0sm2941765ejb.91.2024.02.20.11.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 11:55:53 -0800 (PST)
Message-ID: <e8b4cb98-b0ab-4754-b80a-9df77983137a@redhat.com>
Date: Tue, 20 Feb 2024 20:55:52 +0100
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
 <462aad75-4f03-4f8b-ad58-eef429ed2b34@redhat.com>
 <CANiq72m7-5CuKAKDk=G9sauri_sH0nR2TXi8ye5Eji-qaum3sw@mail.gmail.com>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <CANiq72m7-5CuKAKDk=G9sauri_sH0nR2TXi8ye5Eji-qaum3sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/24 17:53, Miguel Ojeda wrote:
> On Tue, Feb 20, 2024 at 4:53 PM Danilo Krummrich <dakr@redhat.com> wrote:
>>
>> The rational for a convention can't be that it is a convention. Instead
>> it should be a convention for an objective reason.
> 
> The rationale __for the lint__ is that it is a very established
> convention in Rust code.

Understood. I'm basically just asking why this is the convention.

Because I assume that there must be a good reason for that. If there is none,
and it's really just because everyone is doing it, I personally think that's
not an objective rationale.

If there is no other reason it could even be just the opposite causality, as in
it became the convention because clippy enforces it. (Disclaimer: I really don't
know and so far I have no reason to assume so.)

Generally, I don't think there is anything wrong with questioning things and I
also don't think there is anything wrong in not accepting "because everyone does
so" as an objective rationale.

Otherwise I don't see any disagreement. I also understood that you want to be
consistent and comply with this convention and surely I accept that.

But again, I also think it's perfectly valid questioning things.

> 
> That is what Clippy is telling you.
> 
> You may not agree with the convention (and thus the lint). That is
> fine, but it is still a fact that it is the convention, and that is
> why I said whoever wrote that Clippy description probably felt that
> wording is good enough.
> 
>> I'm not saying that we should enforce it otherwise, I just think that we
>> should have objective reasons for restrictions.
> 
> Again, you seem to be saying we do not have objective reasons.

I'm honestly sorry about this misunderstanding and that this seems to be an
emotional discussion for you.

I never said that you don't have objective reasons (in general). I just said that
I don't consider *one specific rationale* as objective (or factual).

And I think it's perfectly valid to claim the right to do so. This isn't a personal
attack in any way.


