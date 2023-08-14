Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCA077B211
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjHNHIR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 03:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjHNHIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:08:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C2F2AC;
        Mon, 14 Aug 2023 00:08:03 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37E76suY6029627, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37E76suY6029627
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Aug 2023 15:06:54 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 14 Aug 2023 15:07:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 14 Aug 2023 15:07:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 14 Aug 2023 15:07:13 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "edumazet@google.com" <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>
Subject: RE: Error 'netif_napi_add_weight() called with weight 256'
Thread-Topic: Error 'netif_napi_add_weight() called with weight 256'
Thread-Index: AQHZw8h1VlKS4AgmjUKpznAl5+SYmK/Tp70AgAAC4ICACvPXQP//7sWAgANr4sD//9pVAIAHlskA
Date:   Mon, 14 Aug 2023 07:07:13 +0000
Message-ID: <ae1c5e6045b24dbfaf9cfa20566e9be6@realtek.com>
References: <0bfd445a-81f7-f702-08b0-bd5a72095e49@amd.com>
        <20230731111330.5211e637@kernel.org>
        <673bc252-2b34-6ef9-1765-9c7cac1e8658@amd.com>
        <8fcbab1aa2e14262bea79222bf7a4976@realtek.com>
        <20230807093727.5249f517@kernel.org>
        <ba9b777754f7493ba14faa2dab7d8d59@realtek.com>
 <20230809113732.5806b550@kernel.org>
In-Reply-To: <20230809113732.5806b550@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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

Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, August 10, 2023 2:38 AM
[...]
> High weight will cause higher latency for other softirq and RT
> processing, it's not a good idea. Even with weight/budget of 64
> if there's no higher prio work to do the driver will be polled
> again immediately if it consumed the budget and has more packets.

I mean that only the slow platform uses more than 64 budget,
even I set the weight to 256.
That is, for the fast platform, the actual used budget is always less than 64,
even the weight is 256.

> Do you have some actual data on how the device performs with budget
> of 64 and 256? And maybe perf traces to show where the difference goes?

I tested that slow embedded platform many years ago, so I
don't remember the actual data.
I think the difference is more than 400Mbps.

Best Regards,
Hayes

