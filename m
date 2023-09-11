Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B2179C271
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbjILCND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbjILCMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:12:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162B26E89;
        Mon, 11 Sep 2023 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694467455; x=1726003455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HcGBa4u1K5hnQPCpGg0DbVeBeHvuKVebaPsTI8ufq4M=;
  b=ktyosDzGwoHvH8GCGscLM0uY+67+YM3Y+RpsBZqCHw7fbSLsgOSYwn8t
   tIgDdtziYCiJBRdj8ZZ3OGm8wm1aRxwbSx9TVmimBYGVyfJBlNMl4xBI2
   H0s34U8iKZrVyTZ5umf3E/iVzmP3NAKQdeYmo9LS6GyT9vBGonfK2GZYx
   KpiPZwvpHVsAtSewgll/GEruDUUrlOBk6lORNXd2nq4H3pb2rIgPJ9FVz
   zYVkUbsQTWWRytFtPcFTA7aAkAjXrylu55/fpmQ0cDu1hVlvPOorIT9Fh
   nj7LfHMdMaVC95m+/njFfZDkn8ls4cEJS6Lz1w2iqT5xePwXosnncqgz1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="380908530"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="380908530"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 14:22:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="813546290"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="813546290"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 14:22:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfoMg-008QX4-2Z;
        Tue, 12 Sep 2023 00:22:38 +0300
Date:   Tue, 12 Sep 2023 00:22:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v3 4/4] platform/x86: intel_scu_ipc: Fail IPC send if
 still busy
Message-ID: <ZP+FHs+GBROf0zH8@smile.fi.intel.com>
References: <20230911193937.302552-1-swboyd@chromium.org>
 <20230911193937.302552-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911193937.302552-5-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 12:39:36PM -0700, Stephen Boyd wrote:
> It's possible for interrupts to get significantly delayed to the point
> that callers of intel_scu_ipc_dev_command() and friends can call the
> function once, hit a timeout, and call it again while the interrupt
> still hasn't been processed. This driver will get seriously confused if
> the interrupt is finally processed after the second IPC has been sent
> with ipc_command(). It won't know which IPC has been completed. This
> could be quite disastrous if calling code assumes something has happened
> upon return from intel_scu_ipc_dev_simple_command() when it actually
> hasn't.
> 
> Let's avoid this scenario by simply returning -EBUSY in this case.
> Hopefully higher layers will know to back off or fail gracefully when
> this happens. It's all highly unlikely anyway, but it's better to be
> correct here as we have no way to know which IPC the status register is
> telling us about if we send a second IPC while the previous IPC is still
> processing.

...

> +static struct intel_scu_ipc_dev *intel_scu_ipc_get(struct intel_scu_ipc_dev *scu)
> +{
> +	u8 status;

> +	if (!scu)
> +		scu = ipcdev;

I would write this as

	scu = scu ?: ipcdev;

> +	if (!scu)
> +		return ERR_PTR(-ENODEV);
> +
> +	status = ipc_read_status(scu);
> +	if (status & IPC_STATUS_BUSY) {
> +		dev_dbg(&scu->dev, "device is busy\n");
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	return scu;
> +}

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


