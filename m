Return-Path: <linux-kernel+bounces-133755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D7289A822
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D1C1C22A6F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A77BA2F;
	Sat,  6 Apr 2024 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6tJWl3S"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3174CC8E1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 01:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712366087; cv=none; b=BogsEC88wVHTosMx7bgf8f0JcqGkxoJybP7Iaiu8+gZs8rRwCfaAHhN2o1p83mw3ktsi8HVAEx8t4WLrdv+Coz2Ks4hlQbURJe2xGCiPznCIAIRlQer+URMdpxKuOc0LejyPZZOa0THsWZzyS5Q+QXodlxAxqRp5mJzz5WX2wJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712366087; c=relaxed/simple;
	bh=r/gYE/Zz9tJKKilM7m8Zai2JPeh/htkd2LIkdAiTKNc=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BYzUyAEb5Zh00uWgw+k4/fnK4sWBTMZAd2ZN/dV//eFhTDYaWPqy9Mb6hVgOeObofpKksbZjI9EOSDB7/+4GzFgtISdku8QRmi17D+9OJ/vsPi8ZRyABkBUMTXPnuWJxxlgwaGhPsAc2hsiPaJVqtWANQOtI5JRZCCZtX7hluoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6tJWl3S; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-22e8676c670so1464346fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 18:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712366084; x=1712970884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUOCIQFB2R9168eqGn8/GvggwQbCuKvMKomVQmoNhkI=;
        b=U6tJWl3SvOy4T453SqgyZ32YxAvNUfgw5GzuVE22i/CabyQuZbrC2uHBbuigkQENaI
         qAwjAC30bUb22V92/h/yQDzRwULOAhps2rCqEUqHBaRC0qt+Nwqg3h89T4KThfzP76hk
         MkxVMuaEwanlWk9hKEMYlq0e9B5+eq06AiKqZQYk2LF0O9f1zfRbEUXvWEyxWhF8yC/H
         9V1T0oyIVf61Cr1rCfgqNqMwTl9bo4lC5O9JN2EZ0L3TDjxsTpl18myRZ8dMj1dPEsEz
         MhE752nVvVedIqWjUQf5PMff1LrDBKPfFTby8nr0N+4ytqUyGwSJmVfxUAeQ055IY6av
         c12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712366084; x=1712970884;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OUOCIQFB2R9168eqGn8/GvggwQbCuKvMKomVQmoNhkI=;
        b=YscxmbGYGmSQvowhHFUTrfHhtLC6zPEiukFb0ztFWSnpaPLSAE3Y0reHSxy+pRlJDp
         AyongR2/f6FBlBeuEeze8QeJ14KB3Klsy47EDnZ5AXv3HqbCxsrEa9I6vYGgnGOp6NvG
         z4T2ceydjmiK4Q5muKXM+3aeqYzspbksIG8eMR5MnyQs/wn/W1eDM7svO4EzRpIY3znd
         MU0x1juk4e3iXuy7r6rdEo/pV4cqYkiBu8YgHTKTIwdpLFQoAUeSXZ7VlO1hmEhLW9gu
         KYpNHXulXvoHGP0ExegRK1+SCEZF67bzCztWlKz2Y7yjplS6Neh2+zDS3x9Z2lNo+87Y
         Eo/g==
X-Forwarded-Encrypted: i=1; AJvYcCU+MetvYIjrrhN22GoDNBSMoKOFwZwCkapshmyJrCjxkHWbyWCwzqFDSJKUOibW4mihO+jyLM+FxP08SjbT7NgiKXb6ymubb9YRxFss
X-Gm-Message-State: AOJu0YwRdQXPswptZRQ0ZnXvQf6SVemoHLT7s8Ukf6mXIKZvbZOkMil6
	hKSG+BMmyv5ElI4lLugtVjaAfT16g1+Xix/DnGH0FTl3KDDLRbDWSafF7eSD
X-Google-Smtp-Source: AGHT+IEe6Ulz+W731tqsz/LUln5enWgNx5JLI+x3ByqhMGEdtA74wHX/xIdqny7RQXWQMsBRDh8qVA==
X-Received: by 2002:a05:6870:f286:b0:22e:c504:74af with SMTP id u6-20020a056870f28600b0022ec50474afmr3577208oap.20.1712366084300;
        Fri, 05 Apr 2024 18:14:44 -0700 (PDT)
