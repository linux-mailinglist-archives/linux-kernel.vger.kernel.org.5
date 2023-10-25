Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD38C7D631D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjJYHeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjJYHdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:33:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E5C1BF4;
        Wed, 25 Oct 2023 00:32:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F441C433CD;
        Wed, 25 Oct 2023 07:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698219170;
        bh=Xr+oCljdZCgIbGd4ca4bWp43lj7iJe6epN66S6FOUCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mFNOrcdKzpANbprFhcnnu5nZ01fPCW+FtFDQ1hUrFtgKgkorcqnbdznRHtLHf/y2q
         QjUgLR+L+74TvTYw/GJKdcOkQyDZwD1uTS/a96GYgoFuOa7Vw79qMfG0zbAkAMR18p
         voeIo4SNs6x2JOTwCBPsGxUleUdB1NTvOCDcAXlRpZ8nFkl6nYkRJifA9KWgtpzwHX
         x8SO+wsoYRuPN2tEo0ZL+hNz3ysDIBxolofEPjJjkR4UAycvlk9nbY3vHhNXqD6Who
         7mjj40zhXjYxdqKLNhoq1U79Y92XqFJBB/v1k24vT2pxzTrDufuKRDxhWa8DImV7dK
         TA1ArQT1WFCag==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvYO5-000810-0j;
        Wed, 25 Oct 2023 09:33:09 +0200
Date:   Wed, 25 Oct 2023 09:33:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [RFC PATCH 1/2] serial: core: Move tty and serdev to be children
 of serial core port device
Message-ID: <ZTjEtWcF4a95BWBK@hovoldconsulting.com>
References: <20231024113624.54364-1-tony@atomide.com>
 <2023102401-playtime-moonrise-6f05@gregkh>
 <20231024122955.GL34982@atomide.com>
 <2023102442-statue-kept-febc@gregkh>
 <20231025065152.GO34982@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025065152.GO34982@atomide.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 09:51:52AM +0300, Tony Lindgren wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [231024 14:01]:

> > > > What does this change the sysfs tree to look like?

> Here's the diff of the same command before and after:
> 
> --- /tmp/before 2023-10-25 09:45:12.197283690 +0300
> +++ /tmp/after  2023-10-25 09:43:30.681797899 +0300
> @@ -1,7 +1,9 @@
>  # find /sys -name tty
>  /sys/class/tty
>  /sys/class/tty/tty
> -/sys/devices/pnp0/00:04/tty
> -/sys/devices/platform/serial8250/tty
> +/sys/devices/pnp0/00:04/00:04:0/00:04:0.0/tty
> +/sys/devices/platform/serial8250/serial8250:0/serial8250:0.3/tty
> +/sys/devices/platform/serial8250/serial8250:0/serial8250:0.1/tty
> +/sys/devices/platform/serial8250/serial8250:0/serial8250:0.2/tty
>  /sys/devices/virtual/tty
>  /sys/devices/virtual/tty/tty

Your diff is missing the actual tty devices. 'tty' is just the class
directory. 

And can you post the equivalent diff for serdev as well for completeness?

> There are multiple ports claimed by serial8250. So I think the new sysfs
> output is correct showing more ttys. If there's some reason why serial8250
> should only have one tty and this output is not correct let me know too..

There should not be more class devices, you've just moved them and thus
there are more class directories (with one device per directory).

Johan
