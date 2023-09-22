Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C47B7AA627
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 02:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjIVAhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 20:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjIVAhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 20:37:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12421A6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 17:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695343065; x=1726879065;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=DmdI4oHKe04/WJ/lKQd7QEfaM28FFFU6/vTomck8QyA=;
  b=lDuPwhRY8qEHcceP3xJ4Icgx/fRLug1+LGX/mEnz62MhWl+MSlcLIWcx
   qmOViS0WqTfgUGT3dsVapi9m4zFKaAmNFguKem/iVxDx6hU4lRjfque7w
   MISS6UkkTuNQJohcw3wy/n8W49JrEWqP2Xgeh84dOGoohtGQWSPQU3WgV
   cgP4KTRGxKeoWywC0xoRkroiKwLFNP4chQyn4zZMP+MBlxn9HfIOc2GTp
   wwQ/u9C6yrnYJAJ298POUTjwf7BYT0unkb14cQq8DPxLD4U0rTkJdeXXe
   LZva/MGxAGEA6zdmzqH+IL1HX1nBJTKkc3MDNo/bvViXG091fKWXGroMa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="379585327"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="379585327"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 17:37:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="740905492"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="740905492"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 17:37:41 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
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
References: <20230920061856.257597-1-ying.huang@intel.com>
        <20230920094118.8b8f739125c6aede17c627e0@linux-foundation.org>
        <87leczwt1o.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230921084617.b1129a46de247e4a6f0098af@linux-foundation.org>
Date:   Fri, 22 Sep 2023 08:33:52 +0800
In-Reply-To: <20230921084617.b1129a46de247e4a6f0098af@linux-foundation.org>
        (Andrew Morton's message of "Thu, 21 Sep 2023 08:46:17 -0700")
Message-ID: <87h6nnvyfj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 21 Sep 2023 21:32:35 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
>
>> >   : It's possible that PCP high auto-tuning doesn't work well for some
>> >   : workloads.  So, when PCP high is tuned by hand via the sysctl knob,
>> >   : the auto-tuning will be disabled.  The PCP high set by hand will be
>> >   : used instead.
>> >
>> >   Is it a bit hacky to disable autotuning when the user alters
>> >   pcp-high?  Would it be cleaner to have a separate on/off knob for
>> >   autotuning?
>> 
>> This was suggested by Mel Gormon,
>> 
>> https://lore.kernel.org/linux-mm/20230714140710.5xbesq6xguhcbyvi@techsingularity.net/
>> 
>> "
>> I'm not opposed to having an adaptive pcp->high in concept. I think it would
>> be best to disable adaptive tuning if percpu_pagelist_high_fraction is set
>> though. I expect that users of that tunable are rare and that if it *is*
>> used that there is a very good reason for it.
>> "
>> 
>> Do you think that this is reasonable?
>
> I suppose so, if it's documented!
>
> Documentation/admin-guide/sysctl/vm.rst describes
> percpu_pagelist_high_fraction.

Sure.  Will add document about auto-tuning behavior in the above
document.

--
Best Regards,
Huang, Ying
