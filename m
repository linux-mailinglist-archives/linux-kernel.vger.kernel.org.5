Return-Path: <linux-kernel+bounces-110060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF985885978
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4C9282419
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BEA83CCD;
	Thu, 21 Mar 2024 12:57:38 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEFB1CA83
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025858; cv=none; b=bN8C1N+Rm4Ly9Xio2mbGoc6fH2Ze4j8uCz2W0PfN9JB61pONW9sA2oZS7rCQoSpFIa9sPE2BtZi32Ah/4ehz/8pKxAOkzi2I7IAL89yyZZ0cgLwzcguiEWanX6wRKs2M6JVTU8K+Rp9shelpn0HW8tQm78oBpHjudIusbSl4GOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025858; c=relaxed/simple;
	bh=Ugs/LBHQ17TVRz8+/1tX85sJb3QOcQv7xVKlpf6dBWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=C3B7dG+HB/hriZy8KBv8bL05YEA5IB+LDbhB9jx/lkyRy8ND9m/mVLZ2bCBfPvv7Ac9rxdgBXTG2Y9ZJvlDCJwO3z1/8PNIWDfB7TI44vcsGe1IT+/7CumZBlQ9RMLz+LHAWVQ0ZECONWj88+f7wkOhqvnCHb2JaZRki4+7LNPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-199-xgFlFvyBPmuyMshxla-1pg-1; Thu, 21 Mar 2024 12:57:33 +0000
X-MC-Unique: xgFlFvyBPmuyMshxla-1pg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 21 Mar
 2024 12:57:07 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 21 Mar 2024 12:57:07 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Russell King' <linux@armlinux.org.uk>
CC: Ard Biesheuvel <ardb@kernel.org>, 'Jiangfeng Xiao'
	<xiaojiangfeng@huawei.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"keescook@chromium.org" <keescook@chromium.org>, "haibo.li@mediatek.com"
	<haibo.li@mediatek.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "amergnat@baylibre.com"
	<amergnat@baylibre.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "douzhaolei@huawei.com"
	<douzhaolei@huawei.com>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "kepler.chenxin@huawei.com"
	<kepler.chenxin@huawei.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "nixiaoming@huawei.com"
	<nixiaoming@huawei.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"wangbing6@huawei.com" <wangbing6@huawei.com>, "wangfangpeng1@huawei.com"
	<wangfangpeng1@huawei.com>, "jannh@google.com" <jannh@google.com>,
	"willy@infradead.org" <willy@infradead.org>
Subject: RE: [PATCH v2] ARM: unwind: improve unwinders for noreturn case
Thread-Topic: [PATCH v2] ARM: unwind: improve unwinders for noreturn case
Thread-Index: AQHae3ROEuI+AaCprEesIWGaAOB7ebFB9uHAgAAWtoCAAAVW8IAACy4AgAADrmA=
Date: Thu, 21 Mar 2024 12:57:07 +0000
Message-ID: <0fd55e156195440bb1d815dd8300894b@AcuMS.aculab.com>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
 <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
 <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
 <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
 <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com>
 <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
 <db930076c837456f999daee5cb76735f@AcuMS.aculab.com>
 <ZfwmomjUwQdCefzh@shell.armlinux.org.uk>
In-Reply-To: <ZfwmomjUwQdCefzh@shell.armlinux.org.uk>
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

From: Russell King
> Sent: 21 March 2024 12:23
..
> > That might mean you can get the BL in the middle of a function
> > but where the following instruction is for the 'no stack frame'
> > side of the branch.
> > That is very likely to break any stack offset calculations.
>=20
> No it can't. At any one point in the function, the stack has to be in
> a well defined state, so that access to local variables can work, and
> also the stack can be correctly unwound. If there exists a point in
> the function body which can be reached where the stack could be in two
> different states, then the stack can't be restored to the parent
> context.

Actually you can get there with a function that has a lot of args.
So you can have:
=09if (...) {
=09=09push x
=09=09bl func
=09=09add %sp, #8
=09}
=09code;
which is fine.
But if 'func' is 'noreturn' then the 'add %sp, #8' can be discarded
and then the saved LR is that of 'code' - but the stack offset is wrong.

> > > This is where the problem lies - because the link register value
> > > created by the BL instruction will point to the instruction after the
> > > BL which will _not_ part of the function that invoked the BL. That
> > > will probably cause issues for the ELF unwinder, which means this
> > > issue probably goes beyond _just_ printing the function name.
> >
> > Isn't this already in the unwinder?
> > A BL itself isn't going to fault with PC =3D next-instruction.
>=20
> You are missing the fact that the PC can be the saved LR, and thus
> can very well be the next instruction.

A PC from LR will always be the next instruction.
It is only the PC from a fault frame that is the current one.
The unwinder probably need to be told which one it has.
(Or add 4 the fault frame PC so that the unwinder can subtract
4 from it.)

At least (I don't think) there are any functions where the
called code is responsible for removing arguments.
That is a whole different bag of worms.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


