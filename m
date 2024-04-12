Return-Path: <linux-kernel+bounces-142844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31DB8A30C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D311F25390
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE6113D618;
	Fri, 12 Apr 2024 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vwk8NzmV"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BD18615C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932418; cv=none; b=mT6z53e2qaOtYvedU1zsMEbWPHNoc1QR2eaF7tKDLUaNkjD1WvWdvCCx4vF9JzQE/RI86UihLY2x/kxi0cRfdmFoL0wKwMkI/YzzIzGHg95abyR53A8aYqFw3r6/blyWUYP/g+0Y6LphZod+RmkZFkwqiz6bcJro++xQmJvWWk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932418; c=relaxed/simple;
	bh=U2v0xXugGcKnm9y+KSvCKSzUBnL/1h15RrqGsLqlE9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkfbnZ96Z/p7ahQILCm1oZhqw2oG+FRcL3mFaknm3TuHNHqutMw8h7Uqy5lhIqYdeKzS9MARDRGX0ph06otx2clpyrMOjogoyuDsD2L0kKrjeyrZu0rngmVXtGCOmnAQTylsDCHwkxJxibLiT4omPWWqEB91K9OAjIiLrqoqqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vwk8NzmV; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso7279539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712932414; x=1713537214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BrT3sFNst7WsOgXv8+8mtDti7gnB6xBN3qOMfMoY1fI=;
        b=vwk8NzmVhBLtsP7Mp0b2VTfD+/hgD3qlDiNBIbsFw6NANgdZ7PmauiIFsek9Ia1kjo
         YzeGU+bp2UON9gUeQgCRmFHLA5XOY8X8+mXDlGDJfOAWM1ImlGkhrl1aMRrV2Ua0ABA4
         wnSrdnxM7eQiDjXQzDwbuIm/mP2SApP+PhBRiTwq6Gu93KQjhV8DHnVN+rgkfAFETTpq
         POd1elXvhDPpOhOMivrqZnDlDOcSuUZTAi059ML9sPQLb2cJOllUkDIf8NYbQRrgR7GF
         G78gNBu4ekqG4IQGTi9/bol/Mqk6MP3AW/jw8fNU6J8927NKBc0x8EIswej9eQqeUSst
         Kswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712932414; x=1713537214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrT3sFNst7WsOgXv8+8mtDti7gnB6xBN3qOMfMoY1fI=;
        b=n9K9Ey6HX//oyVe4DZOPs6wyVExPMvvgkdF0OC7k5okehPiYc9N6V1zpPNkomZ5OPy
         7iwVMjlq77dXmm7jq9KHwecvakVarc24HVD8Oj0XTbYclmsFGJwXlN/yHll4VmHwhIW7
         IkDkNRK42uPXIDqR4vSHeVuJFsNmpgNHryUX/jtCJ3aaM7aG2cOKMiAvNdONhjSsrjx0
         uPG8R1AbfwUOQV9nsaoKFcGlHVRsnc1Z4oiJ9ZVpszerqwHrJ4cc+aiFPfpqPO26itkm
         vXkfrAixbpESXogndXHEiQPxKTOFkVpUw2yyX2hL+N4bUegmOEEWeiVRGVyNXEAWrCg8
         TONw==
X-Forwarded-Encrypted: i=1; AJvYcCXbL/KUEbbMsQayugEgANzO4e1jXsFWDw95k/nK//EeIF5gAPVJQ/MU9SJCGyIlGLMcmWvwRliJZRAmSHDDGENR4MCmPtvF5eV5b08W
X-Gm-Message-State: AOJu0Yyo3ST/Ml+1nua/U/0xPq2gU3mCTkfufZc9EeNuXQULzUY7iTWB
	EnYYWti2mlrUBZcdXAaDonvCRQcm3ybLhC9yQJzaFFhD1il+yhtl4vGa4Gg2KPw=
X-Google-Smtp-Source: AGHT+IG2h8sZqNq+N+XfUeoFr1XWCRRgSLSOhk/Zf8KsfRonGD1pAapHFvoxFp+NKFVuVSDKgPRNNA==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr3147431iog.0.1712932414611;
        Fri, 12 Apr 2024 07:33:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g6-20020a056602150600b007d5ddee1d4esm1069624iow.49.2024.04.12.07.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 07:33:34 -0700 (PDT)
Message-ID: <d071fa42-df7b-459f-832d-798e6b37184f@kernel.dk>
Date: Fri, 12 Apr 2024 08:33:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/2] block: fix that blk_time_get_ns() doesn't
 update time after schedule
Content-Language: en-US
To: Yu Kuai <yukuai3@huawei.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 johannes.thumshirn@wdc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com
References: <20240411032349.3051233-1-yukuai1@huaweicloud.com>
 <20240411032349.3051233-2-yukuai1@huaweicloud.com>
 <9a4f8738-6ad5-407e-a938-83395aa1df4f@kernel.dk>
 <7baaea10-5a3d-5efa-158b-f10448232031@huawei.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7baaea10-5a3d-5efa-158b-f10448232031@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/24 7:24 PM, Yu Kuai wrote:
> Hi,
> 
> ? 2024/04/12 0:44, Jens Axboe ??:
>> On 4/10/24 9:23 PM, Yu Kuai wrote:
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index a16b5abdbbf5..e317d7bc0696 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -1195,6 +1195,7 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
>>>       if (unlikely(!rq_list_empty(plug->cached_rq)))
>>>           blk_mq_free_plug_rqs(plug);
>>>   +    plug->cur_ktime = 0;
>>>       current->flags &= ~PF_BLOCK_TS;
>>>   }
>>
>> We can just use blk_plug_invalidate_ts() here, but not really important.
>> I think this one should go into 6.9, and patch 2 should go into 6.10,
>> however.
> 
> This sounds great! Do you want me to update and send them separately?

I've applied 1/2 separately, so just resend 2/2 when -rc4 has been
tagged and I'll get that one queued for 6.10.

-- 
Jens Axboe


