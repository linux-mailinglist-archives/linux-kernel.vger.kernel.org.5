Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC477588CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjGRW53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGRW51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:57:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD131EC;
        Tue, 18 Jul 2023 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689721046; x=1721257046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rJc0NzmfsRZFbIrbptbmIk0ORpaW6wO71dUz3gVykcg=;
  b=aCN1VZ9rZvTCIoBifs/BKq4NVuHfDvSK0C7QL4BxEfozmDg6s+DbDnPv
   dD8PJP5kwwlBY57+MqkinbZ+YVBF11qfV1YnlzIOtZriQjiuPic61JXKJ
   GpB9wgHIQVXpHPrCXHbIP1oSgOYRh9mw1ZawzKJbjw7w6Uj+656ldu7g/
   W/zKum9n092knH2cEdGE7qnfbBpFrSYQYla/tjvVeLQJsbkUoS/Dl7kcR
   847I1bYrPu/mOUD0bzeboGSaEZggc3i26uKn/9kj7czI4q046fkSgqKnV
   Qpz924+kN30YhTvj6wfzMecV5bdOKgahdUd9dTwl6cCpSvbUDIXojwxfY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="346630362"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="346630362"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 15:57:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="723800535"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="723800535"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 15:57:25 -0700
Date:   Tue, 18 Jul 2023 15:57:24 -0700
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
Subject: Re: [PATCH v3 3/8] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Message-ID: <ZLcY1MQr5/Ibnv7N@agluck-desk3>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230713163207.219710-4-tony.luck@intel.com>
 <769521ee-6907-1613-442f-e2915a8ea554@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <769521ee-6907-1613-442f-e2915a8ea554@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:40:32PM -0700, Reinette Chatre wrote:
> > +	[RDT_RESOURCE_NODE] =
> > +	{
> > +		.r_resctrl = {
> > +			.rid			= RDT_RESOURCE_NODE,
> > +			.name			= "L3",
> > +			.scope			= SCOPE_NODE,
> > +			.domains		= domain_init(RDT_RESOURCE_NODE),
> > +			.fflags			= 0,
> > +		},
> > +	},
> >  };
> 
> So the new resource has the same name, from user perspective,
> as RDT_RESOURCE_L3. From this perspective it thus seems to be a
> shadow of RDT_RESOURCE_L3 that is used as alternative for some properties
> of the actual RDT_RESOURCE_L3? This is starting to look as though this
> solution is wrenching itself into current architecture.
> 
> >From what I can tell the monitoring in SNC environment needs a different
> domain list because of the change in scope. What else is needed in the
> resource that is different from the existing L3 resource? Could the
> monitoring scope of a resource not instead be made distinct from its
> allocation scope? By default monitoring and allocation scope will be
> the same and thus use the same domain list but when SNC is enabled
> then monitoring uses a different domain list.

Answering this part first, because my choice here affects a bunch
of the code that also raised comments from you.

The crux of the issue is that when SNC mode is enabled the scope
for L3 monitoring functions changes to "node" scope, while the
scope of L3 control functions (CAT, CDP) remains at L3 cache scope.

My solution was to just create a new resource. But you have an
interesing alternate solution. Add an extra domain list to the
resource structure to allow creation of distinct domain lists
for this case where the scope for control and monitor functions
differs.

So change the resource structure like this:

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8334eeacfec5..01590aa59a67 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -168,10 +168,12 @@ struct rdt_resource {
 	bool			alloc_capable;
 	bool			mon_capable;
 	int			num_rmid;
-	int			cache_level;
+	int			ctrl_scope;
+	int			mon_scope;
 	struct resctrl_cache	cache;
 	struct resctrl_membw	membw;
-	struct list_head	domains;
+	struct list_head	ctrl_domains;
+	struct list_head	mon_domains;
 	char			*name;
 	int			data_width;
 	u32			default_ctrl;

and build/use separate domain lists for when this resource is
being referenced for allocation/monitoring. E.g. domain_add_cpu()
would check "r->alloc_capable" and add a cpu to the ctrl_domains
list based on the ctrl_scope value. It would do the same with
mon_capable / mon_domains / mon_scope.

If ctrl_scope == mon_scope, just build one list as you suggest above.

Maybe there are more places that walk the list of control domains than
walk the list of monitor domains. Need to audit this set:

$ git grep list_for_each.*domains -- arch/x86/kernel/cpu/resctrl
arch/x86/kernel/cpu/resctrl/core.c:     list_for_each_entry(d, &r->domains, list) {
arch/x86/kernel/cpu/resctrl/core.c:     list_for_each(l, &r->domains) {
arch/x86/kernel/cpu/resctrl/ctrlmondata.c:      list_for_each_entry(d, &r->domains, list) {
arch/x86/kernel/cpu/resctrl/ctrlmondata.c:      list_for_each_entry(d, &r->domains, list) {
arch/x86/kernel/cpu/resctrl/ctrlmondata.c:      list_for_each_entry(dom, &r->domains, list) {
arch/x86/kernel/cpu/resctrl/monitor.c:  list_for_each_entry(d, &r->domains, list) {
arch/x86/kernel/cpu/resctrl/pseudo_lock.c:              list_for_each_entry(d_i, &r->domains, list) {
arch/x86/kernel/cpu/resctrl/rdtgroup.c:         list_for_each_entry(dom, &r->domains, list)
arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(dom, &r->domains, list) {
arch/x86/kernel/cpu/resctrl/rdtgroup.c:         list_for_each_entry(d, &r->domains, list) {
arch/x86/kernel/cpu/resctrl/rdtgroup.c:         list_for_each_entry(d, &r->domains, list) {
arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(dom, &r->domains, list) {
arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(d, &r->domains, list) {
arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(d, &r_l->domains, list) {
arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(d, &r->domains, list) {
arch/x86/kernel/cpu/resctrl/rdtgroup.c:         list_for_each_entry(dom, &r->domains, list)
arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(d, &r->domains, list) {
arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(dom, &r->domains, list) {
arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(d, &s->res->domains, list) {
arch/x86/kernel/cpu/resctrl/rdtgroup.c: list_for_each_entry(d, &r->domains, list) {

Maybe "domains" can keep its name and make a "list_for_each_monitor_domain()" macro
to pick the right list to walk?


I don't think this will reduce the amount of code change in a
significant way. But it may be conceptually easier to follow
what is going on.

-Tony
