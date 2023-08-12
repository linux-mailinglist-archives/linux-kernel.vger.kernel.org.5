Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EE577A09A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjHLPBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLPBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:01:10 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0454E10FB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:01:12 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C7D7F1C0002;
        Sat, 12 Aug 2023 15:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691852471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Alzx0G/XPXpFyVa7O/4kvWcI5FZUIwHqNqauLfR57Lk=;
        b=d5UegVnwQCxkeqnhM19cX1CA2NdPjbFqAp9XfSh6kdknk/PpLZ7+GTGeorsXHP+Pp9YBd7
        Tt+Y/VNZ7fQcMi9bxO5/sJqX0YMlTYJ/B/BJTowF7kopZHdC+HrZuG9oN2YD7eJ5zXR4rd
        3Mqr/Hi9DCe2E8GKHI4rGA9AQUuc5h/wvxTEnZBcbvq8k+zMnoNUQvCexfRkrnBJvgDiN3
        +W2sXsFQWxg/uFdhExGK3DS6l/rLvLg30iok1dMRlzQN0pktoLw9FxzBOfIYoX6zwAzu8y
        QCbL9Z6uzXXl8pp4nXTBDh71HzUx+QKvC7N3Tq055TorH9Pa2vUY/DVmlFaJKA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Rob Herring <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mvebu: Explicitly include correct DT includes
In-Reply-To: <20230717225456.3212019-1-robh@kernel.org>
References: <20230717225456.3212019-1-robh@kernel.org>
Date:   Sat, 12 Aug 2023 17:01:09 +0200
Message-ID: <87v8dktidm.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied on mvebu/arm

Thanks,

Gregory
> ---
>  arch/arm/mach-mvebu/kirkwood.c | 1 +
>  arch/arm/mach-mvebu/pmsu.c     | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
> index 8ff34753e760..73b2a86d6489 100644
> --- a/arch/arm/mach-mvebu/kirkwood.c
> +++ b/arch/arm/mach-mvebu/kirkwood.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_net.h>
>  #include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <asm/hardware/cache-feroceon-l2.h>
>  #include <asm/mach/arch.h>
> diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
> index 6f366d8c4231..79c5171f06ec 100644
> --- a/arch/arm/mach-mvebu/pmsu.c
> +++ b/arch/arm/mach-mvebu/pmsu.c
> @@ -23,8 +23,8 @@
>  #include <linux/kernel.h>
>  #include <linux/mbus.h>
>  #include <linux/mvebu-pmsu.h>
> +#include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/resource.h>
>  #include <linux/slab.h>
> -- 
> 2.40.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
