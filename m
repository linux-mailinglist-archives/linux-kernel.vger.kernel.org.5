Return-Path: <linux-kernel+bounces-55148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D64D084B896
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1395B2EC71
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453CD133983;
	Tue,  6 Feb 2024 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H97xngnq"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C2131E40
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231195; cv=none; b=SOeGf1oBqh+SDVoapYVXyA9KSMBlrYUry29jsR5NxY34s1i6yqDts5NIAyKLmd/otbv4zBnbUo3XnNWszes2X4TNDGxj65igJla+jHVQXodRy54XzWDALhdiJpiQH8J2h8BHShk8YrJ/+yLnd3MW+OJ1CiKYEmTLDQLcIoP2ktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231195; c=relaxed/simple;
	bh=D35/E2FHCU24dgs4Ty+rcDXPBktIfZ1jyU2574rY6J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UD5t87wm8s8b0KU09twOFb1DKEPQoniHTrmEy1D+rhldnCt6EW6iD7dod7Oc5VJ2cgAqZwSRnTaiOzYLifnQoTDcYPw54HRQfVzTquDcqIdPsxHi6XtM1PDG9qDpMXnUnIIRJThnzdNPUKyK9EoCMjBq6bT+eU749VxncYIaDmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H97xngnq; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7bff2f6080aso40315739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707231193; x=1707835993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/RZRnLtReRSjHaUzZeYCw5gGOm6jFVdruT7LPbqwewI=;
        b=H97xngnqC3zj/gw0St/5tBaYKzpvOfvyRzbSqbXV37lY/MOt6FLZyQC5Nf6VwjBBqm
         shXqnYgs1a4eU5tnzbnqP64x2wCitPe1vbgiYc/tji4yjnyPbe0lUaiamBfAqCLuGq61
         H4Brmzxe8usrIYgnWTLy2Qgj/1fnV4ampxwCyrcqG/UXzcgEwyInNfVH0fKQeREo2dM3
         gnF/PPB4XMn19BCQAj65HWumBirNs2+6X55aiQiAkGQqoqYNduRhJPQ6QTCbsyUl+l4j
         IyMSRoVl6kDX3B4leLmoQStU95VsDElsyc2blxEhPQBzt8Q+GEIM3XJDaCkWSQAgJPo5
         Bl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231193; x=1707835993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RZRnLtReRSjHaUzZeYCw5gGOm6jFVdruT7LPbqwewI=;
        b=R+vJ+O7Q75bQc7Mo31AzbdUyYM3DPnCWs4jjgm3FV2r77EP1NrOHdfof2bnDjyQ30X
         gQvVq53OHj1ZtwCkIc7eprZCUGs/IsYT4e9gPrcb0lYqeLrns7/pX57P+d8C7bF5zki5
         7jeZJQyD6u8qscxacq0OgGG1ycwG8u9zJBEUaWFaejy912oBBISIRO4nu/oP06qmVTkT
         J7HfzUMxJ7W8d9AdkgidcpJWT/Q5KtJnpSbzbkTkj8s648t4oD+Orfh5i9Z6VLMIUZaK
         Jp5OzND2id9Y8zuvLx3uZpJW4ESvPl9kxvSB6PXdU/ftAJqUAx22+ZV3D7scaGjYHbC8
         wTGg==
X-Gm-Message-State: AOJu0YwsCbmCawh2YAO44RxcmpONsgxp20mYnCYIOZSUvKw+NZVlOAaB
	OuveuClhtJWO9XFUSK5wF9MdXyNLMUxYBtijERziPLY5HNYbALta0r5WD/N3LAVR81FDJdwN9KO
	Tn6s=
X-Google-Smtp-Source: AGHT+IFkHEcNVJgsmx/JrCZ/vJcgCrBhCvfNvstVEh1lA4SXD33kt+u5VVvHbGTfsV9Sow3BPWZDeA==
X-Received: by 2002:a5d:938a:0:b0:7c3:f631:a18f with SMTP id c10-20020a5d938a000000b007c3f631a18fmr899973iol.1.1707231192965;
        Tue, 06 Feb 2024 06:53:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVG5Yo9X9qz852Tts0zLw91gtWD2fAd7d3MiZvqRPOZWstZ3sSRChpejZH81PST3lyaDhMJQMzvJJ6gvPbe/fGICAHzdE9aaK0Xvn3Rn/RmwUQe7K1BJDTEEH67x8DjsFw=
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d65-20020a0285c7000000b004713a339311sm561194jai.8.2024.02.06.06.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 06:53:12 -0800 (PST)
Message-ID: <0149019c-4562-426b-bcb1-fb8376ba0839@kernel.dk>
Date: Tue, 6 Feb 2024 07:53:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the block tree
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240206131050.0e86d882@canb.auug.org.au>
 <CAMuHMdWjAKbt_bne8Mjpg3N_7R8TcKvAoVV8T4VrwTC2apAr_g@mail.gmail.com>
 <CAMuHMdXMexzzkj=pSdGOPhGncZ3BO8PFCrtfeh2XPoWsZ9-+kw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAMuHMdXMexzzkj=pSdGOPhGncZ3BO8PFCrtfeh2XPoWsZ9-+kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/6/24 6:42 AM, Geert Uytterhoeven wrote:
> On Tue, Feb 6, 2024 at 12:12 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Tue, Feb 6, 2024 at 3:11 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>> After merging the block tree, today's linux-next build (arm
>>> multi_v7_defconfig) produced these warnings:
>>>
>>> In file included from /home/sfr/next/next/include/linux/bits.h:6,
>>>                  from /home/sfr/next/next/include/linux/bitops.h:6,
>>>                  from /home/sfr/next/next/include/linux/kernel.h:23,
>>>                  from /home/sfr/next/next/io_uring/nop.c:2:
>>> /home/sfr/next/next/include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
>>>     7 | #define BIT(nr)                 (UL(1) << (nr))
>>>       |                                        ^~
>>> /home/sfr/next/next/include/linux/io_uring_types.h:538:35: note: in expansion of macro 'BIT'
>>>   538 |         REQ_F_CAN_POLL          = BIT(REQ_F_CAN_POLL_BIT),
>>>       |                                   ^~~
>>>
>>> (and mny more similar)
>>>
>>> Introduced by commit
>>>
>>>   d964e8440442 ("io_uring: add io_file_can_poll() helper")
>>>
>>> REQ_F_CAN_POLL_BIT is 32.
>>
>> All of these BIT() have to be changed to BIT_ULL().
>> And let's hope all variables used for storing these flags have been
>> changed from unsigned long to u64...
> 
> I have sent a fix
> https://lore.kernel.org/1960190f37b94276df50d382b9f1488cd6b6e662.1707226862.git.geert+renesas@glider.be

It needs a bit more than that, just because there's one helper that
also returns flags to be set. I've sorted it out and amended the commit,
should be fine now. I'll check on 32-bit as well.

-- 
Jens Axboe



