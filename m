Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA40F7DCEBE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjJaOFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjJaOFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:05:08 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE6AF1;
        Tue, 31 Oct 2023 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=n82YEEI1FUC/itM1tuyemVtoc1RFlGBRO7Oj8tFvb3E=; b=BjwlepdiJ/TN4Lz2ozay2zVLr0
        hTTPnAj7fDuNYBCXSa/xzHEWFhsgdfIZo7BHAowmfuiF9zpCweIxoe94EX+QRHVZ0z0VqJkPljmLu
        tLdtFZuyrQyDavc6wgsEJ0EzQJzGL2IqqTd96+b7GBRKbytUYmtcJKJMab4jViuUPyuFcPUZFiTzS
        C+w+FiG4x2KY0tdUQQNnFCHaBRzQXgnL+5C+eq2DvuqnyEerzA7sypK0UVg9TY1JGm5/NXW+YuE//
        v5U0vmDQfg/h1YPEpefePs37B/FZCUV+20JKgUUFMnE/9PZYbUi9gW8Vp6sO/8pjizZzlT3bmstHa
        3dSJ8JDA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50578)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qxpMa-0002it-13;
        Tue, 31 Oct 2023 14:05:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qxpMb-00059x-5a; Tue, 31 Oct 2023 14:05:01 +0000
Date:   Tue, 31 Oct 2023 14:05:01 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc:     Hugo Villeneuve <hugo@hugovil.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH 6/6] tty: serial: amba-pl011: Parse bits option as 5, 6,
 7 or 8 in _get_options
Message-ID: <ZUEJjdfk/vmH8XTR@shell.armlinux.org.uk>
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
 <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
 <20231026105329.0ee9603563202bd2157a7d27@hugovil.com>
 <CWMITJ9VX9IP.1WPQCX981VRDE@tleb-bootlin-xps13-01>
 <ZUDS5UpWlo+DUZc4@shell.armlinux.org.uk>
 <CWMKPFZ9LOVD.2756QU9AP6U3W@tleb-bootlin-xps13-01>
 <ZUDjhpQKgUgqVeBh@shell.armlinux.org.uk>
 <CWMNJ47MO8E6.7CXJRZ181PXJ@tleb-bootlin-xps13-01>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CWMNJ47MO8E6.7CXJRZ181PXJ@tleb-bootlin-xps13-01>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 02:51:45PM +0100, Théo Lebrun wrote:
> On Tue Oct 31, 2023 at 12:22 PM CET, Russell King (Oracle) wrote:
> > On Tue, Oct 31, 2023 at 12:04:11PM +0100, Théo Lebrun wrote:
> > > On Tue Oct 31, 2023 at 11:11 AM CET, Russell King (Oracle) wrote:
> > > > There is no point in supporting 5 or 6 bits for console usage. Think
> > > > about it. What values are going to be sent over the console? It'll be
> > > > ASCII, which requires at _least_ 7-bit. 6-bit would turn alpha
> > > > characters into control characters, punctuation and numbers. 5-bit
> > > > would be all control characters.
> > > >
> > > > So there's no point trying to do anything with 5 or 6 bits per byte,
> > > > and I decided we might as well take that as an error (or maybe a
> > > > case that the hardware has not been setup) and default to 8 bits per
> > > > byte.
> > > 
> > > I see your point. Two things come to mind:
> > > 
> > >  - I added this parsing of 5/6 bits to be symmetrical with
> > >    pl011_set_termios that handles 5/6 properly. Should pl011_set_termios
> > >    be modified then?
> >
> > Why should it? Note that I said above about _console_ usage which is
> > what you were referring to - the early code that sets up the console
> > by either reading the current settings (so that we can transparently
> > use the UART when its handed over already setup by a boot loader).
> >
> > This is completely different to what happens once the kernel is running.
> > Userspace might very well have a reason to set 5 or 6 bits if it wants
> > to communicate with a device that uses those sizes.
> >
> > However, such a device won't be a console for the reasons I outlined
> > above (it will truncate the ASCII characters turning console messages
> > into garbage.)
> 
> I'm not sure I get it. (1) We assume it is a console so it's ASCII so no
> reason to set to 5 or 6 bits per word. But (2) there might be a reason
> to set the UART to 5 or 6 bits, the userspace decides.

Precisely.

> How do the two interact? Say we boot to Linux, userspace configures to 6
> bits because reasons and we reset. At second probe we see a config of 6
> bits per word but assume that can't be logical, even though it is.

I think you're conflating "serial console" with "serial port". A
"serial port" can support multiple different formats, and in this case,
such as 5, 6, 7, and 8 bits. 5 and 6 bits are likely to be a specialised
application which uses a binary protocol, not ASCII.

A "serial console" is one application of a "serial port" and a "serial
console" is used to send ASCII characters, not a binary protocol.

> What makes us suppose at probe that it must be a console?

Sorry, but no, we don't assume every serial port is a serial console.
Unless something has changed since I was involved with the serial
layer, we only read the parameters from a serial port _if_ and only
if that port is being used as a serial console.

TTYs under Linux have a standard initial set of parameters at boot -
9600 baud, 8 bits, etc. The exception to this is if a serial port *is
being used* as a serial console, where these settings are overriden by
the serial console configuration. The reason for that is... imagine
the chaos that would occur if:

- Your boot loader configures (through user configuration) the serial
  port for 115200 baud.
- The boot loader loads the kernel and passes control to it, with
  a command line specifying that this serial port is to be used for
  the serial console, but not specifying any parameters.
- The kernel boots, and starts outputting messages at 115200 baud.
- Userspace starts running, opens /dev/console, and switches the port
  to 9600 baud. Now you have utter garbage being received from the
  serial console.

So, the serial console is special in that regard.

Now, when we configure the serial console, we attempt to:

1) parse the options provided on the console= line to set the serial
port appropriately, or
2) if there are no options, then we attempt to set the serial port to
something sane *for use as a serial console*, which uses ASCII protocol
not some random binary protocol. 5 and 6 bits make no sense here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
