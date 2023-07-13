Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2D475246C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjGMN5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjGMN5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3B82723
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689256617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7slRFqXzj+fIwUfWpHgJOEMlp6jejIeFSooLIetSLk=;
        b=QA8bljY/Oh9ruXY/VTWZI6qbC43MAJ10HnkFltaAc0NVA4Nc32Vc+kAis1LOoQteRH/8Ur
        0bElvL8d5fAAI7V35Y2IbDdK/1sICg//dR0Em0u+AB9i51CdMM93zsn85+ZWhSkItucbfV
        oh6G4p2kLrvXPURlehQimmttf+tTUpA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-5Ci--DTWMsGFMvmhNG9juw-1; Thu, 13 Jul 2023 09:56:55 -0400
X-MC-Unique: 5Ci--DTWMsGFMvmhNG9juw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fc0627eafbso3409155e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689256614; x=1691848614;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7slRFqXzj+fIwUfWpHgJOEMlp6jejIeFSooLIetSLk=;
        b=k/ADTqXZlrprZ4ehI/I8wjXwvnFpzZP2cGSBYZeoHesZ9zU678wj7PmNplX7w/NIY+
         kpLJsebMljRRE5vhazQ/hGJrzaS0IkwPRqrjZgPe9SKuPRjLT4tClYxBQ3D59BltSDlE
         N8qYQm7+ZVTGvzGfCEbG4lHqioYw/YuQm0CQ3FKNk1xoCbPzjf4dtDMn+2vHE9OnpQ+u
         UcssEbKt3tdTcdC8Qy/bXIkBrEtdUUHF3YGLZxQLiTYNGr3MoUv5Z9qFEg6jO5iLyWYh
         OQYE2RbX9krMcuM4tQI1YrbgiQaEfyPccvcQHfQ+rifi2ThNYwMOCLoNNE7GrUA0t9n8
         jV/g==
X-Gm-Message-State: ABy/qLauUcRrbfOMf3RXRrs3EUofKuiECy9U1sssSuL4/xi3GTmOxYOD
        RjWqKJeESr18FuMERkpLq88elQ/cVidDwQC89DNMmoZAitrG8mUZ3ulsLeJmbYtcg6C9wkCC0yG
        qJEsDgdLg71pXg71qvXLgPzbp
X-Received: by 2002:a05:600c:5187:b0:3fb:b18a:f32d with SMTP id fa7-20020a05600c518700b003fbb18af32dmr4313873wmb.17.1689256614498;
        Thu, 13 Jul 2023 06:56:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE118GN9dvVisQic4LNU75RVuVsDjt1KGEsf35PRM3rckhrWuEAXEBr4f3RPD+JkiJS5nwlWA==
X-Received: by 2002:a05:600c:5187:b0:3fb:b18a:f32d with SMTP id fa7-20020a05600c518700b003fbb18af32dmr4313854wmb.17.1689256614159;
        Thu, 13 Jul 2023 06:56:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6100:2da7:427e:49a5:e07? (p200300cbc71761002da7427e49a50e07.dip0.t-ipconnect.de. [2003:cb:c717:6100:2da7:427e:49a5:e07])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003fbc9d178a8sm18501864wmc.4.2023.07.13.06.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 06:56:53 -0700 (PDT)
Message-ID: <cf3c237e-69c8-dd6e-26fc-fe19de910813@redhat.com>
Date:   Thu, 13 Jul 2023 15:56:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 3/9] selftests/mm: Skip soft-dirty tests on arm64
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-4-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230713135440.3651409-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.23 15:54, Ryan Roberts wrote:
> arm64 does not support the soft-dirty PTE bit. However there are tests
> in `madv_populate` and `soft-dirty` which assume it is supported and
> cause spurious failures to be reported when preferred behaviour would be
> to mark the tests as skipped.
> 
> Unfortunately, the only way to determine if the soft-dirty dirty bit is
> supported is to write to a page, then see if the bit is set in
> /proc/self/pagemap. But the tests that we want to conditionally execute
> are testing precicesly this. So if we introduced this feature check, we
> could accedentally turn a real failure (on a system that claims to
> support soft-dirty) into a skip.
> 
> So instead, do the check based on architecture; for arm64, we report
> that soft-dirty is not supported. This is wrapped up into a utility
> function `system_has_softdirty()`, which is used to skip the whole
> `soft-dirty` suite, and mark the soft-dirty tests in the `madv_populate`
> suite as skipped.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   tools/testing/selftests/mm/madv_populate.c | 18 +++++++++++++-----
>   tools/testing/selftests/mm/soft-dirty.c    |  3 +++
>   tools/testing/selftests/mm/vm_util.c       | 17 +++++++++++++++++
>   tools/testing/selftests/mm/vm_util.h       |  1 +
>   4 files changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
> index 60547245e479..5a8c176d7fec 100644
> --- a/tools/testing/selftests/mm/madv_populate.c
> +++ b/tools/testing/selftests/mm/madv_populate.c
> @@ -232,6 +232,14 @@ static bool range_is_not_softdirty(char *start, ssize_t size)
>   	return ret;
>   }
> 
> +#define ksft_test_result_if_softdirty(cond, ...)	\
> +do {							\
> +	if (system_has_softdirty())			\
> +		ksft_test_result(cond, __VA_ARGS__);	\
> +	else						\
> +		ksft_test_result_skip(__VA_ARGS__);	\
> +} while (0)
> +
>   static void test_softdirty(void)
>   {
>   	char *addr;
> @@ -246,19 +254,19 @@ static void test_softdirty(void)
> 
>   	/* Clear any softdirty bits. */
>   	clear_softdirty();
> -	ksft_test_result(range_is_not_softdirty(addr, SIZE),
> +	ksft_test_result_if_softdirty(range_is_not_softdirty(addr, SIZE),
>   			 "range is not softdirty\n");
> 
>   	/* Populating READ should set softdirty. */
>   	ret = madvise(addr, SIZE, MADV_POPULATE_READ);
> -	ksft_test_result(!ret, "MADV_POPULATE_READ\n");
> -	ksft_test_result(range_is_not_softdirty(addr, SIZE),
> +	ksft_test_result_if_softdirty(!ret, "MADV_POPULATE_READ\n");
> +	ksft_test_result_if_softdirty(range_is_not_softdirty(addr, SIZE),
>   			 "range is not softdirty\n");
> 
>   	/* Populating WRITE should set softdirty. */
>   	ret = madvise(addr, SIZE, MADV_POPULATE_WRITE);
> -	ksft_test_result(!ret, "MADV_POPULATE_WRITE\n");
> -	ksft_test_result(range_is_softdirty(addr, SIZE),
> +	ksft_test_result_if_softdirty(!ret, "MADV_POPULATE_WRITE\n");
> +	ksft_test_result_if_softdirty(range_is_softdirty(addr, SIZE),
>   			 "range is softdirty\n");

We probably want to skip the whole test_*softdirty* test instead of 
adding this (IMHO suboptimal) ksft_test_result_if_softdirty.

-- 
Cheers,

David / dhildenb

