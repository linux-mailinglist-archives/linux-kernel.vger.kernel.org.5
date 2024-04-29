Return-Path: <linux-kernel+bounces-162505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6518B5C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D721C21167
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81833811F2;
	Mon, 29 Apr 2024 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMZxveWv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39AB7E0E8;
	Mon, 29 Apr 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402825; cv=none; b=FRNBXoL2wKLQew6MHJBTV5kNn2EovUPhWq4GQ/sN0STv5ErGwSacbNJOuEuphhu86Du/o8AVyyeLM1DDcDvKHpR7rUJTwky1SXLvjfppUduz9nexWAzk2J1pRGzMiUfdUh4953lb/usQWyPDPoVDh/VvXchc2LioscYO4XsDE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402825; c=relaxed/simple;
	bh=VmHwpGGRoY1SKBqjn2H7w2QMYcuoLTkqQAl5r7KlsGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUxUuPC06T88u+d8HW66pt4RWpFuKqikfkKzD9+Uhjdt2cjbdu/9h9hZv82PYbL9iVm2ZS3pM+3wL9eI7kikGQUVDJCg/dJY3CnIbRVMnjOcrKgKULqmtyzurPn11ZNSB+K5eprjpnM5TVQvQWB2uG1uTgdRH2bI8f1RggBEFpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMZxveWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C4FC113CD;
	Mon, 29 Apr 2024 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714402824;
	bh=VmHwpGGRoY1SKBqjn2H7w2QMYcuoLTkqQAl5r7KlsGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DMZxveWviuEWLZFgBKggE03uoHY90WE09ANHyLG4gJASmt4mNa+5VIz5ObPICztrc
	 h+wv/AZNFm5LW8uFVX8qgCUadPzI6tBCobcXhDXg2gHjYF7mRo3qafoBfpu4iqLvD9
	 fFZwvP213pB1zKMq1dc7wd0YbaABW1jJpz9acIvFycANUb4x183p7BOyGYFjujH2gk
	 j9hovHIQkmPmEK8pLwtes1MxzgMDrbjHcUd/RaX0N0OwsScVKRWCe29HhHLDcD3ZRy
	 fBGv72+KXijBcrKIuDoyXUb4pFCJ/pzioiz+R0A682ZyaMeec9fboohr0T1g0Bq/Lz
	 FfzG+ThtxVviw==
Date: Mon, 29 Apr 2024 08:00:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jianbo Liu
 <jianbol@nvidia.com>, "edumazet@google.com" <edumazet@google.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from
 skb_frag_unref
Message-ID: <20240429080022.214a9df9@kernel.org>
In-Reply-To: <CAHS8izNs-LV=6FE39sjF3V7qVfveOsOAOJ_X62TSzWpvamsS0Q@mail.gmail.com>
References: <20240424165646.1625690-2-dtatulea@nvidia.com>
	<4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
	<CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
	<4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
	<CAHS8izPkRJyLctmyj+Ppc5j3Qq5O1u3aPe5h9mnFNHDU2OxA=A@mail.gmail.com>
	<20240426160859.0d85908e@kernel.org>
	<CAHS8izNs-LV=6FE39sjF3V7qVfveOsOAOJ_X62TSzWpvamsS0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Apr 2024 21:24:09 -0700 Mina Almasry wrote:
> On Fri, Apr 26, 2024 at 4:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 25 Apr 2024 12:20:59 -0700 Mina Almasry wrote: =20
> > > -       if (recycle && napi_pp_get_page(page))
> > > +       if (napi_pp_get_page(page)) =20
> >
> > Pretty sure you can't do that. The "recycle" here is a concurrency
> > guarantee. A guarantee someone is holding a pp ref on that page,
> > a ref which will not go away while napi_pp_get_page() is executing. =20
>=20
> I don't mean to argue, but I think the get_page()/put_page() pair we
> do in the page ref path is susceptible to the same issue. AFAIU it's
> not safe to get_page() if another CPU can be dropping the last ref,
> get_page_unless_zero() should be used instead.

Whoever gave us the pointer to operate on has a reference, so the page
can't disappear. get_page() is safe. The problem with pp is that we
don't know whether the caller has a pp ref or a page ref. IOW the pp
ref may not be owned by whoever called us.

I guess the situation may actually be worse and we can only pp-ref a
page if both "source" and "destination" skb has pp_recycle =3D 1 :S

> Since get_page() is good in the page ref path without some guarantee,
> it's not obvious to me why we need this guarantee in the pp ref path,
> but I could be missing some subtlety. At any rate, if you prefer us
> going down the road of reverting commit 2cc3aeb5eccc ("skbuff: Fix a
> potential race while recycling page_pool packets"), I think that could
> also fix the issue.

