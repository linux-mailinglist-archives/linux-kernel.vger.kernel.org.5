Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B79E7F3FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjKVIQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjKVIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:16:35 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F5D1BB;
        Wed, 22 Nov 2023 00:16:29 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 7327760859;
        Wed, 22 Nov 2023 08:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1700640989;
        bh=iwEe8AChNtrIiZ7XKdpROYcuo5U7nwfBFHt7j6A3wdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ui2Yfvh7LyuXcYTSk07DZ43XbcDuV7/Iqan6N4V5EXikxAZ4zYYzZBJtnZshDqu/x
         FYVLFo7fdIgEGlL8b/SxEvWGKW+HFnSbenPQhJXryaviKCLW9Xh+EdyHs/hHxMvTWk
         /pMiUO+4TmdVIN/0Qt7TtehHI0vwNOEtli1+zfTiHW5f/IDcKLoalZuJWNVOikUg94
         YcyHJKLTt2a+pKjgKOYbH68caZ4qFT8AoGSuZxi3jbdrvK9nX+81KCmN/Pl2aU1yEx
         4UAaGn6e0c9vwsjWCbmLw2gbSMjyzpijBR0RIrpxwk0da/mWnUbH8ZKIUP0bpW2bFE
         KamNaZBtG5lcQ==
Date:   Wed, 22 Nov 2023 10:15:54 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: core: Move console character device
 handling from printk
Message-ID: <20231122081554.GG5169@atomide.com>
References: <20231121113203.61341-1-tony@atomide.com>
 <20231121113203.61341-4-tony@atomide.com>
 <20231122070353.GF5169@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122070353.GF5169@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [231122 09:04]:
> * Tony Lindgren <tony@atomide.com> [700101 02:00]:
> > -	__add_preferred_console(buf, idx, options, brl_options, true);
> >  	return 1;
> 
> Looks like this can't be dropped yet. We need to keep it for the
> brl_options. I'll change it to return early if brl_options is NULL.

Looks like we can drop the parsing from printk :) In console_setup()
we can call console_opt_save() after _braille_console_setup(), and
then save also the brl_options for the port.

Regards,

Tony
