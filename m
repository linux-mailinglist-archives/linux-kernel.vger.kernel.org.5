Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2079C7D3E57
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjJWRxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJWRxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:53:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF96A3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:53:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251F2C433C8;
        Mon, 23 Oct 2023 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698083613;
        bh=Jhe+XeYG4ZAoofviz9gMtylgOsjcE4B/E4TIZ4/ULYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=znZz8Fvr9vsi/Ax5MK6Q0e1d5+aKpOuPFM+pmFrvJosqNV/l7E/O7cI78iKyxD2aL
         YrTcgowceF+hp8sB/vgDoBCqtR5z3LCrDKbTtar6dV4vvUkfPItqJY2NBzoQ6TvnTt
         eaDlEFX1v9vF1pawCL+4Irduz9naDJ+XjaTZFSuw=
Date:   Mon, 23 Oct 2023 10:53:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     domenico cerasuolo <mimmocerasuolo@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux.co>,
        Matthew Wilcox <willy@infradead.org>,
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
        "Huang, Ying" <ying.huang@intel.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 10/12] mempolicy: alloc_pages_mpol() for NUMA policy
 without vma
Message-Id: <20231023105331.311373ed33a0dfe78ddaa9e5@linux-foundation.org>
In-Reply-To: <CAFYChMvWFdHq-OJHBE3DycmGtGmczDOHVGfoSqdvY-BxM2hWyg@mail.gmail.com>
References: <ebc0987e-beff-8bfb-9283-234c2cbd17c5@google.com>
        <74e34633-6060-f5e3-aee-7040d43f2e93@google.com>
        <1738368e-bac0-fd11-ed7f-b87142a939fe@google.com>
        <CAFYChMvWFdHq-OJHBE3DycmGtGmczDOHVGfoSqdvY-BxM2hWyg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 18:53:26 +0200 domenico cerasuolo <mimmocerasuolo@gmail.com> wrote:

> > Rebased to mm.git's current mm-stable, to resolve with removal of
> > vma_policy() from include/linux/mempolicy.h, and temporary omission
> > of Nhat's ZSWAP mods from mm/swap_state.c: no other changes.
> 
> Hi Hugh,
> 
> not sure if it's the rebase, but I don't see an update to
> __read_swap_cache_async invocation in zswap.c at line 1078. Shouldn't we pass a
> mempolicy there too?

No change needed.  zswap_writeback_entry() was passing a NULL for arg
`vma' and it's now passing a NULL for arg `mpol'.

