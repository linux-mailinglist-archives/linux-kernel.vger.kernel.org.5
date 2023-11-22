Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18E87F3AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjKVAsU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 19:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKVAsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:48:19 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520C3112;
        Tue, 21 Nov 2023 16:48:14 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AM0ltsU71882058, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AM0ltsU71882058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Nov 2023 08:47:55 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 22 Nov 2023 08:47:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 22 Nov 2023 08:47:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 22 Nov 2023 08:47:55 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "tony0620emma@gmail.com" <tony0620emma@gmail.com>,
        "lukas@mntre.com" <lukas@mntre.com>
Subject: RE: [PATCH v3] wifi: rtw88: sdio: Honor the host max_req_size in the RX path
Thread-Topic: [PATCH v3] wifi: rtw88: sdio: Honor the host max_req_size in the
 RX path
Thread-Index: AQHaG6jDIcpCLdDdCE6Dt6ztbl+1PLCFgaMQ
Date:   Wed, 22 Nov 2023 00:47:55 +0000
Message-ID: <d585b2ed88254bbf8747a86324a25fa6@realtek.com>
References: <20231120115726.1569323-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20231120115726.1569323-1-martin.blumenstingl@googlemail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Sent: Monday, November 20, 2023 7:57 PM
> To: linux-wireless@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; jernej.skrabec@gmail.com; Ping-Ke Shih <pkshih@realtek.com>;
> ulf.hansson@linaro.org; kvalo@kernel.org; tony0620emma@gmail.com; lukas@mntre.com; Martin Blumenstingl
> <martin.blumenstingl@googlemail.com>
> Subject: [PATCH v3] wifi: rtw88: sdio: Honor the host max_req_size in the RX path
> 
> Lukas reports skb_over_panic errors on his Banana Pi BPI-CM4 which comes
> with an Amlogic A311D (G12B) SoC and a RTL8822CS SDIO wifi/Bluetooth
> combo card. The error he observed is identical to what has been fixed
> in commit e967229ead0e ("wifi: rtw88: sdio: Check the HISR RX_REQUEST
> bit in rtw_sdio_rx_isr()") but that commit didn't fix Lukas' problem.

Could I know if this patch can fix Lukas' problem? If result is positive,
please add my ack.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

[...]


