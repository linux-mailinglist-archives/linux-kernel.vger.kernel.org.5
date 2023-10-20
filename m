Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663647D0FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377288AbjJTMmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377155AbjJTMmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:42:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B28126
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697805751; x=1729341751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZS32j1eQY1Yi6SVLYpQrchRlTJGbASGZQz5j7O46Mxg=;
  b=b+sb3t9vukJA14GPvxN+LVR+oEL2NLiMBxUPtiCBG3n4pwg9oPYz6RC0
   5l+0bSCqGW1p4s2y2bTJ0Gmv2hsk1VyTcIGVn3Ol51dTVa0c/frc/pjIY
   tHQEHbt2EHu7e9nmHKQ/7wOFqhphY115lW71vSBxZPkHVvicv2J0Jm6Ci
   FXnQSJyEocw9hCnAGvWPlI3xs0tGwMrnsrzhtNrnL3O1MQhZMCHTKa1fv
   lPt2Ik7NrNtQjje4X78dxzUYvPZ2wYJ13gToAqxGYpu11MOddA0Lotzbo
   zuAZ3h6i9zeu/PNutVWsbZh7jY2gSMce9VKmIq6JdfeKZakd8ow1dgUeq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="452967098"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="452967098"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 05:42:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="931004423"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="931004423"
Received: from dgutows1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.237])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 05:42:23 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D971C10A1C7; Fri, 20 Oct 2023 15:42:20 +0300 (+03)
Date:   Fri, 20 Oct 2023 15:42:20 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 03/13] cpu/hotplug, x86/acpi: Disable CPU hotplug for
 ACPI MADT wakeup
Message-ID: <20231020124220.voezn7q72unnt2q6@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-4-kirill.shutemov@linux.intel.com>
 <9f9fef1eb387e6098ca762d10e9c2002296c89f6.camel@intel.com>
 <edcd14bce71326e168a4dc11e5f1771e6f623aa8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edcd14bce71326e168a4dc11e5f1771e6f623aa8.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 11:58:58AM +0000, Huang, Kai wrote:
> On Tue, 2023-10-10 at 10:24 +0000, Huang, Kai wrote:
> > >  /* Physical address of the Multiprocessor Wakeup Structure mailbox */
> > > @@ -74,6 +75,9 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> > >  
> > > 
> > >  	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
> > >  
> > > 
> > > +	/* Disable CPU onlining/offlining */
> > > +	cpu_hotplug_not_supported();
> > > +
> > 
> > Both onlining/offlining are prevented, or just offlining?
> > 
> > The previous patch says:
> > 
> > 	It does not prevent the initial bring up of the CPU, but it stops 
> > 	subsequent offlining.
> > 
> > And ...
> > 
> > [...]
> > 
> > 
> > > --- a/kernel/cpu.c
> > > +++ b/kernel/cpu.c
> > > @@ -1522,7 +1522,7 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
> > >  	 * If the platform does not support hotplug, report it explicitly to
> > >  	 * differentiate it from a transient offlining failure.
> > >  	 */
> > > -	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED) || !cpu_hotplug_supported)
> > > +	if (!cpu_hotplug_supported)
> > >  		return -EOPNOTSUPP;
> > >  	if (cpu_hotplug_disabled)
> > >  		return -EBUSY;
> > 
> > ... here cpu_down_maps_locked() only prevents offlining if I am reading
> > correctly.
> > 
> > Also, can we rename cpu_hotplug_supported to cpu_offline_supported to match the
> > behaviour better?
> > 
> > Anyway, isn't it a little bit odd to have:
> > 
> > 	if (!cpu_hotplug_supported)
> >  		return -EOPNOTSUPP;
> >  	if (cpu_hotplug_disabled)
> >  		return -EBUSY;
> > 
> > ?
> 
> I probably have missed something important, but I don't quite understand what's
> the reason to have the CC_ATTR_HOTPLUG_DISABLED at the beginning, and now
> replace it with cpu_hotplug_not_supported()?

CC_ATTR_HOTPLUG_DISABLED was a mistake. And now obvious when we only need
to disable offlining dynamically, based on supported MADT MP WP version.

> From the changelog:
> 
> 	Currently hotplug prevented based on the confidential computing
> 	attribute which is set for Intel TDX. But TDX is not the only possible
> 	user of the wake up method.
> 
> CC_ATTR_HOTPLUG_DISABLED is only used by TDX guest, but MADT can be used by non-
> TDX guest too.
> 
> Anyway, if the purpose is just to prevent CPU from going offline, can this be
> done by registering a cpuhp callback?
> 
> 	static int madt_wakeup_offline_cpu(unsigned int cpu)
> 	{
> 		return -EOPNOTSUPP;
> 	}
> 
> 	...
> 
> 	err = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "madt-wakeup",
> 			NULL, madt_wakeup_offline_cpu);
> 	if (err) {
> 		pr_err("Register CPU hotplug callback failed.\n");
> 		/* BUG() ??? */
> 	}
> 
> This doesn't pollute the common CPU hotplug code, thus to me looks more clear?

Thomas seems fine with cpu_hotplug_disable_offlining().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
