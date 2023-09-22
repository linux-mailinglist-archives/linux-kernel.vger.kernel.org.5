Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE017AABFB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjIVIKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjIVIJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:09:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2D61981
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:09:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E04C433CA;
        Fri, 22 Sep 2023 08:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695370159;
        bh=gesgJDKBt9RDzx1mXwpHnVS0bL79H7WYB0zJsn8L4gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXI++VKqARiqXJhZfCh8UJGk0/eL1A1I22cQVjhVJVmgTDIGQhuWWkUIzIhnFto/K
         f+zv1BzXJ/b7Kck3A6G9y7ce9cZ6yaqNWKjcapDD+fPk+Hg6Ct69A5QIDAtnCJT58f
         TvgGPz44rdMMdEO7o01UsuuEzoSbpQiotkqSd0hT8W0Z/i3RAbOpdiMCVUGHFTJf1R
         5GBFiryI+K8buRmSQMF8Ubg5QFvGM01vqncI+w8D2Ao5xS/mOMKl2J2TfBWlHF+KR6
         mz3bAOVnXZvwKr7KA2GJ139Qk6o9t1Z7hIvx5WfXgf2F6RxMaC5CaLsKpHayNSpa15
         vF6zy836q0lnw==
Date:   Fri, 22 Sep 2023 11:08:31 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev, glider@google.com,
        elver@google.com, dvyukov@google.com, osalvador@suse.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 1/4] mm: pass set_count and set_reserved to
 __init_single_page
Message-ID: <20230922080831.GH3303@kernel.org>
References: <20230922070923.355656-1-yajun.deng@linux.dev>
 <20230922070923.355656-2-yajun.deng@linux.dev>
 <ZQ1Gg533lODfqvWd@casper.infradead.org>
 <2ed9a6c5-bd36-9b9b-7022-34e7ae894f3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ed9a6c5-bd36-9b9b-7022-34e7ae894f3a@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 09:48:59AM +0200, David Hildenbrand wrote:
> On 22.09.23 09:47, Matthew Wilcox wrote:
> > On Fri, Sep 22, 2023 at 03:09:20PM +0800, Yajun Deng wrote:
> > > -		__init_single_page(page, pfn, zone, nid);
> > > +		__init_single_page(page, pfn, zone, nid, true, false);
> > 
> > So Linus has just had a big rant about not doing bool flags to
> > functions.  And in particular _multiple_ bool flags to functions.
> > 
> > ie this should be:
> > 
> > #define INIT_PAGE_COUNT		(1 << 0)
> > #define INIT_PAGE_RESERVED	(1 << 1)
> > 
> > 		__init_single_page(page, pfn, zone, nid, INIT_PAGE_COUNT);
> > 
> > or something similar.
> > 
> > I have no judgement on the merits of this patch so far.  Do you have
> > performance numbers for each of these patches?  Some of them seem quite
> > unlikely to actually help, at least on a machine which is constrained
> > by cacheline fetches.
> 
> The last patch contains
> 
> before:
> node 0 deferred pages initialised in 78ms
> 
> after:
> node 0 deferred pages initialised in 72ms
> 
> Not earth-shattering :D Maybe with much bigger machines relevant?

Patch 3 contains

The following data was tested on an x86 machine with 190GB of RAM.

before:
free_low_memory_core_early()    342ms

after:
free_low_memory_core_early()    286ms

Which is more impressive, but still I'm not convinced that it's worth the
added complexity and potential subtle bugs.

> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
