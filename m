Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015AE775455
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjHIHl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHIHlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EE41736
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691566835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/LEhUIxJl/IFM00b8bM6YoXNVYz7YZZV5m6MYPcbPp8=;
        b=PlhCqFwOVuw5Qj5f8dSkWlU+3ACNxTpIz8+F6MMC/GxFVCZch+l8BdPSHjDUgyOUarJQVi
        yJ7bSfQ6dblycjqrv5HKwwee1zPZkE4JfSw2mC9DCOJS3BLVQryoZ2FnwLl4US2HeH8H/S
        kG8ZpEUd9Z7+W50vCIWmIPEvFcsIA6k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-zpfQrWH1PYy4hKOeeCWBVg-1; Wed, 09 Aug 2023 03:40:33 -0400
X-MC-Unique: zpfQrWH1PYy4hKOeeCWBVg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fe275023d4so6367002e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 00:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691566832; x=1692171632;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LEhUIxJl/IFM00b8bM6YoXNVYz7YZZV5m6MYPcbPp8=;
        b=BDSNifVwoB6m+KevPNG4Doa/UE+G9w4vxXmET9l0BqoeHM2pfkNzpnpJxzmPHfSpMn
         /Em7Daor2C63rq87NrZZ1ZipdhKNxePFf7tzMbU2eVxWNbIjSGxCTVOMQDi5HDWr3l5n
         kQmR7CYBet/Rsm6I8FLPgQSOrIyPxMNTLp1ViEHjw4Tj0hGHyyxYCLK+qA/KZ3DiZd39
         3/cdIQTox0ilN1bEPje/q6ET8DA/L6KEDt+Q4MOL7Ih+tTISIEdAZ5Q4evALsqXgCpn3
         Mm7aUUkMpPPmD3ps/mATlX8PrC3WwBZw/nJQfdWgdC959fyIgNnds2oJ9RBeGmRnhuGf
         3Onw==
X-Gm-Message-State: AOJu0YzY4f0y1DMO8RLtCQyXo//mkJKyxDJYZi6QFYAjQnQR8KCF96wf
        DcWeUajDsHhP5006UjUj1motSIVNFYSJvOAxpV9ew0gRwW9U/HzQv5SFMTfo3IOthK9ZaKmRtai
        8xCxo5UqQX4bPAEQ12tLXz6Vf
X-Received: by 2002:a05:6512:308b:b0:4fe:4e2c:8e52 with SMTP id z11-20020a056512308b00b004fe4e2c8e52mr1489199lfd.42.1691566832097;
        Wed, 09 Aug 2023 00:40:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqwaJvbsNipfh7mF2DC+yBtFdSuN+yQ+efavTgP0AkGl1wSMeLrq022vVlQQitzwa1YkE6Bw==
X-Received: by 2002:a05:6512:308b:b0:4fe:4e2c:8e52 with SMTP id z11-20020a056512308b00b004fe4e2c8e52mr1489185lfd.42.1691566831740;
        Wed, 09 Aug 2023 00:40:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:6800:9933:28db:f83a:ef5? (p200300cbc70e6800993328dbf83a0ef5.dip0.t-ipconnect.de. [2003:cb:c70e:6800:9933:28db:f83a:ef5])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c11cd00b003fe1a96845bsm1093295wmi.2.2023.08.09.00.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 00:40:31 -0700 (PDT)
Message-ID: <9be602c1-d627-6302-be1c-66c8068c7ecf@redhat.com>
Date:   Wed, 9 Aug 2023 09:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests/mm: FOLL_LONGTERM need to be updated to 0x100
Content-Language: en-US
To:     Ayush Jain <ayush.jain3@amd.com>, jglisse@redhat.com,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bharata@amd.com,
        kalpana.shetty@amd.com, santosh.shukla@amd.com,
        Raghavendra K T <raghavendra.kt@amd.com>
References: <20230808124347.79163-1-ayush.jain3@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230808124347.79163-1-ayush.jain3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.08.23 14:43, Ayush Jain wrote:
> After commit 2c2241081f7d ("mm/gup: move private gup FOLL_ flags to internal.h")
> FOLL_LONGTERM flag value got updated from 0x10000 to 0x100 at
> include/linux/mm_types.h.
> As hmm.hmm_device_private.hmm_gup_test uses FOLL_LONGTERM
> Updating same here as well.
> 
> Before this change test goes in an infinite assert loop in
> hmm.hmm_device_private.hmm_gup_test
> ==========================================================
>   RUN           hmm.hmm_device_private.hmm_gup_test ...
> hmm-tests.c:1962:hmm_gup_test:Expected HMM_DMIRROR_PROT_WRITE..
> ..(2) == m[2] (34)
> hmm-tests.c:157:hmm_gup_test:Expected ret (-1) == 0 (0)
> hmm-tests.c:157:hmm_gup_test:Expected ret (-1) == 0 (0)
> ...
> ==========================================================
> 
>   Call Trace:
>   <TASK>
>   ? sched_clock+0xd/0x20
>   ? __lock_acquire.constprop.0+0x120/0x6c0
>   ? ktime_get+0x2c/0xd0
>   ? sched_clock+0xd/0x20
>   ? local_clock+0x12/0xd0
>   ? lock_release+0x26e/0x3b0
>   pin_user_pages_fast+0x4c/0x70
>   gup_test_ioctl+0x4ff/0xbb0
>   ? gup_test_ioctl+0x68c/0xbb0
>   __x64_sys_ioctl+0x99/0xd0
>   do_syscall_64+0x60/0x90
>   ? syscall_exit_to_user_mode+0x2a/0x50
>   ? do_syscall_64+0x6d/0x90
>   ? syscall_exit_to_user_mode+0x2a/0x50
>   ? do_syscall_64+0x6d/0x90
>   ? irqentry_exit_to_user_mode+0xd/0x20
>   ? irqentry_exit+0x3f/0x50
>   ? exc_page_fault+0x96/0x200
>   entry_SYSCALL_64_after_hwframe+0x72/0xdc
>   RIP: 0033:0x7f6aaa31aaff
> 
> After this change test is able to pass successfully.
> 
> Signed-off-by: Ayush Jain <ayush.jain3@amd.com>
> Reviewed-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
>   tools/testing/selftests/mm/hmm-tests.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
> index 4adaad1b822f..20294553a5dd 100644
> --- a/tools/testing/selftests/mm/hmm-tests.c
> +++ b/tools/testing/selftests/mm/hmm-tests.c
> @@ -57,9 +57,14 @@ enum {
>   
>   #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
>   /* Just the flags we need, copied from mm.h: */
> +
> +#ifndef FOLL_WRITE
>   #define FOLL_WRITE	0x01	/* check pte is writable */
> -#define FOLL_LONGTERM   0x10000 /* mapping lifetime is indefinite */
> +#endif
>   
> +#ifndef FOLL_LONGTERM
> +#define FOLL_LONGTERM   0x100 /* mapping lifetime is indefinite */
> +#endif
>   FIXTURE(hmm)
>   {
>   	int		fd;

Kind of suboptimal that we are passing in FOLL_ flags. mm/gup_test.c 
should just have provided an abstraction for that.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

