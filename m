Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC497BB335
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjJFIa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjJFIa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:30:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B11283;
        Fri,  6 Oct 2023 01:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696581027; x=1728117027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AwhlxzzmAzPePwi2wcwAldf1evn70J98RRqGuI/mr24=;
  b=gIcfG4XWNQ6Wx96XWumYphNinGU5GZ4l2K1/e3MWRFvrmo/pPxu1/aUR
   SPsBm5ymlBetf0PtGzo2nEj66Pj5z3ftswFEBDne3JDZUz5Nl/Zd6WYWS
   QhEWpL5wsvxkI1jKT8V6ri8VwPLc7Rj+93Jj5Qm/tfj4NCCGHxC2vAY87
   uLE/zPSw5s5wlYOwhOl9UYWfKLArOYNbN7fbagQkN7GkJKvXeZSWy/noc
   4VeSs4yS1/NjKULNMSQEVjgjeGsnXeZjDUwRa1d3YDjipPL90l67INh/j
   BNVq+HQznOpJjSBIu9fAUaJIWv4svQLuukfnezM9jGWBdgKQBofK6HOIS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="383594763"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="383594763"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 01:30:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="999258780"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="999258780"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 01:30:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qogE0-00000003EoO-271a;
        Fri, 06 Oct 2023 11:30:20 +0300
Date:   Fri, 6 Oct 2023 11:30:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH] serial: core: Fix checks for tx runtime PM state
Message-ID: <ZR/FnJ9TlnSTcHtk@smile.fi.intel.com>
References: <20231005075644.25936-1-tony@atomide.com>
 <ZR6lc/F1Esxt5ChI@smile.fi.intel.com>
 <20231006072738.GI34982@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006072738.GI34982@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 10:27:38AM +0300, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [231005 12:01]:
> > On Thu, Oct 05, 2023 at 10:56:42AM +0300, Tony Lindgren wrote:
> > > The serdev device and the serial core controller devices are siblings of
> > > the serial port hardware device. The runtime PM usage count from serdev
> > 
> > I'm a bit lost in terminology here.
> > AFAIU there are:
> > 1) children of the serial physical device;
> > 2) siblings (to each other).
> > 
> > But may be I mistakenly deciphered the diagram from the previous discussion.
> 
> You're right, so how about:
> 
> The serdev device and the serial core controller devices are children of
> the serial port hardware device. The runtime PM usage count from serdev
> device does not propagate to the serial core device siblings, it only
> propagates to the parent.

Clearer, thank you!

-- 
With Best Regards,
Andy Shevchenko


