Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2494675590C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 03:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjGQB3B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 16 Jul 2023 21:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQB3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 21:29:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71217E48;
        Sun, 16 Jul 2023 18:28:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36H1SVLz8029388, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36H1SVLz8029388
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 17 Jul 2023 09:28:31 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 17 Jul 2023 09:28:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 17 Jul 2023 09:28:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 17 Jul 2023 09:28:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Zhang Shurong <zhang_shurong@foxmail.com>,
        "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        "kuba@kernel.org" <kuba@kernel.org>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] wifi: rtw89: debug: Fix error handling in rtw89_debug_priv_btc_manual_set()
Thread-Topic: [PATCH v4] wifi: rtw89: debug: Fix error handling in
 rtw89_debug_priv_btc_manual_set()
Thread-Index: AQHZtyJP/JJ+WUOdGEKPFTonbmCFAq+9LKkw
Date:   Mon, 17 Jul 2023 01:28:39 +0000
Message-ID: <96af917c4c8d46438da1e703b2276185@realtek.com>
References: <tencent_1C09B99BD7DA9CAD18B00C8F0F050F540607@qq.com>
In-Reply-To: <tencent_1C09B99BD7DA9CAD18B00C8F0F050F540607@qq.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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
> From: Zhang Shurong <zhang_shurong@foxmail.com>
> Sent: Saturday, July 15, 2023 9:43 PM
> To: Ping-Ke Shih <pkshih@realtek.com>; Markus.Elfring@web.de; kuba@kernel.org
> Cc: kvalo@kernel.org; linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; Zhang Shurong
> <zhang_shurong@foxmail.com>
> Subject: [PATCH v4] wifi: rtw89: debug: Fix error handling in rtw89_debug_priv_btc_manual_set()
> 
> If there is a failure during kstrtobool_from_user()
> rtw89_debug_priv_btc_manual_set should return a negative error code
> instead of returning the count directly.
> 
> Fix this bug by returning an error code instead of a count after
> a failed call of the function "kstrtobool_from_user". Moreover
> I omitted the label "out" with this source code correction.
> 
> Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
> Changes in v2:
> - Corrected the format of this patch
> - Used variable ret instead of goto out
> Changes in v3:
> - Improved change description
> Changes in v4:
> - Improved change description
> 

Normally, we preserve three '-' as delimiter here. I tried to use pwclient to 
apply this patch, and fortunately it works. So, I think no need to resend because
of this.

[...]

