Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67E0786F82
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbjHXMra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbjHXMrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:47:08 -0400
Received: from mx.treblig.org (mx.treblig.org [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDCD10FC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=5ix2rprjqMmtg3QKk2R00SMw+sT74bDQ+N4/iHHMqXU=; b=dnmeukHg0IpApECk4SjENXZFVG
        KUteOEBdFqKrRNxed5CoWPnxZY8giGvPrABTRaDOSuyny2+UfnA2pVIdCrl2/u/aRdAEsjkopG/mS
        HboqVVQ6BnAPAKLVbftvP3Z+62G0idp7AXwiJXZgldf+0ZhbXdMkM0EXY7qV6GCVY8T/4Zom1MAkL
        G4ndnvkvw1CTixHhv2kgrSpbetL+2io/qnDGyvGZgX3/WICiFSW334TITaq1m+geD8CUoJFoh2fxQ
        T21v2pDAjWo3atPsU634ozBYUhM8IRBuiHblUpLpb1gJV84Ba/4cySexGGlIAXDVpyA1FGddZfUCs
        5wouGs+g==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qZ9jk-008QkI-7r; Thu, 24 Aug 2023 12:46:56 +0000
Date:   Thu, 24 Aug 2023 12:46:56 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu, sam@ravnborg.org,
        benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH v3] powerpc: Use shared font data
Message-ID: <ZOdRQFKaxnKQ+s/U@gallifrey>
References: <20230812010241.529173-1-linux@treblig.org>
 <ZOY0dANP4s3L3VyX@gallifrey>
 <87msygvjvy.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87msygvjvy.fsf@mail.lhotse>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 12:42:48 up 48 days, 22:14,  1 user,  load average: 0.01, 0.00, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Ellerman (mpe@ellerman.id.au) wrote:
> "Dr. David Alan Gilbert" <linux@treblig.org> writes:
> > * linux@treblig.org (linux@treblig.org) wrote:
> >> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >> 
> >> PowerPC has a 'btext' font used for the console which is almost identical
> >> to the shared font_sun8x16, so use it rather than duplicating the data.
> >> 
> >> They were actually identical until about a decade ago when
> >>    commit bcfbeecea11c ("drivers: console: font_: Change a glyph from
> >>                         "broken bar" to "vertical line"")
> >> 
> >> which changed the | in the shared font to be a solid
> >> bar rather than a broken bar.  That's the only difference.
> >> 
> >> This was originally spotted by the PMF source code analyser, which
> >> noticed that sparc does the same thing with the same data, and they
> >> also share a bunch of functions to manipulate the data.  I've previously
> >> posted a near identical patch for sparc.
> >> 
> >> Tested very lightly with a boot without FS in qemu.
> >> 
> >> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> >
> > Hi Michael,
> >   Just checking, is there anything else I need to do here?
>    
> I felt like the lib/fonts/Kconfig change could be cleaner, but the
> existing Kconfig is not well structured for what we want to do.

Yeh that line has caused quite a bit of pain in this otherwise simple
set.

> I think at least it could be simplified to:
> 
> config FONT_SUN8x16
> 	bool "Sparc console 8x16 font"
> 	depends on (FRAMEBUFFER_CONSOLE && (FONTS || SPARC)) || BOOTX_TEXT

OK, I'll give it a go - but I wonder what else we need to test?
My version was careful not to change other arch's behaviour
on this config, I worry this might. (Although IMHO I actually think
we could just remove this entire depends, and the only reason I haven't
is because I worry what other knock on there might be).

Dave

> 
> cheers
> 
> 
> >> diff --git a/lib/fonts/Kconfig b/lib/fonts/Kconfig
> >> index c035fde66aebe..1804abe08ffe4 100644
> >> --- a/lib/fonts/Kconfig
> >> +++ b/lib/fonts/Kconfig
> >> @@ -98,7 +98,8 @@ config FONT_10x18
> >>  
> >>  config FONT_SUN8x16
> >>  	bool "Sparc console 8x16 font"
> >> -	depends on FRAMEBUFFER_CONSOLE && (!SPARC && FONTS || SPARC)
> >> +	depends on (FRAMEBUFFER_CONSOLE || BOOTX_TEXT) &&\
> >> +	           (!SPARC && FONTS || SPARC || PPC)
> >>  	help
> >>  	  This is the high resolution console font for Sun machines. Say Y.
> >>  
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
