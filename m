Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4888378F8FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348469AbjIAHP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjIAHP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:15:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0004E49
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 00:15:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B3A6B824D6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B89BC433C8;
        Fri,  1 Sep 2023 07:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693552551;
        bh=tJnRm69x1hlaJM3ZyngxZksf1Q6XBI2KYsWBU6ZDeLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vXmhh0ipbaxFvTnGwWfXVW+6pffgEBMvQHOb5YYUpc12vj1n6rxOiGcTXSuLxr8Pp
         qQrTPDm5FBFdOLP04ZwXtv6afBFX7KwUIi3/MgWXvgZjcsYOBPGPBFWsLaiPEg7ZLH
         QKClhYzB80XyZuI925tZ2zcXDaAb5IlqbAEqEXcc=
Date:   Fri, 1 Sep 2023 09:15:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: Stability guarantees on uevent variables?
Message-ID: <2023090142-hurry-laundry-ad43@gregkh>
References: <c0d32695-9e3e-4173-8448-7d123f38824e@notapiano>
 <2023083110-delicacy-thinly-5af6@gregkh>
 <d53d3200-fe59-4b69-893b-479b7402f572@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d53d3200-fe59-4b69-893b-479b7402f572@notapiano>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 05:58:36PM -0400, Nícolas F. R. A. Prado wrote:
> On Thu, Aug 31, 2023 at 09:58:04AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Aug 24, 2023 at 07:08:39PM -0400, Nícolas F. R. A. Prado wrote:
> > > Hi,
> > > 
> > > my question boils down to the following:
> > > 
> > > Is there a stability guarantee on the format and content of the variables in
> > > uevents produced by the kernel?
> > 
> > Only if the normal userspace tools that use those variables require it.
> > 
> > > I would assume so, given that uevents are explicitly produced for userspace, and
> > > users will rely on them. However, looking through the ABI documentation I could
> > > only find two instances of uevents being defined (testing/usb-uevent and
> > > testing/usb-charger-uevent) and neither mention the variables added in the
> > > KOBJ_ADD action. The document for the uevent file in sysfs,
> > > testing/sysfs-uevent, only mentions writing synthetic uevents, rather than
> > > reading existing ones. Is the documentation simply lacking or is it intentional
> > > that uevent variables aren't covered?
> > > 
> > > I'm particularly interested in the format for the MODALIAS uevent variable. My
> > > understanding is that its only use is to match against the modules' aliases in
> > > the modules.alias file. For that reason I'm wondering whether for this variable,
> > > the guarantee would only be that the format of the value will match the one in
> > > modules.alias, but the precise format is not guaranteed (for example, a new
> > > field could potentially be introduced in the future if added to both the device
> > > uevent and module's alias). However, I do see a few ABI documentation pages for
> > > the modalias file in sysfs (eg in testing/sysfs-bus-pci), which explicitly
> > > describe the format, and that's supposed to be the same as the MODALIAS uevent,
> > > so does that mean the format itself is stable?
> > 
> > No, modalias is not stable, it can change over time (add new fields), as
> > it is just a userspace representation of how to call 'modprobe' and
> > match up with the kernel-provided module alias fields.
> > 
> > So the value will always match the module alias fields, but userspace
> > shouldn't be attempting to parse the thing at all, as that makes no
> > sense (the kernel understands the format, userspace does not need to.)
> 
> I see, that's what I suspected. In that case detailing the format of the
> modalias files in the ABI documentation seems counter-productive. I'll send a
> patch removing those format descriptions.

We can document it, as long as the documentation stays up to date, it
can't hurt, right?

> > > I'll be happy to improve the ABI documentation based on the reply to these
> > > questions.
> > > 
> > > As for the full context for these questions, as part of an effort to improve the
> > > detection of regressions affecting device probe, I want to be able to check
> > > whether devices under a discoverable bus (USB, PCI) were populated and probed by
> > > a driver.
> > 
> > So you want to see if a driver is possible for this device, or if the
> > driver failed to bind to the device?  Those are different things.
> 
> In this instance, I only want to see if a driver failed to bind to the device.

Then look at the driver sysfs entry to find out what devices it is bound
to.

> > > We currently do this by checking against driver and device names [1],
> > > but as has been pointed out before, that's not stable ABI, and the test might
> > > break if things get renamed or moved around.
> > 
> > Yes, driver names get changed all the time, and move around the kernel
> > tree as well.  That's not going to stop, but it shouldn't affect
> > testing, right?
> 
> Indeed, but if we can test just as well and only relying on stable ABIs, that's
> less maintenance :) (as well as less false-positives reported to the mailing
> lists if the reporting becomes automatic). Especially since we test not only
> mainline but also stable kernels and currently end up having to special case the
> tests based on kernel version.

I still don't understand what you are trying to test here.  You are
thinking that devices remain with the same names over time (they don't),
or drivers remain with the same names over time (they don't) or that
device topologies stay the same over time (they don't).

All that matters is how userspace sees the _functionality_ of the system
(i.e. if a mouse appears to userspace), not what the mouse driver was
called, what mouse device was in the device topology, or what driver was
bound to the mouse.

So test system functionality please, that's what should always remain
stable.  Not device names, locations, or driver names.

Now if you want to write unit tests for specific drivers, that's a
different story, but I don't think that's what you are attempting to do
here.

> So the approach I'm favoring is to keep having a per-platform list of devices
> expected to be probed from USB and PCI, but instead of using driver and device
> names, in order to make the tests use stable ABI, I was planning to use the
> modalias for the device instead. But as that's not stable as well, I will look
> into the other uevent variables.

Everything is unstable here because the hardware platform itself is
unstable and non-determinisitic.  Which is why we created the driver
model and sysfs so that userspace can use hints to find the same device
no matter where in the device tree it is, nor what it is called
depending on an attribute that is unique for that device (look at
/dev/disk/ for examples.)

> I see there are a few for USB
> (PRODUCT, TYPE, INTERFACE) and PCI (PCI_CLASS, PCI_ID, PCI_SUBSYS_ID,
> PCI_SLOT_NAME). I'll try to find out who the normal userspace tools using these
> are, to be able to say whether they can be documented as stable ABI or not.

Some of those attributes come directly from the hardware itself, so as
long as the hardware doesn't change, they should not.  Don't get the
ones that can change (i.e. locations or bus numbers or the like)
confused here.

good luck!

greg k-h
