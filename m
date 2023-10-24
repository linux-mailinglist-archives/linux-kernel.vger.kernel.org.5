Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA807D5ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344078AbjJXStB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjJXSsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:48:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A4D7D;
        Tue, 24 Oct 2023 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698173332; x=1729709332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5Zm8CKTJfVYV2t0aRhdkqi7b4PkC1YUGrClMQrdnlxc=;
  b=PwC5uMUa73JBgHxCxHxdGQK+8I6673ReIcP1QwxmiktaVbZrF3FnTs9i
   XFeDVcgrNKAnOZuNTvRF3lBS6kTKCl76MAaeUwPXhxBbKci1HirloqJTG
   fTrUYJBIJKpcbnGCIrwfVUtplJysF6k+rABK2mUm1vvQstWwfN49+k87a
   4JbaxJjLm4nsgRLPCBnD4yeOtLhQ68HfjkZ/9gfZ6GidPuztqYWwuJjiM
   BwkYmi8x4rcMkqsP/1Ol/jW2HP3cij3ugPUAjWNeVV09pRQ2AApU8fg40
   1yc0Iizxe0QkTu80JGPru2l3hHJ3bvkPKWUWjfJS7bKl7Vr6dSps3zObO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="377515063"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="377515063"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 11:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="875167071"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="875167071"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmsmga002.fm.intel.com with SMTP; 24 Oct 2023 11:48:37 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 24 Oct 2023 21:48:36 +0300
Date:   Tue, 24 Oct 2023 21:48:36 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [Intel-gfx] [PATCH] powercap: intel_rapl: Don't warn about BIOS
 locked limits during resume
Message-ID: <ZTgRhFbp5wdsTa5W@intel.com>
References: <20231004183455.27797-1-ville.syrjala@linux.intel.com>
 <6d207eef73fb2ad32264921ae7d1a536b6b8da61.camel@intel.com>
 <ZR22I-9YgGW9vADB@intel.com>
 <ZTf6qwCLR3YEwL9K@intel.com>
 <CAJZ5v0jzqZBHqh8dxChwJ65wT-pU3+9HxVi5f7DAcOTFpYTb9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jzqZBHqh8dxChwJ65wT-pU3+9HxVi5f7DAcOTFpYTb9Q@mail.gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 08:31:34PM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 24, 2023 at 7:11 PM Ville Syrjälä
> <ville.syrjala@linux.intel.com> wrote:
> >
> > On Wed, Oct 04, 2023 at 09:59:47PM +0300, Ville Syrjälä wrote:
> > > On Wed, Oct 04, 2023 at 06:45:22PM +0000, Pandruvada, Srinivas wrote:
> > > > On Wed, 2023-10-04 at 21:34 +0300, Ville Syrjala wrote:
> > > > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > >
> > > > > Restore enough of the original behaviour to stop spamming
> > > > > dmesg with warnings about BIOS locked limits when trying
> > > > > to restore them during resume.
> > > > >
> > > > > This still doesn't 100% match the original behaviour
> > > > > as we no longer attempt to blindly restore the BIOS locked
> > > > > limits. No idea if that makes any difference in practice.
> > > > >
> > > > I lost the context here. Why can't we simply change pr_warn to pr_debug
> > > > here?
> > >
> > > I presume someone wanted to make it pr_warn() for a reason.
> > > I don't mind either way.
> >
> > Ping. Can someone make a decision on how this should get fixed
> > so we get this moving forward?
> 
> I thought we were going to replace the pr_warn() with pr_debug().

I didn't get any answer whether anyone wants to keep the pr_warn().
If everyone is happy with pr_debug() that then I can send a patch
for it.

> 
> > > > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > > > Cc: Wang Wendy <wendy.wang@intel.com>
> > > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> > > > > Fixes: 9050a9cd5e4c ("powercap: intel_rapl: Cleanup Power Limits
> > > > > support")
> > > > > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > > ---
> > > > >  drivers/powercap/intel_rapl_common.c | 28 ++++++++++++++++++++------
> > > > > --
> > > > >  1 file changed, 20 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/powercap/intel_rapl_common.c
> > > > > b/drivers/powercap/intel_rapl_common.c
> > > > > index 40a2cc649c79..9a6a40c83f82 100644
> > > > > --- a/drivers/powercap/intel_rapl_common.c
> > > > > +++ b/drivers/powercap/intel_rapl_common.c
> > > > > @@ -882,22 +882,34 @@ static int rapl_read_pl_data(struct rapl_domain
> > > > > *rd, int pl,
> > > > >         return rapl_read_data_raw(rd, prim, xlate, data);
> > > > >  }
> > > > >
> > > > > -static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
> > > > > -                              enum pl_prims pl_prim,
> > > > > -                              unsigned long long value)
> > > > > +static int rapl_write_pl_data_nowarn(struct rapl_domain *rd, int pl,
> > > > > +                                    enum pl_prims pl_prim,
> > > > > +                                    unsigned long long value)
> > > > >  {
> > > > >         enum rapl_primitives prim = get_pl_prim(rd, pl, pl_prim);
> > > > >
> > > > >         if (!is_pl_valid(rd, pl))
> > > > >                 return -EINVAL;
> > > > >
> > > > > -       if (rd->rpl[pl].locked) {
> > > > > -               pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name,
> > > > > rd->name, pl_names[pl]);
> > > > > +       if (rd->rpl[pl].locked)
> > > > >                 return -EACCES;
> > > > > -       }
> > > > >
> > > > >         return rapl_write_data_raw(rd, prim, value);
> > > > >  }
> > > > > +
> > > > > +static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
> > > > > +                             enum pl_prims pl_prim,
> > > > > +                             unsigned long long value)
> > > > > +{
> > > > > +       int ret;
> > > > > +
> > > > > +       ret = rapl_write_pl_data_nowarn(rd, pl, pl_prim, value);
> > > > > +       if (ret == -EACCES)
> > > > > +               pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name,
> > > > > rd->name, pl_names[pl]);
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * Raw RAPL data stored in MSRs are in certain scales. We need to
> > > > >   * convert them into standard units based on the units reported in
> > > > > @@ -1634,8 +1646,8 @@ static void power_limit_state_restore(void)
> > > > >                 rd = power_zone_to_rapl_domain(rp->power_zone);
> > > > >                 for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++)
> > > > >                         if (rd->rpl[i].last_power_limit)
> > > > > -                               rapl_write_pl_data(rd, i, PL_LIMIT,
> > > > > -                                              rd-
> > > > > >rpl[i].last_power_limit);
> > > > > +                               rapl_write_pl_data_nowarn(rd, i,
> > > > > PL_LIMIT,
> > > > > +                                                         rd-
> > > > > >rpl[i].last_power_limit);
> > > > >         }
> > > > >         cpus_read_unlock();
> > > > >  }
> > > >
> > >
> > > --

-- 
Ville Syrjälä
Intel
