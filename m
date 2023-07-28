Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE65767098
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbjG1PcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbjG1PcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:32:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4193C00;
        Fri, 28 Jul 2023 08:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D5106217D;
        Fri, 28 Jul 2023 15:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D48DC433C7;
        Fri, 28 Jul 2023 15:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690558323;
        bh=G9xffw7AcSqcGsuyvK1ntyxyXN2exlaXtmZ6m57su60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0N8IPH5S8+Q3dFcVtFuZU2fFzscOYRO8Ahsl7QY+RljM2OU6IoEQAYORaEFt2TBU
         wyA0zMLKmkWh2qzIVABpXaWsmkSbMHibpltC9cOLFukAjGY//j14YnhSxlKGbZltpH
         /vWHUY5rGrCFcR1ptXBCZAJ0XSuRmBVGnsWbSvUc=
Date:   Fri, 28 Jul 2023 17:32:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?Q?=C5=81ukasz?= Bartosik <lb@semihalf.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: Re: [PATCH v1 1/2] thunderbolt: add tracefs support to tb_* logging
 helpers
Message-ID: <2023072825-alfalfa-skincare-23b2@gregkh>
References: <20230727131326.2282301-1-lb@semihalf.com>
 <2023072705-palpitate-cut-874b@gregkh>
 <CAK8ByeJYtFcMbEabSDJwXhE3jYY2xQG+JHR0gpwh6_=yg+AXjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8ByeJYtFcMbEabSDJwXhE3jYY2xQG+JHR0gpwh6_=yg+AXjw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 04:50:12PM +0200, Łukasz Bartosik wrote:
> czw., 27 lip 2023 o 16:47 Greg KH <gregkh@linuxfoundation.org> napisał(a):
> >
> > On Thu, Jul 27, 2023 at 03:13:25PM +0200, Łukasz Bartosik wrote:
> > > Thunderbolt tracing is a lightweight alternative to traditional
> > > thunderbolt debug logging. While thunderbolt debug logging is quite
> > > convenient when reproducing a specific issue, it doesn't help when
> > > something goes wrong unexpectedly. There are a couple of reasons why
> > > one does not want to enable thunderbolt debug logging at all times:
> > >
> > > 1. We don't want to overwhelm kernel log with thunderbolt spam, others
> > >    want to use it too
> >
> > But doesn't the dynamic debug infrastructure allow this today?
> >
> 
> Dynamic debug allows only partially what we would like to achieve.
> 
> Our goal is to be able to gather thunderbolt debug logs from ChromeOS
> end users when an issue happens. Especially that would be very useful
> for us in case of issues which reproduction is difficult. We would
> write thunderbolt debug logs to a separate wrap around buffer provided
> by trace subsystem. When an issue happens and a user sends a feedback
> then thunderbolt logs would be attached to the feedback providing
> more insight into what happened.

The problem is, you don't want 100 different debug log formats and tools
for the 100 different driver subsystems.

That is why we unified everything on the dev_* format, and the tracing
tools.  Use them, don't create something new.

> Dynamic debug sends all debug messages to dmesg and with significant
> number of dynamic dev_dbg prints enabled dmesg may be quickly overwritten
> and other important logs lost. Also enabling dynamic debug for the
> entire kernel might
> not be appropriate for production kernels due to impact on kernel size and perf.

If you look at the typec code, they have their own type of ring-buffer
for logging things.  Perhaps look at making that more generic like what
you need here as well, and adding that to the tracing core for everyone
to use and unify with?

I don't want one-off solutions like this, sorry, that way lies madness,
madness that we used to have before we unified everything.  Let's learn
from our past mistakes and not make them again please.

thanks,

greg k-h
