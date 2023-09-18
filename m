Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E097D7A4DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjIRQEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjIRQEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:04:12 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4A046BB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:01:41 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76de9c23e5cso304917085a.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695052663; x=1695657463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2GTC80Nmc9O9nGkpxSmWalzng5ADPOisHNrRaMTEl0U=;
        b=MS9bOKftSk9xrPy6zjJd6TQ6HbGEpzkwEsD8x7w0faXqOsjAsFK/XmjHwMAoE8f5x/
         7aoMl/GXRaG/6a/cpd5JO3Bd1BveXkTSGwGSVs+IbcjWvtRMnkQDhLIpHG8xkfuEqZDu
         xuXaZsw7z2GJ4Dttt63wypPICZ5Jgun0QMGcBoeinu5nx6SpDxIHZ1RBS+T0KZlr/g7q
         Dy2UKm+dGYzZoyqe2cugusAS4De18Eqz37YP8OYBEDE2oisQy2q0g26FhsVt31oZARfo
         zis14E66Prw3jMN5wNC2YtQktgE6tElF0XOq54wJ8CC3SBx9fcZgrV10yMB5SudBrwuE
         bilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052663; x=1695657463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GTC80Nmc9O9nGkpxSmWalzng5ADPOisHNrRaMTEl0U=;
        b=iSEXIkHyX9Hc7hQssch3RBFChCl80IPZ6cIefg4WYCW5n2q2wSP5wJhcG1FsVeS4Xo
         ojEHZkrtJ8uKmuhppWk8blC6ZDePajYIqOdAw44wxhXphPuy8js8Jiud0XLjY2Tzl/dl
         U50FJlerIrYhQAb+4eo7EgsyfTxIanO18dknAOvGLw8RI2Ll1RxNSUQeCO/ARgZqO3FT
         nyFXd9moC2kq/1lpT0xyIHSoj2n4XT+qSghAhObebfTPOmHU+wfEU4/sQ/CFOy0G05uA
         NqpGa+hyHV+5JfyUYrj1AAY+yQEWjes2A9s/mH43X1DP7pJ5V6h8exs19rkEAglXit5O
         NvhA==
X-Gm-Message-State: AOJu0YyYEaZqfKif8Rjup2ZjQYbI70/DAVc4gwbXBuKXd9OLNKw+L6+Q
        td5+D/x+/eHr1cAbhpOsiys96BPx19VR3XH4QdM=
X-Google-Smtp-Source: AGHT+IFpbQZVaJldjF1kKWMRtpSVycajTlLyx91xJ56YAslft0UTLtyJQU8izViGStazvml5yWSIZg==
X-Received: by 2002:a0c:f412:0:b0:656:5199:77a9 with SMTP id h18-20020a0cf412000000b00656519977a9mr5256999qvl.28.1695046141970;
        Mon, 18 Sep 2023 07:09:01 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id g28-20020a0caadc000000b0064d6a81e4d4sm896666qvb.113.2023.09.18.07.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 07:09:01 -0700 (PDT)
Date:   Mon, 18 Sep 2023 10:09:00 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20230918140900.GA16104@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230914235238.GB129171@monkey>
 <20230915141610.GA104956@cmpxchg.org>
 <b344c125-af3b-f4a3-4630-40cc5bd539e7@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b344c125-af3b-f4a3-4630-40cc5bd539e7@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 09:07:53AM +0200, Vlastimil Babka wrote:
> On 9/15/23 16:16, Johannes Weiner wrote:
> > On Thu, Sep 14, 2023 at 04:52:38PM -0700, Mike Kravetz wrote:
> >> In next-20230913, I started hitting the following BUG.  Seems related
> >> to this series.  And, if series is reverted I do not see the BUG.
> >> 
> >> I can easily reproduce on a small 16G VM.  kernel command line contains
> >> "hugetlb_free_vmemmap=on hugetlb_cma=4G".  Then run the script,
> >> while true; do
> >>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> >>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
> >>  echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> >> done
> >> 
> >> For the BUG below I believe it was the first (or second) 1G page creation from
> >> CMA that triggered:  cma_alloc of 1G.
> >> 
> >> Sorry, have not looked deeper into the issue.
> > 
> > Thanks for the report, and sorry about the breakage!
> > 
> > I was scratching my head at this:
> > 
> >                         /* MIGRATE_ISOLATE page should not go to pcplists */
> >                         VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> > 
> > because there is nothing in page isolation that prevents setting
> > MIGRATE_ISOLATE on something that's on the pcplist already. So why
> > didn't this trigger before already?
> > 
> > Then it clicked: it used to only check the *pcpmigratetype* determined
> > by free_unref_page(), which of course mustn't be MIGRATE_ISOLATE.
> > 
> > Pages that get isolated while *already* on the pcplist are fine, and
> > are handled properly:
> > 
> >                         mt = get_pcppage_migratetype(page);
> > 
> >                         /* MIGRATE_ISOLATE page should not go to pcplists */
> >                         VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> > 
> >                         /* Pageblock could have been isolated meanwhile */
> >                         if (unlikely(isolated_pageblocks))
> >                                 mt = get_pageblock_migratetype(page);
> > 
> > So this was purely a sanity check against the pcpmigratetype cache
> > operations. With that gone, we can remove it.
> 
> Agreed, I assume you'll fold it in 1/6 in v3.

Yes, will do.

