Return-Path: <linux-kernel+bounces-138178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A32489EDCB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 009CAB22016
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF5D155300;
	Wed, 10 Apr 2024 08:39:27 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D4F154BF7;
	Wed, 10 Apr 2024 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738367; cv=none; b=qeKOQY0WNbejj4T3h3o0uFhOQmWhLXmFFxqdcuaN/uy8mvSNNOW6WE29omsi4Oan4b0tz65MPGDVw6DI8RIkKDlDwt5EMaD2y5zcQ+SFGA24sC8WsrewugdUaSly+1XB22yDnl8CcF4KC8vnlXLveKVyBhx5TYqqNTg9CQignY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738367; c=relaxed/simple;
	bh=ZO2PG/fMQB+8VlbmBQVf9zcfZmh9qOkdCf4vHQD3Px4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BYqA0l70I+izV+kSHXzpA1EKgBW2pBZEixp09gB1t4Kx1HZdxDmq5zwk4ZqUxs2xuIJxpVYIRzkwF5KJJiBHaWc4mOkmt3CrfLyEdI3n+WxGspMut5uV4F9HKjfH/ptjujUdeJfRaQ5aPqi93NdCcfLvgNh/qqs99YZEzlqI79U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 43A8c4T8014703;
	Wed, 10 Apr 2024 16:38:04 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX11-BJD.srv.huawei-3com.com (unknown [10.153.34.13])
	by mail.maildlp.com (Postfix) with ESMTP id CB763235AF7B;
	Wed, 10 Apr 2024 16:40:14 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX11-BJD.srv.huawei-3com.com (10.153.34.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 10 Apr 2024 16:38:06 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Wed, 10 Apr 2024 16:38:06 +0800
From: Liuye <liu.yeC@h3c.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "jason.wessel@windriver.com"
	<jason.wessel@windriver.com>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "kgdb-bugreport@lists.sourceforge.net"
	<kgdb-bugreport@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSNOiBbUEFUQ0ggVjEwXSBr?=
 =?utf-8?Q?db:_Fix_the_deadlock_issue_in_KDB_debugging.?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENIIFYxMF0ga2RiOiBGaXgg?=
 =?utf-8?Q?the_deadlock_issue_in_KDB_debugging.?=
Thread-Index: AQHaiuuw81gSSyk26Eq+v/7KfdTz2LFgdGkAgACJimD//36cAIAAh7Hw//98qQCAAIohAP//mg0AABEeCaA=
Date: Wed, 10 Apr 2024 08:38:06 +0000
Message-ID: <8f0487eaf15442f5b0bf7a6cafa5b973@h3c.com>
References: <20240409020326.2125332-1-liu.yec@h3c.com>
 <20240410020615.2885000-1-liu.yec@h3c.com>
 <2024041014-padlock-aggregate-4705@gregkh>
 <0c004dd44ad5478eba9451186f4ec962@h3c.com>
 <2024041001-retaliate-cork-1fe5@gregkh>
 <5c659d5f41ff4cf69ea9467b62d74e9b@h3c.com>
 <2024041022-electable-unblock-5077@gregkh>
 <567857bab013409ca53fa7c36292f4b0@h3c.com>
 <2024041007-busload-equipment-b673@gregkh>
In-Reply-To: <2024041007-busload-equipment-b673@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 43A8c4T8014703

Pk9uIFdlZCwgQXByIDEwLCAyMDI0IGF0IDA2OjMwOjU5QU0gKzAwMDAsIExpdXllIHdyb3RlOg0K
Pj4gPk9uIFdlZCwgQXByIDEwLCAyMDI0IGF0IDA2OjEwOjEwQU0gKzAwMDAsIExpdXllIHdyb3Rl
Og0KPj4gPj4gPk9uIFdlZCwgQXByIDEwLCAyMDI0IGF0IDA1OjU0OjA4QU0gKzAwMDAsIExpdXll
IHdyb3RlOg0KPj4gPj4gPj4gPj4gU2lnbmVkLW9mZi1ieTogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+DQo+PiA+PiA+PiA+DQo+PiA+PiA+PiA+SSBoYXZlIE5PVCBzaWduZWQg
b2ZmIG9uIHRoaXMgY29tbWl0LiAgWW91IGp1c3Qgc2FpZCB0aGF0IEkgbWFkZSBhIGxlZ2FsIHN0
YXRlbWVudCBhYm91dCB0aGlzIGNvbW1pdCB3aXRob3V0IHRoYXQgYWN0dWFsbHkgYmVpbmcgdHJ1
ZT8/Pw0KPj4gPj4gPj4gPg0KPj4gPj4gPj4gPlNvcnJ5LCBidXQgdGhhdCBpcyBmbGF0IG91dCBu
b3QgYWNjZXB0YWJsZSBhdCBhbGwuICBQbGVhc2UgZ28gd29yayB3aXRoIHlvdXIgY29tcGFueSBs
YXd5ZXJzIHRvIGZpZ3VyZSBvdXQgd2hhdCB5b3UgZGlkIGFuZCBjb21lIGJhY2sgd2l0aCBhbiBl
eHBsYWluYXRpb24gb2YgZXhhY3RseSB3aGF0IHRoaXMgaXMgYW5kIGhvdyBpdCB3aWxsIG5vdCBo
YXBwZW4gYWdhaW4uDQo+PiA+PiA+PiA+DQo+PiA+PiA+PiANCj4+ID4+ID4+ID4+IFNpZ25lZC1v
ZmYtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4+ID4+
ID4+ID4NCj4+ID4+ID4+ID4+IFY5IC0+IFYxMCA6IEFkZCBTaWduZWQtb2ZmLWJ5IG9mIEdyZWcg
S0ggYW5kIEFuZHkgU2hldmNoZW5rbywgDQo+PiA+PiA+PiA+PiBBY2tlZC1ieSBvZiBEYW5pZWwg
VGhvbXBzb24NCj4+ID4+ID4+ID4NCj4+ID4+ID4+ID5IdWg/IQ0KPj4gPj4gPj4gDQo+PiA+PiA+
PiBAZ3JlZyBrLWgg77yaDQo+PiA+PiA+PiBAQW5keSBTaGV2Y2hlbmtvIO+8mg0KPj4gPj4gPj4g
DQo+PiA+PiA+PiBTb3JyeSwgaXQgd2FzIG15IG1pc3Rha2UuIEkgbWlzdW5kZXJzdG9vZCB0aGUg
bWVhbmluZyBvZiAic2lnbmVkLW9mZi1ieSIsIHdoaWNoIGxlZCB0byB1c2FnZSBpc3N1ZXMuDQo+
PiA+PiA+PiANCj4+ID4+ID4+IEkgd2FudCB0byBleHByZXNzIG15IGdyYXRpdHVkZSBmb3IgdGhl
IHN1Z2dlc3Rpb25zIG9uIHRoZSBwYXRjaCBmcm9tIHRoZSB0d28gb2YgeW91LiANCj4+ID4+ID4+
IA0KPj4gPj4gPj4gV2hhdCBkbyBJIG5lZWQgdG8gZG8gbm93PyBSZWxlYXNlIFBBVENIIFYxMSBh
bmQgZGVsZXRlIHRoZXNlIHR3byBzaWduYXR1cmVzIGluIGl0ID8NCj4+ID4+ID4NCj4+ID4+ID5B
cyBJIHNhaWQsIGdvIHdvcmsgd2l0aCB5b3VyIGNvcnBvcmF0ZSBsYXd5ZXJzIG9uIHRoaXMgdG8g
dW5kZXJzdGFuZCB3aGF0IGp1c3QgaGFwcGVuZWQgYW5kIGhhdmUgdGhlbSBsZXQgdXMga25vdyBo
b3cgaXQgd2lsbCBub3QgaGFwcGVuIGFnYWluLg0KPj4gPj4gDQo+PiA+PiBJJ20gdmVyeSBzb3Jy
eSwgdGhpcyBpcyBteSBmaXJzdCB0aW1lIHN1Ym1pdHRpbmcgYSBwYXRjaCBhbmQgSSBtYWRlIGEg
c2lnbmlmaWNhbnQgbWlzdGFrZSBpbiB1c2luZyAiU2lnbmVkLW9mZi1ieSIuIEkgbm93IHVuZGVy
c3RhbmQgdGhlIG1lYW5pbmcgb2YgdGhpcyBmaWVsZCBhbmQgd2lsbCBub3QgbWFrZSB0aGUgc2Ft
ZSBtaXN0YWtlIGFnYWluIGluIHRoZSBmdXR1cmUuDQo+PiA+DQo+PiA+VW5kZXJzdG9vZCwgYnV0
IHlvdSBzdGlsbCBuZWVkIHRvIGdvIHdvcmsgd2l0aCB5b3VyIGNvcnBvcmF0ZSBsZWdhbCBncm91
cCBzbyB0aGF0IHlvdSBhbGwgZW5zdXJlIHRoaXMgZG9lcyBub3QgaGFwcGVuIGFnYWluIGZvciBh
bnkgb3RoZXIgZGV2ZWxvcGVyIGluIHlvdXIgY29tcGFueSwgYXMgSSBhbSBzdXJlIHRoZXkgd2ls
bCB3YW50IHRvIGtub3cgYWJvdXQgdGhpcy4NCj4+IA0KPj4gT2ssIEkgd2lsbCByZXBvcnQgdGhp
cyB0byB0aGUgY29tcGFueS4gQXQgdGhlIHNhbWUgdGltZSwgSSB3aWxsIGFkZCBhbiBhdWRpdCBt
ZWNoYW5pc20gdG8gdGhlIHBhdGNoIHN1Ym1pc3Npb24gcHJvY2Vzcy4gVGhhbmtzIGFnYWluIGZv
ciB5b3VyIHJlbWluZGVyLg0KPj4gDQo+PiBJIHdpbGwgcmVtb3ZlIHRoaXMgcGFydCBpbiBQQVRD
SCBWMTEuDQo+DQo+Tm8sIHlvdSB3aWxsIG5lZWQgdG8gZG8gdGhpcyBiZWZvcmUgd2UgY2FuIGFj
Y2VwdCB5b3VyIGNoYW5nZS4gIEFuZCBzb21lIHNvcnQgb2YgdmVyaWZpY2F0aW9uIHRoYXQgdGhp
cyBpcyBub3cgaW4gcGxhY2UgcHJvcGVybHkgZm9yIG9idmlvdXMgcmVhc29ucy4NCg0KV2hhdCBk
b2VzICJObyIgbWVhbj8gQXJlIHlvdSB0YWxraW5nIGFib3V0IGdpdmluZyBmZWVkYmFjayB0byB0
aGUgY29tcGFueSB0byBwcmV2ZW50IHRoaXMgaW5jaWRlbnQgZnJvbSBoYXBwZW5pbmc/IE9yIHN1
Ym1pdHRpbmcgUEFUQ0ggVjExPyBJZiBpdCdzIHRoZSBmb3JtZXIsIGhvdyBzaG91bGQgSSBnaXZl
IHlvdSBmZWVkYmFjaz8iDQo=

