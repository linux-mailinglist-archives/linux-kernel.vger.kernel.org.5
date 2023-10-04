Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814147B8C85
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbjJDTFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244791AbjJDTER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:04:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DBA7EEA;
        Wed,  4 Oct 2023 11:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696445992; x=1727981992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fzPcpJVZz9br5RdOdTr7Z5LOCjD6verBS62r27PlbE8=;
  b=ExWXGyeSsIcFynvcm+JYjRfh0Tl5OGwHLUAhDlWVsXkYm4wQldG1EvEk
   kTAbs71TKDa5AhikbhDZ6qnyKpSfOtzLGhmq7ezaD/57/xNarmhMFv6e9
   NKJm3COiavIz6K3jFa1PqX9oPhXa+NwbTqEWZctegkwTC/dM9PqVtKo6y
   6vNnpncu+ITFd/rkC9zQyARwvuxsmFqkfbnSonTXz190GNAqt1OHSOnpZ
   ladv/HuQG+sy53A5xCCuBAumeimyEddmp2Put7lu+e05GoCBmptwYYlpo
   poDnE7HC29tlw+ZL2pfXEAiU/pfuac/kYiKrUnrw56PCGKIApC49FuvZP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="373610282"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="373610282"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:59:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="780913157"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="780913157"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.153])
  by orsmga008.jf.intel.com with SMTP; 04 Oct 2023 11:59:47 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 04 Oct 2023 21:59:47 +0300
Date:   Wed, 4 Oct 2023 21:59:47 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Wang, Wendy" <wendy.wang@intel.com>
Subject: Re: [PATCH] powercap: intel_rapl: Don't warn about BIOS locked
 limits during resume
Message-ID: <ZR22I-9YgGW9vADB@intel.com>
References: <20231004183455.27797-1-ville.syrjala@linux.intel.com>
 <6d207eef73fb2ad32264921ae7d1a536b6b8da61.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d207eef73fb2ad32264921ae7d1a536b6b8da61.camel@intel.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 06:45:22PM +0000, Pandruvada, Srinivas wrote:
> On Wed, 2023-10-04 at 21:34 +0300, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > Restore enough of the original behaviour to stop spamming
> > dmesg with warnings about BIOS locked limits when trying
> > to restore them during resume.
> > 
> > This still doesn't 100% match the original behaviour
> > as we no longer attempt to blindly restore the BIOS locked
> > limits. No idea if that makes any difference in practice.
> > 
> I lost the context here. Why can't we simply change pr_warn to pr_debug
> here?

I presume someone wanted to make it pr_warn() for a reason.
I don't mind either way.

> 
> Thanks,
> Srinivas
> 
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Wang Wendy <wendy.wang@intel.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> > Fixes: 9050a9cd5e4c ("powercap: intel_rapl: Cleanup Power Limits
> > support")
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/powercap/intel_rapl_common.c | 28 ++++++++++++++++++++------
> > --
> >  1 file changed, 20 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/powercap/intel_rapl_common.c
> > b/drivers/powercap/intel_rapl_common.c
> > index 40a2cc649c79..9a6a40c83f82 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -882,22 +882,34 @@ static int rapl_read_pl_data(struct rapl_domain
> > *rd, int pl,
> >         return rapl_read_data_raw(rd, prim, xlate, data);
> >  }
> >  
> > -static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
> > -                              enum pl_prims pl_prim,
> > -                              unsigned long long value)
> > +static int rapl_write_pl_data_nowarn(struct rapl_domain *rd, int pl,
> > +                                    enum pl_prims pl_prim,
> > +                                    unsigned long long value)
> >  {
> >         enum rapl_primitives prim = get_pl_prim(rd, pl, pl_prim);
> >  
> >         if (!is_pl_valid(rd, pl))
> >                 return -EINVAL;
> >  
> > -       if (rd->rpl[pl].locked) {
> > -               pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name,
> > rd->name, pl_names[pl]);
> > +       if (rd->rpl[pl].locked)
> >                 return -EACCES;
> > -       }
> >  
> >         return rapl_write_data_raw(rd, prim, value);
> >  }
> > +
> > +static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
> > +                             enum pl_prims pl_prim,
> > +                             unsigned long long value)
> > +{
> > +       int ret;
> > +
> > +       ret = rapl_write_pl_data_nowarn(rd, pl, pl_prim, value);
> > +       if (ret == -EACCES)
> > +               pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name,
> > rd->name, pl_names[pl]);
> > +
> > +       return ret;
> > +}
> > +
> >  /*
> >   * Raw RAPL data stored in MSRs are in certain scales. We need to
> >   * convert them into standard units based on the units reported in
> > @@ -1634,8 +1646,8 @@ static void power_limit_state_restore(void)
> >                 rd = power_zone_to_rapl_domain(rp->power_zone);
> >                 for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++)
> >                         if (rd->rpl[i].last_power_limit)
> > -                               rapl_write_pl_data(rd, i, PL_LIMIT,
> > -                                              rd-
> > >rpl[i].last_power_limit);
> > +                               rapl_write_pl_data_nowarn(rd, i,
> > PL_LIMIT,
> > +                                                         rd-
> > >rpl[i].last_power_limit);
> >         }
> >         cpus_read_unlock();
> >  }
> 

-- 
Ville Syrjälä
Intel
