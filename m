Return-Path: <linux-kernel+bounces-65653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE7C85500A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427541C21B40
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345D885263;
	Wed, 14 Feb 2024 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdAEMKUO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02557C6D4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931238; cv=none; b=iZCUDGwRFq+Ldxhi3P/iKZQOne6y7TUxCLlXvejjEu/jtV8qypAGT7dzvvOrYlO8fbbGeelkAQdi14yOVVbSs6IEEwOmv9l6H15vCzov56Bj5j9uh7xLKeyyLKfrMzmEbKvPty0sRE9UVxsQc40HOpuRvmvtGrpj+8Br5G00B+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931238; c=relaxed/simple;
	bh=rZQpvm2949OmV6YOny6ngBjCzUMUCrxTtcAoU6BH6Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9vIPGibYt8bty+4TB7ITlIdjhQxDlYNjo4c6UFQO15OhXdG/Wl2ox79eBEU6COdpb1McUkrAPbPfFgV/SdNk6Ea+Kif9+eKpu7vU7AQJ9uGuGSnvZy7EgDFMrNrx48vCXqT53sR19h/l/XB2K2J7F5V5XSsfp0H6aqQBNGpG0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdAEMKUO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707931235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ovk2oX2orbIAKyGqMXy7ixB6AoBlYOpjfpWbhXahpTQ=;
	b=bdAEMKUOHWcrMdnWVy2/5ygvz6PGlkP33pcq9/tH3sWcmMacig7FqYuc5lrQ023wrGFXbn
	vjS27/xpYmwtTSPRJQhUIQPt4xH0N7FWm74/HdbY6gDea0tN2CzGx9kKxc7Fk+vBfR2ghA
	PNuOhwFLk2OGxAmEQ8xznIHoj00y7Ro=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-zuPn1vFcPe2ln9W4Zjaxyg-1; Wed, 14 Feb 2024 12:20:33 -0500
X-MC-Unique: zuPn1vFcPe2ln9W4Zjaxyg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3d114fe9b6so70840466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707931232; x=1708536032;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ovk2oX2orbIAKyGqMXy7ixB6AoBlYOpjfpWbhXahpTQ=;
        b=H0W/DArPEtW3pEWnQOfpB4+OPWY4pychXCQALrS8wkm5nw7wOSGBybdXxuwTjYVwKm
         uadXAA+Sl5bNti33QKhc2pALsX3BfmWcOQEy9W9vyb1It3MvG++n+Dg6H2SkKG95ecL2
         i1BziYV0ofQ72FZ7Sr26xP7nHwr9iprOkj53gLGMfPI5l8DG0zTsueBV3w3ykjisJ3Lk
         JgzmEfwBtyzWxcBcPqZz1a/4EMwvWcXoOwTXNyn9ZPfz39W6fE3vetzpQbsAVTEm8sqt
         MkcdqoyzFsv1d8Rx7XBWLPXD5hpWL0bdqB7fxAOqLM8OPx8WJKnB8WYOvGJxjsWoI4Ol
         LJFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFL0LzhdPVKty9pktxQDhmseAhWNcmKvND53w5pAEveQGkqNZgC3hg2w55Szeq3BkZ7uxJee//nPA8aJqFa6wU7sYFZugy2ze6RyVT
X-Gm-Message-State: AOJu0YzPNAdqpHm1LOFmyqeJ+FAzAkvTCrFMovBCuikKYC1IYfCL+Dlg
	lbVcUujsJNTn7GqQqz53Mqsnn6Oy7Cm1/FMkslQ/DS6JcN21stTaPQqZPbqklwA8lrWE2XYyelQ
	dUbxEcxUV2vt+FWrc8V+RDVAzKnJRs08dXqtB8D0+QdS3j018FJSaH/4q7nejfg==
X-Received: by 2002:a17:906:459:b0:a3d:26db:b05b with SMTP id e25-20020a170906045900b00a3d26dbb05bmr2576299eja.14.1707931232236;
        Wed, 14 Feb 2024 09:20:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNWEcylqQIB7DYfeUi0TPm6NJ7N5bNqDGnpBM2Ojzlxvf0336clxkKnR79u0IJ8isMXnTF8Q==
X-Received: by 2002:a17:906:459:b0:a3d:26db:b05b with SMTP id e25-20020a170906045900b00a3d26dbb05bmr2576280eja.14.1707931231965;
        Wed, 14 Feb 2024 09:20:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWM4KZtzQ9AqpaFNV6aoe/BJvP08r0+Z0bHteT8pJrhy1AWxBLB5EiJ6/ZZ5HwEkfeCSnujDILPqKmsiy9EKhpIplM6baudpNgdBN5OUfhv26vZm1ao8yY4iTc0CuN26u+3t9utOGc8WhiV1pvLE9oT7MaHQL+w1h5q9ga9ugFiH7tFJElYHk2qGrxv6jpxrVujaHFyhSfwEBQkWdabiHgKqCFemSnfq/L0BqfmRSZovUr3aVjVUKfWKYlNvF9N96jSM/fdB2MRGhVQQ2gI0H/CeNNs+VcjgktXumYTgu4rNVfAmpo4mEeRtK83iDUIMp1pezVvUHgh3YTnMY1KovPztLJskGDkiAzP
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id st1-20020a170907c08100b00a3d581658bbsm576484ejc.86.2024.02.14.09.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 09:20:31 -0800 (PST)
Message-ID: <ce189a14-78da-4897-b505-792330620de5@redhat.com>
Date: Wed, 14 Feb 2024 18:20:30 +0100
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
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240130023843.11512-1-dakr@redhat.com>
 <CAH5fLgj-0Li7E4KGKV0e1-dF9x6TQXS6E_KyagY2ndQV8MSVnQ@mail.gmail.com>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <CAH5fLgj-0Li7E4KGKV0e1-dF9x6TQXS6E_KyagY2ndQV8MSVnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/13/24 15:19, Alice Ryhl wrote:
> On Tue, Jan 30, 2024 at 3:38 AM Danilo Krummrich <dakr@redhat.com> wrote:
>>
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
> Not a deal-breaker, but this comment of mine still applies:
> 
> https://lore.kernel.org/rust-for-linux/CAH5fLgiwRDcyaxbcUNY8M1c_w11vkCWyRfqVVrN9Sgc7XYT0xw@mail.gmail.com/

I missed your mail, gonna send a v3.

- Danilo

> 
> Alice
> 


