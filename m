Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645AA7AE1FA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjIYW6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIYW6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:58:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D2B101
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XwCjcncnJ5ZxZIUi6jjYCedQryoBULwBfDgkVT6PDZ8=; b=K0VyEqlpKIUcb2s2ECR+gWwU3f
        K0R/AOu77KZXhWs1Pe0jCYCUqt1Pj42flLAciC+v+CLJt34xmR0PG884riCWfyqVhjCZFONwni9Ls
        kZs7kCMxQ3m/EutNC1eVjka01AruF7G7/8yrOrnipePwRYFwkWkLumMF4RrAYdxn4WzQGD7UaG25x
        iC+AR/0lbjoaYISMaIX1aRcCHWkdCmIS4wU+cf/hSKqmZE1tO6TN8Yizg59suEIKO3vwDg6DmOxSt
        rAl6GW/wol4im9XzL1kJ1Fd3gKp4ayblZAIavwv+xCgTjCRqPNGzx+pCj4TF1PMOrxZyQr44ZUO7L
        wOkrmtlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qkuWz-0048m2-On; Mon, 25 Sep 2023 22:58:21 +0000
Date:   Mon, 25 Sep 2023 23:58:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 09/12] mm: add page_rmappable_folio() wrapper
Message-ID: <ZRIQjZOZJ2ZFkY8C@casper.infradead.org>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
 <f4dc7bb6-be3a-c1b-c30-37c4e0c16e4d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4dc7bb6-be3a-c1b-c30-37c4e0c16e4d@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:32:02AM -0700, Hugh Dickins wrote:
>  {
>  	struct page *page = __alloc_pages(gfp | __GFP_COMP, order,
> -			preferred_nid, nodemask);
> +					  preferred_nid, nodemask);

I really prefer not to do this "align arguments with opening bracket"
style.  As long as they're indented enough to make them visually distinct
from indentation-for-if-blocks, I find it annoying when functions get
renamed to something with a different length and somebody then wastes
time reindenting all the arguments to match.

> +	return page_rmappable_folio(page);

I don't particularly object to the main thrust of this patch.  I'm not
sure I like it in huge_mm.h though.  Maybe in mm/internal.h?  I
wouldn't want anyone outside mm/ calling it.
