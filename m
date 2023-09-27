Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC047B039E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjI0MMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjI0MMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FFA196
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695816694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j/XxDyek/Q/2ZVTp/WQFAQdK2L4m9KV2ebzrY+oyuLY=;
        b=Qin7qZ8sHLR5yMnGZ8ZmbnMSo19BFMhsR1pDq2JtVHtck6TXogFyVVxuV0/FUpQG7hSj+c
        s5D6Gs2BkRjbPAWqSyAXQoba00dGsNKwZ816hXYEVOpFoT8CS96VN8HefXyFBESZyqwBW1
        b7IZQVjU0XACzRaWOBUfJGo+fipTrpM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-eECeqdWYP6OKJdcO12nEGQ-1; Wed, 27 Sep 2023 08:11:31 -0400
X-MC-Unique: eECeqdWYP6OKJdcO12nEGQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae57d8b502so914895566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695816690; x=1696421490;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/XxDyek/Q/2ZVTp/WQFAQdK2L4m9KV2ebzrY+oyuLY=;
        b=YMMgXb4T/ejFRxlaDnXRVdCrP65xzuXaBv23vZDcqMglRhLTfaJYaOFZFu/QJuZ+Ig
         t6+VvC+8PQTmma5cl6pn4cTLgLs7TV+e5rTNkGV2hHr0YzoDxkJ+6vVe71g3MvZWJaHo
         xjCyZGHN+urvP55d0sl5+07DK3iCWeJFNH3qvWSac+pJhK3187r2UkRie9EC+47mHU/K
         fbaY919iEiw5agls8h1bS5S8b14VcLKPareajE+yVM+NIrE0KOaqH9wSMPSzNF9uFylo
         oZws0BctwtxRTUttnLTPVActVVvAq0MZnwhbAvGIqbijwPqfbrYXSBg1hBvgKZ8q9R1a
         MvtA==
X-Gm-Message-State: AOJu0YyQ2ch3dYwZyD2jhujRLmc6NmT8tRaonzAa3+nst5hUajqev+sY
        ka+W259iqZKdX25KDTwwvXaT5DWSyGLqnu28QhKYHFPtQ9/J/NFfkWOw0cJb3w9Q6ahX/RBHCAz
        c1QtbtHf5Z/2wDJ6CedaM49Hr7E3vIXER
X-Received: by 2002:a17:907:7857:b0:9a5:874a:9745 with SMTP id lb23-20020a170907785700b009a5874a9745mr1436075ejc.26.1695816689604;
        Wed, 27 Sep 2023 05:11:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5aYsS5mqIr0SPepr0XIa7eIIFBNKZ+bBX+zEyA1S2Zg4v94xgjm2ff6CAUDGYgqgTi9EZPw==
X-Received: by 2002:a17:907:7857:b0:9a5:874a:9745 with SMTP id lb23-20020a170907785700b009a5874a9745mr1436027ejc.26.1695816688488;
        Wed, 27 Sep 2023 05:11:28 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906614800b009828e26e519sm9101007ejl.122.2023.09.27.05.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 05:11:27 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prarit Bhargava <prarit@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, jschlst@samba.org
Subject: Re: [PATCH] net: appletalk: remove cops support
In-Reply-To: <20230927090029.44704-2-gregkh@linuxfoundation.org>
References: <20230927090029.44704-2-gregkh@linuxfoundation.org>
Date:   Wed, 27 Sep 2023 14:11:26 +0200
Message-ID: <87fs2zbytt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> The COPS Appletalk support is very old, never said to actually work
> properly, and the firmware code for the devices are under a very suspect
> license.  Remove it all to clear up the license issue, if it is still
> needed and actually used by anyone, we can add it back later once the
> license is cleared up.
>
> Reported-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>

FWIW,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

