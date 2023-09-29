Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B27B7B3B49
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjI2Ugg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbjI2Ugf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:36:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A65F1AA;
        Fri, 29 Sep 2023 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696019793; x=1727555793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6RJ58gJGIttunNUtpzzHLytmZYmKvUXPL7IuLrvIBUU=;
  b=YvGSh99Vo708Rk2IptH09IErDh80u2ErnLI8yKHrmCIaFvQFbl/LpBm/
   2CsyY5wF/aBQXcCyAja+Oe42kTsqAJqWolrVK8xUiVG7u3qRKpdZolUcK
   GqpKPo/kvQmeepY8A7mw4iQhU0TmJMKZKxnAr0SH50oIFnvexDFK50CP6
   4Xeo6ZGefAAcxrtovndjmBa90r7A+mT9ejJYP4lFRyuGhm91lFSxlT036
   CLh3AQZJgeu95E/1j2TIWqs6yheQMKTOREcBIxvySbi3txygM9H3NOAkU
   5XEEzbutLaGbJwNk+uvjrxjp0mOiZUQWdNCwGa44+4iHoeYyKPYP4/pTx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="3934269"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="3934269"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 12:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="1081019174"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="1081019174"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 12:15:07 -0700
Date:   Fri, 29 Sep 2023 12:15:05 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Peter Newman <peternewman@google.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v6 3/8] x86/resctrl: Prepare for different scope for
 control/monitor operations
Message-ID: <ZRciOWSBuRuvZrKl@agluck-desk3>
References: <20230829234426.64421-1-tony.luck@intel.com>
 <20230928191350.205703-1-tony.luck@intel.com>
 <20230928191350.205703-4-tony.luck@intel.com>
 <CALPaoCgb35dGiC87e_cqTOXKKZ-nQcokWou+u=mC7m2gR36G8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALPaoCgb35dGiC87e_cqTOXKKZ-nQcokWou+u=mC7m2gR36G8w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 03:10:18PM +0200, Peter Newman wrote:
> Hi Tony,
> 
> On Thu, Sep 28, 2023 at 9:14 PM Tony Luck <tony.luck@intel.com> wrote:
> >
> > @@ -352,7 +355,7 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
> >  {
> >         struct rdt_domain *d;
> >
> > -       list_for_each_entry(d, &r->domains, hdr.list) {
> > +       list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
> 
> If someone were to call get_domain_from_cpu() looking for a
> mon_domain, I don't think they'd be happy with the result.

Indeed not. Type checking in "C" doesn't seem adequate to address this
(when using "container_of()" which blindly trusts the user provided the
right tyep/fieldname). I'm using the rdt_domain_hdr.type field to
provide necessary checks.

> 
> This problem seems adequately addressed by the next patch where a type
> mismatch on the return value would result.
> 
> In any case, perhaps the name could be updated to set expectations better.
> 
> 
> > @@ -549,44 +552,101 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
> >
> >         rdt_domain_reconfigure_cdp(r);
> >
> > -       if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> > +       if (domain_setup_ctrlval(r, d)) {
> >                 domain_free(hw_dom);
> >                 return;
> >         }
> >
> > -       if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> > +       list_add_tail(&d->hdr.list, add_pos);
> > +
> > +       err = resctrl_online_ctrl_domain(r, d);
> > +       if (err) {
> > +               list_del(&d->hdr.list);
> >                 domain_free(hw_dom);
> > +       }
> > +}
> > +
> > +static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
> > +{
> > +       int id = get_domain_id_from_scope(cpu, r->mon_scope);
> > +       struct list_head *add_pos = NULL;
> > +       struct rdt_hw_domain *hw_mondom;
> 
> It's still hw_dom in domain_add_cpu_ctrl(), so why hw_mondom here?

No good reason. I'll change it to "hw_dom".

> 
> 
> > @@ -3711,16 +3711,16 @@ static void domain_destroy_mon_state(struct rdt_domain *d)
> >         kfree(d->mbm_local);
> >  }
> >
> > -void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
> > +void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
> >  {
> >         lockdep_assert_held(&rdtgroup_mutex);
> >
> >         if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
> >                 mba_sc_domain_destroy(r, d);
> > +}
> >
> > -       if (!r->mon_capable)
> > -               return;
> > -
> > +void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
> > +{
> >         /*
> >          * If resctrl is mounted, remove all the
> >          * per domain monitor data directories.
> 
> We did a lockdep_assert_held(&rdtgroup_mutex) for both types before.
> Should we continue to do so here?

Yes. Added it.

> 
> 
> > --
> > 2.41.0
> >
> 
> In the resctrl2 prototype I complained that resctrl_resource was
> awkwardly disjoint in its support for control and monitoring
> groups[1]. In this patch, you seem to have already done most of the
> hard work in separating the control and monitoring functionality, so
> taking the next step and using a different structure to represent
> control and monitoring resources would further improve the code by
> statically typing monitoring and control resources, which would be
> less error-prone than run-time checks on the alloc_capable and
> mon_capable fields, which seem easy to forget.
> 
> I don't think this is necessary to complete SNC support, but it would
> give me confidence that there isn't a misplaced {alloc,mon}_capable
> check resulting in the wrong domain list being traversed. I will
> probably do this myself later if you don't.

Simple change. It's split between previous patch to add the field
and current patch to initialize and check.

> 
> Thanks!
> -Peter
> 
> [1] https://lore.kernel.org/all/CALPaoCj_oa=nATvOO_uysYvu+PdTQtd0pvssvm9_M1+fP-Z8JA@mail.gmail.com/

Thanks

-Tony
