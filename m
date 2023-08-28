Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA25F78B7D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjH1TGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjH1TGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:06:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCE3E0;
        Mon, 28 Aug 2023 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693249564; x=1724785564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mt0j3jMw8EW+E+l8MtReNSWFBKlj4P+LduvO4XW1DGs=;
  b=DAoz9qkwzKFcRxYDndu2kTGI30XiTx4aI7BYgRpE3L4gdoNfByl0VMY2
   ep/ES8/0eN1sXB/hbTSjN720mIzm+vjwYxxKsSfZNssvCNx90XaV+XBaq
   SHOTBDjJ89rS622gGs5pj//bmvWyWO0eqB2Mo7necOxFBu+c3tmKHAcoO
   HLITXEINoN+9bTQY66JOIecgu4BY4EdhOSXjRaITJ6LKdxtWhg9P4y8Sw
   wBOhixpN+m7zYICqmip/QHeVcZhl7nX0p50zvOGoLAzeOT+ADtEX5b1u0
   fed5Qia24MlKaXjd1iTQtviTyucdVphiN9uimM1HxDoTI/jDX8nTPcQdW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="439134250"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="439134250"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 12:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="688207661"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="688207661"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 12:06:02 -0700
Date:   Mon, 28 Aug 2023 12:06:01 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v4 7/7] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Message-ID: <ZOzwGQhGucBXZGO+@agluck-desk3>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-8-tony.luck@intel.com>
 <dc06f2ea-ed1e-60e5-f2d7-ccf7facde25b@intel.com>
 <ZOjrYB1UgtRchbXK@agluck-desk3>
 <f791d0e5-43b2-8ec2-436b-c008d2ce7696@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f791d0e5-43b2-8ec2-436b-c008d2ce7696@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:06:32AM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 8/25/2023 10:56 AM, Tony Luck wrote:
> > On Fri, Aug 11, 2023 at 10:33:43AM -0700, Reinette Chatre wrote:
> >> Hi Tony,
> >>
> >> On 7/22/2023 12:07 PM, Tony Luck wrote:
> 
> ...
> 
> >>> @@ -190,6 +245,8 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
> >>>  			break;
> >>>  	}
> >>>  
> >>> +	if (cache_num == 3)
> >>> +		*cache_size /= snc_ways();
> >>>  	return 0;
> >>>  }
> >>>  
> >>
> >> I am surprised that this small change is sufficient. The resctrl
> >> selftests are definitely not NUMA aware and the CAT and CMT tests
> >> are not taking that into account when picking CPUs to run on. From
> >> what I understand LLC occupancy counters need to be added in this
> >> scenario but I do not see that done either.
> > 
> > This is a first step (the tests are definitely going to fail if
> > they have incorrect information about the cache size).
> > 
> > For a fully reliable set of tests some major surgery will be required
> > to bind to CPUs and memory to control allocation and access.
> > 
> 
> What is the plan for making the tests more reliable? What is the
> use of this patch if it is just the first step?

Reinette,

I have no immediate plan to re-architect the the resctrl self-tests.
If you feel this step towards a solution is useless unless it is part
of a complete solution, then I can drop it from this series.

-Tony
