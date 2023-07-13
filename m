Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B68752563
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjGMOmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjGMOml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBDC2706
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689259312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2R6dDDtWkBzm8BK7gNECoNNAz90QfecM3mxU2f2ZR0=;
        b=TeMyEt+NXgWnMPi8GcEO9nBuodVIVFKBiHIhfsejSsoBk4jTgU8w0tmCMd+wfRyjEDPoLa
        CPpza3eifNlaPf4s66NP53qu+l6CUaMYXToe5gJOg2Xod/aFMkCb+garQz6AQWii8nWsGv
        QK6NTEJduDURLm5ng3nviyAUbmytQ7w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-rvIjv6vZNxKWfq9ortUDSw-1; Thu, 13 Jul 2023 10:41:50 -0400
X-MC-Unique: rvIjv6vZNxKWfq9ortUDSw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fc0855dcc5so4186755e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689259309; x=1691851309;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2R6dDDtWkBzm8BK7gNECoNNAz90QfecM3mxU2f2ZR0=;
        b=Wl8FX56zg8CKUd5peXJMWgM0k0iQdLdYnEc9PffViKA9V7yPh6oU4eaODu4/EcPPGx
         WkX2vNAjULHvKPXqfFwfR3HGLXIoHhBOdvkSMMP4JGIQYYD54wfZuDyfB7aiQwJubBKk
         rOuZFpcm2oyR4vOILFUYslQL7CrIFFz1V0AGcZ/z1bHw8MPqmWorcwYxEA1hzdY7R+P6
         e/knAA0aOMEXbszSobRG5ObqBfaWC6Rn6VefwNC3JNZTqj9AZg8sQhBLFl3M4oXMeRBS
         4dU8qzFI5ecNJghcaCHVwvEPOqHQybHyuM4vGT7x0cXIKQGpzfGURsJJsQUPKALSoJDn
         /5ag==
X-Gm-Message-State: ABy/qLZ/5Ka92N5FL0JJ1lWPP5EjVLpfXz4NTC+rl/eVggaMLJKGSTPX
        renHIHXOLdM2BR6qsZTSKvoCkQwD166QY8EyqYsabrOTwH4TvoOID+EKiSpxBUfCBxY01UfbPPc
        tgXxSfAaYAfetRz16Nbl/3smn
X-Received: by 2002:a5d:5944:0:b0:313:fce9:c568 with SMTP id e4-20020a5d5944000000b00313fce9c568mr1555690wri.31.1689259309465;
        Thu, 13 Jul 2023 07:41:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF8Y9wJtjwsoykc35+sgxyZLim850yFkZVhcdkP6y60VpV1mMg23WlUd55g5Z0yevQoGHHrqg==
X-Received: by 2002:a5d:5944:0:b0:313:fce9:c568 with SMTP id e4-20020a5d5944000000b00313fce9c568mr1555675wri.31.1689259309129;
        Thu, 13 Jul 2023 07:41:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6100:2da7:427e:49a5:e07? (p200300cbc71761002da7427e49a50e07.dip0.t-ipconnect.de. [2003:cb:c717:6100:2da7:427e:49a5:e07])
        by smtp.gmail.com with ESMTPSA id d6-20020adfe846000000b0030fd03e3d25sm8165077wrn.75.2023.07.13.07.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 07:41:48 -0700 (PDT)
Message-ID: <afe16f17-3398-c30c-82a9-eaadae4949c1@redhat.com>
Date:   Thu, 13 Jul 2023 16:41:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 6/9] selftests/mm: va_high_addr_switch should skip
 unsupported arm64 configs
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
 <20230713135440.3651409-7-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230713135440.3651409-7-ryan.roberts@arm.com>
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
> va_high_addr_switch has a mechanism to determine if the tests should be
> run or skipped (supported_arch()). This currently returns
> unconditionally true for arm64. However, va_high_addr_switch also
> requires a large virtual address space for the tests to run, otherwise
> they spuriously fail.
> 
> Since arm64 can only support VA > 48 bits when the page size is 64K,
> let's decide whether we should skip the test suite based on the page
> size. This reduces noise when running on 4K and 16K kernels.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   tools/testing/selftests/mm/va_high_addr_switch.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/va_high_addr_switch.c b/tools/testing/selftests/mm/va_high_addr_switch.c
> index 7cfaf4a74c57..4b6f62c69a9d 100644
> --- a/tools/testing/selftests/mm/va_high_addr_switch.c
> +++ b/tools/testing/selftests/mm/va_high_addr_switch.c
> @@ -292,7 +292,8 @@ static int supported_arch(void)
>   #elif defined(__x86_64__)
>   	return 1;
>   #elif defined(__aarch64__)
> -	return 1;
> +	size_t page_size = getpagesize();
> +	return page_size == PAGE_SIZE;


return getpagesize() == PAGE_SIZE;

?


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

