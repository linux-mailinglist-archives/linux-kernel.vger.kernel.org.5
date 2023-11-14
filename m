Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D137EA853
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjKNBlq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Nov 2023 20:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNBlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:41:45 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450CBD44;
        Mon, 13 Nov 2023 17:41:38 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AE1fLBr9504956, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AE1fLBr9504956
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 09:41:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Nov 2023 09:41:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 14 Nov 2023 09:41:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 14 Nov 2023 09:41:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Jian-Hong Pan <jhp@endlessos.org>,
        Larry Finger <Larry.Finger@lwfinger.net>
CC:     Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@endlessos.org" <linux@endlessos.org>
Subject: RE: [PATCH v2] rtlwifi: rtl8723be: Disable ASPM if RTL8723BE connects to Intel PCI bridge
Thread-Topic: [PATCH v2] rtlwifi: rtl8723be: Disable ASPM if RTL8723BE
 connects to Intel PCI bridge
Thread-Index: AQHaFesSDUrn2ZZcD0iHcrWtrRCESbB5BjIg
Date:   Tue, 14 Nov 2023 01:41:20 +0000
Message-ID: <2614f3f7a386435ea7d5f989061c7780@realtek.com>
References: <05390e0b-27fd-4190-971e-e70a498c8221@lwfinger.net>
 <20231113043454.10053-2-jhp@endlessos.org>
In-Reply-To: <20231113043454.10053-2-jhp@endlessos.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jian-Hong Pan <jhp@endlessos.org>
> Sent: Monday, November 13, 2023 12:35 PM
> To: Larry Finger <Larry.Finger@lwfinger.net>; Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux@endlessos.org; Jian-Hong Pan <jhp@endlessos.org>
> Subject: [PATCH v2] rtlwifi: rtl8723be: Disable ASPM if RTL8723BE connects to Intel PCI bridge
> 
> Disable rtl8723be's ASPM if the Realtek RTL8723BE PCIe Wireless adapter
> connects to some Intel PCI bridges, such as Skylake and Kabylake.
> Otherwise, the PCI AER flood hangs system:
> 
> pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
> pcieport 0000:00:1c.5:    [ 0] RxErr                  (First)
> pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> pcieport 0000:00:1c.5: AER: Multiple Corrected error received: 0000:00:1c.5
> pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> 
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=218127

Seemingly, you can use "Link" or "Closes" tag.

> Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


> ---
> v2: Add the switch case's default condition with comment:
>     "The ASPM has already been enabled by initializing
>     rtl8723be_mod_params' aspm_support as 1."
> 
>  .../wireless/realtek/rtlwifi/rtl8723be/sw.c   | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> index 43b611d5288d..b20c0b9d8393 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
> @@ -25,10 +25,34 @@ static void rtl8723be_init_aspm_vars(struct ieee80211_hw *hw)
>  {
>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>         struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
> +       struct pci_dev *bridge_pdev;
> 
>         /*close ASPM for AMD defaultly */
>         rtlpci->const_amdpci_aspm = 0;
> 
> +       /* Disable ASPM if RTL8723BE connects to some Intel PCI bridges, such as
> +        * Skylake and Kabylake. Otherwise, the PCI AER flood hangs system.
> +        */
> +       bridge_pdev = rtlpci->pdev->bus->self;
> +       if (bridge_pdev->vendor == PCI_VENDOR_ID_INTEL) {
> +               switch(bridge_pdev->device) {
> +               case 0x9d15:
> +               /* PCI bridges on Skylake */
> +               case 0xa110 ... 0xa11f:
> +               case 0xa167 ... 0xa16a:
> +               /* PCI bridges on Kabylake */
> +               case 0xa290 ... 0xa29f:
> +               case 0xa2e7 ... 0xa2ee:

Out of curiosity, do you have so many real platforms to test? 


