Return-Path: <linux-kernel+bounces-27104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B7282EA77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F22283DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F851111B7;
	Tue, 16 Jan 2024 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="oGVCcZ8P"
Received: from smtp2-kfki.kfki.hu (smtp2-kfki.kfki.hu [148.6.0.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4EA111A4;
	Tue, 16 Jan 2024 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blackhole.kfki.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp2.kfki.hu (Postfix) with ESMTP id 5D311CC02B2;
	Tue, 16 Jan 2024 08:57:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:message-id
	:in-reply-to:from:from:date:date:received:received:received
	:received; s=20151130; t=1705391844; x=1707206245; bh=YtGdwP222a
	OPjyafDG2zZ0g5Qa+ykMxMO+cELsQoiwA=; b=oGVCcZ8PUYixBSITD0HI0GHWRR
	CxCRg2zK50+rWh7iXztMx1/oVX7PCBvC+ff8wUuVAxa14/yAVs3Rl6G+05WlKkV/
	Aksnyia2ZoG9yD0eA+FTMBaViBHN4nz3PDPyFlQSQqJHQYU09pFr0xJfaeya8y7j
	Zv86iV1jZaEHRIue8=
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
	by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP; Tue, 16 Jan 2024 08:57:24 +0100 (CET)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
	by smtp2.kfki.hu (Postfix) with ESMTP id 4C3ECCC0110;
	Tue, 16 Jan 2024 08:57:23 +0100 (CET)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
	id 168A2343167; Tue, 16 Jan 2024 08:57:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by blackhole.kfki.hu (Postfix) with ESMTP id 14973343166;
	Tue, 16 Jan 2024 08:57:23 +0100 (CET)
Date: Tue, 16 Jan 2024 08:57:23 +0100 (CET)
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To: Ale Crismani <ale.crismani@automattic.com>
cc: Wang David <00107082@163.com>, linux-kernel@vger.kernel.org, 
    netfilter-devel@vger.kernel.org, Ayuso Pablo Neira <pablo@netfilter.org>, 
    xiaolinkui@kylinos.cn
Subject: Re: Performance regression in ip_set_swap on 6.7.0
In-Reply-To: <7214C087-ED54-4D3B-A17C-DA811951BF67@automattic.com>
Message-ID: <b2dfbbb9-7e4f-aed3-8935-769d4254ef25@blackhole.kfki.hu>
References: <b333bc85-83ea-8869-ccf7-374c9456d93c@blackhole.kfki.hu> <20240111145330.18474-1-00107082@163.com> <d5c24887-b2d4-bcc-f5a4-bd3d2670d16@blackhole.kfki.hu> <41662e12.d59.18d0673507e.Coremail.00107082@163.com> <D2070167-F299-455C-AE4B-5D047ABD5B28@automattic.com>
 <7214C087-ED54-4D3B-A17C-DA811951BF67@automattic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 15 Jan 2024, Ale Crismani wrote:

> > Il giorno 14 gen 2024, alle ore 21:38, Ale Crismani <ale.crismani@automattic.com> ha scritto:
> > 
> >> Il giorno 14 gen 2024, alle ore 06:30, David Wang <00107082@163.com> ha scritto:
> >> 
> >> 
> >> At 2024-01-14 02:24:07, "Jozsef Kadlecsik" <kadlec@blackhole.kfki.hu> wrote:
> >>> On Thu, 11 Jan 2024, David Wang wrote:
> >>> 
> >>>> I tested the patch with code stressing swap->destroy->create->add 10000 
> >>>> times, the performance regression still happens, and now it is 
> >>>> ip_set_destroy. (I pasted the test code at the end of this mail)
> >> 
> >>>> 
> >>>> They all call wait_for_completion, which may sleep on something on 
> >>>> purpose, I guess...
> >>> 
> >>> That's OK because ip_set_destroy() calls rcu_barrier() which is needed to 
> >>> handle flush in list type of sets.
> >>> 
> >>> However, rcu_barrier() with call_rcu() together makes multiple destroys 
> >>> one after another slow. But rcu_barrier() is needed for list type of sets 
> >>> only and that can be handled separately. So could you test the patch 
> >>> below? According to my tests it is even a little bit faster than the 
> >>> original code before synchronize_rcu() was added to swap.
> >> 
> >> Confirmed~! This patch does fix the performance regression in my case.
> >> 
> >> Hope it can fix ale.crismani@automattic.com's original issue.
> > 
> > Thanks for all the help on this, I'll try the patch tomorrow hopefully 
> > and will report back!
> 
> I applied the patch on 6.1.y on top of 875ee3a and I can confirm it 
> fixes the performance issues in our case too.

Thanks for the testing, to both of you. I'm going to release the patch 
for kernel inclusion.

Best regards,
Jozsef
-- 
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary

