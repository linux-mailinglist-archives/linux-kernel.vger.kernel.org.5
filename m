Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA1C76E82E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjHCMae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjHCMac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:30:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D594430EF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+GBZoisSMbVY7fBPLSgxdUKAz4UO3mFAPyDKEIWzr3s=; b=ioOJ9uorxOLEyrm9ld/C2rO8EA
        ATmR1hfJ2DAYYGEgzH9tdKbku/JjdGnEe2YnPoqGUSXMh3qY6P5aTE4j4muSxx35gG6i1Zwm0HYZL
        Y3QZ57/eUSM8tpf/0FlFkcchwFYv1nn2brYYv3gdkOfHGp/m8tJhLdICZgfxlR3TTBEjBFBV0n6EA
        J0U/aPTqAvWQ848zav2g/Xq6qYdj3EEDBHGaJbV/fRfastADNeBOHEDFnb9U5nVgPZDSZddPJaMB6
        JL8Qt9EXzZmOlMJkO6Wm0wOPIMaTmwI/qsqA18nXA20A9Drl6e1p359IEuZOuQcSo8LBPUBex0lyC
        rdAqmzRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRXTB-003dKU-Ch; Thu, 03 Aug 2023 12:30:21 +0000
Date:   Thu, 3 Aug 2023 13:30:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/4] mm: migrate: use a folio in add_page_for_migration()
Message-ID: <ZMud3RreEpsvFKuA@casper.infradead.org>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
 <20230802095346.87449-2-wangkefeng.wang@huawei.com>
 <ZMpKYfNWA/jNgEuL@casper.infradead.org>
 <001ee9b0-ea25-a896-e3ae-9a9b05a46546@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001ee9b0-ea25-a896-e3ae-9a9b05a46546@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 03:13:21PM +0800, Kefeng Wang wrote:
> 
> 
> On 2023/8/2 20:21, Matthew Wilcox wrote:
> > On Wed, Aug 02, 2023 at 05:53:43PM +0800, Kefeng Wang wrote:
> > >   	err = -EACCES;
> > > -	if (page_mapcount(page) > 1 && !migrate_all)
> > > -		goto out_putpage;
> > > +	if (folio_estimated_sharers(folio) > 1 && !migrate_all)
> > > +		goto out_putfolio;
> > 
> > I do not think this is the correct change.  Maybe leave this line
> > alone.
> 
> Ok, I am aware of the discussion about this in other mail, will not
> change it(also the next two patch about this function), or wait the
> new work of David.
> > 
> > > -	if (PageHuge(page)) {
> > > -		if (PageHead(page)) {
> > > -			isolated = isolate_hugetlb(page_folio(page), pagelist);
> > > +	if (folio_test_hugetlb(folio)) {
> > > +		if (folio_test_large(folio)) {
> > 
> > This makes no sense when you read it.  All hugetlb folios are large,
> > by definition.  Think about what this code used to do, and what it
> > should be changed to.
> 
> hugetlb folio is self large folio, will drop redundant check

No, that's not the difference.  Keep thinking about it.  This is not
a mechanical translation!
