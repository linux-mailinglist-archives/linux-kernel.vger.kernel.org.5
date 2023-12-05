Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1110B805D8A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345863AbjLESOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbjLESOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:14:20 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46941A2;
        Tue,  5 Dec 2023 10:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+EEdAY5I5fDE6iNN/6bW8wHl8UaPsKF7/BDuoeVzsws=; b=YKQh5usfx8LdrGc7W+RHN5PT1c
        VJiaeKCkgyk6iWrrXXvYZirpg/LeSBE920nEDENyfOuPLQ0AXdG2MovxQgdlj35w/asSVRszrQuds
        FpEoA7wxnWLy3SQ5AoQBi9mquXz2q1l18OzPozKs9YcXIPBeAoiqJnI49d1VVX8X47AkmCSKoDNtO
        VwXF7bNh+TbyG1PU8EwM8FkzjSzmbJiah5uJ1NwNn5Zl9CJglBVAeJ1RdvYcY2XDNpi1CcbkTqP0p
        RPoT5GkyxZtL1XaxOEOv45a8HW69TIIgQYbaRMpz0Bk9dV4tFYyU8/hlLkB8w8fUwQ3+Oe9eC1MRl
        cJFFrIJg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38970)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rAZvw-0007Ce-1t;
        Tue, 05 Dec 2023 18:14:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rAZvw-0001vd-0E; Tue, 05 Dec 2023 18:14:12 +0000
Date:   Tue, 5 Dec 2023 18:14:11 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Harini Katakam <harini.katakam@amd.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        workflows@vger.kernel.org
Subject: Re: [net-next PATCH v3 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <ZW9oc9TO93kOq20s@shell.armlinux.org.uk>
References: <20231128133630.7829-1-ansuelsmth@gmail.com>
 <20231128133630.7829-3-ansuelsmth@gmail.com>
 <20231204181752.2be3fd68@kernel.org>
 <51aae9d0-5100-41af-ade0-ecebeccbc418@lunn.ch>
 <656f37a6.5d0a0220.96144.356f@mx.google.com>
 <adbe5299-de4a-4ac1-90d0-f7ae537287d0@lunn.ch>
 <ZW89errbJWUt33vz@shell.armlinux.org.uk>
 <20231205072912.2d79a1d5@kernel.org>
 <ZW9LroqqugXzqAY9@shell.armlinux.org.uk>
 <d2762241-f60a-4d61-babe-ce9535d9adde@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2762241-f60a-4d61-babe-ce9535d9adde@quicinc.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:44:05AM -0800, Jeff Johnson wrote:
> On 12/5/2023 8:11 AM, Russell King (Oracle) wrote:
> > On Tue, Dec 05, 2023 at 07:29:12AM -0800, Jakub Kicinski wrote:
> >> On Tue, 5 Dec 2023 15:10:50 +0000 Russell King (Oracle) wrote:
> >>> I've raised this before in other subsystems, and it's suggested that
> >>> it's better to have it in the .c file. I guess the reason is that it's
> >>> more obvious that the function is documented when modifying it, so
> >>> there's a higher probability that the kdoc will get updated when the
> >>> function is altered.
> >>
> >> Plus I think people using IDEs (i.e. not me) may use the "jump to
> >> definition" functionality, to find the doc? 
> >>
> >> TBH I thought putting kdoc in the C source was documented in the coding
> >> style, but I can't find any mention of it now.
> > 
> > Well, in Documentation/doc-guide/kernel-doc.rst:
> > 
> >   The function and type kernel-doc comments should be placed just before
> >   the function or type being described in order to maximise the chance
> >   that somebody changing the code will also change the documentation.
> > 
> > That implies (but not explicitly) that it should be at the function
> > definition site, since "changing the code" is used as an argument as
> > I did in my previous email.
> > 
> > Secondly, this document goes on to give an example of running
> > scripts/kernel-doc on a .c file.
> > 
> > Thirdly, there are seven references in this document of kernel-doc
> > in .c files, and only one for kernel-doc in a .h file. So this suggests
> > that "it will be in a .c file" isn't a rule (it can't be because of
> > documenting structures!)
> > 
> > So let's not get hung up on whether it should be in .c or .h because I
> > think that isn't relevant. Instead, I think it's about "it should be at
> > the definition site" - that being a structure definition or a function
> > definition, and not at a function prototype.
> > 
> > The only exception I can think of is the style I've used in
> > linux/phylink.h for the _method_ definitions which look like function
> > prototypes - that's just a work-around because one can't kernel-doc
> > the structure-of-function-pointers and document the function parameters
> > without jumping through that hoop, and it would be silly to document
> > the methods in some random driver!
> > 
> 
> The Linux Kernel philosophy of documenting functions instead of
> prototypes has always bothered me since I'm "old school" and am
> ingrained with the software engineering philosophy that you document
> interfaces, not implementations. This was reinforced early in my career
> by working on multiple projects in different programming languages using
> processes outlined in DOD-STD-2167A, and for some projects, especially
> ones written in Ada, the header files were the design and the documentation.
> 
> This philosophy was further enforced when working with closed source
> projects (Windows, IOS, VxWorks) where all the documentation was
> contained in shared header files.
> 
> So in my experience a function prototype IS the function definition, and
> the actual function is just the implementation of that definition.
> 
> But that thinking obviously isn't shared by others.

Interestingly, the view that a function prototype is a function
definition does not seem to be shared by w3school, Microsoft, IBM,
and many more.

If we look at the C99 standard, then 6.9.1 Function definitions gives
the syntax as including a compound-statement, which is defined as
requiring the curley braces and contents. Therefore, a function
definition as defined by the C standard includes its body.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
