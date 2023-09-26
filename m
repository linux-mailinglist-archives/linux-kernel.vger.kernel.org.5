Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED637AF74E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 02:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjI0ATI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 20:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjI0ARG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 20:17:06 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605A393D2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:26:42 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-65b162328edso21864686d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 14:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695763601; x=1696368401; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=muLZH0eItTClOvNm2BECD1Xlt1dVjs1Gh1+6BZ2wAV4=;
        b=mA2/gmOJiIxRamt7mY5xH0Uli/qXUWKXjuIDC7Tx8+GI3qTUmdU2FmIWnB9Yt+cP2G
         4a440fa4hNvE/0E7ud5/JC+NOO2MD7dKMVmuYN701FSJFjtBjWKbyg2X/LZZUFWAHqLA
         Ji1KsjuWvre5n4eK3ns7fjFxO4xoekaFnYX+3Aj22mRZbNm46hnCDvkh8uGFbnuvmiXb
         g/ApFF7MFjiS8RapZrJiacDfMadaLBw0oLBBbCm5OSKChdCeBcQxt6tOkV5lNDLtdypk
         h6jRDyuWD+hAUrRhEUc3aBVMru1HRQ67qw09GvjiyVnPaU9Va3uvreJJ5Sva2Nxn3xNp
         uSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763601; x=1696368401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muLZH0eItTClOvNm2BECD1Xlt1dVjs1Gh1+6BZ2wAV4=;
        b=fX0QXmDdRblzb02fQeVUOWREGUAF5Uj04W9De8pTPhHZH0pDeBg0wszMTFvOl8LvM2
         eUWL8L+3Pe3ZKnXjWi1ygoPJaQZdbZpizZb27oV1ZG78jaLPRZw2bXqOmc+XnxXvskoj
         PPi9xRsYDhNj+x4gQisrEGEhcj0re9aoTc8G3S3l9N/YCpYSAffoKQVEZFnIPW1CWGZQ
         3LTEiQlwHnma96fysian9KZAyUmHY+KYxvEi5N6mSeptXSut3HBkRmJjOIVQTWh+eLus
         UOTSNPJUU+TrAEQd78GfWGMFYpz/QfU0i9AnoHq7oOe0UtgybgmfhhEuiiKz6YOUUhIm
         lp7w==
X-Gm-Message-State: AOJu0YzH8iy49Oz4V1mwv64SNU44pWRsu+aMR1/CjS91mj+4Cte4I84H
        6bNzOZ/O08zp96OFuroN/X2edg==
X-Google-Smtp-Source: AGHT+IHzmW+l9cgN4DlbGDZUaAp8zkUi3pgbXJykAuA7GiC0MGLqCWdJ+CpuymwGwbW+p7jrJ0Godg==
X-Received: by 2002:a0c:f053:0:b0:658:396a:444e with SMTP id b19-20020a0cf053000000b00658396a444emr145795qvl.7.1695763601492;
        Tue, 26 Sep 2023 14:26:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ba06])
        by smtp.gmail.com with ESMTPSA id r13-20020a0cb28d000000b0064f4e0b2089sm1478849qve.33.2023.09.26.14.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 14:26:41 -0700 (PDT)
Date:   Tue, 26 Sep 2023 17:26:40 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: change zswap's default allocator to zsmalloc
Message-ID: <20230926212640.GC348484@cmpxchg.org>
References: <20230908235115.2943486-1-nphamcs@gmail.com>
 <ZRKIRyYYkAbJ5uOP@infradead.org>
 <CAKEwX=O3ydrSKoZKv-6T0QHTEh5WkgRfK3b7Aa_H6GmQbn4QsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=O3ydrSKoZKv-6T0QHTEh5WkgRfK3b7Aa_H6GmQbn4QsA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 01:06:13PM -0700, Nhat Pham wrote:
> On Tue, Sep 26, 2023 at 12:29 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Fri, Sep 08, 2023 at 04:51:15PM -0700, Nhat Pham wrote:
> > > Out of zswap's 3 allocators, zsmalloc is the clear superior in terms of
> > > memory utilization, both in theory and as observed in practice, with its
> > > high storage density and low internal fragmentation. zsmalloc is also
> > > more actively developed and maintained, since it is the allocator of
> > > choice for zswap for many users, as well as the only allocator for zram.
> >
> > Dumb question from an outside, why do we then even keep the other
> > two allocators around?
> >
> 
> Maybe legacy users who explicitly configure zbud/z3fold?
> We have a couple internally, and have to manually undo
> those configuration after we stop compiling these 2
> allocators.
> 
> But yeah, I don't see why we should keep these 2 allocators
> around. Time to deprecate them? :)

I agree we should try to get rid of them. The best reason for them I
can come up with is that they're more "lightweight". But I'm not sure
that pans out in practice. Even if loads and stores are marginally
faster, the poor density means you have to reclaim more/hotter anon
pages for the equivalent reduction in memory usage. In most cases this
will increase the overall amount of ongoing paging. That should
quickly dwarve the minor advantage in per-transaction overhead.

We could do something similar as we did for slab and mark them
deprecated for a few cycles:

commit eb07c4f39c3e858a7d0cc4bb15b8a304f83f0497
Author: Vlastimil Babka <vbabka@suse.cz>
Date:   Tue May 23 09:06:34 2023 +0200

    mm/slab: rename CONFIG_SLAB to CONFIG_SLAB_DEPRECATED

Then if nobody complains give them the ax.
