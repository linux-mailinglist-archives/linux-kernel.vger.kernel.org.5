Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FE07B7AB1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbjJDIv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjJDIvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:51:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C51698;
        Wed,  4 Oct 2023 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696409511; x=1727945511;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xFTwZbp/Tgd7NfCjaT0B0pvTGrRIJLYgdHGo9ZMmqb0=;
  b=j2/ML4TWsomHN0oHBy2iDoXulaAS3km2dB+bu8jQpCG9y49TUKHuUQJN
   lPcxG+Pvyx1CwnXD7w7zSa/nt/t/Klv2JZjFaf4yFz3t9L6l9yrPlPDpD
   cxWN5S8XcKQsiO+weIqd5yoHHuPgmm6vMRxwbV804vUPOKdFlOyOnYE8P
   IWGKO50APrZfniD7br245zCbkIH/W5OqdgnpyrCbe2yfHaAJBVSENYxc8
   2oDESBL7Tsk7E7ZbrNF9polFKBX5LJHsv1/vYl+j5oqCiknK2q5WJ62yn
   4t+4vKTzJ7CXIaQDWcT0dX17ZwCM2+01JsDYhTkwjWB3vKy8gYsrCUFbR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449600607"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449600607"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 01:51:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="925021152"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="925021152"
Received: from cyrillet-mobl.ger.corp.intel.com ([10.252.55.203])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 01:51:48 -0700
Date:   Wed, 4 Oct 2023 11:51:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Vadim Pasternak <vadimp@nvidia.com>
cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Michael Shych <michaelsh@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform: mellanox: Fix a resource leak in an error
 handling path in mlxplat_probe()
In-Reply-To: <BN9PR12MB53810BC39ADE210092559CADAFC4A@BN9PR12MB5381.namprd12.prod.outlook.com>
Message-ID: <70165032-796e-6f5c-6748-f514e3b9d08c@linux.intel.com>
References: <8bd0a7944f0f4f1342333eaf8d92d8e9d5623110.1696141233.git.christophe.jaillet@wanadoo.fr> <7d966897-56b5-4a53-3b75-dd90072e17@linux.intel.com> <BN9PR12MB53810BC39ADE210092559CADAFC4A@BN9PR12MB5381.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-702811403-1696409510=:1931"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-702811403-1696409510=:1931
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 3 Oct 2023, Vadim Pasternak wrote:

