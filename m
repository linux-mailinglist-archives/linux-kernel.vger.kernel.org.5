Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BFB7B3B99
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjI2Us0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjI2UsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:48:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FCE1AB;
        Fri, 29 Sep 2023 13:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696020499; x=1727556499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tXfZaIVeQzhgci4D2hG+Kx5EgnvkGliDQ/EynlWJjdo=;
  b=FOZTdSJa0BpiqhWLN0Vd46qxQ7pX8XkzUxhPnye+S+K2H56G8iP/8zt2
   keKlHZ4tDggQ5q1y90FoIDVeNCvL8eQnYRgp4qsUCqHHCBmw6UczmmAvt
   QXe4FPMqhQheJ2lXZiq58MLdHeoaNeOyYNaa4uWvcnRNU5f5jdOWI9uNv
   hFsdoit4lSh8+WGhZawCh1LZraUn7+QceyBcqM6tz2Jfa4x1SGYcPkHfs
   xPQgEdmfqb09o/IdeQ7RgSp0qLjmSNgbJ8QRODpfxS4RIRMb8JhasDQCB
   Y/fsA59ZBm2krrhdzrhNk0f6ibtBtOLhiSKHCE1rcQccxBCzM4Bx4qulD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="386239718"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="386239718"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:18:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="779369649"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="779369649"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:18:02 -0700
Date:   Fri, 29 Sep 2023 13:18:00 -0700
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
Subject: Re: [PATCH v6 6/8] x86/resctrl: Introduce snc_nodes_per_l3_cache
Message-ID: <ZRcw+OhDMelVq0D6@agluck-desk3>
References: <20230829234426.64421-1-tony.luck@intel.com>
 <20230928191350.205703-1-tony.luck@intel.com>
 <20230928191350.205703-7-tony.luck@intel.com>
 <CALPaoCh0dzx2T8-u5ZQXXM0XqaZgJbUAGnRVBmbzHmQiHjvWTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALPaoCh0dzx2T8-u5ZQXXM0XqaZgJbUAGnRVBmbzHmQiHjvWTA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 04:21:54PM +0200, Peter Newman wrote:
> Hi Tony,
> 
> On Thu, Sep 28, 2023 at 9:14 PM Tony Luck <tony.luck@intel.com> wrote:
> >
> > Intel Sub-NUMA Cluster (SNC) is a feature that subdivides the CPU cores
> > and memory controllers on a socket into two or more groups. These are
> > presented to the operating system as NUMA nodes.
> >
> > This may enable some workloads to have slightly lower latency to memory
> > as the memory controller(s) in an SNC node are electrically closer to the
> > CPU cores on that SNC node. This cost may be offset by lower bandwidth
> > since the memory accesses for each core can only be interleaved between
> > the memory controllers on the same SNC node.
> >
> > Resctrl monitoring on Intel system depends upon attaching RMIDs to tasks
> > to track L3 cache occupancy and memory bandwidth. There is an MSR that
> > controls how the RMIDs are shared between SNC nodes.
> >
> > The default mode divides them numerically. E.g. when there are two SNC
> > nodes on a socket the lower number half of the RMIDs are given to the
> > first node, the remainder to the second node. This would be difficult
> > to use with the Linux resctrl interface as specific RMID values assigned
> > to resctrl groups are not visible to users.
> >
> > The other mode divides the RMIDs and renumbers the ones on the second
> > SNC node to start from zero.
> >
> > Even with this redumbering SNC mode requires several changes in resctrl
> > behavior for correct operation.
> 
> redumbering? Harsh.

Spell check didn't catch this. Implies that redumbering is a real word!
Now I need to find an opportunity to use it :-)

Changed to renumbering.
> 
> 
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index b0901fb95aa9..a5404c412f53 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -1357,7 +1357,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
> >                 }
> >         }
> >
> > -       return size;
> > +       return size / snc_nodes_per_l3_cache;
> 
> To confirm, the size represented by a bit goes down rather than the
> CBM mask shrinking in each sub-NUMA domain?

Correct. The CBM mask keeps the same number of bits. Those bits are
all available to control allocation in each SNC node. But the amount
of cache you get per-bit is reduced in the ratio of the number of SNC
ways.

> 
> I would maybe have expected the CBM mask to already be allocating at
> the smallest granularity the hardware supports.
> 
> >  }
> >
> >  /**
> > @@ -2590,7 +2590,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >                 ctx->enable_cdpl2 = true;
> >                 return 0;
> >         case Opt_mba_mbps:
> > -               if (!supports_mba_mbps())
> > +               if (!supports_mba_mbps() || snc_nodes_per_l3_cache > 1)
> 
> Factor into supports_mba_mbps()?

Agreed. That's a better place. Moved this test into supports_mba_mbps().
> 
> >                         return -EINVAL;
> >                 ctx->enable_mba_mbps = true;
> >                 return 0;
> > --
> > 2.41.0
> >
> 
> Reviewed-by: Peter Newman <peternewman@google.com>

Thanks

-Tony
