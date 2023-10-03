Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAA77B687B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjJCMF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 08:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjJCMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:05:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65665B0;
        Tue,  3 Oct 2023 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696334752; x=1727870752;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2FVL6oK6St+5P80WJ+yzirfeEardVkYw1NDRImd/gVM=;
  b=hy6FhSqVPGJW2GTaOqs59afYeTh+sNqjm09T7xMNL7Xt/FD6CSW/YF1a
   N2Jmni6DBeC6CR1tXVa0epbhNAVS8WJIteMt1KOBFNHnHTxmBHuitkDZQ
   zruieOvmqBhJ5ZyZTfwW8ugs3E8ta40rRpkke5g0UV1BX4dMh3t4JA82a
   2DKo/MWOAHocUENldcgBIm7c19wzwEUJsQtEiWAZUWLDbTznAQo+OxL4W
   vDI3AWaqUZ+/oRPwlffxQ4CnIUd8pqfH80s8zlfp1aqG0N/PKE5pyZOIT
   4ytUG9PCxoJ+XAWapjPjjJomKbC7xLDhtvJ5jUy/iCQaWn4PTsAsUC048
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="449347037"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="449347037"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 05:05:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="727589592"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="727589592"
Received: from tciutacu-mobl.ger.corp.intel.com (HELO rrabie-mobl.amr.corp.intel.com) ([10.252.40.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 05:05:47 -0700
Date:   Tue, 3 Oct 2023 15:05:45 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     Vadim Pasternak <vadimp@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Michael Shych <michaelsh@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform: mellanox: Fix a resource leak in an error
 handling path in mlxplat_probe()
In-Reply-To: <8bd0a7944f0f4f1342333eaf8d92d8e9d5623110.1696141233.git.christophe.jaillet@wanadoo.fr>
Message-ID: <7d966897-56b5-4a53-3b75-dd90072e17@linux.intel.com>
References: <8bd0a7944f0f4f1342333eaf8d92d8e9d5623110.1696141233.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2023, Christophe JAILLET wrote:

> If an error occurs after a successful mlxplat_i2c_main_init(),
> mlxplat_i2c_main_exit() should be called to free some resources.
> 
> Add the missing call, as already done in the remove function.
> 
> Fixes: 158cd8320776 ("platform: mellanox: Split logic in init and exit flow")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is based on comparison between functions called in the remove
> function and the error handling path of the probe.
> 
> For some reason, the way the code is written and function names are
> puzzling to me.

Indeed, pre/post are mixed up for init/exit variants which makes 
everything very confusing and the call to mlxplat_post_init() is buried 
deep into the call chain.

These would seem better names for the init/deinit with proper pairing:

- ..._logicdev_init/deinit for FPGA/CPLD init.
- ..._mainbus_init/deinit
- perhaps the rest could be just ..._platdevs_reg/unreg

Those alone would make it much easier to follow.

In addition,
- mlxplat_i2c_mux_complition_notify() looks just useless call chain level
  and should be removed (it also has a typo in its name).
- Maybe ..._platdev_reg() (currently mlxplat_post_init()) should be called 
  directly from mainbus_init() or even from .probe() and not from the
  mux topo init.

> So Review with care!

It does not look complete as also mlxplat_i2c_main_init() lacks rollback 
it should do it mlxplat_i2c_mux_topology_init() failed.

Since currently mlxplat_i2c_main_init() is what ultimately calls 
mlxplat_post_init() deep down in the call chain (unless the call to it 
gets moved out from there), it would be appropriate for 
mlxplat_i2c_main_exit() to do/call the cleanup.  And neither .probe() nor 
.remove() should call mlxplat_pre_exit() directly in that case.

So two alternative ways forward for the fix before all the renaming:

1) Move mlxplat_post_init() call out of its current place into .probe() 
   and make the rollback path there to match that.
2) Do cleanup properly in mlxplat_i2c_main_init() and 
   mlxplat_i2c_main_exit().

I'd prefer 1) because it's much simpler to follow the init logic when the 
init components are not hidden deep into the call chain.

-- 
 i.


> ---
>  drivers/platform/x86/mlx-platform.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
> index 3d96dbf79a72..64701b63336e 100644
> --- a/drivers/platform/x86/mlx-platform.c
> +++ b/drivers/platform/x86/mlx-platform.c
> @@ -6598,6 +6598,7 @@ static int mlxplat_probe(struct platform_device *pdev)
>  fail_register_reboot_notifier:
>  fail_regcache_sync:
>  	mlxplat_pre_exit(priv);
> +	mlxplat_i2c_main_exit(priv);
>  fail_mlxplat_i2c_main_init:
>  fail_regmap_write:
>  fail_alloc:
> 
