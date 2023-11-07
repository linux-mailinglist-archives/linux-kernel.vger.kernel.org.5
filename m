Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6707E4A65
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343890AbjKGVP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbjKGVPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:15:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220F392;
        Tue,  7 Nov 2023 13:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699391752; x=1730927752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tvrqr3gCoi7R07ZKXs6dBXJsySNmo1jfexcJRbjtD20=;
  b=Vvc68D6OiQmLNL1Ad0ZAf8HZFuiPgYywtEhwK6AQ47aHRZTC4pNCWv56
   RdmgJRlf46qrg+YiMQodmV23Ps5d/tXc+U2eGgljfPd5VC8EIcs8022yp
   FmMsXoM2VOSYABnLnKo//jzRVEXUU91S8L6rWEBAelCUfUYEHJC8TA032
   PSNnQFrIW41vakE/SYXOjTPgJJAHhy5fgM+Cu4BvWI4g46VoqIKnW/Qcr
   qAekZCSnW8jsrGKIIbk2OPotcLqggVhRWVZglyhi9ekzZD04EKuK7vanc
   zoJLDM5Qfp+6Ag2S/ash40lhrNUTbhwjuIqAmBrTtAS7VIUKwEyDsg0DE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2558705"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2558705"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 13:15:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="739278248"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="739278248"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 13:15:38 -0800
Date:   Tue, 7 Nov 2023 13:15:36 -0800
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
Subject: Re: [PATCH v3] x86/resctrl: mba_MBps: Fall back to total b/w if
 local b/w unavailable
Message-ID: <ZUqo+MsEQi2Xc/pO@agluck-desk3>
References: <20231025235046.12940-1-tony.luck@intel.com>
 <20231026200214.16017-1-tony.luck@intel.com>
 <0cee68e9-e188-46e9-83a8-02259a9c081f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cee68e9-e188-46e9-83a8-02259a9c081f@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 02:43:15PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 10/26/2023 1:02 PM, Tony Luck wrote:
> > On Intel the various resource director technology (RDT) features are all
> > orthogonal and independently enumerated. Thus it is possible to have
> > a system that  provides "total" memory bandwidth measurements without
> > providing "local" bandwidth measurements.
> 
> This motivation is written in support of Intel systems but from what I
> can tell the changes impact Intel as well as AMD.

If AMD were to build a system that did this, same fixes would be needed.

> > 
> > If local bandwidth measurement is not available, do not give up on
> > providing the "mba_MBps" feedback option completely, make the code fall
> > back to using total bandwidth.
> 
> It is interesting to me that the "fall back" is essentially a drop-in
> replacement without any adjustments to the data/algorithm.

The algorithm is, by necessity, very simple. Essentially "if measured
bandwidth is above desired target, apply one step extra throttling.
Reverse when bandwidth is below desired level." I'm not sure what tweaks
are possible.

> Can these measurements be considered equivalent? Could a user now perhaps
> want to experiment by disabling local bandwidth measurement to explore if
> system behaves differently when using total memory bandwidth? What
> would have a user choose one over the other (apart from when user
> is forced by system ability)?

This may be interesting. I dug around in the e-mail archives to see if
there was any discussion on why "local" was picked as the feedback
measurement rather that "total". But I couldn't find anything.

Thinking about it now, "total" feels like a better choice. Why would
you not care about off-package memory bandwidth? In pathological cases
all the memory traffic might be going off package, but the existing
mba_MBps algorithm would *reduce* the amount of throttling, eventually
to zero.

Maybe additional an mount option "mba_MBps_total" so the user can pick
total instead of local?

> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> > Change since v2:
> > 
> > Babu doesn't like the global variable. So here's a version without it.
> > 
> > Note that my preference is still the v2 version. But as I tell newbies
> > to Linux "Your job isn't to get YOUR patch upstream. You job is to get
> > the problem fixed.".  So taking my own advice I don't really mind
> > whether v2 or v3 is applied.
> > 
> >  arch/x86/kernel/cpu/resctrl/monitor.c  | 43 ++++++++++++++++++--------
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
> >  2 files changed, 31 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> > index f136ac046851..29e86310677d 100644
> > --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> > +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> > @@ -418,6 +418,20 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * For legacy compatibility use the local memory bandwidth to drive
> > + * the mba_MBps feedback control loop. But on platforms that do not
> > + * provide the local event fall back to use the total bandwidth event
> > + * instead.
> > + */
> > +static enum resctrl_event_id pick_mba_mbps_event(void)
> > +{
> > +	if (is_mbm_local_enabled())
> > +		return QOS_L3_MBM_LOCAL_EVENT_ID;
> > +
> > +	return QOS_L3_MBM_TOTAL_EVENT_ID;
> > +}
> 
> Can there be a WARN here to catch the unlikely event that
> !is_mbm_total_enabled()?
> This may mean the caller (in update_mba_bw()) needs to move
> to code protected by is_mbm_enabled().

All this code is under the protection of the check at mount time
done by supports_mba_mbps()

static bool supports_mba_mbps(void)
{
        struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;

        return (is_mbm_enabled() &&
                r->alloc_capable && is_mba_linear());
}

Adding even more run-time checks seems overkill.

> One option to consider is to have a single "get_mba_mbps_state()"
> call (similar to V1) that determines the eventid as above and
> then calls get_mbm_state() to return a pointer to mbm_state in one
> call. Starting to seem like nitpicking but I'd thought I'd mention it
> since it seemed a way to have V1 solution with request to use
> get_mbm_state() addressed.

It doesn't sound any better than the V3 approach.

> > +
> >  /*
> >   * mbm_bw_count() - Update bw count from values previously read by
> >   *		    __mon_event_count().
> > @@ -431,9 +445,11 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
> >   */
> >  static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
> >  {
> > -	struct mbm_state *m = &rr->d->mbm_local[rmid];
> > +	enum resctrl_event_id mba_mbps_evt_id = pick_mba_mbps_event();
> >  	u64 cur_bw, bytes, cur_bytes;
> > +	struct mbm_state *m;
> >  
> > +	m = get_mbm_state(rr->d, rmid, mba_mbps_evt_id);
> >  	cur_bytes = rr->val;
> >  	bytes = cur_bytes - m->prev_bw_bytes;
> >  	m->prev_bw_bytes = cur_bytes;
> 
> It should not be necessary to pick the event id again. It is available
> within the struct rmid_read parameter. 

So it is. I can drop the extra pick_mba_mbps_event() call here.

-Tony
