Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392297F3E09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjKVGSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVGSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:18:38 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C48D40;
        Tue, 21 Nov 2023 22:18:34 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 798D060852;
        Wed, 22 Nov 2023 06:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1700633913;
        bh=s2Rn9HZSrXpT1wimrPImmfufYVdONUvRoqjmZHEvbes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OoYqo2C9oHA9tXrpgOX+dWYtyewBVusp46hd+a/zwCo5Skm1JZBaAqBY+c2qDMNUV
         YKFbT+vCt9NA/OfC18UJq9WK402lwsLMZ3w4uNFevHkG9QxCituKGb7+XaBdOAwyjQ
         9FeNq3BfE2p0RWIV/55LrymCmxSIqWwRcHWO5+Rc6BMQy3gVurOlIcKGk4Grq1puVr
         moVB9Xwx6VQVd6/27FfDTmzdpBAQA8D4KTcv8ACydf2smsCi9ri5GOnQtF8v38cNn8
         NTWAa5x8eauL9f9tgO8102loKoMSHsQCb7pUwrrtatHgtXOJ9BWXHEtzg4ANv2WYoe
         of0M5APHo1rtw==
Date:   Wed, 22 Nov 2023 08:18:00 +0200
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
Subject: Re: [PATCH v3 1/3] printk: Save console options for
 add_preferred_console_match()
Message-ID: <20231122061800.GC5169@atomide.com>
References: <20231121113203.61341-1-tony@atomide.com>
 <20231121113203.61341-2-tony@atomide.com>
 <ZVzuih3Aw3hdfj2s@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVzuih3Aw3hdfj2s@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [231121 17:53]:
> On Tue, Nov 21, 2023 at 01:31:55PM +0200, Tony Lindgren wrote:
> > +#include <linux/console.h>
> 
> > +#include <linux/kernel.h>
> 
> I think instead of kernel.h you may want to see these:
> 
> linux/init.h
> linux/string.h
> 
> asm/errno.h
> 
> > +#include "console_cmdline.h"

OK

> > +/**
> > + * console_opt_save - Saves kernel command line console option for driver use
> > + * @str: Kernel command line console name and option
> > + *
> > + * Saves a kernel command line console option for driver subsystems to use for
> > + * adding a preferred console during init. Called from console_setup() only.
> 
> 	scripts/kernel-doc -v -none -Wall ...
> 
> most likely will complain (no Return section).

OK adding.

> > + */
> > +int __init console_opt_save(char *str)
> 
> str is not const? Hmm...

Nice yes it can be const char *str here. Hmm maybe with the third patch
also console_setup() can use const char * now.. Will check.

Thanks,

Tony
