Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ABB7FEA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjK3I1z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Nov 2023 03:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjK3I1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:27:47 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031FD10D0;
        Thu, 30 Nov 2023 00:27:51 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AU8R2vsC3390733, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AU8R2vsC3390733
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Nov 2023 16:27:02 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 30 Nov 2023 16:27:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 30 Nov 2023 16:27:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 30 Nov 2023 16:27:02 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Grant Grundler <grundler@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Edward Hill <ecgh@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>,
        "Eric Dumazet" <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net v3 5/5] r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()
Thread-Topic: [PATCH net v3 5/5] r8152: Add RTL8152_INACCESSIBLE to
 r8153_aldps_en()
Thread-Index: AQHaIwq5NbchQV0OhUGi+YoyKvWVRrCSg2Aw
Date:   Thu, 30 Nov 2023 08:27:00 +0000
Message-ID: <52a03c3217704bfa8051c9d4006a99a4@realtek.com>
References: <20231129132521.net.v3.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
 <20231129132521.net.v3.5.I1306b6432228404d6e61b2d43c2f71885292e972@changeid>
In-Reply-To: <20231129132521.net.v3.5.I1306b6432228404d6e61b2d43c2f71885292e972@changeid>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.228.6]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="iso-8859-1"
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

Douglas Anderson <dianders@chromium.org>
> Sent: Thursday, November 30, 2023 5:25 AM
[...]
> 
> Delay loops in r8152 should break out if RTL8152_INACCESSIBLE is set
> so that they don't delay too long if the device becomes
> inaccessible. Add the break to the loop in r8153_aldps_en().
> 
> Fixes: 4214cc550bf9 ("r8152: check if disabling ALDPS is finished")
> Reviewed-by: Grant Grundler <grundler@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Hayes Wang <hayeswang@realtek.com>

Best Regards,
Hayes