> Hi Ilpo,
> Thank you very much for review.
> 
> > -----Original Message-----
> > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Sent: Tuesday, 3 October 2023 15:06
> > To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Cc: Vadim Pasternak <vadimp@nvidia.com>; Hans de Goede
> > <hdegoede@redhat.com>; Mark Gross <markgross@kernel.org>; Michael
> > Shych <michaelsh@nvidia.com>; LKML <linux-kernel@vger.kernel.org>; kernel-
> > janitors@vger.kernel.org; platform-driver-x86@vger.kernel.org
> > Subject: Re: [PATCH] platform: mellanox: Fix a resource leak in an error
> > handling path in mlxplat_probe()
> > 
> > On Sun, 1 Oct 2023, Christophe JAILLET wrote:
> > 
> > > If an error occurs after a successful mlxplat_i2c_main_init(),
> > > mlxplat_i2c_main_exit() should be called to free some resources.
> > >
> > > Add the missing call, as already done in the remove function.
> > >
> > > Fixes: 158cd8320776 ("platform: mellanox: Split logic in init and exit
> > > flow")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > This patch is based on comparison between functions called in the
> > > remove function and the error handling path of the probe.
> > >
> > > For some reason, the way the code is written and function names are
> > > puzzling to me.
> > 
> > Indeed, pre/post are mixed up for init/exit variants which makes everything
> > very confusing and the call to mlxplat_post_init() is buried deep into the call
> > chain.
> > 
> > These would seem better names for the init/deinit with proper pairing:
> > 
> > - ..._logicdev_init/deinit for FPGA/CPLD init.
> > - ..._mainbus_init/deinit
> > - perhaps the rest could be just ..._platdevs_reg/unreg
> > 
> > Those alone would make it much easier to follow.
> > 
> > In addition,
> > - mlxplat_i2c_mux_complition_notify() looks just useless call chain level
> >   and should be removed (it also has a typo in its name).
> > - Maybe ..._platdev_reg() (currently mlxplat_post_init()) should be called
> >   directly from mainbus_init() or even from .probe() and not from the
> >   mux topo init.
> > 
> > > So Review with care!
> > 
> > It does not look complete as also mlxplat_i2c_main_init() lacks rollback it
> > should do it mlxplat_i2c_mux_topology_init() failed.
> > 
> > Since currently mlxplat_i2c_main_init() is what ultimately calls
> > mlxplat_post_init() deep down in the call chain (unless the call to it gets moved
> > out from there), it would be appropriate for
> > mlxplat_i2c_main_exit() to do/call the cleanup.  And neither .probe() nor
> > .remove() should call mlxplat_pre_exit() directly in that case.
> > 
> > So two alternative ways forward for the fix before all the renaming:
> > 
> > 1) Move mlxplat_post_init() call out of its current place into .probe()
> >    and make the rollback path there to match that.
> > 2) Do cleanup properly in mlxplat_i2c_main_init() and
> >    mlxplat_i2c_main_exit().
> > 
> > I'd prefer 1) because it's much simpler to follow the init logic when the init
> > components are not hidden deep into the call chain.
> > 
> 
> I would prefer to keep mlxplat_i2c_mux_complition_notify() as separate
> function. I am going to use it as a callback. 

It's okay for it to remain as long as the init/deinit pairs properly in 
the end.

> I suggest I'll prepare the next patches:
> 
> 1.
> As a bugfix, fix provided by Christophe and additional cleanup in
> mlxplat_i2c_main_init():
> 
> @@ -6514,6 +6514,10 @@ static int mlxplat_i2c_main_init(struct mlxplat_priv *priv)
>         return 0;
>  
>  fail_mlxplat_i2c_mux_topology_init:
> +       if (priv->pdev_i2c) {
> +               platform_device_unregister(priv->pdev_i2c);
> +               priv->pdev_i2c = NULL;
> +       }
>  fail_platform_i2c_register:
>  fail_mlxplat_mlxcpld_verify_bus_topology:
>         return err;
> @@ -6598,6 +6602,7 @@ static int mlxplat_probe(struct platform_device *pdev)
>  fail_register_reboot_notifier:
>  fail_regcache_sync:
>         mlxplat_pre_exit(priv);
> +       mlxplat_i2c_main_exit(priv);
>  fail_mlxplat_i2c_main_init:
>  fail_regmap_write:
> 
> 2.
> Move mlxplat_pre_exit() inside mlxplat_i2c_main_exit()

This can be and should be combined with step 1 (where .probe()'s rollback 
and .remove() would call it and not mlxplat_pre_exit() at all). It already 
makes the pairing okay on the logic level so only name pairing needs to be 
done after that.

You can do separate patch both with Fixes tags since these are kinda 
independent issues.

These 1+2 are what I suggested in 2).

> 3.
> Fix of ' complition' misspelling:
> s/mlxplat_i2c_main_complition_notify/ mlxplat_i2c_main_completion_notify
> 
> 4.
> 
> Renaming:
> mlxplat_pre_init()/mlxplat_post_exit() to
> 	mlxplat_logicdev_init()/mlxplat_logicdev_exit()
> 
> mlxplat_i2c_main_init()/mlxplat_i2c_main_exit() keep as is.
> 
> mlxplat_post_init()/mlxplat_pre_exit() to
> 	mlxplat_platdevs_init()/mlxplat_platdevs_exit()
> 
> What do you think?

Yes to 3 & 4.


-- 
 i.

--8323329-702811403-1696409510=:1931--
