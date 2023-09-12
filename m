Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FDE79D5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbjILQDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjILQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:02:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F8B10F1;
        Tue, 12 Sep 2023 09:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694534574; x=1726070574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U+a6QizW/Aulka1WQ2QT9P6hpcvGBSRq2JsjI2qWUjA=;
  b=fuJLYqQ4CeKUIhED8SGfE6McKliYiUm22MpYXEh/XS8yZSDRHTdd239s
   YjmxVKAlWsv55PxPhZzDm1oPXubzJ23eXtLMuB9g7WP7utH3DEZH+DM3c
   d9TfF4DilNAFWg4NYE3hBWCBrxUP7xZ9EpEMPp9QFuubFzjyh6yHy8Upu
   DlQyQhzOa9b2/bI6gW1V3frcswT8/0icfKfiAA6FVimNhRsec0OvllhBL
   Yy2pAE3Enkt9m/C3ONM7Ib9e5lLq5/Hab6IqBgjoiviqXWZkdlzxKDrS1
   TJ4c7nLMXnV/5zg6/uPcNxxHdT45Go0HdpeMgYoU27eC4yPYMrdWHjz1A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="363450044"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="363450044"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="1074597625"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="1074597625"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:01:18 -0700
Date:   Tue, 12 Sep 2023 09:01:17 -0700
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
Message-ID: <ZQCLTS0XAs/H2min@agluck-desk3>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <45e81506-3c43-95ba-56a4-38e1bb2e42dc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45e81506-3c43-95ba-56a4-38e1bb2e42dc@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 01:23:35PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 8/29/2023 4:44 PM, Tony Luck wrote:
> > The Sub-NUMA cluster feature on some Intel processors partitions
> > the CPUs that share an L3 cache into two or more sets. This plays
> > havoc with the Resource Director Technology (RDT) monitoring features.
> > Prior to this patch Intel has advised that SNC and RDT are incompatible.
> > 
> > Some of these CPU support an MSR that can partition the RMID
> > counters in the same way. This allows for monitoring features
> > to be used (with the caveat that memory accesses between different
> > SNC NUMA nodes may still not be counted accuratlely.
> 
> Same typo as in V4.

Sorry. Will fix and re-post.

> > 
> > Note that this patch series improves resctrl reporting considerably
> > on systems with SNC enabled, but there will still be some anomalies
> > for processes accessing memory from other sub-NUMA nodes.
> 
> I have the same question as with V4 that was not answered in that email
> thread nor in this new version.
> https://lore.kernel.org/lkml/e350514e-76ed-14ea-3e74-c0852658182f@intel.com/

Non-SNC systems already have an issue when reporting memory bandwidth
for a task that Linux may migrate the task to a CPU on a different node
which means that logging for that task will also move to different files
in the mon_data/mon_L3_*/ for the new node.

With SNC enabled, migration between NUMA nodes on the same socket may happen
much more frequently because:
1) The CPUs on the other NUMA nodes in the socket are in the same Linux
   L3 cache domain. So Linux regard the migration as "cheap".
2) The ACPI SLIT table on SNC enabled systems may also report the
   latency for remote access to another NUMA node on the same socket
   as significantly lower than the latency for cross-socket access. On
   my test system the SLIT distance for same socket nodes is 0xC,
   compared to 0x15 for cross-socket distance. This will also lead
   to Linux being more likely to migrate a task to a CPU on another
   SNC NUMA node in the same socket.

To avoid migration issues, users may use sched_setaffinity(2) to bind
tasks to the subset of CPUs that share an SNC NUMA node.

I can write this up in a new cover letter.

> I stop my review of this series here.

Reinette

Should I repost the whole series as v6 with the new cover letter. The
only change to the patches so far is to the selftest reported by
Shaopeng Tan[1].

-Tony

[1] https://lore.kernel.org/all/TYAPR01MB633033C489AAC0E514CBC6688BEEA@TYAPR01MB6330.jpnprd01.prod.outlook.com/
