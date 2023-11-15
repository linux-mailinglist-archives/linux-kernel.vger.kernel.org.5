Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A017ED1ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344265AbjKOUXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKOUXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:23:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9374DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:23:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50021C433C8;
        Wed, 15 Nov 2023 20:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700079809;
        bh=gabJ5os+xjeNpC+/5fAtNZcqD3iV33NQ/cAdC59SDeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdL+QufB/iE97IKDDSJZF2KstB/Lpihw4KL0t2gZlNHJ+b2qANVNv2SCKm2esd5z1
         E20NuEUjVbyvsn2OeGfXqvN0KkC5nErJW6Q+G/fGULJPWJQc4xn1F02D23nDlEQvZU
         Cz2z7YoFN3r58FYxQ5JHOSWLkUHWGUQoafT8ohEU=
Date:   Wed, 15 Nov 2023 15:21:29 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
Message-ID: <2023111513-stinky-doorframe-8cd1@gregkh>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
 <2023102624-moonshine-duller-3043@gregkh>
 <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
 <ZUPBVMdi3hcTyW2n@smile.fi.intel.com>
 <CAMRc=MeV9ZyOzuQFEE_duPTHYgfmr6UZU6bpjDPhrczZX4PHpg@mail.gmail.com>
 <CAMRc=MdSpk_OszeDCyA5_Sp-w=sL9DHB2gGCOFP+FCiobm2cbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdSpk_OszeDCyA5_Sp-w=sL9DHB2gGCOFP+FCiobm2cbA@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 03:58:54PM +0100, Bartosz Golaszewski wrote:
> On Fri, Nov 3, 2023 at 10:08 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Thu, Nov 2, 2023 at 4:33 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:
> > > > > > Some users want to use the struct device pointer to see if the
> > > > > > device is big endian in terms of Open Firmware specifications,
> > > > > > i.e. if it has a "big-endian" property, or if the kernel was
> > > > > > compiled for BE *and* the device has a "native-endian" property.
> > > > > >
> > > > > > Provide inline helper for the users.
> > > > >
> > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > Thank you, Greg.
> > > >
> > > > Bart, would it be still possible to take this into next?
> > > > I would like to have at least this patch applied (with the first user)
> > > > to allow conversion of others (I have some more users of new API).
> > >
> > > Okay, seems we missed v6.7 with this, can you then prepare an immutable
> > > branch / tag with this, so other maintainers can pull in case it's needed?
> > > (I have something against tty already and perhaps something else, let's
> > >  see.)
> > >
> >
> > It arrived too late in the cycle, I needed to send my PR earlier this
> > time as I was OoO this week.
> >
> > Bart
> 
> Greg, will you take this patch through your tree and provide me with
> an immutable tag for this cycle?

Sure, let me catch up with patches after I return from Plumbers next
week.

greg k-h
