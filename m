Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E347997F0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 14:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbjIIMd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 08:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjIIMd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 08:33:27 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEBECD6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 05:33:23 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2128586433;
        Sat,  9 Sep 2023 14:33:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694262801;
        bh=FGJ+3GoBJjrtTqJFHFJ12q0FRofA5cXQDyydOvBNyO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MDTcfkRObBGeXLdQGT1lvvL5V366HVLH1RPZevF89/SRhxGDqQrLQ6qVzl1aSyJqs
         VSqTXfskgZhUgqlTZyngyHNv55pDAXByBfDp5jKoA47270k4WJFQHAB7tgqXFPoKE6
         9TtBNa75Xi9v/nR7KlW+pfEmp4dJag4B5NA4Raf/hiH+9EoixyzL4C04YUe5HeYM/m
         0OuBAABdgkEV9FlTCdDAdJyITbRc4JvDF0vE6VQdMdRDohzMotJgsC2zIHqqHqvPb1
         RS3KckYNdSU7GqLVMf8720TRs5Zn1sLdrvIiNbSFhI9eVOcvLmE5DRiIoUvKRn6eqx
         aKk3UA+Nj1BmQ==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 09 Sep 2023 09:33:21 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] ASoC: wm8960: Fix error handling in probe
In-Reply-To: <20230909120237.2646275-1-linux@roeck-us.net>
References: <20230909120237.2646275-1-linux@roeck-us.net>
Message-ID: <f25a7897ba298a2e0187df91d121ab28@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2023 09:02, Guenter Roeck wrote:
> Commit 422f10adc3eb ("ASoC: wm8960: Add support for the power 
> supplies")
> added regulator support to the wm8960 driver, but neglected to update
> error handling in the probe function. This results in warning 
> backtraces
> if the probe function fails.
> 
> WARNING: CPU: 0 PID: 1 at drivers/regulator/core.c:2396
> _regulator_put.part.0+0x1b4/0x1d8
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Tainted: G                 N
> 6.5.0-11075-g92901222f83d #1
> Hardware name: Freescale i.MX6 Ultralite (Device Tree)
>  unwind_backtrace from show_stack+0x10/0x14
>  show_stack from dump_stack_lvl+0x68/0x90
>  dump_stack_lvl from __warn+0x70/0x1a4
>  __warn from warn_slowpath_fmt+0xac/0x220
>  warn_slowpath_fmt from _regulator_put.part.0+0x1b4/0x1d8
>  _regulator_put.part.0 from regulator_bulk_free+0x44/0x64
>  regulator_bulk_free from release_nodes+0x50/0x7c
>  release_nodes from devres_release_group+0xbc/0x138
>  devres_release_group from i2c_device_probe+0x180/0x268
>  i2c_device_probe from really_probe+0xc4/0x2e0
>  really_probe from __driver_probe_device+0x84/0x1a0
>  __driver_probe_device from driver_probe_device+0x2c/0xc4
>  driver_probe_device from __driver_attach+0x94/0x144
>  __driver_attach from bus_for_each_dev+0x70/0xc4
>  bus_for_each_dev from bus_add_driver+0xc4/0x1cc
>  bus_add_driver from driver_register+0x7c/0x114
>  driver_register from i2c_register_driver+0x3c/0xac
>  i2c_register_driver from do_one_initcall+0x68/0x3b0
>  do_one_initcall from kernel_init_freeable+0x18c/0x240
>  kernel_init_freeable from kernel_init+0x14/0x144
>  kernel_init from ret_from_fork+0x14/0x24
> 
> Add the missing calls to regulator_bulk_disable().
> 
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Fixes: 422f10adc3eb ("ASoC: wm8960: Add support for the power 
> supplies")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks for the fix:

Reviewed-by: Fabio Estevam <festevam@denx.de>
