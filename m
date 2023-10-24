Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA7C7D54AC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjJXPFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJXPFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:05:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA80122;
        Tue, 24 Oct 2023 08:05:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05EFC433C8;
        Tue, 24 Oct 2023 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698159950;
        bh=F93LEIRwPkxkpX2KL1Aw1knTdXl/0lgfHPPX7S8mhD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dPzCN4kZNZYS/Q/tRDSaHBrvar62KBf4MMY+yYOVK60ZkucgZse8twWqCec42Ck+d
         Gvo7ebBRTAb5vW3eeeIaFl8lvUGNt9za+gToWm/ZYzGQTZGkK0Zb5AN/DqzvVDh+Iq
         bEZrfFY8yvLvvXUBWprjBCKEJyeKPdoJfPKJoL5g=
Date:   Tue, 24 Oct 2023 17:05:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, miquel.raynal@bootlin.com
Subject: Re: [PATCH v2 1/1] tty: i3c: add TTY over I3C master support
Message-ID: <2023102442-immorally-repost-e736@gregkh>
References: <20231020160027.3663772-1-Frank.Li@nxp.com>
 <2023102105-outfit-legroom-1633@gregkh>
 <ZTaewidgtcDaBega@lizhi-Precision-Tower-5810>
 <2023102457-galore-uphill-4c84@gregkh>
 <ZTfVV3DW8jqH6ek9@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTfVV3DW8jqH6ek9@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 10:31:51AM -0400, Frank Li wrote:
> On Tue, Oct 24, 2023 at 11:30:33AM +0200, Greg KH wrote:
> > On Mon, Oct 23, 2023 at 12:26:42PM -0400, Frank Li wrote:
> > > On Sat, Oct 21, 2023 at 07:02:40PM +0200, Greg KH wrote:
> > > > Note, your subject line needs to change.
> > > > 
> > > > On Fri, Oct 20, 2023 at 12:00:27PM -0400, Frank Li wrote:
> > > > > In typical embedded Linux systems, UART consoles require at least two pins,
> > > > > TX and RX. In scenarios where I2C/I3C devices like sensors or PMICs are
> > > > > present, we can save these two pins by using this driver. Pins is crucial
> > > > 
> > > > "Pins are crucial"
> > > > 
> > > > > resources, especially in small chip packages.
> > > > > 
> > > > > This introduces support for using the I3C bus to transfer console tty data,
> > > > > effectively replacing the need for dedicated UART pins. This not only
> > > > > conserves valuable pin resources but also facilitates testing of I3C's
> > > > > advanced features, including early termination, in-band interrupt (IBI)
> > > > > support, and the creation of more complex data patterns. Additionally,
> > > > > it aids in identifying and addressing issues within the I3C controller
> > > > > driver.
> > > > 
> > > > But where is the serial data ending up at?  Not a normal uart, what is
> > > > on the other end?  And do line settings mean anything here?
> > > 
> > > Currently, it use slave i3c code. 
> > > https://lore.kernel.org/imx/20231018215809.3477437-1-Frank.Li@nxp.com/T/#t
> > > 
> > > idealy build an i3c->usb dongle to bride it to usb acm. 
> > 
> > So no one has built such a thing yet to determine if any of this works?
> 
> It is easy to proof concept by I3C slave code and USB gadget ACM, then pipe
> two tty (ttyACM0 and ttySI3C0 together).

So you have not actually tested this?  why write a driver that no one is
using?

> Of we also can implement a USB to I3C class standard, base on this, reuse
> this tty driver at host side.

Is there a USB I3C standard?  I see i3c descriptors assigned by the
USB-IF, but haven't dug to see if there's more than that anywhere...

thanks,

greg k-h
