Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A9778F85C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344829AbjIAGHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbjIAGGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:06:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8A710CA;
        Thu, 31 Aug 2023 23:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693548398; x=1725084398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5zXm/ilGbvaTMhT7HjwnoHc9furUVXGdEvbQQYm3oTY=;
  b=a646sJqBzC/S3bqwWxgwYWMxXNfkUxN6vgosb0+Vtzx/hLmqT/D0zUQJ
   Ztf5344cMUaSi+CW+n9rGxtSeB77hqLK9UA0kqjpQNmgS8ivN+31wVP8r
   6Janfc5ghTze0YC0kZ+Prb5DV9GGXzyCR91H/IitllA2kCRnTihfzniia
   8Nyx6BcMrHSf/mWlhqGV6nCp33YbkZlO/fyrTuNHZrJbSdJo6lpFpkBr3
   cIJAtfUEyPae9jdpjolVhfzuIGArFrEovTkC94DgaeaNrobw5GaA2Zjsd
   Lh8YQYnRfACg/i2b9jGh3OFLk7sAf5wZOi0WMiwi+QwnWEZ/f/IO0qtEF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="361168132"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="361168132"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 23:06:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="1070612442"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="1070612442"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 31 Aug 2023 23:06:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BDE26DE; Fri,  1 Sep 2023 09:06:33 +0300 (EEST)
Date:   Fri, 1 Sep 2023 09:06:33 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH 3/3] platform/x86: intel_scu_ipc: Fail IPC send if still
 busy
Message-ID: <20230901060633.GV3465@black.fi.intel.com>
References: <20230831011405.3246849-1-swboyd@chromium.org>
 <20230831011405.3246849-4-swboyd@chromium.org>
 <ZPCenoPp/SDesUek@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPCenoPp/SDesUek@smile.fi.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 05:07:26PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 30, 2023 at 06:14:03PM -0700, Stephen Boyd wrote:
> > It's possible for interrupts to get significantly delayed to the point
> > that callers of intel_scu_ipc_dev_command() and friends can call the
> > function once, hit a timeout, and call it again while the interrupt
> > still hasn't been processed. This driver will get seriously confused if
> > the interrupt is finally processed after the second IPC has been sent
> > with ipc_command(). It won't know which IPC has been completed. This
> > could be quite disastrous if calling code assumes something has happened
> > upon return from intel_scu_ipc_dev_simple_command() when it actually
> > hasn't.
> > 
> > Let's avoid this scenario by simply returning -EBUSY in this case.
> > Hopefully higher layers will know to back off or fail gracefully when
> > this happens. It's all highly unlikely anyway, but it's better to be
> > correct here as we have no way to know which IPC the status register is
> > telling us about if we send a second IPC while the previous IPC is still
> > processing.
> 
> > +static bool intel_scu_ipc_busy(struct intel_scu_ipc_dev *scu)
> 
> static int ?
> 
> > +{
> > +	u8 status;
> > +
> > +	status = ipc_read_status(scu);
> > +	if (status & IPC_STATUS_BUSY) {
> 
> > +		dev_err(&scu->dev, "device is busy\n");
> 
> 1. Wouldn't it exaggerate the logs? Shouldn't be rate limited?
> 2. OTOH if we return -EBUSY directly from here, do we need this at all?

Agree w/ returning -EBUSY here and dropping the dev_err() (or using
dev_dbg()).
