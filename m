Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C9B78E25B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343823AbjH3Wdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbjH3Wdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:33:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E361BF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693434808; x=1724970808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8/L/PFxdivB0WJisZaNCROLvCiEtHqm8cWTc4ukTnJU=;
  b=O/aOX7Y+aQHjE94O3DB1CQHznOAL+Bv5fJInASYtazc9v6IteW80NMcN
   Yau6p3Uo25E0xWXmfHkimAaVz52F2xhLHkBlPs4kmaKvJ/nbp0COjcAES
   fLTietepIgS/Ht9+2z8pOwOApf7II4naRh3bNYTdl8qREFz7z0PIH1NnC
   3DcdKcAdZ26JWe5nWONwyR85YEqNgs+0VzQdgXa9YuPELAD2Z32MtJaMf
   /5jG5cao8/MUaU6fumAtTw2FT+62YjhCRXXh43CnoLdAuhZXVOnn5xite
   3aozxwQzRZF/2xhssG5al2b30Z7PMBvVWx7UK9OAYMDPmqpyPDXqjp1h2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="378480955"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="378480955"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 15:32:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="829390726"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="829390726"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 15:32:43 -0700
Date:   Wed, 30 Aug 2023 15:32:42 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com
Subject: Re: [PATCH v5 06/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
Message-ID: <ZO/DiqemqXqj8P3u@agluck-desk3>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-7-james.morse@arm.com>
 <03cd7ac4-b58d-c7a8-7cb9-ebcc770d21f0@intel.com>
 <20b566d9-448b-5367-b4db-593466e7a2f8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20b566d9-448b-5367-b4db-593466e7a2f8@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 05:53:03PM +0100, James Morse wrote:
> Something on my eternal-todo-list is to make the filesystem parts of resctrl a loadable
> module (if Tony doesn't get there first!). That would flush this sort of thing out.
> Last time I triggered resctrl_exit() manually not all of the files got cleaned up - I
> haven't investigated it further.

James,

I looked at going to a full loadable module approach for about 3 seconds,
and found none of the kernfs support functions are exported. So I also
put that on the eternal-todo-list :-)

There are possibly a few other functions that need exporting like
get_cpu_cacheinfo(), and two or three others from the "perf"
code for pseudo-lock debugfs support.

-Tony

P.S. Latest version of my re-write is at:

https://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git/log/?h=resctrl2_v65rc7

Well, almost latest. I haven't pushed the changes to auto-load all the
modules for basic X86 functions based on X86_FEATURE_* bits.
