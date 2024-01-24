Return-Path: <linux-kernel+bounces-37190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E4A83AC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE7E1F216EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8D47C099;
	Wed, 24 Jan 2024 14:36:14 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC957C085
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106974; cv=none; b=vAKKc4SqFZpJumgeNY6/tgM6ZM5pk56vgh8ep9vJBZ3D3f94QX4fe3fqwDawALDkyfl3EgEuIIMYVkNww16hqPTYksKiIgJXtwkha59pI9E/IOozdR9U8pvJPPaz5eIvcPqp85lXwURTxeQR38k9wnelh87/vqG6WxM5YkX+q8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106974; c=relaxed/simple;
	bh=CtLoXwiHmVTFLWHjVNE+rTCwxWvFIc7mKFFlsDnEr7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=cRMGKOaZC7BRFgoU53BOYsZ0JID2Q5CGqFluyOEOoziS6Fqz0+/1MZj/2XKP0/AOm0V7ikQ1oiF2MCUvYHqg2eKnlp7RqvdKx5VtDAqLSdl80KViKPHgVPePi8DNx9LnIfyMUQvNzG1fHqZ+7XKp4DV25lnDT+DYjX3aV/8wLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-222-J1pcMmz5MSWud34OfGsxZQ-1; Wed, 24 Jan 2024 14:36:04 +0000
X-MC-Unique: J1pcMmz5MSWud34OfGsxZQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Jan
 2024 14:35:45 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 Jan 2024 14:35:45 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jonas Gorski' <jonas.gorski@gmail.com>, Guenter Roeck
	<linux@roeck-us.net>
CC: Mark Brown <broonie@kernel.org>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>, "Amit
 Kumar Mahapatra" <amit.kumar-mahapatra@amd.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>
Subject: RE: [PATCH] spi: Raise limit on number of chip selects
Thread-Topic: [PATCH] spi: Raise limit on number of chip selects
Thread-Index: AQHaTsr+Wx04Q9P7EECylvQrgvsjlLDpB40A
Date: Wed, 24 Jan 2024 14:35:45 +0000
Message-ID: <7cadfe452f614e92be81d01111203a54@AcuMS.aculab.com>
References: <20240122-spi-multi-cs-max-v1-1-a7e98cd5f6c7@kernel.org>
 <20240123120430.75c7ace0@bootlin.com>
 <cefafa30-b78d-471b-83e0-b05060d806d4@sirena.org.uk>
 <93385fc2-7596-4f66-b0c1-07d7d5c9ed8d@csgroup.eu>
 <49b52941-6205-48bd-b2ae-e334018ac5cd@sirena.org.uk>
 <CAOiHx==FzSyyqP3NzLTeOSVxUQYy3ZhypZrDLsc-OjGCdSzvUA@mail.gmail.com>
 <801eecbe-4bf9-4bb8-9de0-1a7ca6673ddf@roeck-us.net>
 <CAOiHx=mM7kpzR-MOshsgXZM+CSB0nawfWxMhpt=tuhmJyMTCzQ@mail.gmail.com>
In-Reply-To: <CAOiHx=mM7kpzR-MOshsgXZM+CSB0nawfWxMhpt=tuhmJyMTCzQ@mail.gmail.com>
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

Li4uDQo+IEZvciBzb21lIHJlYXNvbiB3ZSBkb24ndCBzdG9yZSBuZWl0aGVyIHRoZSBhY3R1YWwg
bnVtYmVyIG9mIHN1cHBvcnRlZA0KPiBwYXJhbGxlbCBjaGlwc2VsZWN0cyBpbiB0aGUgY29udHJv
bGxlciwgbm9yIHRoZSBhbW91bnQgb2YgY2hpcHNlbGVjdHMNCj4gdXNlZCBieSB0aGUgc3BpIGRl
dmljZSwgc28gYWxsIGxvb3BzIGFsd2F5cyAgbmVlZCB0byBpdGVyYXRlDQo+IFNQSV9DU19DTlRf
TUFYIHRpbWVzIGFuZCBjaGVjayBmb3IgdGhlIGNoaXBzZWxlY3QgbnVtYmVycyBub3QgYmVpbmcN
Cj4gMHhmZiBpbnN0ZWFkIG9mIGxpbWl0aW5nIGJ5IHRoZSAocG9zc2libGUgdG8ga25vdykgYWN0
dWFsIG51bWJlciBvZg0KPiBjaGlwIHNlbGVjdHMgaW4gdXNlLg0KDQpPciBldmVuIHRoZSBoaWdo
ZXN0IG9uZSBldmVyIHVzZWQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFr
ZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwg
VUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


