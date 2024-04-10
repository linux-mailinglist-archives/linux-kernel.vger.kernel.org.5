Return-Path: <linux-kernel+bounces-137991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC86089EAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C351C21164
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E749E22071;
	Wed, 10 Apr 2024 06:32:27 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA5C8DD;
	Wed, 10 Apr 2024 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730747; cv=none; b=dowadIcocvUh77PGhTX1Vxpgj8dZJjofwPsL5d7xwRH9Re7uKbM3l/3gB5slBwWjHyDLsfmkpmKkAnztuSMKKMiVdzjKR9TSwyNZ/aQhH6UzKrZ5myQ1xGHScxXZY88BYCDiOKDzLOcQtVNjN9wZpvbaitsl5o6II6XdqOmgLog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730747; c=relaxed/simple;
	bh=pGvxBubreliBepPTNBS2k6SqYHRlWHDZe4Zl/3HRKZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MVzWykoaRp8OK9NDpFgPLcoKp21AQ3L62YMQEbgpaZTn/pm6JUzVZ8fq4CQ3BzdQpzLFEfxXvRtaFn/R507J6ewct5Q0UD9f4ttXtrXRm7vHuC90GHO2UErsGVePrKYFxosPUuwhJa8ISzo7z3RVs9h+d7BPZ8J2TUAQfDdipUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 43A6Uv1R068148;
	Wed, 10 Apr 2024 14:30:57 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX10-BJD.srv.huawei-3com.com (unknown [10.153.34.12])
	by mail.maildlp.com (Postfix) with ESMTP id BC1FD2006135;
	Wed, 10 Apr 2024 14:33:07 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX10-BJD.srv.huawei-3com.com (10.153.34.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 10 Apr 2024 14:30:59 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Wed, 10 Apr 2024 14:30:59 +0800
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
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlOWkjTogW1BBVENIIFYxMF0ga2RiOiBGaXgg?=
 =?utf-8?Q?the_deadlock_issue_in_KDB_debugging.?=
Thread-Topic: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCBWMTBdIGtkYjogRml4IHRoZSBkZWFk?=
 =?utf-8?Q?lock_issue_in_KDB_debugging.?=
Thread-Index: AQHaiuuw81gSSyk26Eq+v/7KfdTz2LFgdGkAgACJimD//36cAIAAh7Hw//98qQCAAIohAA==
Date: Wed, 10 Apr 2024 06:30:59 +0000
Message-ID: <567857bab013409ca53fa7c36292f4b0@h3c.com>
References: <20240409020326.2125332-1-liu.yec@h3c.com>
 <20240410020615.2885000-1-liu.yec@h3c.com>
 <2024041014-padlock-aggregate-4705@gregkh>
 <0c004dd44ad5478eba9451186f4ec962@h3c.com>
 <2024041001-retaliate-cork-1fe5@gregkh>
 <5c659d5f41ff4cf69ea9467b62d74e9b@h3c.com>
 <2024041022-electable-unblock-5077@gregkh>
In-Reply-To: <2024041022-electable-unblock-5077@gregkh>
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
X-MAIL:h3cspam02-ex.h3c.com 43A6Uv1R068148

Pk9uIFdlZCwgQXByIDEwLCAyMDI0IGF0IDA2OjEwOjEwQU0gKzAwMDAsIExpdXllIHdyb3RlOg0K
Pj4gPk9uIFdlZCwgQXByIDEwLCAyMDI0IGF0IDA1OjU0OjA4QU0gKzAwMDAsIExpdXllIHdyb3Rl
Og0KPj4gPj4gPj4gU2lnbmVkLW9mZi1ieTogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+DQo+PiA+PiA+DQo+PiA+PiA+SSBoYXZlIE5PVCBzaWduZWQgb2ZmIG9uIHRoaXMgY29t
bWl0LiAgWW91IGp1c3Qgc2FpZCB0aGF0IEkgbWFkZSBhIGxlZ2FsIHN0YXRlbWVudCBhYm91dCB0
aGlzIGNvbW1pdCB3aXRob3V0IHRoYXQgYWN0dWFsbHkgYmVpbmcgdHJ1ZT8/Pw0KPj4gPj4gPg0K
Pj4gPj4gPlNvcnJ5LCBidXQgdGhhdCBpcyBmbGF0IG91dCBub3QgYWNjZXB0YWJsZSBhdCBhbGwu
ICBQbGVhc2UgZ28gd29yayB3aXRoIHlvdXIgY29tcGFueSBsYXd5ZXJzIHRvIGZpZ3VyZSBvdXQg
d2hhdCB5b3UgZGlkIGFuZCBjb21lIGJhY2sgd2l0aCBhbiBleHBsYWluYXRpb24gb2YgZXhhY3Rs
eSB3aGF0IHRoaXMgaXMgYW5kIGhvdyBpdCB3aWxsIG5vdCBoYXBwZW4gYWdhaW4uDQo+PiA+PiA+
DQo+PiA+PiANCj4+ID4+ID4+IFNpZ25lZC1vZmYtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5keS5z
aGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4+ID4+ID4NCj4+ID4+ID4+IFY5IC0+IFYxMCA6IEFkZCBT
aWduZWQtb2ZmLWJ5IG9mIEdyZWcgS0ggYW5kIEFuZHkgU2hldmNoZW5rbywgDQo+PiA+PiA+PiBB
Y2tlZC1ieSBvZiBEYW5pZWwgVGhvbXBzb24NCj4+ID4+ID4NCj4+ID4+ID5IdWg/IQ0KPj4gPj4g
DQo+PiA+PiBAZ3JlZyBrLWgg77yaDQo+PiA+PiBAQW5keSBTaGV2Y2hlbmtvIO+8mg0KPj4gPj4g
DQo+PiA+PiBTb3JyeSwgaXQgd2FzIG15IG1pc3Rha2UuIEkgbWlzdW5kZXJzdG9vZCB0aGUgbWVh
bmluZyBvZiAic2lnbmVkLW9mZi1ieSIsIHdoaWNoIGxlZCB0byB1c2FnZSBpc3N1ZXMuDQo+PiA+
PiANCj4+ID4+IEkgd2FudCB0byBleHByZXNzIG15IGdyYXRpdHVkZSBmb3IgdGhlIHN1Z2dlc3Rp
b25zIG9uIHRoZSBwYXRjaCBmcm9tIHRoZSB0d28gb2YgeW91LiANCj4+ID4+IA0KPj4gPj4gV2hh
dCBkbyBJIG5lZWQgdG8gZG8gbm93PyBSZWxlYXNlIFBBVENIIFYxMSBhbmQgZGVsZXRlIHRoZXNl
IHR3byBzaWduYXR1cmVzIGluIGl0ID8NCj4+ID4NCj4+ID5BcyBJIHNhaWQsIGdvIHdvcmsgd2l0
aCB5b3VyIGNvcnBvcmF0ZSBsYXd5ZXJzIG9uIHRoaXMgdG8gdW5kZXJzdGFuZCB3aGF0IGp1c3Qg
aGFwcGVuZWQgYW5kIGhhdmUgdGhlbSBsZXQgdXMga25vdyBob3cgaXQgd2lsbCBub3QgaGFwcGVu
IGFnYWluLg0KPj4gDQo+PiBJJ20gdmVyeSBzb3JyeSwgdGhpcyBpcyBteSBmaXJzdCB0aW1lIHN1
Ym1pdHRpbmcgYSBwYXRjaCBhbmQgSSBtYWRlIGEgc2lnbmlmaWNhbnQgbWlzdGFrZSBpbiB1c2lu
ZyAiU2lnbmVkLW9mZi1ieSIuIEkgbm93IHVuZGVyc3RhbmQgdGhlIG1lYW5pbmcgb2YgdGhpcyBm
aWVsZCBhbmQgd2lsbCBub3QgbWFrZSB0aGUgc2FtZSBtaXN0YWtlIGFnYWluIGluIHRoZSBmdXR1
cmUuDQo+DQo+VW5kZXJzdG9vZCwgYnV0IHlvdSBzdGlsbCBuZWVkIHRvIGdvIHdvcmsgd2l0aCB5
b3VyIGNvcnBvcmF0ZSBsZWdhbCBncm91cCBzbyB0aGF0IHlvdSBhbGwgZW5zdXJlIHRoaXMgZG9l
cyBub3QgaGFwcGVuIGFnYWluIGZvciBhbnkgb3RoZXIgZGV2ZWxvcGVyIGluIHlvdXIgY29tcGFu
eSwgYXMgSSBhbSBzdXJlIHRoZXkgd2lsbCB3YW50IHRvIGtub3cgYWJvdXQgdGhpcy4NCg0KT2ss
IEkgd2lsbCByZXBvcnQgdGhpcyB0byB0aGUgY29tcGFueS4gQXQgdGhlIHNhbWUgdGltZSwgSSB3
aWxsIGFkZCBhbiBhdWRpdCBtZWNoYW5pc20gdG8gdGhlIHBhdGNoIHN1Ym1pc3Npb24gcHJvY2Vz
cy4gVGhhbmtzIGFnYWluIGZvciB5b3VyIHJlbWluZGVyLg0KDQpJIHdpbGwgcmVtb3ZlIHRoaXMg
cGFydCBpbiBQQVRDSCBWMTEuDQoNClRoYW5rc++8jA0KTGl1IFllDQo=

