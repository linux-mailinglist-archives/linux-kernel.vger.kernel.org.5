Return-Path: <linux-kernel+bounces-3313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514E0816AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45FA1F24B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8F513AF1;
	Mon, 18 Dec 2023 10:18:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E715483;
	Mon, 18 Dec 2023 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BIAIVdC43382004, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BIAIVdC43382004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 18:18:31 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 18 Dec 2023 18:18:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 18 Dec 2023 18:18:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 18 Dec 2023 18:18:30 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Paolo Abeni <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>, Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v14 07/13] rtase: Implement a function to receive packets
Thread-Topic: [PATCH net-next v14 07/13] rtase: Implement a function to
 receive packets
Thread-Index: AQHaKbuc5PsGtCK8iE+X+AXG8s/kd7Ck67gAgAn2eIA=
Date: Mon, 18 Dec 2023 10:18:30 +0000
Message-ID: <5368be1697534df09784f95d93b1f1fd@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
	 <20231208094733.1671296-8-justinlai0215@realtek.com>
 <18552cff6fe32d4c21b4751cd6be4ff4757c63e8.camel@redhat.com>
In-Reply-To: <18552cff6fe32d4c21b4751cd6be4ff4757c63e8.camel@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

PiA+ICsNCj4gPiArICAgICBjdXJfcnggPSByaW5nLT5jdXJfaWR4Ow0KPiA+ICsgICAgIGVudHJ5
ID0gY3VyX3J4ICUgTlVNX0RFU0M7DQo+ID4gKyAgICAgZGVzYyA9ICZkZXNjX2Jhc2VbZW50cnld
Ow0KPiA+ICsNCj4gPiArICAgICBkbyB7DQo+ID4gKyAgICAgICAgICAgICAvKiBtYWtlIHN1cmUg
ZGlzY3JpcHRvciBoYXMgYmVlbiB1cGRhdGVkICovDQo+ID4gKyAgICAgICAgICAgICBybWIoKTsN
Cj4gPiArICAgICAgICAgICAgIHN0YXR1cyA9IGxlMzJfdG9fY3B1KGRlc2MtPmRlc2Nfc3RhdHVz
Lm9wdHMxKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICBpZiAoc3RhdHVzICYgREVTQ19PV04p
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsNCj4gPiArICAgICAgICAg
ICAgIGlmICh1bmxpa2VseShzdGF0dXMgJiBSWF9SRVMpKSB7DQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgIGlmIChuZXRfcmF0ZWxpbWl0KCkpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgbmV0ZGV2X3dhcm4oZGV2LCAiUnggRVJST1IuIHN0YXR1cyA9DQo+ICUwOHhcbiIsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzKTsNCj4g
PiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGRldi0+c3RhdHMucnhfZXJyb3JzKys7DQo+
ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBpZiAoc3RhdHVzICYgKFJYX1JXVCB8IFJY
X1JVTlQpKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldi0+c3RhdHMucnhf
bGVuZ3RoX2Vycm9ycysrOw0KPiANCj4gVGhlIGRldmljZSBoYXMgYSBzaW5nbGUgUlggcXVldWUs
IHJpZ2h0PyBPdGhlcndpc2UgdGhpcyBraW5kIG9mIHN0YXRzDQo+IGFjY291bnRpbmcgaXMgZ29p
bmcgdG8gYmUgY29zdGx5Lg0KPiANCj4gQ2hlZXJzLA0KPiANCj4gUGFvbG8NCg0KSGksIFBhb2xv
DQoNClRoaXMgZGV2aWNlIHN1cHBvcnRzIG11bHRpcGxlIFJYIHF1ZXVlLg0KQ291bGQgeW91IHBs
ZWFzZSBwcm92aWRlIGFuIGV4YW1wbGUgb2YgaG93IHlvdSB3b3VsZCBsaWtlIGl0IGRvbmU/DQo=

