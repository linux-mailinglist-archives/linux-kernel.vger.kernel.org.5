Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080D37B50D7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbjJBLFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbjJBLFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D8791
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696244696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8cBxtAVddjS+hNyM9mTVrYZGqycnRIJPpuXvgIE3Yhk=;
        b=NdF5F+HMp9U5J3t6S/X2qmqPjZMXOWs6iOq3aKIYtgAV/T8p/9Mog79DonS0GMV8jckKTm
        qtIZEmq5K7Ud49eNt2IlKLPxrmvpiuWcQX+vm4PhL2aPDaJqZQDX6rkVw5mYHFOK8GZDZh
        9P4ztC+k54C3+Lq/CM9TUrVAKfPXWJo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-FyyXTfB_MfiMhxAEfwivvA-1; Mon, 02 Oct 2023 07:04:54 -0400
X-MC-Unique: FyyXTfB_MfiMhxAEfwivvA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-313c930ee0eso12146269f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 04:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696244693; x=1696849493;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8cBxtAVddjS+hNyM9mTVrYZGqycnRIJPpuXvgIE3Yhk=;
        b=GgJPqRJ7BC8pdsdROCi52wkB0vOSzXg+iqFT5XmHDWWiop3VqAy4hYqNcQ2/5LYDT8
         KgjzB1rXePctabvqZTPp2SiDmodY6lTqH2o/gkumCUnnW1IZTpEyNGCyY3piSyejwii4
         vhTrOGp1wEdV3NfD2OZW9bZv/wVTwFT+0Qaci9WRBDgaCV8IMdz5s5PpzhDghGK/ZBdi
         cc0XYhk7VauzjAFs2fEm3swRImU5n1YkXNQXvFdABokqVCjpl0dU3uyGPvPcXH6X9ErY
         b5X+xuFda2i/muVBVJ5o9dj8WhYWGJ/2LIMYZRROcIbAz2UzHhdK8kvcNu/AHGDnTm52
         8nQA==
X-Gm-Message-State: AOJu0Yxu7KbByN8KQeXIo4F56gzWUrK71IRAbyB2BSJpDr5Eaj9xDRr1
        BiVCiNZbye5tenks95J9RkMAaXY/JZMUSDOubny8GVnVsYmGisX+fG8REn9HM1Zt8RMdxzoAfLs
        Z3kxl/r7gXGrLxCaDflVC6yxx
X-Received: by 2002:a5d:4049:0:b0:319:7787:54a9 with SMTP id w9-20020a5d4049000000b00319778754a9mr10218040wrp.24.1696244693424;
        Mon, 02 Oct 2023 04:04:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5hZLzyg8yCazilpJAIZFObjvd1Ux7I4CrOg2rbKF6uIxEnS0fx/sB30Bchauf4irEEyCkVg==
X-Received: by 2002:a5d:4049:0:b0:319:7787:54a9 with SMTP id w9-20020a5d4049000000b00319778754a9mr10218011wrp.24.1696244692967;
        Mon, 02 Oct 2023 04:04:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id n24-20020a1c7218000000b003fefb94ccc9sm6966596wmc.11.2023.10.02.04.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 04:04:52 -0700 (PDT)
Message-ID: <6161e8a8-64a4-c4ea-626d-daac45ccd836@redhat.com>
Date:   Mon, 2 Oct 2023 13:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] mm/gup: make failure to pin an error if FOLL_NOWAIT
 not specified
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <cover.1696174961.git.lstoakes@gmail.com>
 <c7bfaf30cb682b92766e35ec85d93a84798b37f4.1696174961.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c7bfaf30cb682b92766e35ec85d93a84798b37f4.1696174961.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.23 18:00, Lorenzo Stoakes wrote:
> There really should be no circumstances under which a non-FOLL_NOWAIT GUP
> operation fails to return any pages, so make this an error.
> 
> To catch the trivial case, simply exit early if nr_pages == 0.
> 
> This brings __get_user_pages_locked() in line with the behaviour of its
> nommu variant.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>   mm/gup.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index b21b33d1787e..fb2218d74ca5 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1471,6 +1471,9 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>   	long ret, pages_done;
>   	bool must_unlock = false;
>   
> +	if (!nr_pages)
> +		return 0;
> +

Probably unlikely() is reasonable. I even wonder if WARN_ON_ONCE() would 
be appropriate, but likely there are weird callers that end up calling 
this with nr_pages==0 ... probably they should be identified and 
changed. Future work.

>   	/*
>   	 * The internal caller expects GUP to manage the lock internally and the
>   	 * lock must be released when this returns.
> @@ -1595,6 +1598,14 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
>   		mmap_read_unlock(mm);
>   		*locked = 0;
>   	}
> +
> +	/*
> +	 * Failing to pin anything implies something has gone wrong except when
> +	 * FOLL_NOWAIT is specified, so explicitly make this an error.
> +	 */
> +	if (pages_done == 0 && !(flags & FOLL_NOWAIT))
> +		return -EFAULT;
> +

But who would be affected by that and why do we care about adding this 
check?

This smells like a "if (WARN_ON_ONCE())", correct?

-- 
Cheers,

David / dhildenb

