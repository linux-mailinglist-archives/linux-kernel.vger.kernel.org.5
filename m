Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BEE788DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbjHYRNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjHYRNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:13:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80A1FFA;
        Fri, 25 Aug 2023 10:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692983587; x=1724519587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m4WgKbbZd0F2TvjQ89ax5kpXFdun78wONiOy5Zyzj3g=;
  b=BeEsDKYubJFQ7RIhxtECRU5QKj57PhXxI4IAnzVjqNVFovTRatmH2TD7
   eobsW/CUIuOM7nwWIhUNE3mUH7Ov+dTmP2Gd3GGvqdeLOxXOA0/oUHUJD
   1AsCbcw3XD5HO+iy1wjgIy7GgtbAZS3nfEHZ2u7J1rO3/Qls0Y313Wl5x
   HjGJsre6IR7BrgtKxKAOVSLli0JAN48wlGW5uggwhAb6d7SWANRjAgS/f
   7apu350ipW/tzw0pe+zkX9tuQry0iTGrbanCU8GHxscUd0hizYmBjhCAH
   aSiP2vzdxoA0mgvTjZssuiadqNOTiFndI3bPbvjaBDk7FrqzbaZzGNSDl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="378540928"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="378540928"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 10:13:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="984173265"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="984173265"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 10:13:05 -0700
Date:   Fri, 25 Aug 2023 10:13:04 -0700
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
Subject: Re: [PATCH v4 3/7] x86/resctrl: Change monitor code to use
 rdt_mondomain
Message-ID: <ZOjhIJNm0EjmDygL@agluck-desk3>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-4-tony.luck@intel.com>
 <17dbf847-bd91-08ae-7c1b-3278b000dc6f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17dbf847-bd91-08ae-7c1b-3278b000dc6f@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:30:20AM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 7/22/2023 12:07 PM, Tony Luck wrote:
> > A few functions need to be duplicated to provide versions to
> > operate on control and monitor domains respectively. But most
> > of the changes are just fixing argument and return value types.
> 
> Could you please add some context in support of this change?
> 
> I do not think "duplicated" is appropriate though. Functions
> are not duplicated but instead made to be dedicated to
> either control or monitoring domains, no?

Commit comment rewritten based on these suggestions

> 
> ...
> 
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index 274605aaa026..0161362b0c3e 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -393,9 +393,12 @@ void rdt_ctrl_update(void *arg)
> >   * id is found in a domain, return the domain. Otherwise, if requested by
> >   * caller, return the first domain whose id is bigger than the input id.
> >   * The domain list is sorted by id in ascending order.
> > + *
> > + * N.B. Returned value may be either a pointer to "struct rdt_domain" or
> > + * to "struct rdt_mondomain" depending on which domain list is scanned.
> >   */
> > -struct rdt_domain *rdt_find_domain(struct list_head *h, int id,
> > -				   struct list_head **pos)
> > +void *rdt_find_domain(struct list_head *h, int id,
> > +		      struct list_head **pos)
> >  {
> >  	struct rdt_domain *d;
> >  	struct list_head *l;
> 
> I do not think that void pointers should be passed around. How about two
> new functions dedicated to the different domain types with the void pointer
> handling contained in a static function? For example,
> 
> static void *__rdt_find_domain(struct list_head *h, int id, struct list_head **pos)
> 
> struct rdt_mondomain *rdt_find_mondomain(struct rdt_resource *r, int id, struct list_head **pos)
> struct rdt_domain *rdt_find_ctrldomain(struct rdt_resource *r, int id, struct list_head **pos)
> 
> rdt_find_mondomain() and rdt_find_ctrldomain() would be what callers use
> while they can be wrappers of __rdt_find_domain().

Good suggestion. Initial bits are in patch 1. Types changed later
after struct rdt_mondomain is added.

> 
> 
> > @@ -434,10 +437,15 @@ static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
> >  }
> >  
> >  static void domain_free(struct rdt_hw_domain *hw_dom)
> > +{
> > +	kfree(hw_dom->ctrl_val);
> > +	kfree(hw_dom);
> > +}
> > +
> > +static void mondomain_free(struct rdt_hw_mondomain *hw_dom)
> >  {
> >  	kfree(hw_dom->arch_mbm_total);
> >  	kfree(hw_dom->arch_mbm_local);
> > -	kfree(hw_dom->ctrl_val);
> >  	kfree(hw_dom);
> >  }
> >  
> > @@ -467,7 +475,7 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
> >   * @num_rmid:	The size of the MBM counter array
> >   * @hw_dom:	The domain that owns the allocated arrays
> >   */
> > -static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
> > +static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_mondomain *hw_dom)
> >  {
> >  	size_t tsize;
> >  
> > @@ -539,8 +547,8 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
> >  {
> >  	int id = get_cpu_cacheinfo_id(cpu, r->mon_scope);
> >  	struct list_head *add_pos = NULL;
> > -	struct rdt_hw_domain *hw_dom;
> > -	struct rdt_domain *d;
> > +	struct rdt_hw_mondomain *hw_mondom;
> > +	struct rdt_mondomain *d;
> >  	int err;
> >  
> 
> Please ensure that reverse fir tree order is maintained in all these changes.

Oops. Fixed this one and looked around for any others introduced by me.
> 
> Reinette

-Tony
