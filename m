Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9E579DD3A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbjIMArD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 20:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjIMArB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:47:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1C54CF3;
        Tue, 12 Sep 2023 17:46:56 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38D0khalF3256447, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38D0khalF3256447
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 08:46:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 13 Sep 2023 08:46:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 13 Sep 2023 08:46:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Wed, 13 Sep 2023 08:46:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Zenm Chen <zenmchen@gmail.com>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH v2] wifi: rtl8xxxu: fix LED control code of RTL8192FU
Thread-Topic: [PATCH v2] wifi: rtl8xxxu: fix LED control code of RTL8192FU
Thread-Index: AQHZ5WwYvP5lze30skyDvzKTfg2eG7AX5lFQ
Date:   Wed, 13 Sep 2023 00:46:36 +0000
Message-ID: <1cf3a01b90e74a528c884246b9fbf531@realtek.com>
References: <20230912112709.22456-1-zenmchen@gmail.com>
In-Reply-To: <20230912112709.22456-1-zenmchen@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Zenm Chen <zenmchen@gmail.com>
> Sent: Tuesday, September 12, 2023 7:27 PM
> To: Jes.Sorensen@gmail.com
> Cc: kvalo@kernel.org; linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> rtl8821cerfe2@gmail.com; Ping-Ke Shih <pkshih@realtek.com>; Zenm Chen <zenmchen@gmail.com>
> Subject: [PATCH v2] wifi: rtl8xxxu: fix LED control code of RTL8192FU
> 
> Some of the RTL8192FU-based wifi adapters use the register "REG_LEDCFG1"
> to control the LED, and some of them use the register "REG_LEDCFG0"
> instead. Currently rtl8xxxu controls the LED via writing the values
> to the register "REG_LEDCFG1" only. This caused a few RTL8192FU-based wifi
> adapters's LED don't blink according to the network activity. This patch
> will make rtl8xxxu write the correct values to the both register
> "REG_LEDCFG0" and "REG_LEDCFG1" to fix this issue.
> 
> This was tested with these two wifi adapters:
> ASUS USB-N13 C1 (vid=0x0b05, pid=0x18f1, rfe_type=0x1)
> MERCURY MW310UH (vid=0x0bda, pid=0xf192, rfe_type=0x5)
> 
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> ---
> v2:
>  - Explain why to fix the issue in this way in the commit message.
>  - Split a long statement into short ones.
>  - Use some of the definitions suggested by Ping-Ke Shih.
> ---
>  .../realtek/rtl8xxxu/rtl8xxxu_8192f.c         | 26 ++++++++++++-------
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h |  3 +++
>  2 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
> index 28e93835e05a..779f93afc22b 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
> @@ -2014,26 +2014,34 @@ static int rtl8192fu_led_brightness_set(struct led_classdev *led_cdev,
>         struct rtl8xxxu_priv *priv = container_of(led_cdev,
>                                                   struct rtl8xxxu_priv,
>                                                   led_cdev);
> -       u16 ledcfg;
> +       u32 ledcfg;
> 
>         /* Values obtained by observing the USB traffic from the Windows driver. */
>         rtl8xxxu_write32(priv, REG_SW_GPIO_SHARE_CTRL_0, 0x20080);
>         rtl8xxxu_write32(priv, REG_SW_GPIO_SHARE_CTRL_1, 0x1b0000);
> 
> -       ledcfg = rtl8xxxu_read16(priv, REG_LEDCFG0);
> +       ledcfg = rtl8xxxu_read32(priv, REG_LEDCFG0);
> +
> +       /* Set LED0 GPIO enabled */
> +       ledcfg |= LEDCFG0_LED0_GPIO_ENABLE;
> 
>         if (brightness == LED_OFF) {
> -               /* Value obtained like above. */
> -               ledcfg = BIT(1) | BIT(7);
> +               /* Setting REG_LEDCFG0[15:0] to 0x0000 turns LED0/LED1 off. */
> +               ledcfg &= ~GENMASK(15, 0);
>         } else if (brightness == LED_ON) {
> -               /* Value obtained like above. */
> -               ledcfg = BIT(1) | BIT(7) | BIT(11);
> +               /* Setting REG_LEDCFG0[15:0] to 0x0808 turns LED0/LED1 on. */
> +               ledcfg &= ~GENMASK(15, 0);
> +               ledcfg |= LEDCFG0_LED1SV | LEDCFG0_LED0SV;
>         } else if (brightness == RTL8XXXU_HW_LED_CONTROL) {
> -               /* Value obtained by brute force. */
> -               ledcfg = BIT(8) | BIT(9);
> +               /* Setting REG_LEDCFG0[15:0] to 0x0303 enables
> +                * hardware-controlled blinking for LED0/LED1.
> +                * The value 0x0303 is obtained by brute force.

I suppose this would not be a brute force if you can use register definitions
I provided by v1. 

> +                */
> +               ledcfg &= ~GENMASK(15, 0);
> +               ledcfg |= BIT(9) | BIT(8) | BIT(1) | BIT(0);
>         }
> 
> -       rtl8xxxu_write16(priv, REG_LEDCFG0, ledcfg);
> +       rtl8xxxu_write32(priv, REG_LEDCFG0, ledcfg);
> 
>         return 0;
>  }
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
> index 920ee50e2115..5ce845f1d069 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
> @@ -146,6 +146,9 @@
>  #define  GPIO_INTM_EDGE_TRIG_IRQ       BIT(9)
> 
>  #define REG_LEDCFG0                    0x004c
> +#define  LEDCFG0_LED0SV                        BIT(3)
> +#define  LEDCFG0_LED1SV                        BIT(11)
> +#define  LEDCFG0_LED0_GPIO_ENABLE      BIT(21)
>  #define  LEDCFG0_DPDT_SELECT           BIT(23)
>  #define REG_LEDCFG1                    0x004d
>  #define  LEDCFG1_HW_LED_CONTROL                BIT(1)
> --
> 2.42.0

