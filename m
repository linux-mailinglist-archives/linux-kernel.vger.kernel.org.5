Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6897EA317
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 19:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjKMSwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 13:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMSwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 13:52:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D8310EC;
        Mon, 13 Nov 2023 10:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699901528; x=1731437528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r39Ku0xlX347d/TvksU4tDQXuXoO+3UlsSCTAY3iVW8=;
  b=G7yFJlqVsTWCXvw048BUDCssyWVmsal3gcTKLInZMtYP+wV/zyF7m98c
   di8k26UyqG5YXC4zVh/WFk3Zm1nlXPFBw7LYKJ0O7xgi6Sh3pqdbCSrWw
   ptbRI1ZRhaa4+L88gw38F5E6E/tnwtGPRezLmfxcxh9xe7EqpA7Kfdswr
   p8h/8NJ9Z1dLZhF48MkzML0UZdiYEzx7jc1L03G2BfEA9fOujwAl16Bat
   wsCPr2tIw9/EQKz2AE6MfOaGogH/kpjxrlnvNIY7z59aw58NMmhzNxlF6
   oJxF6a7E5y2deonewU6cTVcqw8HRHyjTaVcqcY0R92zrtyMh+i2Yyd98p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="393354716"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="393354716"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 10:52:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1095829967"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1095829967"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 10:52:07 -0800
Date:   Mon, 13 Nov 2023 10:52:06 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     "Moger, Babu" <babu.moger@amd.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v11 2/8] x86/resctrl: Prepare to split rdt_domain
 structure
Message-ID: <ZVJwVs5ayxKzC5pX@agluck-desk3>
References: <20231031211708.37390-1-tony.luck@intel.com>
 <20231109230915.73600-1-tony.luck@intel.com>
 <20231109230915.73600-3-tony.luck@intel.com>
 <678ea7e8-e4e5-4848-b77c-a94a1d326f5b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678ea7e8-e4e5-4848-b77c-a94a1d326f5b@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 12:08:19PM -0600, Moger, Babu wrote:
> Hi Tony,
> 
> Sorry for the late review. The patches look good for the most part. But we
> can simplify a little more. Please see my comments below.
> 
> 
> On 11/9/23 17:09, Tony Luck wrote:
> > The rdt_domain structure is used for both control and monitor features.
> > It is about to be split into separate structures for these two usages
> > because the scope for control and monitoring features for a resource
> > will be different for future resources.
> > 
> > To allow for common code that scans a list of domains looking for a
> > specific domain id, move all the common fields ("list", "id", "cpu_mask")
> > into their own structure within the rdt_domain structure.
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  include/linux/resctrl.h                   | 16 ++++--
> >  arch/x86/kernel/cpu/resctrl/core.c        | 26 +++++-----
> >  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 22 ++++-----
> >  arch/x86/kernel/cpu/resctrl/monitor.c     | 10 ++--
> >  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 14 +++---
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 60 +++++++++++------------
> >  6 files changed, 78 insertions(+), 70 deletions(-)
> > 
> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index 7d4eb7df611d..c4067150a6b7 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -53,10 +53,20 @@ struct resctrl_staged_config {
> >  };
> >  
> >  /**
> > - * struct rdt_domain - group of CPUs sharing a resctrl resource
> > + * struct rdt_domain_hdr - common header for different domain types
> >   * @list:		all instances of this resource
> >   * @id:			unique id for this instance
> >   * @cpu_mask:		which CPUs share this resource
> > + */
> > +struct rdt_domain_hdr {
> > +	struct list_head		list;
> > +	int				id;
> > +	struct cpumask			cpu_mask;
> > +};
> 
> I like the idea of separating the domains, one for control and another for
> monitor. I have some comments on how it can be done to simplify the code.
> Adding the hdr adds a little complexity to the code.
> 
> How about converting the current rdt_domain to explicitly to rdt_mon_domain?
> 
> Something like this.
> 
> struct rdt_mon_domain {
>         struct list_head                list;
>         int                             id;
>         struct cpumask                  cpu_mask;
>         unsigned long                   *rmid_busy_llc;
>         struct mbm_state                *mbm_total;
>         struct mbm_state                *mbm_local;
>         struct delayed_work             mbm_over;
>         struct delayed_work             cqm_limbo;
>         int                             mbm_work_cpu;
>         int                             cqm_work_cpu;
> };
> 
> 
> Then introduce rdt_ctrl_domain to which separates into two doamins.
> 
> struct rdt_ctrl_domain {
>         struct list_head                list;
>         int                             id;
>         struct cpumask                  cpu_mask;
>         struct pseudo_lock_region       *plr;
>         struct resctrl_staged_config    staged_config[CDP_NUM_TYPES];
>         u32                             *mbps_val;
> };
> 
> I feel this will be easy to understand and makes the code simpler. Changes
> will be minimal.

Babu,

I went in this direction because of rdt_find_domain() which is used
to search either of the "ctrl" or "mon" lists. So it needs to be sure
that the "list" and "id" fields are at identical offsets in both the
rdt_ctrl_domain and rdt_mon_domain structures. Best way to guarantee[1]
that is to create the "hdr" entry (which later acquired the cpu_mask
field as a common element after a comment from Reinette).

One way to avoid this would be to essentially duplicate
rdt_find_domain() into rdt_find_ctrl_domain() and rdt_find_mon_domain()
... but I fear the function is just big enough to get complaints
that the two copies should somehow be merged.

-Tony

[1] In v5 I tried using a comment in each to say they must be the same,
but Reinette didn't like comments within declarations:
https://lore.kernel.org/all/5f1256d3-737e-a447-abbe-f541767b2c8f@intel.com/
