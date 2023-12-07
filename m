Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CEE8081CA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377758AbjLGHYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:24:09 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563D5137;
        Wed,  6 Dec 2023 23:24:15 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 883666045F;
        Thu,  7 Dec 2023 07:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1701933854;
        bh=GcpuyJOOGh2S7aKayPWmBRwvuTKxOUW0u06b5+DK914=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuqGEHQrbAWk1yb21SAy9bNFrQv3Imxp/zKD+WEEwF3NpYSl8w/HR8PVl+H3Ciy2M
         0sTR72cl0u9uKGlNCYgV7cNXLKVWtxVljT+aXHjg7XhuSYJXL54iM99PKyF8uZDgZz
         A22dj9ga2+TwhV6bE4As7GQj6Sw3nE2IeGh67apHrOA5X3YVnR+YF9pcc8NBX0QFFT
         ow7a2WwKumwCAzo2sBiBnE3sl2bTs00i3NJi2khMosHLbWFAwKmjIaSJWv8l80b28A
         6cr0htr0gQo+Wo2FA4yDGMYOeebWqkG6memKtCVc7xw7U5XGcwJHxO95Zo9xmd6Hqy
         Y+DPNskCYHBrQ==
Date:   Thu, 7 Dec 2023 09:23:41 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "David S . Miller" <davem@davemloft.net>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 4/4] serial: 8250: Add preferred console in
 serial8250_isa_init_ports()
Message-ID: <20231207072341.GU5169@atomide.com>
References: <20231205073255.20562-1-tony@atomide.com>
 <20231205073255.20562-5-tony@atomide.com>
 <ZW9LBXc8ars-rrh6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW9LBXc8ars-rrh6@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [231205 16:08]:
> On Tue, Dec 05, 2023 at 09:32:36AM +0200, Tony Lindgren wrote:
> > +	name = kasprintf(GFP_KERNEL, "%s%i", serial8250_reg.dev_name, idx);
> 
> No error check?

Oops

> > +	ret = add_preferred_console_match(name, serial8250_reg.dev_name, idx);
> > +	if (!ret || ret == -ENOENT)
> > +		return;
> 
> 	ret = serial_base_add_one_prefcon(...);
> 
> ?

Yup that should work even before struct device. Will fix the other
places too you noticed.

Thanks,

Tony
