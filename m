Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC6B7D5910
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbjJXQp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjJXQp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:45:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E1112B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GMAFTNtWnm12yWRaZ75O/gVwatB6p/CE7HbexbbR0y0=; b=h3hHKUazF0w+AqrXJZ52L1PY03
        1HrNDOZfLL8fBSNuoERzU7wgqScFvATDv1ljjww3j/uKx1NFNf+DPPCXTqCev7jUanoHcVYgaQYH7
        AvU2RlteoElYKLtB1IIvC9j4Pb4vbo6pnQt+fjvHNFJjeRwgyCnSwjlbFBQxYxfmlkEMZlBLJKgCa
        f1G9B2GFd4PBXXhwxnJDDrV0Od29dBCbcT9uCZ6h3LSkyqgW2xhtikkjd4Xg9A7G9wu+k4I9IY5Oc
        WVaccXT/6OUjtp0XR14Vfm2w6IaCjxlbkCDuudUqsSxAEDYF3djLW2dqfSu68l9TfeUqL0pXWTxvt
        hRs4Yqow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qvKWm-003aXc-7J; Tue, 24 Oct 2023 16:45:12 +0000
Date:   Tue, 24 Oct 2023 17:45:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mempolicy: migration attempt to match interleave nodes:
 fix
Message-ID: <ZTf0mP3fTvhlr/DX@casper.infradead.org>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
 <77954a5-9c9b-1c11-7d5c-3262c01b895f@google.com>
 <3311d544-fb05-a7f1-1b74-16aa0f6cd4fe@google.com>
 <20231024151827.i7e2f6cheet4k5h5@revolver>
 <5b570bcd-e0fb-4473-7cfc-81b8b53d7712@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b570bcd-e0fb-4473-7cfc-81b8b53d7712@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 09:32:44AM -0700, Hugh Dickins wrote:
> On Tue, 24 Oct 2023, Liam R. Howlett wrote:
> 
> > * Hugh Dickins <hughd@google.com> [231024 02:50]:
> > > mm-unstable commit edd33b8807a1 ("mempolicy: migration attempt to match
> > > interleave nodes") added a second vma_iter search to do_mbind(), to
> > > determine the interleave index to be used in the MPOL_INTERLEAVE case.
> > > 
> > > But sadly it added it just after the mmap_write_unlock(), leaving this
> > > new VMA search unprotected: and so syzbot reports suspicious RCU usage
> > > from lib/maple_tree.c:856.
> > > 
> > > This could be fixed with an rcu_read_lock/unlock() pair (per Liam);
> > > but since we have been relying on the mmap_lock up to this point, it's
> > > slightly better to extend it over the new search too, for a well-defined
> > > result consistent with the policy this mbind() is establishing (rather
> > > than whatever might follow once the mmap_lock is dropped).
> > 
> > Would downgrading the lock work?  It would avoid the potential writing
> > issue and should still satisfy lockdep.
> 
> Downgrading the lock would work, but it would be a pointless complication.

I tend to agree.  It's also becoming far less important these days
with the vast majority of page faults handled under the per-VMA lock.
We might be able to turn it into a mutex instead of an rwsem without
seeing a noticable drop-off in performance.  Not volunteering to try this.
