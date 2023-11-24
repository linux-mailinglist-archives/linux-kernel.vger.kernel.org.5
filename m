Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5FE7F853C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 21:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjKXU0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 15:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjKXU0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 15:26:16 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5913E170B;
        Fri, 24 Nov 2023 12:26:19 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id ACF4A20718;
        Fri, 24 Nov 2023 21:26:15 +0100 (CET)
Date:   Fri, 24 Nov 2023 21:26:11 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Sherry Sun <sherry.sun@nxp.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Marcel Ziswiler <marcel@ziswiler.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: btnxpuart: Fix btnxpuart_close
Message-ID: <ZWEG40nzRhm6oVEq@francesco-nb.int.toradex.com>
References: <20231018145540.34014-1-marcel@ziswiler.com>
 <20231018145540.34014-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018145540.34014-2-marcel@ziswiler.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On Wed, Oct 18, 2023 at 04:55:39PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Unfortunately, btnxpuart_close() may trigger a BUG: scheduling while
> atomic. Fix this by properly purging the transmit queue and freeing the
> receive skb.
> 
> Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> This is the kernel trace this commit fixes:
> [   29.270685] BUG: scheduling while atomic: kworker/u3:0/55/0x00000002

I just hit this bug with 6.7-rc2, I think it would be worth to
apply this fix.


[   70.443965] BUG: scheduling while atomic: kworker/u5:0/65/0x00000002
[   70.450649] Modules linked in: 8021q garp mrp stp llc usb_f_ncm u_ether spidev mwifiex_sdio mwifiex snd_soc_simple_card snd_soc_simple_card_utils crct10dif_ce cfg80211 k3_j72xx_bandgap rti_wdt rtc_ti_k3 btnxpuart bluetooth ecdh_generic ecc snd_soc_davinci_mcasp sa2ul sha256_generic rfkill snd_soc_ti_udma libsha256 snd_soc_ti_edma authenc tidss snd_soc_ti_sdma omap_mailbox drm_dma_helper ti_ads1015 industrialio_triggered_buffer lontium_lt8912b snd_soc_wm8904 kfifo_buf lm75 at24 tps65219_pwrbutton ina2xx m_can_platform rtc_ds1307 tc358768 m_can display_connector spi_omap2_mcspi pwm_tiehrpwm can_dev drm_kms_helper libcomposite fuse drm backlight ipv6
[   70.509384] CPU: 0 PID: 65 Comm: kworker/u5:0 Not tainted 6.7.0-rc2-00147-gf1a09972a45a #1
[   70.517747] Hardware name: Toradex Verdin AM62 WB on Dahlia Board (DT)
[   70.524334] Workqueue: hci0 hci_power_on [bluetooth]
[   70.529870] Call trace:
[   70.532349]  dump_backtrace+0x94/0xec
[   70.536103]  show_stack+0x18/0x24
[   70.539491]  dump_stack_lvl+0x48/0x60
[   70.543210]  dump_stack+0x18/0x24
[   70.546575]  __schedule_bug+0x50/0x68
[   70.550312]  __schedule+0x7c4/0xa64
[   70.553874]  schedule+0x34/0xa0
[   70.557083]  schedule_timeout+0x180/0x25c
[   70.561151]  wait_for_completion_timeout+0x80/0x15c
[   70.566101]  ti_sci_set_device_state+0x164/0x22c
[   70.570790]  ti_sci_cmd_get_device_exclusive+0x18/0x24
[   70.575991]  ti_sci_pd_power_on+0x28/0x48
[   70.580073]  _genpd_power_on+0x94/0x154
[   70.583964]  genpd_power_on.part.0+0xa4/0x174
[   70.588383]  genpd_runtime_resume+0x118/0x294
[   70.592800]  __rpm_callback+0x48/0x140
[   70.596616]  rpm_callback+0x6c/0x78
[   70.600165]  rpm_resume+0x3bc/0x59c
[   70.603714]  __pm_runtime_resume+0x4c/0x90
[   70.607870]  omap8250_set_mctrl+0x2c/0xc0
[   70.611954]  serial8250_set_mctrl.part.0+0x18/0x34
[   70.616801]  serial8250_set_mctrl+0x18/0x28
[   70.621038]  uart_update_mctrl+0x58/0x78
[   70.625024]  uart_dtr_rts+0x108/0x118
[   70.628750]  tty_port_shutdown+0x88/0xd8
[   70.632744]  tty_port_close+0x50/0xac
[   70.636472]  uart_close+0x28/0x80
[   70.639850]  ttyport_close+0x50/0x94
[   70.643500]  serdev_device_close+0x40/0x50
[   70.647664]  btnxpuart_close+0x24/0x84 [btnxpuart]
[   70.652553]  hci_dev_open_sync+0x3f8/0x9dc [bluetooth]
[   70.658144]  hci_dev_do_open+0x28/0x48 [bluetooth]
[   70.663377]  hci_power_on+0x4c/0x2ac [bluetooth]
[   70.668441]  process_scheduled_works+0x16c/0x28c
[   70.673135]  worker_thread+0x16c/0x2e0
[   70.676950]  kthread+0x11c/0x128
[   70.680247]  ret_from_fork+0x10/0x20


 
