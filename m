Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E629178F4F0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347644AbjHaV6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHaV6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:58:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D06211B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:58:42 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 52A3766072A4;
        Thu, 31 Aug 2023 22:58:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693519121;
        bh=GLflrvHC5XgBQ62wicWcw6i11UYI9ckJCqulQpQX9HE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lUbxTaao5clCCN5RTCfkqDaW42hUtfuRoERpGvjBS09xBdlBPYiRV9ZeVCXSvm/in
         bELpEaWJiXuQLxeoutUQtOnl933sNw8PhuP84rj5HMklfRGyfY3AECrxEMG6yF27Z5
         B65O+AB5A0scLMpf9fTZHsAxXDThVVA+GzLNIlIcCL8gik52Up3JDVxO7vMJ0MiXIl
         5m/vp4rqsfmfdJNmyNi/+PcqKVGlu6LsC3f/7HYXKSBOIkJT6qfI0yotdzZcVSEZd6
         qR8wIwwioX2R9IsIeUZIx6a8DVElxTMk7mGBHK41dD+Wh6syQzbsJAHq+g8wG9J6HS
         aF3qDrqcSOg6w==
Date:   Thu, 31 Aug 2023 17:58:36 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: Stability guarantees on uevent variables?
Message-ID: <d53d3200-fe59-4b69-893b-479b7402f572@notapiano>
References: <c0d32695-9e3e-4173-8448-7d123f38824e@notapiano>
 <2023083110-delicacy-thinly-5af6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023083110-delicacy-thinly-5af6@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 09:58:04AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 24, 2023 at 07:08:39PM -0400, Nícolas F. R. A. Prado wrote:
> > Hi,
> > 
> > my question boils down to the following:
> > 
> > Is there a stability guarantee on the format and content of the variables in
> > uevents produced by the kernel?
> 
> Only if the normal userspace tools that use those variables require it.
> 
> > I would assume so, given that uevents are explicitly produced for userspace, and
> > users will rely on them. However, looking through the ABI documentation I could
> > only find two instances of uevents being defined (testing/usb-uevent and
> > testing/usb-charger-uevent) and neither mention the variables added in the
> > KOBJ_ADD action. The document for the uevent file in sysfs,
> > testing/sysfs-uevent, only mentions writing synthetic uevents, rather than
> > reading existing ones. Is the documentation simply lacking or is it intentional
> > that uevent variables aren't covered?
> > 
> > I'm particularly interested in the format for the MODALIAS uevent variable. My
> > understanding is that its only use is to match against the modules' aliases in
> > the modules.alias file. For that reason I'm wondering whether for this variable,
> > the guarantee would only be that the format of the value will match the one in
> > modules.alias, but the precise format is not guaranteed (for example, a new
> > field could potentially be introduced in the future if added to both the device
> > uevent and module's alias). However, I do see a few ABI documentation pages for
> > the modalias file in sysfs (eg in testing/sysfs-bus-pci), which explicitly
> > describe the format, and that's supposed to be the same as the MODALIAS uevent,
> > so does that mean the format itself is stable?
> 
> No, modalias is not stable, it can change over time (add new fields), as
> it is just a userspace representation of how to call 'modprobe' and
> match up with the kernel-provided module alias fields.
> 
> So the value will always match the module alias fields, but userspace
> shouldn't be attempting to parse the thing at all, as that makes no
> sense (the kernel understands the format, userspace does not need to.)

I see, that's what I suspected. In that case detailing the format of the
modalias files in the ABI documentation seems counter-productive. I'll send a
patch removing those format descriptions.

> 
> > I'll be happy to improve the ABI documentation based on the reply to these
> > questions.
> > 
> > As for the full context for these questions, as part of an effort to improve the
> > detection of regressions affecting device probe, I want to be able to check
> > whether devices under a discoverable bus (USB, PCI) were populated and probed by
> > a driver.
> 
> So you want to see if a driver is possible for this device, or if the
> driver failed to bind to the device?  Those are different things.

In this instance, I only want to see if a driver failed to bind to the device.

> 
> > We currently do this by checking against driver and device names [1],
> > but as has been pointed out before, that's not stable ABI, and the test might
> > break if things get renamed or moved around.
> 
> Yes, driver names get changed all the time, and move around the kernel
> tree as well.  That's not going to stop, but it shouldn't affect
> testing, right?

Indeed, but if we can test just as well and only relying on stable ABIs, that's
less maintenance :) (as well as less false-positives reported to the mailing
lists if the reporting becomes automatic). Especially since we test not only
mainline but also stable kernels and currently end up having to special case the
tests based on kernel version.

> 
> > So my intention is to change that
> > check to use modaliases or other uevents to find the device in a stable way and
> > check for the driver symlink to verify it's been probed.
> 
> Just use the symlink, that shows if a device actually has a driver bound
> to it.  Note that drivers can refuse to bind to a device for loads of
> reasons, even if it's probe function is properly called by the kernel.
> 
> So for regressions, just see if there is a link from all devices to a
> driver and you should be fine.  No need to mess around with module
> aliases at all, as you don't want to put the parsing of those structures
> in userspace as well, right?

I do simply check the driver symlink to figure out if the device was probed by
the driver. The question here is about finding where in sysfs the devices I want
to check are, in a stable way.

Just checking all devices doesn't work because not all devices can be expected
to bind to a driver, even when talking just about USB and PCI devices.

Another option I've considered is to first figure out what devices can match to
drivers (similar to what I did for DT devices [1]), by parsing the id_tables and
building a list to use as a filter. The limitation of this approach is that it
relies on devices being listed on sysfs to be tested in the first place. So
regressions affecting USB enumeration or elsewhere in the device registration
would go unnoticed.

So the approach I'm favoring is to keep having a per-platform list of devices
expected to be probed from USB and PCI, but instead of using driver and device
names, in order to make the tests use stable ABI, I was planning to use the
modalias for the device instead. But as that's not stable as well, I will look
into the other uevent variables. I see there are a few for USB
(PRODUCT, TYPE, INTERFACE) and PCI (PCI_CLASS, PCI_ID, PCI_SUBSYS_ID,
PCI_SLOT_NAME). I'll try to find out who the normal userspace tools using these
are, to be able to say whether they can be documented as stable ABI or not.

Thanks,
Nícolas

[1] https://lore.kernel.org/all/20230828211424.2964562-1-nfraprado@collabora.com
