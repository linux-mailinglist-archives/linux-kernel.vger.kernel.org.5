Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AF577C800
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjHOGoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbjHOGoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:44:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD1C1984;
        Mon, 14 Aug 2023 23:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692081843; x=1723617843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SJCFz23iMorp2MSescO5CvL1mFsihA9SKEwVgqbFojM=;
  b=kc/JTJHUQCEfibuwUIUHxklU48kaYF9wJqmoEktfig52z5llPSvGl/4P
   h8nj4dGPisT5BPnueMydLmRWJJWCdc01knfCktAB1QZ95Bs3OIvBt7DDp
   MZi2RqVsRuaf4NBDZOwYiiMwf97so1vda5XltIckq0HmM68Jkiz4b9bka
   FisPuoL8VaiGA+ggupHUZLyZc7a7xhXgjTcvPGnuh7hI45CuvRiP6H0P2
   U0YRIZGuynyXEldBVisCh2mZnn9DTi+7xalmNHY1rTGvsjW4mc/Gp2s6q
   SBSVpRDIW5AcyTa5e0NmHr0KY+9pGzHcelIVLvU7fd/DRWugZQ9ghlBhA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="372210271"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="372210271"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 23:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="847948778"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="847948778"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 14 Aug 2023 23:43:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVnmX-006sLk-2v;
        Tue, 15 Aug 2023 09:43:57 +0300
Date:   Tue, 15 Aug 2023 09:43:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Justin Chen <justin.chen@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
        "open list:TTY LAYER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_bcm7271: improve bcm7271 8250 port
Message-ID: <ZNsercXiIhPZ4vyB@smile.fi.intel.com>
References: <1691792050-25042-1-git-send-email-justin.chen@broadcom.com>
 <2023081221-truth-footsie-b5ab@gregkh>
 <CALSSxFZyQCCupuXC7=z3yoO7xhVY3Grw_zFsdWKrE+txk9-S1Q@mail.gmail.com>
 <ZNpEe+nmXGAkEbAb@smile.fi.intel.com>
 <533b62f7-a6c2-b360-13e0-b873a1a54251@broadcom.com>
 <5d4757d4-6143-8179-9df9-2de56a716773@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d4757d4-6143-8179-9df9-2de56a716773@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 11:09:46AM -0700, Doug Berger wrote:
> On 8/14/2023 9:28 AM, Justin Chen wrote:
> > On 8/14/23 8:12 AM, Andy Shevchenko wrote:
> > > On Sat, Aug 12, 2023 at 09:24:21PM -0700, Justin Chen wrote:
> > > > On Sat, Aug 12, 2023 at 3:50 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > > On Fri, Aug 11, 2023 at 03:14:01PM -0700, Justin Chen wrote:

...

> > > > > > +     [PORT_BCM7271] = {
> > > > > > +             .name           = "bcm7271_uart",
> > > 
> > > This is badly named port type.
> > > 
> This may be true, but it does mirror the PORT_BCM63XX naming and I do value
> consistency so it is acceptable to me. However, I will happily yield to a
> better name if one can be determined by popular consensus.
> 
> > 
> > Would "Brcmstb 7271 UART" suffice?
> > 
> Perhaps, "Broadcom BCM7271 UART" but it seems excessively "chatty" to me, so
> as I said I am OK with the original submission.

I'm not okay, sorry. But your variant seems the best from all proposed.

> > > > > > +             .fifo_size      = 32,
> > > > > > +             .tx_loadsz      = 32,
> > > > > > +             .fcr            = UART_FCR_ENABLE_FIFO |
> > > > > > UART_FCR_R_TRIG_01,
> > > > > > +             .rxtrig_bytes   = {1, 8, 16, 30},
> > > > > > +             .flags          = UART_CAP_FIFO | UART_CAP_AFE
> > > > > > +     },
> > > > > >   };
> > > 
> > > This is almost a dup of PORT_ALTR_16550_F32. Use it if you wish.
> > > You can always rename it if it feels the right thing to do.
> > > 
> > 
> > There is some other PORT_ALTR logic that I would like to avoid. I would
> > also like to avoid future changes to PORT_ALTR that wouldn't be
> > applicable to us.
> I too am reluctant to introduce yet another port type, but Justin is correct
> in pointing out that the PORT_ALTR_16550_* port types include Tx FIFO
> threshold programming that is incompatible with the BCM7271 UART hardware.
> This port type does appear necessary to address fundamental differences in
> the hardware unless we are willing to scrap the uart_config[] array and have
> the individual drivers manage these differences (which I would also be OK
> with, but I am just a tail on this dog).
> 
> The BCM7271 UART IP does support programmable Tx FIFO thresholds in a
> different way, so if I (or someone else) decided to enable support for that
> it would appear that this new port type would be necessary at that time as
> well.

All these details are missing in the initial submission. How should we know all
that? Please, amend the commit message accordingly.

> > > But why 8 and not 16 is the default rxtrig?
> > 
> > We were seeing some latency issues on our chips where 16 would cause
> > overflows. Trying to kill 2 birds with one stone. If creating another
> > port type is avoidable then alternatively I can change the default in
> > userspace.

Also choose the number less than 124, IIRC we have gaps that may be filled.

-- 
With Best Regards,
Andy Shevchenko


