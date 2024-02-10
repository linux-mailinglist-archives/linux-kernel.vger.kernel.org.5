Return-Path: <linux-kernel+bounces-60397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C62F850465
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20DF92838A8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9A643AAD;
	Sat, 10 Feb 2024 12:35:08 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A1339AC
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707568508; cv=none; b=bfKbEgweH0FuQ8FQ6zGp/0FiFi/Go9IcB1/GoCyZPHhD1Cr7nmMBc7uOKAWkAyrVghBbwwrX7wEp3N1WDhMlkLbntykuJWByB4BjUVwWolSsW1ncRWYelfJOoGeD5r6AaooV0XOKD3nnoU8n+1NuHCBjWvPOvIh9VdkX6W2/bnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707568508; c=relaxed/simple;
	bh=kV1dH9N0wl6dbAp2XFipJ67xCC7y7WlCPuruPIHVk6U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Y4gvKk/IWxkX4SOEl0rp6x9r6F2SCXmzMHgsII6uapD8iamvRpa6A/RexaRv1RT9cx5cHN6pu54/ucg01wHec2aZHiI84uhrHiRJQiTRguky3aE81Xt82ZEFrsQPMSz05AFPb8N+WrAhVtT0RoychivGL51YzzjIVfqkhkNJkqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-285-B9mkscCCOyeXmvwkut24cQ-1; Sat, 10 Feb 2024 12:35:02 +0000
X-MC-Unique: B9mkscCCOyeXmvwkut24cQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Feb
 2024 12:34:41 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Feb 2024 12:34:41 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
CC: Andy Shevchenko <andy@kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Richard Weinberger <richard@nod.at>,
	"Anton Ivanov" <anton.ivanov@cambridgegreys.com>, Johannes Berg
	<johannes@sipsolutions.net>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, "kernel
 test robot" <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>, "Azeem
 Shaikh" <azeemshaikh38@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>
Subject: RE: [PATCH v3 3/4] string: Allow 2-argument strscpy_pad()
Thread-Topic: [PATCH v3 3/4] string: Allow 2-argument strscpy_pad()
Thread-Index: AQHaWaavaD/gLIDMg0aBzFOj9pBKgrEDhhFw
Date: Sat, 10 Feb 2024 12:34:41 +0000
Message-ID: <d6710f82acfd4957a296601c420fba76@AcuMS.aculab.com>
References: <20240206142027.make.107-kees@kernel.org>
 <20240206142221.2208763-3-keescook@chromium.org>
 <20240207005151.lyrtgqd4wekolwe7@google.com> <202402070115.2C86687F@keescook>
In-Reply-To: <202402070115.2C86687F@keescook>
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

From: Kees Cook
> Sent: 07 February 2024 09:19
>=20
> On Wed, Feb 07, 2024 at 12:51:51AM +0000, Justin Stitt wrote:
> > Hi,
> >
> > On Tue, Feb 06, 2024 at 06:22:18AM -0800, Kees Cook wrote:
> > > Similar to strscpy(), update strscpy_pad()'s 3rd argument to be
> > > optional when the destination is a compile-time known size array.
> >
> > This patch is diff'd against Patch 1/4 in this series, right? I wonder
> > why you split them up. If I hadn't literally just read that patch I
> > would be mildly confused.
> >
> > I suppose one reason may be that 1/4 is a standalone change with a high
> > percentage chance of landing whilst this overloading magic may not land
> > as easily?
>=20
> I viewed it as a distinct logical change. I could certainly combine
> them, but I think it's easier to review the conversion from function to
> macro without needing to consider anything else. No behavioral changes
> are expected, etc.

I wonder about the code-bloat from inlining strscpy_pad()?
Especially given the code that gcc is likely to generate
for string ops.

I strongly suspect that the end of strscpy() knows exactly
you many bytes weren't written (in the non-truncate path).
So maybe implement both strscpy() and strscp_pad() in terms
of an inline function that has a parameter that 'turns on'
padding.

That way you get a simple call site and still only one
implementation.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


