Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD8479C614
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjILFCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjILFBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:01:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFDE10F3;
        Mon, 11 Sep 2023 22:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694494850; x=1726030850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gQCqTAEYQL/pkOw8sp0WLX0nuh/gNZ5sLDu8CpvEilQ=;
  b=BZcCpUc5C4dX5QLT8AP/Mwxqm2PqtJVimeYxugMUIZvqDXEPJdYbYh8y
   iGCZK4KvRPS9QGJERR8sKZzUMl4lnx9Q+GUr7HTGaCV/9mUy6wnhXmTGf
   SEakXS/ipHinNXObesAI9ZGoOXQvnneZqrLPMlhhI+d6zJek4u9I4E4vL
   +4i3DeAAAn1GpNWbyu0Noc99igV7yt1K1BIKjS0/GRevQ5zGKSh9N8XbS
   JwKA/2MugK5AmetstDHyMjS77fqCrhBH0gYqEjQGM8UOWzFpOyKgsiL/F
   BLzdUNImVsiDsJSoKiW0DZ+RiGLhi2n7DemMG+6utU2cTVV51BtzExnDL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="409230167"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="409230167"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 22:00:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858637789"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="858637789"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 11 Sep 2023 22:00:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id EFC82248; Tue, 12 Sep 2023 08:00:45 +0300 (EEST)
Date:   Tue, 12 Sep 2023 08:00:45 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v3 2/4] platform/x86: intel_scu_ipc: Check status upon
 timeout in ipc_wait_for_interrupt()
Message-ID: <20230912050045.GA1599918@black.fi.intel.com>
References: <20230911193937.302552-1-swboyd@chromium.org>
 <20230911193937.302552-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230911193937.302552-3-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 12:39:34PM -0700, Stephen Boyd wrote:
> It's possible for the completion in ipc_wait_for_interrupt() to timeout,
> simply because the interrupt was delayed in being processed. A timeout
> in itself is not an error. This driver should check the status register
> upon a timeout to ensure that scheduling or interrupt processing delays
> don't affect the outcome of the IPC return value.
> 
>  CPU0                                                   SCU
>  ----                                                   ---
>  ipc_wait_for_interrupt()
>   wait_for_completion_timeout(&scu->cmd_complete)
>   [TIMEOUT]                                             status[IPC_STATUS_BUSY]=0
> 
> Fix this problem by reading the status bit in all cases, regardless of
> the timeout. If the completion times out, we'll assume the problem was
> that the IPC_STATUS_BUSY bit was still set, but if the status bit is
> cleared in the meantime we know that we hit some scheduling delay and we
> should just check the error bit.
> 
> Cc: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
