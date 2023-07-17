Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1E17565FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjGQONS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjGQONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:13:01 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C6B10E5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:12:52 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7672303c831so431564285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1689603171; x=1692195171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mUo+6I0vtoW6cfyVYK79jK4ZqLeZxYB4Nx9OKnhgx0U=;
        b=ku2rfNUK+DU5Hrx59tES8EpLWBWpNHDaYQK9aNkA4w7I0J6zKbMmk+t71+OCIFjDeN
         CpAwZDk/+R0b8mf/fupiKX8yYumHwfH3rEZ15qGdcz7FEC0D9B4V1XlBaJhFA7QVr4Gp
         D+1Ah9nHuE7ee9o2aD94yyPfhzILFyfl+q3Ip0gkSBDZomcxvUeXgSXRSYvsl+G0K7Er
         M0V8S1otEmVOCDpCD7a+/+NXta2i/4m9BnZ9Z2a8GAjsu8DeiuOwA6t+Gl8+YPDzypov
         orC75KUozuXSyf76NwcwEOtlfnyVdIKLKenze5MwGV40O2k7X76Ot4tpnvSptuE+21db
         g5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689603171; x=1692195171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUo+6I0vtoW6cfyVYK79jK4ZqLeZxYB4Nx9OKnhgx0U=;
        b=YRNU5SqL6yjWGkO8YJ+myi/VfzmCWQVv3lhHxdGTDHVs6dvdN/ML4wIppdiOzarisb
         5z+GljrTjOfsWEBbrVUM9OhFWp1M/E9EC4IOtkMczQAAKg8LfSNV07zmsou1o6rJhYeR
         QclPiJeLzdiqgfXq5EfQwJWerrfqYa0RC9pcLQxNuWHwgOTcFaqHvRRzsVnBEShOohdI
         n2hK7lloBAvYPGmPoGsXnqisjOa9zuiuHXxXA8QNI3HzfoxBtCyyK8yaagR6FWqwl6AW
         GHRriSCS0CpV56CGqKISt4qeJNmmwT97y+cId9zNdkJHymZNy1l5Bde21zyX3iBIkWpi
         7hew==
X-Gm-Message-State: ABy/qLZlEoQAlxTet01QyyvkXG9HIONnHUh7psZs+l6VsJ4K+e2fOGBU
        EmO69udlIXPxsH6wbZ9krYtDKA==
X-Google-Smtp-Source: APBJJlGAGULC7enn5gfZAvLy/hJHQS3JtiaNt8i0W6K9lNpDSglVC/a8mnN/bspkZOik1rny8T6p0w==
X-Received: by 2002:a05:620a:4087:b0:765:3380:2005 with SMTP id f7-20020a05620a408700b0076533802005mr15636201qko.61.1689603171377;
        Mon, 17 Jul 2023 07:12:51 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a136100b00767cfac77c3sm6069128qkl.134.2023.07.17.07.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:12:51 -0700 (PDT)
Date:   Mon, 17 Jul 2023 10:12:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        konrad.wilk@oracle.com, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kill frontswap
Message-ID: <20230717141250.GA866068@cmpxchg.org>
References: <20230714194610.828210-1-hannes@cmpxchg.org>
 <ZLIVleBYOm4HIGTZ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLIVleBYOm4HIGTZ@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 04:42:13AM +0100, Matthew Wilcox wrote:
> On Fri, Jul 14, 2023 at 03:46:08PM -0400, Johannes Weiner wrote:
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 62195f72bf56..1b0128060792 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -2,7 +2,7 @@
> >  /*
> >   * zswap.c - zswap driver file
> >   *
> > - * zswap is a backend for frontswap that takes pages that are in the process
> > + * zswap is a cache that takes pages that are in the process
> >   * of being swapped out and attempts to compress and store them in a
> >   * RAM-based memory pool.  This can result in a significant I/O reduction on
> >   * the swap device and, in the case where decompressing from RAM is faster
> > @@ -20,7 +20,6 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/types.h>
> >  #include <linux/atomic.h>
> > -#include <linux/frontswap.h>
> >  #include <linux/rbtree.h>
> >  #include <linux/swap.h>
> >  #include <linux/crypto.h>
> 
> To make this patch compile, I had to add zswap.h to the include list.

I can fix that up, but I'm curious what kind of failure you saw. It
built fine for me, not even a warning.
