Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2378F7DCBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjJaLW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjJaLWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:22:54 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F2F97;
        Tue, 31 Oct 2023 04:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Nl4LFqAC2Uv3TVZuzpPEiO7Jkauztt8lcPvawy8/0uQ=; b=Kp6zpNUs6KcfyhFpW5tSRUsQZF
        WpmYkBuWO1HqYKkZXTDiQ2b0NbeDN7e2SoF5+Em0fB7YOPCZu6LNR8eckskhLN5Q/sWFhbKukYVjD
        RfAudewliQ3zZcnklKfZMcRcCBSbCR5XnqfHaHH5DoApCCR7Jrikh5vboSXnWZ0WanTZXY2ccUOrk
        arAIQH7DAPcNOj6Y6fbCahsq1+qEd1pmoog3i1+4mfQWywrqROclHVFdWmqMvwSgA6Vam5nZ6Z/Fq
        h2+1U7N2/43lWSO1TczzWjHFmQKscUGAgcqJHvsTwJLJeGyYMzEtF0CwA3rRRC+jpciiUl0yTNQLz
        BcOpjwoA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35478)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qxmpZ-0002by-2c;
        Tue, 31 Oct 2023 11:22:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qxmpa-00053o-OJ; Tue, 31 Oct 2023 11:22:46 +0000
Date:   Tue, 31 Oct 2023 11:22:46 +0000
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
Message-ID: <ZUDjhpQKgUgqVeBh@shell.armlinux.org.uk>
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
 <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
 <20231026105329.0ee9603563202bd2157a7d27@hugovil.com>
 <CWMITJ9VX9IP.1WPQCX981VRDE@tleb-bootlin-xps13-01>
 <ZUDS5UpWlo+DUZc4@shell.armlinux.org.uk>
 <CWMKPFZ9LOVD.2756QU9AP6U3W@tleb-bootlin-xps13-01>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CWMKPFZ9LOVD.2756QU9AP6U3W@tleb-bootlin-xps13-01>
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

On Tue, Oct 31, 2023 at 12:04:11PM +0100, Théo Lebrun wrote:
> Hello,
> 
> On Tue Oct 31, 2023 at 11:11 AM CET, Russell King (Oracle) wrote:
> > There is no point in supporting 5 or 6 bits for console usage. Think
> > about it. What values are going to be sent over the console? It'll be
> > ASCII, which requires at _least_ 7-bit. 6-bit would turn alpha
> > characters into control characters, punctuation and numbers. 5-bit
> > would be all control characters.
> >
> > So there's no point trying to do anything with 5 or 6 bits per byte,
> > and I decided we might as well take that as an error (or maybe a
> > case that the hardware has not been setup) and default to 8 bits per
> > byte.
> 
> I see your point. Two things come to mind:
> 
>  - I added this parsing of 5/6 bits to be symmetrical with
>    pl011_set_termios that handles 5/6 properly. Should pl011_set_termios
>    be modified then?

Why should it? Note that I said above about _console_ usage which is
what you were referring to - the early code that sets up the console
by either reading the current settings (so that we can transparently
use the UART when its handed over already setup by a boot loader).

This is completely different to what happens once the kernel is running.
Userspace might very well have a reason to set 5 or 6 bits if it wants
to communicate with a device that uses those sizes.

However, such a device won't be a console for the reasons I outlined
above (it will truncate the ASCII characters turning console messages
into garbage.)

> If you decide to keep the current behavior, I'd be down to adding a
> comment to explicit this choice in pl011_console_get_options.

Well, honestly I don't think it needs a comment _if_ one thinks about
what these sizes mean for what is supposed to be a console displaying
ASCII characters. It feels to me like pointing out the obvious, and
would be on the level of teaching people how to suck eggs... but then
again, maybe there are times when people need to be taught how to
suck eggs...

So yes, add a comment if you think it's a good idea, but should that
comment be replicated in almost every driver or should it be documented
elsewhere?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
