Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B911276D3E9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjHBQoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjHBQoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:44:08 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5063F269A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=031AZhyLVAnvSrG5EfAXCSNcm362d8NHJ28zLnLxYmc=; b=mtLrXd/JAIp176o8Ohuxx8WcsW
        CxmFnVk4u/FFudPnt/vFTbsxFGGckpr8P3ZRXY0tjldKqOvwlzyqA1Hy3gkWRMi0NR/dgQFWUyeGU
        +tpJmOLGSaC4XVSe7yQTczif0hg52oCybE+3qlr6ZWcIlTCRwZp28cQoRAhbcTskQh2Lllht3EIBX
        PQBcjcivt1eZGQdRpsyvbR2zgoYBSt5GXncG4J0N+IOg74k4D6WVfNHPYnufGJvRTDBbJBvaW80VM
        ulomkks44Tt+xFKB5j54KJePEH5DDUMdjSxhltyT/PCTX/pXXSh01bsoVqYreJ7WgBfbyloP/qUul
        JIv5hMxg==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qREwy-004sNq-9g; Wed, 02 Aug 2023 16:43:52 +0000
Date:   Wed, 2 Aug 2023 16:43:52 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, sam@ravnborg.org,
        benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Use shared font data
Message-ID: <ZMqHyC5PAEGzMLRz@gallifrey>
References: <20230725000141.165985-1-linux@treblig.org>
 <878rb0em3s.fsf@mail.lhotse>
 <ZMOaz9EqqeaPGokA@gallifrey>
 <871qgl1vs2.fsf@mail.lhotse>
 <182b08ea-04f3-3282-e3c3-9448bab6568a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <182b08ea-04f3-3282-e3c3-9448bab6568a@infradead.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 16:37:41 up 27 days,  2:09,  1 user,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Randy Dunlap (rdunlap@infradead.org) wrote:
> 
> 
> On 8/2/23 05:19, Michael Ellerman wrote:
> > "Dr. David Alan Gilbert" <linux@treblig.org> writes:
> >> * Michael Ellerman (mpe@ellerman.id.au) wrote:
> >>> linux@treblig.org writes:
> >>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >>>>
> >>>> PowerPC has a 'btext' font used for the console which is almost identical
> >>>> to the shared font_sun8x16, so use it rather than duplicating the data.
> >>>>
> >>>> They were actually identical until about a decade ago when
> >>>>    commit bcfbeecea11c ("drivers: console: font_: Change a glyph from
> >>>>                         "broken bar" to "vertical line"")
> >>>>
> >>>> which changed the | in the shared font to be a solid
> >>>> bar rather than a broken bar.  That's the only difference.
> >>>>
> >>>> This was originally spotted by PMD which noticed that sparc does
> >>>
> >>> PMD means "Page Middle Directory" to most Linux folks, I assume that's
> >>> not what you meant :)
> >>
> >> Ah, any good TLA is ripe for reuse:
> >>    https://pmd.github.io/pmd/pmd_userdocs_cpd.html
> > 
> > Thanks.
> > 
> > Unfortunately this patch causes a warning:
> > 
> >   WARNING: unmet direct dependencies detected for FONT_SUN8x16
> >     Depends on [n]: FONT_SUPPORT [=y] && FRAMEBUFFER_CONSOLE [=y] && (!SPARC && FONTS [=n] || SPARC)
> >     Selected by [y]:
> >     - BOOTX_TEXT [=y] && PPC_BOOK3S [=y]
> > 
> > And breaks allmodconfig with:
> > 
> >   ld: arch/powerpc/kernel/btext.o:(.toc+0x0): undefined reference to `font_sun_8x16'
> >   make[3]: *** [../scripts/Makefile.vmlinux:36: vmlinux] Error 1
> > 
> > I guess the Kconfig logic needs some more work.
> 
> Also please see:
>   https://lore.kernel.org/all/dd29e5f5-d9f7-0103-e602-b98f26c88fb1@infradead.org/
> for a similar problem on UML.

Thanks Michael, Randy.

Does anyone understand why the font_sun8x16 has any of those
 'Depends on' ?

It's just a font structure definition.

Dave

> -- 
> ~Randy
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
