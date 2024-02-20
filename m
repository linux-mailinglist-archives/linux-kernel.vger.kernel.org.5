Return-Path: <linux-kernel+bounces-72325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040F785B201
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AB8283EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EE1482C8;
	Tue, 20 Feb 2024 04:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZngZhAvt"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE04433D0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708404749; cv=none; b=LpxIK4JKUraapylPaexnmeM18XLA9WAyhwYoZDfuADJ3Wdlfa+K9x4UNTTlq7pZF7mQpf6wGe/diX7UH9ixdN8dlA7NaiEKmpNp3Sue9Nzk3BgGdNZTPzPji/yPzUU1v5+xKmgV4vKSS/RUiqDFHwf0TYNp0Ao/jdkVx0HvFf1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708404749; c=relaxed/simple;
	bh=Yza/gVyp6CjH0pAS498TOH+kGoqxz3vwiLg3tZ+l654=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgAkMIGdk3f9iituyEnv+P3avXZRk3lyeDGzgYTDlRD9HxYCgLS5pi98t8Tsqk+OFHliFPl+t7VeXGpSnsXLO+AzHw77eBB0JqFFsjGGWO+V239WKrVwZ4Zyf5NLqU5XWoHA3dqzi5si0aRKDeWPPNr3U48ch06RxSIgiOdAPJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZngZhAvt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e466a679bfso905834b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708404711; x=1709009511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mYygh8p6dlxobU8XBNj0jXg1IkFE8a0t479zKU+CTw=;
        b=ZngZhAvt2Sim4/0DwEE2wLM/TWAOZK2mPGEyppfXh19Qahplpm02/93E19QgaZK3mj
         fGf2d1VG/ppiPamzkoVojduD0ne9HxOd93GmBKCnRpGfCJCQFRbVzMPwtiWdciU3qJa0
         GFNxgasy/AqmU8EL72cqRogzR8LqgEZr+kJOA93bafUxdcm1ZRKnjNhc4osH9cBjlh8L
         DJl44qewDrX1cfD7EmFJu9CRK0cDlmngiCgF2fx5W8O8ita87yBEdG4KBtGpgMUTOg//
         vg3Ojj8px/aeczTNiuRzvx4u1CwxaI73Mzr10NvA/xPWSqJ3n2gE+9q2mRwArd+rv9f0
         sGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708404711; x=1709009511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mYygh8p6dlxobU8XBNj0jXg1IkFE8a0t479zKU+CTw=;
        b=lS3fEqAPz+YsuTfbQe5TVAQNyd/7hazEK0yIGQZ1r6L6OUBir24qkNYktCw38ST0n+
         VL6fmeeX65LH1v9dfNI+DICrktZM8iTdnpd8/LATLjdiyukhLVLxFJHEbwp12JXMReSN
         73MbItCrjaZNpqzlj18Uh5u61yVziuVl5cGCQRJCY0JVWf1VuPB+zqa6+p+fxRVerP94
         KAlgUymGOJ5x1Osi0m0B0NhujWv2gh6lK9BcfAqwm8dd7dyRMJMN0Gc0WkNlceACjlUb
         IPCfna7gh+3XYDZw/lVwWAwbDpBEdkgwXRA+QP9yaGfBGoxtZPEHK7ErBYtuozQkqsAk
         Q0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoyytEsKeu+8vvAVgnHW9IeEF5u8xTkNeddZj8yEktOBqNgVsjlsDVppU+ZnH9S2X62JZpSm1gUZCauI73E7FJWJapIwrxLcn05dku
X-Gm-Message-State: AOJu0YyvKbJZ8fnjjYuvkDvVXLzv4fYPLMtmdt4J7CEGLR/l8Nmdqp4i
	v9FFdVVSteo6dJ1CexYw8fsPJ1Zn0PMC9M4v9mrxVIc9MdZzr5t+EZaTzTgN2vc=
X-Google-Smtp-Source: AGHT+IGn1WTzy+QP7GoYHjjKhbmY/dTV/RzlOdfgmAWM2wYTzRqVoIZUZ6pNgpAYsdfo4cFoXCfVIA==
X-Received: by 2002:a05:6a00:1acb:b0:6e4:6a40:1b36 with SMTP id f11-20020a056a001acb00b006e46a401b36mr4723444pfv.12.1708404710901;
        Mon, 19 Feb 2024 20:51:50 -0800 (PST)
Received: from [10.254.117.3] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id h15-20020a056a00000f00b006dd843734c8sm5247248pfk.81.2024.02.19.20.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 20:51:50 -0800 (PST)
Message-ID: <4f3c6c96-3bea-4369-a2de-e3c559505bba@bytedance.com>
Date: Tue, 20 Feb 2024 12:51:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/zsmalloc: remove migrate_write_lock_nested()
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: nphamcs@gmail.com, yosryahmed@google.com, Minchan Kim
 <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 hannes@cmpxchg.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240219-b4-szmalloc-migrate-v1-0-34cd49c6545b@bytedance.com>
 <20240219-b4-szmalloc-migrate-v1-2-34cd49c6545b@bytedance.com>
 <20240220044825.GD11472@google.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20240220044825.GD11472@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/2/20 12:48, Sergey Senozhatsky wrote:
> On (24/02/19 13:33), Chengming Zhou wrote:
>>  static void migrate_write_unlock(struct zspage *zspage)
>>  {
>>  	write_unlock(&zspage->lock);
>> @@ -2003,19 +1997,17 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>>  			dst_zspage = isolate_dst_zspage(class);
>>  			if (!dst_zspage)
>>  				break;
>> -			migrate_write_lock(dst_zspage);
>>  		}
>>  
>>  		src_zspage = isolate_src_zspage(class);
>>  		if (!src_zspage)
>>  			break;
>>  
>> -		migrate_write_lock_nested(src_zspage);
>> -
>> +		migrate_write_lock(src_zspage);
>>  		migrate_zspage(pool, src_zspage, dst_zspage);
>> -		fg = putback_zspage(class, src_zspage);
>>  		migrate_write_unlock(src_zspage);
>>  
>> +		fg = putback_zspage(class, src_zspage);
> 
> Hmm. Lockless putback doesn't look right to me. We modify critical
> zspage fileds in putback_zspage().

Which I think is protected by pool->lock, right? We already held it.

> 
>>  		if (fg == ZS_INUSE_RATIO_0) {
>>  			free_zspage(pool, class, src_zspage);
>>  			pages_freed += class->pages_per_zspage;
>> @@ -2025,7 +2017,6 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>>  		if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
>>  		    || spin_is_contended(&pool->lock)) {
>>  			putback_zspage(class, dst_zspage);
>> -			migrate_write_unlock(dst_zspage);
>>  			dst_zspage = NULL;
>>  
>>  			spin_unlock(&pool->lock);
>> @@ -2034,15 +2025,12 @@ static unsigned long __zs_compact(struct zs_pool *pool,
>>  		}
>>  	}
>>  
>> -	if (src_zspage) {
>> +	if (src_zspage)
>>  		putback_zspage(class, src_zspage);
>> -		migrate_write_unlock(src_zspage);
>> -	}
>>  
>> -	if (dst_zspage) {
>> +	if (dst_zspage)
>>  		putback_zspage(class, dst_zspage);
>> -		migrate_write_unlock(dst_zspage);
>> -	}

