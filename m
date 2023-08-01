Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D942F76B00E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjHAJ5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjHAJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EB112A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 875E661482
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4E9C433C8;
        Tue,  1 Aug 2023 09:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883802;
        bh=o9NJXNBvxerdPZqQCMCPQoowVldy3VF1ic/qIDVn3Rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XzkDIAi4uCLHbgpxBahPCuriZQpsHKJWZMbqK+GB6xA0LTt8+zHyr8ufzTou02Q9S
         9FXkWufmoo0GiVPd+IKsdIQPNjvcNbaWECLRIcF4ELElrPFvJBBEkz5NXo+S6c/RP2
         +Mq2KRIdSAme0XK0MgPcx3/T4C8Mk29JJRfo3XEA=
Date:   Tue, 1 Aug 2023 11:56:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 3/3] nvmem: core: Expose cells through sysfs
Message-ID: <2023080125-renovate-uptake-86f0@gregkh>
References: <20230717075147.43326-1-miquel.raynal@bootlin.com>
 <20230717075147.43326-4-miquel.raynal@bootlin.com>
 <2023071717-channel-supernova-4cc9@gregkh>
 <20230717183323.49a55ad0@xps-13>
 <2023071724-twiddling-morale-157e@gregkh>
 <20230731164642.49fea651@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731164642.49fea651@xps-13>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 05:33:13PM +0200, Miquel Raynal wrote:
> Hi Greg,
> 
> gregkh@linuxfoundation.org wrote on Mon, 17 Jul 2023 18:59:52 +0200:
> 
> > On Mon, Jul 17, 2023 at 06:33:23PM +0200, Miquel Raynal wrote:
> > > Hi Greg,
> > > 
> > > gregkh@linuxfoundation.org wrote on Mon, 17 Jul 2023 16:32:09 +0200:
> > >   
> > > > On Mon, Jul 17, 2023 at 09:51:47AM +0200, Miquel Raynal wrote:  
> > > > > The binary content of nvmem devices is available to the user so in the
> > > > > easiest cases, finding the content of a cell is rather easy as it is
> > > > > just a matter of looking at a known and fixed offset. However, nvmem
> > > > > layouts have been recently introduced to cope with more advanced
> > > > > situations, where the offset and size of the cells is not known in
> > > > > advance or is dynamic. When using layouts, more advanced parsers are
> > > > > used by the kernel in order to give direct access to the content of each
> > > > > cell, regardless of its position/size in the underlying
> > > > > device. Unfortunately, these information are not accessible by users,
> > > > > unless by fully re-implementing the parser logic in userland.
> > > > > 
> > > > > Let's expose the cells and their content through sysfs to avoid these
> > > > > situations. Of course the relevant NVMEM sysfs Kconfig option must be
> > > > > enabled for this support to be available.
> > > > > 
> > > > > Not all nvmem devices expose cells. Indeed, the .bin_attrs attribute
> > > > > group member will be filled at runtime only when relevant and will
> > > > > remain empty otherwise. In this case, as the cells attribute group will
> > > > > be empty, it will not lead to any additional folder/file creation.
> > > > > 
> > > > > Exposed cells are read-only. There is, in practice, everything in the
> > > > > core to support a write path, but as I don't see any need for that, I
> > > > > prefer to keep the interface simple (and probably safer). The interface
> > > > > is documented as being in the "testing" state which means we can later
> > > > > add a write attribute if though relevant.
> > > > > 
> > > > > There is one limitation though: if a layout is built as a module but is
> > > > > not properly installed in the system and loaded manually with insmod
> > > > > while the nvmem device driver was built-in, the cells won't appear in
> > > > > sysfs. But if done like that, the cells won't be usable by the built-in
> > > > > kernel drivers anyway.    
> > > > 
> > > > Wait, what?  That should not be an issue here, if so, then this change
> > > > is not correct and should be fixed as this is NOT an issue for sysfs
> > > > (otherwise the whole tree wouldn't work.)
> > > > 
> > > > Please fix up your dependancies if this is somehow not working properly.  
> > > 
> > > I'm not sure I fully get your point.
> > > 
> > > There is no way we can describe any dependency between a storage device
> > > driver and an nvmem layout. NVMEM is a pure software abstraction, the
> > > layout that will be chosen depends on the device tree, but if the
> > > layout has not been installed, there is no existing mechanism in
> > > the kernel to prevent it from being loaded (how do you know it's
> > > not on purpose?).  
> > 
> > Once a layout has been loaded, the sysfs files should show up, right?
> > Otherwise what does a "layout" do?  (hint, I have no idea, it's an odd
> > term to me...)
> 
> Sorry for the latency in responding to these questions, I'll try to
> clarify the situation.
> 
> We have:
> - device drivers (like NAND flashes, SPI-NOR flashes or EEPROMs) which
>   typically probe and register their devices into the nvmem
>   layer to expose their content through NVMEM.
> - each registration in NVMEM leads to the creation of the relevant
>   NVMEM cells which can then be used by other device drivers
>   (typically: a network controller retrieving a MAC address from an
>   EEPROM through the generic NVMEM abstraction).


So is a "cell" here a device in the device model?  Or something else?

> We recently covered a slightly new case: the NVMEM cells can be in
> random places in the storage devices so we need a "dynamic" way to
> discover them: this is the purpose of the NVMEM layouts. We know cell X
> is in the device, we just don't know where it is exactly at compile
> time, the layout driver will discover it dynamically for us at runtime.

So you then create the needed device when it is found?

> While the "static cells" parser is built-in the NVMEM subsystem, you
> explicitly asked to have the layouts modularized. This means
> registering a storage device in nvmem while no layout driver has been
> inserted yet is now a scenario. We cannot describe any dependency
> between a storage device and a layout driver. We cannot defer the probe
> either because device drivers which don't get access to their NVMEM
> cell are responsible of choosing what to do (most of the time, the idea
> is to fallback to a default value to avoid failing the probe for no
> reason).
> 
> So to answer your original question:
> 
> > Once a layout has been loaded, the sysfs files should show up, right?
> 
> No. The layouts are kind of "libraries" that the NVMEM subsystem uses
> to try exposing cells *when* a new device is registered in NVMEM (not
> later). The registration of an NVMEM layout does not trigger any new
> parsing, because that is not how the NVMEM subsystem was designed.

So they are a type of "class" right?  Why not just use class devices
then?

> I must emphasize that if the layout driver is installed in
> /lib/modules/ there is no problem, it will be loaded with
> usermodehelper. But if it is not, we can very well have the layout
> driver inserted after, and this case, while in practice possible, is
> irrelevant from a driver standpoint. It does not make any sense to have
> these cells created "after" because they are mostly used during probes.
> An easy workaround would be to unregister/register again the underlying
> storage device driver.

We really do not support any situation where a module is NOT in the
proper place when device discovery happens.  So this shouldn't be an
issue, yet you all mention it?  So how is it happening?

And if you used the class code, would that work better as mentioned
above?

thanks

greg k-h
