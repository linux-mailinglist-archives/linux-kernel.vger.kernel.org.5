Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE816794451
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbjIFUNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjIFUNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:13:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566F1198E;
        Wed,  6 Sep 2023 13:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694031213; x=1725567213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zX9IKg4GJKWsi/mIULaeZN5e6VR5b1qoI9Vm93n2kY8=;
  b=el8bO5u6MVWIRQ9bF4SUJAdMhE8YDsa2zX6LoRmpONj3wjCpPD/nBa/T
   5EWUip82vjC6N8EedVarNso7Ck3xk6x6C5+ek7mIkv8jRawbcMbjiel0B
   P818WbMUa56Uqwz5MpvpyGj2j1yIHOtyi5MJOmL5rv5Tw8bAaeQ1/B/FA
   j3l/86E3k1JivRPWHXm9BS9B71adFfn+wEMXHsgd6NXPBIORhBnhaAKXD
   FEgWit5XKsvZZtjcfE/G2LNgohu/+QydsyW8/e4PM2sGF36GrFmiIDEpX
   qkKxp54H1jI1EKuQ3pNk8mKY01A/xuqtnte5fS1UlDhiFQFhCzGm0KSL7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="357484744"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="357484744"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:13:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="691431871"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="691431871"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:13:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdytz-0079B0-0r;
        Wed, 06 Sep 2023 23:13:27 +0300
Date:   Wed, 6 Sep 2023 23:13:27 +0300
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
Subject: Re: [PATCH v2 3/3] platform/x86: intel_scu_ipc: Fail IPC send if
 still busy
Message-ID: <ZPjdZ3xNmBEBvNiS@smile.fi.intel.com>
References: <20230906180944.2197111-1-swboyd@chromium.org>
 <20230906180944.2197111-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906180944.2197111-4-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 11:09:43AM -0700, Stephen Boyd wrote:
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Also see below.

...

> @@ -450,6 +468,12 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
>  		return -ENODEV;
>  	}

>  	scu = ipcdev;

Side observation: Isn't this a bug? We should not override the supplied parameter.

> +	err = intel_scu_ipc_busy(scu);
> +	if (err) {
> +		mutex_unlock(&ipclock);
> +		return err;
> +	}
> +
>  	cmdval = sub << 12 | cmd;
>  	ipc_command(scu, cmdval);
>  	err = intel_scu_ipc_check_status(scu);

-- 
With Best Regards,
Andy Shevchenko


