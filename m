Return-Path: <linux-kernel+bounces-42665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A75840491
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606122849C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A765D8FE;
	Mon, 29 Jan 2024 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qb3eCHxg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E98755E58
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529925; cv=none; b=SiJ1JXDxmwXiWWiU+n47TN/KNVib77dhB/6nerVRxU/L6x/4LU2LynwlMlx8V9+NjVIZ2zS7tBCvpckRe9MhFd4dYhnPA14tiKWhViP3Ayrn15BCjiuR7KXCm3wa+exVyafoNfGlU/GbvKuUWjs/O4A4Nejy41HFbHsMcEtJ7Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529925; c=relaxed/simple;
	bh=B31YqXWo2jR6Q6dfmNlAsdyMk4Lj6GHmNj2kx0cjzZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqTgiCddrtJ/+y3EcaW8aK36oiiebSKzdiEr3gbsBl4Vgk5y9ICLtQMZNaT1af4qWe02pYbVFDfQi4WpyOTKGR+R+Y0pVUgWVNyq8xlZjIbJTSZT/qfuIyqjLivhgzcqMcADD+iMAwIez/IjkXPIEXJ7CP9DcHUtXczNw7butu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qb3eCHxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43055C43399;
	Mon, 29 Jan 2024 12:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706529924;
	bh=B31YqXWo2jR6Q6dfmNlAsdyMk4Lj6GHmNj2kx0cjzZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qb3eCHxgl85vWgSsclmEXDaKG08hwQgCm5ulSL8tMkw4n9V1qQENErMX3CNueOhRC
	 MrkxftfhKBdvIVA8t+k0jSLhr/aXd157nuL1BFQw2secdXQELTYQrzBUx+C37E1qde
	 x1kxlouM4lP5HzpmDIo9Zb0jnQSTUQN0r4DT3hZmvqgOfhnH4WGAfw7LG6noAmhXD1
	 PVKFoPMhw5GGKHpOjDWFKTadgqFBgzzMwtaDmeBEQzgmfdY+vLVp+E6G5+M0BqdgiK
	 P7QVswmFsdY9o6IuaK5A7E7aCmmFQe3VlWeTrSHmKSzqvhKL4r7+XovFGmvg3lReG8
	 VjrK6uFIt3+Yg==
Date: Mon, 29 Jan 2024 19:52:33 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com, samuel.holland@sifive.com,
	ajones@ventanamicro.com, mchitale@ventanamicro.com,
	dylan@andestech.com, sergey.matyukevich@syntacore.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, apatel@ventanamicro.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] RISC-V: add uniprocessor
 flush_tlb_range() support
Message-ID: <ZbeRgRBhvNnnTd8h@xhacker>
References: <20240125062044.63344-1-cuiyunhui@bytedance.com>
 <ZbdYijWK1PnHXn47@xhacker>
 <CAEEQ3wnSN8dLh3FcmHq5yPwQRdjLQa_VjcuTH+7YYZLOqCzaCQ@mail.gmail.com>
 <ZbdyLJ24I2fa6oNb@xhacker>
 <CAEEQ3w=gpSTxzxTzh-zHbP37P8s5eVCzG6RZndBXF-U+mNrziw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3w=gpSTxzxTzh-zHbP37P8s5eVCzG6RZndBXF-U+mNrziw@mail.gmail.com>

On Mon, Jan 29, 2024 at 07:02:10PM +0800, yunhui cui wrote:
> Hi Jisheng,
> 
> On Mon, Jan 29, 2024 at 5:51 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > On Mon, Jan 29, 2024 at 04:26:57PM +0800, yunhui cui wrote:
> > > Hi Jisheng,
> > >
> > > On Mon, Jan 29, 2024 at 4:02 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> > > >
> > > > On Thu, Jan 25, 2024 at 02:20:44PM +0800, Yunhui Cui wrote:
> > > > > Add support for flush_tlb_range() to improve TLB performance for
> > > > > UP systems. In order to avoid the mutual inclusion of tlbflush.h
> > > > > and hugetlb.h, the UP part is also implemented in tlbflush.c.
> > > >
> > > > Hi Yunhui,
> > > >
> > > > IIRC, Samuel sent similar patch series a few weeks ago.
> > > >
> > > > https://lore.kernel.org/linux-riscv/20240102220134.3229156-1-samuel.holland@sifive.com/
> > > >
> > > > After that series, do you still need this patch?
> > >
> > > Thank you for your reminder. I didn't find it before I mailed my
> > > patch. I just looked at the content of this patch. I understand that
> > > my patch is needed. For a single core, a more concise TLB flush logic
> > > is needed, and it is helpful to improve performance.
> >
> > Currently, riscv UP flush_tlb_range still use flush all TLB entries,
> > obviously it's is a big hammer, this is what your patch is trying to
> > optimize. I'm not sure whether I understand your code correctly or not.
> > Let me know if I misunderstand your code.
> >
> > After patch5 of the Samuel's series, __flush_tlb_range is unified for
> > SMP and UP, so that UP can also benefit from recent improvements, such
> > as range flush rather than all.
> 
> In my opinion, UP does not need to combine some SMP if... else,
> on_each_cpu(...) logic, which is also a manifestation of performance

Hi Yunhui,

IIRC, the compiler will optimise out the unnecessary logic under UP, I
may misread the code. But if no, indeed, there's improvement room.
However, even in this case, IMHO, it's better if you can base on
Samuel's series.
Anyway, the optimization(range tlb entries rather than *all* entries under
UP case) you want to do has been implemented. While I'm not sure whether
we can rely on the compiler to optimize out all unnecessary logics.

Thanks
> improvement. what do you think?
> Thanks,
> Yunhui

