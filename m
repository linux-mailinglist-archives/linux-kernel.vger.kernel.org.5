Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D309180F6B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376876AbjLLTb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjLLTb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:31:28 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 60BD69B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:31:33 -0800 (PST)
Received: (qmail 175710 invoked by uid 1000); 12 Dec 2023 14:31:31 -0500
Date:   Tue, 12 Dec 2023 14:31:31 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kevin Hilman <khilman@kernel.org>
Cc:     =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
        Roger Quadros <rogerq@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "Vardhan, Vibhore" <vibhore@ti.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/6] usb: cdns3-ti: add suspend/resume procedures for
 J7200
Message-ID: <ae99430d-12a3-4831-b4b7-586d6d045b15@rowland.harvard.edu>
References: <CX0GOP07I40N.198G7LJ0HYDBG@tleb-bootlin-xps13-01>
 <bdea68ad-7523-4738-8fa1-b670d81a6b93@kernel.org>
 <CX10D9YX1O1C.30PF317AG065N@tleb-bootlin-xps13-01>
 <3e00b2ad-b58f-4b09-9230-683c58d3bb92@kernel.org>
 <CX15J7B8F8HH.1WZ10OOW31X1H@tleb-bootlin-xps13-01>
 <7h34wxfmwn.fsf@baylibre.com>
 <CX63KP2UPL1N.J9Q344Q06IGP@tleb-bootlin-xps13-01>
 <7hil5odtwl.fsf@baylibre.com>
 <CX9MMPFL7HAY.NGULD1FN5WPN@tleb-bootlin-xps13-01>
 <7h7cljcm6a.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7h7cljcm6a.fsf@baylibre.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:26:05AM -0800, Kevin Hilman wrote:
> Théo Lebrun <theo.lebrun@bootlin.com> writes:

> 
> > Hello,
> >
> > On Sun Nov 26, 2023 at 11:36 PM CET, Kevin Hilman wrote:
> >> Théo Lebrun <theo.lebrun@bootlin.com> writes:
> >> > On Wed Nov 22, 2023 at 11:23 PM CET, Kevin Hilman wrote:
> >> >> Théo Lebrun <theo.lebrun@bootlin.com> writes:
> >> >> The point is to signal to the power domain the device is in that it can
> >> >> power on/off.  These IP blocks are (re)used on many different SoCs, so
> >> >> the driver should not make any assumptions about what power domain it is
> >> >> in (if any.)
> >> >
> >> > On my platform, when the device is attached to the PD it gets turned on.
> >> > That feels logical to me: if a driver is not RPM aware it "just works".
> >>
> >> It "just works"... until the domain gets turned off.
> >>
> >> > Are there platforms where RPM must get enabled for the attached
> >> > power-domains to be turned on?
> >>
> >> Yes, but but more importantly, there are platforms where RPM must get
> >> enabled for the power domain to *stay* on.  For example, the power
> >> domain might get turned on due to devices probing etc, but as soon as
> >> all the RPM-enabled drivers drop their refcount, the domain will turn
> >> off.  If there is a device in that domain with a non-RPM enabled driver,
> >> that device will be powered off anc cause a crash.
> >
> > OK, that makes sense, thanks for taking the time to explain. This topic
> > makes me see two things that I feel are close to being bugs. I'd be
> > curious to get your view on both.
> 
> TL;DR; they are features, not bugs.  ;)
> 
> >  - If a device does not use RPM but its children do, it might get its
> >    associated power-domain turned off. That forces every single driver
> >    that want to stay alive to enable & increment RPM.
> >
> >    What I naively expect: a genpd with a device attached to it that is
> >    not using RPM should mean that it should not be powered off at
> >    runtime_suspend. Benefit: no RPM calls in drivers that do not use
> >    it, and the behavior is that the genpd associated stays alive "as
> >    expected".
> 
> Your expectation makes sense, but unfortunately, that's not how RPM was
> designed.

I'm not sure how runtime PM is meant to work with power domains.  

However, from the very beginning of runtime PM the intention was that 
device drivers and subsystems could safely ignore it.  Their devices 
would have a permanently nonzero disable_depth (permanent because the 
driver/subsystem would not know to change it) and therefore would always 
remain in the active state (see rpm_check_suspend_allowed()).

It would be very surprising if runtime PM for power domains was written 
in a way that would subvert this intention.

Alan Stern
