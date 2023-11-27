Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7587FA2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjK0O3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjK0O2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:28:55 -0500
X-Greylist: delayed 98 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 06:16:58 PST
Received: from smtpo54.interia.pl (smtpo54.interia.pl [217.74.67.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EFF1FC9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:16:58 -0800 (PST)
Received: from nr200 (unknown [80.68.225.159])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
        Mon, 27 Nov 2023 15:15:16 +0100 (CET)
Date:   Mon, 27 Nov 2023 15:15:15 +0100
From:   Slawomir Stepien <sst@poczta.fm>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Fang Xiang <fangxiang3@xiaomi.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] irqchip/gic-v3-its: Fix the coherent issue in
 its_setup_baser() when shr = 0.
Message-ID: <ZWSkcxjgXmxXhT6n@nr200>
References: <20231026020116.4238-1-fangxiang3@xiaomi.com>
 <87sf5x6cdu.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sf5x6cdu.wl-maz@kernel.org>
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
        t=1701094517; bh=ob+g8wyFUYqMNGTFK61Vic4ys3hU0qkUWR6QMj4Iiy0=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=d/8IVjrya/HAwx5izy3E7580znPNvF+a+nb0qr+aj0Jmoy23rWQmucjK1RxxFhuID
         EyjKU3aLy4+pWaDqvibkZKpHQ1AIJGgJJ5Uw3vqA6y+C8fdWtuklK2DfoNvLHHuvGM
         xISwT10+A0l0kK0fN/ei8oMRbvlzf2tndUGGUoAw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc and Fang

(Maybe nobody cares anymore...but I've observed the problem and I'm glad it is now fixed, see below
my symptoms).

On paź 26, 2023 09:01, Marc Zyngier wrote:
> On Thu, 26 Oct 2023 03:01:16 +0100,
> Fang Xiang <fangxiang3@xiaomi.com> wrote:
> > 
> > The table would not be flushed if the input parameter shr = 0 in
> > its_setup_baser() and it would cause a coherent problem.
> 
> Would? Or does? I'm asking, as you have previously indicated that this
> workaround was working for you.
> 
> Have you actually observed a problem? Or is that by inspection?

On my Orange Pi 5 Plus (RK3588), I've seen (only during reboot):

[   68.236523] ITS queue timeout (17856 17793)
[   68.236893] ITS cmd its_build_discard_cmd failed
[   69.697180] ITS queue timeout (17920 17793)
[   69.697546] ITS cmd its_build_discard_cmd failed
[   71.157769] ITS queue timeout (17984 17793)
[   71.158136] ITS cmd its_build_discard_cmd failed
[   72.618378] ITS queue timeout (18048 17793)
[   72.618748] ITS cmd its_build_discard_cmd failed
[   74.078961] ITS queue timeout (18112 17793)
[   74.079327] ITS cmd its_build_discard_cmd failed
[   75.539560] ITS queue timeout (18176 17793)
[   75.539926] ITS cmd its_build_discard_cmd failed
[   76.999319] ITS queue timeout (18240 17793)
[   76.999685] ITS cmd its_build_inv_cmd failed
[   78.458810] ITS queue timeout (18304 17793)
[   78.459176] ITS cmd its_build_discard_cmd failed
[   79.918328] ITS queue timeout (18368 17793)
[   79.918694] ITS cmd its_build_inv_cmd failed
[   81.378019] ITS queue timeout (18432 17793)
[   81.378386] ITS cmd its_build_discard_cmd failed
[   82.838738] ITS queue timeout (18496 17793)
[   82.839105] ITS cmd its_build_discard_cmd failed
[   84.299324] ITS queue timeout (18560 17793)
[   84.299690] ITS cmd its_build_discard_cmd failed
[   85.759906] ITS queue timeout (18624 17793)
[   85.760273] ITS cmd its_build_discard_cmd failed
[   87.220496] ITS queue timeout (18688 17793)
[   87.220861] ITS cmd its_build_discard_cmd failed
[   88.681075] ITS queue timeout (18752 17793)
[   88.681441] ITS cmd its_build_discard_cmd failed
[   90.141657] ITS queue timeout (18816 17793)
[   90.142024] ITS cmd its_build_discard_cmd failed
[   91.602233] ITS queue timeout (18880 17793)
[   91.602599] ITS cmd its_build_discard_cmd failed
[   93.062827] ITS queue timeout (18944 17793)
[   93.063193] ITS cmd its_build_discard_cmd failed
[   94.601533] ITS queue timeout (8992 8929)
[   94.601885] ITS cmd its_build_discard_cmd failed
[   96.062111] ITS queue timeout (9056 8929)
[   96.062462] ITS cmd its_build_discard_cmd failed
[   97.522652] ITS queue timeout (9120 8929)
[   97.523005] ITS cmd its_build_discard_cmd failed
[   98.983192] ITS queue timeout (9184 8929)
[   98.983543] ITS cmd its_build_discard_cmd failed
[  100.443753] ITS queue timeout (9248 8929)
[  100.444104] ITS cmd its_build_discard_cmd failed
[  101.904294] ITS queue timeout (9312 8929)
[  101.904645] ITS cmd its_build_discard_cmd failed
[  103.364847] ITS queue timeout (9376 8929)
[  103.365198] ITS cmd its_build_discard_cmd failed
[  104.825394] ITS queue timeout (9440 8929)
[  104.825743] ITS cmd its_build_discard_cmd failed
[  104.827172] reboot: Restarting system

This patch (the one that ended up in 6.7.0-rc3) fixed this issue for me.

> > 
> > Signed-off-by: Fang Xiang <fangxiang3@xiaomi.com>
> > ---
> >  drivers/irqchip/irq-gic-v3-its.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index 75a2dd550625..58a9f24ccfa7 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -2394,13 +2394,15 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
> >  		 * non-cacheable as well.
> >  		 */
> >  		shr = tmp & GITS_BASER_SHAREABILITY_MASK;
> > -		if (!shr) {
> > +		if (!shr)
> >  			cache = GITS_BASER_nC;
> > -			gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
> > -		}
> > +
> >  		goto retry_baser;
> >  	}
> >  
> > +	if (!shr)
> > +		gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
> > +
> 
> This is wrong. You're doing the cache clean *after* the register has
> been programmed with its final value, and the ITS is perfectly allowed
> to prefetch anything it wants as soon as you program the register. The
> clean must thus happen before the write. Yes, it was wrong before, but
> you are now making it wrong always.
> 
> >  	if (val != tmp) {
> >  		pr_err("ITS@%pa: %s doesn't stick: %llx %llx\n",
> >  		       &its->phys_base, its_base_type_string[type],
> 
> Overall, I think we need a slightly better fix. Since non-coherent
> ITSs are quickly becoming the common case, we can save ourselves some
> effort and hoist the quirked attributes early.
> 
> Does the hack below work for you?
> 
> 	M.
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 75a2dd550625..d76d44ea2de1 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2379,12 +2379,12 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
>  		break;
>  	}
>  
> +	if (!shr)
> +		gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
> +
>  	its_write_baser(its, baser, val);
>  	tmp = baser->val;
>  
> -	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE)
> -		tmp &= ~GITS_BASER_SHAREABILITY_MASK;
> -
>  	if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
>  		/*
>  		 * Shareability didn't stick. Just use
> @@ -2394,10 +2394,9 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
>  		 * non-cacheable as well.
>  		 */
>  		shr = tmp & GITS_BASER_SHAREABILITY_MASK;
> -		if (!shr) {
> +		if (!shr)
>  			cache = GITS_BASER_nC;
> -			gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
> -		}
> +
>  		goto retry_baser;
>  	}
>  
> @@ -2609,6 +2608,11 @@ static int its_alloc_tables(struct its_node *its)
>  		/* erratum 24313: ignore memory access type */
>  		cache = GITS_BASER_nCnB;
>  
> +	if (its->flags & ITS_FLAGS_FORCE_NON_SHAREABLE) {
> +		cache = GITS_BASER_nC;
> +		shr = 0;
> +	}
> +
>  	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
>  		struct its_baser *baser = its->tables + i;
>  		u64 val = its_read_baser(its, baser);

-- 
Slawomir Stepien
