Return-Path: <linux-kernel+bounces-97926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA6B8771BB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF201C203B0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FB743ACD;
	Sat,  9 Mar 2024 14:58:23 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447A3FB9F
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709996303; cv=none; b=PfMekROO0J2X3+Ibbr6meqsk5ITXEQlws6XTvs9X6gMvCJOIaxJDM1t5Y3uvtxgHFzhjku/M3vAvB+Ade7sxa/vgXSUGsY3f+0xQPFoWiJr78JMogzBa6oRIykmunfGF5qDsAt5Ip40e3Q+7s4dXwZrfleTrRE/Zeu+AVe+QR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709996303; c=relaxed/simple;
	bh=/X7H1ggJXyw8oZM2tEuo8CdkdavfIrnwt00+d/TQK+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=qnjdgGmlnh2jxbHYFoGEefmWgOhivoXyO97ax7UbnAP2S0VktPm8L8wm+3QJ/KaBMNjUYKZ56gLiH2bPGXiNluhpzw/Wf67AdSk11huolWPBmqmP6fviy1HFf4K4gPVGVQHVkz2BujJs3EDG2nbacyME07DaSUYV0vPUWpqyAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-156-mu8viMgRPXKNX4dY6V6FnA-1; Sat, 09 Mar 2024 14:58:11 +0000
X-MC-Unique: mu8viMgRPXKNX4dY6V6FnA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 9 Mar
 2024 14:58:25 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 9 Mar 2024 14:58:25 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Russell King' <linux@armlinux.org.uk>, Josh Poimboeuf
	<jpoimboe@kernel.org>
CC: Jiangfeng Xiao <xiaojiangfeng@huawei.com>, Kees Cook
	<keescook@chromium.org>, Jann Horn <jannh@google.com>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "nixiaoming@huawei.com"
	<nixiaoming@huawei.com>, "kepler.chenxin@huawei.com"
	<kepler.chenxin@huawei.com>, "wangbing6@huawei.com" <wangbing6@huawei.com>,
	"wangfangpeng1@huawei.com" <wangfangpeng1@huawei.com>,
	"douzhaolei@huawei.com" <douzhaolei@huawei.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: RE: [PATCH] usercopy: delete __noreturn from usercopy_abort
Thread-Topic: [PATCH] usercopy: delete __noreturn from usercopy_abort
Thread-Index: AQHab6wYEHIoKEvMpEWW5WbAwswgILEvgkBg
Date: Sat, 9 Mar 2024 14:58:25 +0000
Message-ID: <15437f635ba94224b6ed808bd6f42065@AcuMS.aculab.com>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>
 <202403040938.D770633@keescook>
 <77bb0d81-f496-7726-9495-57088a4c0bfc@huawei.com>
 <202403050129.5B72ACAA0D@keescook>
 <b274b545-9439-7ff8-e3ed-604a9ac81f65@huawei.com>
 <20240305175846.qnyiru7uaa7itqba@treble>
 <Zeg8wRYFemMjcCxG@shell.armlinux.org.uk>
In-Reply-To: <Zeg8wRYFemMjcCxG@shell.armlinux.org.uk>
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
> Sent: 06 March 2024 09:52
>=20
> On Tue, Mar 05, 2024 at 09:58:46AM -0800, Josh Poimboeuf wrote:
> > This is an off-by-one bug which is common in unwinders, due to the fact
> > that the address on the stack points to the return address rather than
> > the call address.
> >
> > So, for example, when the last instruction of a function is a function
> > call (e.g., to a noreturn function), it can cause the unwinder to
> > incorrectly try to unwind from the function *after* the callee.
>=20
> I suppose this can only happen in __noreturn functions because that
> can be:
>=20
> foo:
> ..
> =09bl=09bar
> .. end of function and thus next function ...
>=20
> which results in LR pointing into the next function.
>=20
> Would it make better sense to lookup the LR value winding it back by
> one instruction like ORC on x86 does (as you mention) rather than
> the patch you proposed which looks rather large and complicated?

Is it even possible to always reliably get a stack trace from
a no-return function on a cpu that uses a 'lr'?

If the function doesn't return then the compiler need not save
'lr' on stack and can still use it as a temporary register.
Without a valid 'lr' I think all you can do is search the stack
for a likely code address?

Am I missing something?

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


