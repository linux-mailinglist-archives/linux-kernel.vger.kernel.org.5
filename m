Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D26E7E1929
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjKFDXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 22:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFDXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:23:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5500BB;
        Sun,  5 Nov 2023 19:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699240985; x=1730776985;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=d0GJaRr0bVj8J9IvowV4cvGbvN8Uw+bGKm4vNcfReLQ=;
  b=Ih1RGuf/Dl6IHo46U6SnpoxFL/W360YLXJgRzy8qoksdqggrGr6e08Kf
   eJtMiOml+ZJQsbLFsRsj4up5D89Vqu9e8w9ZLrCn8nSRsKdicYn1IE9HB
   NbMV8G/NBdvzaWWEl5BaG4AuvGqzQCrHcSlt+i+dDHnuh9ikidjmP7fee
   8Lujh1LaF3nwYQJrxSoEWq1mwLXnvehJxNCoefh+SLQNlWTHy7GW9lfwW
   tZ60zfWi8PYeoYKTLW0FJtNvS6oyifov9teR/2Mg5X4xcbG6DIv2D7OWw
   4Nxx4lgb0sC/IG3nwB6Txd9MRTlUIUOHDRmLKOXOaOXpUpPgLdvrDWfKs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="2182573"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="2182573"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 19:23:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="885772160"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="885772160"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 19:23:00 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Gregory Price <gregory.price@memverge.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Gregory Price <gourry.memverge@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.ibm.com>, <weixugc@google.com>,
        <apopple@nvidia.com>, <tim.c.chen@intel.com>,
        <dave.hansen@intel.com>, <shy828301@gmail.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>
Subject: Re: [RFC PATCH v3 0/4] Node Weights and Weighted Interleave
In-Reply-To: <20231103141636.000007e4@Huawei.com> (Jonathan Cameron's message
        of "Fri, 3 Nov 2023 14:16:36 +0000")
References: <20231031003810.4532-1-gregory.price@memverge.com>
        <rm43wgtlvwowjolzcf6gj4un4qac4myngxqnd2jwt5yqxree62@t66scnrruttc>
        <20231031152142.GA3029315@cmpxchg.org>
        <jgh5b5bm73qe7m3qmnsjo3drazgfaix3ycqmom5u6tfp6hcerj@ij4vftrutvrt>
        <ZUCCGJgrqqk87aGN@memverge.com>
        <pmxrljwp4ayl3fcu7rxm6prbumgb5l3lwb75lqfipmxxxwnqfo@nb5qjcxw22gp>
        <ZUKDz5NpMsoyzWtZ@memverge.com>
        <a4f5das6ckw5lwj3qv2eaygx4nypb762b6mdnxivrjjndqlhjk@zpjao2ewfdoc>
        <ZUMVI4YG7mB54u0D@memverge.com>
        <87fs1nz3ee.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20231103141636.000007e4@Huawei.com>
Date:   Mon, 06 Nov 2023 11:20:58 +0800
Message-ID: <8734xjworp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Fri, 03 Nov 2023 15:45:13 +0800
> "Huang, Ying" <ying.huang@intel.com> wrote:
>
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> > On Thu, Nov 02, 2023 at 10:47:33AM +0100, Michal Hocko wrote:  
>> >> On Wed 01-11-23 12:58:55, Gregory Price wrote:  
>> >> > Basically consider: `numactl --interleave=all ...`
>> >> > 
>> >> > If `--weights=...`: when a node hotplug event occurs, there is no
>> >> > recourse for adding a weight for the new node (it will default to 1).  
>> >> 
>> >> Correct and this is what I was asking about in an earlier email. How
>> >> much do we really need to consider this setup. Is this something nice to
>> >> have or does the nature of the technology requires to be fully dynamic
>> >> and expect new nodes coming up at any moment?
>> >>    
>> >
>> > Dynamic Capacity is expected to cause a numa node to change size (in
>> > number of memory blocks) rather than cause numa nodes to come and go, so
>> > maybe handling the full node hotplug is a bit of an overreach.  
>> 
>> Will node max bandwidth change with the number of memory blocks?
>
> Typically no as even a single memory extent would probably be interleaved
> across all the actual memory devices (think DIMMS for simplicity) within
> a CXL device. I guess a device 'could' do some scaling based on capacity
> provided to a particular host but feels like they should be separate controls.
> I don't recall there being anything in the specification to suggest the
> need to recheck the CDAT info for updates when DC add / remove events happen.

Sounds good!  Thank you for detailed explanation.

> Mind you, who knows in future :)  We'll point out in relevant forums that
> doing so would be very hard to handle cleanly in Linux.

Thanks!

--
Best Regards,
Huang, Ying
