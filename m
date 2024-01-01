Return-Path: <linux-kernel+bounces-13958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6FC8215E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 00:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8769EB211D1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 23:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26639EAD4;
	Mon,  1 Jan 2024 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhYoCEIZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412AF9C3;
	Mon,  1 Jan 2024 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704150664; x=1735686664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UfoigrsgWZw1qwRV1NPochIPQ0OH+itXFklI76nBwvQ=;
  b=OhYoCEIZRVA9fxguImnqLpHXw4uDQ30oob7OydWlfqz4ky8qHdrqMtJH
   mp1SlFAkVTFAT0GFLD5N8zQK2Nc/Zv0vhAL8mP32uT+zju+a68kzjSBn/
   +0rpIMPv/wKZw8XTBdFjW9w1tbFJEDOXJdJkHzU3raArZMSo8/Cw42zxE
   pnCmfGu1SCoFqcOZxL5NK/B+NJCJmDKQnoFNFoNebktdzdDL/dMnumG1Y
   jAFlfEZ/LSViIEo8Xfjrn/oGAHz2pO+PIQPJG+V1CqzeTdIU9DQMcoIDS
   KJXVD0RKTU1nwmGA89iDzkRVjurtf7FxI37nn2SQdsxz06PgiHIJ0/e4q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="399588091"
X-IronPort-AV: E=Sophos;i="6.04,323,1695711600"; 
   d="scan'208";a="399588091"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 15:11:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="1110880998"
X-IronPort-AV: E=Sophos;i="6.04,323,1695711600"; 
   d="scan'208";a="1110880998"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 15:11:02 -0800
Date: Mon, 1 Jan 2024 15:12:41 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 1/4] thermal: intel: hfi: Refactor enabling code into
 helper functions
Message-ID: <20240101231240.GA8281@ranerica-svr.sc.intel.com>
References: <20231227062940.10780-1-ricardo.neri-calderon@linux.intel.com>
 <20231227062940.10780-2-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0iTaoiWWxueysmgx_SxqLZB0iODqSMX0vht9n8r_MC=KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iTaoiWWxueysmgx_SxqLZB0iODqSMX0vht9n8r_MC=KA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Dec 29, 2023 at 06:22:25PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 27, 2023 at 7:28 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > In preparation to add a suspend notifier, wrap the logic to enable HFI and
> > program its memory buffer into helper functions. Both the CPU hotplug
> > callback and the suspend notifier will use it.
> 
> No functional impact?

Thank you for your review!

Correct. There is no functional impact. I will update the commit message
in my next version.

> 
> > Cc: Chen Yu <yu.c.chen@intel.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: stable@vger.kernel.org
> 
> Please don't CC stable@vger on patch submissions, although you may add
> a Cc: stable tag without actually CCing it for my information, but in
> that case please add a full tag including the earliest stable series
> the patch is intended to apply to.

I see. Sure Rafael, I can do this.

> 
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  drivers/thermal/intel/intel_hfi.c | 46 +++++++++++++++++--------------
> >  1 file changed, 25 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > index c69db6c90869..87ac7b196981 100644
> > --- a/drivers/thermal/intel/intel_hfi.c
> > +++ b/drivers/thermal/intel/intel_hfi.c
> > @@ -347,6 +347,25 @@ static void init_hfi_instance(struct hfi_instance *hfi_instance)
> >         hfi_instance->data = hfi_instance->hdr + hfi_features.hdr_size;
> >  }
> >
> > +static void hfi_enable(void)
> > +{
> > +       u64 msr_val;
> > +
> > +       rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
> > +       msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
> > +       wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
> > +}
> > +
> > +static void hfi_set_hw_table(struct hfi_instance *hfi_instance)
> > +{
> > +       phys_addr_t hw_table_pa;
> > +       u64 msr_val;
> > +
> > +       hw_table_pa = virt_to_phys(hfi_instance->hw_table);
> > +       msr_val = hw_table_pa | HW_FEEDBACK_PTR_VALID_BIT;
> > +       wrmsrl(MSR_IA32_HW_FEEDBACK_PTR, msr_val);
> > +}
> > +
> >  /**
> >   * intel_hfi_online() - Enable HFI on @cpu
> >   * @cpu:       CPU in which the HFI will be enabled
> > @@ -364,8 +383,6 @@ void intel_hfi_online(unsigned int cpu)
> >  {
> >         struct hfi_instance *hfi_instance;
> >         struct hfi_cpu_info *info;
> > -       phys_addr_t hw_table_pa;
> > -       u64 msr_val;
> >         u16 die_id;
> >
> >         /* Nothing to do if hfi_instances are missing. */
> > @@ -403,14 +420,16 @@ void intel_hfi_online(unsigned int cpu)
> >         /*
> >          * Hardware is programmed with the physical address of the first page
> >          * frame of the table. Hence, the allocated memory must be page-aligned.
> > +        *
> > +        * Some processors do not forget the initial address of the HFI table
> > +        * even after having been reprogrammed. Keep using the same pages. Do
> > +        * not free them.
> 
> This comment change does not seem to belong to this patch.  I guess it
> needs to go to one of the subsequent patches?

My intention was is to relocate here the comment I deleted in the
subsequent hunk (after some rewording). Sure, I can put this comment in
patch 3/4, which deals with disabling HFI.
 
> 
> >          */
> >         hfi_instance->hw_table = alloc_pages_exact(hfi_features.nr_table_pages,
> >                                                    GFP_KERNEL | __GFP_ZERO);
> >         if (!hfi_instance->hw_table)
> >                 goto unlock;
> >
> > -       hw_table_pa = virt_to_phys(hfi_instance->hw_table);
> > -
> >         /*
> >          * Allocate memory to keep a local copy of the table that
> >          * hardware generates.
> > @@ -420,16 +439,6 @@ void intel_hfi_online(unsigned int cpu)
> >         if (!hfi_instance->local_table)
> >                 goto free_hw_table;
> >
> > -       /*
> > -        * Program the address of the feedback table of this die/package. On
> > -        * some processors, hardware remembers the old address of the HFI table
> > -        * even after having been reprogrammed and re-enabled. Thus, do not free
> > -        * the pages allocated for the table or reprogram the hardware with a
> > -        * new base address. Namely, program the hardware only once.
> > -        */
> > -       msr_val = hw_table_pa | HW_FEEDBACK_PTR_VALID_BIT;
> > -       wrmsrl(MSR_IA32_HW_FEEDBACK_PTR, msr_val);
> > -
> >         init_hfi_instance(hfi_instance);
> >
> >         INIT_DELAYED_WORK(&hfi_instance->update_work, hfi_update_work_fn);
> > @@ -438,13 +447,8 @@ void intel_hfi_online(unsigned int cpu)
> >
> >         cpumask_set_cpu(cpu, hfi_instance->cpus);
> >
> > -       /*
> > -        * Enable the hardware feedback interface and never disable it. See
> > -        * comment on programming the address of the table.
> > -        */
> > -       rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
> > -       msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
> > -       wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
> > +       hfi_set_hw_table(hfi_instance);
> > +       hfi_enable();
> >
> >  unlock:
> >         mutex_unlock(&hfi_instance_lock);
> > --

