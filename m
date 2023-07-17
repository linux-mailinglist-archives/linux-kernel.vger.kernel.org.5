Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834AF756A17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGQRXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjGQRXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B209B5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689614537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uS2WS/BDTnCQtRW2bGAzVXx+rq+QgojxjwNbtUWSj4U=;
        b=LLSpegoFlzcy1PDeKqYpDlX9c9+mZHzkBfqeMspUpOiEC/7KUhkUa9yTsRSMpeG2jBMWOl
        6uQ0QY9DBmvYBKvMZXpmlyA2Rqe7rlCzQllaZen93Wk744RFAzXOf7DG8EcIvNfVdd+j6z
        cDtgLtlBVuZjwke+DoRvvj/F4VG1nw0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-Hty_A5SdOomtvwBip3pbOw-1; Mon, 17 Jul 2023 13:22:16 -0400
X-MC-Unique: Hty_A5SdOomtvwBip3pbOw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3143b999f6eso2746905f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689614535; x=1692206535;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uS2WS/BDTnCQtRW2bGAzVXx+rq+QgojxjwNbtUWSj4U=;
        b=i5NdwVPdZrC9bK0u9eBTPzJAvJwQqOrpbCi3hpEwQnC4W5cmIrMfKmIwX4gUKTwY0f
         TztQOKTyUFDno/XzIDK7tLEp1+j5nY7BAR3X0dL73drFLt0Xr2gYWyxPW0VliDFN2hWV
         IzMSi3aozCC4BNG3bUxxzN9o/pZLaglHuzy0VeDVrUv119JnicQjPQc6o2udnflPdUtJ
         myUe3sAp7r9Lzqa7aLkRYK6qieSKBfiapGHy8WBBNP1kWeeKbDtQoRFh+O9Fp7VT0YKo
         Kfb+BQtKKD5GmzFePYoRiMq7sTe+t+qDWxlBRUVcIVLD3cC6Kf/3faJGpRdSzAVogd/o
         1b0g==
X-Gm-Message-State: ABy/qLZSvpBbMbycckEIYiPAJ4E9KB+HHNBx4V1RvoMVN0Or9lLSY4PZ
        CIO5Qwzxr1V0fZMY9SH5Axl0JqO2nWO0qEFvYZeubvjoZoecDRGvP+fjfbwMLI5Cv9DbA6NIbN9
        sHwEtdioit4ggS1cbfLRe8oHV
X-Received: by 2002:a5d:4b06:0:b0:313:e5f2:7cbf with SMTP id v6-20020a5d4b06000000b00313e5f27cbfmr10455322wrq.58.1689614535149;
        Mon, 17 Jul 2023 10:22:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG5w0pwpqpuswQO0mr5p24K4kS+T7JyG79MOUp+x29Ro/O73yqXbI5EoQaDa7+hAzceVJDQfw==
X-Received: by 2002:a5d:4b06:0:b0:313:e5f2:7cbf with SMTP id v6-20020a5d4b06000000b00313e5f27cbfmr10455308wrq.58.1689614534778;
        Mon, 17 Jul 2023 10:22:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d5188000000b00314172ba213sm19579156wrv.108.2023.07.17.10.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 10:22:14 -0700 (PDT)
Message-ID: <e9207c67-40d9-23c9-3c90-677e0a605566@redhat.com>
Date:   Mon, 17 Jul 2023 19:22:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/8] selftests/mm: Fix thuge-gen test bugs
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230717103152.202078-1-ryan.roberts@arm.com>
 <20230717103152.202078-5-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230717103152.202078-5-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.23 12:31, Ryan Roberts wrote:
> thuge-gen was previously only munmapping part of the mmapped buffer,
> which caused us to run out of 1G huge pages for a later part of the
> test. Fix this by munmapping the whole buffer. Based on the code, it
> looks like a typo rather than an intention to keep some of the buffer
> mapped.
> 
> thuge-gen was also calling mmap with SHM_HUGETLB flag (bit 11 set),
> which is actually MAP_DENYWRITE in mmap context. The man page says this
> flag is ignored in modern kernels. I'm pretty sure from the context that
> the author intended to pass the MAP_HUGETLB flag so I've fixed that up
> too.

Makes sense to me.

> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   tools/testing/selftests/mm/thuge-gen.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> index 380ab5f0a534..16ed4dfa7359 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -139,7 +139,7 @@ void test_mmap(unsigned long size, unsigned flags)
>   		before, after, before - after, size);
>   	assert(size == getpagesize() || (before - after) == NUM_PAGES);
>   	show(size);
> -	err = munmap(map, size);
> +	err = munmap(map, size * NUM_PAGES);
>   	assert(!err);
>   }
>   
> @@ -222,7 +222,7 @@ int main(void)
>   		test_mmap(ps, MAP_HUGETLB | arg);
>   	}
>   	printf("Testing default huge mmap\n");
> -	test_mmap(default_hps, SHM_HUGETLB);
> +	test_mmap(default_hps, MAP_HUGETLB);
>   
>   	puts("Testing non-huge shmget");
>   	test_shmget(getpagesize(), 0);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

