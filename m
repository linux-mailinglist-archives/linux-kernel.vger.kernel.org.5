Return-Path: <linux-kernel+bounces-11848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC2781EC77
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67142283676
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D4D6131;
	Wed, 27 Dec 2023 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BG62qPNp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C8D5CB5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce0656a7bdso213169a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 22:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703657473; x=1704262273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hk2kRuZJzsTncYz8diW0amRVuQLlRcJy88VPv7kReGA=;
        b=BG62qPNpG+znh4rwLdgWLOpoOfGvQGuTjf7OzOx0RZUA2WKGrDFMZuSzVbXGPwJ/VO
         X3SIc/U4ADdPLy5s6Ggle4d9UPwVXG+niCfFphD4OX6U4m6xA1qLGB4agyUsp2YyNayb
         7pgCuyqpR+71IeNyvhWgO4MJ+fF5oSbDokJ7cC17APFHnMLP1qvzl/HO86+k7V9OQJZT
         95yGQ25h8nQ2x0zlB9DmH5nBiyKWYESPNwjoqN7S8hyWHaYX9dD39u4IA8/cfVLcBltx
         y2Y3i6CqxVq5wJ9OdIpEy8jhnUtJPUjZDYsohuj1DkmUC14+fgw/jnVhYiVSSph/5V1M
         5DSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703657473; x=1704262273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hk2kRuZJzsTncYz8diW0amRVuQLlRcJy88VPv7kReGA=;
        b=kSdu1/p+haoYnAavddfJg2fc94KO9RHjwGzGPUAaPKsX/ErpZY3jYUXjkd7c64AtVj
         Nq3ca2FT4cQpxUlGML7gyhKXwuYTH00EtnpWS4l4Jei5uftcFA9csfrWm0pWh2x0auRb
         zxjOJHidCO1P1LSnayED6AMaavtrtnvvx2WPHfzlsNWHFiaWcd5cMeeyI3/u3H4tBpgH
         nwOd66RmfR+cO+R7p6JNVXTiFd57xtxbVXUtcFFWYCsV8F7r7zzmKsLt+JafXv760XqX
         K/TLHTlGJKGpfgJzG3ZckyJUkVK8rRQBRupOuWubkeMruhrvd9WFolLTgd8MMaUWXQKU
         pNTA==
X-Gm-Message-State: AOJu0YwX3cVbIhRLLfar/i3DSNocJ4Adh5EGh6GtUT2bRR0BNeyANb97
	p0IvCP1BMB75vzd8mMLuRFwdmP/K+tttHQ==
X-Google-Smtp-Source: AGHT+IHZXpcj4F9r6j1E5ik6jZqZGkQ5M2E2bBGhP0Kx7ayOTSqytnoB9YneLu1KPzzmM4XwYwyf/w==
X-Received: by 2002:a05:6a21:a5a8:b0:195:e20b:f02c with SMTP id gd40-20020a056a21a5a800b00195e20bf02cmr835139pzc.98.1703657473489;
        Tue, 26 Dec 2023 22:11:13 -0800 (PST)
Received: from [10.254.10.159] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id jb2-20020a170903258200b001d0c5037ed3sm11155478plb.46.2023.12.26.22.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 22:11:13 -0800 (PST)
Message-ID: <af0a03d5-e536-41b7-9ab8-c5985794b7db@bytedance.com>
Date: Wed, 27 Dec 2023 14:11:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] mm/zswap: change dstmem size to one page
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Seth Jennings <sjenning@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Vitaly Wool <vitaly.wool@konsulko.com>, Nhat Pham <nphamcs@gmail.com>,
 Chris Li <chriscli@google.com>, Yosry Ahmed <yosryahmed@google.com>,
 Dan Streetman <ddstreet@ieee.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
 <20231213-zswap-dstmem-v4-1-f228b059dd89@bytedance.com>
 <CAGsJ_4wuTZcGurby9h4PU2DwFaiEKB4bxuycaeyz3bPw3jSX3A@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAGsJ_4wuTZcGurby9h4PU2DwFaiEKB4bxuycaeyz3bPw3jSX3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/27 09:07, Barry Song wrote:
