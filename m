Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4BE78EF48
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345755AbjHaOIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjHaOIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:08:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767E5F4;
        Thu, 31 Aug 2023 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693490886; x=1725026886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b1giQg6JZeac/5i+rnklAmY2c37piEGAdmDhQDDAAyA=;
  b=I+Woeh1ngA7agpmS0Ub0PBwz6zJfJMApJYsIpaAe81KmPJYho382N+3U
   HFOZjCLOyu73RGriiH+3E2RkL2Dk6xWNp4NdBvhYPYbo+pI6JNdi3xUz3
   qYSkzvap6NURv/NRrItcS+B1Mzdas6dQdrh56dN08oONaGV4FHzD1qyOc
   EGR5JmVbdGWQq+/zStoDFjobAYixoR/72bTVy/Mg+o50ay7Jql3CtpIkR
   K/noEBvPdm+WU81bjpsck0aJuocT5uhXsxm1Ko7Rpf5xE+51d7IsBvyIk
   FNLF1ASDJk+QzIR6AeRpiNnnMqjpt6doiCG4EMF8dJ2K1mqKzwg5juZwm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="462323503"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="462323503"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 07:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="809645901"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="809645901"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 07:07:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbiKU-005P9q-1J;
        Thu, 31 Aug 2023 17:07:26 +0300
Date:   Thu, 31 Aug 2023 17:07:26 +0300
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
Subject: Re: [PATCH 3/3] platform/x86: intel_scu_ipc: Fail IPC send if still
 busy
Message-ID: <ZPCenoPp/SDesUek@smile.fi.intel.com>
References: <20230831011405.3246849-1-swboyd@chromium.org>
 <20230831011405.3246849-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831011405.3246849-4-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 06:14:03PM -0700, Stephen Boyd wrote:
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

> +static bool intel_scu_ipc_busy(struct intel_scu_ipc_dev *scu)

static int ?

> +{
> +	u8 status;
> +
> +	status = ipc_read_status(scu);
> +	if (status & IPC_STATUS_BUSY) {

> +		dev_err(&scu->dev, "device is busy\n");

1. Wouldn't it exaggerate the logs? Shouldn't be rate limited?
2. OTOH if we return -EBUSY directly from here, do we need this at all?

> +		return true;
> +	}
> +
> +	return false;
> +}

-- 
With Best Regards,
Andy Shevchenko


