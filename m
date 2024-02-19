Return-Path: <linux-kernel+bounces-72047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5852085AE37
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E24B20F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0EB55E4F;
	Mon, 19 Feb 2024 22:13:47 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DBB55E43
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708380827; cv=none; b=skD9LZ4NKrV7w00ON3qH2RROaADZtpmY0+CYZDztUlO3k5VO3cRBSo4lE5/7nQlHNZ08ETH4/JyID7qwrvjqR2+2MZLXBfa7QhpBOUZpKKmSbjqiDGhKpTrpECQqC/gEfvhTLsgMjH4dhuuY1CCbI3Q4Vyems6slGq+zC4ITows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708380827; c=relaxed/simple;
	bh=HqMn80djPQUIYTF5ICDwnrR7AbzqadPjX6f4LJwG6hk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=s2lsBkRCpXWPkHVVoDEuZgVKd1DyxkBd2GWJc0c2CPoD/q4LyT3Me0imT2HruepmaIh/OD1x0mFWL9UM6qJoxQDzyIil6BskcCjBAA9ErLhLZrb1etz6ZAe5RxU7+8d8BkHdNgrHGECINj9adpSnf7g4BL/y93akMFswOvcmKWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-265-m_PGMIMlN6iHaxBJ_AyIiw-1; Mon, 19 Feb 2024 22:13:41 +0000
X-MC-Unique: m_PGMIMlN6iHaxBJ_AyIiw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 19 Feb
 2024 22:13:40 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 19 Feb 2024 22:13:40 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: =?utf-8?B?J0Jqw7ZybiBUw7ZwZWwn?= <bjorn@kernel.org>, Samuel Holland
	<samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Samuel Holland
	<samuel.holland@sifive.com>
Subject: RE: [PATCH 4/7] riscv: Simplify text patching loops
Thread-Topic: [PATCH 4/7] riscv: Simplify text patching loops
Thread-Index: AQHaYzROWznNq41EbUSlVTL0RNzcK7ESOwDw
Date: Mon, 19 Feb 2024 22:13:40 +0000
Message-ID: <cb89b03b34d6403685297f95924524a7@AcuMS.aculab.com>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
 <20240212025529.1971876-5-samuel.holland@sifive.com>
 <874je4fvxl.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <874je4fvxl.fsf@all.your.base.are.belong.to.us>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

Li4uDQo+ID4gLQl3aGlsZSAocGF0Y2hlZCA8IGxlbiAmJiAhcmV0KSB7DQo+ID4gLQkJc2l6ZSA9
IG1pbl90KHNpemVfdCwgUEFHRV9TSVpFICogMiAtIG9mZnNldF9pbl9wYWdlKGFkZHIgKyBwYXRj
aGVkKSwgbGVuIC0gcGF0Y2hlZCk7DQo+ID4gLQkJcmV0ID0gX19wYXRjaF9pbnNuX3NldChhZGRy
ICsgcGF0Y2hlZCwgYywgc2l6ZSk7DQo+ID4gKwl3aGlsZSAobGVuICYmICFyZXQpIHsNCj4gPiAr
CQlzaXplID0gbWluX3Qoc2l6ZV90LCBQQUdFX1NJWkUgKiAyIC0gb2Zmc2V0X2luX3BhZ2UoYWRk
ciksIGxlbik7DQoNCkRvZXMgdGhhdCBuZWVkIHRvIGJlIG1pbl90KCk/DQpCb3RoIGFyZ3VtZW50
cyBzZWVtIHRvIGJlIHVuc2lnbmVkLg0KKERpZCBpdCBldmVuIGV2ZXIgbmVlZCB0byBiZT8pDQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=


