Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5527734E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 01:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjHGXVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 19:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjHGXVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 19:21:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83268121
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 16:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691450474; x=1722986474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MW1RL2mb5XewuhxxaL7Gc11E1DDyvPjXs3PuxFsltlA=;
  b=BeB13SW9hKvzUDzJ19Gkijv6xkRXA6dC0xXFBIqoB23un19fNd29DNZ9
   Zs1aYBWvLXe0lu4BFayeg+dLz3dADMacZoZ7co84MfhdcoltVQbns73yD
   aYpMyOT4LwdQFcZl1nMFSrRYWeKEhW+3OClWHcMBDWm4m80ohJHFRpozQ
   Q0fSzGRAshN4NrbhFneGhwix/9yAYNLbIlPvVhgBPvwQh2U/fmmMdpA1f
   HrWxCcI01n91J7k2HXT1z1aaDp/F75R0aTyLA0OIPwwyiFcG9+7W9MEc3
   gXgZHl7KpjhjtRaMBGtRQfXJv031YjSPsjnyLpGpovD8z22c3Vdrb2a7X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401634200"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="401634200"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 16:21:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1061758805"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="1061758805"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2023 16:21:13 -0700
Date:   Mon, 7 Aug 2023 16:23:46 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Radu Rendec <rrendec@redhat.com>, linux-kernel@vger.kernel.org,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] cacheinfo: Add arch specific early level
 initializer
Message-ID: <20230807232346.GB18573@ranerica-svr.sc.intel.com>
References: <20230412185759.755408-1-rrendec@redhat.com>
 <20230412185759.755408-2-rrendec@redhat.com>
 <20230510191207.GA18514@ranerica-svr.sc.intel.com>
 <20230515093608.etfprpqn3lmgybe6@bogus>
 <20230518012703.GA19967@ranerica-svr.sc.intel.com>
 <20230518093414.qhwyogcig4wv3r5s@bogus>
 <20230531122201.3n3ak5n3cjisbmtm@bogus>
 <20230531170336.GA22753@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531170336.GA22753@ranerica-svr.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 10:03:36AM -0700, Ricardo Neri wrote:
> On Wed, May 31, 2023 at 01:22:01PM +0100, Sudeep Holla wrote:
> > On Thu, May 18, 2023 at 10:34:14AM +0100, Sudeep Holla wrote:
> > > On Wed, May 17, 2023 at 06:27:03PM -0700, Ricardo Neri wrote:
> > > > On Mon, May 15, 2023 at 10:36:08AM +0100, Sudeep Holla wrote:
> > > > > On Wed, May 10, 2023 at 12:12:07PM -0700, Ricardo Neri wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > I had posted a patchset[1] for x86 that initializes
> > > > > > ci_cacheinfo(cpu)->num_leaves during SMP boot.
> > > > > >
> > > > > 
> > > > > It is entirely clear to me if this is just a clean up or a fix to some
> > > > > issue you faced ? Just wanted to let you know Prateek from AMD has couple
> > > > > of fixes [2]
> > > > 
> > > > My first patch is a bug fix. The second patch is clean up that results
> > > > from fixing the bug in patch 1.
> > > > 
> > > > > 
> > > > > > This means that early_leaves and a late cache_leaves() are equal but
> > > > > > per_cpu_cacheinfo(cpu) is never allocated. Currently, x86 does not use
> > > > > > fetch_cache_info().
> > > > > > 
> > > > > > I think that we should check here that per_cpu_cacheinfo() has been allocated to
> > > > > > take care of the case in which early and late cache leaves remain the same:
> > > > > > 
> > > > > > -       if (cache_leaves(cpu) <= early_leaves)
> > > > > > +       if (cache_leaves(cpu) <= early_leaves && per_cpu_cacheinfo(cpu))
> > > > > > 
> > > > > > Otherwise, in v6.4-rc1 + [1] I observe a NULL pointer dereference from
> > > > > > last_level_cache_is_valid().
> > > > > >
> > > > > 
> > > > > I think this is different issue as Prateek was just observing wrong info
> > > > > after cpuhotplug operations. But the patches manage the cpumap_populated
> > > > > state better with the patches. Can you please look at that as weel ?
> > > > 
> > > > I verified that the patches from Prateek fix a different issue. I was able
> > > > to reproduce his issue. His patches fixes it.
> > > > 
> > > > I still see my issue after applying Prateek's patches.
> > > 
> > > Thanks, I thought it is different issue and good that you were able to test
> > > them as well. Please post a proper patch for the NULL ptr dereference you
> > > are hitting on x86.
> > 
> > Gentle ping! Are you still observing NULL ptr dereference with v6.4-rcx ?
> 
> Yes, I still observe it on v6.4-rc4.
> 
> > If so, can you please post the fix as a proper patch ? Some of the patches
> > in v6.4-rc1 are being backported, so I prefer to have all the known issues
> > fixed before that happens. Sorry for the nag, but backport is the reason
> > I am pushing for this.
> 
> Sure. Sorry for the delay. I have the patch ready and post this week. I
> will post it as part my previous patches in [1].

I at last posted the patchet, Sudeep. You can take a look here:
https://lore.kernel.org/all/20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com/

Sorry for the delay. I had to jump through various hoops before posting.

Thanks and BR,
Ricardo
