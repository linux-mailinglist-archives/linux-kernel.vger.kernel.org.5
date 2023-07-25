Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9C7761FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjGYQyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjGYQyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:54:02 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF056270E;
        Tue, 25 Jul 2023 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=m7fAhDuATOTXbBw+03CG8AVOeMC/rQ7dwdJI39b0ePg=; b=iaoymfNpP7Rxl+UOcYficA+N+s
        l76BWfP+K8D3cEK0NFqByra2UfIii9iAU9yi3DGpbWt/GbeQmPBJmxzdHEyqX9FCRzAjCVP35nrlE
        9V2dk3mhEr99hLFMuufsq+v8jNeeZhgpPBMgPcSewFpvMrieO6tCdEPV0yiszELJRZTH86jEWJYSY
        Y8KM344otcBhjcMqabyWxdLInoIyoiaYVf82/kmGEi1cGt1r3BEqZWi+hmR3/DRBjAs8xvJJzAeTQ
        mnhTz29x7G6U1tN9Ngal6GfWLFrIT2dZDRWnpawLTM4ZUTYoRXJnsyyXpWErzGE/e8fPQhEdTcd51
        5uFuAOMg==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qOLHr-003GkY-DG; Tue, 25 Jul 2023 16:53:27 +0000
Date:   Tue, 25 Jul 2023 16:53:27 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     davem@davemloft.net, benh@kernel.crashing.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sparc: Use shared font data
Message-ID: <ZL/+Bz5C2Mxx0Msw@gallifrey>
References: <20230724235851.165871-1-linux@treblig.org>
 <20230725161040.GA832394@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230725161040.GA832394@ravnborg.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 16:51:09 up 19 days,  2:22,  1 user,  load average: 0.04, 0.03, 0.00
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
> On Tue, Jul 25, 2023 at 12:58:51AM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > sparc has a 'btext' font used for the console which is almost identical
> > to the shared font_sun8x16, so use it rather than duplicating the data.
> > 
> > They were actually identical until about a decade ago when
> >    commit bcfbeecea11c ("drivers: console: font_: Change a glyph from
> >                         "broken bar" to "vertical line"")
> > 
> > which changed the | in the shared font to be a solid
> > bar rather than a broken bar.  That's the only difference.
> > 
> > This was originally spotted by PMD which noticed that PPC does
> > the same thing with the same data, and they also share a bunch
> > of functions to manipulate the data.  The PPC code and the functions
> > I'll look at another time if this patch is OK.
> > 
> > Tested very lightly with a boot without FS in qemu.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Looks good, thanks for the fixes.
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Thanks

> Let's hope someone picks it up...

I was hoping Dave would, but I realise Sparc doesn't get much
these days.
Of course if anyone feels guilty about their own patches adding code
they can take this patch to make ~340 lines of penance.

Dave

> 	Sam
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
