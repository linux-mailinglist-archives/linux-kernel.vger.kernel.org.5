Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278177E1A52
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjKFGnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKFGna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:43:30 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD10F9;
        Sun,  5 Nov 2023 22:43:25 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A66gbokF3312619, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A66gbokF3312619
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 14:42:37 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 6 Nov 2023 14:42:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Nov 2023 14:42:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 6 Nov 2023 14:42:37 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Zheng Hacker <hackerzheng666@gmail.com>,
        Zheng Wang <zyytlz.wz@163.com>
CC:     "aspriel@gmail.com" <aspriel@gmail.com>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "jisoo.jang@yonsei.ac.kr" <jisoo.jang@yonsei.ac.kr>,
        "linuxlovemin@yonsei.ac.kr" <linuxlovemin@yonsei.ac.kr>,
        "wataru.gohda@cypress.com" <wataru.gohda@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach
Thread-Topic: [PATCH v3] brcmfmac: Fix use-after-free bug in
 brcmf_cfg80211_detach
Thread-Index: AQHaEHB6V0+Brry5e0a00xnicEhvc7Bs12Vg
Date:   Mon, 6 Nov 2023 06:42:37 +0000
Message-ID: <e783dbcedc9b444ca2651d2eac036d6e@realtek.com>
References: <20231106043957.815407-1-zyytlz.wz@163.com>
 <CAJedcCxoDVS-7jVwLvsWOWiv0aObyYBiG-GmqX4bq+Qp+i3iTw@mail.gmail.com>
In-Reply-To: <CAJedcCxoDVS-7jVwLvsWOWiv0aObyYBiG-GmqX4bq+Qp+i3iTw@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhlbmcgSGFja2VyIDxo
YWNrZXJ6aGVuZzY2NkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgNiwgMjAy
MyAxOjE2IFBNDQo+IFRvOiBaaGVuZyBXYW5nIDx6eXl0bHoud3pAMTYzLmNvbT4NCj4gQ2M6IGFz
cHJpZWxAZ21haWwuY29tOyBmcmFua3kubGluQGJyb2FkY29tLmNvbTsgaGFudGUubWV1bGVtYW5A
YnJvYWRjb20uY29tOyBrdmFsb0BrZXJuZWwub3JnOw0KPiBqb2hhbm5lcy5iZXJnQGludGVsLmNv
bTsgbWFyY2FuQG1hcmNhbi5zdDsgbGludXMud2FsbGVpakBsaW5hcm8ub3JnOyBqaXNvby5qYW5n
QHlvbnNlaS5hYy5rcjsNCj4gbGludXhsb3ZlbWluQHlvbnNlaS5hYy5rcjsgd2F0YXJ1LmdvaGRh
QGN5cHJlc3MuY29tOyBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGJyY204MDIx
MS1kZXYtbGlzdC5wZGxAYnJvYWRjb20uY29tOyBTSEEtY3lmbWFjLWRldi1saXN0QGluZmluZW9u
LmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gc2VjdXJpdHlAa2VybmVsLm9y
Zzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBicmNt
Zm1hYzogRml4IHVzZS1hZnRlci1mcmVlIGJ1ZyBpbiBicmNtZl9jZmc4MDIxMV9kZXRhY2gNCg0K
c3ViamVjdCBwcmVmaXggIndpZjogYnJjbWZtYWM6IC4uLiINClRyeSAiZ2l0IGxvZyAtLW9uZWxp
bmUgZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFjIiB0byBr
bm93IHRoYXQuIA0KDQo+IA0KPiBUaGlzIGlzIHRoZSBjYW5kaWRhdGUgcGF0Y2ggb2YgQ1ZFLTIw
MjMtNDcyMzMgOg0KPiBodHRwczovL252ZC5uaXN0Lmdvdi92dWxuL2RldGFpbC9DVkUtMjAyMy00
NzIzMw0KDQpJIHRoaW5rIHlvdSBjYW4gYWRkIHRoaXMgbGluayB0byBjb21taXQgbWVzc2FnZSBh
cyB3ZWxsLiANCg0KDQo=
