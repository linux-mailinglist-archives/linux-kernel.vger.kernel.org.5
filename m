Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D457E2CE3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjKFTdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjKFTdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:33:19 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22F798
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:33:16 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d134a019cso34297276d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1699299196; x=1699903996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=coUY4R4bHV6GlqkmIzcmtT/lwGgqLzFx1u4qLz1y+oQ=;
        b=PH1GvQOn6fAbv2MwCknxQhb63C0h2di5Jgcv8yrRgUDGYFm3i+h7Dl/b9evUlb4jYi
         8SmOiJM9R/Y7JjD2o04GQiwmQZr9f/bs3MpBn/WSHBoehAt0Ducw/VWLJ9fmM0P0wdnM
         4BpTr2YthH9kbCsHnGxwbKkmhTqXq4eYMp6gw3hUfHVgzGQ1k/8C3UvQlwNr0nxSHRkb
         HU4Yb414aoIVoEnZL0Q08mDj5hYw3qniXSrVLtmg7sR2npSSCG89Hofy5V0QSDw+mnft
         WZQ9IWnRtMrl4MI8gsN9KJ4MB6FxN0iatCGq42q68O4tRN8314Uadg5xmMnVRg5mbgT7
         LrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299196; x=1699903996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coUY4R4bHV6GlqkmIzcmtT/lwGgqLzFx1u4qLz1y+oQ=;
        b=oBAH1DLF5EXop86y8bP7mQxN9+j7OqIDVmL1OjLGLfc4WfMqd+G+xrdBj5fedzdvWj
         8kAAcc7yGcxLYusPD47rsrY0dvfFoshG/hmRbr7CFzQi0N3Ikr6f6oYS9DnjwOHApll0
         3iEkOYjx4HUqwOe+qvVw7L6JHMfamk+B11ucUwRES5IYkVDxEMx1NgH4Ox4Icq+sV3D9
         lpXG7O+XyQ7D7yOJnLwpOmgPHsGBFKXU3ZTxnUTRSa/1nAJTBgktUkvTZMMipgKndOm9
         4fmhLgY0aU0TCfbO9jOe/f8fkEHa0nRvgOhj2HporgzgGGxN4O3tLsyIIhVDChp+Wm6a
         aCOw==
X-Gm-Message-State: AOJu0YwNRvextu9/z8I5+gUOSK/CVmcAafxpTZRQrixeW8BOM3pOYJ7k
        mi7aJGYDaADonUGMb2ZD9XJtE9DVFyLcJAlKonI=
X-Google-Smtp-Source: AGHT+IFB4ynFNenu6NMKO6W41ABUIn46Q9P4fziPyO/xQ3FY9qzDVqjEw+VHQZZ3P4pw7Eq4GLK1ow==
X-Received: by 2002:ad4:5c4c:0:b0:66d:113e:5374 with SMTP id a12-20020ad45c4c000000b0066d113e5374mr37727312qva.25.1699299196147;
        Mon, 06 Nov 2023 11:33:16 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:86b7])
        by smtp.gmail.com with ESMTPSA id i3-20020a0cfcc3000000b0066d02f0af01sm3708077qvq.72.2023.11.06.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 11:33:15 -0800 (PST)
Date:   Mon, 6 Nov 2023 14:33:15 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com,
        akpm@linux-foundation.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1] mm: Fix for negative counter: nr_file_hugepages
Message-ID: <20231106193315.GB3661273@cmpxchg.org>
References: <20231106181918.1091043-1-shr@devkernel.io>
 <ZUk3q/H/swmDPRo+@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUk3q/H/swmDPRo+@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 06:59:55PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 06, 2023 at 10:19:18AM -0800, Stefan Roesch wrote:
> > +++ b/mm/huge_memory.c
> > @@ -2740,7 +2740,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
> >  			if (folio_test_swapbacked(folio)) {
> >  				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
> >  							-nr);
> > -			} else {
> > +			} else if (folio_test_pmd_mappable(folio)) {
> > +
> >  				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
> >  							-nr);
> >  				filemap_nr_thps_dec(mapping);
> 
> Good catch.  Two things:
> 
> 1. No blank line after the 'else if'.
> 
> 2. We're leaving a bit of a landmine for shmem when it gets support for
> arbitrary folio sizes.  Really all of this should be under a
> test_pmd_mappable.

I was wondering if we want to keep NR_FILE_THPS permanently for
original flavor 512 basepage THPs, or whether they should account
large folios as well? Same for NR_ANON_THPS and NR_SHMEM_THPS.

If so, then I agree this should all be conditional on pmdmapped. I
suppose the same in filemap_unaccount_folio().
