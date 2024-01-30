Return-Path: <linux-kernel+bounces-45258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7431F842DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254DD1F250F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EAC71B4F;
	Tue, 30 Jan 2024 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BoHLiJty"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC2069E14;
	Tue, 30 Jan 2024 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646465; cv=none; b=S8daBNY54S5iGyEsO9oAYRW5JmHIXaXkARr78zS6Tj48OyDVTf4lSHSnksWKKia+hpYWUrJjmMhFZGoCqCsZpUXtdD8omO3n9I/hB2pLObiF5NFu9pvNU7sC9BahV78iIqcp18Py9//nway3nBm0MpMMqmh9Fq89m05IBgiDYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646465; c=relaxed/simple;
	bh=v83Ebp421YVrZ0ZYFAm4D7pXG8a0FdzvdpMpaihmQHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KI9ZtxHTFVCC97LnLy/OlckBmpdUto9Nosoupqduofyn4No9kC2yAkOyn6WG/mip+aPamtlBqVf2Bj30xdakwn3qBl0RLALIMzOq+e+P0UGmEHwjI2IiiR4s0Dg71W/wUL7VRtdXHMdFvNT45vyYs3v7UPlRPiCswk5korYbHOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BoHLiJty; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=KF0eA11IhH1RKliosU16MNbkjO0cWVDLOUxDSxK6czs=; b=BoHLiJtytJma/rBq+XUDY19xyn
	+zF+XyExGa3ZC59LtZpu1AOY7JeLTUHTfaoFtNTpKyPQM8LZWN3aj0E4drJCn1rcgP5TJY9Dp3bbV
	E7BNaIT+n7KVtYzDm/rajfb48s1+yLIHsSG//4oEPyjOytYA1w25hMLzgWHAjGcH9oiyWFLo47hkU
	jyFj4D2GZFEU295kPldN+c6bQmq0B8lgWIzPYKa68D/cGSkjsZhVYRZ91vw/jTqO5mlBF6NxPB4Y1
	sGYhSVCseNdKyh9IcN0/guh5Dxl0WxX0F+x+bnrwKGD9/5dHVyx19xESEUjhDtzSbZR86cO4c+M5Y
	EcBFtR7A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUuhk-00000000Sqp-25pi;
	Tue, 30 Jan 2024 20:27:36 +0000
Date: Tue, 30 Jan 2024 12:27:36 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 1/3] init: Declare rodata_enabled and mark_rodata_ro() at
 all time
Message-ID: <ZblbuHLaK2_Xhff_@bombadil.infradead.org>
References: <7b5df1782e94a755b4a18733af44d17d8dd8b37b.1703149011.git.christophe.leroy@csgroup.eu>
 <ZbgGDlgrLhB8tcGI@bombadil.infradead.org>
 <20240130091626.GA3684878@google.com>
 <9e298fa7-a953-462a-96a4-56a1b4316a17@csgroup.eu>
 <CGME20240130174812eucas1p166f62549457fd188fed6ed72b6b4b9cd@eucas1p1.samsung.com>
 <30ddedc9-0829-4a99-9cb1-39190937981c@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30ddedc9-0829-4a99-9cb1-39190937981c@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Jan 30, 2024 at 06:48:11PM +0100, Marek Szyprowski wrote:
> Dear All,
> 
> On 30.01.2024 12:03, Christophe Leroy wrote:
> > Le 30/01/2024 à 10:16, Chen-Yu Tsai a écrit :
> >> [Vous ne recevez pas souvent de courriers de wenst@chromium.org. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
> >>
> >> On Mon, Jan 29, 2024 at 12:09:50PM -0800, Luis Chamberlain wrote:
> >>> On Thu, Dec 21, 2023 at 10:02:46AM +0100, Christophe Leroy wrote:
> >>>> Declaring rodata_enabled and mark_rodata_ro() at all time
> >>>> helps removing related #ifdefery in C files.
> >>>>
> >>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >>> Very nice cleanup, thanks!, applied and pushed
> >>>
> >>>     Luis
> >> On next-20240130, which has your modules-next branch, and thus this
> >> series and the other "module: Use set_memory_rox()" series applied,
> >> my kernel crashes in some very weird way. Reverting your branch
> >> makes the crash go away.
> >>
> >> I thought I'd report it right away. Maybe you folks would know what's
> >> happening here? This is on arm64.
> > That's strange, it seems to bug in module_bug_finalize() which is
> > _before_ calls to module_enable_ro() and such.
> >
> > Can you try to revert the 6 patches one by one to see which one
> > introduces the problem ?
> >
> > In reality, only patch 677bfb9db8a3 really change things. Other ones are
> > more on less only cleanup.
> 
> I've also run into this issue with today's (20240130) linux-next on my 
> test farm. The issue is not fully reproducible, so it was a bit hard to 
> bisect it automatically. I've spent some time on manual testing and it 
> looks that reverting the following 2 commits on top of linux-next fixes 
> the problem:
> 
> 65929884f868 ("modules: Remove #ifdef CONFIG_STRICT_MODULE_RWX around 
> rodata_enabled")
> 677bfb9db8a3 ("module: Don't ignore errors from set_memory_XX()")
> 
> This in fact means that commit 677bfb9db8a3 is responsible for this 
> regression, as 65929884f868 has to be reverted only because the latter 
> depends on it. Let me know what I can do to help debugging this issue.

Thanks for the bisect, I've reset my tree to commit
3559ad395bf02 ("module: Change module_enable_{nx/x/ro}() to more
explicit names") for now then, so to remove those commits.

  Luis

