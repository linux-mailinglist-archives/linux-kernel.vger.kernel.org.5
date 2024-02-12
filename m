Return-Path: <linux-kernel+bounces-61772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D056B851664
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011451C23766
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8532E47F6B;
	Mon, 12 Feb 2024 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqOzInwP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE233A1D0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746075; cv=none; b=QLvucAQTe9bznLMXkLbiqBYDATx5qbd7fa/PN8GZHYLZsMpP5U9qDFHe/17He7VMYt+VsCIwv0NsMObXhjJfHefRcy8UGUY2qD9ml5mMuZK8mKzNDQEWJpEeikMtXjnzaari//mvONVAhoXXm7oQpXsnwNqN1CrvmtsK2MbmJR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746075; c=relaxed/simple;
	bh=Ev0Gx4Yc5/QewIA31s+hPWeBidroCsrycUyXp1zUIy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQ+Y9Bgyekm/gBB0T2/gvstK88Q1IaP5rbj2gXC96sS6+UKk+XDQg6d7pV36iaMbZfpP/85QLkCxsDskd2hP9jkDyzTClgFrCAiaP45Z/Hu/ao3nB/3ZoXb+TSk63tUcX9tg/BTmdvI3Neja6OgAtHUZiwCYZWEVGLhBCAUduCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DqOzInwP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707746072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YP7Y72pR3TzaVeTLoSMRU6+Mwmpub8nSmmmtqDdNsGw=;
	b=DqOzInwPHd6+hKipsewW9jiAUh5HE9U4p1zYl5UPYV6RdhmJeE2pfRbr4qTX+xBqMS/K9J
	eNwzz9QwRPgHvmwmRAaZyQYEH82Y00x3c0Kc6dJbr37WxJo5rJWZ1zrrGyxLWUwAokAJ3/
	qmuYDmVGN1GiEu08NKdNTrojE/HcvHQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-Ka2GYmTyMeOC3tMB9bA27g-1; Mon, 12 Feb 2024 08:54:31 -0500
X-MC-Unique: Ka2GYmTyMeOC3tMB9bA27g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4107469e8adso18235425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746070; x=1708350870;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YP7Y72pR3TzaVeTLoSMRU6+Mwmpub8nSmmmtqDdNsGw=;
        b=I8dgKc1dyhVarTgp6lwtJfir1lf/JsqyF+wdMYbgARwZe/p2NpR8NyQyGQrUJi9D8L
         +adltvb16FEfhlJkqpPCCJVSZtx1kU1xi/yjX2b77ij/j0dwcKYgb5dS4p8aECnXjKf1
         +mUQIuafILpIb+0Rbi3iYCDUsrBGaOjC0Xo5fBOrDwyNzIpIuq8/sh8RTA2TbmIQ8M6h
         JHfW8biKlkYX585+3ovjex1FfIJ6q+la823hIlG75wHKa+1G+semyAoH5X+oBd7S78tT
         yMkUlbo6x6LALEx0FWYyYhr6id/zPo4sZHbdidiD6Q0LF5cFj43aKL3zB2c9DYNZITIl
         wYmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUACQSVSV+kF/z975j5u4wHrDFvaWKeiuQA0dHQrQbTmxM1yQxL1o4+Gu718VvOUD3OYucussOBS16ndYjq4GbldvLj1ETsgg5siw16
X-Gm-Message-State: AOJu0YxGzvvnx6Q4iCueRh0jlEXIi2FAg0lT3dUOaX7lzvpeUDnPX9lx
	ABcVcOGBpeyrWdV6HLhfxLcru7f/owqmoTMSkTeOgvnlJEQAY55fAJtZEf3HZWvkhCf8Y1aj/ho
	OsOS+5Kp0v//8BZTjbn0Wub3uaxJDIV2J5CRthH3xUUHuRtUyUexfCx+kZK5khQ==
X-Received: by 2002:a05:600c:1d82:b0:411:a8e9:993e with SMTP id p2-20020a05600c1d8200b00411a8e9993emr79133wms.32.1707746070481;
        Mon, 12 Feb 2024 05:54:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECqjY4b/HynzxzJ2l+7/0bVWIETsdljuuAUD3AMoClAzlgC1kozPzME5eFXS62b0PYVkarNg==
