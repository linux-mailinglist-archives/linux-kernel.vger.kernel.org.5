Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595147713AA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 07:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjHFFFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 01:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHFFFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 01:05:03 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0981FCB
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 22:05:00 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-cfd4ea89978so3680571276.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 22:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691298300; x=1691903100;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kD7nNOIObNtNAHZ/WPJsr0/IMIpCdcKwrAKTB88pbeU=;
        b=JYEq72ltlZNdiKJk0/tZjUKWHrOtN2gJckKHHkaIkYNQnJjg9tQkg9kjTPMBAb7XKl
         4pUMyKNrqWPYTxLJElR9AqZH0Gepr2m9yKN7KESpwnUpUOcQf36y3m0617QK4d77TMbb
         Ue3sz4W6NdXH83d+yRDnu6hHIFajOvotmi142tvl7+/emzffPHV5SgIjCl6VkR1R67ms
         drj+q3/cZTY1H/BhDKotiUJ48LMH6xzu5lSMjpE1csq3d5XTNHw9/AhSc7FKoSvOLin1
         e6kXDPkjZ6bInkJ7H3q5MixM1sAzgjc8l9JMikUS91PGsXF8eUJWwvURWIbLpEZrVD/N
         KNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691298300; x=1691903100;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kD7nNOIObNtNAHZ/WPJsr0/IMIpCdcKwrAKTB88pbeU=;
        b=h2YeUQi527XUK1ILZ7tn7pjkpM+qFZDKFhZ1LZmGbnWUsHGUIv78TvRaZICMgtqAdy
         DnjegjSNJTfI5gKQSsAIkeAzKtRGg2p8VEhtxE8K+4JNNEGp9HPvjlE05arXL4Vg6CnE
         6utnhJE7axMC74xpedvrV6qeCYQ4fhOHUq2iVyBLFVTBfFibi0NCFNgKKzNT7MD/lwKK
         dFzFf01nt+CwVobX9om9nco1x9neJDOuPzEopkd+bM01hHTPtaqi8ATa968TK7HXze+9
         Yj6Xd2K2iLm+ji1yhfA4+Yo2ckUmGwlAgeIdBr1BwUEMt6kiFiaxlVNIQy98rO1WX/XF
         BFjQ==
X-Gm-Message-State: AOJu0Yzh6eF4pow6J6MaG66mS969ckSQYOPqwoikDaYR8PFjB2iCUTKG
        3n/GufP+JDww8L8zotc3MFZRuA==
X-Google-Smtp-Source: AGHT+IEkwc+7HgoNtgn+ahT6bReTdlMuaaeyxwNZdWVfSJO3mghlv58Q9v7Zw+Zy0uiPbU+lrsbEOw==
X-Received: by 2002:a25:361b:0:b0:d0f:846c:ef7b with SMTP id d27-20020a25361b000000b00d0f846cef7bmr7439389yba.17.1691298299947;
        Sat, 05 Aug 2023 22:04:59 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t64-20020a254643000000b00d0fe6cb4741sm1691914yba.25.2023.08.05.22.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 22:04:57 -0700 (PDT)
Date:   Sat, 5 Aug 2023 22:04:48 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 2/4] mm: migrate: convert numamigrate_isolate_page() to
 numamigrate_isolate_folio()
In-Reply-To: <2f6c2ddb-b1a7-7152-bb7c-a5dcaf61ce36@huawei.com>
Message-ID: <4b83ba15-9f1-812b-8620-1bd935262eaa@google.com>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com> <20230802095346.87449-3-wangkefeng.wang@huawei.com> <ZMpMfQUktateeN1D@casper.infradead.org> <2f6c2ddb-b1a7-7152-bb7c-a5dcaf61ce36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023, Kefeng Wang wrote:
> On 2023/8/2 20:30, Matthew Wilcox wrote:
> > On Wed, Aug 02, 2023 at 05:53:44PM +0800, Kefeng Wang wrote:
> >>   	/* Do not migrate THP mapped by multiple processes */
> >> -	if (PageTransHuge(page) && total_mapcount(page) > 1)
> >> +	if (folio_test_pmd_mappable(folio) && folio_estimated_sharers(folio) >
> >> 1)
> >>     return 0;
> > 
> > I don't know if this is the right logic.  We've willing to move folios
> > mapped by multiple processes, as long as they're smaller than PMD size,
> > but once they get to PMD size they're magical and can't be moved?
> 
> It seems that the logical is introduced by commit 04fa5d6a6547 ("mm:
> migrate: check page_count of THP before migrating") and refactor by
> 340ef3902cf2 ("mm: numa: cleanup flow of transhuge page migration"),
> 
> 
>   "Hugh Dickins pointed out that migrate_misplaced_transhuge_page() does
>   not check page_count before migrating like base page migration and
>   khugepage.  He could not see why this was safe and he is right."
> 
> For now, there is no migrate_misplaced_transhuge_page() and base/thp
> page migrate's path is unified, there is a check(for old/new kernel) in
> migrate_misplaced_page(),

Right, Mel's comment on safety above comes from a time when
migrate_misplaced_transhuge_page() went its own way, and so did not
reach the careful reference count checking found in (the now named)
folio_migrate_mapping().  If migrate_misplaced_page() is now using
the standard migrate_pages() for small pages and THPs, then there
should no longer be safety concerns.

> 
>  "Don't migrate file pages that are mapped in multiple processes
>  with execute permissions as they are probably shared libraries."
> 
> We could drop the above check in numamigrate_isolate_page(), but
> according to 04fa5d6a6547, maybe disable migrate page shared by
> multi-process during numa balance for both base/thp page.

I'm out of touch with the NUMA balancing preferences at present,
but think that you're probably right that it should aim to treat
folio mapped into multiple processes the same way for small and large
and THP (except, of course, that large and THP, with multiple PTEs in
the same process, can present more challenges to how to go about that).

Hugh
