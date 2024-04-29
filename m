Return-Path: <linux-kernel+bounces-161975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925F68B540F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6411B214EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD32B28373;
	Mon, 29 Apr 2024 09:14:54 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E0224EA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382094; cv=none; b=m6RP4160ajSGRwNCnoavgEQpdHRu7/st5Yga9qXsBRjZWyOBUe6R0n0xilnAElyml9GAFcPXFzSLn4l3KDsZ/LQuQdA4E3PIo3taXiYBGQIxL35bv6HRtJguvSHupjzKqIFpNrc3ooWhBQNaVlaBBdUhH5zBhAfycn9ECPqcnk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382094; c=relaxed/simple;
	bh=TwIt8dL4+4FciE3Jbqznx0mwOtJY9K54EjWjrWQb+TQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=TSUJwPNSPXvcQma9bj5jLw44jEuXtCiLeRRzmIPdh3EHg3t+x6RuJ7qSL3pl3TInUx/cnlefxm77/3cOrvLrHQRaIROBJEgqteM9om1D0YUnLi4WtnCymOeWDN1wqVg+F0k6rp5l16TJhgu76X3r/WLvBkZKbihrXw5ckFyMNHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-83-8-pfOq6XNPGGCsa-FnWE_A-1; Mon, 29 Apr 2024 10:14:43 +0100
X-MC-Unique: 8-pfOq6XNPGGCsa-FnWE_A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 29 Apr
 2024 10:14:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 29 Apr 2024 10:14:06 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jiri Slaby' <jirislaby@kernel.org>, Hugo Villeneuve <hugo@hugovil.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Ringle
	<jringle@gridpoint.com>
CC: "ria.freelander@gmail.com" <ria.freelander@gmail.com>, Hugo Villeneuve
	<hvilleneuve@dimonoff.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>
Subject: RE: [PATCH] serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when
 using prescaler
Thread-Topic: [PATCH] serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when
 using prescaler
Thread-Index: AQHamf/sWZGWHPbUOU+NpCCP8YCCu7F+9eqA
Date: Mon, 29 Apr 2024 09:14:06 +0000
Message-ID: <6ea689ace38d47f285efe026772efcae@AcuMS.aculab.com>
References: <20240426135937.3810959-1-hugo@hugovil.com>
 <17d2cc58-cf68-430d-9248-25abe4c5b0f0@kernel.org>
In-Reply-To: <17d2cc58-cf68-430d-9248-25abe4c5b0f0@kernel.org>
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

RnJvbTogSmlyaSBTbGFieQ0KPiBTZW50OiAyOSBBcHJpbCAyMDI0IDA3OjM5DQouLi4NCj4gPiAt
CXU4IHByZXNjYWxlciA9IDA7DQo+ID4gKwlpbnQgcHJlc2NhbGVyID0gMTsNCj4gDQo+IFVnaCwg
d2h5IGRvIHlvdSBtb3ZlIHRvIHNpZ25lZCBhcml0aG1ldGljcz8NCg0KQW55IGFyaXRobWV0aWMg
d291bGQgYWx3YXlzIGhhdmUgYmVlbiBzaWduZWQuDQp1OCBpcyBwcm9tb3RlZCB0byAnc2lnbmVk
IGludCcgYmVmb3JlIGJlaW5nIHVzZWQgZm9yIHByZXR0eSBtdWNoIGFueXRoaW5nLg0KDQondW5z
aWduZWQgaW50IHByZXNjYWxlcicgbWlnaHQgaGF2ZSBjaGFuZ2VkIGFyaXRobWV0aWMgdG8gYmUg
dW5zaWduZWQuDQoNCk9UT0ggeW91IHByb2JhYmx5IGRvbid0IHdhbnQgYSB1OCAtIHRoYXQgbWln
aHQgcmVxdWlyZSB0aGUgY29tcGlsZXINCm1hc2sgYW4gYXJpdGhtZXRpYyByZXN1bHQgdG8gOCBi
aXRzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0K


