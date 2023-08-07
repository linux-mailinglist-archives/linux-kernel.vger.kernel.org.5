Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84D0772B56
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjHGQns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjHGQnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908AB172A;
        Mon,  7 Aug 2023 09:43:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AE3961F5F;
        Mon,  7 Aug 2023 16:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28418C433C7;
        Mon,  7 Aug 2023 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691426623;
        bh=mC/OCo8hq+diLms6Fsc67TK0qEWRyhhnzPlcu8trSb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=COIfvsny16WgH9j0mtGIQ5SmK6mHXLjrjumtR4I2MUWJ7RfrVddCiXNFh/BglZOz9
         VWXQaqTT0zXnwJnJI4lENI8tGb6YWhf+OseHCQvVMwywv4Ve/ZsCndA88YVv612EE0
         Z03tnfzBhKg0C+zjBHnUBZfMsUjll1sJW5Jfvc2Q=
Date:   Mon, 7 Aug 2023 09:43:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <willy@infradead.org>,
        <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <minchan@kernel.org>, <yuzhao@google.com>, <david@redhat.com>,
        <ryan.roberts@arm.com>, <shy828301@gmail.com>
Subject: Re: [PATCH 0/2] don't use mapcount() to check large folio sharing
Message-Id: <20230807094342.17199a897f51a298f20fda57@linux-foundation.org>
In-Reply-To: <6dbf9f37-e4bf-656d-4121-789e2e6cfae2@intel.com>
References: <20230728161356.1784568-1-fengwei.yin@intel.com>
        <20230728102405.7b456eb87fb46042fbce5e4b@linux-foundation.org>
        <29cd58c4-08d3-c03c-7232-15f85878934d@intel.com>
        <6dbf9f37-e4bf-656d-4121-789e2e6cfae2@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 15:14:53 +0800 "Yin, Fengwei" <fengwei.yin@intel.com> wrote:

> Hi Andrew,
> 
> On 8/2/2023 8:39 PM, Yin, Fengwei wrote:
> > Hi Andrew,
> > 
> > On 7/29/2023 1:24 AM, Andrew Morton wrote:
> >> On Sat, 29 Jul 2023 00:13:54 +0800 Yin Fengwei <fengwei.yin@intel.com> wrote:
> >>
> >>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
> >>> folio_mapcount() is used to check whether the folio is shared. But it's
> >>> not correct as folio_mapcount() returns total mapcount of large folio.
> >>>
> >>> Use folio_estimated_sharers() here as the estimated number is enough.
> >>
> >> What are the user-visible runtime effects of these changes?
> >>
> >> (and please try to avoid using the same Subject: for different patches)
> >>
> > 
> > Can you hold on these patches to mm-unstable? I think we need to wait for
> > David's work on folio_maybe_mapped_shared() and redo the fix base on that.
> > Thanks and sorry for the noise.
> Sorry for bothering you again for this patchset.
> 
> Let me explain the situation here:
>   - The reason to hold on the patches to mm-unstable is that I don't want to
>     promote the fix in this patch (using folio_estimated_sharers()). The
>     correct way is waiting for folio_maybe_mapped_shared() from David.
> 
>     Merging these patches motivate using folio_estimated_sharers() in other
>     places. So once folio_maybe_mapped_shared() is ready, we need to replace
>     folio_estimated_sharers() with folio_maybe_mapped_shared().
> 
>   - For this specific patches, if they are suitable for stable, we may want to
>     merge it (special for stable branch. I assume folio_maybe_mapped_shared()
>     may not be back ported to stable branch).
> 
> So how do we deal with this situation? Thanks in advance.
> 

I think I'll stage them for 6.5, with a cc:stable.

I'll drop the current three patches.  Please resend with

a) different Subject:s for all patches and

b) changelogs which fully describe the user-visible effects of the change.

Thanks.
