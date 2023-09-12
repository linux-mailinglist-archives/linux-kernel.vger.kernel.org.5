Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E522B79D7DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbjILRpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjILRpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:45:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E550310C9;
        Tue, 12 Sep 2023 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694540737; x=1726076737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CG1SbLvb2i8X0vM67LTH8RnhL6e9+zkf2JDJ8mw6STw=;
  b=IxnW4xBouY9ecHCXD6+E6beRY3nLH13iUQXewMzIEv0wFPIKiWYjY4TB
   W511j20qiOS0k4H1YwTh8OaNfLK8eSgV39aMrArO2jTPpDkrqxJ4wGVdg
   RWlVBnUq04CuQ7/UGo6NCp5b4dfdewLYhUAjJ4HGuHcG7s2Pd7DYlVUkk
   RbM63Uj3VzSsRyU48GwHlCggB6I7WWHGYb+ewf9x5uEka+Ns6cX0h54Hk
   OubS7adfGSqykU1aaCq9MTqDlbua5mEiKA+YGPuydeEmoLBthsXSzN/de
   vQmAdK1ocigY3Aq7PNvi12Wg5esuYLL92mAcd+nizN1FRSjaZTgS7WQO8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="377363183"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="377363183"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 10:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="809364292"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="809364292"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 10:45:14 -0700
Date:   Tue, 12 Sep 2023 10:45:13 -0700
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
Subject: Re: [PATCH v5 0/8] Add support for Sub-NUMA cluster (SNC) systems
Message-ID: <ZQCjqc4XJ4sxZARn@agluck-desk3>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <45e81506-3c43-95ba-56a4-38e1bb2e42dc@intel.com>
 <ZQCLTS0XAs/H2min@agluck-desk3>
 <0a59dce4-59f3-3d60-e06a-ef3e84e8c64c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a59dce4-59f3-3d60-e06a-ef3e84e8c64c@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:13:31AM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 9/12/2023 9:01 AM, Tony Luck wrote:
> > On Mon, Sep 11, 2023 at 01:23:35PM -0700, Reinette Chatre wrote:
> >> Hi Tony,
> >>
> >> On 8/29/2023 4:44 PM, Tony Luck wrote:
> >>> The Sub-NUMA cluster feature on some Intel processors partitions
> >>> the CPUs that share an L3 cache into two or more sets. This plays
> >>> havoc with the Resource Director Technology (RDT) monitoring features.
> >>> Prior to this patch Intel has advised that SNC and RDT are incompatible.
> >>>
> >>> Some of these CPU support an MSR that can partition the RMID
> >>> counters in the same way. This allows for monitoring features
> >>> to be used (with the caveat that memory accesses between different
> >>> SNC NUMA nodes may still not be counted accuratlely.
> >>
> >> Same typo as in V4.
> > 
> > Sorry. Will fix and re-post.
> > 
> >>>
> >>> Note that this patch series improves resctrl reporting considerably
> >>> on systems with SNC enabled, but there will still be some anomalies
> >>> for processes accessing memory from other sub-NUMA nodes.
> >>
> >> I have the same question as with V4 that was not answered in that email
> >> thread nor in this new version.
> >> https://lore.kernel.org/lkml/e350514e-76ed-14ea-3e74-c0852658182f@intel.com/
> > 
> > Non-SNC systems already have an issue when reporting memory bandwidth
> > for a task that Linux may migrate the task to a CPU on a different node
> > which means that logging for that task will also move to different files
> > in the mon_data/mon_L3_*/ for the new node.
> 
> It is not obvious to me that this is an issue. From what I understand
> the data remains accurate.
> 
> How does this map to the earlier "may still not be counted
> accurately"? 

Yes, the data is accurate. But a naive application reading the wrong
files from mon_data will not see the accurate data. Without SNC users
may only see this issue rarely as Linux tries hard to not migrate
processes to other NUMA nodes or L3 cache domains. But with SNC enabled
this is no longer the case. the ACPI SLIT distance of 0xC is below the
threshold that Linux checks for "is the target CPU for a migration far away"
so migration to other SNC nodes may be quite common.

I can move this out of the cover letter and provide guidance/warnings
in the patch to Documentation/arch/x86/resctrl.rst

> 
> > 
> > With SNC enabled, migration between NUMA nodes on the same socket may happen
> > much more frequently because:
> > 1) The CPUs on the other NUMA nodes in the socket are in the same Linux
> >    L3 cache domain. So Linux regard the migration as "cheap".
> > 2) The ACPI SLIT table on SNC enabled systems may also report the
> >    latency for remote access to another NUMA node on the same socket
> >    as significantly lower than the latency for cross-socket access. On
> >    my test system the SLIT distance for same socket nodes is 0xC,
> >    compared to 0x15 for cross-socket distance. This will also lead
> >    to Linux being more likely to migrate a task to a CPU on another
> >    SNC NUMA node in the same socket.
> > 
> > To avoid migration issues, users may use sched_setaffinity(2) to bind
> > tasks to the subset of CPUs that share an SNC NUMA node.
> > 
> > I can write this up in a new cover letter.
> > 
> >> I stop my review of this series here.
> > 
> > Reinette
> > 
> > Should I repost the whole series as v6 with the new cover letter. The
> > only change to the patches so far is to the selftest reported by
> > Shaopeng Tan[1].
> > 
> 
> Is this an assurance that the cover letter in no way reflects how 
> feedback was addressed in the rest of this series?

My track record here is far from perfect. I believe I addressed all
the issues you raised. But it's very possible that I may have missed
some, or misintepreted the concerns you raised.

> 
> Reinette

-Tony