Received: from [10.1.1.24] (222-152-175-63-fibre.sparkbb.co.nz. [222.152.175.63])
        by smtp.gmail.com with ESMTPSA id w3-20020aa78583000000b006ecd942161fsm2119552pfn.190.2024.04.05.18.14.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2024 18:14:43 -0700 (PDT)
Subject: Re: [PATCH 0/1] m68k: Handle HAS_IOPORT dependencies
To: Arnd Bergmann <arnd@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
References: <20240403122851.38808-1-schnelle@linux.ibm.com>
 <dd55afa6-8cb6-4e25-b720-d2df62dbb5e6@gmail.com>
 <bf276f98-2712-4fcf-a119-f984a1aedbf2@app.fastmail.com>
 <CAMuHMdX+M1VuhDVnC9n4hCBDjHywwsByNK1w8ibazc+-8_C53A@mail.gmail.com>
 <d9bdfa48-572a-caa1-229b-44565690d9e6@gmail.com>
 <6b308ab0-dda7-4052-98b3-cb03e17e3e12@app.fastmail.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
 linux-m68k@lists.linux-m68k.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <ff54515f-3fc1-8f5f-8a15-d4ebbeb2035b@gmail.com>
Date: Sat, 6 Apr 2024 14:14:35 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6b308ab0-dda7-4052-98b3-cb03e17e3e12@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Arnd,

thanks for your suggestions!

Am 06.04.2024 um 09:13 schrieb Arnd Bergmann:
> On Fri, Apr 5, 2024, at 20:36, Michael Schmitz wrote:
>> Am 05.04.2024 um 23:16 schrieb Geert Uytterhoeven:
>>> On Wed, Apr 3, 2024 at 8:35 PM Arnd Bergmann <arnd@kernel.org> wrote:
>>>> On Wed, Apr 3, 2024, at 20:11, Michael Schmitz wrote:
>>>>> how do you propose we handle legacy drivers that do depend on
>>>>> inb()/outb() functions (_not_ actual ISA I/O) on architectures that map
>>>>> inb()/outb() to MMIO functions?
>>>>>
>>>>> (In my case, that's at least ne.c - Geert ought to have a better
>>>>> overview what else does use inb()/outb() on m68k)
>>>>
>>>> If a machine provides an inb()/outb() set of operations that
>>>> is actually used, it should set HAS_IOPORT.
>>>>
>>>> For the Q40, it may be better in the long run to change the
>>>> drivers to just use MMIO directly though.
>>>
>>> Q40 uses ISA.
>>>
>>> Michael is worried about non-ISA drivers using inb() and friends.
>>> At some point in time (i.e. eons ago), we were told it was better to
>>> use in[bwl]()/read[bwl]() instead of directly dereferencing volatile
>>> pointers...
>>>
>>> Anyway, I don't think we have many users of inb() and friends left, and
>>> I assume the bots should have detected any/most remaining users in Niklas'
>>> branch...
>>
>> All the 8390 based ethernet drivers still use inb() and friends.
>>
>> That is the main reason for the terrible hacks in
>> arch/m68k/include/asm/io_mm.h ...
>>
>> The last time I tried to add support for a different PCMCIA ethernet
>> adapter to apne.c _without_ adding to the hacks in io_mm.h, I wasn't
>> getting anywhere with the netdev crowd. That was ages ago, and I doubt
>> their enthusiasm for a rewrite of the 8390 code base to avoid using
>> inb() on MMIO architectures will be any better now.
>
> From what I can see, there is already an abstraction layer in
> these drivers that is used by all m68k drivers except apne:

As well as ne ... which uses the 8390p.c helper.

