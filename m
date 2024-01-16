Return-Path: <linux-kernel+bounces-27618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABFD82F30E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC921F233A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866631CAB6;
	Tue, 16 Jan 2024 17:16:20 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7826D1CA87
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705425380; cv=none; b=EoSsQYYExaVJkbjV67KulUNzmWyy7LLZov71ADKQysoXBHjVxrrQs48vLN0CDz59c3RoxoYuRA+aUv41ETCo7dcTnkCr2ASu6kLNM/VPUtbvuqBupz3IGJHp2W1IDJzG9HW4paQQ9zl6PNxNc9SrZ4ldCxxTweIQH/RlefZ2Auo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705425380; c=relaxed/simple;
	bh=j2Z4bIVnqoPG9LFw0AGpHv56gD99sl2dYSmB7eDu+WY=;
	h=Received:X-MC-Unique:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-exchange-transport-fromentityheader:x-originating-ip:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding; b=G2bSzrJb2Z8CCRYCYf95GPjBE3AGiQsDbrjTXbut3gBEIEzTT1AXu54x4hO63hF+BCZboLZ5C++UG4DtZpMvcz/k+26F23/n8rmGeYkLgPYkkR771Rm0ktu0JpSK53Ywh1CnQwCcuj8aPlzyZqj0PepflHDxAfeQBffDRLI4UC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-70-O4suwSxkO-eGETgMSyPNLQ-1; Tue, 16 Jan 2024 17:16:15 +0000
X-MC-Unique: O4suwSxkO-eGETgMSyPNLQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 16 Jan
 2024 17:15:56 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 16 Jan 2024 17:15:56 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Andrew Jones' <ajones@ventanamicro.com>, Xiao Wang
	<xiao.w.wang@intel.com>
CC: "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "conor.dooley@microchip.com"
	<conor.dooley@microchip.com>, "heiko@sntech.de" <heiko@sntech.de>,
	"haicheng.li@intel.com" <haicheng.li@intel.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] riscv: Optimize crc32 with Zbc extension
Thread-Topic: [PATCH] riscv: Optimize crc32 with Zbc extension
Thread-Index: AQHaSI1C2Wp5kEQM1k+UoNSZlBGjlrDcqukw
Date: Tue, 16 Jan 2024 17:15:56 +0000
Message-ID: <1153d2dd82cf43adb6062627d8d89b27@AcuMS.aculab.com>
References: <20240105080830.3738117-1-xiao.w.wang@intel.com>
 <20240116-9f09b002afc2337ab5e41e3f@orel>
In-Reply-To: <20240116-9f09b002afc2337ab5e41e3f@orel>
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

..
> > +static inline u32 __pure crc32_le_generic(u32 crc, unsigned char const=
 *p,
> > +#if (BITS_PER_LONG =3D=3D 64)
> > +=09=09=09=09=09  size_t len, u32 poly, u64 poly_qt,
> > +#else
> > +=09=09=09=09=09  size_t len, u32 poly, u32 poly_qt,
> > +#endif
>=20
> How about creating a new type for poly_qt, defined as u64 for xlen=3D64
> and u32 for xlen=3D32 to avoid the #ifdef?

unsigned long ?

..
> > +=09for (int i =3D 0; i < len; i++) {
> > +#if (BITS_PER_LONG =3D=3D 64)
> > +=09=09s =3D (unsigned long)crc << 32;
> > +=09=09s ^=3D __cpu_to_be64(*p_ul++);
> > +#else
> > +=09=09s =3D crc ^ __cpu_to_be32(*p_ul++);
> > +#endif
>=20
> Could write the above without #ifdef with

Haven't I seen a bpf patch that rather implies that byteswap
is likely to be truly horrid?

I've not tried to parse the crc code (although I do understand
how it should work). But I'm surprised you need a byteswap.

After all, the crc is basically a long division of the buffer
by the crc constant.

The CRC I've done recently is the hdlc crc-16.
My nios version (also mips-like) has:

static __inline__ uint32_t
crc_step(uint32_t crc, uint32_t byte_val)
{
#if defined(crc_step_ci)
    return crc_step_ci(byte_val, crc);
#else
    uint32_t t =3D crc ^ (byte_val & 0xff);
    t =3D (t ^ t << 4) & 0xff;
    return crc >> 8 ^ t << 8 ^ t << 3 ^ t >> 4;
#endif
}

I normally use a custom instruction for the logic - one clock.
But the C code is only a couple of clocks slower that the best
table lookup version.
On anything pipelined and multi-issue the C code is likely to
be faster than a lookup table!
I don't know if any of the 32bit crc can be reduced the same way.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


