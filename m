Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F154B752536
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjGMOdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjGMOdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AA91734
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689258783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P7pipf1xjklds1hqijWcFcvA7z6pIZtEssODVbK51OY=;
        b=KHQzYpX2EerG99d2yanbTrh/H1xOKr8qsI6DxGqYry9vM82dCyYAT+gS+QR/Wr0lhYa1I9
        gF7oe5cOH6UNDC2fCwluIg4xfzrUKtDIBw0jqT+RqmlkkC6pwDyRPUXXR6XaW0FLK0EoMb
        byDu1VlfucV96m2uZYa9hQaiMoIs0rI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-_aVcopRaNbepgViomx_O4A-1; Thu, 13 Jul 2023 10:33:01 -0400
X-MC-Unique: _aVcopRaNbepgViomx_O4A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30e3ee8a42eso554666f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689258780; x=1691850780;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7pipf1xjklds1hqijWcFcvA7z6pIZtEssODVbK51OY=;
        b=gJgTRolpJ0ykN2UOvVg4cB6q3eUhJnFZ+CeXTQrFVuozfRxXTWHetprD1TZQSkSfc3
         6AxYPJuMZnJInlk+Y7uTRk4JXQDVJWLijjYczFoQ/XNVfHJsU/D1+90oPeruNcWvJSBL
         6pXK6OKotLPmqxd4j0Kx2qoDqRphEntfkXG3+nd6802xemOuxcukXfYCKHuyPuTzJQoG
         /PKsa71fJWxqhWg74dcPIz8HKpynUIuuDZiz2TdDLqNhvXKjdXkibaUj+febouwQ789w
         HuGUtNSwrHaGRSKVWmokCSqaQQ33KSGJEDeCkmNCoY2W1/1owvZN0iwB3MK4/BsWhbzy
         Dd7Q==
X-Gm-Message-State: ABy/qLaCY4DICus7vDXKVmyBVlmxv7O+ojWoOBdsbehbcd/IIFZ3PuUF
        NfTAAAUAJz8YHBpxIo6zkC5pjD+Uuj+SnBuEJuqehbDkoIy6EyZ77fPL9KyCEFNSl6/jAw7kdj6
        hMfcpzb53G8IDBR3MhdLely4E
X-Received: by 2002:adf:e310:0:b0:314:49d2:aaab with SMTP id b16-20020adfe310000000b0031449d2aaabmr1577351wrj.8.1689258780173;
        Thu, 13 Jul 2023 07:33:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwSeBPrVR+g94l9GoMddAsNtnw4BZIvQ2tOWjmM+Svv65TtZ3rMtRBHmdJBqmHsorXANwgCg==
X-Received: by 2002:adf:e310:0:b0:314:49d2:aaab with SMTP id b16-20020adfe310000000b0031449d2aaabmr1577339wrj.8.1689258779827;
        Thu, 13 Jul 2023 07:32:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6100:2da7:427e:49a5:e07? (p200300cbc71761002da7427e49a50e07.dip0.t-ipconnect.de. [2003:cb:c717:6100:2da7:427e:49a5:e07])
        by smtp.gmail.com with ESMTPSA id t12-20020a5d6a4c000000b00314329f7d8asm8121499wrw.29.2023.07.13.07.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 07:32:59 -0700 (PDT)
Message-ID: <94af96c5-0e3f-9b01-84ea-e17a748b29e7@redhat.com>
Date:   Thu, 13 Jul 2023 16:32:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 4/9] selftests/mm: Enable mrelease_test for arm64
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
 <20230713135440.3651409-5-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230713135440.3651409-5-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.23 15:54, Ryan Roberts wrote:
> mrelease_test defaults to defining __NR_pidfd_open and
> __NR_process_mrelease syscall numbers to -1, if they are not defined
> anywhere else, and the suite would then be marked as skipped as a
> result.
> 
> arm64 (at least the stock debian toolchain that I'm using) requires
> including <sys/syscall.h> to pull in the defines for these syscalls. So
> let's add this header. With this in place, the test is passing on arm64.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   tools/testing/selftests/mm/mrelease_test.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/mm/mrelease_test.c b/tools/testing/selftests/mm/mrelease_test.c
> index dca21042b679..d822004a374e 100644
> --- a/tools/testing/selftests/mm/mrelease_test.c
> +++ b/tools/testing/selftests/mm/mrelease_test.c
> @@ -7,6 +7,7 @@
>   #include <stdbool.h>
>   #include <stdio.h>
>   #include <stdlib.h>
> +#include <sys/syscall.h>
>   #include <sys/wait.h>
>   #include <unistd.h>
>   #include <asm-generic/unistd.h>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