>
> $ git grep -w 'define\sei_inb'
> drivers/net/ethernet/8390/8390.h:#define ei_inb(_p)     inb(_p)
> drivers/net/ethernet/8390/8390p.c:#define ei_inb(_p)    inb(_p)
> drivers/net/ethernet/8390/ax88796.c:#define ei_inb(_a) readb(ax_convert_addr(_a))
> drivers/net/ethernet/8390/etherh.c:#define ei_inb(_p)    readb((void __iomem *)_p)
> drivers/net/ethernet/8390/hydra.c:#define ei_inb(port)   in_8(port)
> drivers/net/ethernet/8390/mac8390.c:#define ei_inb(port)        in_8(port)
> drivers/net/ethernet/8390/mcf8390.c:#define     ei_inb  ei_inb
> drivers/net/ethernet/8390/xsurf100.c:#define ei_inb(_a) z_readb(ax_convert_addr(_a))
> drivers/net/ethernet/8390/zorro8390.c:#define ei_inb(port)              in_8(port)
>
> Can't apne.c just do the same here? The patch below didn't
> take that long to come up with, but I may be missing something
> here of course.

The address translation from ISA IO ports to MMIO addresses needs to be 
added as well (in_8() does not use address translation on m68k). apne.c 
also uses inw() which does have a different address translation yet, but 
that's only for data transfer from the ring buffers and can be handled 
entirely inside apne.c.

Now that is all limited to m68k. I might be able to submit a patch, but 
I cannot test any of this.

ne.c needs the same treatment as far as I can see, and I could actually 
test that one (on Atari, not actually on a PC ISA card). I'll see what I 
can come up with.

I might well be missing something else here - as I said, it's been a few 
years since I worked on the apne driver, and experimented with IO 
abstractions in that context. The problem has always been making sure 
drivers shared by different m68k platforms need only be built once and 
still work on e.g. Q40 and Atari.

You've given me something to work with, thanks again!

Cheers,

	Michael

