Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA20782438
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjHUHNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjHUHNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:13:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5DAB1;
        Mon, 21 Aug 2023 00:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE48D6109A;
        Mon, 21 Aug 2023 07:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BFAC433C7;
        Mon, 21 Aug 2023 07:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692602016;
        bh=yQJkjn1BuHjZD/DDVzSLKknk7uYBVOvi9rbBEqifM8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYNUL8tbq6MOMMwPeAK1JOppwdGTsa/QCpR7fMiX86xOTxAkjsGBjkAPPqLS2cZ6p
         TK5K+8r6Lflan7YWciEwVOfjJEnFe1WnE9RWEy0zaVx61ACiVaZOzLQGZm/SxZyYoe
         ALXUE6sYpCofsEulo4uZ95QpsqBMDbrp1iq4RtVhAladHrjpiG05qxw0j83hJu9E0e
         I/uHI3UAjITlL/ESFiLtUwxG0T3GLvFE/RVIlRVgxMgqsnXAKjhbRpaJxeABKCmWBc
         jVlnuSTOWJyh5PsLr1HibCBXiuD7eo63xx9aJ0s5DwP0SOjchLl8AiYvYGZtiYET6N
         YVdHqE3E5btVg==
Date:   Mon, 21 Aug 2023 08:13:31 +0100
From:   Lee Jones <lee@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the battery tree
Message-ID: <20230821071331.GC1380343@google.com>
References: <20230821125741.3a2474d7@canb.auug.org.au>
 <20230821070731.GB1380343@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230821070731.GB1380343@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023, Lee Jones wrote:

> On Mon, 21 Aug 2023, Stephen Rothwell wrote:
> 
> > Hi all,
> > 
> > After merging the battery tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> > 
> > drivers/power/supply/rt5033_charger.c: In function 'rt5033_charger_probe':
> > drivers/power/supply/rt5033_charger.c:694:19: error: implicit declaration of function 'of_parse_phandle' [-Werror=implicit-function-declaration]
> 
> Is this because your merge-conflict patch:
> 
>   linux-next: manual merge of the battery tree with the mfd tree
> 
>  ... removed of_device.h?

Oh, that was Rob's patch.  I see now, thanks.

> >   694 |         np_conn = of_parse_phandle(pdev->dev.of_node, "richtek,usb-connector", 0);
> >       |                   ^~~~~~~~~~~~~~~~
> > drivers/power/supply/rt5033_charger.c:694:17: error: assignment to 'struct device_node *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
> >   694 |         np_conn = of_parse_phandle(pdev->dev.of_node, "richtek,usb-connector", 0);
> >       |                 ^
> > drivers/power/supply/rt5033_charger.c:695:19: error: implicit declaration of function 'of_get_parent'; did you mean 'kernfs_get_parent'? [-Werror=implicit-function-declaration]
> >   695 |         np_edev = of_get_parent(np_conn);
> >       |                   ^~~~~~~~~~~~~
> >       |                   kernfs_get_parent
> > drivers/power/supply/rt5033_charger.c:695:17: error: assignment to 'struct device_node *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
> >   695 |         np_edev = of_get_parent(np_conn);
> >       |                 ^
> > 
> > Caused by commit
> > 
> >   2ce8284c3115 ("power: Explicitly include correct DT includes")
> > 
> > interacting with commit
> > 
> >   12cc585f36b8 ("power: supply: rt5033_charger: Add cable detection and USB OTG supply")
> > 
> > from the mfd tree.
> > 
> > I have applied the following merge fix patch.
> > 
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 21 Aug 2023 12:50:12 +1000
> > Subject: [PATCH] fixup for "power: Explicitly include correct DT includes"
> > 
> > interacting with commit
> > 
> >   12cc585f36b8 ("power: supply: rt5033_charger: Add cable detection and USB OTG supply")
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/power/supply/rt5033_charger.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply/rt5033_charger.c
> > index 4d1198d752b7..4ea769775fa5 100644
> > --- a/drivers/power/supply/rt5033_charger.c
> > +++ b/drivers/power/supply/rt5033_charger.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/extcon.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > +#include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/power_supply.h>
> >  #include <linux/regmap.h>
> > -- 
> > 2.40.1
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> 
> 
> 
> -- 
> Lee Jones [李琼斯]

-- 
Lee Jones [李琼斯]
