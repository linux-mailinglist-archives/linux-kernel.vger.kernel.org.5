Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B717F6EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345102AbjKXIxY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Nov 2023 03:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXIxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:53:21 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B630D53;
        Fri, 24 Nov 2023 00:53:26 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AO8pJvQ53617164, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AO8pJvQ53617164
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Nov 2023 16:51:21 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Nov 2023 16:51:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 24 Nov 2023 16:51:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 24 Nov 2023 16:51:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Su Hui <suhui@nfschina.com>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "trix@redhat.com" <trix@redhat.com>
CC:     "lizetao1@huawei.com" <lizetao1@huawei.com>,
        "linville@tuxdriver.com" <linville@tuxdriver.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior
Thread-Topic: [PATCH v2 2/2] wifi: rtlwifi: rtl8821ae: phy: fix an undefined
 bitwise shift behavior
Thread-Index: AQHaHnqh3ek0X9cmrkSIvDKQ0v3B9rCJKRKA
Date:   Fri, 24 Nov 2023 08:51:15 +0000
Message-ID: <167fbc7a77db447d90f696666f6f0a9b@realtek.com>
References: <20231124020352.1660621-1-suhui@nfschina.com>
 <20231124020352.1660621-2-suhui@nfschina.com>
In-Reply-To: <20231124020352.1660621-2-suhui@nfschina.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Su Hui <suhui@nfschina.com>
> Sent: Friday, November 24, 2023 10:04 AM
> To: dan.carpenter@linaro.org; Ping-Ke Shih <pkshih@realtek.com>; kvalo@kernel.org; nathan@kernel.org;
> ndesaulniers@google.com; trix@redhat.com
> Cc: Su Hui <suhui@nfschina.com>; lizetao1@huawei.com; linville@tuxdriver.com; Larry.Finger@lwfinger.net;
> linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; llvm@lists.linux.dev;
> kernel-janitors@vger.kernel.org
> Subject: [PATCH v2 2/2] wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior
> 

[...]

> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> index 6df270e29e66..52ab1b0761c0 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> @@ -31,7 +31,12 @@ static u32 _rtl8821ae_phy_calculate_bit_shift(u32 bitmask)
>  {
>         u32 i = ffs(bitmask);
> 
> -       return i ? i - 1 : 32;
> +       if (!i) {
> +               WARN_ON_ONCE(1);
> +               return 0;
> +       }
> +
> +       return i - 1;
>  }

Personally, I prefer to use __ffs(), because in normal case no need additional '-1',
and abnormal cases should not happen. 


