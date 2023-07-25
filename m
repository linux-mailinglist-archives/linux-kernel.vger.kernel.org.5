Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BC1760DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjGYJHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjGYJHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:07:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF9B9C;
        Tue, 25 Jul 2023 02:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690276030; x=1721812030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mvn8U73wmClMy7XHDxwuIdZAnWDa4Qrtd6Cm49TAiHQ=;
  b=aNy+2BKKNW429qbBhnxvxSLj70XSfl/5atzIpDHNivttAgWyZo/eHGFo
   WUVL6nH5SlbX8cWt52urCugIVGtVkIGQmjQ+YGG3uG1PtFxMu0SP1Jxrx
   KPi3ZusHNFJgBaV8wbPjyZdIl+KZXQ8RZbe5ROj/DZTxfV5kJM81iD5PC
   Z6MpFEcs5imAP0RZm90mrEpmQxj5kYpl1pvY3OhTe3Hw1E+7k3ZFHiVHM
   Kw/4xuwfCWSaF/hp06v8ja9bCi7s8SAlQulMmJMmY1F2mm+k1hOO2oTwP
   9qURRP2QQyfulDmGUW0lcsiQdHcGS6cjgUiWdzHdWadfXhxVYynAuZFnt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347940066"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="347940066"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:07:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="849937832"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="849937832"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 25 Jul 2023 02:07:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOE0X-002UuA-04;
        Tue, 25 Jul 2023 12:07:05 +0300
Date:   Tue, 25 Jul 2023 12:07:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 3/3] serial: core: Fix serial core controller port
 name to show controller id
Message-ID: <ZL+QuHE4CztPvBxo@smile.fi.intel.com>
References: <20230725054216.45696-1-tony@atomide.com>
 <20230725054216.45696-4-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725054216.45696-4-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:42:12AM +0300, Tony Lindgren wrote:
> We are missing the serial core controller id for the serial core port
> name. Let's fix the issue for sane sysfs output, and to avoid issues
> addressing serial ports later on.
> 
> And as we're now showing the controller id, the "ctrl" and "port" prefix
> for the DEVNAME become useless, we can just drop them. Let's standardize on
> DEVNAME:0 for controller name, where 0 is the controller id. And
> DEVNAME:0.0 for port name, where 0.0 are the controller id and port id.
> 
> This makes the sysfs output nicer, on qemu for example:
> 
> $ ls /sys/bus/serial-base/devices
> 00:04:0         serial8250:0    serial8250:0.2
> 00:04:0.0       serial8250:0.1  serial8250:0.3

Hmm... Why 0.0 is absent for serial8250?
Btw, what was before this patch there?
And maybe ls -l will look more informative?

> Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Andy, I kept your Reviewed-by although I updated the device naming and
> description, does the patch still look OK to you?

Looks okay, but I have a question above.

-- 
With Best Regards,
Andy Shevchenko


