Return-Path: <linux-kernel+bounces-57785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8332484DD69
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35691C24A00
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0A16D1A0;
	Thu,  8 Feb 2024 09:55:13 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BC36BFDC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386112; cv=none; b=UJubNJN9np72ya+4mZkbhUPyecGDbaUkH9j7GxOt6F8LzMZrmCDucgRGRIZMjfy8kQLgqMLLd2ZWpx5mXjX05B4ylCoW6UfGB+fZVrMIlNgmIVXQrCtP1vNP4cnoC6YcQYGX2Fvfq8d/hkpYXme92ouqesEB7+2WrZ1f5bOfWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386112; c=relaxed/simple;
	bh=A5u3bJpWdZ5zza7OgZpzC7vZ3+2py5aXPKSGlD4Yvac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=t6CYoFjcy1ykV9nAH5o23PmLxCh5Vd8Tsh7epAkqtrvf9j/jXQWvg+mJtlTy3CHSIUIcf6pG8eX2vAsnhBPlMukCSTnxEBEqSV4/L2oSrzbvri5F1DtwS+Z9UFlNJkw2idOHX/C5NcHyCiaZAtLpkyjTCRqZfPX28m/ynTmzzVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-152-XpH53RNmNBOBYoAZQ70Org-1; Thu, 08 Feb 2024 09:54:59 +0000
X-MC-Unique: XpH53RNmNBOBYoAZQ70Org-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 8 Feb
 2024 09:54:39 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 8 Feb 2024 09:54:39 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Charlie Jenkins' <charlie@rivosinc.com>, Guenter Roeck
	<linux@roeck-us.net>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Thread-Topic: [PATCH v5 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Thread-Index: AQHaWiTi9Vrw8P9Q6kGXDnUtGZ/kaLEAM1Og
Date: Thu, 8 Feb 2024 09:54:39 +0000
Message-ID: <0b78e69bf4ef4e52a61ffe21d2c08c96@AcuMS.aculab.com>
References: <20240130-fix_sparse_errors_checksum_tests-v5-0-4d8a0a337e5e@rivosinc.com>
 <20240130-fix_sparse_errors_checksum_tests-v5-2-4d8a0a337e5e@rivosinc.com>
 <ec44bf32-8b66-40c4-bc62-4deed3702f99@roeck-us.net> <ZcQeyigDWwvnc4Nu@ghost>
In-Reply-To: <ZcQeyigDWwvnc4Nu@ghost>
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

From: Charlie Jenkins
> Sent: 08 February 2024 00:23
>=20
> On Sun, Feb 04, 2024 at 09:41:56AM -0800, Guenter Roeck wrote:
> > Hi,
> >
> > On Tue, Jan 30, 2024 at 11:10:04AM -0800, Charlie Jenkins wrote:
> > > The test cases for ip_fast_csum and csum_ipv6_magic were using arbitr=
ary
> > > alignment of data to iterate through random inputs. ip_fast_csum shou=
ld
> > > have the data aligned along (14 + NET_IP_ALIGN) bytes and
> > > csum_ipv6_magic should have data aligned along 32-bit boundaries.
> > >
> > >
..
> >
> > So this works on little endian systems. Unfortunately, I still get
> >
..
> >
> > when running the test on big endian systems such as hppa/parisc or spar=
c.
>=20
> Hmm okay it was easy to get this to work on big endian for
> test_ip_fast_csum but test_csum_ipv6_magic was trickier. I will send out
> a new version with the changes.

Instead of trying to save the expected results why not just
calculate them with a 'really dumb' implementation.
(eg: Add 16bit items and then fold.)

For the generic tests, IIRC:
Your test vectors looked random.
They should probably contain some very specific tests cases.
eg:
- Zero length and all zeros - checksum should be zero (not 0xffff).
- Buffers where the final 'fold' needs the carry added in.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