> On Wed, Dec 27, 2023 at 4:55 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> Change the dstmem size from 2 * PAGE_SIZE to only one page since
>> we only need at most one page when compress, and the "dlen" is also
>> PAGE_SIZE in acomp_request_set_params(). If the output size > PAGE_SIZE
>> we don't wanna store the output in zswap anyway.
>>
>> So change it to one page, and delete the stale comment.
>>
>> There is no any history about the reason why we needed 2 pages, it has
>> been 2 * PAGE_SIZE since the time zswap was first merged.
> 
> i remember there was an over-compression case,  that means the compressed
> data can be bigger than the source data. the similar thing is also done in zram
> drivers/block/zram/zcomp.c

Right, there is a buffer overflow report[1] that I just +to you.

I think over-compression is all right, but buffer overflow is not acceptable,
so we should fix any buffer overflow problem IMHO. Anyway, 2 pages maybe
overflowed too, just with smaller probability, right?

Thanks.

> 
> int zcomp_compress(struct zcomp_strm *zstrm,
>                 const void *src, unsigned int *dst_len)
> {
>         /*
>          * Our dst memory (zstrm->buffer) is always `2 * PAGE_SIZE' sized
>          * because sometimes we can endup having a bigger compressed data
>          * due to various reasons: for example compression algorithms tend
>          * to add some padding to the compressed buffer. Speaking of padding,
>          * comp algorithm `842' pads the compressed length to multiple of 8
>          * and returns -ENOSP when the dst memory is not big enough, which
>          * is not something that ZRAM wants to see. We can handle the
>          * `compressed_size > PAGE_SIZE' case easily in ZRAM, but when we
>          * receive -ERRNO from the compressing backend we can't help it
>          * anymore. To make `842' happy we need to tell the exact size of
>          * the dst buffer, zram_drv will take care of the fact that
>          * compressed buffer is too big.
>          */
>         *dst_len = PAGE_SIZE * 2;
> 
>         return crypto_comp_compress(zstrm->tfm,
>                         src, PAGE_SIZE,
>                         zstrm->buffer, dst_len);
> }
> 
> 
>>
>> According to Yosry and Nhat, one potential reason is that we used to
>> store a zswap header containing the swap entry in the compressed page
>> for writeback purposes, but we don't do that anymore.
>>
>> This patch works good in kernel build testing even when the input data
>> doesn't compress at all (i.e. dlen == PAGE_SIZE), which we can see
>> from the bpftrace tool:
>>
>> bpftrace -e 'k:zpool_malloc {@[(uint32)arg1==4096]=count()}'
>> @[1]: 2
>> @[0]: 12011430
>>
>> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
>> Acked-by: Chris Li <chrisl@kernel.org> (Google)
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  mm/zswap.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 7ee54a3d8281..976f278aa507 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -707,7 +707,7 @@ static int zswap_dstmem_prepare(unsigned int cpu)
>>         struct mutex *mutex;
>>         u8 *dst;
>>
>> -       dst = kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu_to_node(cpu));
>> +       dst = kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
>>         if (!dst)
>>                 return -ENOMEM;
>>
>> @@ -1662,8 +1662,7 @@ bool zswap_store(struct folio *folio)
>>         sg_init_table(&input, 1);
>>         sg_set_page(&input, page, PAGE_SIZE, 0);
>>
>> -       /* zswap_dstmem is of size (PAGE_SIZE * 2). Reflect same in sg_list */
>> -       sg_init_one(&output, dst, PAGE_SIZE * 2);
>> +       sg_init_one(&output, dst, PAGE_SIZE);
>>         acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dlen);
>>         /*
>>          * it maybe looks a little bit silly that we send an asynchronous request,
>>
>> --
>> b4 0.10.1
>>
> 
> Thanks
> Barry

