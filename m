Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FFE7E5E75
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjKHTTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjKHTTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:19:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D17210E;
        Wed,  8 Nov 2023 11:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699471180; x=1731007180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9LP5XzsexOTRXF8If2u9iDZg0YN5GJpyCU4qN42T1QY=;
  b=eviq/k9LPhVcTii1OITJOUS0ntBXtTF2ll3vzkbumC7Lmrugxvh27JXG
   /+PF1wIxedc/kZPoXyXJV312GAo+q4495ltXVTGK0aBo2EPPHmqhD+hza
   D8B7A99lrbfL4J2fbNg3lItPvcj1854Xm4ilgITfafXnHX9Jc7tnLvXPq
   YXnp2cnc2xBJAfCXA3CizIkihjIVtnypGwQK8Yyrv3LcP1W+nbY6xsyiu
   gBmqnNXD3cqrnAKJuWqF8SVH5UhD8o41BDkbMKhUNC2Ut2qGyskGvhBZr
   M63a33whpaZR0H4wIyFftzcLYH92T3WRZcMdGxurnG747pK/8D9nK6/eo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="454142437"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="454142437"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:19:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="766735234"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="766735234"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 11:19:39 -0800
Date:   Wed, 8 Nov 2023 11:19:37 -0800
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
Subject: Re: [PATCH v10 4/8] x86/resctrl: Split the rdt_domain and
 rdt_hw_domain structures
Message-ID: <ZUvfSbnOY+niAr+e@agluck-desk3>
References: <20231020213100.123598-1-tony.luck@intel.com>
 <20231031211708.37390-1-tony.luck@intel.com>
 <20231031211708.37390-5-tony.luck@intel.com>
 <51332bf8-d641-4a89-bcec-60b849fc6a34@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51332bf8-d641-4a89-bcec-60b849fc6a34@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 04:32:56PM -0800, Reinette Chatre wrote:
> Hi Tony,
> 
> On 10/31/2023 2:17 PM, Tony Luck wrote:
> > The same rdt_domain structure is used for both control and monitor
> > functions. But this results in wasted memory as some of the fields are
> > only used by control functions, while most are only used for monitor
> > functions.
> > 
> > Split into separate rdt_ctrl_domain and rdt_mon_domain structures with
> > just the fields required for control and monitoring respectively.
> > 
> > Similar split of the rdt_hw_domain structure into rdt_hw_ctrl_domain
> > and rdt_hw_mon_domain.
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> > Changes since v9
> > Comment against patch 4, but now fixed in patch #2. cpu_mask
> > is included in common header.
> > 
> >  include/linux/resctrl.h                   | 50 +++++++------
> >  arch/x86/kernel/cpu/resctrl/internal.h    | 60 ++++++++++------
> >  arch/x86/kernel/cpu/resctrl/core.c        | 87 ++++++++++++-----------
> >  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 32 ++++-----
> >  arch/x86/kernel/cpu/resctrl/monitor.c     | 40 +++++------
> >  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 +-
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 62 ++++++++--------
> >  7 files changed, 184 insertions(+), 153 deletions(-)
> > 
> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index 35e700edc6e6..36503e8870cd 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -72,7 +72,25 @@ struct rdt_domain_hdr {
> >  };
> >  
> >  /**
> > - * struct rdt_domain - group of CPUs sharing a resctrl resource
> > + * struct rdt_ctrl_domain - group of CPUs sharing a resctrl control resource
> > + * @hdr:		common header for different domain types
> > + * @cpu_mask:		which CPUs share this resource
> > + * @plr:		pseudo-locked region (if any) associated with domain
> > + * @staged_config:	parsed configuration to be applied
> > + * @mbps_val:		When mba_sc is enabled, this holds the array of user
> > + *			specified control values for mba_sc in MBps, indexed
> > + *			by closid
> > + */
> > +struct rdt_ctrl_domain {
> > +	struct rdt_domain_hdr		hdr;
> > +	struct cpumask			cpu_mask;
> 
> This patch did not change what it said it changed.

Reinette,

I'm not sure of the problem. The commit said the patch is splitting the
rdt_domain structure into rdt_ctrl_domain and rdt_mon_domain.

The piece of the patch where you gave this comment changed like this:

------- Before -------
/**
 * struct rdt_domain - group of CPUs sharing a resctrl resource
 * @hdr:		common header for different domain types
 * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
 * @mbm_total:		saved state for MBM total bandwidth
 * @mbm_local:		saved state for MBM local bandwidth
 * @mbm_over:		worker to periodically read MBM h/w counters
 * @cqm_limbo:		worker to periodically read CQM h/w counters
 * @mbm_work_cpu:	worker CPU for MBM h/w counters
 * @cqm_work_cpu:	worker CPU for CQM h/w counters
 * @plr:		pseudo-locked region (if any) associated with domain
 * @staged_config:	parsed configuration to be applied
 * @mbps_val:		When mba_sc is enabled, this holds the array of user
 *			specified control values for mba_sc in MBps, indexed
 *			by closid
 */
struct rdt_domain {
	struct rdt_domain_hdr		hdr;
	unsigned long			*rmid_busy_llc;
	struct mbm_state		*mbm_total;
	struct mbm_state		*mbm_local;
	struct delayed_work		mbm_over;
	struct delayed_work		cqm_limbo;
	int				mbm_work_cpu;
	int				cqm_work_cpu;
	struct pseudo_lock_region	*plr;
	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
	u32				*mbps_val;
};
------- After -------
/**
 * struct rdt_ctrl_domain - group of CPUs sharing a resctrl control resource
 * @hdr:		common header for different domain types
 * @cpu_mask:		which CPUs share this resource
 * @plr:		pseudo-locked region (if any) associated with domain
 * @staged_config:	parsed configuration to be applied
 * @mbps_val:		When mba_sc is enabled, this holds the array of user
 *			specified control values for mba_sc in MBps, indexed
 *			by closid
 */
struct rdt_ctrl_domain {
	struct rdt_domain_hdr		hdr;
	struct cpumask			cpu_mask;
	struct pseudo_lock_region	*plr;
	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
	u32				*mbps_val;
};

/**
 * struct rdt_mon_domain - group of CPUs sharing a resctrl control resource
 * @hdr:		common header for different domain types
 * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
 * @mbm_total:		saved state for MBM total bandwidth
 * @mbm_local:		saved state for MBM local bandwidth
 * @mbm_over:		worker to periodically read MBM h/w counters
 * @cqm_limbo:		worker to periodically read CQM h/w counters
 * @mbm_work_cpu:	worker CPU for MBM h/w counters
 * @cqm_work_cpu:	worker CPU for CQM h/w counters
 */
struct rdt_mon_domain {
	struct rdt_domain_hdr		hdr;
	unsigned long			*rmid_busy_llc;
	struct mbm_state		*mbm_total;
	struct mbm_state		*mbm_local;
	struct delayed_work		mbm_over;
	struct delayed_work		cqm_limbo;
	int				mbm_work_cpu;
	int				cqm_work_cpu;
};
-----

Which to my eyes looks like exactly what the commit comment says I
was going to do the in this patch. The old rdt_domain structure has
been replaced with two structures, with names as described in the commit
comment. The fields of the orginal structure have been distributed
betweeen the two new structures based on whether they are used for
control or monitor functions.


What am I missing? (Apart from a silly cut & paste error in the comments
that I just noticed and will fix now).

-Tony
