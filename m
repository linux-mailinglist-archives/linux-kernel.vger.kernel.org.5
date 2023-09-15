Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E5E7A215B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbjIOOrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjIOOrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:47:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4F21BE6;
        Fri, 15 Sep 2023 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694789255; x=1726325255;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RSdffzo1Ydfr8wTOPsJoUEWKUqgBQtx4q1XDTHhuglM=;
  b=gr2BqvAhnzs1sKFPuJolVLPoSBz5iV+PsWpNX3mkHmOBgEd7+ChD4UfG
   v6SMaWMobfHOvL4GR3L4oEwil+Lr1SxBTWoPQIeGEtjdp3adVmIGwKwHc
   APixYkkEwGcKxDW1hkepFURLVdfMxZ4XnU55y2bfluJfd9mba5IqrguOj
   dFMUODdUe1sp5Fqo5pxnbyb2UDCruAbYEFDNKc+LZOleTpTi+mV+o9GMI
   Rsmwj9pqItikf3EHl5vjiNRbSTg0R/q5g2pxd/Z9SLXpAoa0OYOUwk9FU
   Xy5RAJZvN7iEGTtWtWLdJUchqT7HhoIlZEW8iIJ8kx2URTkoE90eu2B7X
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="410202250"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="410202250"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 07:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="774340718"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="774340718"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 07:45:44 -0700
Date:   Fri, 15 Sep 2023 17:45:42 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v4 3/4] platform/x86: intel_scu_ipc: Don't override scu
 in intel_scu_ipc_dev_simple_command()
In-Reply-To: <20230913212723.3055315-4-swboyd@chromium.org>
Message-ID: <58e817b0-1872-6ff1-58bb-1aeeb572361@linux.intel.com>
References: <20230913212723.3055315-1-swboyd@chromium.org> <20230913212723.3055315-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-769386324-1694789146=:2347"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-769386324-1694789146=:2347
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 13 Sep 2023, Stephen Boyd wrote:

> Andy discovered this bug during patch review. The 'scu' argument to this
> function shouldn't be overridden by the function itself. It doesn't make
> any sense. Looking at the commit history, we see that commit
> f57fa18583f5 ("platform/x86: intel_scu_ipc: Introduce new SCU IPC API")
> removed the setting of the scu to ipcdev in other functions, but not
> this one. That was an oversight. Remove this line so that we stop
> overriding the scu instance that is used by this function.
> 
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Closes: https://lore.kernel.org/r/ZPjdZ3xNmBEBvNiS@smile.fi.intel.com

This looks somewhat unusual way to tag it. I'd just drop the Closes tag 
as the email list is not a bug tracter.

Other than that,
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

> Cc: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Fixes: f57fa18583f5 ("platform/x86: intel_scu_ipc: Introduce new SCU IPC API")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 299c15312acb..3271f81a9c00 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -443,7 +443,6 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
>  		mutex_unlock(&ipclock);
>  		return -ENODEV;
>  	}
> -	scu = ipcdev;
>  	cmdval = sub << 12 | cmd;
>  	ipc_command(scu, cmdval);
>  	err = intel_scu_ipc_check_status(scu);
> 
--8323329-769386324-1694789146=:2347--
