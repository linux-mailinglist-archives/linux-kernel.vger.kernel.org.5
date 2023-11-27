Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FB37FAA2F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjK0TYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0TYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:24:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EA1D5F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:24:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D123CC433C7;
        Mon, 27 Nov 2023 19:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701113089;
        bh=2+2TugPLWUQIHnsjKYagWhkv02bQPz5PxpwH8diK5Oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xyWrciaE3hnyiIjCnXrZlpuCNDBktCnmiTiIts7Veh50v+oMWe9OSLoOY/HVhFyz+
         rZgVd617nuq97njElUCvjImmJ0YG0xGh5XXgylt54/kiEn3hFDzoTQsU8ocZkzQKyu
         njf9RwqsJrggPAy0IppZ85gk8P4Cxm/rJXE0Ye58=
Date:   Mon, 27 Nov 2023 19:24:46 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 1/3] Bluetooth: btnxpuart: fix recv_buf() return value
Message-ID: <2023112728-tractor-concept-fc39@gregkh>
References: <20231127191409.151254-1-francesco@dolcini.it>
 <20231127191409.151254-2-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127191409.151254-2-francesco@dolcini.it>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 08:14:06PM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Serdev recv_buf() callback is supposed to return the amount of bytes
> consumed, therefore an int in between 0 and count.
> 
> Do not return negative number in case of issue, just print an error and
> return count.  This fixes a WARN in ttyport_receive_buf().
> 
> [    9.962266] Bluetooth: hci0: Frame reassembly failed (-84)
> [    9.972939] ------------[ cut here ]------------
> [    9.977922] serial serial0: receive_buf returns -84 (count = 6)
> [    9.994857] WARNING: CPU: 0 PID: 37 at drivers/tty/serdev/serdev-ttyport.c:37 ttyport_receive_buf+0xd8/0xf8
> [   10.004840] Modules linked in: mwifiex_sdio(+) mwifiex snd_soc_simple_card crct10dif_ce cfg80211 snd_soc_simple_card_utils k3_j72xx_bandgap rti_wdt rtc_ti_k3 btnxpuart bluetooth sa2ul ecdh_generic ecc sha256_generic tidss rfkill libsha256 drm_dma_helper snd_soc_davinci_mcasp authenc omap_mailbox snd_soc_ti_udma snd_soc_ti_edma snd_soc_ti_sdma atmel_mxt_ts ina2xx snd_soc_nau8822 ti_sn65dsi83 tc358768 ti_ads1015 tps65219_pwrbutton at24 m_can_platform industrialio_triggered_buffer drm_kms_helper m_can kfifo_buf rtc_ds1307 lm75 pwm_tiehrpwm can_dev spi_omap2_mcspi panel_lvds pwm_bl libcomposite fuse drm backlight ipv6
> [   10.059984] CPU: 0 PID: 37 Comm: kworker/u4:2 Not tainted 6.7.0-rc2-00147-gf1a09972a45a #1
> [   10.071793] Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)
> [   10.082898] Workqueue: events_unbound flush_to_ldisc
> [   10.091345] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   10.101820] pc : ttyport_receive_buf+0xd8/0xf8
> [   10.109712] lr : ttyport_receive_buf+0xd8/0xf8
> [   10.117581] sp : ffff800082b9bd20
> [   10.124202] x29: ffff800082b9bd20 x28: ffff00000000ee05 x27: ffff0000002f21c0
> [   10.134735] x26: ffff000002931820 x25: 61c8864680b583eb x24: ffff0000002f21b8
> [   10.145209] x23: ffff00000026e740 x22: ffff0000002f21e0 x21: ffffffffffffffac
> [   10.155686] x20: ffff000000da5c00 x19: 0000000000000006 x18: 0000000000000000
> [   10.166178] x17: ffff7fffbe0e7000 x16: ffff800080000000 x15: 000039966db1c650
> [   10.176564] x14: 000000000000022c x13: 000000000000022c x12: 0000000000000000
> [   10.186979] x11: 000000000000000a x10: 0000000000000a60 x9 : ffff800082b9bb80
> [   10.197352] x8 : ffff00000026f200 x7 : ffff00003fd90080 x6 : 00000000000022e5
> [   10.207680] x5 : 00000000410fd030 x4 : 0000000000c0000e x3 : ffff7fffbe0e7000
> [   10.218051] x2 : 0000000000000002 x1 : 0000000000000000 x0 : 0000000000000000
> [   10.228393] Call trace:
> [   10.233989]  ttyport_receive_buf+0xd8/0xf8
> [   10.241224]  flush_to_ldisc+0xbc/0x1a4
> [   10.248117]  process_scheduled_works+0x16c/0x28c
> [   10.255851]  worker_thread+0x16c/0x2e0
> [   10.262673]  kthread+0x11c/0x128
> [   10.268953]  ret_from_fork+0x10/0x20
> [   10.275460] ---[ end trace 0000000000000000 ]---
> 
> Closes: https://lore.kernel.org/all/ZWEIhcUXfutb5SY6@francesco-nb.int.toradex.com/
> Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/bluetooth/btnxpuart.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
