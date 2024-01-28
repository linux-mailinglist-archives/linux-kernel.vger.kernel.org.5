Return-Path: <linux-kernel+bounces-41625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C0483F587
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA961F21B2A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E9F23761;
	Sun, 28 Jan 2024 12:47:29 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1CA23748
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706446048; cv=none; b=fEzYiKeug6y9CsCTFg41KUYzFs0tdo9dd5IBSPylqiOS9DoKd1ZkaQWvRuHgEMEDMzIasyJRY37NrMnDgktJQHBCDRY5jFUw+wciLpnGS+sYV2qq4TG4l+pShNoNOelCd/GUa6fmvlkJfVz3gh9kBmE+K7D4gV+MfATcZQJ3w4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706446048; c=relaxed/simple;
	bh=5YeFWB1hS7eap1X9wa8CghCchvUOxczPLoTC1AWLJjI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=EP51Ez329BPEnWtfaLZnW7hP+jCSG+FbdyymjOtVQjzvPVrc3oHvRN2uif7u84ySkvYHcqbefVuwfIVOOfIKgrhBgoAhQIyDW40b/TXEvo4eQvCBAFyYOIOqbR7t2pdbjzWMfh/rpxmMWgZdc736W4AF9BPkbwPQXy/kq+ZYydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-192-sDnoWcOHNe-yKChU7lXVCg-1; Sun, 28 Jan 2024 12:47:23 +0000
X-MC-Unique: sDnoWcOHNe-yKChU7lXVCg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 12:47:00 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jan 2024 12:47:00 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jisheng Zhang' <jszhang@kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matteo Croce
	<mcroce@microsoft.com>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH 2/3] riscv: optimized memmove
Thread-Topic: [PATCH 2/3] riscv: optimized memmove
Thread-Index: AQHaUdxjAvIJPrdYsUmtWfJZGIT/drDvKbzw
Date: Sun, 28 Jan 2024 12:47:00 +0000
Message-ID: <59bed43df37b4361a8a1cb31b8582e9b@AcuMS.aculab.com>
References: <20240128111013.2450-1-jszhang@kernel.org>
 <20240128111013.2450-3-jszhang@kernel.org>
In-Reply-To: <20240128111013.2450-3-jszhang@kernel.org>
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
Content-Transfer-Encoding: quoted-printable

From: Jisheng Zhang
> Sent: 28 January 2024 11:10
>=20
> When the destination buffer is before the source one, or when the
> buffers doesn't overlap, it's safe to use memcpy() instead, which is
> optimized to use a bigger data size possible.
>=20
..
> + * Simply check if the buffer overlaps an call memcpy() in case,
> + * otherwise do a simple one byte at time backward copy.

I'd at least do a 64bit copy loop if the addresses are aligned.

Thinks a bit more....

Put the copy 64 bytes code (the body of the memcpy() loop)
into it an inline function and call it with increasing addresses
in memcpy() are decrementing addresses in memmove.

So memcpy() contains:
=09src_lim =3D src_lim + count;
=09... alignment copy
=09for (; src + 64 <=3D src_lim; src +=3D 64; dest +=3D 64)
=09=09copy_64_bytes(dest, src);
=09... tail copy

Then you can do something very similar for backwards copies.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


