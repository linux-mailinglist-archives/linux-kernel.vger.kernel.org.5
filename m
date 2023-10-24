Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8085A7D5015
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjJXMmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjJXMmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:42:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBC690;
        Tue, 24 Oct 2023 05:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698151371; x=1729687371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DvUixc2Vg4ONkJAO/hqh3NXKsUjfM0uDUvrjCYxymhE=;
  b=BT/ND8wCVPZ4FtSneyJTLgkH61u4HuALflxQ64Jc4DUNAsuKQBAKnwe+
   19wxoVHJE5zleu4F1CkwgoNjclMzYQ/F/VA16TsEtfCIJJM4/AnMRk3Iq
   VnraQvj/ZaHeG8/sluak42YJTnExvTM+JnF5n8mTveB1KO1iBZHVdA4Fg
   HCN6v8f+624U04PorPHfebaO1zlaH2wSIBsn4PIjozsk8IAZoc+MMQDsp
   Ijg0gZ2gQQ5NZb718gIwcIVm3t2t6YHUbOpvMsSsw95CjfHJaQXIloqLV
   R8pr4YS3B05YTngHGx8Fb9ub/SKVaQr4OlLesptvsvoR0fnjQhrv57jeW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="385940746"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="385940746"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="828814686"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="828814686"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 05:42:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qvGk9-00000008HfK-0rlG;
        Tue, 24 Oct 2023 15:42:45 +0300
Date:   Tue, 24 Oct 2023 15:42:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [RFC PATCH 1/2] serial: core: Move tty and serdev to be children
 of serial core port device
Message-ID: <ZTe7xIBCQ8e5DKZL@smile.fi.intel.com>
References: <20231024113624.54364-1-tony@atomide.com>
 <2023102401-playtime-moonrise-6f05@gregkh>
 <20231024122955.GL34982@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024122955.GL34982@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 03:29:55PM +0300, Tony Lindgren wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [231024 11:52]:
> > What does this change the sysfs tree to look like?
> 
> On x86 qemu for the ttys:
> 
> # find /sys -name tty
> /sys/class/tty
> /sys/class/tty/tty
> /sys/devices/pnp0/00:04/00:04:0/00:04:0.0/tty
> /sys/devices/platform/serial8250/serial8250:0/serial8250:0.3/tty
> /sys/devices/platform/serial8250/serial8250:0/serial8250:0.1/tty
> /sys/devices/platform/serial8250/serial8250:0/serial8250:0.2/tty
> /sys/devices/virtual/tty
> /sys/devices/virtual/tty/tty

I believe the question was how serdev device will move it's location
in the hierarchy.

-- 
With Best Regards,
Andy Shevchenko


