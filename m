Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB17CA3E1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjJPJRd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Oct 2023 05:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJPJRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:17:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A158EB4;
        Mon, 16 Oct 2023 02:17:28 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39G9GN3R02428077, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39G9GN3R02428077
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 17:16:24 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 16 Oct 2023 17:15:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 16 Oct 2023 17:15:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 16 Oct 2023 17:15:51 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Grant Grundler <grundler@chromium.org>,
        =?iso-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>,
        "Eric Dumazet" <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v3 5/5] r8152: Block future register access if register access fails
Thread-Topic: [PATCH v3 5/5] r8152: Block future register access if register
 access fails
Thread-Index: AQHZ/UKPr2uppqw2y0WH24Vf4SC1orBMGX/A
Date:   Mon, 16 Oct 2023 09:15:51 +0000
Message-ID: <29f9a2ff1979406489213909b940184f@realtek.com>
References: <20231012192552.3900360-1-dianders@chromium.org>
 <20231012122458.v3.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
In-Reply-To: <20231012122458.v3.5.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Anderson <dianders@chromium.org>
> Sent: Friday, October 13, 2023 3:25 AM
[...]
>  static int generic_ocp_read(struct r8152 *tp, u16 index, u16 size,
> @@ -8265,6 +8353,19 @@ static int rtl8152_pre_reset(struct usb_interface
> *intf)
>         if (!tp)
>                 return 0;
> 
> +       /* We can only use the optimized reset if we made it to the end of
> +        * probe without any register access fails, which sets
> +        * `PROBED_WITH_NO_ERRORS` to true. If we didn't have that then return
> +        * an error here which tells the USB framework to fully unbind/rebind
> +        * our driver.

Would you stay in a loop of unbind and rebind,
if the control transfers in the probe() are not always successful?
I just think about the worst case that at least one control always fails in probe().

> +        */
> +       mutex_lock(&tp->control);

I don't think you need the mutex for testing the bit.

> +       if (!test_bit(PROBED_WITH_NO_ERRORS, &tp->flags)) {
> +               mutex_unlock(&tp->control);
> +               return -EIO;
> +       }
> +       mutex_unlock(&tp->control);
> +
>         netdev = tp->netdev;
>         if (!netif_running(netdev))
>                 return 0;
> @@ -8277,7 +8378,9 @@ static int rtl8152_pre_reset(struct usb_interface
> *intf)
>         napi_disable(&tp->napi);
>         if (netif_carrier_ok(netdev)) {
>                 mutex_lock(&tp->control);
> +               set_bit(IN_PRE_RESET, &tp->flags);
>                 tp->rtl_ops.disable(tp);
> +               clear_bit(IN_PRE_RESET, &tp->flags);
>                 mutex_unlock(&tp->control);
>         }
> 
> @@ -8293,6 +8396,10 @@ static int rtl8152_post_reset(struct usb_interface
> *intf)
>         if (!tp)
>                 return 0;
> 
> +       mutex_lock(&tp->control);

I don't think clear_bit() needs the protection of mutex.
I think you could call rtl_set_accessible() directly.

> +       rtl_set_accessible(tp);
> +       mutex_unlock(&tp->control);
> +
>         /* reset the MAC address in case of policy change */
>         if (determine_ethernet_addr(tp, &sa) >= 0) {
>                 rtnl_lock();

Best Regards,
Hayes

