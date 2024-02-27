Return-Path: <linux-kernel+bounces-83861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F7B869F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C409428691F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FE850A6A;
	Tue, 27 Feb 2024 18:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KGyOJPxa"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01C21EB20
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059868; cv=none; b=hghYVIAS952VzNqTx6E6ULXEpNDDtgj7wGoAesIRXFJfNloPYUvVNaie1KUpGICrX8TCHR4xrAeLY6IvcaOX9rtJ5UHt6eOxAktTd4PNWVBxM77Z6mFTYfwpIzUzeWh+Sz6sYyvijMQT04aqV69d0aV1Y8iJXrJ8MhEPb7v99QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059868; c=relaxed/simple;
	bh=YlWm0lELQ5xDSf+iW/m9/mgQRvjaHGGY0PFUNvAPAEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0v/jorJ0Bi0Ao2/YbWJ2wbvzhOYpqI0Zh+DAyvR5JO1Mi0a1rpgWXPL5BdmBvnK3nLMLR1mNBQiDjNru2GB4MjQtGomjrZWsYKchE4sV2DdamzlmId1LWR3Ai2NuBdj3RumKkwIHuWTAxQFX9UEGRVoXrOu6JLACRamXanL56g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KGyOJPxa; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c403dbf3adso244319739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709059866; x=1709664666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drJreYx4pAFp2nnVZ0PvEgVW3Uejo7zf3o/ymgjKE2M=;
        b=KGyOJPxaaxir0gV2fLzRLzcO9v3woPpCC8ApZ6FsSuu62e6P0LD/bDzr+TwhE8dz3O
         1AweMEdq1IjnqlXvvDBVJz/Crb2thUOAV833Vpjf7oFHisUmFphr9OTMED5KySDpLWJ5
         QozsAFSGOUOgwowCTDX92RE7Rs+wC8VSdZ6VPZVHvesnyKI+lpXVMu0ayHzu6kNrotoo
         9O6plb5nekJj22INIVD3DxwEH98dp5RGWfoWkjvE040WoQRtb53uBcm9XC90PQX7zDcp
         KjMRtjULxUXjG8n15WN6Kpsm0HV45euWvWC8iUsKDRJgXkLLDxZx10bYPriJE5gYY+Da
         oQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709059866; x=1709664666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drJreYx4pAFp2nnVZ0PvEgVW3Uejo7zf3o/ymgjKE2M=;
        b=SOBdttYMh0Bc8AMZ7e3bVm1pW1vERaW9ZijZzCOSif1Utr3GECR92/ZOTR+k4GePmB
         rA/KyrsNx8PAe7kof+SlQvJ6UR8uy0L2qRckZ5J9cTQnamqIRbzh+pbdevqWi/sjRgxt
         4rRh/1Fwpb2qLsackBTeybWDppcKoDfCpmT4W5xKkKWTT8AqTn2miev7yjqwi1mhp6+3
         LmFBZZs/qLkSr84mRIr887bAAgcQysAiCp/gp5ANZKSgY0Cvmzh16DGOZLOYOq+ZruwW
         iWWykHWKtgrCYfUnO4UdCJOhBt1IvFmY/dj+wddcX+dP95+Ps7+dsa7iMcbNrDF+6PEy
         ZmWg==
X-Forwarded-Encrypted: i=1; AJvYcCUYS4/ymR416m7kP9vzpDbejVJ0JmZdiy9jdeYLNLK3imE1XeKY4hK+R0M5bj/7CRBo+bkIsX8Isk7nfuD+ElDrEKX1lk5KQeQxO9Jd
X-Gm-Message-State: AOJu0YxFeY9NMhEeWWS6yk/7/7RPa24TaHVj9TKn9b9nC2DLzBDC3g1J
	vn7P9Sw/lUbsqOJtk7v8wy53YUZe9lTR67EuOeGPEFZnAbaG6tDhxL0KUa04xxU=
X-Google-Smtp-Source: AGHT+IHGhL7UOJoJ/kl7lKOY8POXqisT6wepMEGy8eV2MwZHoopmjBN5qT0lMDUZs6Oa7UBaxHoQAw==
X-Received: by 2002:a5d:9606:0:b0:7c7:ef39:97dc with SMTP id w6-20020a5d9606000000b007c7ef3997dcmr1397618iol.15.1709059866084;
        Tue, 27 Feb 2024 10:51:06 -0800 (PST)
Received: from [100.64.0.1] ([170.85.6.200])
        by smtp.gmail.com with ESMTPSA id x20-20020a056638249400b004747c4f663dsm1602054jat.0.2024.02.27.10.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 10:51:05 -0800 (PST)
Message-ID: <e07f9c83-1d57-45aa-98eb-982371d1d02e@sifive.com>
Date: Tue, 27 Feb 2024 12:51:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] riscv: 64-bit NOMMU fixes and enhancements
Content-Language: en-US
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
 <20240227-footage-porridge-949a43ee8ecb@wendy>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240227-footage-porridge-949a43ee8ecb@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Conor,

On 2024-02-27 6:13 AM, Conor Dooley wrote:
> On Mon, Feb 26, 2024 at 04:34:45PM -0800, Samuel Holland wrote:
>> This series aims to improve support for NOMMU, specifically by making it
>> easier to test NOMMU kernels in QEMU and on various widely-available
>> hardware (errata permitting). After all, everything supports Svbare...
>>
>> After applying this series, a NOMMU kernel based on defconfig (changing
>> only the three options below*) boots to userspace on QEMU when passed as
>> -kernel.
>>
>>   # CONFIG_RISCV_M_MODE is not set
>>   # CONFIG_MMU is not set
>>   CONFIG_NONPORTABLE=y
>>
>> *if you are using LLD, you must also disable BPF_SYSCALL and KALLSYMS,
>> because LLD bails on out-of-range references to undefined weak symbols.
> 
> That's not new to these patches though, right? IIRC that's an existing
> issue.

Yes, that's correct. I see that arch/riscv/configs/nommu_* have KALLSYMS
disabled already; this may be the reason.

Regards,
Samuel


