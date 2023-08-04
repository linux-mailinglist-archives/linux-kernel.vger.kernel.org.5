Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAECC770B2D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjHDVml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjHDVmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:42:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A21E2;
        Fri,  4 Aug 2023 14:42:37 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686ed1d2594so2329700b3a.2;
        Fri, 04 Aug 2023 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691185357; x=1691790157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0/6CvPNm9CobAsm1AmWHbP2FlhRlN8WyLMgOhvLfhE=;
        b=e7ylBeA1oNDzq9TQgXgvQVB7VwbV9ZJWVsuMCB0ECl4ULDQ8RJiIBasRYKrXkKwcVL
         Wb6pCpWGSSTMhOPZZrVf+QSiIzb6Hf+XnsC11rWEWc51jCIHqzUzmNyHgXONx4gucjRH
         PD1iH8ykjscedvM077r3VRlsRtkjkqireBkhFxypzDvH2lZrEDVCjTdlsftTCrH/5MU3
         5MOTNR6dX3sVEOYsvF5oTcUewK0Egw6Nm7bJa4EDPwacNNr4e/PinTq6qsfy/w3vG0b2
         GbQXPz8DYX/tf5pAaGft+zjNdEs5Chqa+YrSO2EvjKOG8mDmuK+vMWOnmZ0aFuh2nKNF
         g7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691185357; x=1691790157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0/6CvPNm9CobAsm1AmWHbP2FlhRlN8WyLMgOhvLfhE=;
        b=bEU3iFygJUrkO1Bzjs2es7kfnBS/PhhLj3kzWR9/MdyJJ4OZoJvXJQY+wJcx4lS3G0
         gn9uZ/63QZsBxX5sZ7iGZ5/W0JH+D3NQ5UWYGpxV/KqebJevMwXwhrRR6m/3EVzBPgxX
         jg+FNKttNBaHFXrS2ku5GI8hxYkNOrw1VVvKIBwZ8EbUgDwiXovNOdkYnGeU0gm8crip
         xE7/xQGFlgDHPmyGTmJCGMDM2AHv9JHFotFsM6jAbODxA2fEMbkg5K1CxIWbGVj3ZpA1
         J479VSDaKGwsX1bHB8SNOwphgC6aClWnlRyUdv3rYUyEFDHIz4UKzmqH+YbINh9Bzz9L
         d3lw==
X-Gm-Message-State: AOJu0Yzg8iFHiqsrVrGU2carF1WcMDsE+/2Iz/s2+hhvk2ns2uTgreKZ
        2OuQNtSP8KSMwYW/Jw1KieI=
X-Google-Smtp-Source: AGHT+IFHMy1YZQk7j0jBDU1gArt3mHX46rj2mOwsCdItaasbOntEFYRy6OuuGLVbr1VtJk3J06FHTg==
X-Received: by 2002:a05:6a20:3d05:b0:132:a85f:b20c with SMTP id y5-20020a056a203d0500b00132a85fb20cmr3877479pzi.38.1691185356990;
        Fri, 04 Aug 2023 14:42:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s15-20020a63770f000000b0056456fff676sm1517273pgc.66.2023.08.04.14.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 14:42:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 4 Aug 2023 14:42:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/1] serial: core: Fix serial_base_match() after
 fixing controller port name
Message-ID: <0e1bc27d-dc84-473d-bfdf-db0743c5d64a@roeck-us.net>
References: <20230803071034.25571-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803071034.25571-1-tony@atomide.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:10:32AM +0300, Tony Lindgren wrote:
> While fixing DEVNAME to be more usable, I broke serial_base_match() as the
> ctrl and port prefix for device names seemed unnecessary.
> 
> The prefixes are still needed by serial_base_match() to probe the serial
> base controller port, and serial tx is now broken.
> 
> Let's fix the issue by checking against dev->type and drv->name instead
> of the prefixes that are no longer in the DEVNAME.
> 
> Fixes: 1ef2c2df1199 ("serial: core: Fix serial core controller port name to show controller id")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202308021529.35b3ad6c-oliver.sang@intel.com
> Signed-off-by: Tony Lindgren <tony@atomide.com>

