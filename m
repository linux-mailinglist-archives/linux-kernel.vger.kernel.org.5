Return-Path: <linux-kernel+bounces-50807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C21D847E27
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58191F2930C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6D11FA2;
	Sat,  3 Feb 2024 01:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nso9e4d9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548651FB2;
	Sat,  3 Feb 2024 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706923665; cv=none; b=VPcfz9TUEtVE0HPT8ct003D75IapGrV77SDXla/Te5gPs0Rf5DRFpokfTbh9gC+L1fjn+2Vm3LEhryMy1P1M773cORs4Ay9ORi9GP3itobCyoQDDQyV4ekr7Eo7M5owG9FfnU8o6dR6fX5m6l3wW9dhxuu3bviDoUtSOuIVzX8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706923665; c=relaxed/simple;
	bh=dBctjRI6nluqE8RB9zYwPPC95te3cwqh8vdPXmMhREk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtAnOy3v5Tr0mY3AJaWQ0OWD1LzGHtWH1FqxIH4QP9zTnnEwW6BhJpnxedQxDp94b/f/J2So0cV7yzsyLI8lw3NvZeZ2oVMmFZltoJpPb1uYe8Q3hTijUTIMWEvs3jCqxOR/IKGavyhktXo/E7ssOFRzX4UXOXh6d4tvfWme+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nso9e4d9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C527CC433C7;
	Sat,  3 Feb 2024 01:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706923664;
	bh=dBctjRI6nluqE8RB9zYwPPC95te3cwqh8vdPXmMhREk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nso9e4d9rXfyHjY1mJmZeHdoBsO4xLV3Tr5pzHOfrRN+utd4Xc0sHZux77paGwwBS
	 RgwIjjiUTRFhLMLbxlx3DzTFZKxHM9lSTj01yqLh3oapyQScdZTSDf10G20KsRDXsE
	 +WiP/M3wVTYsHy320X64fPgXa5ek6iNGHCbnbLek=
Date: Fri, 2 Feb 2024 17:27:44 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	stable@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH 6.1.y and 6.6.y] LoongArch/smp: Call
 rcutree_report_cpu_starting() at tlb_init()
Message-ID: <2024020237-liable-strife-4800@gregkh>
References: <20240131072151.1023985-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131072151.1023985-1-chenhuacai@loongson.cn>

On Wed, Jan 31, 2024 at 03:21:51PM +0800, Huacai Chen wrote:
> Machines which have more than 8 nodes fail to boot SMP after commit
> a2ccf46333d7b2cf96 ("LoongArch/smp: Call rcutree_report_cpu_starting()
> earlier"). Because such machines use tlb-based per-cpu base address
> rather than dmw-based per-cpu base address, resulting per-cpu variables
> can only be accessed after tlb_init(). But rcutree_report_cpu_starting()
> is now called before tlb_init() and accesses per-cpu variables indeed.
> 
> Since the original patch want to avoid the lockdep warning caused by
> page allocation in tlb_init(), we can move rcutree_report_cpu_starting()
> to tlb_init() where after tlb exception configuration but before page
> allocation.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/kernel/smp.c |  1 -
>  arch/loongarch/mm/tlb.c     | 16 ++++++++++------
>  2 files changed, 10 insertions(+), 7 deletions(-)

Now queued up, thanks.

greg k-h

