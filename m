Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3559B793DFC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbjIFNrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjIFNrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:47:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87E2CF1;
        Wed,  6 Sep 2023 06:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694008036; x=1725544036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zDFPAPYGX2IZoTeqMbNV/DXZinj8Poy4eWm5AtR/VnU=;
  b=Xjs8s0VkJanOfenWMR+CwGjZZTnbEYx5a/E8yOACsO02jRa2HhzIo5rT
   8he5wCfwdFYvAwjC/O3/2pgaaaBkd0FIYUwpBFs5649NZT6TXQy5JowKz
   1Ny+brNE/2bsk06/jsTglFIr71/YhTOqXBPapavHMhkxzQMJv8iXlmezp
   GehxQ0mdjYAHshBVn+kyrWjN/TRtJqLe89HtKs4CJZ1BR2eD+lFxCQAvg
   ejBoj9OEz8Fx6F3yuP7a7doLEzIhAD6qwUY0nB7Iuh8OiFbuA89Sgh/8K
   6uwx+HD+g7mroo7Emo0WpKeoCVAJ/Kk8kxLecVh6hTCDY+O26YIzeTg31
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="380866183"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="380866183"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 06:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="988236819"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="988236819"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 06:47:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdsrw-006xGR-01;
        Wed, 06 Sep 2023 16:46:56 +0300
Date:   Wed, 6 Sep 2023 16:46:55 +0300
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
Subject: Re: [PATCH 1/3] platform/x86: intel_scu_ipc: Check status after
 timeouts in busy_loop()
Message-ID: <ZPiCz6AaLc4mqGH8@smile.fi.intel.com>
References: <20230831011405.3246849-1-swboyd@chromium.org>
 <20230831011405.3246849-2-swboyd@chromium.org>
 <20230901055011.GT3465@black.fi.intel.com>
 <CAE-0n50XCw7ugkoTAUfb5Jrr6-Vh=bvXfTOSeHV_ymyOQfRB2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n50XCw7ugkoTAUfb5Jrr6-Vh=bvXfTOSeHV_ymyOQfRB2g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 05:27:23PM -0500, Stephen Boyd wrote:
> Quoting Mika Westerberg (2023-08-31 22:50:11)
> > On Wed, Aug 30, 2023 at 06:14:01PM -0700, Stephen Boyd wrote:
> > > It's possible for the polling loop in busy_loop() to get scheduled away
> > > for a long time.
> > >
> > >   status = ipc_read_status(scu);
> > >   <long time scheduled away>
> > >   if (!(status & IPC_STATUS_BUSY))
> >
> > How can the status bit change here as we are the only user and the SCU
> > access is serialized by ipclock?
> 
> I don't know how the SCU works. I thought that IPC_STATUS_BUSY bit was
> cleared by the SCU when it was done processing. With that assumption, I
> tried to show that the status is read and then the process schedules
> away for a long time and has an outdated view of the busy bit.

We probably have different versions of firmwares for the different SoC
generations. But I _think_ that you are right, the SCU firmware should
clear the bit when it's done.

-- 
With Best Regards,
Andy Shevchenko


