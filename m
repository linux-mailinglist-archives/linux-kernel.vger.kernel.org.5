Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC1761FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjGYRIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjGYRIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:08:44 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69B41BDA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 10:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=yRbVjFfsSAWk2qgPNLV4SL8PYOAzyHPJa8qojV/qbTU=; b=Tc94ByYH0orSeNXKGUiuuOjWTS
        ATnRhfKj2TfUyt+WICB9rlgeFHnc2qULhs+lSzd2663ZUtjIuViBkKDl4v9cvfQE70uhdxfi2OfVo
        hXzlkILmigafv1+Mb2ZmSuUm/1rAt3+M2VTcN2pV5oS87RL5bwgli0k7APUKsnTUyG5xB87fE64nj
        UsihBZudUopiFXmotkuW68RBPAkmvd2mPZLaOpBn08IskQJN3VjNqNORXfrhdudlMgRbt8H4MCBj3
        rQwkK6s27v528DgBSbJsVmgjKbcvzVO2mqAZyIeHKxpY+YodZ55LfPQQ1PPlA/YFHlx0ZeRMiC52L
        nUy4XK8Q==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qOLWR-003Grm-3b; Tue, 25 Jul 2023 17:08:31 +0000
Date:   Tue, 25 Jul 2023 17:08:31 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Use shared font data
Message-ID: <ZMABj6UNK98fONEQ@gallifrey>
References: <20230725000141.165985-1-linux@treblig.org>
 <20230725170104.GA838289@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230725170104.GA838289@ravnborg.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 17:08:19 up 19 days,  2:39,  1 user,  load average: 0.00, 0.01, 0.00
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

* Sam Ravnborg (sam@ravnborg.org) wrote:
> Hi David,
> 
> On Tue, Jul 25, 2023 at 01:01:41AM +0100, linux@treblig.org wrote:
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
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Yep, looks very similar to sparc, so
> 
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Thanks!

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
