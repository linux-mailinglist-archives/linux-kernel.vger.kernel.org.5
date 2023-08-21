Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B48C78293F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbjHUMfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjHUMft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:35:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA984F0;
        Mon, 21 Aug 2023 05:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692621342; x=1724157342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lSXJmc9lJev1J6Hq8pjXtoxpQGrgSPsS4RxEeprd9Do=;
  b=e7H8x5uFtoHTzRShU3y1mfyfz5bD9L9TmV28jr4mf92bGhdHdLfw2f4w
   jQ3XyAlNF8AQJZYGuYJmjva+2YixqzxDvlIeL7303qbCcV5hdZa55bmyN
   hRkFECdMIkIKY/TIg3zUq1Pj5Kp45rrNECmWIpBP6ZcA34OTEHVzj27Io
   2sU46TfIAVyAAGr98SQMkyztzfOcHgKH3yiNOVArmwuQWdOzDrJE6Xv6u
   /Bz0bLenuZsfwl1bxeMvWIEJh3CeRZ4n6hvNTqISFR7yp8X0MEcGvarFv
   /Ifw+wope3UkMUZPH02x/yUBK6G4DQJQB55KFskm1cOZ2MNL8vrmsD/U8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="459944424"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="459944424"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 05:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="982448003"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="982448003"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 21 Aug 2023 05:35:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY48A-00E3NW-0G;
        Mon, 21 Aug 2023 15:35:38 +0300
Date:   Mon, 21 Aug 2023 15:35:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] of: dynamic: Move dead property list check into
 property add/update functions
Message-ID: <ZONaGYtfP0y+LgGP@smile.fi.intel.com>
References: <20230801-dt-changeset-fixes-v3-0-5f0410e007dd@kernel.org>
 <20230801-dt-changeset-fixes-v3-5-5f0410e007dd@kernel.org>
 <ZONBMMVrzuu53hwC@smile.fi.intel.com>
 <CAL_JsqJRQ0VFLHJYo6XHnUnyhtn3X6F2ZedsftnsviO_wOtcGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJRQ0VFLHJYo6XHnUnyhtn3X6F2ZedsftnsviO_wOtcGw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 07:24:43AM -0500, Rob Herring wrote:
> On Mon, Aug 21, 2023 at 5:49 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Aug 18, 2023 at 03:41:00PM -0500, Rob Herring wrote:

...

> > > v3:
> > >  - Keep existing style in deadprops loop
> >
> > Not sure where exactly in the code that one, but...
> 
> That was your previous comment...

I admit that I haven't heard about cleanup.h that time.

...

> > >  int __of_remove_property(struct device_node *np, struct property *prop)
> > >  {
> > > -     struct property **next;
> > > -
> > > -     for (next = &np->properties; *next; next = &(*next)->next) {
> > > -             if (*next == prop)
> > > -                     break;
> > > +     if (__of_remove_property_from_list(&np->properties, prop)) {
> > > +             /* Found the property, add it to deadprops list */
> > > +             prop->next = np->deadprops;
> > > +             np->deadprops = prop;
> > > +             return 0;
> > >       }
> > > -     if (*next == NULL)
> > > -             return -ENODEV;
> > > -
> > > -     /* found the node */
> > > -     *next = prop->next;
> > > -     prop->next = np->deadprops;
> > > -     np->deadprops = prop;
> > >
> > > -     return 0;
> > > +     return -ENODEV;
> > >  }
> >
> >
> > ...if it's this one, I don't see how it's better than
> >
> >         if (!__of_remove_property_from_list(&np->properties, prop))
> >                 return -ENODEV;
> 
> Because this way doesn't work well when we move the spinlock in here.
> Maybe cleanup.h will help, but I'm not going to do that now. If we do,
> then I'll do it for the whole subsystem/file.

Fair enough.

Although we may also use goto approach in the next patch. Anyway,
I leave it to you for what you think is the best.

-- 
With Best Regards,
Andy Shevchenko


