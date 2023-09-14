Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76597A04B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbjINNBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbjINNBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C9281FD4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694696425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GD4InApqGwPlaqPD1j+cPsIFJ/FaN83LoGbvPs5/BZM=;
        b=CS/5BYrLQrA3Lm4xseMkspyD3Q2gGRMYJ+Af3/DWqyVFz+I0RahF0g6tsRCNjYNP9w+fgz
        1HAjVzugmBgb0l6Uh3wq3kmkJg2x1Hf7qZw63KRAGTdzj/JNScf6I1q8aBiBKMRBlUT8iO
        s5IJGRq7D+yalcpUCehRw97bP34uPPg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-sl-t1mcSN8eO_rF_t1yPnA-1; Thu, 14 Sep 2023 09:00:24 -0400
X-MC-Unique: sl-t1mcSN8eO_rF_t1yPnA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4020645b2a2so7032215e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694696422; x=1695301222;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GD4InApqGwPlaqPD1j+cPsIFJ/FaN83LoGbvPs5/BZM=;
        b=dztuRqbbnnOXoawVGPiDcm6uMRPrvAK836aR+bVcI7MTw793iSrnA/NWTQW+iwsa9k
         gbO2xsXvNE+w5gO/G15WpZn7X+Cd5pqJeLViAiz3fuqNsr5jsc08tuBumom/DFQ9tZ/d
         nhWdnETHsq9HPRd+jDIP/SFnbxLbj6CevFfZdtE3mrpW59OJEQ8t8Tr6Up672JXyaozr
         W+nvPgX/kAewfXSmhF1MS9yCeeJpqenSs71Tvtpx00Ht4uEDVnKfNjukd8KHqe9+/ZQI
         6Iw1MTX6A+yyKDwqcdnkWF6aMjCnZiauxZeqNXB35R3uVd5haxGIji+cBkf+RNq1ivXg
         5q0w==
X-Gm-Message-State: AOJu0YxxqxenAXLMAzFZMOjsCx58deyQKSolEuW9KNiG9/YBbz4ECKBw
        MfAjW1JYGQFeeQxNo6nxBoBnBigMnojGIgdm6DiVgAfTMi/DiF79NseK5Ag/AQX1ZP7hz5FL+je
        Z57jO9aeGx0ZrFFtoiLCt0gWw
X-Received: by 2002:a1c:7c08:0:b0:3fd:2e89:31bd with SMTP id x8-20020a1c7c08000000b003fd2e8931bdmr4909341wmc.14.1694696421061;
        Thu, 14 Sep 2023 06:00:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyAuCfFyUyVDVL0z0/uh6CoJRANuY+BSorx+ortm8WCPKSWcX0US0Dzyy1Y66VZIZ/zKjomA==
X-Received: by 2002:a1c:7c08:0:b0:3fd:2e89:31bd with SMTP id x8-20020a1c7c08000000b003fd2e8931bdmr4909307wmc.14.1694696420636;
        Thu, 14 Sep 2023 06:00:20 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id g13-20020a7bc4cd000000b003fc02e8ea68sm4810805wmk.13.2023.09.14.06.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 06:00:20 -0700 (PDT)
Message-ID: <5d6a780e-2945-2b24-bca6-3e38565fe157@redhat.com>
Date:   Thu, 14 Sep 2023 15:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] mm: report per-page metadata information
Content-Language: en-US
To:     Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, rppt@kernel.org, rdunlap@infradead.org,
        chenlinxuan@uniontech.com, yang.yang29@zte.com.cn,
        tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@Oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
References: <20230913173000.4016218-1-souravpanda@google.com>
 <20230913173000.4016218-2-souravpanda@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230913173000.4016218-2-souravpanda@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.09.23 19:30, Sourav Panda wrote:
> Adds a new per-node PageMetadata field to
> /sys/devices/system/node/nodeN/meminfo
> and a global PageMetadata field to /proc/meminfo. This information can
> be used by users to see how much memory is being used by per-page
> metadata, which can vary depending on build configuration, machine
> architecture, and system use.
> 
> Per-page metadata is the amount of memory that Linux needs in order to
> manage memory at the page granularity. The majority of such memory is
> used by "struct page" and "page_ext" data structures.

It's probably worth mentioning, that in contrast to most other "memory 
consumption" statistics, this metadata might not be included "MemTotal"; 
when the memmap is allocated using the memblock allocator, it's not 
included, when it's dynamically allocated using the buddy (e.g., memory 
hotplug), it's included.

-- 
Cheers,

David / dhildenb