X-Received: by 2002:a05:600c:1d82:b0:411:a8e9:993e with SMTP id p2-20020a05600c1d8200b00411a8e9993emr79096wms.32.1707746070090;
        Mon, 12 Feb 2024 05:54:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrxG08xbF92anXCefVJKs4zYGQ6FMEDjKc2YetNG2vh4Bg4ZCnCsPM1AeM2s7LPqH1NZaBpVhdNYZXh8eoa69XRJa7RDpwA7WX9efD0mo2EBSI6osKvdy2MIsbjTvoflbj04Hl1hPq+2Ys6ZgX/5DNEobWqiu1OLmOuEj0LWYiMdeHXLX6+usmiNl2Ng9hGfm/rfpp9fmE6DMR1Dr4PfDcYvaSmXKMkmAZImLM1hd4t31wJ4+9zwqJkTnipshs5fPPL0X0O3Uvg8H5fFulYkYD2OPe9S6qjlesFjojqyEjTqnZWMmgKSG/MGAQ+Qd3P/8A2/wuvuMY6VGVYFH5YmppFaXeByzDlBavtELstwJcZMjyAfhDUaOkc1iYAz9NZOjPMv6lLai7Qf4h5KNPxotLQ926Qs7iOj2O2ttR0fmlqGmY/eTID2f6XWjmfloTAv0q8aJB8nkoLVUJBMsxRxJw0mQkJkXA5vO9pqqYKfG/4P6/PgBry+x2AY6nw3n6lyI1xLduov664gL1BigaeB4HYrpuxzPbv4Lo69US8Iu2dPbd98415V9m41pkxzp8G8EHWa+tX0Yz819QOE5/0/xKyDIE+haoZ+lU5aAohEvijwZJSU39CWLaoeq1A2V6/gR1uxcoclr7k1Q9YZNKRMBxslsbp6wniWUoTQzD+Fy7zDrwSg3HXTHP6DJq3UbxmrZ2aVJMzJW4x6dPz5B3NmE31/pwF9LptuXsmKX6McG0lSK9An9ALBEKG/B1mF+o1K5pdOxkyge0P/VTJuhjSpmunKrxyz0SdkpRIRFGJGZUbi7Vl6M6b9zaySa5EoJ59sQtLsgHzEjZznMDyJgi8TFxXEMKjjIkLN3OPgtQ0onCMr/n0UFJwlPHD5OLJg==
Received: from [192.168.3.108] (p4ff23a05.dip0.t-ipconnect.de. [79.242.58.5])
        by smtp.gmail.com with ESMTPSA id ay15-20020a5d6f0f000000b0033b4ebc3c8fsm7090793wrb.2.2024.02.12.05.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:54:29 -0800 (PST)
Message-ID: <a91cfe1c-289e-4828-8cfc-be34eb69a71b@redhat.com>
Date: Mon, 12 Feb 2024 14:54:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/25] arm64/mm: Wire up PTE_CONT for user mappings
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 James Morse <james.morse@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard
 <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Yang Shi <shy828301@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
 <20240202080756.1453939-20-ryan.roberts@arm.com>
 <ZcoIVypNwOPIX30w@FVFF77S0Q05N>
 <c899f252-dbf3-4e7b-8342-b5a5180486cd@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c899f252-dbf3-4e7b-8342-b5a5180486cd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> If so, I wonder if we could instead do that comparison modulo the access/dirty
>> bits,
> 
> I think that would work - but will need to think a bit more on it.
> 
>> and leave ptep_get_lockless() only reading a single entry?
> 
> I think we will need to do something a bit less fragile. ptep_get() does collect
> the access/dirty bits so its confusing if ptep_get_lockless() doesn't IMHO. So
> we will likely want to rename the function and make its documentation explicit
> that it does not return those bits.
> 
> ptep_get_lockless_noyoungdirty()? yuk... Any ideas?
> 
> Of course if I could convince you the current implementation is safe, I might be
> able to sidestep this optimization until a later date?

As discussed (and pointed out abive), there might be quite some 
callsites where we don't really care about uptodate accessed/dirty bits 
-- where ptep_get() is used nowadays.

One way to approach that I had in mind was having an explicit interface:

ptep_get()
ptep_get_uptodate()
ptep_get_lockless()
ptep_get_lockless_uptodate()

Especially the last one might not be needed.

Futher, "uptodate" might not be the best choice because of 
PageUptodate() and friends. But it's better than 
"youngdirty"/"noyoungdirty" IMHO.

Of course, any such changes require care and are better done one step at 
at time separately.

-- 
Cheers,

David / dhildenb


