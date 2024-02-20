Return-Path: <linux-kernel+bounces-72977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B1E85BB5C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70784B21D62
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3494667C56;
	Tue, 20 Feb 2024 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJ0KtNMM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7557267A0D;
	Tue, 20 Feb 2024 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430736; cv=none; b=aLNVwxAB7ZSdaxZlC5yCQPMvyz1blzyvas5rVTrvh8OXB6bNeR+0bMFvO4+0UUORiEkVuO7RP9qaohDxSYZAbL9Gesk57YRV/xjdCxcZD5WF6h0/o8G8UgHcmvbkf9khB9gklRDG/Ce45hNDLK/QfBAhMZGj/XgDBKBT7qqbLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430736; c=relaxed/simple;
	bh=uFhQeV0G5kKC+gS0p2qQ4txoQzbH3NaU3HXRPdCBUI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JroSxubeWYhdJYQcjESrfMTJnvuJSvTshICpnz74/ov8CyjhdWYoRWpPB7LLF+CK33j9jrUNwTxHLY2oNloy5bDqzCy9rPVLli0BSXGeG75q2LpR7xTvEexsNB40hqBi3VuMwFkkiGl6qpPIlBCzdQmRUVzbdbu4V08WpblRxTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJ0KtNMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B58C433C7;
	Tue, 20 Feb 2024 12:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708430735;
	bh=uFhQeV0G5kKC+gS0p2qQ4txoQzbH3NaU3HXRPdCBUI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJ0KtNMMu9CPBiN4yK5l4EUJ1JY73SfqBKLLpqsSUWWjkKMH7h3m9ng5R6huJQpJs
	 599ouKRCIN7NddfvXPghuzZFq9v9dRp4BTfq7t6M35+MKx6kLvfG+IqmBpZ0mzTLYx
	 Plk20+upJx1xNjr4JZgS//FVLUETCwzM6u2IKcAROPCIZBpD49zGa5W5WXZJP2w8nb
	 uWx0AHEs1PmcAjUNrQTbaLM7Yotq2Ww98b/tsY0KUxWvr+pLYpcOz5nGnI0hjXE8cP
	 kUyUpMNZdQAqpZHGmDoA4q37P/6MJQ/NGqXf+tx8k+xgLmFgtkQ5dqufkoOQUKJ81a
	 D14m+iX7xJ3Zg==
Date: Tue, 20 Feb 2024 12:05:30 +0000
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>, Fangrui Song <maskray@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>,
	Peter Smith <peter.smith@arm.com>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: jump_label: use constraints "Si" instead of "i"
Message-ID: <20240220120529.GA5613@willie-the-truck>
References: <20240206074552.541154-1-maskray@google.com>
 <CAMuHMdVOoxVFohcwwoQtY0KgZEvbjgJJ6mib8Fabo97P0krEqw@mail.gmail.com>
 <CAMj1kXGaF5bobHTr1pTg+-=s4Ft7+5SSbX72-NxsR_W_Yuxb8Q@mail.gmail.com>
 <CAMj1kXGw+r7yEEBA8gYBcdrqkiP=VYOSzz9YLnNavJn2snmFwA@mail.gmail.com>
 <CAMuHMdX+6fnAf8Hm6EqYJPAjrrLO9T7c=Gu3S8V_pqjSDowJ6g@mail.gmail.com>
 <CAMj1kXHh_m=V0QsiTpHrUXpFBXFbFfezdysz8quhPSgUrZg1MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHh_m=V0QsiTpHrUXpFBXFbFfezdysz8quhPSgUrZg1MA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Feb 19, 2024 at 04:41:03PM +0100, Ard Biesheuvel wrote:
> On Mon, 19 Feb 2024 at 15:43, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > Changes from
> > > > > > arm64: jump_label: use constraint "S" instead of "i" (https://lore.kernel.org/all/20240131065322.1126831-1-maskray@google.com/)
> > > > > >
> > > > > > * Use "Si" as Ard suggested to support Clang<19
> > > > > > * Make branch a separate operand
> > > > > >
> > > > > > Changes from v1:
> > > > > >
> > > > > > * Use asmSymbolicName for readability
> > > > >
> > > > > But it still fails on gcc-5:
> > > > >
> > > > >     arch/arm64/include/asm/jump_label.h:25:2: error: invalid 'asm':
> > > > > invalid operand
> > > > >       asm goto(
> > > > >       ^
> > > > >
> > > > > http://kisskb.ellerman.id.au/kisskb/buildresult/15129281/
> > > > >
> > > >
> > > > How odd. godbolt.org has 5.4 and it seems perfectly happy with it.
> >
> > > https://godbolt.org/z/GTnf3vPaT
> >
> > I could reproduce the issue on v6.8-rc5 using arm64 defconfig
> > and x86_64-gcc-5.5.0-nolibc-aarch64-linux.tar.xz from
> > https://cdn.kernel.org/pub/tools/crosstool/files/bin/x86_64/5.5.0/:
> >
> 
> OK, I managed to do so as well.
> 
> And GCC 6.4 from the same source works correctly.
> 
> Not sure whether there are any plans to bump the minimal GCC version
> any time soon (cc'ing Arnd), but we should probably drop this change
> until that happens.

Yup, makes sense to me. I'll revert the original change and we can bring it
back later if we decide to bump the minimum GCC version.

Cheers,

Will

