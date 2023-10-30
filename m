Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9307DB4B1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjJ3IBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjJ3IBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC52BD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698652866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=h9RWUS1F6kr4OiaR+WSA0tOpjHyodlexhso6k4CIFR0=;
        b=fl1n/5IMwu2e3rxjlqwlUTs+DyWrd7sPz9ZkSivq2di1J4tgKyVFz3oha2MqfmfQTR572L
        y8HtyAkR9NUCwwE7C3nRXioPeVuC7MQ4ipFM1j5Zm2BO5EJlSE35y5iKopRtz7GtMObQOD
        wLIxz9xUI4TTT9dklvxY8dicPDEd/Ow=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-YW3RG2G9PO2gjH9aUDYhqA-1; Mon, 30 Oct 2023 04:01:00 -0400
X-MC-Unique: YW3RG2G9PO2gjH9aUDYhqA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2c4fe286a5dso41711681fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698652858; x=1699257658;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9RWUS1F6kr4OiaR+WSA0tOpjHyodlexhso6k4CIFR0=;
        b=oTjKUk/oZVa06sYJmOQg5EVBf+at6hYf1n/Wi8kWsmzg7g4hfhZHpuyxEl16+eNrBx
         ABz5k+oonU5Ps4rsZWRbqIhujbB93eKJWd9G1K9LnWV5cGstZ1vHJsj/yHvnpJCMghFe
         qqSsgZQTmw1gwbem3vjo8YYtCaJL/G9eHf0JNzd2Eg7QoZflXlnDHIMtstBERTkq6qNs
         UTzy/hDRnxBzxmsbeepwfsuF5Rnzb/KAyDUt528SSDyy2nViTiZ1YMjCiPMMFZl17I04
         nqtA7tYVkxZY+gThOVvfU2i/H/6ajuqu7vojgScKPZMz4GhVMv+zNqq7jDrSTxSEQJQP
         EZww==
X-Gm-Message-State: AOJu0YzhtssOaErlW3+L9lrs6V8IQL4zouxCCJ7dAraPBPkR74MNo+7n
        riJIbOwVYyPfAagHun6G8ID6n/wbOu0LL5D+FtKjGC+/We+fk5xphp/1YrPYHKRHUAw1ebbnlpQ
        YV1fLDjZujW1SUhjVz6UJi/ux
X-Received: by 2002:a2e:b0e5:0:b0:2c5:2813:5538 with SMTP id h5-20020a2eb0e5000000b002c528135538mr7184206ljl.21.1698652858591;
        Mon, 30 Oct 2023 01:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExs1BL8ct+ce0/tI04RetXN5MBe36TMMnwdk2wwQHYjsjyxZFYa3xhH18djXHV6HoC3s7Uxg==
X-Received: by 2002:a2e:b0e5:0:b0:2c5:2813:5538 with SMTP id h5-20020a2eb0e5000000b002c528135538mr7184185ljl.21.1698652858145;
        Mon, 30 Oct 2023 01:00:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:f800:7df6:a2c9:652e:c799? (p200300cbc73cf8007df6a2c9652ec799.dip0.t-ipconnect.de. [2003:cb:c73c:f800:7df6:a2c9:652e:c799])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b00401e32b25adsm8558453wms.4.2023.10.30.01.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 01:00:57 -0700 (PDT)
Message-ID: <a8337371-50ed-4618-b48e-78b96d18810f@redhat.com>
Date:   Mon, 30 Oct 2023 09:00:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 2/3] mm: Defer TLB flush by keeping both src and dst folios
 at migration
To:     Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     kernel_team@skhynix.com, akpm@linux-foundation.org,
        ying.huang@intel.com, namit@vmware.com, xhao@linux.alibaba.com,
        mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
        peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-3-byungchul@sk.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231030072540.38631-3-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.23 08:25, Byungchul Park wrote:
> Implementation of CONFIG_MIGRC that stands for 'Migration Read Copy'.
> We always face the migration overhead at either promotion or demotion,
> while working with tiered memory e.g. CXL memory and found out TLB
> shootdown is a quite big one that is needed to get rid of if possible.
> 
> Fortunately, TLB flush can be defered or even skipped if both source and
> destination of folios during migration are kept until all TLB flushes
> required will have been done, of course, only if the target PTE entries
> have read only permission, more precisely speaking, don't have write
> permission. Otherwise, no doubt the folio might get messed up.
> 
> To achieve that:
> 
>     1. For the folios that map only to non-writable TLB entries, prevent
>        TLB flush at migration by keeping both source and destination
>        folios, which will be handled later at a better time.
> 
>     2. When any non-writable TLB entry changes to writable e.g. through
>        fault handler, give up CONFIG_MIGRC mechanism so as to perform
>        TLB flush required right away.
> 
>     3. Temporarily stop migrc from working when the system is in very
>        high memory pressure e.g. direct reclaim needed.
> 
> The measurement result:
> 
>     Architecture - x86_64
>     QEMU - kvm enabled, host cpu
>     Numa - 2 nodes (16 CPUs 1GB, no CPUs 8GB)
>     Linux Kernel - v6.6-rc5, numa balancing tiering on, demotion enabled
>     Benchmark - XSBench -p 50000000 (-p option makes the runtime longer)
> 
>     run 'perf stat' using events:
>        1) itlb.itlb_flush
>        2) tlb_flush.dtlb_thread
>        3) tlb_flush.stlb_any
>        4) dTLB-load-misses
>        5) dTLB-store-misses
>        6) iTLB-load-misses
> 
>     run 'cat /proc/vmstat' and pick:
>        1) numa_pages_migrated
>        2) pgmigrate_success
>        3) nr_tlb_remote_flush
>        4) nr_tlb_remote_flush_received
>        5) nr_tlb_local_flush_all
>        6) nr_tlb_local_flush_one
> 
>     BEFORE - mainline v6.6-rc5
>     ------------------------------------------
>     $ perf stat -a \
> 	   -e itlb.itlb_flush \
> 	   -e tlb_flush.dtlb_thread \
> 	   -e tlb_flush.stlb_any \
> 	   -e dTLB-load-misses \
> 	   -e dTLB-store-misses \
> 	   -e iTLB-load-misses \
> 	   ./XSBench -p 50000000
> 
>     Performance counter stats for 'system wide':
> 
>        20953405     itlb.itlb_flush
>        114886593    tlb_flush.dtlb_thread
>        88267015     tlb_flush.stlb_any
>        115304095543 dTLB-load-misses
>        163904743    dTLB-store-misses
>        608486259	   iTLB-load-misses
> 
>     556.787113849 seconds time elapsed
> 
>     $ cat /proc/vmstat
> 
>     ...
>     numa_pages_migrated 3378748
>     pgmigrate_success 7720310
>     nr_tlb_remote_flush 751464
>     nr_tlb_remote_flush_received 10742115
>     nr_tlb_local_flush_all 21899
>     nr_tlb_local_flush_one 740157
>     ...
> 
>     AFTER - mainline v6.6-rc5 + CONFIG_MIGRC
>     ------------------------------------------
>     $ perf stat -a \
> 	   -e itlb.itlb_flush \
> 	   -e tlb_flush.dtlb_thread \
> 	   -e tlb_flush.stlb_any \
> 	   -e dTLB-load-misses \
> 	   -e dTLB-store-misses \
> 	   -e iTLB-load-misses \
> 	   ./XSBench -p 50000000
> 
>     Performance counter stats for 'system wide':
> 
>        4353555      itlb.itlb_flush
>        72482780     tlb_flush.dtlb_thread
>        68226458     tlb_flush.stlb_any
>        114331610808 dTLB-load-misses
>        116084771    dTLB-store-misses
>        377180518    iTLB-load-misses
> 
>     552.667718220 seconds time elapsed
> 
>     $ cat /proc/vmstat
> 

So, an improvement of 0.74% ? How stable are the results? Serious 
question: worth the churn?

Or did I get the numbers wrong?

>   #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 5c02720c53a5..1ca2ac91aa14 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -135,6 +135,9 @@ enum pageflags {
>   #ifdef CONFIG_ARCH_USES_PG_ARCH_X
>   	PG_arch_2,
>   	PG_arch_3,
> +#endif
> +#ifdef CONFIG_MIGRC
> +	PG_migrc,		/* Page has its copy under migrc's control */
>   #endif
>   	__NR_PAGEFLAGS,
>   
> @@ -589,6 +592,10 @@ TESTCLEARFLAG(Young, young, PF_ANY)
>   PAGEFLAG(Idle, idle, PF_ANY)
>   #endif
>   
> +#ifdef CONFIG_MIGRC
> +PAGEFLAG(Migrc, migrc, PF_ANY)
> +#endif

I assume you know this: new pageflags are frowned upon.

-- 
Cheers,

David / dhildenb