With this patch applied, I see the following traceback in the pending-fixes
branch.

Bisect log attached as well. It actually points to commit d962de6ae51f
("serial: core: Fix serial core port id to not use port->line").
Bisect was on mips, but I also see problems on arm, ppc, and sparc.
sparc boot tests show the warning message and then stall until aborted
(which of course may be a different problem).

Guenter

---
printk: console [ttyS0] enabled
sysfs: cannot create duplicate filename '/devices/platform/serial8250.0/serial8250.0:0/serial8250.0:0.0'
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                 N 6.5.0-rc4-00350-g514250232787 #1
Stack : ffffffff 801adf80 80e74014 00000004 818e0000 00000000 821ab77c 92b3462d
        81140000 812b9940 81140000 821b0450 81202193 00000001 821ab720 821bc000
        00000000 00000000 8104844c 0000018e 00000001 0000018f 00000000 00000165
        648ce409 00000002 81140000 fff80000 81140000 8104844c 00000001 82a50548
        82a4ac04 00000000 821aba48 00000017 00000000 808398ec 00000000 812c0000
        ...
Call Trace:
[<8010a0e8>] show_stack+0x38/0x118
[<80d92a70>] dump_stack_lvl+0xa4/0xf0
[<803ace54>] sysfs_warn_dup+0x68/0x84
[<803acfd0>] sysfs_create_dir_ns+0xf8/0x110
[<80d4754c>] kobject_add_internal+0xc4/0x2fc
[<80d47db8>] kobject_add+0x64/0xe4
[<8084a824>] device_add+0x110/0x790
[<808357ac>] serial_base_port_add+0x100/0x134
[<80834aa4>] serial_core_register_port+0x88/0x6b0
[<808362bc>] serial8250_register_8250_port+0x398/0x5c8
[<808367fc>] serial8250_probe+0x150/0x1e4
[<80851894>] platform_probe+0x50/0xbc
[<8084eb0c>] really_probe+0xc0/0x378
[<8084efec>] driver_probe_device+0x48/0x110
[<8084f25c>] __driver_attach+0xb0/0x180
[<8084c5c8>] bus_for_each_dev+0x84/0xe8
[<8084ddb4>] bus_add_driver+0x174/0x1fc
[<80850030>] driver_register+0x88/0x15c
[<812425a4>] serial8250_init+0x170/0x1d0
[<80100c28>] do_one_initcall+0x88/0x330
[<81219134>] kernel_init_freeable+0x204/0x2b0
[<80d956a4>] kernel_init+0x24/0x118
[<80102fd8>] ret_from_kernel_thread+0x14/0x1c

kobject: kobject_add_internal failed for serial8250.0:0.0 with -EEXIST, don't try to register things with the same name in the same directory.
serial8250 serial8250.0: unable to register port at index 1 (IO2f8 MEM0 IRQ3): -17
sysfs: cannot create duplicate filename '/devices/platform/serial8250.0/serial8250.0:0/serial8250.0:0.0'
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                 N 6.5.0-rc4-00350-g514250232787 #1
Stack : ffffffff 801adf80 80e74014 00000004 818e0000 00000000 821ab77c 92b3462d
        81140000 812b9940 81140000 821b0450 81202193 00000001 821ab720 821bc000
        00000000 00000000 8104844c 000001b1 00000001 000001b2 00000000 00000165
        648ce409 00000002 81140000 fff80000 81140000 8104844c 00000001 82a50548
        82a48804 00000000 821aba48 00000017 00000000 808398ec 00000000 812c0000
        ...
