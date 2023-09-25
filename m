Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D607AE1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjIYWvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIYWvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:51:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B189DCE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fkpEMEA5GrodGGnTXvAzWVCKUrI8tAWka+urpqQ/HT0=; b=fW8kU+Fnbdm+zP6pBUarKlT0N7
        jjaiHlrjVoxGHFLkB9uLWHfdGX4E6MHfSnZZHVB69oZGq5z7KNriYlyK53K0tjzR6Zh49ceBDJzyp
        NplP8BnOUM9FByS5qLgA8RgZyVx2T67OCJ+jfwLh2+OavJogFSqrYmCRL28g70UOTmV1xtuRFyhsz
        CIIl2F3mVFXiDTZpW+W1K8LIhnjrE/jl3lkp1bsSkqvROQfz7g2hiGNaQnaL9EephW/f6o8mGwHaq
        Ke7BLp1J3J/R2AIYx+WPS8b06H9ac/K30HZtXCD2VySIYucaw6alemgfh2AYH+bNzwmkKAj8u4YBp
        dozksdjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qkuPl-0048Wp-6m; Mon, 25 Sep 2023 22:50:53 +0000
Date:   Mon, 25 Sep 2023 23:50:53 +0100
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
Subject: Re: [PATCH 07/12] mempolicy: mpol_shared_policy_init() without
 pseudo-vma
Message-ID: <ZRIOzcI78x8BmGdo@casper.infradead.org>
References: <2d872cef-7787-a7ca-10e-9d45a64c80b4@google.com>
 <ea413d84-8b43-91c2-feef-92998bc7c1e2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea413d84-8b43-91c2-feef-92998bc7c1e2@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:29:28AM -0700, Hugh Dickins wrote:
> +		/* alloc node covering entire file; adds ref to new */

This comment is confusing.  sp_alloc initialises the refcount of 'n' to 1.
Which is the same memory referred to by the name 'new' in __mpol_dup(),
but in this function, the name "new" refers to the mempolicy called
"old" in __mpol_dup().

> +		n = sp_alloc(0, MAX_LFS_FILESIZE >> PAGE_SHIFT, new);
> +		if (n)
> +			sp_insert(sp, n);
>  put_new:
>  		mpol_put(new);			/* drop initial ref */
>  free_scratch:

This is all a bit inefficient, really.  We call mpol_new() to get a
new mpol, then we set it up, then we dup it, then we free it.  It'd
be nice if we could donate it instead of copying it.  Maybe you'll
do something like that later.
