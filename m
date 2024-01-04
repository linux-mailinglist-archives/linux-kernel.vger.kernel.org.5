Return-Path: <linux-kernel+bounces-17323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5820824BC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD2E1C226BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BE22D052;
	Thu,  4 Jan 2024 23:22:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EC62D025
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DA17D626FAE6;
	Fri,  5 Jan 2024 00:22:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id yD_ZKLh5XoAP; Fri,  5 Jan 2024 00:22:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7780F626FB00;
	Fri,  5 Jan 2024 00:22:11 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VpwcTByJ0DTB; Fri,  5 Jan 2024 00:22:11 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 550FF626FAE6;
	Fri,  5 Jan 2024 00:22:11 +0100 (CET)
Date: Fri, 5 Jan 2024 00:22:11 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz, 
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Message-ID: <435201914.200552.1704410531143.JavaMail.zimbra@nod.at>
In-Reply-To: <20231215121431.680-1-petrtesarik@huaweicloud.com>
References: <20231215121431.680-1-petrtesarik@huaweicloud.com>
Subject: Re: [PATCH 0/2] um: improve UML page fault handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: improve UML page fault handling
Thread-Index: 3x5bOAmY5/XfwxP9N8Jncq5xgr1IZw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Petr Tesarik" <petrtesarik@huaweicloud.com>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>, "linux-um" <linux-um@lists.infradead.org>, "=
linux-kernel" <linux-kernel@vger.kernel.org>
> CC: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, petr@tesarici.cz, "P=
etr Tesarik"
> <petr.tesarik1@huawei-partners.com>
> Gesendet: Freitag, 15. Dezember 2023 13:14:29
> Betreff: [PATCH 0/2] um: improve UML page fault handling

> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>=20
> Improve UML handling of segmentation faults in kernel mode. Although
> such page faults are generally caused by a kernel bug, it is annoying
> if they cause an infinite loop, or panic the kernel. More importantly,
> a robust implementation allows to write KUnit tests for various guard
> pages, preventing potential kernel self-protection regressions.
>=20
> Petr Tesarik (2):
>  um: do not panic on kernel mode faults
>  um: oops on accessing an non-present page in the vmalloc area

I think this is a good thing to have.
For the implementation side, this needs to use the oops_* helpers
from kernel/panic.c and taint the kernel, etc...
See arch/x86/kernel/dumpstack.c die() and friends.

Thanks,
//richard

