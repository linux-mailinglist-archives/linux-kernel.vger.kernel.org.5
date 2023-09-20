Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4248F7A89A5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjITQl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjITQlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:41:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CE283
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:41:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF03C433C7;
        Wed, 20 Sep 2023 16:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695228079;
        bh=VX2oHOVCDzGT6jqqR+drIuZN91AqPApS73azW2k4k0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2C1qKJNp1nBdIrGsK/QkVP7rD/18cjSBvs9sXLfbaZtMJLBRTvRllW3mEj1OZfDoA
         6YVvm5XRPz57CI5PkU/vcpB2W8OXkykA4r4OGGoC9kmpNCfLnlXIxXC/hF/OSn+K7a
         mB3zsHxu0+UCMQUa7v4NX4swx1Ls553GaRSDk2Nk=
Date:   Wed, 20 Sep 2023 09:41:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 00/10] mm: PCP high auto-tuning
Message-Id: <20230920094118.8b8f739125c6aede17c627e0@linux-foundation.org>
In-Reply-To: <20230920061856.257597-1-ying.huang@intel.com>
References: <20230920061856.257597-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 14:18:46 +0800 Huang Ying <ying.huang@intel.com> wrote:

> The page allocation performance requirements of different workloads
> are often different.  So, we need to tune the PCP (Per-CPU Pageset)
> high on each CPU automatically to optimize the page allocation
> performance.

Some of the performance changes here are downright scary.

I've never been very sure that percpu pages was very beneficial (and
hey, I invented the thing back in the Mesozoic era).  But these numbers
make me think it's very important and we should have been paying more
attention.

> The list of patches in series is as follows,
> 
>  1 mm, pcp: avoid to drain PCP when process exit
>  2 cacheinfo: calculate per-CPU data cache size
>  3 mm, pcp: reduce lock contention for draining high-order pages
>  4 mm: restrict the pcp batch scale factor to avoid too long latency
>  5 mm, page_alloc: scale the number of pages that are batch allocated
>  6 mm: add framework for PCP high auto-tuning
>  7 mm: tune PCP high automatically
>  8 mm, pcp: decrease PCP high if free pages < high watermark
>  9 mm, pcp: avoid to reduce PCP high unnecessarily
> 10 mm, pcp: reduce detecting time of consecutive high order page freeing
> 
> Patch 1/2/3 optimize the PCP draining for consecutive high-order pages
> freeing.
> 
> Patch 4/5 optimize batch freeing and allocating.
> 
> Patch 6/7/8/9 implement and optimize a PCP high auto-tuning method.
> 
> Patch 10 optimize the PCP draining for consecutive high order page
> freeing based on PCP high auto-tuning.
> 
> The test results for patches with performance impact are as follows,
> 
> kbuild
> ======
> 
> On a 2-socket Intel server with 224 logical CPU, we tested kbuild on
> one socket with `make -j 112`.
> 
> 	build time	zone lock%	free_high	alloc_zone
> 	----------	----------	---------	----------
> base	     100.0	      43.6          100.0            100.0
> patch1	      96.6	      40.3	     49.2	      95.2
> patch3	      96.4	      40.5	     11.3	      95.1
> patch5	      96.1	      37.9	     13.3	      96.8
> patch7	      86.4	       9.8	      6.2	      22.0
> patch9	      85.9	       9.4	      4.8	      16.3
> patch10	      87.7	      12.6	     29.0	      32.3

You're seriously saying that kbuild got 12% faster?

I see that [07/10] (autotuning) alone sped up kbuild by 10%?

Other thoughts:

- What if any facilities are provided to permit users/developers to
  monitor the operation of the autotuning algorithm?

- I'm not seeing any Documentation/ updates.  Surely there are things
  we can tell users?

- This:

  : It's possible that PCP high auto-tuning doesn't work well for some
  : workloads.  So, when PCP high is tuned by hand via the sysctl knob,
  : the auto-tuning will be disabled.  The PCP high set by hand will be
  : used instead.

  Is it a bit hacky to disable autotuning when the user alters
  pcp-high?  Would it be cleaner to have a separate on/off knob for
  autotuning?

  And how is the user to determine that "PCP high auto-tuning doesn't work
  well" for their workload?
