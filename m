Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153A38014C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjLAUpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjLAUpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:45:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4268FF;
        Fri,  1 Dec 2023 12:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701463529; x=1732999529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yG0Y48woFZNswGTmBBWmxBZc/W1//0MjI/GiuILqv6k=;
  b=EYC718hv1rugfCcnKoczcZu27jVK0XsMYg8VZDwBK33p9qRlYwsGp3F5
   0OobgrRzOmI4hAHR8hwPrZN95VS3sAb8r31dE1m6cg6HwNxnLPg+ac0X6
   DB+bwOANfLg7Jo19qbOwddR5w8Vzjo5wdPJD6gwtrVW+hiFpDncUWfMB2
   zkfH8v4uz+YpvxUSyhlo1IfEj35mn2hsotcjpbiETgkOTq6nQjQBNyge1
   tngAXCrW03R/Gy4GrQF7vvm3O1Bm2/6WYSgTH3iUlYbd9e6DYyNE2iGm9
   cHp1U82KxrZWOXt08RhsQfO3zqTptX7qCFXZ6Nac504DHdcNbTLUl6sLG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="431731"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="431731"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 12:45:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="1101411470"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="1101411470"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 12:45:27 -0800
Date:   Fri, 1 Dec 2023 12:45:26 -0800
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
Subject: Re: [PATCH v4] x86/resctrl: Add mount option to pick total MBM event
Message-ID: <ZWpF5m4mIeZdK8kv@agluck-desk3>
References: <20231026200214.16017-1-tony.luck@intel.com>
 <20231128231439.81691-1-tony.luck@intel.com>
 <95a21b05-1838-4098-854f-f60f82f26f5f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95a21b05-1838-4098-854f-f60f82f26f5f@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:48:37PM -0800, Reinette Chatre wrote:
> Hi Tony,
> 
> On 11/28/2023 3:14 PM, Tony Luck wrote:
> > Add a "total" mount option to be used in conjunction with "mba_MBps"
> > to request use of the total memory bandwidth event as the feedback
> > input to the control loop.
> 
> "total" is very generic. It is also not clear to me why users
> would need to use two mount options. What if the new mount option
> is "mba_MBps_total" instead, without user needing to also provide
> "mba_MBps"? 

I wasn't attached to "total". I tried to change the type of the existing
"mba_MBps" option to fsparam_string_emtpy() in the hope that existing users
would be able to keep using "mba_MBps", and users who want to use total
bandwidth could use "mba_MBps=total". But that type requires the "="
in the string provided by the user for the "empty" case.

So now I'm experimenting with adding a new option:

	fsparam_string("mba_MBps_event", Opt_mba_mbps_event)

so a user would specify "mba_MBps_event=total" instead of "mba_MBps".
My code also allow for "mba_MBps_event=local" if a user want to ensure
they use the local bandwidth event (failing the mount if it is not
available).

Existing code using the legacy "mba_MBps" option will get local by
default, failing over to total if needed.

> > 
> > Also fall back to using the total event if the local event is not
> > supported by the CPU.
> > 
> > Update the once-per-second polling code to use the event (local
> > or total memory bandwidth).
> 
> Please take care to describe why this change is needed, not just
> what it does. This is required by x86. For confirmation:
> https://lore.kernel.org/lkml/20231009172517.GRZSQ3fT05LGgpcW35@fat_crate.local/

Yes. I had some justification in earlier versions, but lost it along the
way. I will include in next version.

> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> > 
> > Changes since v3:
> > 
> > Reinette suggested that users might like the option to use the total
> > memory bandwidth event. I tried out some code to make the event runtime
> > selectable via a r/w file in the resctrl/info directories. But that
> > got complicated because of the amount of state that needs to be updated
> > when switching events. Since there isn't a firm use case for user
> > selectable event, this latest version falls back to the far simpler
> > case of using a mount option.
> 
> (I did not realize that that discussion was over.)

I'd like to avoid too much feature creep in this series. I'd like to
finish solving the original problem (systems without local bandwidth
monitoring should have a way to use total bandwidth) before tackling
additional issues in a separate patch series. Taking on a simple way
for users to request total bandwidth isn't much extra code. Making
it possible to switch events at runtime isn't. Fixing the corner cases
where the feedback loop may get stuck is also a separate issue.

> > 
> >  Documentation/arch/x86/resctrl.rst     |  3 +++
> >  arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
> >  arch/x86/kernel/cpu/resctrl/monitor.c  | 20 +++++++++-----------
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 ++++++++++++++-
> >  4 files changed, 29 insertions(+), 12 deletions(-)
> > 
> > diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> > index a6279df64a9d..29c3e7137eb8 100644
> > --- a/Documentation/arch/x86/resctrl.rst
> > +++ b/Documentation/arch/x86/resctrl.rst
> > @@ -46,6 +46,9 @@ mount options are:
> >  "mba_MBps":
> >  	Enable the MBA Software Controller(mba_sc) to specify MBA
> >  	bandwidth in MBps
> > +"total":
> > +	Use total instead of local memory bandwidth to drive the
> > +	MBA Software Controller
> >  "debug":
> >  	Make debug files accessible. Available debug files are annotated with
> >  	"Available only with debug option".
> > diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> > index a4f1aa15f0a2..f98fc9adc2da 100644
> > --- a/arch/x86/kernel/cpu/resctrl/internal.h
> > +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> > @@ -59,6 +59,7 @@ struct rdt_fs_context {
> >  	bool				enable_cdpl2;
> >  	bool				enable_cdpl3;
> >  	bool				enable_mba_mbps;
> > +	bool				use_mbm_total;
> >  	bool				enable_debug;
> >  };
> 
> Why did you choose new member to not follow existing custom of having
> an enable_ prefix?

That does look awful. Next version will do this:

-       bool                            enable_mba_mbps;
+       bool                            enable_mba_mbps_local;
+       bool                            enable_mba_mbps_total;

> 
> >  
> > @@ -428,6 +429,8 @@ extern struct rdt_hw_resource rdt_resources_all[];
> >  extern struct rdtgroup rdtgroup_default;
> >  DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
> >  
> > +extern enum resctrl_event_id mba_mbps_evt_id;
> > +
> 
> This global seems unnecessary. struct resctrl_membw.mba_sc indicates if
> the software controller is enabled. Creating this global fragments
> related information.

Global is now gone.

> One option could be to change the type of struct resctrl_membw.mba_sc to
> enum resctrl_event_id. I assume that 0 would never be a valid event ID and
> can thus be used to know if the software controller is disabled. If this
> is done then enum resctrl_event_id's documentation should be updated
> with this assumption/usage.

But I'm not fond of this overloading the meaning of resctrl_membw.mba_sc
by making that assumption that "0" will never be a valid event.

I've left the mba_sc field as a boolean that indicates enabled and added
a new field for the event:

@@ -138,6 +139,7 @@ struct resctrl_membw {
        bool                            arch_needs_linear;
        enum membw_throttle_mode        throttle_mode;
        bool                            mba_sc;
+       enum resctrl_event_id           mba_mbps_event;
        u32                             *mb_map;
 };

New version will be posted soon.

-Tony
