Return-Path: <linux-kernel+bounces-29514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF44830F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A90289193
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958D41E887;
	Wed, 17 Jan 2024 22:49:04 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7191E87D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531744; cv=none; b=CVBx4qAAbHCX6sUHQn96B9NM9vFtUeUpTJTMdU2ZhMaL+zUPgSKs8cm41XTFu+NpMcw6sb11wCk9aD70R89Q88EYTuByZLgWsnWVN2o0RYyrqzSffk4wH3iYL+x6cgpMZehyPYUNokKEN1v7MoY9A3AWyd5z51K/punPY2YjOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531744; c=relaxed/simple;
	bh=BUcf8xHpEIiBvl8cLb2c21ckzGB5onz3r6wFRqc2vIk=;
	h=Received:X-MC-Unique:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-exchange-transport-fromentityheader:x-originating-ip:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding; b=q/dkHkaMiewl386DAm6q+vnJi0GQ93qVlZ6LfJfMv5r76VobDTrcqBpB3YKFHlp3VnPvXDGzE+g+XDU4JQ/Qso80hBuoCx+vjZWbRzb9D83igeihLLT27V7MTz3qWO4L/IIJb14a7zmrAYwzLrQ05nsrp8w/TCWCr4T7jf3RMFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-143-tHS3zxe8MH66648R1lNVPg-1; Wed, 17 Jan 2024 22:47:32 +0000
X-MC-Unique: tHS3zxe8MH66648R1lNVPg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jan
 2024 22:47:16 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 17 Jan 2024 22:47:16 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Arnd Bergmann
	<arnd@arndb.de>
CC: "Theodore Y. Ts'o" <tytso@mit.edu>, "'adilger.kernel@dilger.ca'"
	<adilger.kernel@dilger.ca>
Subject: Subject: [PATCH next] ext4: super: Use clamp() instead of clamp_val()
 to bound timestamps
Thread-Topic: Subject: [PATCH next] ext4: super: Use clamp() instead of
 clamp_val() to bound timestamps
Thread-Index: AdpJlv7FNtWwV0cSQNCCM5QNS6v7lg==
Date: Wed, 17 Jan 2024 22:47:16 +0000
Message-ID: <364a2f251cab4b2fbd43c661d51fcdd5@AcuMS.aculab.com>
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

Commit 6a0678a79bb3a extended the superblock timestamps to 40 bits.
The time64_t (signed 64bit) was bounded using:
=09now =3D clamp_val(now, 0, (1ull << 40) - 1);
which is equivalent to:
=09now =3D clamp(now, (typeof(now))0, (typeof(now))((1ull << 40) - 1));
However clamp_val() is an 'accident waiting to happen' because it
is very easy to specify bounds that get masked by the cast.
The current clamp() only requires the three values to have the same
signedness - not the same types.
So changing the upper limit to a signed value allows clamp() be used.

This is the only place in the kernel I build where replacing clamp_val()
with clamp() generates a compile-time error.

This is a similar 'problem' to code like:
=09unsigned int val =3D ...
=09u8 bounded =3D min_t(u8, val, 255);
which is surprisingly common and has been a real bug.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0980845c8b8f..714d51a1667b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -425,7 +425,7 @@ void ext4_itable_unused_set(struct super_block *sb,
=20
 static void __ext4_update_tstamp(__le32 *lo, __u8 *hi, time64_t now)
 {
-=09now =3D clamp_val(now, 0, (1ull << 40) - 1);
+=09now =3D clamp(now, 0, (1ll << 40) - 1);
=20
 =09*lo =3D cpu_to_le32(lower_32_bits(now));
 =09*hi =3D upper_32_bits(now);
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


