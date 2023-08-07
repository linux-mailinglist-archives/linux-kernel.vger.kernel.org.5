Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3205771785
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 02:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjHGAlu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 6 Aug 2023 20:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGAls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 20:41:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9942170E;
        Sun,  6 Aug 2023 17:41:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3770f2MC1027837, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3770f2MC1027837
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 7 Aug 2023 08:41:02 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 7 Aug 2023 08:41:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 7 Aug 2023 08:41:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 7 Aug 2023 08:41:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "Lukas F . Hartmann" <lukas@mntre.com>
Subject: RE: [PATCH v2] wifi: rtw88: sdio: Honor the host max_req_size in the RX path
Thread-Topic: [PATCH v2] wifi: rtw88: sdio: Honor the host max_req_size in the
 RX path
Thread-Index: AQHZyJJBxKp6wAKI9k2D+NDrSHNiaq/d+wnA
Date:   Mon, 7 Aug 2023 00:41:01 +0000
Message-ID: <42e6d455aaa34c68ba8d50ec22a17b79@realtek.com>
References: <20230806181656.2072792-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20230806181656.2072792-1-martin.blumenstingl@googlemail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Sent: Monday, August 7, 2023 2:17 AM
> To: linux-wireless@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; jernej.skrabec@gmail.com; Ping-Ke Shih <pkshih@realtek.com>;
> ulf.hansson@linaro.org; kvalo@kernel.org; tony0620emma@gmail.com; Martin Blumenstingl
> <martin.blumenstingl@googlemail.com>; Lukas F . Hartmann <lukas@mntre.com>
> Subject: [PATCH v2] wifi: rtw88: sdio: Honor the host max_req_size in the RX path
> 

[...]

> 
> 
>  drivers/net/wireless/realtek/rtw88/sdio.c | 30 +++++++++++++++++------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
> index 2c1fb2dabd40..553b7e68ca3b 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -500,19 +500,35 @@ static u32 rtw_sdio_get_tx_addr(struct rtw_dev *rtwdev, size_t size,
>  static int rtw_sdio_read_port(struct rtw_dev *rtwdev, u8 *buf, size_t count)
>  {
>         struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
> +       struct mmc_host *host = rtwsdio->sdio_func->card->host;
>         bool bus_claim = rtw_sdio_bus_claim_needed(rtwsdio);
>         u32 rxaddr = rtwsdio->rx_addr++;
> -       int ret;
> +       int ret = 0, err = 0;

nit: no need initializer of 'err'

> +       size_t bytes;
> 
>         if (bus_claim)
>                 sdio_claim_host(rtwsdio->sdio_func);
> 
> -       ret = sdio_memcpy_fromio(rtwsdio->sdio_func, buf,
> -                                RTW_SDIO_ADDR_RX_RX0FF_GEN(rxaddr), count);
> -       if (ret)
> -               rtw_warn(rtwdev,
> -                        "Failed to read %zu byte(s) from SDIO port 0x%08x",
> -                        count, rxaddr);
> +       while (count > 0) {
> +               bytes = min_t(size_t, host->max_req_size, count);
> +
> +               err = sdio_memcpy_fromio(rtwsdio->sdio_func, buf,
> +                                        RTW_SDIO_ADDR_RX_RX0FF_GEN(rxaddr),
> +                                        bytes);
> +               if (err) {
> +                       rtw_warn(rtwdev,
> +                                "Failed to read %zu byte(s) from SDIO port 0x%08x: %d",
> +                                bytes, rxaddr, err);
> +                       ret = err;

I think this intends to return an error to callers if one error presents among
N times read. Would you like to point out this in comment as well? Because I want
to say we don't need 'err' at first glance, but this is indeed needed. 

> +                       /* Don't stop here - instead drain the remaining data
> +                        * from the card's buffer, else the card will return
> +                        * corrupt data for the next rtw_sdio_read_port() call.
> +                        */
> +               }
> +
> +               count -= bytes;
> +               buf += bytes;
> +       }
> 
>         if (bus_claim)
>                 sdio_release_host(rtwsdio->sdio_func);
> --
> 2.41.0

