Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9396B78BE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjH2GK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbjH2GKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:10:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766B1198
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693289441; x=1724825441;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=nvPDIFg377zliRnyEf2uQQZQ8UkypFn5SQhyuarr91w=;
  b=Y719RCv7kUW6j3s7c5zyWFjoPmG8BwjF7xS3h5MOMG7tB4hasvPH9qt8
   fLLYUpk4kTwGJrLs61IYlfyTWdz7Zn1fFzDM+JhEkBUrIGmQTZBuHIb1d
   gLVINTsfG5nZ0p1D/gRH/MzUP+tYQqCT79QYewwDtOuGRcZGlahY97wF4
   tp0ipyPVl2m8gd506GeCIj2fsRmnmFwzSmvXCEqH0vlvwhGgcZJea6cIm
   RI8n/zjEjNC/QwyPcHrBpnirme10s4yNtiNoYQV6jdk465NtxaicZ9j5n
   cQdZY+uIOEGONYuZ5a4OVj46O2DfPXGedMJstyvLsLKFF4HBjsoxeF7kb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="378007732"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="378007732"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 23:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="688381879"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="688381879"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 23:10:19 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Lameter, Christopher" <cl@os.amperecomputing.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: fix draining remote pageset
References: <20230811090819.60845-1-ying.huang@intel.com>
        <ZNYA6YWLqtDOdQne@dhcp22.suse.cz>
        <87r0o6bcyw.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZNxxaFnM9W8+imHD@dhcp22.suse.cz>
        <87jztv79co.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZOMYb27IulTpDFpe@dhcp22.suse.cz>
        <87v8d8dch1.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZOMuCiZ07N+L/ljG@dhcp22.suse.cz>
        <87msykc9ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZORtHmDeDCMcCb7Q@dhcp22.suse.cz>
        <94b0e0c6-a626-46a1-e746-a336d20cdc08@os.amperecomputing.com>
Date:   Tue, 29 Aug 2023 14:08:15 +0800
In-Reply-To: <94b0e0c6-a626-46a1-e746-a336d20cdc08@os.amperecomputing.com>
        (Christopher Lameter's message of "Fri, 25 Aug 2023 10:06:19 -0700
        (PDT)")
Message-ID: <87h6oi4bzk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christopher,

"Lameter, Christopher" <cl@os.amperecomputing.com> writes:

> On Tue, 22 Aug 2023, Michal Hocko wrote:
>
>> Yes, this doesn't really show any actual correctness problem so I do not
>> think this is sufficient to change the code. You would need to show that
>> the existing behavior is actively harmful.
>
> Having some pages from a remote NUMA node stuck in a pcp somewhere is
> making that memory unusable. It is usually rate that these remote
> pages are needed again and so they may remain there for a long time if
> the situation is right.
>
> And he is right that the intended behavior of freeing the remote pages
> has been disabled by the patch.
>
> So I think there is sufficient rationale to apply these fixes.

Thanks!  Can I get your "Acked-by" or "Reviewed-by" for the patch?

--
Best Regards,
Huang, Ying
