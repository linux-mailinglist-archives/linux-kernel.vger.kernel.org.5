Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E74479A1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 05:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjIKDp5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 10 Sep 2023 23:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjIKDp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:45:56 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7B319C;
        Sun, 10 Sep 2023 20:45:47 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38B3jayK7720369, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38B3jayK7720369
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 11:45:36 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 11 Sep 2023 11:45:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 11 Sep 2023 11:45:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Mon, 11 Sep 2023 11:45:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Zenm Chen <zenmchen@gmail.com>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: fix LED control code of RTL8192FU
Thread-Topic: [PATCH] wifi: rtl8xxxu: fix LED control code of RTL8192FU
Thread-Index: AQHZ43yy3RGPFV4ndke0IFI7dh9WYrAU6yYA
Date:   Mon, 11 Sep 2023 03:45:36 +0000
Message-ID: <f4891f71e1f44e7891d20a67b5db9523@realtek.com>
References: <20230910002038.56362-1-zenmchen@gmail.com>
In-Reply-To: <20230910002038.56362-1-zenmchen@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Zenm Chen <zenmchen@gmail.com>
> Sent: Sunday, September 10, 2023 8:21 AM
> To: Jes.Sorensen@gmail.com
> Cc: kvalo@kernel.org; linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> rtl8821cerfe2@gmail.com; Ping-Ke Shih <pkshih@realtek.com>; Zenm Chen <zenmchen@gmail.com>
> Subject: [PATCH] wifi: rtl8xxxu: fix LED control code of RTL8192FU
> 
> ASUS USB-N13 C1 is a wifi adapter based on a RTL8192FU chip and its LED
> doesn't blink with the rtl8xxxu driver. This patch fix this via writing
> the correct value to the register "REG_LEDCFG0".
> 
> This was tested with these two wifi adapters:
> ASUS USB-N13 C1 (vid=0x0b05, pid=0x18f1, rfe_type=0x1)
> MERCURY MW310UH (vid=0x0bda, pid=0xf192, rfe_type=0x5)

Did you ever try Linux vendor driver for software and hardware LED? 
Seemingly, the vendor driver is different from yours, but I'm pretty 
sure which one is correct because I don't have a RTL8192FU stick. 

> 
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> ---
>  .../realtek/rtl8xxxu/rtl8xxxu_8192f.c         | 24 ++++++++-----------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
> index 28e93835e05a..ab6d4e4e228e 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
> @@ -2014,26 +2014,22 @@ static int rtl8192fu_led_brightness_set(struct led_classdev *led_cdev,
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
> -
> -       if (brightness == LED_OFF) {
> -               /* Value obtained like above. */
> -               ledcfg = BIT(1) | BIT(7);
> -       } else if (brightness == LED_ON) {
> -               /* Value obtained like above. */
> -               ledcfg = BIT(1) | BIT(7) | BIT(11);
> -       } else if (brightness == RTL8XXXU_HW_LED_CONTROL) {
> -               /* Value obtained by brute force. */
> -               ledcfg = BIT(8) | BIT(9);
> -       }

The definitions are used by this driver: 

#define BIT_LED2EN BIT(21)
#define BIT_LED1SV BIT(11) // the same definition with BIT_LED0SV
#define BIT_LED1CM GENMASK(10, 8) // use the same value of BIT_LED0CM
#define BIT_LED0SV BIT(3)
#define BIT_LED0CM GENMASK(2, 0)
#define LED_MODE_TX_OR_RX_EVENTS 3
#define LED_MODE_SW_CTRL 0


> +       /* Enable LED0 GPIO and turn LED0/LED1 off. */
> +       ledcfg = (rtl8xxxu_read32(priv, REG_LEDCFG0) | BIT(21)) & ~0xffff;

Split this statement into multiple lines and use definitions I provide above.

> +
> +       /* Values obtained by brute force. */
> +       if (brightness == LED_ON)
> +               ledcfg |= BIT(3) | BIT(11);
> +       else if (brightness == RTL8XXXU_HW_LED_CONTROL)
> +               ledcfg |= BIT(0) | BIT(1) | BIT(8) | BIT(9);
> 
> -       rtl8xxxu_write16(priv, REG_LEDCFG0, ledcfg);
> +       rtl8xxxu_write32(priv, REG_LEDCFG0, ledcfg);
> 
>         return 0;
>  }
> --
> 2.42.0

