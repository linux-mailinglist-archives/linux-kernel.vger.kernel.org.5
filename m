Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7181477447B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjHHSUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjHHSUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:20:02 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176AB21240
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=5O2J3ZOvO2rHCsErDQjcGUfCgAaBbnfOM3Ddj2mjhyk=; b=Vq2SMmKsiIQ4V2d0R0GIxbtD8t
        rhzaB4rM41FepLLQIOy6dCcivND3z7YakVxQok02wev6LbOrgElrlslBW9gX67WJHPItY+wmmRcxy
        zTWgI1QjxDuaZGa/X0N22s//Pf+77jSahC/pk55krmXTac+IvjB0V6cpmi6Vw3eJ6+xCEsnmjresP
        qzUhMlNuCxtqzEEJNHiHK9U0hh5itD6iDWHVu8ZQKiKDr+Mv1sM02dz3jE3TksPm2CnUWyQc+/KrT
        ulP2OqYxb6IyTGMS4zSh+L7Gql2+dUoDFzuaKmPeqW/jc4BJDKB6DMq/2EX1riIEXTsPqQOOaY7PT
        MGH8+bZw==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qTQVX-005lCt-AT; Tue, 08 Aug 2023 17:28:35 +0000
Date:   Tue, 8 Aug 2023 17:28:35 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        sam@ravnborg.org, benh@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: Use shared font data
Message-ID: <ZNJ7QzfA/GSgahmf@gallifrey>
References: <20230807010721.799613-1-linux@treblig.org>
 <828497a6-80c2-329f-8b47-2311bf08943d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <828497a6-80c2-329f-8b47-2311bf08943d@infradead.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 17:25:06 up 33 days,  2:56,  1 user,  load average: 0.06, 0.05, 0.07
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Randy Dunlap (rdunlap@infradead.org) wrote:
> Hi--
> 
> On 8/6/23 18:07, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > PowerPC has a 'btext' font used for the console which is almost identical
> > to the shared font_sun8x16, so use it rather than duplicating the data.
> > 
> > They were actually identical until about a decade ago when
> >    commit bcfbeecea11c ("drivers: console: font_: Change a glyph from
> >                         "broken bar" to "vertical line"")
> > 
> > which changed the | in the shared font to be a solid
> > bar rather than a broken bar.  That's the only difference.
> > 
> > This was originally spotted by PMD which noticed that sparc does
> > the same thing with the same data, and they also share a bunch
> > of functions to manipulate the data.  I've previously posted a near
> > identical patch for sparc.
> > 
> > One difference I notice in PowerPC is that there are a bunch of compile
> > options for the .c files for the early code to avoid a bunch of security
> > compilation features;  it's not clear to me if this is a problem for
> > this font data.
> > 
> > Tested very lightly with a boot without FS in qemu.
> > 
> > v2
> >   Added 'select FONT_SUPPORT' (to stop modconfig causing the font to be
> >    linked into a module rather than the main kernel)
> >   Added 'select FONTS' to satisfy requirements in lib/fonts
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  arch/powerpc/Kconfig.debug  |   3 +
> >  arch/powerpc/kernel/btext.c | 360 +-----------------------------------
> >  2 files changed, 9 insertions(+), 354 deletions(-)
> > 
> > diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> > index 2a54fadbeaf51..521c4baf30e88 100644
> > --- a/arch/powerpc/Kconfig.debug
> > +++ b/arch/powerpc/Kconfig.debug
> > @@ -147,6 +147,9 @@ config BDI_SWITCH
> >  config BOOTX_TEXT
> >  	bool "Support for early boot text console (BootX or OpenFirmware only)"
> >  	depends on PPC_BOOK3S
> > +	select FONT_SUN8x16
> > +	select FONT_SUPPORT
> > +	select FONTS
> >  	help
> >  	  Say Y here to see progress messages from the boot firmware in text
> >  	  mode. Requires either BootX or Open Firmware.
> 
> kconfig tells me:
> 
> WARNING: unmet direct dependencies detected for FONTS
>   Depends on [n]: FONT_SUPPORT [=y] && (FRAMEBUFFER_CONSOLE [=n] || STI_CONSOLE [=n])
>   Selected by [y]:
>   - BOOTX_TEXT [=y] && PPC_BOOK3S [=y]
> 
> WARNING: unmet direct dependencies detected for FONT_SUN8x16
>   Depends on [n]: FONT_SUPPORT [=y] && FRAMEBUFFER_CONSOLE [=n] && (!SPARC && FONTS [=y] || SPARC)
>   Selected by [y]:
>   - BOOTX_TEXT [=y] && PPC_BOOK3S [=y]
> 
> because FONTS depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE and neither of those is set.

I'm not getting the warnings in the v2, with a few configs; what command
are using?

I'm tempted to change the FONT_SUN8x16 dependency line to have
SPARC||BOOTX_TEXT or SPARC||POWERPC  and drop the 'select FONTS' I
added.

Dave

> 
> -- 
> ~Randy
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
