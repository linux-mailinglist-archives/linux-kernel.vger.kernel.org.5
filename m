Return-Path: <linux-kernel+bounces-17519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2EA824EC6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4106E284EFA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364F1DDF1;
	Fri,  5 Jan 2024 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="rUZM2/Bj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDBE1D68C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id CDA611A72AF;
	Fri,  5 Jan 2024 07:51:10 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1704437470; bh=NPN413BX7veL0ZZ7wcFpIrFwMjUtaFyf8fSTVWxL9IY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rUZM2/BjJNY3By53aFMPeWST2d8QK3+nd6GJQtlK/Eua315I29ynJPJ7Sa5dsd4jC
	 i4DA2glt0PCNyqxeNhKN6wG8ECyQoaj4APHCrBNEe9V5iXyegI6B1eRFvA+mhRFXSN
	 oxUjV3B3dEU+Dc/Y4iitUaPs2eWirs0OFcALSvUWSQ+duXJNJfH/398JFDzcdoS0Pd
	 dIb3Q6H8p0wq8siy3wBQvc3RuDa8SUWg4AM3t6CAUXCuCDdkyw6CG506k8nLDVc6M3
	 tG4tp7vCuTo0v9rP5wUbiAaC79iBhYKzZSJeY/Yl9vA4xqxbYCpkd0azQW6iGzO1gW
	 p5u/R2FppHTvw==
Date: Fri, 5 Jan 2024 07:51:09 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Richard Weinberger <richard@nod.at>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, anton ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, linux-um <linux-um@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu
 <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH 0/2] um: improve UML page fault handling
Message-ID: <20240105075109.4f0e2785@meshulam.tesarici.cz>
In-Reply-To: <435201914.200552.1704410531143.JavaMail.zimbra@nod.at>
References: <20231215121431.680-1-petrtesarik@huaweicloud.com>
	<435201914.200552.1704410531143.JavaMail.zimbra@nod.at>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Helo Richard,

Am Fri, 5 Jan 2024 00:22:11 +0100 (CET)
schrieb Richard Weinberger <richard@nod.at>:

> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Petr Tesarik" <petrtesarik@huaweicloud.com>
> > An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgeg=
reys.com>, "Johannes Berg"
> > <johannes@sipsolutions.net>, "linux-um" <linux-um@lists.infradead.org>,=
 "linux-kernel" <linux-kernel@vger.kernel.org>
> > CC: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, petr@tesarici.cz, =
"Petr Tesarik"
> > <petr.tesarik1@huawei-partners.com>
> > Gesendet: Freitag, 15. Dezember 2023 13:14:29
> > Betreff: [PATCH 0/2] um: improve UML page fault handling =20
>=20
> > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> >=20
> > Improve UML handling of segmentation faults in kernel mode. Although
> > such page faults are generally caused by a kernel bug, it is annoying
> > if they cause an infinite loop, or panic the kernel. More importantly,
> > a robust implementation allows to write KUnit tests for various guard
> > pages, preventing potential kernel self-protection regressions.
> >=20
> > Petr Tesarik (2):
> >  um: do not panic on kernel mode faults
> >  um: oops on accessing an non-present page in the vmalloc area =20
>=20
> I think this is a good thing to have.

Thanks for the feedback.

> For the implementation side, this needs to use the oops_* helpers
> from kernel/panic.c and taint the kernel, etc...

Yes, I did see that coming but wanted to get some confirmation that
it's worth the effort.

> See arch/x86/kernel/dumpstack.c die() and friends.

This implementation also calls die notifiers, but AFAICS different
architectures are not very consistent in their use. Do you also
require die notifiers for the UML implementation?

Petr T

