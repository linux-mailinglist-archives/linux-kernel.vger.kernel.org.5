Return-Path: <linux-kernel+bounces-108189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FC6880740
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04312283756
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3920F5FB8F;
	Tue, 19 Mar 2024 22:23:35 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83D5FB87
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710887014; cv=none; b=IBE/CinyapKT3Nun4MNFoEZsRfXD8EfYyj/D/dUZBwzvdz8U+Yr3KPvD8qqJh8NpjT6HspjriuvuRPCWJqHy0x8qX1gjEQIFGRldXmeHqykHeTROx7dEwNu/O00Md7KJLqtUrBhD7aZw6eYAIfumySlpXaXweBzH6FWOxV/YFeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710887014; c=relaxed/simple;
	bh=yLckV8zdpwBC7lLU1aS75M7QQR1x8wHlYNEMkhCPHqY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=OHAEAgF62rY/uGELc8L1ECX4EP8dXkxTphOaA2M9IEYwEfz17KakyZqUAqEmIq1V+MHkdbtJStKFT6oZM3WkQ2p2AYMEkh7IwV+MzS1HEJybMCpI6aDPyGZ/rLoikx+Z8BUIcQJ/xzf67oBZJCvlcBh/0oqaMr9aYF6GTEy49wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6DD706450963;
	Tue, 19 Mar 2024 23:18:07 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id eBsVIj-qbrJE; Tue, 19 Mar 2024 23:18:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5F2536450966;
	Tue, 19 Mar 2024 23:18:06 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wa50cn74hycn; Tue, 19 Mar 2024 23:18:06 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 194C86450963;
	Tue, 19 Mar 2024 23:18:06 +0100 (CET)
Date: Tue, 19 Mar 2024 23:18:05 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	petr <petr@tesarici.cz>
Message-ID: <1418379493.78340.1710886685735.JavaMail.zimbra@nod.at>
In-Reply-To: <8d45f94c-bce1-4327-9573-cec254a4e9c3@huaweicloud.com>
References: <20240223140435.1240-1-petrtesarik@huaweicloud.com> <9284cda7-d7e3-4390-bf62-58092e97d1c8@huaweicloud.com> <8d45f94c-bce1-4327-9573-cec254a4e9c3@huaweicloud.com>
Subject: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in
 the vmalloc area
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: oops on accessing a non-present page in the vmalloc area
Thread-Index: OdzHbbhSrpqdStaC7MekET1pCSEHow==

----- Urspr=C3=BCngliche Mail -----
> Von: "Petr Tesarik" <petrtesarik@huaweicloud.com>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>, "linux-um" <linux-um@lists.infradead.org>, "=
linux-kernel" <linux-kernel@vger.kernel.org>
> CC: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, "petr" <petr@tesaric=
i.cz>
> Gesendet: Montag, 18. M=C3=A4rz 2024 14:09:07
> Betreff: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page =
in the vmalloc area

> On 3/12/2024 4:07 PM, Petr Tesarik wrote:
>> On 2/23/2024 3:04 PM, Petr Tesarik wrote:
>>> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>>>
>>> If a segmentation fault is caused by accessing an address in the vmallo=
c
>>> area, check that the target page is present.
>>>
>>> Currently, if the kernel hits a guard page in the vmalloc area, UML bli=
ndly
>>> assumes that the fault is caused by a stale mapping and will be fixed b=
y
>>> flush_tlb_kernel_vm(). Unsurprisingly, if the fault is caused by access=
ing
>>> a guard page, no mapping is created, and when the faulting instruction =
is
>>> restarted, it will cause exactly the same fault again, effectively crea=
ting
>>> an infinite loop.
>>=20
>> Ping. Any comment on this fix?
>=20
> I don't think I have seen a reply from you. If you did comment, then
> your email has not reached me.
>=20
> Please, can you confirm you have seen my patch?

Yes. I'm just way behind my maintainer schedule. :-/

Thanks,
//richard

