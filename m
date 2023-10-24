Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376387D5A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344152AbjJXSbu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 14:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343871AbjJXSbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:31:48 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9EDA2;
        Tue, 24 Oct 2023 11:31:46 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1e99a55a9c0so735259fac.1;
        Tue, 24 Oct 2023 11:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698172306; x=1698777106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDoF8Vf3VyZumUoLFjmWZx8r9xJBfxkPhJpQuVboEpw=;
        b=R4pDpEYAIaKdzH+wFybntzGrrxG2cfOypQ0kRSXVek1KvKpcnZFF81qBeFhkmNCUr8
         1CakN+Vz8RfvFy7CYNqmpA4EnYkGpGG7r/vnMvDpTGX7FWsfsklwBCdO4VatBgbYfpdF
         TJivEYKxJNQdSyVDN+mZBo8hNseaq/TV12u/hym9AMz40huDk32WVbGubs55BEB1/yQt
         SFhpBXa5fbgWXrlxgloW/Wdk1bBCILZ0hCDZpqMoj3QoX7R4OJpSAoFaFW5exmyGlvmR
         e7csJnV0Lz+dp2KjoU1A+xBXBuxyWFXBlVya9IfNiVwXyFRm9XC3hV5T/AgifUfBRI6V
         rTbA==
X-Gm-Message-State: AOJu0YzZGhPQrQS0QKqWMEeWGtit+ps1PIf+t4OcFjSYtd/nRWOdU06C
        lZFP6RWhk+Vp6sDE9yq+AmFJXTR5ZzcPlRvQIrU=
X-Google-Smtp-Source: AGHT+IH2EFbLWL/v9E/dQTTscrQum2xp8EVbFFAxX4pQ+ccP9+k7qxANEe03vrJQNqg6WZSi/OqmgP88n4f5zhsp9/A=
X-Received: by 2002:a05:6871:3317:b0:1bf:9fa2:bfa3 with SMTP id
 nf23-20020a056871331700b001bf9fa2bfa3mr14098531oac.1.1698172305854; Tue, 24
 Oct 2023 11:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231004183455.27797-1-ville.syrjala@linux.intel.com>
 <6d207eef73fb2ad32264921ae7d1a536b6b8da61.camel@intel.com>
 <ZR22I-9YgGW9vADB@intel.com> <ZTf6qwCLR3YEwL9K@intel.com>
In-Reply-To: <ZTf6qwCLR3YEwL9K@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Oct 2023 20:31:34 +0200
Message-ID: <CAJZ5v0jzqZBHqh8dxChwJ65wT-pU3+9HxVi5f7DAcOTFpYTb9Q@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] powercap: intel_rapl: Don't warn about BIOS
 locked limits during resume
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 7:11 PM Ville Syrjälä
<ville.syrjala@linux.intel.com> wrote:
>
> On Wed, Oct 04, 2023 at 09:59:47PM +0300, Ville Syrjälä wrote:
> > On Wed, Oct 04, 2023 at 06:45:22PM +0000, Pandruvada, Srinivas wrote:
> > > On Wed, 2023-10-04 at 21:34 +0300, Ville Syrjala wrote:
> > > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > >
> > > > Restore enough of the original behaviour to stop spamming
> > > > dmesg with warnings about BIOS locked limits when trying
> > > > to restore them during resume.
> > > >
> > > > This still doesn't 100% match the original behaviour
> > > > as we no longer attempt to blindly restore the BIOS locked
> > > > limits. No idea if that makes any difference in practice.
> > > >
> > > I lost the context here. Why can't we simply change pr_warn to pr_debug
> > > here?
> >
> > I presume someone wanted to make it pr_warn() for a reason.
> > I don't mind either way.
>
> Ping. Can someone make a decision on how this should get fixed
> so we get this moving forward?

I thought we were going to replace the pr_warn() with pr_debug().

> > > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > > Cc: Wang Wendy <wendy.wang@intel.com>
> > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> > > > Fixes: 9050a9cd5e4c ("powercap: intel_rapl: Cleanup Power Limits
> > > > support")
> > > > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > ---
> > > >  drivers/powercap/intel_rapl_common.c | 28 ++++++++++++++++++++------
> > > > --
> > > >  1 file changed, 20 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/powercap/intel_rapl_common.c
> > > > b/drivers/powercap/intel_rapl_common.c
> > > > index 40a2cc649c79..9a6a40c83f82 100644
> > > > --- a/drivers/powercap/intel_rapl_common.c
> > > > +++ b/drivers/powercap/intel_rapl_common.c
> > > > @@ -882,22 +882,34 @@ static int rapl_read_pl_data(struct rapl_domain
> > > > *rd, int pl,
> > > >         return rapl_read_data_raw(rd, prim, xlate, data);
> > > >  }
> > > >
> > > > -static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
> > > > -                              enum pl_prims pl_prim,
> > > > -                              unsigned long long value)
> > > > +static int rapl_write_pl_data_nowarn(struct rapl_domain *rd, int pl,
> > > > +                                    enum pl_prims pl_prim,
> > > > +                                    unsigned long long value)
> > > >  {
> > > >         enum rapl_primitives prim = get_pl_prim(rd, pl, pl_prim);
> > > >
> > > >         if (!is_pl_valid(rd, pl))
> > > >                 return -EINVAL;
> > > >
> > > > -       if (rd->rpl[pl].locked) {
> > > > -               pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name,
> > > > rd->name, pl_names[pl]);
> > > > +       if (rd->rpl[pl].locked)
> > > >                 return -EACCES;
> > > > -       }
> > > >
> > > >         return rapl_write_data_raw(rd, prim, value);
> > > >  }
> > > > +
> > > > +static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
> > > > +                             enum pl_prims pl_prim,
> > > > +                             unsigned long long value)
> > > > +{
> > > > +       int ret;
> > > > +
> > > > +       ret = rapl_write_pl_data_nowarn(rd, pl, pl_prim, value);
> > > > +       if (ret == -EACCES)
> > > > +               pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name,
> > > > rd->name, pl_names[pl]);
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +
> > > >  /*
> > > >   * Raw RAPL data stored in MSRs are in certain scales. We need to
> > > >   * convert them into standard units based on the units reported in
> > > > @@ -1634,8 +1646,8 @@ static void power_limit_state_restore(void)
> > > >                 rd = power_zone_to_rapl_domain(rp->power_zone);
> > > >                 for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++)
> > > >                         if (rd->rpl[i].last_power_limit)
> > > > -                               rapl_write_pl_data(rd, i, PL_LIMIT,
> > > > -                                              rd-
> > > > >rpl[i].last_power_limit);
> > > > +                               rapl_write_pl_data_nowarn(rd, i,
> > > > PL_LIMIT,
> > > > +                                                         rd-
> > > > >rpl[i].last_power_limit);
> > > >         }
> > > >         cpus_read_unlock();
> > > >  }
> > >
> >
> > --