> Cc: jschlst@samba.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  .../device_drivers/appletalk/cops.rst         |   80 --
>  .../device_drivers/appletalk/index.rst        |   18 -
>  .../networking/device_drivers/index.rst       |    1 -
>  drivers/net/Space.c                           |    6 -
>  drivers/net/appletalk/Kconfig                 |   30 -
>  drivers/net/appletalk/Makefile                |    1 -
>  drivers/net/appletalk/cops.c                  | 1005 -----------------
>  drivers/net/appletalk/cops.h                  |   61 -
>  drivers/net/appletalk/cops_ffdrv.h            |  532 ---------
>  drivers/net/appletalk/cops_ltdrv.h            |  241 ----
>  include/net/Space.h                           |    1 -
>  11 files changed, 1976 deletions(-)
>  delete mode 100644 Documentation/networking/device_drivers/appletalk/cops.rst
>  delete mode 100644 Documentation/networking/device_drivers/appletalk/index.rst
>  delete mode 100644 drivers/net/appletalk/cops.c
>  delete mode 100644 drivers/net/appletalk/cops.h
>  delete mode 100644 drivers/net/appletalk/cops_ffdrv.h
>  delete mode 100644 drivers/net/appletalk/cops_ltdrv.h
>
> diff --git a/Documentation/networking/device_drivers/appletalk/cops.rst b/Documentation/networking/device_drivers/appletalk/cops.rst
> deleted file mode 100644
> index 964ba80599a9..000000000000
> --- a/Documentation/networking/device_drivers/appletalk/cops.rst
> +++ /dev/null
> @@ -1,80 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0
> -
> -========================================
> -The COPS LocalTalk Linux driver (cops.c)
> -========================================
> -
> -By Jay Schulist <jschlst@samba.org>
> -
> -This driver has two modes and they are: Dayna mode and Tangent mode.
> -Each mode corresponds with the type of card. It has been found
> -that there are 2 main types of cards and all other cards are
> -the same and just have different names or only have minor differences
> -such as more IO ports. As this driver is tested it will
> -become more clear exactly what cards are supported.
> -
> -Right now these cards are known to work with the COPS driver. The
> -LT-200 cards work in a somewhat more limited capacity than the
> -DL200 cards, which work very well and are in use by many people.
> -
> -TANGENT driver mode:
> -	- Tangent ATB-II, Novell NL-1000, Daystar Digital LT-200
> -
> -DAYNA driver mode:
> -	- Dayna DL2000/DaynaTalk PC (Half Length), COPS LT-95,
> -	- Farallon PhoneNET PC III, Farallon PhoneNET PC II
> -
> -Other cards possibly supported mode unknown though:
> -	- Dayna DL2000 (Full length)
> -
> -The COPS driver defaults to using Dayna mode. To change the driver's
> -mode if you built a driver with dual support use board_type=1 or
> -board_type=2 for Dayna or Tangent with insmod.
> -
> -Operation/loading of the driver
> -===============================
> -
> -Use modprobe like this:	/sbin/modprobe cops.o (IO #) (IRQ #)
> -If you do not specify any options the driver will try and use the IO = 0x240,
> -IRQ = 5. As of right now I would only use IRQ 5 for the card, if autoprobing.
> -
> -To load multiple COPS driver Localtalk cards you can do one of the following::
> -
> -	insmod cops io=0x240 irq=5
> -	insmod -o cops2 cops io=0x260 irq=3
> -
> -Or in lilo.conf put something like this::
> -
> -	append="ether=5,0x240,lt0 ether=3,0x260,lt1"
> -
> -Then bring up the interface with ifconfig. It will look something like this::
> -
> -  lt0       Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-F7-00-00-00-00-00-00-00-00
> -	    inet addr:192.168.1.2  Bcast:192.168.1.255  Mask:255.255.255.0
> -	    UP BROADCAST RUNNING NOARP MULTICAST  MTU:600  Metric:1
> -	    RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> -	    TX packets:0 errors:0 dropped:0 overruns:0 carrier:0 coll:0
> -
> -Netatalk Configuration
> -======================
> -
> -You will need to configure atalkd with something like the following to make
> -it work with the cops.c driver.
> -
> -* For single LTalk card use::
> -
> -    dummy -seed -phase 2 -net 2000 -addr 2000.10 -zone "1033"
> -    lt0 -seed -phase 1 -net 1000 -addr 1000.50 -zone "1033"
> -
> -* For multiple cards, Ethernet and LocalTalk::
> -
> -    eth0 -seed -phase 2 -net 3000 -addr 3000.20 -zone "1033"
> -    lt0 -seed -phase 1 -net 1000 -addr 1000.50 -zone "1033"
> -
> -* For multiple LocalTalk cards, and an Ethernet card.
> -
> -* Order seems to matter here, Ethernet last::
> -
> -    lt0 -seed -phase 1 -net 1000 -addr 1000.10 -zone "LocalTalk1"
> -    lt1 -seed -phase 1 -net 2000 -addr 2000.20 -zone "LocalTalk2"
> -    eth0 -seed -phase 2 -net 3000 -addr 3000.30 -zone "EtherTalk"
> diff --git a/Documentation/networking/device_drivers/appletalk/index.rst b/Documentation/networking/device_drivers/appletalk/index.rst
> deleted file mode 100644
> index c196baeb0856..000000000000
> --- a/Documentation/networking/device_drivers/appletalk/index.rst
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -
> -AppleTalk Device Drivers
> -========================
> -
> -Contents:
> -
> -.. toctree::
> -   :maxdepth: 2
> -
> -   cops
> -
> -.. only::  subproject and html
> -
> -   Indices
> -   =======
> -
> -   * :ref:`genindex`
> diff --git a/Documentation/networking/device_drivers/index.rst b/Documentation/networking/device_drivers/index.rst
> index 601eacaf12f3..2f0285a5bc80 100644
> --- a/Documentation/networking/device_drivers/index.rst
> +++ b/Documentation/networking/device_drivers/index.rst
> @@ -8,7 +8,6 @@ Contents:
>  .. toctree::
>     :maxdepth: 2
>  
> -   appletalk/index
>     atm/index
>     cable/index
>     can/index
> diff --git a/drivers/net/Space.c b/drivers/net/Space.c
> index 83214e2e70ab..dc50797a2ed0 100644
> --- a/drivers/net/Space.c
> +++ b/drivers/net/Space.c
> @@ -247,12 +247,6 @@ static int __init net_olddevs_init(void)
>  	for (num = 0; num < 8; ++num)
>  		ethif_probe2(num);
>  
> -#ifdef CONFIG_COPS
> -	cops_probe(0);
> -	cops_probe(1);
> -	cops_probe(2);
> -#endif
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/net/appletalk/Kconfig b/drivers/net/appletalk/Kconfig
> index b38ed52b82bc..b94f731e4576 100644
> --- a/drivers/net/appletalk/Kconfig
> +++ b/drivers/net/appletalk/Kconfig
> @@ -37,36 +37,6 @@ config DEV_APPLETALK
>  	  on a network.  If your Linux box is connected to such a network, and wish
>  	  to do IP over it, or you have a LocalTalk card and wish to use it to
>  	  connect to the AppleTalk network, say Y.
> -	  
> -
> -config COPS
> -	tristate "COPS LocalTalk PC support"
> -	depends on DEV_APPLETALK && ISA
> -	depends on NETDEVICES
> -	select NETDEV_LEGACY_INIT
> -	help
> -	  This allows you to use COPS AppleTalk cards to connect to LocalTalk
> -	  networks. You also need version 1.3.3 or later of the netatalk
> -	  package. This driver is experimental, which means that it may not
> -	  work. This driver will only work if you choose "AppleTalk DDP"
> -	  networking support, above.
> -	  Please read the file
> -	  <file:Documentation/networking/device_drivers/appletalk/cops.rst>.
> -
> -config COPS_DAYNA
> -	bool "Dayna firmware support"
> -	depends on COPS
> -	help
> -	  Support COPS compatible cards with Dayna style firmware (Dayna
> -	  DL2000/ Daynatalk/PC (half length), COPS LT-95, Farallon PhoneNET PC
> -	  III, Farallon PhoneNET PC II).
> -
> -config COPS_TANGENT
> -	bool "Tangent firmware support"
> -	depends on COPS
> -	help
> -	  Support COPS compatible cards with Tangent style firmware (Tangent
> -	  ATB_II, Novell NL-1000, Daystar Digital LT-200.
>  
>  config IPDDP
>  	tristate "Appletalk-IP driver support"
> diff --git a/drivers/net/appletalk/Makefile b/drivers/net/appletalk/Makefile
> index 6db2943ce5d6..d8c7b23ec7ff 100644
> --- a/drivers/net/appletalk/Makefile
> +++ b/drivers/net/appletalk/Makefile
> @@ -4,4 +4,3 @@
>  #
>  
>  obj-$(CONFIG_IPDDP) += ipddp.o
> -obj-$(CONFIG_COPS) += cops.o
> diff --git a/drivers/net/appletalk/cops.c b/drivers/net/appletalk/cops.c
> deleted file mode 100644
> index 97f254bdbb16..000000000000
> --- a/drivers/net/appletalk/cops.c
> +++ /dev/null
> @@ -1,1005 +0,0 @@
> -/*      cops.c: LocalTalk driver for Linux.
> - *
> - *	Authors:
> - *      - Jay Schulist <jschlst@samba.org>
> - *
> - *	With more than a little help from;
> - *	- Alan Cox <alan@lxorguk.ukuu.org.uk>
> - *
> - *      Derived from:
> - *      - skeleton.c: A network driver outline for linux.
> - *        Written 1993-94 by Donald Becker.
> - *	- ltpc.c: A driver for the LocalTalk PC card.
> - *	  Written by Bradford W. Johnson.
> - *
> - *      Copyright 1993 United States Government as represented by the
> - *      Director, National Security Agency.
> - *
> - *      This software may be used and distributed according to the terms
> - *      of the GNU General Public License, incorporated herein by reference.
> - *
> - *	Changes:
> - *	19970608	Alan Cox	Allowed dual card type support
> - *					Can set board type in insmod
> - *					Hooks for cops_setup routine
> - *					(not yet implemented).
> - *	19971101	Jay Schulist	Fixes for multiple lt* devices.
> - *	19980607	Steven Hirsch	Fixed the badly broken support
> - *					for Tangent type cards. Only
> - *                                      tested on Daystar LT200. Some
> - *                                      cleanup of formatting and program
> - *                                      logic.  Added emacs 'local-vars'
> - *                                      setup for Jay's brace style.
> - *	20000211	Alan Cox	Cleaned up for softnet
> - */
> -
> -static const char *version =
> -"cops.c:v0.04 6/7/98 Jay Schulist <jschlst@samba.org>\n";
> -/*
> - *  Sources:
> - *      COPS Localtalk SDK. This provides almost all of the information
> - *      needed.
> - */
> -
> -/*
> - * insmod/modprobe configurable stuff.
> - *	- IO Port, choose one your card supports or 0 if you dare.
> - *	- IRQ, also choose one your card supports or nothing and let
> - *	  the driver figure it out.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/types.h>
> -#include <linux/fcntl.h>
> -#include <linux/interrupt.h>
> -#include <linux/ptrace.h>
> -#include <linux/ioport.h>
> -#include <linux/in.h>
> -#include <linux/string.h>
> -#include <linux/errno.h>
> -#include <linux/init.h>
> -#include <linux/netdevice.h>
> -#include <linux/etherdevice.h>
> -#include <linux/skbuff.h>
> -#include <linux/if_arp.h>
> -#include <linux/if_ltalk.h>
> -#include <linux/delay.h>	/* For udelay() */
> -#include <linux/atalk.h>
> -#include <linux/spinlock.h>
> -#include <linux/bitops.h>
> -#include <linux/jiffies.h>
> -
> -#include <net/Space.h>
> -
> -#include <asm/io.h>
> -#include <asm/dma.h>
> -
> -#include "cops.h"		/* Our Stuff */
> -#include "cops_ltdrv.h"		/* Firmware code for Tangent type cards. */
> -#include "cops_ffdrv.h"		/* Firmware code for Dayna type cards. */
> -
> -/*
> - *      The name of the card. Is used for messages and in the requests for
> - *      io regions, irqs and dma channels
> - */
> -
> -static const char *cardname = "cops";
> -
> -#ifdef CONFIG_COPS_DAYNA
> -static int board_type = DAYNA;	/* Module exported */
> -#else
> -static int board_type = TANGENT;
> -#endif
> -
> -static int io = 0x240;		/* Default IO for Dayna */
> -static int irq = 5;		/* Default IRQ */
> -
> -/*
> - *	COPS Autoprobe information.
> - *	Right now if port address is right but IRQ is not 5 this will
> - *      return a 5 no matter what since we will still get a status response.
> - *      Need one more additional check to narrow down after we have gotten
> - *      the ioaddr. But since only other possible IRQs is 3 and 4 so no real
> - *	hurry on this. I *STRONGLY* recommend using IRQ 5 for your card with
> - *	this driver.
> - * 
> - *	This driver has 2 modes and they are: Dayna mode and Tangent mode.
> - *	Each mode corresponds with the type of card. It has been found
> - *	that there are 2 main types of cards and all other cards are
> - *	the same and just have different names or only have minor differences
> - *	such as more IO ports. As this driver is tested it will
> - *	become more clear on exactly what cards are supported. The driver
> - *	defaults to using Dayna mode. To change the drivers mode, simply
> - *	select Dayna or Tangent mode when configuring the kernel.
> - *
> - *      This driver should support:
> - *      TANGENT driver mode:
> - *              Tangent ATB-II, Novell NL-1000, Daystar Digital LT-200,
> - *		COPS LT-1
> - *      DAYNA driver mode:
> - *              Dayna DL2000/DaynaTalk PC (Half Length), COPS LT-95, 
> - *		Farallon PhoneNET PC III, Farallon PhoneNET PC II
> - *	Other cards possibly supported mode unknown though:
> - *		Dayna DL2000 (Full length), COPS LT/M (Micro-Channel)
> - *
> - *	Cards NOT supported by this driver but supported by the ltpc.c
> - *	driver written by Bradford W. Johnson <johns393@maroon.tc.umn.edu>
> - *		Farallon PhoneNET PC
> - *		Original Apple LocalTalk PC card
> - * 
> - *      N.B.
> - *
> - *      The Daystar Digital LT200 boards do not support interrupt-driven
> - *      IO.  You must specify 'irq=0xff' as a module parameter to invoke
> - *      polled mode.  I also believe that the port probing logic is quite
> - *      dangerous at best and certainly hopeless for a polled card.  Best to 
> - *      specify both. - Steve H.
> - *
> - */
> -
> -/*
> - * Zero terminated list of IO ports to probe.
> - */
> -
> -static unsigned int ports[] = { 
> -	0x240, 0x340, 0x200, 0x210, 0x220, 0x230, 0x260, 
> -	0x2A0, 0x300, 0x310, 0x320, 0x330, 0x350, 0x360,
> -	0
> -};
> -
> -/*
> - * Zero terminated list of IRQ ports to probe.
> - */
> -
> -static int cops_irqlist[] = {
> -	5, 4, 3, 0 
> -};
> -
> -static struct timer_list cops_timer;
> -static struct net_device *cops_timer_dev;
> -
> -/* use 0 for production, 1 for verification, 2 for debug, 3 for verbose debug */
> -#ifndef COPS_DEBUG
> -#define COPS_DEBUG 1 
> -#endif
> -static unsigned int cops_debug = COPS_DEBUG;
> -
> -/* The number of low I/O ports used by the card. */
> -#define COPS_IO_EXTENT       8
> -
> -/* Information that needs to be kept for each board. */
> -
> -struct cops_local
> -{
> -        int board;			/* Holds what board type is. */
> -	int nodeid;			/* Set to 1 once have nodeid. */
> -        unsigned char node_acquire;	/* Node ID when acquired. */
> -        struct atalk_addr node_addr;	/* Full node address */
> -	spinlock_t lock;		/* RX/TX lock */
> -};
> -
> -/* Index to functions, as function prototypes. */
> -static int  cops_probe1 (struct net_device *dev, int ioaddr);
> -static int  cops_irq (int ioaddr, int board);
> -
> -static int  cops_open (struct net_device *dev);
> -static int  cops_jumpstart (struct net_device *dev);
> -static void cops_reset (struct net_device *dev, int sleep);
> -static void cops_load (struct net_device *dev);
> -static int  cops_nodeid (struct net_device *dev, int nodeid);
> -
> -static irqreturn_t cops_interrupt (int irq, void *dev_id);
> -static void cops_poll(struct timer_list *t);
> -static void cops_timeout(struct net_device *dev, unsigned int txqueue);
> -static void cops_rx (struct net_device *dev);
> -static netdev_tx_t  cops_send_packet (struct sk_buff *skb,
> -					    struct net_device *dev);
> -static void set_multicast_list (struct net_device *dev);
> -static int  cops_ioctl (struct net_device *dev, struct ifreq *rq, int cmd);
> -static int  cops_close (struct net_device *dev);
> -
> -static void cleanup_card(struct net_device *dev)
> -{
> -	if (dev->irq)
> -		free_irq(dev->irq, dev);
> -	release_region(dev->base_addr, COPS_IO_EXTENT);
> -}
> -
> -/*
> - *      Check for a network adaptor of this type, and return '0' iff one exists.
> - *      If dev->base_addr == 0, probe all likely locations.
> - *      If dev->base_addr in [1..0x1ff], always return failure.
> - *        otherwise go with what we pass in.
> - */
> -struct net_device * __init cops_probe(int unit)
> -{
> -	struct net_device *dev;
> -	unsigned *port;
> -	int base_addr;
> -	int err = 0;
> -
> -	dev = alloc_ltalkdev(sizeof(struct cops_local));
> -	if (!dev)
> -		return ERR_PTR(-ENOMEM);
> -
> -	if (unit >= 0) {
> -		sprintf(dev->name, "lt%d", unit);
> -		netdev_boot_setup_check(dev);
> -		irq = dev->irq;
> -		base_addr = dev->base_addr;
> -	} else {
> -		base_addr = dev->base_addr = io;
> -	}
> -
> -	if (base_addr > 0x1ff) {    /* Check a single specified location. */
> -		err = cops_probe1(dev, base_addr);
> -	} else if (base_addr != 0) { /* Don't probe at all. */
> -		err = -ENXIO;
> -	} else {
> -		/* FIXME  Does this really work for cards which generate irq?
> -		 * It's definitely N.G. for polled Tangent. sh
> -		 * Dayna cards don't autoprobe well at all, but if your card is
> -		 * at IRQ 5 & IO 0x240 we find it every time. ;) JS
> -		 */
> -		for (port = ports; *port && cops_probe1(dev, *port) < 0; port++)
> -			;
> -		if (!*port)
> -			err = -ENODEV;
> -	}
> -	if (err)
> -		goto out;
> -	err = register_netdev(dev);
> -	if (err)
> -		goto out1;
> -	return dev;
> -out1:
> -	cleanup_card(dev);
> -out:
> -	free_netdev(dev);
> -	return ERR_PTR(err);
> -}
> -
> -static const struct net_device_ops cops_netdev_ops = {
> -	.ndo_open               = cops_open,
> -        .ndo_stop               = cops_close,
> -	.ndo_start_xmit   	= cops_send_packet,
> -	.ndo_tx_timeout		= cops_timeout,
> -        .ndo_do_ioctl           = cops_ioctl,
> -	.ndo_set_rx_mode	= set_multicast_list,
> -};
> -
> -/*
> - *      This is the real probe routine. Linux has a history of friendly device
> - *      probes on the ISA bus. A good device probes avoids doing writes, and
> - *      verifies that the correct device exists and functions.
> - */
> -static int __init cops_probe1(struct net_device *dev, int ioaddr)
> -{
> -        struct cops_local *lp;
> -	static unsigned version_printed;
> -	int board = board_type;
> -	int retval;
> -	
> -        if(cops_debug && version_printed++ == 0)
> -		printk("%s", version);
> -
> -	/* Grab the region so no one else tries to probe our ioports. */
> -	if (!request_region(ioaddr, COPS_IO_EXTENT, dev->name))
> -		return -EBUSY;
> -
> -        /*
> -         * Since this board has jumpered interrupts, allocate the interrupt
> -         * vector now. There is no point in waiting since no other device
> -         * can use the interrupt, and this marks the irq as busy. Jumpered
> -         * interrupts are typically not reported by the boards, and we must
> -         * used AutoIRQ to find them.
> -	 */
> -	dev->irq = irq;
> -	switch (dev->irq)
> -	{
> -		case 0:
> -			/* COPS AutoIRQ routine */
> -			dev->irq = cops_irq(ioaddr, board);
> -			if (dev->irq)
> -				break;
> -			fallthrough;	/* Once no IRQ found on this port */
> -		case 1:
> -			retval = -EINVAL;
> -			goto err_out;
> -
> -		/* Fixup for users that don't know that IRQ 2 is really
> -		 * IRQ 9, or don't know which one to set.
> -		 */
> -		case 2:
> -			dev->irq = 9;
> -			break;
> -
> -		/* Polled operation requested. Although irq of zero passed as
> -		 * a parameter tells the init routines to probe, we'll
> -		 * overload it to denote polled operation at runtime.
> -		 */
> -		case 0xff:
> -			dev->irq = 0;
> -			break;
> -
> -		default:
> -			break;
> -	}
> -
> -	dev->base_addr = ioaddr;
> -
> -	/* Reserve any actual interrupt. */
> -	if (dev->irq) {
> -		retval = request_irq(dev->irq, cops_interrupt, 0, dev->name, dev);
> -		if (retval)
> -			goto err_out;
> -	}
> -
> -        lp = netdev_priv(dev);
> -        spin_lock_init(&lp->lock);
> -
> -	/* Copy local board variable to lp struct. */
> -	lp->board               = board;
> -
> -	dev->netdev_ops 	= &cops_netdev_ops;
> -	dev->watchdog_timeo	= HZ * 2;
> -
> -
> -	/* Tell the user where the card is and what mode we're in. */
> -	if(board==DAYNA)
> -		printk("%s: %s at %#3x, using IRQ %d, in Dayna mode.\n", 
> -			dev->name, cardname, ioaddr, dev->irq);
> -	if(board==TANGENT) {
> -		if(dev->irq)
> -			printk("%s: %s at %#3x, IRQ %d, in Tangent mode\n", 
> -				dev->name, cardname, ioaddr, dev->irq);
> -		else
> -			printk("%s: %s at %#3x, using polled IO, in Tangent mode.\n", 
> -				dev->name, cardname, ioaddr);
> -
> -	}
> -        return 0;
> -
> -err_out:
> -	release_region(ioaddr, COPS_IO_EXTENT);
> -	return retval;
> -}
> -
> -static int __init cops_irq (int ioaddr, int board)
> -{       /*
> -         * This does not use the IRQ to determine where the IRQ is. We just
> -         * assume that when we get a correct status response that it's the IRQ.
> -         * This really just verifies the IO port but since we only have access
> -         * to such a small number of IRQs (5, 4, 3) this is not bad.
> -         * This will probably not work for more than one card.
> -         */
> -        int irqaddr=0;
> -        int i, x, status;
> -
> -        if(board==DAYNA)
> -        {
> -                outb(0, ioaddr+DAYNA_RESET);
> -                inb(ioaddr+DAYNA_RESET);
> -                mdelay(333);
> -        }
> -        if(board==TANGENT)
> -        {
> -                inb(ioaddr);
> -                outb(0, ioaddr);
> -                outb(0, ioaddr+TANG_RESET);
> -        }
> -
> -        for(i=0; cops_irqlist[i] !=0; i++)
> -        {
> -                irqaddr = cops_irqlist[i];
> -                for(x = 0xFFFF; x>0; x --)    /* wait for response */
> -                {
> -                        if(board==DAYNA)
> -                        {
> -                                status = (inb(ioaddr+DAYNA_CARD_STATUS)&3);
> -                                if(status == 1)
> -                                        return irqaddr;
> -                        }
> -                        if(board==TANGENT)
> -                        {
> -                                if((inb(ioaddr+TANG_CARD_STATUS)& TANG_TX_READY) !=0)
> -                                        return irqaddr;
> -                        }
> -                }
> -        }
> -        return 0;       /* no IRQ found */
> -}
> -
> -/*
> - * Open/initialize the board. This is called (in the current kernel)
> - * sometime after booting when the 'ifconfig' program is run.
> - */
> -static int cops_open(struct net_device *dev)
> -{
> -    struct cops_local *lp = netdev_priv(dev);
> -
> -	if(dev->irq==0)
> -	{
> -		/*
> -		 * I don't know if the Dayna-style boards support polled 
> -		 * operation.  For now, only allow it for Tangent.
> -		 */
> -		if(lp->board==TANGENT)	/* Poll 20 times per second */
> -		{
> -		    cops_timer_dev = dev;
> -		    timer_setup(&cops_timer, cops_poll, 0);
> -		    cops_timer.expires 	= jiffies + HZ/20;
> -		    add_timer(&cops_timer);
> -		} 
> -		else 
> -		{
> -			printk(KERN_WARNING "%s: No irq line set\n", dev->name);
> -			return -EAGAIN;
> -		}
> -	}
> -
> -	cops_jumpstart(dev);	/* Start the card up. */
> -
> -	netif_start_queue(dev);
> -        return 0;
> -}
> -
> -/*
> - *	This allows for a dynamic start/restart of the entire card.
> - */
> -static int cops_jumpstart(struct net_device *dev)
> -{
> -	struct cops_local *lp = netdev_priv(dev);
> -
> -	/*
> -         *      Once the card has the firmware loaded and has acquired
> -         *      the nodeid, if it is reset it will lose it all.
> -         */
> -        cops_reset(dev,1);	/* Need to reset card before load firmware. */
> -        cops_load(dev);		/* Load the firmware. */
> -
> -	/*
> -	 *	If atalkd already gave us a nodeid we will use that
> -	 *	one again, else we wait for atalkd to give us a nodeid
> -	 *	in cops_ioctl. This may cause a problem if someone steals
> -	 *	our nodeid while we are resetting.
> -	 */	
> -	if(lp->nodeid == 1)
> -		cops_nodeid(dev,lp->node_acquire);
> -
> -	return 0;
> -}
> -
> -static void tangent_wait_reset(int ioaddr)
> -{
> -	int timeout=0;
> -
> -	while(timeout++ < 5 && (inb(ioaddr+TANG_CARD_STATUS)&TANG_TX_READY)==0)
> -		mdelay(1);   /* Wait 1 second */
> -}
> -
> -/*
> - *      Reset the LocalTalk board.
> - */
> -static void cops_reset(struct net_device *dev, int sleep)
> -{
> -        struct cops_local *lp = netdev_priv(dev);
> -        int ioaddr=dev->base_addr;
> -
> -        if(lp->board==TANGENT)
> -        {
> -                inb(ioaddr);		/* Clear request latch. */
> -                outb(0,ioaddr);		/* Clear the TANG_TX_READY flop. */
> -                outb(0, ioaddr+TANG_RESET);	/* Reset the adapter. */
> -
> -		tangent_wait_reset(ioaddr);
> -                outb(0, ioaddr+TANG_CLEAR_INT);
> -        }
> -        if(lp->board==DAYNA)
> -        {
> -                outb(0, ioaddr+DAYNA_RESET);	/* Assert the reset port */
> -                inb(ioaddr+DAYNA_RESET);	/* Clear the reset */
> -		if (sleep)
> -			msleep(333);
> -		else
> -			mdelay(333);
> -        }
> -
> -	netif_wake_queue(dev);
> -}
> -
> -static void cops_load (struct net_device *dev)
> -{
> -        struct ifreq ifr;
> -        struct ltfirmware *ltf= (struct ltfirmware *)&ifr.ifr_ifru;
> -        struct cops_local *lp = netdev_priv(dev);
> -        int ioaddr=dev->base_addr;
> -	int length, i = 0;
> -
> -        strcpy(ifr.ifr_name,"lt0");
> -
> -        /* Get card's firmware code and do some checks on it. */
> -#ifdef CONFIG_COPS_DAYNA        
> -        if(lp->board==DAYNA)
> -        {
> -                ltf->length=sizeof(ffdrv_code);
> -                ltf->data=ffdrv_code;
> -        }
> -        else
> -#endif        
> -#ifdef CONFIG_COPS_TANGENT
> -        if(lp->board==TANGENT)
> -        {
> -                ltf->length=sizeof(ltdrv_code);
> -                ltf->data=ltdrv_code;
> -        }
> -        else
> -#endif
> -	{
> -		printk(KERN_INFO "%s; unsupported board type.\n", dev->name);
> -		return;
> -	}
> -	
> -        /* Check to make sure firmware is correct length. */
> -        if(lp->board==DAYNA && ltf->length!=5983)
> -        {
> -                printk(KERN_WARNING "%s: Firmware is not length of FFDRV.BIN.\n", dev->name);
> -                return;
> -        }
> -        if(lp->board==TANGENT && ltf->length!=2501)
> -        {
> -                printk(KERN_WARNING "%s: Firmware is not length of DRVCODE.BIN.\n", dev->name);
> -                return;
> -        }
> -
> -        if(lp->board==DAYNA)
> -        {
> -                /*
> -                 *      We must wait for a status response
> -                 *      with the DAYNA board.
> -                 */
> -                while(++i<65536)
> -                {
> -                       if((inb(ioaddr+DAYNA_CARD_STATUS)&3)==1)
> -                                break;
> -                }
> -
> -                if(i==65536)
> -                        return;
> -        }
> -
> -        /*
> -         *      Upload the firmware and kick. Byte-by-byte works nicely here.
> -         */
> -	i=0;
> -        length = ltf->length;
> -        while(length--)
> -        {
> -                outb(ltf->data[i], ioaddr);
> -                i++;
> -        }
> -
> -	if(cops_debug > 1)
> -		printk("%s: Uploaded firmware - %d bytes of %d bytes.\n", 
> -			dev->name, i, ltf->length);
> -
> -        if(lp->board==DAYNA) 	/* Tell Dayna to run the firmware code. */
> -                outb(1, ioaddr+DAYNA_INT_CARD);
> -	else			/* Tell Tang to run the firmware code. */
> -		inb(ioaddr);
> -
> -        if(lp->board==TANGENT)
> -        {
> -                tangent_wait_reset(ioaddr);
> -                inb(ioaddr);	/* Clear initial ready signal. */
> -        }
> -}
> -
> -/*
> - * 	Get the LocalTalk Nodeid from the card. We can suggest
> - *	any nodeid 1-254. The card will try and get that exact
> - *	address else we can specify 0 as the nodeid and the card
> - *	will autoprobe for a nodeid.
> - */
> -static int cops_nodeid (struct net_device *dev, int nodeid)
> -{
> -	struct cops_local *lp = netdev_priv(dev);
> -	int ioaddr = dev->base_addr;
> -
> -	if(lp->board == DAYNA)
> -        {
> -		/* Empty any pending adapter responses. */
> -                while((inb(ioaddr+DAYNA_CARD_STATUS)&DAYNA_TX_READY)==0)
> -                {
> -			outb(0, ioaddr+COPS_CLEAR_INT);	/* Clear interrupts. */
> -			if((inb(ioaddr+DAYNA_CARD_STATUS)&0x03)==DAYNA_RX_REQUEST)
> -				cops_rx(dev);	/* Kick any packets waiting. */
> -			schedule();
> -                }
> -
> -                outb(2, ioaddr);       	/* Output command packet length as 2. */
> -                outb(0, ioaddr);
> -                outb(LAP_INIT, ioaddr);	/* Send LAP_INIT command byte. */
> -                outb(nodeid, ioaddr);  	/* Suggest node address. */
> -        }
> -
> -	if(lp->board == TANGENT)
> -        {
> -                /* Empty any pending adapter responses. */
> -                while(inb(ioaddr+TANG_CARD_STATUS)&TANG_RX_READY)
> -                {
> -			outb(0, ioaddr+COPS_CLEAR_INT);	/* Clear interrupt. */
> -			cops_rx(dev);          	/* Kick out packets waiting. */
> -			schedule();
> -                }
> -
> -		/* Not sure what Tangent does if nodeid picked is used. */
> -                if(nodeid == 0)	         		/* Seed. */
> -			nodeid = jiffies&0xFF;		/* Get a random try */
> -                outb(2, ioaddr);        		/* Command length LSB */
> -                outb(0, ioaddr);       			/* Command length MSB */
> -                outb(LAP_INIT, ioaddr); 		/* Send LAP_INIT byte */
> -                outb(nodeid, ioaddr); 		  	/* LAP address hint. */
> -                outb(0xFF, ioaddr);     		/* Int. level to use */
> -        }
> -
> -	lp->node_acquire=0;		/* Set nodeid holder to 0. */
> -        while(lp->node_acquire==0)	/* Get *True* nodeid finally. */
> -	{
> -		outb(0, ioaddr+COPS_CLEAR_INT);	/* Clear any interrupt. */
> -
> -		if(lp->board == DAYNA)
> -		{
> -			if((inb(ioaddr+DAYNA_CARD_STATUS)&0x03)==DAYNA_RX_REQUEST)
> -				cops_rx(dev);	/* Grab the nodeid put in lp->node_acquire. */
> -		}
> -		if(lp->board == TANGENT)
> -		{	
> -			if(inb(ioaddr+TANG_CARD_STATUS)&TANG_RX_READY)
> -				cops_rx(dev);   /* Grab the nodeid put in lp->node_acquire. */
> -		}
> -		schedule();
> -	}
> -
> -	if(cops_debug > 1)
> -		printk(KERN_DEBUG "%s: Node ID %d has been acquired.\n", 
> -			dev->name, lp->node_acquire);
> -
> -	lp->nodeid=1;	/* Set got nodeid to 1. */
> -
> -        return 0;
> -}
> -
> -/*
> - *	Poll the Tangent type cards to see if we have work.
> - */
> - 
> -static void cops_poll(struct timer_list *unused)
> -{
> -	int ioaddr, status;
> -	int boguscount = 0;
> -	struct net_device *dev = cops_timer_dev;
> -
> -	del_timer(&cops_timer);
> -
> -	if(dev == NULL)
> -		return;	/* We've been downed */
> -
> -	ioaddr = dev->base_addr;
> -	do {
> -		status=inb(ioaddr+TANG_CARD_STATUS);
> -		if(status & TANG_RX_READY)
> -			cops_rx(dev);
> -		if(status & TANG_TX_READY)
> -			netif_wake_queue(dev);
> -		status = inb(ioaddr+TANG_CARD_STATUS);
> -	} while((++boguscount < 20) && (status&(TANG_RX_READY|TANG_TX_READY)));
> -
> -	/* poll 20 times per second */
> -	cops_timer.expires = jiffies + HZ/20;
> -	add_timer(&cops_timer);
> -}
> -
> -/*
> - *      The typical workload of the driver:
> - *      Handle the network interface interrupts.
> - */
> -static irqreturn_t cops_interrupt(int irq, void *dev_id)
> -{
> -        struct net_device *dev = dev_id;
> -        struct cops_local *lp;
> -        int ioaddr, status;
> -        int boguscount = 0;
> -
> -        ioaddr = dev->base_addr;
> -        lp = netdev_priv(dev);
> -
> -	if(lp->board==DAYNA)
> -	{
> -		do {
> -			outb(0, ioaddr + COPS_CLEAR_INT);
> -			status=inb(ioaddr+DAYNA_CARD_STATUS);
> -			if((status&0x03)==DAYNA_RX_REQUEST)
> -				cops_rx(dev);
> -			netif_wake_queue(dev);
> -		} while(++boguscount < 20);
> -	}
> -	else
> -	{
> -		do {
> -			status=inb(ioaddr+TANG_CARD_STATUS);
> -			if(status & TANG_RX_READY)
> -				cops_rx(dev);
> -			if(status & TANG_TX_READY)
> -				netif_wake_queue(dev);
> -			status=inb(ioaddr+TANG_CARD_STATUS);
> -		} while((++boguscount < 20) && (status&(TANG_RX_READY|TANG_TX_READY)));
> -	}
> -
> -        return IRQ_HANDLED;
> -}
> -
> -/*
> - *      We have a good packet(s), get it/them out of the buffers.
> - */
> -static void cops_rx(struct net_device *dev)
> -{
> -        int pkt_len = 0;
> -        int rsp_type = 0;
> -        struct sk_buff *skb = NULL;
> -        struct cops_local *lp = netdev_priv(dev);
> -        int ioaddr = dev->base_addr;
> -        int boguscount = 0;
> -        unsigned long flags;
> -
> -
> -	spin_lock_irqsave(&lp->lock, flags);
> -	
> -        if(lp->board==DAYNA)
> -        {
> -                outb(0, ioaddr);                /* Send out Zero length. */
> -                outb(0, ioaddr);
> -                outb(DATA_READ, ioaddr);        /* Send read command out. */
> -
> -                /* Wait for DMA to turn around. */
> -                while(++boguscount<1000000)
> -                {
> -			barrier();
> -                        if((inb(ioaddr+DAYNA_CARD_STATUS)&0x03)==DAYNA_RX_READY)
> -                                break;
> -                }
> -
> -                if(boguscount==1000000)
> -                {
> -                        printk(KERN_WARNING "%s: DMA timed out.\n",dev->name);
> -			spin_unlock_irqrestore(&lp->lock, flags);
> -                        return;
> -                }
> -        }
> -
> -        /* Get response length. */
> -	pkt_len = inb(ioaddr);
> -        pkt_len |= (inb(ioaddr) << 8);
> -        /* Input IO code. */
> -        rsp_type=inb(ioaddr);
> -
> -        /* Malloc up new buffer. */
> -        skb = dev_alloc_skb(pkt_len);
> -        if(skb == NULL)
> -        {
> -                printk(KERN_WARNING "%s: Memory squeeze, dropping packet.\n",
> -			dev->name);
> -                dev->stats.rx_dropped++;
> -                while(pkt_len--)        /* Discard packet */
> -                        inb(ioaddr);
> -                spin_unlock_irqrestore(&lp->lock, flags);
> -                return;
> -        }
> -        skb->dev = dev;
> -        skb_put(skb, pkt_len);
> -        skb->protocol = htons(ETH_P_LOCALTALK);
> -
> -        insb(ioaddr, skb->data, pkt_len);               /* Eat the Data */
> -
> -        if(lp->board==DAYNA)
> -                outb(1, ioaddr+DAYNA_INT_CARD);         /* Interrupt the card */
> -
> -        spin_unlock_irqrestore(&lp->lock, flags);  /* Restore interrupts. */
> -
> -        /* Check for bad response length */
> -        if(pkt_len < 0 || pkt_len > MAX_LLAP_SIZE)
> -        {
> -		printk(KERN_WARNING "%s: Bad packet length of %d bytes.\n", 
> -			dev->name, pkt_len);
> -                dev->stats.tx_errors++;
> -                dev_kfree_skb_any(skb);
> -                return;
> -        }
> -
> -        /* Set nodeid and then get out. */
> -        if(rsp_type == LAP_INIT_RSP)
> -        {	/* Nodeid taken from received packet. */
> -                lp->node_acquire = skb->data[0];
> -                dev_kfree_skb_any(skb);
> -                return;
> -        }
> -
> -        /* One last check to make sure we have a good packet. */
> -        if(rsp_type != LAP_RESPONSE)
> -        {
> -                printk(KERN_WARNING "%s: Bad packet type %d.\n", dev->name, rsp_type);
> -                dev->stats.tx_errors++;
> -                dev_kfree_skb_any(skb);
> -                return;
> -        }
> -
> -        skb_reset_mac_header(skb);    /* Point to entire packet. */
> -        skb_pull(skb,3);
> -        skb_reset_transport_header(skb);    /* Point to data (Skip header). */
> -
> -        /* Update the counters. */
> -        dev->stats.rx_packets++;
> -        dev->stats.rx_bytes += skb->len;
> -
> -        /* Send packet to a higher place. */
> -        netif_rx(skb);
> -}
> -
> -static void cops_timeout(struct net_device *dev, unsigned int txqueue)
> -{
> -        struct cops_local *lp = netdev_priv(dev);
> -        int ioaddr = dev->base_addr;
> -
> -	dev->stats.tx_errors++;
> -        if(lp->board==TANGENT)
> -        {
> -		if((inb(ioaddr+TANG_CARD_STATUS)&TANG_TX_READY)==0)
> -			printk(KERN_WARNING "%s: No TX complete interrupt.\n", dev->name);
> -	}
> -	printk(KERN_WARNING "%s: Transmit timed out.\n", dev->name);
> -	cops_jumpstart(dev);	/* Restart the card. */
> -	netif_trans_update(dev); /* prevent tx timeout */
> -	netif_wake_queue(dev);
> -}
> -
> -
> -/*
> - *	Make the card transmit a LocalTalk packet.
> - */
> -
> -static netdev_tx_t cops_send_packet(struct sk_buff *skb,
> -					  struct net_device *dev)
> -{
> -        struct cops_local *lp = netdev_priv(dev);
> -        int ioaddr = dev->base_addr;
> -        unsigned long flags;
> -
> -        /*
> -         * Block a timer-based transmit from overlapping. 
> -	 */
> -	 
> -	netif_stop_queue(dev);
> -
> -	spin_lock_irqsave(&lp->lock, flags);
> -	if(lp->board == DAYNA)	 /* Wait for adapter transmit buffer. */
> -		while((inb(ioaddr+DAYNA_CARD_STATUS)&DAYNA_TX_READY)==0)
> -			cpu_relax();
> -	if(lp->board == TANGENT) /* Wait for adapter transmit buffer. */
> -		while((inb(ioaddr+TANG_CARD_STATUS)&TANG_TX_READY)==0)
> -			cpu_relax();
> -
> -	/* Output IO length. */
> -	outb(skb->len, ioaddr);
> -	outb(skb->len >> 8, ioaddr);
> -
> -	/* Output IO code. */
> -	outb(LAP_WRITE, ioaddr);
> -
> -	if(lp->board == DAYNA)	/* Check the transmit buffer again. */
> -		while((inb(ioaddr+DAYNA_CARD_STATUS)&DAYNA_TX_READY)==0);
> -
> -	outsb(ioaddr, skb->data, skb->len);	/* Send out the data. */
> -
> -	if(lp->board==DAYNA)	/* Dayna requires you kick the card */
> -		outb(1, ioaddr+DAYNA_INT_CARD);
> -
> -	spin_unlock_irqrestore(&lp->lock, flags);	/* Restore interrupts. */
> -
> -	/* Done sending packet, update counters and cleanup. */
> -	dev->stats.tx_packets++;
> -	dev->stats.tx_bytes += skb->len;
> -	dev_kfree_skb (skb);
> -	return NETDEV_TX_OK;
> -}
> -
> -/*
> - *	Dummy function to keep the Appletalk layer happy.
> - */
> - 
> -static void set_multicast_list(struct net_device *dev)
> -{
> -        if(cops_debug >= 3)
> -		printk("%s: set_multicast_list executed\n", dev->name);
> -}
> -
> -/*
> - *      System ioctls for the COPS LocalTalk card.
> - */
> - 
> -static int cops_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> -{
> -        struct cops_local *lp = netdev_priv(dev);
> -        struct sockaddr_at *sa = (struct sockaddr_at *)&ifr->ifr_addr;
> -        struct atalk_addr *aa = &lp->node_addr;
> -
> -        switch(cmd)
> -        {
> -                case SIOCSIFADDR:
> -			/* Get and set the nodeid and network # atalkd wants. */
> -			cops_nodeid(dev, sa->sat_addr.s_node);
> -			aa->s_net               = sa->sat_addr.s_net;
> -                        aa->s_node              = lp->node_acquire;
> -
> -			/* Set broardcast address. */
> -                        dev->broadcast[0]       = 0xFF;
> -			
> -			/* Set hardware address. */
> -                        dev->addr_len           = 1;
> -			dev_addr_set(dev, &aa->s_node);
> -                        return 0;
> -
> -                case SIOCGIFADDR:
> -                        sa->sat_addr.s_net      = aa->s_net;
> -                        sa->sat_addr.s_node     = aa->s_node;
> -                        return 0;
> -
> -                default:
> -                        return -EOPNOTSUPP;
> -        }
> -}
> -
> -/*
> - *	The inverse routine to cops_open().
> - */
> - 
> -static int cops_close(struct net_device *dev)
> -{
> -	struct cops_local *lp = netdev_priv(dev);
> -
> -	/* If we were running polled, yank the timer.
> -	 */
> -	if(lp->board==TANGENT && dev->irq==0)
> -		del_timer(&cops_timer);
> -
> -	netif_stop_queue(dev);
> -        return 0;
> -}
> -
> -
> -#ifdef MODULE
> -static struct net_device *cops_dev;
> -
> -MODULE_LICENSE("GPL");
> -module_param_hw(io, int, ioport, 0);
> -module_param_hw(irq, int, irq, 0);
> -module_param_hw(board_type, int, other, 0);
> -
> -static int __init cops_module_init(void)
> -{
> -	if (io == 0)
> -		printk(KERN_WARNING "%s: You shouldn't autoprobe with insmod\n",
> -			cardname);
> -	cops_dev = cops_probe(-1);
> -	return PTR_ERR_OR_ZERO(cops_dev);
> -}
> -
> -static void __exit cops_module_exit(void)
> -{
> -	unregister_netdev(cops_dev);
> -	cleanup_card(cops_dev);
> -	free_netdev(cops_dev);
> -}
> -module_init(cops_module_init);
> -module_exit(cops_module_exit);
> -#endif /* MODULE */
> diff --git a/drivers/net/appletalk/cops.h b/drivers/net/appletalk/cops.h
> deleted file mode 100644
> index 7a0bfb351929..000000000000
> --- a/drivers/net/appletalk/cops.h
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*      cops.h: LocalTalk driver for Linux.
> - *
> - *      Authors:
> - *      - Jay Schulist <jschlst@samba.org>
> - */
> -
> -#ifndef __LINUX_COPSLTALK_H
> -#define __LINUX_COPSLTALK_H
> -
> -#ifdef __KERNEL__
> -
> -/* Max LLAP size we will accept. */
> -#define MAX_LLAP_SIZE		603
> -
> -/* Tangent */
> -#define TANG_CARD_STATUS        1
> -#define TANG_CLEAR_INT          1
> -#define TANG_RESET              3
> -
> -#define TANG_TX_READY           1
> -#define TANG_RX_READY           2
> -
> -/* Dayna */
> -#define DAYNA_CMD_DATA          0
> -#define DAYNA_CLEAR_INT         1
> -#define DAYNA_CARD_STATUS       2
> -#define DAYNA_INT_CARD          3
> -#define DAYNA_RESET             4
> -
> -#define DAYNA_RX_READY          0
> -#define DAYNA_TX_READY          1
> -#define DAYNA_RX_REQUEST        3
> -
> -/* Same on both card types */
> -#define COPS_CLEAR_INT  1
> -
> -/* LAP response codes received from the cards. */
> -#define LAP_INIT        1       /* Init cmd */
> -#define LAP_INIT_RSP    2       /* Init response */
> -#define LAP_WRITE       3       /* Write cmd */
> -#define DATA_READ       4       /* Data read */
> -#define LAP_RESPONSE    4       /* Received ALAP frame response */
> -#define LAP_GETSTAT     5       /* Get LAP and HW status */
> -#define LAP_RSPSTAT     6       /* Status response */
> -
> -#endif
> -
> -/*
> - *	Structure to hold the firmware information.
> - */
> -struct ltfirmware
> -{
> -        unsigned int length;
> -        const unsigned char *data;
> -};
> -
> -#define DAYNA 1
> -#define TANGENT 2
> -
> -#endif
> diff --git a/drivers/net/appletalk/cops_ffdrv.h b/drivers/net/appletalk/cops_ffdrv.h
> deleted file mode 100644
> index b02005087c1b..000000000000
> --- a/drivers/net/appletalk/cops_ffdrv.h
> +++ /dev/null
> @@ -1,532 +0,0 @@
> -
> -/*
> - *	The firmware this driver downloads into the Localtalk card is a
> - *	separate program and is not GPL'd source code, even though the Linux
> - *	side driver and the routine that loads this data into the card are.
> - *	
> - *	It is taken from the COPS SDK and is under the following license
> - *
> - *	This material is licensed to you strictly for use in conjunction with
> - *	the use of COPS LocalTalk adapters.
> - *	There is no charge for this SDK. And no waranty express or implied
> - *	about its fitness for any purpose. However, we will cheerefully
> - *	refund every penny you paid for this SDK...
> - *	Regards,
> - *
> - *	Thomas F. Divine
> - *	Chief Scientist
> - */
> -
> -
> -/*      cops_ffdrv.h: LocalTalk driver firmware dump for Linux.
> - *
> - *      Authors:
> - *      - Jay Schulist <jschlst@samba.org>
> - */
> -
> -
> -#ifdef CONFIG_COPS_DAYNA
> -
> -static const unsigned char ffdrv_code[] = {
> -	58,3,0,50,228,149,33,255,255,34,226,149,
> -	249,17,40,152,33,202,154,183,237,82,77,68,
> -	11,107,98,19,54,0,237,176,175,50,80,0,
> -	62,128,237,71,62,32,237,57,51,62,12,237,
> -	57,50,237,57,54,62,6,237,57,52,62,12,
> -	237,57,49,33,107,137,34,32,128,33,83,130,
> -	34,40,128,33,86,130,34,42,128,33,112,130,
> -	34,36,128,33,211,130,34,38,128,62,0,237,
> -	57,16,33,63,148,34,34,128,237,94,205,15,
> -	130,251,205,168,145,24,141,67,111,112,121,114,
> -	105,103,104,116,32,40,67,41,32,49,57,56,
> -	56,32,45,32,68,97,121,110,97,32,67,111,
> -	109,109,117,110,105,99,97,116,105,111,110,115,
> -	32,32,32,65,108,108,32,114,105,103,104,116,
> -	115,32,114,101,115,101,114,118,101,100,46,32,
> -	32,40,68,40,68,7,16,8,34,7,22,6,
> -	16,5,12,4,8,3,6,140,0,16,39,128,
> -	0,4,96,10,224,6,0,7,126,2,64,11,
> -	118,12,6,13,0,14,193,15,0,5,96,3,
> -	192,1,64,9,8,62,9,211,66,62,192,211,
> -	66,62,100,61,32,253,6,28,33,205,129,14,
> -	66,237,163,194,253,129,6,28,33,205,129,14,
> -	64,237,163,194,9,130,201,62,47,50,71,152,
> -	62,47,211,68,58,203,129,237,57,20,58,204,
> -	129,237,57,21,33,77,152,54,132,205,233,129,
> -	58,228,149,254,209,40,6,56,4,62,0,24,
> -	2,219,96,33,233,149,119,230,62,33,232,149,
> -	119,213,33,8,152,17,7,0,25,119,19,25,
> -	119,209,201,251,237,77,245,197,213,229,221,229,
> -	205,233,129,62,1,50,106,137,205,158,139,221,
> -	225,225,209,193,241,251,237,77,245,197,213,219,
> -	72,237,56,16,230,46,237,57,16,237,56,12,
> -	58,72,152,183,32,26,6,20,17,128,2,237,
> -	56,46,187,32,35,237,56,47,186,32,29,219,
> -	72,230,1,32,3,5,32,232,175,50,72,152,
> -	229,221,229,62,1,50,106,137,205,158,139,221,
> -	225,225,24,25,62,1,50,72,152,58,201,129,
> -	237,57,12,58,202,129,237,57,13,237,56,16,
> -	246,17,237,57,16,209,193,241,251,237,77,245,
> -	197,229,213,221,229,237,56,16,230,17,237,57,
> -	16,237,56,20,58,34,152,246,16,246,8,211,
> -	68,62,6,61,32,253,58,34,152,246,8,211,
> -	68,58,203,129,237,57,20,58,204,129,237,57,
> -	21,237,56,16,246,34,237,57,16,221,225,209,
> -	225,193,241,251,237,77,33,2,0,57,126,230,
> -	3,237,100,1,40,2,246,128,230,130,245,62,
> -	5,211,64,241,211,64,201,229,213,243,237,56,
> -	16,230,46,237,57,16,237,56,12,251,70,35,
> -	35,126,254,175,202,77,133,254,129,202,15,133,
> -	230,128,194,191,132,43,58,44,152,119,33,76,
> -	152,119,35,62,132,119,120,254,255,40,4,58,
> -	49,152,119,219,72,43,43,112,17,3,0,237,
> -	56,52,230,248,237,57,52,219,72,230,1,194,
> -	141,131,209,225,237,56,52,246,6,237,57,52,
> -	62,1,55,251,201,62,3,211,66,62,192,211,
> -	66,62,48,211,66,0,0,219,66,230,1,40,
> -	4,219,67,24,240,205,203,135,58,75,152,254,
> -	255,202,128,132,58,49,152,254,161,250,207,131,
> -	58,34,152,211,68,62,10,211,66,62,128,211,
> -	66,62,11,211,66,62,6,211,66,24,0,62,
> -	14,211,66,62,33,211,66,62,1,211,66,62,
> -	64,211,66,62,3,211,66,62,209,211,66,62,
> -	100,71,219,66,230,1,32,6,5,32,247,195,
> -	248,132,219,67,71,58,44,152,184,194,248,132,
> -	62,100,71,219,66,230,1,32,6,5,32,247,
> -	195,248,132,219,67,62,100,71,219,66,230,1,
> -	32,6,5,32,247,195,248,132,219,67,254,133,
> -	32,7,62,0,50,74,152,24,17,254,173,32,
> -	7,62,1,50,74,152,24,6,254,141,194,248,
> -	132,71,209,225,58,49,152,254,132,32,10,62,
> -	50,205,2,134,205,144,135,24,27,254,140,32,
> -	15,62,110,205,2,134,62,141,184,32,5,205,
> -	144,135,24,8,62,10,205,2,134,205,8,134,
> -	62,1,50,106,137,205,158,139,237,56,52,246,
> -	6,237,57,52,175,183,251,201,62,20,135,237,
> -	57,20,175,237,57,21,237,56,16,246,2,237,
> -	57,16,237,56,20,95,237,56,21,123,254,10,
> -	48,244,237,56,16,230,17,237,57,16,209,225,
> -	205,144,135,62,1,50,106,137,205,158,139,237,
> -	56,52,246,6,237,57,52,175,183,251,201,209,
> -	225,243,219,72,230,1,40,13,62,10,211,66,
> -	0,0,219,66,230,192,202,226,132,237,56,52,
> -	246,6,237,57,52,62,1,55,251,201,205,203,
> -	135,62,1,50,106,137,205,158,139,237,56,52,
> -	246,6,237,57,52,183,251,201,209,225,62,1,
> -	50,106,137,205,158,139,237,56,52,246,6,237,
> -	57,52,62,2,55,251,201,209,225,243,219,72,
> -	230,1,202,213,132,62,10,211,66,0,0,219,
> -	66,230,192,194,213,132,229,62,1,50,106,137,
> -	42,40,152,205,65,143,225,17,3,0,205,111,
> -	136,62,6,211,66,58,44,152,211,66,237,56,
> -	52,246,6,237,57,52,183,251,201,209,197,237,
> -	56,52,230,248,237,57,52,219,72,230,1,32,
> -	15,193,225,237,56,52,246,6,237,57,52,62,
> -	1,55,251,201,14,23,58,37,152,254,0,40,
> -	14,14,2,254,1,32,5,62,140,119,24,3,
> -	62,132,119,43,43,197,205,203,135,193,62,1,
> -	211,66,62,64,211,66,62,3,211,66,62,193,
> -	211,66,62,100,203,39,71,219,66,230,1,32,
> -	6,5,32,247,195,229,133,33,238,151,219,67,
> -	71,58,44,152,184,194,229,133,119,62,100,71,
> -	219,66,230,1,32,6,5,32,247,195,229,133,
> -	219,67,35,119,13,32,234,193,225,62,1,50,
> -	106,137,205,158,139,237,56,52,246,6,237,57,
> -	52,175,183,251,201,33,234,151,35,35,62,255,
> -	119,193,225,62,1,50,106,137,205,158,139,237,
> -	56,52,246,6,237,57,52,175,251,201,243,61,
> -	32,253,251,201,62,3,211,66,62,192,211,66,
> -	58,49,152,254,140,32,19,197,229,213,17,181,
> -	129,33,185,129,1,2,0,237,176,209,225,193,
> -	24,27,229,213,33,187,129,58,49,152,230,15,
> -	87,30,2,237,92,25,17,181,129,126,18,19,
> -	35,126,18,209,225,58,34,152,246,8,211,68,
> -	58,49,152,254,165,40,14,254,164,40,10,62,
> -	10,211,66,62,224,211,66,24,25,58,74,152,
> -	254,0,40,10,62,10,211,66,62,160,211,66,
> -	24,8,62,10,211,66,62,128,211,66,62,11,
> -	211,66,62,6,211,66,205,147,143,62,5,211,
> -	66,62,224,211,66,62,5,211,66,62,96,211,
> -	66,62,5,61,32,253,62,5,211,66,62,224,
> -	211,66,62,14,61,32,253,62,5,211,66,62,
> -	233,211,66,62,128,211,66,58,181,129,61,32,
> -	253,62,1,211,66,62,192,211,66,1,254,19,
> -	237,56,46,187,32,6,13,32,247,195,226,134,
> -	62,192,211,66,0,0,219,66,203,119,40,250,
> -	219,66,203,87,40,250,243,237,56,16,230,17,
> -	237,57,16,237,56,20,251,62,5,211,66,62,
> -	224,211,66,58,182,129,61,32,253,229,33,181,
> -	129,58,183,129,203,63,119,35,58,184,129,119,
> -	225,62,10,211,66,62,224,211,66,62,11,211,
> -	66,62,118,211,66,62,47,211,68,62,5,211,
> -	66,62,233,211,66,58,181,129,61,32,253,62,
> -	5,211,66,62,224,211,66,58,182,129,61,32,
> -	253,62,5,211,66,62,96,211,66,201,229,213,
> -	58,50,152,230,15,87,30,2,237,92,33,187,
> -	129,25,17,181,129,126,18,35,19,126,18,209,
> -	225,58,71,152,246,8,211,68,58,50,152,254,
> -	165,40,14,254,164,40,10,62,10,211,66,62,
> -	224,211,66,24,8,62,10,211,66,62,128,211,
> -	66,62,11,211,66,62,6,211,66,195,248,135,
> -	62,3,211,66,62,192,211,66,197,229,213,17,
> -	181,129,33,183,129,1,2,0,237,176,209,225,
> -	193,62,47,211,68,62,10,211,66,62,224,211,
> -	66,62,11,211,66,62,118,211,66,62,1,211,
> -	66,62,0,211,66,205,147,143,195,16,136,62,
> -	3,211,66,62,192,211,66,197,229,213,17,181,
> -	129,33,183,129,1,2,0,237,176,209,225,193,
> -	62,47,211,68,62,10,211,66,62,224,211,66,
> -	62,11,211,66,62,118,211,66,205,147,143,62,
> -	5,211,66,62,224,211,66,62,5,211,66,62,
> -	96,211,66,62,5,61,32,253,62,5,211,66,
> -	62,224,211,66,62,14,61,32,253,62,5,211,
> -	66,62,233,211,66,62,128,211,66,58,181,129,
> -	61,32,253,62,1,211,66,62,192,211,66,1,
> -	254,19,237,56,46,187,32,6,13,32,247,195,
> -	88,136,62,192,211,66,0,0,219,66,203,119,
> -	40,250,219,66,203,87,40,250,62,5,211,66,
> -	62,224,211,66,58,182,129,61,32,253,62,5,
> -	211,66,62,96,211,66,201,197,14,67,6,0,
> -	62,3,211,66,62,192,211,66,62,48,211,66,
> -	0,0,219,66,230,1,40,4,219,67,24,240,
> -	62,5,211,66,62,233,211,66,62,128,211,66,
> -	58,181,129,61,32,253,237,163,29,62,192,211,
> -	66,219,66,230,4,40,250,237,163,29,32,245,
> -	219,66,230,4,40,250,62,255,71,219,66,230,
> -	4,40,3,5,32,247,219,66,230,4,40,250,
> -	62,5,211,66,62,224,211,66,58,182,129,61,
> -	32,253,62,5,211,66,62,96,211,66,58,71,
> -	152,254,1,202,18,137,62,16,211,66,62,56,
> -	211,66,62,14,211,66,62,33,211,66,62,1,
> -	211,66,62,248,211,66,237,56,48,246,153,230,
> -	207,237,57,48,62,3,211,66,62,221,211,66,
> -	193,201,58,71,152,211,68,62,10,211,66,62,
> -	128,211,66,62,11,211,66,62,6,211,66,62,
> -	6,211,66,58,44,152,211,66,62,16,211,66,
> -	62,56,211,66,62,48,211,66,0,0,62,14,
> -	211,66,62,33,211,66,62,1,211,66,62,248,
> -	211,66,237,56,48,246,145,246,8,230,207,237,
> -	57,48,62,3,211,66,62,221,211,66,193,201,
> -	44,3,1,0,70,69,1,245,197,213,229,175,
> -	50,72,152,237,56,16,230,46,237,57,16,237,
> -	56,12,62,1,211,66,0,0,219,66,95,230,
> -	160,32,3,195,20,139,123,230,96,194,72,139,
> -	62,48,211,66,62,1,211,66,62,64,211,66,
> -	237,91,40,152,205,207,143,25,43,55,237,82,
> -	218,70,139,34,42,152,98,107,58,44,152,190,
> -	194,210,138,35,35,62,130,190,194,200,137,62,
> -	1,50,48,152,62,175,190,202,82,139,62,132,
> -	190,32,44,50,50,152,62,47,50,71,152,229,
> -	175,50,106,137,42,40,152,205,65,143,225,54,
> -	133,43,70,58,44,152,119,43,112,17,3,0,
> -	62,10,205,2,134,205,111,136,195,158,138,62,
> -	140,190,32,19,50,50,152,58,233,149,230,4,
> -	202,222,138,62,1,50,71,152,195,219,137,126,
> -	254,160,250,185,138,254,166,242,185,138,50,50,
> -	152,43,126,35,229,213,33,234,149,95,22,0,
> -	25,126,254,132,40,18,254,140,40,14,58,50,
> -	152,230,15,87,126,31,21,242,65,138,56,2,
> -	175,119,58,50,152,230,15,87,58,233,149,230,
> -	62,31,21,242,85,138,218,98,138,209,225,195,
> -	20,139,58,50,152,33,100,137,230,15,95,22,
> -	0,25,126,50,71,152,209,225,58,50,152,254,
> -	164,250,135,138,58,73,152,254,0,40,4,54,
> -	173,24,2,54,133,43,70,58,44,152,119,43,
> -	112,17,3,0,205,70,135,175,50,106,137,205,
> -	208,139,58,199,129,237,57,12,58,200,129,237,
> -	57,13,237,56,16,246,17,237,57,16,225,209,
> -	193,241,251,237,77,62,129,190,194,227,138,54,
> -	130,43,70,58,44,152,119,43,112,17,3,0,
> -	205,144,135,195,20,139,35,35,126,254,132,194,
> -	227,138,175,50,106,137,205,158,139,24,42,58,
> -	201,154,254,1,40,7,62,1,50,106,137,24,
> -	237,58,106,137,254,1,202,222,138,62,128,166,
> -	194,222,138,221,229,221,33,67,152,205,127,142,
> -	205,109,144,221,225,225,209,193,241,251,237,77,
> -	58,106,137,254,1,202,44,139,58,50,152,254,
> -	164,250,44,139,58,73,152,238,1,50,73,152,
> -	221,229,221,33,51,152,205,127,142,221,225,62,
> -	1,50,106,137,205,158,139,195,13,139,24,208,
> -	24,206,24,204,230,64,40,3,195,20,139,195,
> -	20,139,43,126,33,8,152,119,35,58,44,152,
> -	119,43,237,91,35,152,205,203,135,205,158,139,
> -	195,13,139,175,50,78,152,62,3,211,66,62,
> -	192,211,66,201,197,33,4,0,57,126,35,102,
> -	111,62,1,50,106,137,219,72,205,141,139,193,
> -	201,62,1,50,78,152,34,40,152,54,0,35,
> -	35,54,0,195,163,139,58,78,152,183,200,229,
> -	33,181,129,58,183,129,119,35,58,184,129,119,
> -	225,62,47,211,68,62,14,211,66,62,193,211,
> -	66,62,10,211,66,62,224,211,66,62,11,211,
> -	66,62,118,211,66,195,3,140,58,78,152,183,
> -	200,58,71,152,211,68,254,69,40,4,254,70,
> -	32,17,58,73,152,254,0,40,10,62,10,211,
> -	66,62,160,211,66,24,8,62,10,211,66,62,
> -	128,211,66,62,11,211,66,62,6,211,66,62,
> -	6,211,66,58,44,152,211,66,62,16,211,66,
> -	62,56,211,66,62,48,211,66,0,0,219,66,
> -	230,1,40,4,219,67,24,240,62,14,211,66,
> -	62,33,211,66,42,40,152,205,65,143,62,1,
> -	211,66,62,248,211,66,237,56,48,246,145,246,
> -	8,230,207,237,57,48,62,3,211,66,62,221,
> -	211,66,201,62,16,211,66,62,56,211,66,62,
> -	48,211,66,0,0,219,66,230,1,40,4,219,
> -	67,24,240,62,14,211,66,62,33,211,66,62,
> -	1,211,66,62,248,211,66,237,56,48,246,153,
> -	230,207,237,57,48,62,3,211,66,62,221,211,
> -	66,201,229,213,33,234,149,95,22,0,25,126,
> -	254,132,40,4,254,140,32,2,175,119,123,209,
> -	225,201,6,8,14,0,31,48,1,12,16,250,
> -	121,201,33,4,0,57,94,35,86,33,2,0,
> -	57,126,35,102,111,221,229,34,89,152,237,83,
> -	91,152,221,33,63,152,205,127,142,58,81,152,
> -	50,82,152,58,80,152,135,50,80,152,205,162,
> -	140,254,3,56,16,58,81,152,135,60,230,15,
> -	50,81,152,175,50,80,152,24,23,58,79,152,
> -	205,162,140,254,3,48,13,58,81,152,203,63,
> -	50,81,152,62,255,50,79,152,58,81,152,50,
> -	82,152,58,79,152,135,50,79,152,62,32,50,
> -	83,152,50,84,152,237,56,16,230,17,237,57,
> -	16,219,72,62,192,50,93,152,62,93,50,94,
> -	152,58,93,152,61,50,93,152,32,9,58,94,
> -	152,61,50,94,152,40,44,62,170,237,57,20,
> -	175,237,57,21,237,56,16,246,2,237,57,16,
> -	219,72,230,1,202,29,141,237,56,20,71,237,
> -	56,21,120,254,10,48,237,237,56,16,230,17,
> -	237,57,16,243,62,14,211,66,62,65,211,66,
> -	251,58,39,152,23,23,60,50,39,152,71,58,
> -	82,152,160,230,15,40,22,71,14,10,219,66,
> -	230,16,202,186,141,219,72,230,1,202,186,141,
> -	13,32,239,16,235,42,89,152,237,91,91,152,
> -	205,47,131,48,7,61,202,186,141,195,227,141,
> -	221,225,33,0,0,201,221,33,55,152,205,127,
> -	142,58,84,152,61,50,84,152,40,19,58,82,
> -	152,246,1,50,82,152,58,79,152,246,1,50,
> -	79,152,195,29,141,221,225,33,1,0,201,221,
> -	33,59,152,205,127,142,58,80,152,246,1,50,
> -	80,152,58,82,152,135,246,1,50,82,152,58,
> -	83,152,61,50,83,152,194,29,141,221,225,33,
> -	2,0,201,221,229,33,0,0,57,17,4,0,
> -	25,126,50,44,152,230,128,50,85,152,58,85,
> -	152,183,40,6,221,33,88,2,24,4,221,33,
> -	150,0,58,44,152,183,40,53,60,40,50,60,
> -	40,47,61,61,33,86,152,119,35,119,35,54,
> -	129,175,50,48,152,221,43,221,229,225,124,181,
> -	40,42,33,86,152,17,3,0,205,189,140,17,
> -	232,3,27,123,178,32,251,58,48,152,183,40,
> -	224,58,44,152,71,62,7,128,230,127,71,58,
> -	85,152,176,50,44,152,24,162,221,225,201,183,
> -	221,52,0,192,221,52,1,192,221,52,2,192,
> -	221,52,3,192,55,201,245,62,1,211,100,241,
> -	201,245,62,1,211,96,241,201,33,2,0,57,
> -	126,35,102,111,237,56,48,230,175,237,57,48,
> -	62,48,237,57,49,125,237,57,32,124,237,57,
> -	33,62,0,237,57,34,62,88,237,57,35,62,
> -	0,237,57,36,237,57,37,33,128,2,125,237,
> -	57,38,124,237,57,39,237,56,48,246,97,230,
> -	207,237,57,48,62,0,237,57,0,62,0,211,
> -	96,211,100,201,33,2,0,57,126,35,102,111,
> -	237,56,48,230,175,237,57,48,62,12,237,57,
> -	49,62,76,237,57,32,62,0,237,57,33,237,
> -	57,34,125,237,57,35,124,237,57,36,62,0,
> -	237,57,37,33,128,2,125,237,57,38,124,237,
> -	57,39,237,56,48,246,97,230,207,237,57,48,
> -	62,1,211,96,201,33,2,0,57,126,35,102,
> -	111,229,237,56,48,230,87,237,57,48,125,237,
> -	57,40,124,237,57,41,62,0,237,57,42,62,
> -	67,237,57,43,62,0,237,57,44,58,106,137,
> -	254,1,32,5,33,6,0,24,3,33,128,2,
> -	125,237,57,46,124,237,57,47,237,56,50,230,
> -	252,246,2,237,57,50,225,201,33,4,0,57,
> -	94,35,86,33,2,0,57,126,35,102,111,237,
> -	56,48,230,87,237,57,48,125,237,57,40,124,
> -	237,57,41,62,0,237,57,42,62,67,237,57,
> -	43,62,0,237,57,44,123,237,57,46,122,237,
> -	57,47,237,56,50,230,244,246,0,237,57,50,
> -	237,56,48,246,145,230,207,237,57,48,201,213,
> -	237,56,46,95,237,56,47,87,237,56,46,111,
> -	237,56,47,103,183,237,82,32,235,33,128,2,
> -	183,237,82,209,201,213,237,56,38,95,237,56,
> -	39,87,237,56,38,111,237,56,39,103,183,237,
> -	82,32,235,33,128,2,183,237,82,209,201,245,
> -	197,1,52,0,237,120,230,253,237,121,193,241,
> -	201,245,197,1,52,0,237,120,246,2,237,121,
> -	193,241,201,33,2,0,57,126,35,102,111,126,
> -	35,110,103,201,33,0,0,34,102,152,34,96,
> -	152,34,98,152,33,202,154,34,104,152,237,91,
> -	104,152,42,226,149,183,237,82,17,0,255,25,
> -	34,100,152,203,124,40,6,33,0,125,34,100,
> -	152,42,104,152,35,35,35,229,205,120,139,193,
> -	201,205,186,149,229,42,40,152,35,35,35,229,
> -	205,39,144,193,124,230,3,103,221,117,254,221,
> -	116,255,237,91,42,152,35,35,35,183,237,82,
> -	32,12,17,5,0,42,42,152,205,171,149,242,
> -	169,144,42,40,152,229,205,120,139,193,195,198,
> -	149,237,91,42,152,42,98,152,25,34,98,152,
> -	19,19,19,42,102,152,25,34,102,152,237,91,
> -	100,152,33,158,253,25,237,91,102,152,205,171,
> -	149,242,214,144,33,0,0,34,102,152,62,1,
> -	50,95,152,205,225,144,195,198,149,58,95,152,
> -	183,200,237,91,96,152,42,102,152,205,171,149,
> -	242,5,145,237,91,102,152,33,98,2,25,237,
> -	91,96,152,205,171,149,250,37,145,237,91,96,
> -	152,42,102,152,183,237,82,32,7,42,98,152,
> -	125,180,40,13,237,91,102,152,42,96,152,205,
> -	171,149,242,58,145,237,91,104,152,42,102,152,
> -	25,35,35,35,229,205,120,139,193,175,50,95,
> -	152,201,195,107,139,205,206,149,250,255,243,205,
> -	225,144,251,58,230,149,183,194,198,149,17,1,
> -	0,42,98,152,205,171,149,250,198,149,62,1,
> -	50,230,149,237,91,96,152,42,104,152,25,221,
> -	117,252,221,116,253,237,91,104,152,42,96,152,
> -	25,35,35,35,221,117,254,221,116,255,35,35,
> -	35,229,205,39,144,124,230,3,103,35,35,35,
> -	221,117,250,221,116,251,235,221,110,252,221,102,
> -	253,115,35,114,35,54,4,62,1,211,100,211,
> -	84,195,198,149,33,0,0,34,102,152,34,96,
> -	152,34,98,152,33,202,154,34,104,152,237,91,
> -	104,152,42,226,149,183,237,82,17,0,255,25,
> -	34,100,152,33,109,152,54,0,33,107,152,229,
> -	205,240,142,193,62,47,50,34,152,62,132,50,
> -	49,152,205,241,145,205,61,145,58,39,152,60,
> -	50,39,152,24,241,205,206,149,251,255,33,109,
> -	152,126,183,202,198,149,110,221,117,251,33,109,
> -	152,54,0,221,126,251,254,1,40,28,254,3,
> -	40,101,254,4,202,190,147,254,5,202,147,147,
> -	254,8,40,87,33,107,152,229,205,240,142,195,
> -	198,149,58,201,154,183,32,21,33,111,152,126,
> -	50,229,149,205,52,144,33,110,152,110,38,0,
> -	229,205,11,142,193,237,91,96,152,42,104,152,
> -	25,221,117,254,221,116,255,35,35,54,2,17,
> -	2,0,43,43,115,35,114,58,44,152,35,35,
> -	119,58,228,149,35,119,62,1,211,100,211,84,
> -	62,1,50,201,154,24,169,205,153,142,58,231,
> -	149,183,40,250,175,50,231,149,33,110,152,126,
> -	254,255,40,91,58,233,149,230,63,183,40,83,
> -	94,22,0,33,234,149,25,126,183,40,13,33,
> -	110,152,94,33,234,150,25,126,254,3,32,36,
> -	205,81,148,125,180,33,110,152,94,22,0,40,
> -	17,33,234,149,25,54,0,33,107,152,229,205,
> -	240,142,193,195,198,149,33,234,150,25,54,0,
> -	33,110,152,94,22,0,33,234,149,25,126,50,
> -	49,152,254,132,32,37,62,47,50,34,152,42,
> -	107,152,229,33,110,152,229,205,174,140,193,193,
> -	125,180,33,110,152,94,22,0,33,234,150,202,
> -	117,147,25,52,195,120,147,58,49,152,254,140,
> -	32,7,62,1,50,34,152,24,210,62,32,50,
> -	106,152,24,19,58,49,152,95,58,106,152,163,
> -	183,58,106,152,32,11,203,63,50,106,152,58,
> -	106,152,183,32,231,254,2,40,51,254,4,40,
> -	38,254,8,40,26,254,16,40,13,254,32,32,
> -	158,62,165,50,49,152,62,69,24,190,62,164,
> -	50,49,152,62,70,24,181,62,163,50,49,152,
> -	175,24,173,62,162,50,49,152,62,1,24,164,
> -	62,161,50,49,152,62,3,24,155,25,54,0,
> -	221,126,251,254,8,40,7,58,230,149,183,202,
> -	32,146,33,107,152,229,205,240,142,193,211,84,
> -	195,198,149,237,91,96,152,42,104,152,25,221,
> -	117,254,221,116,255,35,35,54,6,17,2,0,
> -	43,43,115,35,114,58,228,149,35,35,119,58,
> -	233,149,35,119,205,146,142,195,32,146,237,91,
> -	96,152,42,104,152,25,229,205,160,142,193,58,
> -	231,149,183,40,250,175,50,231,149,243,237,91,
> -	96,152,42,104,152,25,221,117,254,221,116,255,
> -	78,35,70,221,113,252,221,112,253,89,80,42,
> -	98,152,183,237,82,34,98,152,203,124,40,19,
> -	33,0,0,34,98,152,34,102,152,34,96,152,
> -	62,1,50,95,152,24,40,221,94,252,221,86,
> -	253,19,19,19,42,96,152,25,34,96,152,237,
> -	91,100,152,33,158,253,25,237,91,96,152,205,
> -	171,149,242,55,148,33,0,0,34,96,152,175,
> -	50,230,149,251,195,32,146,245,62,1,50,231,
> -	149,62,16,237,57,0,211,80,241,251,237,77,
> -	201,205,186,149,229,229,33,0,0,34,37,152,
> -	33,110,152,126,50,234,151,58,44,152,33,235,
> -	151,119,221,54,253,0,221,54,254,0,195,230,
> -	148,33,236,151,54,175,33,3,0,229,33,234,
> -	151,229,205,174,140,193,193,33,236,151,126,254,
> -	255,40,74,33,245,151,110,221,117,255,33,249,
> -	151,126,221,166,255,221,119,255,33,253,151,126,
> -	221,166,255,221,119,255,58,232,149,95,221,126,
> -	255,163,221,119,255,183,40,15,230,191,33,110,
> -	152,94,22,0,33,234,149,25,119,24,12,33,
> -	110,152,94,22,0,33,234,149,25,54,132,33,
> -	0,0,195,198,149,221,110,253,221,102,254,35,
> -	221,117,253,221,116,254,17,32,0,221,110,253,
> -	221,102,254,205,171,149,250,117,148,58,233,149,
> -	203,87,40,84,33,1,0,34,37,152,221,54,
> -	253,0,221,54,254,0,24,53,33,236,151,54,
> -	175,33,3,0,229,33,234,151,229,205,174,140,
> -	193,193,33,236,151,126,254,255,40,14,33,110,
> -	152,94,22,0,33,234,149,25,54,140,24,159,
> -	221,110,253,221,102,254,35,221,117,253,221,116,
> -	254,17,32,0,221,110,253,221,102,254,205,171,
> -	149,250,12,149,33,2,0,34,37,152,221,54,
> -	253,0,221,54,254,0,24,54,33,236,151,54,
> -	175,33,3,0,229,33,234,151,229,205,174,140,
> -	193,193,33,236,151,126,254,255,40,15,33,110,
> -	152,94,22,0,33,234,149,25,54,132,195,211,
> -	148,221,110,253,221,102,254,35,221,117,253,221,
> -	116,254,17,32,0,221,110,253,221,102,254,205,
> -	171,149,250,96,149,33,1,0,195,198,149,124,
> -	170,250,179,149,237,82,201,124,230,128,237,82,
> -	60,201,225,253,229,221,229,221,33,0,0,221,
> -	57,233,221,249,221,225,253,225,201,233,225,253,
> -	229,221,229,221,33,0,0,221,57,94,35,86,
> -	35,235,57,249,235,233,0,0,0,0,0,0,
> -	62,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	175,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,133,1,0,0,0,63,
> -	255,255,255,255,0,0,0,63,0,0,0,0,
> -	0,0,0,0,0,0,0,24,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0
> -	} ;
> -
> -#endif
> diff --git a/drivers/net/appletalk/cops_ltdrv.h b/drivers/net/appletalk/cops_ltdrv.h
> deleted file mode 100644
> index c699b1ad31da..000000000000
> --- a/drivers/net/appletalk/cops_ltdrv.h
> +++ /dev/null
> @@ -1,241 +0,0 @@
> -/*
> - *	The firmware this driver downloads into the Localtalk card is a
> - *	separate program and is not GPL'd source code, even though the Linux
> - *	side driver and the routine that loads this data into the card are.
> - *	
> - *	It is taken from the COPS SDK and is under the following license
> - *
> - *	This material is licensed to you strictly for use in conjunction with
> - *	the use of COPS LocalTalk adapters.
> - *	There is no charge for this SDK. And no waranty express or implied
> - *	about its fitness for any purpose. However, we will cheerefully
> - *	refund every penny you paid for this SDK...
> - *	Regards,
> - *
> - *	Thomas F. Divine
> - *	Chief Scientist
> - */
> -
> -
> -/*      cops_ltdrv.h: LocalTalk driver firmware dump for Linux.
> - *
> - *      Authors:
> - *      - Jay Schulist <jschlst@samba.org>
> - */
> - 
> -
> -#ifdef CONFIG_COPS_TANGENT
> -
> -static const unsigned char ltdrv_code[] = {
> -	58,3,0,50,148,10,33,143,15,62,85,119,
> -	190,32,9,62,170,119,190,32,3,35,24,241,
> -	34,146,10,249,17,150,10,33,143,15,183,237,
> -	82,77,68,11,107,98,19,54,0,237,176,62,
> -	16,237,57,51,62,0,237,57,50,237,57,54,
> -	62,12,237,57,49,62,195,33,39,2,50,56,
> -	0,34,57,0,237,86,205,30,2,251,205,60,
> -	10,24,169,67,111,112,121,114,105,103,104,116,
> -	32,40,99,41,32,49,57,56,56,45,49,57,
> -	57,50,44,32,80,114,105,110,116,105,110,103,
> -	32,67,111,109,109,117,110,105,99,97,116,105,
> -	111,110,115,32,65,115,115,111,99,105,97,116,
> -	101,115,44,32,73,110,99,46,65,108,108,32,
> -	114,105,103,104,116,115,32,114,101,115,101,114,
> -	118,101,100,46,32,32,4,4,22,40,255,60,
> -	4,96,10,224,6,0,7,126,2,64,11,246,
> -	12,6,13,0,14,193,15,0,5,96,3,192,
> -	1,0,9,8,62,3,211,82,62,192,211,82,
> -	201,62,3,211,82,62,213,211,82,201,62,5,
> -	211,82,62,224,211,82,201,62,5,211,82,62,
> -	224,211,82,201,62,5,211,82,62,96,211,82,
> -	201,6,28,33,180,1,14,82,237,163,194,4,
> -	2,33,39,2,34,64,0,58,3,0,230,1,
> -	192,62,11,237,121,62,118,237,121,201,33,182,
> -	10,54,132,205,253,1,201,245,197,213,229,42,
> -	150,10,14,83,17,98,2,67,20,237,162,58,
> -	179,1,95,219,82,230,1,32,6,29,32,247,
> -	195,17,3,62,1,211,82,219,82,95,230,160,
> -	32,10,237,162,32,225,21,32,222,195,15,3,
> -	237,162,123,230,96,194,21,3,62,48,211,82,
> -	62,1,211,82,175,211,82,237,91,150,10,43,
> -	55,237,82,218,19,3,34,152,10,98,107,58,
> -	154,10,190,32,81,62,1,50,158,10,35,35,
> -	62,132,190,32,44,54,133,43,70,58,154,10,
> -	119,43,112,17,3,0,205,137,3,62,16,211,
> -	82,62,56,211,82,205,217,1,42,150,10,14,
> -	83,17,98,2,67,20,58,178,1,95,195,59,
> -	2,62,129,190,194,227,2,54,130,43,70,58,
> -	154,10,119,43,112,17,3,0,205,137,3,195,
> -	254,2,35,35,126,254,132,194,227,2,205,61,
> -	3,24,20,62,128,166,194,222,2,221,229,221,
> -	33,175,10,205,93,6,205,144,7,221,225,225,
> -	209,193,241,251,237,77,221,229,221,33,159,10,
> -	205,93,6,221,225,205,61,3,195,247,2,24,
> -	237,24,235,24,233,230,64,40,2,24,227,24,
> -	225,175,50,179,10,205,208,1,201,197,33,4,
> -	0,57,126,35,102,111,205,51,3,193,201,62,
> -	1,50,179,10,34,150,10,54,0,58,179,10,
> -	183,200,62,14,211,82,62,193,211,82,62,10,
> -	211,82,62,224,211,82,62,6,211,82,58,154,
> -	10,211,82,62,16,211,82,62,56,211,82,62,
> -	48,211,82,219,82,230,1,40,4,219,83,24,
> -	242,62,14,211,82,62,33,211,82,62,1,211,
> -	82,62,9,211,82,62,32,211,82,205,217,1,
> -	201,14,83,205,208,1,24,23,14,83,205,208,
> -	1,205,226,1,58,174,1,61,32,253,205,244,
> -	1,58,174,1,61,32,253,205,226,1,58,175,
> -	1,61,32,253,62,5,211,82,62,233,211,82,
> -	62,128,211,82,58,176,1,61,32,253,237,163,
> -	27,62,192,211,82,219,82,230,4,40,250,237,
> -	163,27,122,179,32,243,219,82,230,4,40,250,
> -	58,178,1,71,219,82,230,4,40,3,5,32,
> -	247,219,82,230,4,40,250,205,235,1,58,177,
> -	1,61,32,253,205,244,1,201,229,213,35,35,
> -	126,230,128,194,145,4,43,58,154,10,119,43,
> -	70,33,181,10,119,43,112,17,3,0,243,62,
> -	10,211,82,219,82,230,128,202,41,4,209,225,
> -	62,1,55,251,201,205,144,3,58,180,10,254,
> -	255,202,127,4,205,217,1,58,178,1,71,219,
> -	82,230,1,32,6,5,32,247,195,173,4,219,
> -	83,71,58,154,10,184,194,173,4,58,178,1,
> -	71,219,82,230,1,32,6,5,32,247,195,173,
> -	4,219,83,58,178,1,71,219,82,230,1,32,
> -	6,5,32,247,195,173,4,219,83,254,133,194,
> -	173,4,58,179,1,24,4,58,179,1,135,61,
> -	32,253,209,225,205,137,3,205,61,3,183,251,
> -	201,209,225,243,62,10,211,82,219,82,230,128,
> -	202,164,4,62,1,55,251,201,205,144,3,205,
> -	61,3,183,251,201,209,225,62,2,55,251,201,
> -	243,62,14,211,82,62,33,211,82,251,201,33,
> -	4,0,57,94,35,86,33,2,0,57,126,35,
> -	102,111,221,229,34,193,10,237,83,195,10,221,
> -	33,171,10,205,93,6,58,185,10,50,186,10,
> -	58,184,10,135,50,184,10,205,112,6,254,3,
> -	56,16,58,185,10,135,60,230,15,50,185,10,
> -	175,50,184,10,24,23,58,183,10,205,112,6,
> -	254,3,48,13,58,185,10,203,63,50,185,10,
> -	62,255,50,183,10,58,185,10,50,186,10,58,
> -	183,10,135,50,183,10,62,32,50,187,10,50,
> -	188,10,6,255,219,82,230,16,32,3,5,32,
> -	247,205,180,4,6,40,219,82,230,16,40,3,
> -	5,32,247,62,10,211,82,219,82,230,128,194,
> -	46,5,219,82,230,16,40,214,237,95,71,58,
> -	186,10,160,230,15,40,32,71,14,10,62,10,
> -	211,82,219,82,230,128,202,119,5,205,180,4,
> -	195,156,5,219,82,230,16,202,156,5,13,32,
> -	229,16,225,42,193,10,237,91,195,10,205,252,
> -	3,48,7,61,202,156,5,195,197,5,221,225,
> -	33,0,0,201,221,33,163,10,205,93,6,58,
> -	188,10,61,50,188,10,40,19,58,186,10,246,
> -	1,50,186,10,58,183,10,246,1,50,183,10,
> -	195,46,5,221,225,33,1,0,201,221,33,167,
> -	10,205,93,6,58,184,10,246,1,50,184,10,
> -	58,186,10,135,246,1,50,186,10,58,187,10,
> -	61,50,187,10,194,46,5,221,225,33,2,0,
> -	201,221,229,33,0,0,57,17,4,0,25,126,
> -	50,154,10,230,128,50,189,10,58,189,10,183,
> -	40,6,221,33,88,2,24,4,221,33,150,0,
> -	58,154,10,183,40,49,60,40,46,61,33,190,
> -	10,119,35,119,35,54,129,175,50,158,10,221,
> -	43,221,229,225,124,181,40,42,33,190,10,17,
> -	3,0,205,206,4,17,232,3,27,123,178,32,
> -	251,58,158,10,183,40,224,58,154,10,71,62,
> -	7,128,230,127,71,58,189,10,176,50,154,10,
> -	24,166,221,225,201,183,221,52,0,192,221,52,
> -	1,192,221,52,2,192,221,52,3,192,55,201,
> -	6,8,14,0,31,48,1,12,16,250,121,201,
> -	33,2,0,57,94,35,86,35,78,35,70,35,
> -	126,35,102,105,79,120,68,103,237,176,201,33,
> -	2,0,57,126,35,102,111,62,17,237,57,48,
> -	125,237,57,40,124,237,57,41,62,0,237,57,
> -	42,62,64,237,57,43,62,0,237,57,44,33,
> -	128,2,125,237,57,46,124,237,57,47,62,145,
> -	237,57,48,211,68,58,149,10,211,66,201,33,
> -	2,0,57,126,35,102,111,62,33,237,57,48,
> -	62,64,237,57,32,62,0,237,57,33,237,57,
> -	34,125,237,57,35,124,237,57,36,62,0,237,
> -	57,37,33,128,2,125,237,57,38,124,237,57,
> -	39,62,97,237,57,48,211,67,58,149,10,211,
> -	66,201,237,56,46,95,237,56,47,87,237,56,
> -	46,111,237,56,47,103,183,237,82,32,235,33,
> -	128,2,183,237,82,201,237,56,38,95,237,56,
> -	39,87,237,56,38,111,237,56,39,103,183,237,
> -	82,32,235,33,128,2,183,237,82,201,205,106,
> -	10,221,110,6,221,102,7,126,35,110,103,195,
> -	118,10,205,106,10,33,0,0,34,205,10,34,
> -	198,10,34,200,10,33,143,15,34,207,10,237,
> -	91,207,10,42,146,10,183,237,82,17,0,255,
> -	25,34,203,10,203,124,40,6,33,0,125,34,
> -	203,10,42,207,10,229,205,37,3,195,118,10,
> -	205,106,10,229,42,150,10,35,35,35,229,205,
> -	70,7,193,124,230,3,103,221,117,254,221,116,
> -	255,237,91,152,10,35,35,35,183,237,82,32,
> -	12,17,5,0,42,152,10,205,91,10,242,203,
> -	7,42,150,10,229,205,37,3,195,118,10,237,
> -	91,152,10,42,200,10,25,34,200,10,42,205,
> -	10,25,34,205,10,237,91,203,10,33,158,253,
> -	25,237,91,205,10,205,91,10,242,245,7,33,
> -	0,0,34,205,10,62,1,50,197,10,205,5,
> -	8,33,0,0,57,249,195,118,10,205,106,10,
> -	58,197,10,183,202,118,10,237,91,198,10,42,
> -	205,10,205,91,10,242,46,8,237,91,205,10,
> -	33,98,2,25,237,91,198,10,205,91,10,250,
> -	78,8,237,91,198,10,42,205,10,183,237,82,
> -	32,7,42,200,10,125,180,40,13,237,91,205,
> -	10,42,198,10,205,91,10,242,97,8,237,91,
> -	207,10,42,205,10,25,229,205,37,3,175,50,
> -	197,10,195,118,10,205,29,3,33,0,0,57,
> -	249,195,118,10,205,106,10,58,202,10,183,40,
> -	22,205,14,7,237,91,209,10,19,19,19,205,
> -	91,10,242,139,8,33,1,0,195,118,10,33,
> -	0,0,195,118,10,205,126,10,252,255,205,108,
> -	8,125,180,194,118,10,237,91,200,10,33,0,
> -	0,205,91,10,242,118,10,237,91,207,10,42,
> -	198,10,25,221,117,254,221,116,255,35,35,35,
> -	229,205,70,7,193,124,230,3,103,35,35,35,
> -	221,117,252,221,116,253,229,221,110,254,221,102,
> -	255,229,33,212,10,229,205,124,6,193,193,221,
> -	110,252,221,102,253,34,209,10,33,211,10,54,
> -	4,33,209,10,227,205,147,6,193,62,1,50,
> -	202,10,243,221,94,252,221,86,253,42,200,10,
> -	183,237,82,34,200,10,203,124,40,17,33,0,
> -	0,34,200,10,34,205,10,34,198,10,50,197,
> -	10,24,37,221,94,252,221,86,253,42,198,10,
> -	25,34,198,10,237,91,203,10,33,158,253,25,
> -	237,91,198,10,205,91,10,242,68,9,33,0,
> -	0,34,198,10,205,5,8,33,0,0,57,249,
> -	251,195,118,10,205,106,10,33,49,13,126,183,
> -	40,16,205,42,7,237,91,47,13,19,19,19,
> -	205,91,10,242,117,9,58,142,15,198,1,50,
> -	142,15,195,118,10,33,49,13,126,254,1,40,
> -	25,254,3,202,7,10,254,5,202,21,10,33,
> -	49,13,54,0,33,47,13,229,205,207,6,195,
> -	118,10,58,141,15,183,32,72,33,51,13,126,
> -	50,149,10,205,86,7,33,50,13,126,230,127,
> -	183,32,40,58,142,15,230,127,50,142,15,183,
> -	32,5,198,1,50,142,15,33,50,13,126,111,
> -	23,159,103,203,125,58,142,15,40,5,198,128,
> -	50,142,15,33,50,13,119,33,50,13,126,111,
> -	23,159,103,229,205,237,5,193,33,211,10,54,
> -	2,33,2,0,34,209,10,58,154,10,33,212,
> -	10,119,58,148,10,33,213,10,119,33,209,10,
> -	229,205,147,6,193,24,128,42,47,13,229,33,
> -	50,13,229,205,191,4,193,24,239,33,211,10,
> -	54,6,33,3,0,34,209,10,58,154,10,33,
> -	212,10,119,58,148,10,33,213,10,119,33,214,
> -	10,54,5,33,209,10,229,205,147,6,24,200,
> -	205,106,10,33,49,13,54,0,33,47,13,229,
> -	205,207,6,33,209,10,227,205,147,6,193,205,
> -	80,9,205,145,8,24,248,124,170,250,99,10,
> -	237,82,201,124,230,128,237,82,60,201,225,253,
> -	229,221,229,221,33,0,0,221,57,233,221,249,
> -	221,225,253,225,201,233,225,253,229,221,229,221,
> -	33,0,0,221,57,94,35,86,35,235,57,249,
> -	235,233,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0,0,0,0,0,0,0,0,
> -	0,0,0,0,0
> -	} ;
> -
> -#endif
> diff --git a/include/net/Space.h b/include/net/Space.h
> index c29f3d51c078..ef42629f4258 100644
> --- a/include/net/Space.h
> +++ b/include/net/Space.h
> @@ -10,4 +10,3 @@ struct net_device *smc_init(int unit);
>  struct net_device *cs89x0_probe(int unit);
>  struct net_device *tc515_probe(int unit);
>  struct net_device *lance_probe(int unit);
> -struct net_device *cops_probe(int unit);

-- 
Vitaly

