Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCFA8131AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573352AbjLNNeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573319AbjLNNeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:34:01 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0863111
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:33:43 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-591553d3835so1157585eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702560823; x=1703165623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TGQSpV/olTYn464XLvf+Bx7XCT2e+qVX0TS6kVY/Gjg=;
        b=EL6mK7hAtgVsqv0CSCKyjDXmw00t1vtHqgN+6JjaV/xg2IaxFQrC6iMcJx/s3S19a4
         kLz/L8i4cFwJuzBH1FfRwlwczZyTjq9FfDeBEgdbh+X11q/DJ6p7xu+6RwwUy7DYD4h4
         GOfcTSZyYOmNtlFLEbBQZkTy4WzNhKqTVdup/s5utWSAFhMpz/QWrK5S2nGqR7HJzMtb
         y9xSCSrayGYNqhLTJDkFPQ3yYXnTP456uucMnhUceSm9j7wXA6hQWCOnKDmZRhqmRU2I
         OTrm8ZOTIBiBqggJz8b1ZE2XLRdlHY4CErJ4iuNBOs75pqnDZqtNqnN7iMca7senmFl5
         Lf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702560823; x=1703165623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGQSpV/olTYn464XLvf+Bx7XCT2e+qVX0TS6kVY/Gjg=;
        b=BiA59UuEcJO3UJ/9XjkMYFAyfGJ8xr7rQVKItiv1lUy51KeP/LgpUM5C/h8Q4odaV8
         eREE3m/uLDRaRaS6EFvmppNQteKEujv3BgrI1msu9sDooF6vlt4WJHLXpBYSQ5gBna6W
         ZKxCiEgGTo6mvSqeWobcf4ancqjgzmxucURGkeer0i9dkGFMW8wPu30Q9Rc7tjGIfLMu
         KePEVw8n89x0k+vvRzUVs21OSqwlrSkoxIxxlb9LjhUFL80cb1wh8+7DTGsaTXU7aYRB
         4wN8LbPgSsfU3XnoVtFDdemQqqm4nI0CKmPuXZSnISxjy4aXZv2AscbSqe9+7Ld79kHP
         0Yrw==
X-Gm-Message-State: AOJu0YzBcwz/yYHbxOIYK4jcV4FBf5bJbm2hsEDqb6qgMwODCVbhYn2N
        oNXLQ5Sk257hk1gbWuUfGH3L2Q==
X-Google-Smtp-Source: AGHT+IEsgLO6mOi7JT+gprO/GPP7X7B/o7SXKZV0aL/La/Rx0XOY2ck3DS7xg7ciCvCv5QR4TqyRfg==
X-Received: by 2002:a05:6359:2e03:b0:170:17eb:3785 with SMTP id ro3-20020a0563592e0300b0017017eb3785mr7794874rwb.45.1702560823021;
        Thu, 14 Dec 2023 05:33:43 -0800 (PST)
Received: from ?IPV6:2409:8a28:e64:34f0:4525:57e4:217e:6e2c? ([2409:8a28:e64:34f0:4525:57e4:217e:6e2c])
        by smtp.gmail.com with ESMTPSA id n37-20020a634d65000000b005c21c23180bsm11638794pgl.76.2023.12.14.05.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 05:33:42 -0800 (PST)
Message-ID: <cb558f85-4f9b-4eb9-b60c-9b609075920d@bytedance.com>
Date:   Thu, 14 Dec 2023 21:33:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm/zswap: change dstmem size to one page
Content-Language: en-US
To:     Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-2-896763369d04@bytedance.com>
 <CAJD7tkZJRgf+502QU_ECVPey0w-5vw_e6HSL+Ay7unetq5gL0A@mail.gmail.com>
 <CAKEwX=P4=YbvoRCa5+BB+==f4YL_5-6AaUNUCdH3v2faTx-PYQ@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKEwX=P4=YbvoRCa5+BB+==f4YL_5-6AaUNUCdH3v2faTx-PYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/14 08:18, Nhat Pham wrote:
> On Wed, Dec 13, 2023 at 3:34 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>>
>> On Tue, Dec 12, 2023 at 8:18 PM Chengming Zhou
>> <zhouchengming@bytedance.com> wrote:
>>>
>>> Change the dstmem size from 2 * PAGE_SIZE to only one page since
>>> we only need at most one page when compress, and the "dlen" is also
>>> PAGE_SIZE in acomp_request_set_params(). If the output size > PAGE_SIZE
>>> we don't wanna store the output in zswap anyway.
>>>
>>> So change it to one page, and delete the stale comment.
>>
>> I couldn't find the history of why we needed 2 * PAGE_SIZE, it would
>> be nice if someone has the context, perhaps one of the maintainers.
> 
> It'd be very nice indeed.
> 
>>
>> One potential reason is that we used to store a zswap header
>> containing the swap entry in the compressed page for writeback
>> purposes, but we don't do that anymore. Maybe we wanted to be able to
>> handle the case where an incompressible page would exceed PAGE_SIZE
>> because of that?
> 
> It could be hmm. I didn't study the old zswap architecture too much,
> but it has been 2 * PAGE_SIZE since the time zswap was first merged
> last I checked.
> I'm not 100% comfortable ACK-ing the undoing of something that looks
> so intentional, but FTR, AFAICT, this looks correct to me.

Right, there is no any history about the reason why we needed 2 pages.
But obviously only one page is needed from the current code and no any
problem found in the kernel build stress testing.

Thanks!