>
>     Arnd
>
> 8<---
> From 5dd43e612a52adf499b1ea3d33e3b2b45894d275 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Fri, 5 Apr 2024 21:47:51 +0200
> Subject: [PATCH] net: apne: convert to lib8390
>
> The apne driver still uses the ISA-style inb()/outb() wappers through the
> 8390.c helper module, which won't work in the future.
>
> Change it to include lib8390.c like all the other m68k variants of this
> driver do, so it can have custom MMIO abstractions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/drivers/net/ethernet/8390/Makefile b/drivers/net/ethernet/8390/Makefile
> index 85c83c566ec6..ec1b325da4e4 100644
> --- a/drivers/net/ethernet/8390/Makefile
> +++ b/drivers/net/ethernet/8390/Makefile
> @@ -4,7 +4,7 @@
>  #
>
>  obj-$(CONFIG_MAC8390) += mac8390.o
> -obj-$(CONFIG_APNE) += apne.o 8390.o
> +obj-$(CONFIG_APNE) += apne.o
>  obj-$(CONFIG_ARM_ETHERH) += etherh.o
>  obj-$(CONFIG_AX88796) += ax88796.o
>  obj-$(CONFIG_HYDRA) += hydra.o
> diff --git a/drivers/net/ethernet/8390/apne.c b/drivers/net/ethernet/8390/apne.c
> index 828edca8d30c..ea3747723b3c 100644
> --- a/drivers/net/ethernet/8390/apne.c
> +++ b/drivers/net/ethernet/8390/apne.c
> @@ -41,7 +41,15 @@
>  #include <asm/amigayle.h>
>  #include <asm/amipcmcia.h>
>
> -#include "8390.h"
> +#define ei_inb(port)            in_8(port)
> +#define ei_outb(val, port)      out_8(port, val)
> +#define ei_inb_p(port)          in_8(port)
> +#define ei_outb_p(val, port)    out_8(port, val)
> +
> +static const char version[] =
> +    "apne.c:v1.1 7/10/98 Alain Malek (Alain.Malek@cryogen.ch)\n";
> +
> +#include "lib8390.c"
>
>  /* ---- No user-serviceable parts below ---- */
>
> @@ -105,14 +113,21 @@ static int init_pcmcia(void);
>  #define MANUAL_HWADDR5 0x9a
>  */
>
> -static const char version[] =
> -    "apne.c:v1.1 7/10/98 Alain Malek (Alain.Malek@cryogen.ch)\n";
> -
>  static int apne_owned;	/* signal if card already owned */
>
> -static u32 apne_msg_enable;
> -module_param_named(msg_enable, apne_msg_enable, uint, 0444);
> -MODULE_PARM_DESC(msg_enable, "Debug message level (see linux/netdevice.h for bitmap)");
> +static const struct net_device_ops apne_netdev_ops = {
> +	.ndo_open		= __ei_open,
> +	.ndo_stop		= __ei_close,
> +	.ndo_start_xmit		= __ei_start_xmit,
> +	.ndo_tx_timeout		= __ei_tx_timeout,
> +	.ndo_get_stats		= __ei_get_stats,
> +	.ndo_set_rx_mode	= __ei_set_multicast_list,
> +	.ndo_validate_addr	= eth_validate_addr,
> +	.ndo_set_mac_address	= eth_mac_addr,
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +	.ndo_poll_controller	= __ei_poll,
> +#endif
> +};
>
>  static struct net_device * __init apne_probe(void)
>  {
> @@ -141,11 +156,11 @@ static struct net_device * __init apne_probe(void)
>  		return ERR_PTR(-ENODEV);
>  	}
>
> -	dev = alloc_ei_netdev();
> +	dev = ____alloc_ei_netdev(0);
>  	if (!dev)
>  		return ERR_PTR(-ENOMEM);
>  	ei_local = netdev_priv(dev);
> -	ei_local->msg_enable = apne_msg_enable;
> +	ei_local->msg_enable = msg_enable;
>
>  	/* disable pcmcia irq for readtuple */
>  	pcmcia_disable_irq();
> @@ -203,7 +218,7 @@ static int __init apne_probe1(struct net_device *dev, int ioaddr)
>  #endif
>      static unsigned version_printed;
>
> -    if ((apne_msg_enable & NETIF_MSG_DRV) && (version_printed++ == 0))
> +    if ((msg_enable & NETIF_MSG_DRV) && (version_printed++ == 0))
>  		netdev_info(dev, version);
>
>      netdev_info(dev, "PCMCIA NE*000 ethercard probe");
> @@ -309,7 +324,7 @@ static int __init apne_probe1(struct net_device *dev, int ioaddr)
>
>      dev->base_addr = ioaddr;
>      dev->irq = IRQ_AMIGA_PORTS;
> -    dev->netdev_ops = &ei_netdev_ops;
> +    dev->netdev_ops = &apne_netdev_ops;
>
>      /* Install the Interrupt handler */
>      i = request_irq(dev->irq, apne_interrupt, IRQF_SHARED, DRV_NAME, dev);
> @@ -333,7 +348,7 @@ static int __init apne_probe1(struct net_device *dev, int ioaddr)
>      ei_status.block_output = &apne_block_output;
>      ei_status.get_8390_hdr = &apne_get_8390_hdr;
>
> -    NS8390_init(dev, 0);
> +    __NS8390_init(dev, 0);
>
>      pcmcia_ack_int(pcmcia_get_intreq());		/* ack PCMCIA int req */
>      pcmcia_enable_irq();
> @@ -513,7 +528,7 @@ apne_block_output(struct net_device *dev, int count,
>  	if (time_after(jiffies, dma_start + 2*HZ/100)) {	/* 20ms */
>  		netdev_warn(dev, "timeout waiting for Tx RDC.\n");
>  		apne_reset_8390(dev);
> -		NS8390_init(dev,1);
> +		__NS8390_init(dev,1);
>  		break;
>  	}
>
> @@ -534,10 +549,10 @@ static irqreturn_t apne_interrupt(int irq, void *dev_id)
>          pcmcia_ack_int(pcmcia_intreq);
>          return IRQ_NONE;
>      }
> -    if (apne_msg_enable & NETIF_MSG_INTR)
> +    if (msg_enable & NETIF_MSG_INTR)
>  	pr_debug("pcmcia intreq = %x\n", pcmcia_intreq);
>      pcmcia_disable_irq();			/* to get rid of the sti() within ei_interrupt */
> -    ei_interrupt(irq, dev_id);
> +    __ei_interrupt(irq, dev_id);
>      pcmcia_ack_int(pcmcia_get_intreq());
>      pcmcia_enable_irq();
>      return IRQ_HANDLED;
>

