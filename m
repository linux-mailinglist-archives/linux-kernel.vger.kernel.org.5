Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5113752E51
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 02:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjGNAeo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 20:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjGNAem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 20:34:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DAE52D4B;
        Thu, 13 Jul 2023 17:34:40 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36E0Y7n84015630, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36E0Y7n84015630
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 14 Jul 2023 08:34:08 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 14 Jul 2023 08:34:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 14 Jul 2023 08:34:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 14 Jul 2023 08:34:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "Lukas F. Hartmann" <lukas@mntre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>
Subject: RE: [PATCH] wifi: rtw88: sdio: Honor the host max_req_size in the RX path
Thread-Topic: [PATCH] wifi: rtw88: sdio: Honor the host max_req_size in the RX
 path
Thread-Index: AQHZsp+XbJMjQ56edkCHhTIfjugPgq+yJqHggAT+3gCAAUh3EA==
Date:   Fri, 14 Jul 2023 00:34:14 +0000
Message-ID: <208ee32354b44205bb76a55c0d4bc93b@realtek.com>
References: <20230709195712.603200-1-martin.blumenstingl@googlemail.com>
 <b55cd3172ea7474ba1a67db2d5b39301@realtek.com> <87pm4w3rjp.fsf@mntre.com>
In-Reply-To: <87pm4w3rjp.fsf@mntre.com>
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Lukas F. Hartmann <lukas@mntre.com>
> Sent: Thursday, July 13, 2023 8:49 PM
> To: Ping-Ke Shih <pkshih@realtek.com>; Martin Blumenstingl <martin.blumenstingl@googlemail.com>;
> linux-wireless@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; jernej.skrabec@gmail.com; ulf.hansson@linaro.org; kvalo@kernel.org;
> tony0620emma@gmail.com
> Subject: RE: [PATCH] wifi: rtw88: sdio: Honor the host max_req_size in the RX path
> 
> Hi,
> 
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
> > I assume your conclusion is correct for all platforms, so I add my reviewed-by.
> > But, I think it would be better that Lukas can help to test this patch on his
> > platform, and give a tested-by tag before getting this patch merged.
> 
> I have been testing this now more rigorously in my own laptop with
> Kernel 6.4.1 (from Debian experimental) and this patch applied. I first
> had issues with rtw_power_mode_change (and "firmware failed to leave lps
> state"), so I turned off power_save using iw. This made everything
> quiet, but unfortunately after about 1 hour of usage I get
> skb_over_panic again and I believe some memory corruption happens in the
> kernel, as I can do dmesg only once and then another dmesg will hang forever.
> (After WARNING: CPU: 4 PID: 0 at kernel/context_tracking.c:128
> ct_kernel_exit.constprop.0+0xa0/0xa8)
> 
> Here are the errors that lead up to this:
> http://dump.mntmn.com/rtw88-failure-1h-dmesg.txt

Hi Martin,

The dmesg shows that
"rtw_8822cs mmc2:0001:1: Failed to read 1536 byte(s) from SDIO port 0x000000d1"

Shouldn't we return an error code (with proper error handling) instead of
just break the loop? Because 'buf' content isn't usable. 

I wonder the approach of this patch is still not enough for Lukas' platform. 

Ping-Ke

