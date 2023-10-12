Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696D77C7036
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347272AbjJLOWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjJLOWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:22:07 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2543BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:22:05 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-65b162328edso5395566d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1697120525; x=1697725325; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7BE2R8PIkyHRd4gL99LO+dIQVqA8MQjkYJ3iaAbvj+E=;
        b=P2LofO0wg0MZJpWNnTO8gBnfhAMOcMZwJ7QCx/X93aG2chXeovab2DfZbuR0geyR5Y
         G8AgC9aZnhOWI3ZeLwL0kt3baw7imBiDa7b3dDRSWP6MrSpn8Yvnco2tam8faOvc3PWC
         k+/2qkZ/y9zoAZd1BQ95HZqPOmBuAq2UKLZoV4PiTq7ZpxdB3apQCTmy0uYbSMdSQIyQ
         6dBGZauKXqDFqPOSoCdgScdBpmer2ez1I0Co4zZj7Jcf3BBvb/8qB3UmZzsoeHnmy/PG
         5/twEmQKlkeb41xGcTWg7+aavIs2sLe8l77fmCKGOA0evFQoGcUyy4Pj1zEvm4T0IF+3
         bP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697120525; x=1697725325;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BE2R8PIkyHRd4gL99LO+dIQVqA8MQjkYJ3iaAbvj+E=;
        b=lrIwm1yF4a8vibfxAuwhvVO9Wrti+LXj4oTfJPx0NY9PWnmoTMjJATtj2xG2ZF24UK
         f+8rZIumU2NQUej6uMn8UJIYDD/ilSzMHr0uNZv/eU1TOaXmpEnFvPPMzlfpSPCX+ETM
         7h7+ObCJP4AApCpqqXqMLRsxYbSY5bs5eHqzjrZ7ss8TF/z9w2+ZFw0EGKY/wQ7wd7rP
         lTq0Dh53rS6/UP/XQGHa0u0/uHXxBp9ODVOY9ioJbBzgBwF0jZptkagxb981YKLvBW8t
         Ohc/6iAqo5Z1t4vUQrkfcbUSwEyt6ek5IdW80rUrUnDEmNy5i6g1vE1MEiQAMirJIoMn
         GHiw==
X-Gm-Message-State: AOJu0YyCQxIHWqhDSPZOumyGZqi91/rQIl0AZ1qj+M4J/ar/aPQIRGVB
        vJsjBfaP1E5lJREDF3S3rvhlwA==
X-Google-Smtp-Source: AGHT+IF8WXQQjj03Qgtha678waoUBFdOS2UgdJY4pIJn8t2ryLggunLaBPasQU/FB2X4h9VDQYiU3A==
X-Received: by 2002:a05:6214:300e:b0:66d:12e0:2555 with SMTP id ke14-20020a056214300e00b0066d12e02555mr3239901qvb.33.1697120524914;
        Thu, 12 Oct 2023 07:22:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:66a6])
        by smtp.gmail.com with ESMTPSA id jy20-20020a0562142b5400b0065d05c8bb5dsm464815qvb.64.2023.10.12.07.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 07:22:04 -0700 (PDT)
Date:   Thu, 12 Oct 2023 10:22:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     =?utf-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [RFC PATCH] zswap: add writeback_time_threshold
 interface to shrink zswap pool
Message-ID: <20231012142203.GB470544@cmpxchg.org>
References: <20231011051117.2289518-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OBYiH+G17YLRvEhx2Ode6q_hc0NgR6ZisBD_h0URcgSw@mail.gmail.com>
 <CACSyD1N6PPJCJ6TCTGijRKGEf2bGm+3mBLfr=DwCKgy+7-PBEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1N6PPJCJ6TCTGijRKGEf2bGm+3mBLfr=DwCKgy+7-PBEw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:13:16PM +0800, 贺中坤 wrote:
> Hi Nhat, thanks for your detailed reply.
> 
> > We're currently trying to solve this exact problem. Our approach is to
> > add a shrinker that automatically shrinks the size of the zswap pool:
> >
> > https://lore.kernel.org/lkml/20230919171447.2712746-1-nphamcs@gmail.com/
> >
> > It is triggered on memory-pressure, and can perform reclaim in a
> > workload-specific manner.
> >
> > I'm currently working on v3 of this patch series, but in the meantime,
> > could you take a look and see if it will address your issues as well?
> >
> > Comments and suggestions are always welcome, of course :)
> >
> 
> Thanks, I've seen both patches. But we hope to be able to reclaim memory
> in advance, regardless of memory pressure, like memory.reclaim in memcg,
> so we can offload memory in different tiers.

Can you use memory.reclaim itself for that? With Nhat's shrinker, it
should move the whole pipeline (LRU -> zswap -> swap).

> Thanks for your review，we should update the store time when it was loaded.
> But it confused me, there are two copies of the same page in memory
> (compressed and uncompressed) after faulting in a page from zswap if
> 'zswap_exclusive_loads_enabled' was disabled. I didn't notice any difference
> when turning that option on or off because the frontswap_ops has been removed
> and there is no frontswap_map anymore. Sorry, am I missing something?

In many instances, swapins already free the swap slot through the
generic swap code (see should_try_to_free_swap()). It matters for
shared pages, or for swapcaching read-only data when swap isn't full -
it could be that isn't the case in your tests.
