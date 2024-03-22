Return-Path: <linux-kernel+bounces-111594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56285886E54
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D909428B50D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DBA47F7A;
	Fri, 22 Mar 2024 14:16:53 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D0047A40
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117013; cv=none; b=f+hH2hDRGe/kTM/Leiq4o8b6qT5egrSDrWP72Q7hQxE19DznLRRQnVgIykdqOJwLHMqCppx4NoTQ6VqcJ9pTSQPeKB6a0qtv+ABDv3D2yc9nkS4O7zTgTFz3sG739sF6q2Cnz9KHKuSD3ya2ZU7QgDh5bFK2MQzJiwgAyOt1/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117013; c=relaxed/simple;
	bh=gTQrp4Js3OxUcPX+M7h8O2IyGN5Wup3eAf2X2EQJk+g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=p4BqrkHgrxQjJiwvFGe9qcbHqG+cpgoDUts7+Hi1jDB8RXgUnxYsjJ8E4XBwTfpZDRq9Fw28gLx2+B0/ybBk8e3Vy1gOxQNlQ0ijHdfxfZaQSar2gFjk5vh3JhQivgAOav4QyUnjYm1U+TWX0093uYUDiZBdBsoJK4sqMM2buJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-11-17hD1aE4NWuU9zNj5esXGg-1; Fri, 22 Mar 2024 14:16:41 +0000
X-MC-Unique: 17hD1aE4NWuU9zNj5esXGg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 22 Mar
 2024 14:16:15 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 22 Mar 2024 14:16:15 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Russell King' <linux@armlinux.org.uk>
CC: Ard Biesheuvel <ardb@kernel.org>, Jiangfeng Xiao
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
Thread-Index: AQHae3ROEuI+AaCprEesIWGaAOB7ebFB9uHAgADsd8GAAJnLsIAACSyAgABHz+A=
Date: Fri, 22 Mar 2024 14:16:15 +0000
Message-ID: <8f12147ee3cf4bbd8fc980821ae1deac@AcuMS.aculab.com>
References: <1710906278-23851-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZfqiD8Yw0oOVHW/p@shell.armlinux.org.uk>
 <84a57ca8-8963-ca24-8bd1-ddc5c33bf4da@huawei.com>
 <Zfs7sT6Pxy5yjnPC@shell.armlinux.org.uk>
 <bad25937-fc98-8e11-4279-ab6b3a727c1f@huawei.com>
 <bbcca1e205384cf0b42236e17f3969f7@AcuMS.aculab.com>
 <ZfwYx/8k8FVONg6+@shell.armlinux.org.uk>
 <CAMj1kXG2EGvgGuV-K7h5qDVJeLMd5hkq8GzigzCRzh9Z8cgyWw@mail.gmail.com>
 <ZfzMFv3zmYY36l9u@shell.armlinux.org.uk>
 <2b2993fb215c4a5abd7d77ff1c984113@AcuMS.aculab.com>
 <Zf1UyxlDf/oCjXxr@shell.armlinux.org.uk>
In-Reply-To: <Zf1UyxlDf/oCjXxr@shell.armlinux.org.uk>
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
> Whereas we already provide an abort() function because iirc the
> compiler used to emit branches to that due to noreturn functions. If
> correct, there's previous convention for doing this - and abort() is
> still exists in the kernel and in userspace since it's part of ANSI
> C. This would be a more reliable and portable solution, but probably
> not for embedded platforms - and that's probably why it got removed.

Wouldn't you want it to do a 'bl abort' so that you could do a backtrace
to find out which 'noreturn' function had returned?

But that leaves you with another 'noreturn' function that you have
difficulty generating a backtrace from.

So you'd need a compiler option to specify what to put there.
I'd suspect linux would like something that generates an 'undefined
instruction' trap - since that would be expected to fault with the
saved PC pointing to the instruction itself (but architectures may vary).

'One size' definitely doesn't 'fit all' :-)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


