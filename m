Return-Path: <linux-kernel+bounces-137963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB1A89EA73
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A65D2877EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B06B20B2E;
	Wed, 10 Apr 2024 06:11:30 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB428F0;
	Wed, 10 Apr 2024 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729490; cv=none; b=Wbi3RWbp8lEDPyXdc93a8QnzkBmiJtfZxedDMY9/tVK0jIwErdxuzQlyidvnKJxgJTUs9zLrpPst3eE2q3ELw56Hp8cmYpnzuS/QCtKhYM0TF8yj4fHuDYinDbOBND+boEm0WtPuXFDrQLzi9hXkILSAdj64Sy13Ys7Kx9qlfLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729490; c=relaxed/simple;
	bh=pUwUVEB5nJCdcq7xQJGKXu20SVViDzFPOHwvow6ztcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n6bLFcUdCSo+JkBfkBD3Xfk4daLqyp4iWgQRX+pznbYV2QCSS63CGy7GD9hnCFHR4tFEfLm9033JQxp7ncSCcdgWM2Ai/CSrJE+N+jQ8ZPun8uLROAer5wQBT1i5jpIxwYSWECgcTBR/EcBjDDPBrblX8NJh0Et6KuBDOPLGRbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 43A6A82D070683;
	Wed, 10 Apr 2024 14:10:08 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (unknown [10.62.14.11])
	by mail.maildlp.com (Postfix) with ESMTP id 90AF92004BA6;
	Wed, 10 Apr 2024 14:12:18 +0800 (CST)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) by
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 10 Apr 2024 14:10:10 +0800
Received: from DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4])
 by DAG6EX02-IMDC.srv.huawei-3com.com ([fe80::4c21:7c89:4f9d:e4c4%16]) with
 mapi id 15.02.1258.027; Wed, 10 Apr 2024 14:10:10 +0800
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
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCBWMTBdIGtkYjogRml4IHRoZSBkZWFk?=
 =?utf-8?Q?lock_issue_in_KDB_debugging.?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0ggVjEwXSBrZGI6IEZpeCB0aGUgZGVhZGxvY2sgaXNz?=
 =?utf-8?Q?ue_in_KDB_debugging.?=
Thread-Index: AQHaiuuw81gSSyk26Eq+v/7KfdTz2LFgdGkAgACJimD//36cAIAAh7Hw
Date: Wed, 10 Apr 2024 06:10:10 +0000
Message-ID: <5c659d5f41ff4cf69ea9467b62d74e9b@h3c.com>
References: <20240409020326.2125332-1-liu.yec@h3c.com>
 <20240410020615.2885000-1-liu.yec@h3c.com>
 <2024041014-padlock-aggregate-4705@gregkh>
 <0c004dd44ad5478eba9451186f4ec962@h3c.com>
 <2024041001-retaliate-cork-1fe5@gregkh>
In-Reply-To: <2024041001-retaliate-cork-1fe5@gregkh>
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
X-MAIL:h3cspam02-ex.h3c.com 43A6A82D070683

Pk9uIFdlZCwgQXByIDEwLCAyMDI0IGF0IDA1OjU0OjA4QU0gKzAwMDAsIExpdXllIHdyb3RlOg0K
Pj4gPj4gU2lnbmVkLW9mZi1ieTogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+
DQo+PiA+DQo+PiA+SSBoYXZlIE5PVCBzaWduZWQgb2ZmIG9uIHRoaXMgY29tbWl0LiAgWW91IGp1
c3Qgc2FpZCB0aGF0IEkgbWFkZSBhIGxlZ2FsIHN0YXRlbWVudCBhYm91dCB0aGlzIGNvbW1pdCB3
aXRob3V0IHRoYXQgYWN0dWFsbHkgYmVpbmcgdHJ1ZT8/Pw0KPj4gPg0KPj4gPlNvcnJ5LCBidXQg
dGhhdCBpcyBmbGF0IG91dCBub3QgYWNjZXB0YWJsZSBhdCBhbGwuICBQbGVhc2UgZ28gd29yayB3
aXRoIHlvdXIgY29tcGFueSBsYXd5ZXJzIHRvIGZpZ3VyZSBvdXQgd2hhdCB5b3UgZGlkIGFuZCBj
b21lIGJhY2sgd2l0aCBhbiBleHBsYWluYXRpb24gb2YgZXhhY3RseSB3aGF0IHRoaXMgaXMgYW5k
IGhvdyBpdCB3aWxsIG5vdCBoYXBwZW4gYWdhaW4uDQo+PiA+DQo+PiANCj4+ID4+IFNpZ25lZC1v
ZmYtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj4+ID4N
Cj4+ID4+IFY5IC0+IFYxMCA6IEFkZCBTaWduZWQtb2ZmLWJ5IG9mIEdyZWcgS0ggYW5kIEFuZHkg
U2hldmNoZW5rbywgDQo+PiA+PiBBY2tlZC1ieSBvZiBEYW5pZWwgVGhvbXBzb24NCj4+ID4NCj4+
ID5IdWg/IQ0KPj4gDQo+PiBAZ3JlZyBrLWgg77yaDQo+PiBAQW5keSBTaGV2Y2hlbmtvIO+8mg0K
Pj4gDQo+PiBTb3JyeSwgaXQgd2FzIG15IG1pc3Rha2UuIEkgbWlzdW5kZXJzdG9vZCB0aGUgbWVh
bmluZyBvZiAic2lnbmVkLW9mZi1ieSIsIHdoaWNoIGxlZCB0byB1c2FnZSBpc3N1ZXMuDQo+PiAN
Cj4+IEkgd2FudCB0byBleHByZXNzIG15IGdyYXRpdHVkZSBmb3IgdGhlIHN1Z2dlc3Rpb25zIG9u
IHRoZSBwYXRjaCBmcm9tIHRoZSB0d28gb2YgeW91LiANCj4+IA0KPj4gV2hhdCBkbyBJIG5lZWQg
dG8gZG8gbm93PyBSZWxlYXNlIFBBVENIIFYxMSBhbmQgZGVsZXRlIHRoZXNlIHR3byBzaWduYXR1
cmVzIGluIGl0ID8NCj4NCj5BcyBJIHNhaWQsIGdvIHdvcmsgd2l0aCB5b3VyIGNvcnBvcmF0ZSBs
YXd5ZXJzIG9uIHRoaXMgdG8gdW5kZXJzdGFuZCB3aGF0IGp1c3QgaGFwcGVuZWQgYW5kIGhhdmUg
dGhlbSBsZXQgdXMga25vdyBob3cgaXQgd2lsbCBub3QgaGFwcGVuIGFnYWluLg0KDQpJJ20gdmVy
eSBzb3JyeSwgdGhpcyBpcyBteSBmaXJzdCB0aW1lIHN1Ym1pdHRpbmcgYSBwYXRjaCBhbmQgSSBt
YWRlIGEgc2lnbmlmaWNhbnQgbWlzdGFrZSBpbiB1c2luZyAiU2lnbmVkLW9mZi1ieSIuIEkgbm93
IHVuZGVyc3RhbmQgdGhlIG1lYW5pbmcgb2YgdGhpcyBmaWVsZCBhbmQgd2lsbCBub3QgbWFrZSB0
aGUgc2FtZSBtaXN0YWtlIGFnYWluIGluIHRoZSBmdXR1cmUuDQoNClRoYW5rc++8jA0KTGl1IFll
DQo=

