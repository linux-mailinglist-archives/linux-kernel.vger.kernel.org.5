Return-Path: <linux-kernel+bounces-70111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BA6859332
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 23:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44412826A9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADB57E59E;
	Sat, 17 Feb 2024 22:48:07 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770501CF96
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708210087; cv=none; b=fETC1dJeb0Fd/IFwQX1IPD3plNjmyQ7b2aGeQVF5C60gTnQq49ugAZxBKuOzLNeiREKWp/sKt/lpfTpItpR3+UCo8wBuRe6tOxmg8RfVKUxan4RgFLOeNoxBQ423ydhPy4LSQhdatLbzkGc4wQCceccNfTxsj7HRWfwSz7MFRVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708210087; c=relaxed/simple;
	bh=Oxo9xfWWrylqVF9wdIJ15x+712dCbCjyWGNGN7jK96E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Ysub0lt0MSBBYQswqUTju+qrIrdQYC1Ul4sw7BZEdFdjqcSG/b/cBUBeMw5trdlI7Y+Ydq53/f54scwy2sjnkP8GQYi8cXHZcE/smvKWiBn6/e9Ga6/ZlpHvEOITSJxBfD8QBlAN1Bl8x5iPt1AWuIHKVLBKEmh40pK3qlk5C58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-200-m7FAOtyeN7C0BBLLhnGudQ-1; Sat, 17 Feb 2024 22:47:54 +0000
X-MC-Unique: m7FAOtyeN7C0BBLLhnGudQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 17 Feb
 2024 22:47:31 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 17 Feb 2024 22:47:31 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Charlie Jenkins' <charlie@rivosinc.com>, Helge Deller <deller@kernel.org>
CC: Guenter Roeck <linux@roeck-us.net>, Helge Deller <deller@gmx.de>, "James E
 . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer Dabbelt
	<palmer@rivosinc.com>
Subject: RE: [PATCH] parisc: Fix csum_ipv6_magic on 64-bit systems
Thread-Topic: [PATCH] parisc: Fix csum_ipv6_magic on 64-bit systems
Thread-Index: AQHaYU1uf9SPNwTrtE2tFbsnOFUZorEPGrIQ
Date: Sat, 17 Feb 2024 22:47:31 +0000
Message-ID: <8c5a811655004999ba187e69fe2d5fbf@AcuMS.aculab.com>
References: <20240213234631.940055-1-linux@roeck-us.net>
 <Zc9XW-TxQKp84vMt@p100> <ZdAhQHFXUF7wEWea@ghost>
In-Reply-To: <ZdAhQHFXUF7wEWea@ghost>
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
> We can do better than this! By inspection this looks like a performance
> regression. The generic version of csum_fold in
> include/asm-generic/checksum.h is better than this so should be used
> instead.

Yes, that got changed for 6.8-rc1 (I pretty much suggested the patch)
but hadn't noticed Linus has applied it.
That C version is (probably) not worse than any of the asm versions
except sparc32 - which has a carry flag but rotate.
(It is better than the x86-64 asm one.)

..
> This doesn't leverage add with carry well. This causes the code size of t=
his
> to be dramatically larger than the original assembly, which I assume
> nicely correlates to an increased execution time.

It is pretty much impossible to do add with carry from C.
So an asm adc block is pretty much always going to win.

For csum_partial and short to moderate length buffers
on x86 it is hard to beat 10: adc, adc, dec, jnz 10b
which (on modern intel cpu at least) does 8 bytes/clock.
You can get 12 bytes/clock but it only really wins for 256+ bytes.
(See the current x86-64 version.)

For cpu without a carry flag it is likely that a common C
function will be pretty much optimal on all architectures.
(Or maybe a couple of implementations based the actual
cpu implementation - not the architecture.)

Mostly I don't think you can beat 4 instructions/word, but they
will pipeline so with multi-issue you might get a read/clock.=20
Arm's barrel shifter might give 3: v + *p; x +=3D v, y +=3D v >> 32.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


