Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0655B80FA6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377690AbjLLWOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjLLWOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:14:46 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E609C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:14:52 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc79f73e58so16835ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702419292; x=1703024092; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ai/6oa+3xTjAhJGHry+JbJcf+dfhAKDUCjsENuNGuQQ=;
        b=SDVhH1j5ypoRpu/ZYEY0JntccJr4ZS8uOaF2lJFEBqzOpAnn/pDYQykwTUFqR1aqe6
         9wCmlie0S1/2SdX8RY5K9k8CHsXfeINnniNC0BhYhuIV8RBHbcPqrKFGcN0dluGleFIy
         EW1ADTzcFUMnXaaBHA01mMGE0KuDHEaDpJxbYDvKemugBuVvNXNKt1U2ej9+3ozyeyxP
         YM+8DSOjBGfbaSJmkNpZ4qVIM7uCCGMh3+oO7pFq6UfVmNKeI2qNfPmbOIlOBBXubRI6
         24CGOfpqaxTRiCnox3Kbuf6Ywf4fyf+YrSA8d1y9U/ZrDJW2I/s5l2S1QotstjCD/Wg8
         o2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419292; x=1703024092;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ai/6oa+3xTjAhJGHry+JbJcf+dfhAKDUCjsENuNGuQQ=;
        b=b/eMs/JYTUjS0QcBZplLK7oha1eVTulJ8Jmrmjy2i0RR1pTTqWZi9U6oy3K9XQfrr6
         +IKGPGAo/A/a/6nJYP7ICXLXvM00X5gxZ27ts70FvsZs/AsA9aiIkthVNeeQ5d+1TYZg
         3SEf08jd/xPmCCdYil5XWXRRMrNxhdGED/SZkvIESl7YJoNU4zXGbMqMZnkbr+PA1ma2
         3ylJhQwck73DhOHkUIBgYeA2j+ui1hkQpA1DV/q0Gos8C2a4QTJ9WYI20GTKfL9hKuTS
         93KyljYVo9W98J3JywfS80CZBDbsjXHPzxShZiMtlBw8SW8EIAdsVDTQRrdHiAYZez80
         sTzQ==
X-Gm-Message-State: AOJu0Yy5kgxgBELhrfmHiMOU2bBwOlDX6/U4OZAiMHEhokREFSLiuhzF
        EvksPvMBon8ro+TbK9NSaRvMmA==
X-Google-Smtp-Source: AGHT+IGwh/A1nELtAxUKj+TAxd3RqTHBSSMVjxaO/S4KOsZf7yBKwvkT9TAlTopzChwQot1tEfqt1Q==
X-Received: by 2002:a17:902:dac2:b0:1cc:6fa6:fb4a with SMTP id q2-20020a170902dac200b001cc6fa6fb4amr962337plx.22.1702419292041;
        Tue, 12 Dec 2023 14:14:52 -0800 (PST)
Received: from [2620:0:1008:15:fc81:e0ce:797b:3b4b] ([2620:0:1008:15:fc81:e0ce:797b:3b4b])
        by smtp.gmail.com with ESMTPSA id e10-20020aa7980a000000b006cef6293132sm6394390pfl.101.2023.12.12.14.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:14:51 -0800 (PST)
Date:   Tue, 12 Dec 2023 14:14:49 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Gang Li <gang.li@linux.dev>
cc:     David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
Subject: Re: [RFC PATCH v2 0/5] hugetlb: parallelize hugetlb page init on
 boot
In-Reply-To: <20231208025240.4744-1-gang.li@linux.dev>
Message-ID: <996ba32c-78f0-1807-5e64-af5841a820e7@google.com>
References: <20231208025240.4744-1-gang.li@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023, Gang Li wrote:

> Hi all, hugetlb init parallelization has now been updated to v2.
> 
> To David Hildenbrand: padata multithread utilities has been used to reduce
> code complexity.
> 
> To David Rientjes: The patch for measuring time will be separately included
> in the reply. Please test during your free time, thanks.
> 

I'd love to, but what kernel is this based on?  :)  I can't get this to 
apply to any kernels that I have recently benchmarked with.

> # Introduction
> Hugetlb initialization during boot takes up a considerable amount of time.
> For instance, on a 2TB system, initializing 1,800 1GB huge pages takes 1-2
> seconds out of 10 seconds. Initializing 11,776 1GB pages on a 12TB Intel
> host takes 65.2 seconds [1], which is 17.4% of the total 373.78 seconds boot
> time. This is a noteworthy figure.
> 
> Inspired by [2] and [3], hugetlb initialization can also be accelerated
> through parallelization. Kernel already has infrastructure like
> padata_do_multithreaded, this patch uses it to achieve effective results
> by minimal modifications.
> 
> [1] https://lore.kernel.org/all/783f8bac-55b8-5b95-eb6a-11a583675000@google.com/
> [2] https://lore.kernel.org/all/20200527173608.2885243-1-daniel.m.jordan@oracle.com/
> [3] https://lore.kernel.org/all/20230906112605.2286994-1-usama.arif@bytedance.com/
> 
> # Test result
>         test          no patch(ms)   patched(ms)   saved   
>  ------------------- -------------- ------------- -------- 
>   256c2t(4 node) 2M           2624           956   63.57%  
>   256c2t(4 node) 1G           2679          1582   40.95%  
>   128c1t(2 node) 2M           1788           684   61.74%  
>   128c1t(2 node) 1G           3160          1618   48.80%  
> 
> # Change log
> Changes in v2:
> - Reduce complexity with `padata_do_multithreaded`
> - Support 1G hugetlb
> 
> v1:
> - https://lore.kernel.org/all/20231123133036.68540-1-gang.li@linux.dev/
> - parallelize 2M hugetlb initialization with workqueue
> 
> Gang Li (5):
>   hugetlb: code clean for hugetlb_hstate_alloc_pages
>   hugetlb: split hugetlb_hstate_alloc_pages
>   padata: dispatch works on different nodes
>   hugetlb: parallelize 2M hugetlb allocation and initialization
>   hugetlb: parallelize 1G hugetlb initialization
> 
>  include/linux/hugetlb.h |   2 +-
>  include/linux/padata.h  |   2 +
>  kernel/padata.c         |   8 +-
>  mm/hugetlb.c            | 201 +++++++++++++++++++++++++++-------------
>  mm/mm_init.c            |   1 +
>  5 files changed, 148 insertions(+), 66 deletions(-)
> 
> -- 
> 2.30.2
> 
> 
