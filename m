Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34B077BC9C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjHNPNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjHNPNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:13:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B3BE77;
        Mon, 14 Aug 2023 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692025985; x=1723561985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vweF0NhHQHmLFNJJCA8R1t0Md8M3C1n1VX4Sto42i5A=;
  b=Tv8G2rsyreIsQ6xIHWZsmNKQQW4pNRyPRXcKqtY6fcM6Uxy1rKCpxA/4
   HMKFvibzG8HnAOVPIy80ouM922ooPKXMasOLV3/mcpRePe402IwKc+Krv
   vVVteeRh492Ax8XI30HQmlSExwIJMN/hFBnrTZxCwCyUyNtUv/9EoWyvx
   GM+hkzfxEyQTMuU/Pv/hrJuO2IjE8oXjJxb3Hf69egdK2oV5QQLbfquW+
   znjiNF4Kiirc8vTwJBDFONAkfYv5kZcITtZdlzeOPlq4769E3JzDJlE+p
   qqnWzIZ9Cd3/C0vjFUGAU+g4X6k4j4+SqtGrSVU8ofrNYPekfwyX19q/T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="374835076"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="374835076"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 08:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="847694803"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="847694803"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 14 Aug 2023 08:13:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVZFc-00AA8u-0Y;
        Mon, 14 Aug 2023 18:13:00 +0300
Date:   Mon, 14 Aug 2023 18:12:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, opendmb@gmail.com,
        Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
        "open list:TTY LAYER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_bcm7271: improve bcm7271 8250 port
Message-ID: <ZNpEe+nmXGAkEbAb@smile.fi.intel.com>
References: <1691792050-25042-1-git-send-email-justin.chen@broadcom.com>
 <2023081221-truth-footsie-b5ab@gregkh>
 <CALSSxFZyQCCupuXC7=z3yoO7xhVY3Grw_zFsdWKrE+txk9-S1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALSSxFZyQCCupuXC7=z3yoO7xhVY3Grw_zFsdWKrE+txk9-S1Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 09:24:21PM -0700, Justin Chen wrote:
> On Sat, Aug 12, 2023 at 3:50 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Fri, Aug 11, 2023 at 03:14:01PM -0700, Justin Chen wrote:

> > > +     [PORT_BCM7271] = {
> > > +             .name           = "bcm7271_uart",

This is badly named port type.

> > > +             .fifo_size      = 32,
> > > +             .tx_loadsz      = 32,
> > > +             .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01,
> > > +             .rxtrig_bytes   = {1, 8, 16, 30},
> > > +             .flags          = UART_CAP_FIFO | UART_CAP_AFE
> > > +     },
> > >  };

This is almost a dup of PORT_ALTR_16550_F32. Use it if you wish.
You can always rename it if it feels the right thing to do.

But why 8 and not 16 is the default rxtrig?

-- 
With Best Regards,
Andy Shevchenko


