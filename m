Return-Path: <linux-kernel+bounces-49459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDA0846A97
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0011C254EA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B55C18049;
	Fri,  2 Feb 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QYY8JAOi"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87671802B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861908; cv=none; b=ASb/23HwDuB7lP8IIQGA/SybIWlG9YkFcb/1r4V1SqOczFAcMmw5IQShOTnPNdf8X5nAMw9P2wXoK0a4QsIlhLHvMlnkybHkyCKi5BtVhW6xziD3c9VXHcAOzP4sbqUxyNUxuHwuKRUp8mlEQfjYDeqvy2/G+oPOMHeE2Hk+OfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861908; c=relaxed/simple;
	bh=HCNr/Xfp3YGCAQPpRop1HR1VKXvpU8me7hzFM2Mi3s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/yZytjFYUAgtezMaj3rdEJURATK2Cwy4Lc0LqPtqQyA8JVRXcEOYs0Yhk1YYqVTQy1YKytU+05tZI0CjwnP2ZX9qRHXlCzkBiz7QTnX9+172un7C0pa3jn/t0dum2jmOJPbsoiyRsL0x70hSjF/w7pyfCnjXXmXdZ5ja7V0pJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QYY8JAOi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d731314e67so13504615ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706861906; x=1707466706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8JKJRVjJxcWXDIssGGKTl6XnP5kvfHnpKPkyENOkJ0=;
        b=QYY8JAOiX74OU9ifSxA+NiBoR3SJYhmVNsB3xt7phvkS1atLlGUJWuGWi32+ZTPc+/
         X12dGRmS4a0fQEt0St1Z5VhEHLUH9chWME3aZi0Q7VIzfO9tnGsv3N0AuUxSqdpJ5zJe
         wJdpRJuDsHiAsbBjvNvm4n822y+U/meakPCH421fQXY+QpICah22HbbTI5ZY8IgeP6Z6
         DuBYUnvxRXF/WL+ZaCEWl17LzXpfcs1eLQHaeBkevlSGke5GAlXzq1qH8UzMiqFk7r1Y
         gxmRlkA0V2uVfwZrWzJTwt8jXvJIOkge2PfotaJe8yGfF9IPCK3OQ86pMQsa58OGpQ3T
         4Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706861906; x=1707466706;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8JKJRVjJxcWXDIssGGKTl6XnP5kvfHnpKPkyENOkJ0=;
        b=Xm0fR+OVI02gjUKDZFD72j24L+u7KU+qafxHISnon3zmyHHWQasXA8ijJVo98cG6Gj
         +kXPTLc3qMdJqbgGREi9PavZt/mg5B4iJHujH3eL4ARXfYsbz+e39EYVn8HB0L1RL4ar
         ScYFJ5Hn0/rWF/PSlvXlRK8aFfYOPPc5o+/Piq36WV4FfIuhpHiAc9TMxTC8l+Cqs0n2
         oqVXhswfQMtTOfEn2fIJNr0cjM5GZuSrIc1WWD8u3yLIQxgwr7O6FXZI1+Cor1lp9uhl
         VDVQwLHgpzZZ8VmlxhNmI1rZURUuRbkd3fSW2M4Q18qjGxBJvZLcwnt/pn2pHZ9CwWrc
         ELUA==
X-Forwarded-Encrypted: i=0; AJvYcCXHrEj/YQA7uOq2CnaLjg5fYTfybow/Y5rkp1PwGMvmK13f+dhlBkmhYxqS2+gX0mX7uSRPE9D7DrsMSgeYyzHYw3KCYNhqp4aYJHTH
X-Gm-Message-State: AOJu0Yxjgbnq+9gMIjkphC6imObA3+qC2FvpfTPPNVbAdU4yLBevhp+9
	ShjtHNck38OLhWPqKPDuCMofMkTQ8t0WYi1UdI9d/d7PnGuWcH2l5HjPy2BO8Jw=
X-Google-Smtp-Source: AGHT+IH8Zf2upHYIxK6SuWPxN+b+CjxUBf8fzbG38h58P2nVOcfE+Sz2gaLhfCAUQ2TRER/rrcKHMQ==
X-Received: by 2002:a17:903:120d:b0:1d8:b778:e9b0 with SMTP id l13-20020a170903120d00b001d8b778e9b0mr5694553plh.0.1706861906078;
        Fri, 02 Feb 2024 00:18:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXLCNdMPzL6jMcV7benB5WfWXlOxuUGR2inJUhGn/c8yJ7SgnQ8wFcw28273QVZqecKJrF+vaJrc78jGWC3GzarJ0dqpSblZhfSufcKcaV/wxZTqdyy71BlE/AnwzE+6uS2DgxXf+VbhZ3b8vmeDJaD0XyDDeO3ekjqPJfhkmPPsRyFGrGtjHsSzlIXk/CsSKqzJA==
Received: from [10.255.208.99] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id g24-20020a1709029f9800b001d7207fa2a7sm1023739plq.152.2024.02.02.00.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 00:18:25 -0800 (PST)
Message-ID: <50ac8845-0a19-4b0f-b593-a37268d30be0@bytedance.com>
Date: Fri, 2 Feb 2024 16:18:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mm/zswap: remove duplicate_entry debug value
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-4-56ed496b6e55@bytedance.com>
 <20240201175536.GD321148@cmpxchg.org>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240201175536.GD321148@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/2 01:55, Johannes Weiner wrote:
> On Thu, Feb 01, 2024 at 03:49:04PM +0000, Chengming Zhou wrote:
>> cat /sys/kernel/debug/zswap/duplicate_entry
>> 2086447
>>
>> When testing, the duplicate_entry value is very high, but no warning
>> message in the kernel log. From the comment of duplicate_entry
>> "Duplicate store was encountered (rare)", it seems something goes wrong.
>>
>> Actually it's incremented in the beginning of zswap_store(), which found
>> its zswap entry has already on the tree. And this is a normal case,
>> since the folio could leave zswap entry on the tree after swapin,
>> later it's dirtied and swapout/zswap_store again, found its original
>> zswap entry. (Maybe we can reuse it instead of invalidating it?)
> 
> Probably not worth it, especially after the next patch.

You are right, not worth it.

> 
>> So duplicate_entry should be only incremented in the real bug case,
>> which already have "WARN_ON(1)", it looks redundant to count bug case,
>> so this patch just remove it.
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Either way, I agree that the WARN_ON() is more useful to point out a
> bug than a counter.
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!