Call Trace:
[<8010a0e8>] show_stack+0x38/0x118
[<80d92a70>] dump_stack_lvl+0xa4/0xf0
[<803ace54>] sysfs_warn_dup+0x68/0x84
[<803acfd0>] sysfs_create_dir_ns+0xf8/0x110
[<80d4754c>] kobject_add_internal+0xc4/0x2fc
[<80d47db8>] kobject_add+0x64/0xe4
[<8084a824>] device_add+0x110/0x790
[<808357ac>] serial_base_port_add+0x100/0x134
[<80834aa4>] serial_core_register_port+0x88/0x6b0
[<808362bc>] serial8250_register_8250_port+0x398/0x5c8
[<808367fc>] serial8250_probe+0x150/0x1e4
[<80851894>] platform_probe+0x50/0xbc
[<8084eb0c>] really_probe+0xc0/0x378
[<8084efec>] driver_probe_device+0x48/0x110
[<8084f25c>] __driver_attach+0xb0/0x180
[<8084c5c8>] bus_for_each_dev+0x84/0xe8
[<8084ddb4>] bus_add_driver+0x174/0x1fc
[<80850030>] driver_register+0x88/0x15c
[<812425a4>] serial8250_init+0x170/0x1d0
[<80100c28>] do_one_initcall+0x88/0x330
[<81219134>] kernel_init_freeable+0x204/0x2b0
[<80d956a4>] kernel_init+0x24/0x118
[<80102fd8>] ret_from_kernel_thread+0x14/0x1c

kobject: kobject_add_internal failed for serial8250.0:0.0 with -EEXIST, don't try to register things with the same name in the same directory.
serial8250 serial8250.0: unable to register port at index 2 (IO0 MEM1f000900 IRQ20): -17

---
# bad: [514250232787bc4c20714949414b314a161120b4] Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc
# good: [5d0c230f1de8c7515b6567d9afba1f196fb4e2f4] Linux 6.5-rc4
git bisect start 'HEAD' 'v6.5-rc4'
# good: [3678fcb6d3eed56ab276f8211a2fd0cae245ac81] Merge branch 'mm-hotfixes-unstable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good 3678fcb6d3eed56ab276f8211a2fd0cae245ac81
# bad: [7bbae783b7eea8c2b47ec201abd8fbab135c641c] Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
git bisect bad 7bbae783b7eea8c2b47ec201abd8fbab135c641c
# good: [3f649ff97541b87652c1c8fe4762dd63d59088d7] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
git bisect good 3f649ff97541b87652c1c8fe4762dd63d59088d7
# bad: [b0aa91d9eb582c1e1f773516945e125ba01c76bd] Merge branch 'fixes-togreg' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
git bisect bad b0aa91d9eb582c1e1f773516945e125ba01c76bd
# good: [8a4629055ef55177b5b63dab1ecce676bd8cccdd] iio: cros_ec: Fix the allocation size for cros_ec_command
git bisect good 8a4629055ef55177b5b63dab1ecce676bd8cccdd
# bad: [7d695d83767cdb4288b101affef6d1d1bcf44d31] serial: core: Fix serial_base_match() after fixing controller port name
git bisect bad 7d695d83767cdb4288b101affef6d1d1bcf44d31
# good: [83c35180abfdfb22f3d7703b0c85ad2d442ed2c5] serial: core: Controller id cannot be negative
git bisect good 83c35180abfdfb22f3d7703b0c85ad2d442ed2c5
# bad: [1ef2c2df11997b8135f34adcf2c200d3b4aacbe9] serial: core: Fix serial core controller port name to show controller id
git bisect bad 1ef2c2df11997b8135f34adcf2c200d3b4aacbe9
# bad: [d962de6ae51f9b76ad736220077cda83084090b1] serial: core: Fix serial core port id to not use port->line
git bisect bad d962de6ae51f9b76ad736220077cda83084090b1
# first bad commit: [d962de6ae51f9b76ad736220077cda83084090b1] serial: core: Fix serial core port id to not use port->line

