Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6662B797F9E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbjIHAXp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Sep 2023 20:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbjIHAXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:23:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7381BCD;
        Thu,  7 Sep 2023 17:23:39 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3880NDSd81157082, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3880NDSd81157082
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 08:23:14 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 8 Sep 2023 08:23:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 8 Sep 2023 08:23:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Fri, 8 Sep 2023 08:23:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>, Yanik Fuchs <Yanik.fuchs@mbv.ch>
Subject: RE: [PATCH] wifi: rtw88: rtw8723d: Fix MAC address offset in EEPROM
Thread-Topic: [PATCH] wifi: rtw88: rtw8723d: Fix MAC address offset in EEPROM
Thread-Index: AQHZ4bCywrxD8v2r7U+cPGPqL7npbrAQEGKw
Date:   Fri, 8 Sep 2023 00:23:13 +0000
Message-ID: <bed0e0cacc44476582fc58180d77519c@realtek.com>
References: <20230907071614.2032404-1-s.hauer@pengutronix.de>
In-Reply-To: <20230907071614.2032404-1-s.hauer@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Thursday, September 7, 2023 3:16 PM
> To: linux-wireless@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih <pkshih@realtek.com>; Yanik
> Fuchs <Yanik.fuchs@mbv.ch>
> Subject: [PATCH] wifi: rtw88: rtw8723d: Fix MAC address offset in EEPROM
> 
> The MAC address is stored at offset 0x107 in the EEPROM, like correctly
> stated in the comment. Add a two bytes reserved field right before the
> MAC address to shift it from offset 0x105 to 0x107.
> 
> With this the MAC address returned from my RTL8723du wifi stick can be
> correctly decoded as "Shenzhen Four Seas Global Link Network Technology
> Co., Ltd."

With this correctness, my stick can be recognized as: 
" Bus 003 Device 010: ID 0bda:d723 Realtek Semiconductor Corp. 802.11n WLAN Adapter"

Should it add a Fixes tag? 
Fixes: 87caeef032fc ("wifi: rtw88: Add rtw8723du chipset support")

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reported-by: Yanik Fuchs <Yanik.fuchs@mbv.ch>
> Cc: stable@vger.kernel.org

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

By the way, this patch should be 'v2' that seems to add more people in
To or Cc fields.

> ---
>  drivers/net/wireless/realtek/rtw88/rtw8723d.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
> b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
> index 3642a2c7f80c9..2434e2480cbe2 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
> @@ -46,6 +46,7 @@ struct rtw8723du_efuse {
>         u8 vender_id[2];                /* 0x100 */
>         u8 product_id[2];               /* 0x102 */
>         u8 usb_option;                  /* 0x104 */
> +       u8 res5[2];                     /* 0x105 */
>         u8 mac_addr[ETH_ALEN];          /* 0x107 */
>  };
> 
> --
> 2.39.2

