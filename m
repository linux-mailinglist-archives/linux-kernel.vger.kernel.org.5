Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BF97D16EC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjJTUZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjJTUZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:25:25 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8C4D66
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:25:21 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B6A9CE0003;
        Fri, 20 Oct 2023 20:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697833520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sfiWF1djQwW183R/n1Ql11Gvhq6s/Znqmh+4YVfuGWU=;
        b=lmMEKHcO4Kfebn4Ds5bXoJ7JSSdHmrZVL0PjwehYTgvNmjc0wbpbssC5t6ldsPBp7LuHKt
        hwu2U9DK6qnP1764Y3xC+dEUESkCTPTjHEWANuEofysAwrEZWB9Ztm3hzbnSaoWSisDl85
        Knb7vG4qL9rZ+gqij5IqasMyIYBnheXqXN1TAEbsOLZlxm35tNxXmBuj4Caus2EVjMrHrz
        QL78DZXcXfbAmF5VHe3diLW6dxyHQ8oyTdJZVD5+VQCwlkYvjHXi2GOEHieXEl7CSsM0nd
        5P5OUbDVxXNeEIupFx9uPcFeTokOY+ABWFENSlsxCr6QG+osKNzGNDbSMIp1NA==
Date:   Fri, 20 Oct 2023 22:25:19 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Zbigniew, Lukwinski" <zbigniew.lukwinski@linux.intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Frank Li <Frank.li@nxp.com>, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] i3c: master: add enable(disable) hot join in sys
 entry
Message-ID: <20231020202519b2449707@mail.local>
References: <20231018205929.3435110-1-Frank.Li@nxp.com>
 <20231018205929.3435110-2-Frank.Li@nxp.com>
 <57efe6de-cf65-32ed-fd1e-a388e1676c70@linux.intel.com>
 <20231020154528.2f5f68f5@xps-13>
 <ZTKMyW939rB6sSKq@lizhi-Precision-Tower-5810>
 <20231020163348.1752167d@xps-13>
 <8a7ac52e-f102-6f5e-35ab-217e6ecc6ba5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a7ac52e-f102-6f5e-35ab-217e6ecc6ba5@linux.intel.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2023 17:12:53+0200, Zbigniew, Lukwinski wrote:
> On 10/20/2023 4:33 PM, Miquel Raynal wrote:
> > Hi Frank,
> > 
> > Frank.li@nxp.com  wrote on Fri, 20 Oct 2023 10:20:57 -0400:
> > 
> > > On Fri, Oct 20, 2023 at 03:45:28PM +0200, Miquel Raynal wrote:
> > > > Hi Lukwinski,
> > > > 
> > > > zbigniew.lukwinski@linux.intel.com  wrote on Fri, 20 Oct 2023 10:55:27
> > > > +0200:
> > > > > On 10/18/2023 10:59 PM, Frank Li wrote:
> > > > > > Add hotjoin entry in sys file system allow user enable/disable hotjoin
> > > > > > feature.
> > > > > > 
> > > > > > Add (*enable(disable)_hotjoin)() to i3c_master_controller_ops.
> > > > > > Add api i3c_master_enable(disable)_hotjoin();
> > > > > What is the use case for having HJ enable knob in sysfs available for user space other than for debug stuff? In other words, does user space really need to enable/disable HJ in runtime for other reason but debug? If it is only for debug maybe it  could be move to debugFS?
> > > > I don't think hotjoin should be considered as a debug feature. The
> > > > problem here is the power consumption which is higher if you enable
> > > > this feature (you need to keep everything clocked and ready to handle
> > > > an IBI) whereas if your design is "fixed" (more like an I2C bus) you
> > > > may save power by disabling this feature.
> > > > 
> > > > A module parameter does not fit here because it's a per-bus
> > > > configuration.
> > > I agree. sys entry is more flexiable. and let controller choose better
> > > power saving policy for difference user case.
> > Maybe it's not the first time this case is faced, would you mind
> > including power management maintainers in this discussion? Perhaps they
> > might have pointers or even have the solution already.
> 
> I did not mind HJ as debug feature. But enabling / disabling the HJ sounds
> to me like debug option.
> 
> So the flow you are considering here is like this:?
> 
>     1. system boot with HJ enabled, so HJ works during initial bus
>        discovery
>     2. some entity in user space decides to disable HJ because power
>        consumption?
>     3. some entity in use space decide some time later to re-enable HJ
>        because some reason?
> 
> I am just wondering whether there is real use case when you starts with HJ
> enabled and than disable it
> 
> in runtime or start with HJ disabled and enable it in runtime. If you are
> taking care about power saving
> 
>  let's keep HJ disabled all the time. Default state for HJ could be
> controlled by DT entry.
> 

This would be HW configuration and not HW description.


> 
> > Thanks,
> > Miquèl

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
