Return-Path: <linux-kernel+bounces-98886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DA48780AD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA431C21804
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B13D961;
	Mon, 11 Mar 2024 13:33:46 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C441F2E3F7;
	Mon, 11 Mar 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164026; cv=none; b=b2Y/klesH7NTJyj5xEPlsqna+3ghac88jXjyxG2FxJAOJpE+Z3DJFl9yArZ8o8A9a/hXnQ8kTb4oih1ut6mI3JeelwCEQ6BAf7e/gmCOB8nYlDSVdsZKmMsw83Q6iK8wGJ6hyC/RAAbjhDNA9Uu2V7cHLqfaDbnp+PLN+9rgHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164026; c=relaxed/simple;
	bh=jxq8f271ujvpbwEQPSIylVtewrclzvRsFccoNPWrj2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLOOoTrAG1vN8rkWFcZ8szdUg8VxhKKwJBdfNzoBkAwRgWHWBCG8+clvRTxHTKhM+yqOUA4YUbvqwBRdp7Z59bc/H3VODu87h6jAVVNAzjIJcVpDMgcoGwkxBsqpuJVk60dy3BoCs0q2n0MJVjfqaTvCHEeWuTiehM9HMRQglcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rjfO2-0001bk-00; Mon, 11 Mar 2024 14:08:14 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 3D2C9C0694; Mon, 11 Mar 2024 14:07:19 +0100 (CET)
Date: Mon, 11 Mar 2024 14:07:19 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mips: cm: Convert __mips_cm_l2sync_phys_base() to
 weak function
Message-ID: <Ze8CB27Ad427Gk3K@alpha.franken.de>
References: <20240226105427.7191-1-fancer.lancer@gmail.com>
 <20240226105427.7191-2-fancer.lancer@gmail.com>
 <34af21b5-a878-418e-a70b-299cab61b37e@app.fastmail.com>
 <y2lxeu5uvj7ezlv7kf6lox5e5xprmvrhqmf3gvzjsatlrrlub7@mvqzoyq5mnvd>
 <cc9e02b3-57df-4a7d-bd21-2d574bf4b878@app.fastmail.com>
 <simbnmm644ouv3kc3agsxiub6fzg6advihkqsbjzgmb44nmuxv@ktgkhn3kr43z>
 <60e60313-3cc4-452f-a222-aadd7728183d@app.fastmail.com>
 <6n2synlvazjh2gptxtioju7dciwshwqyei4xnfzorns66b3hqx@c7blt5kwnpbl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6n2synlvazjh2gptxtioju7dciwshwqyei4xnfzorns66b3hqx@c7blt5kwnpbl>

On Mon, Feb 26, 2024 at 04:11:05PM +0300, Serge Semin wrote:
> On Mon, Feb 26, 2024 at 01:29:54PM +0100, Arnd Bergmann wrote:
> > On Mon, Feb 26, 2024, at 13:20, Serge Semin wrote:
> > > On Mon, Feb 26, 2024 at 01:04:33PM +0100, Arnd Bergmann wrote:
> > >> On Mon, Feb 26, 2024, at 12:27, Serge Semin wrote:
> > 
> > > I see your point now. Thanks for clarification. IMO it would be less
> > > readable due to the ifdef-ery and the new config, and less
> > > maintainable due to the conditional compilation, but would provide a
> > > more performant solution since the compiler will be able to inline the
> > > singly used static method. Basically you suggest to emulate the weak
> > > implementation by an additional kernel config.
> > 
> > I mean the kernel config that you already need here, since
> > the strong version of the function is already optional.
> 
> Why would I need it if after this patch is applied the
> mips_cm_l2sync_phys_base() method will be converted to a global weak
> implementation?
> 
> > 
> > > Not sure whether it would be better than a well-known
> > > weak-attribute-based pattern. Anyway let's wait for the
> > > Thomas' opinion about your suggestion. If he thinks
> > > it would be better I'll update the patches.
> > 
> > Weak functions are not used all that much outside of a
> > couple of parts of the kernel. There is a lot of them
> > in drivers/pci/, a little bit in acpi and efi, and
> > then a bit in arch/*/, though most of that is in mips.
> 
> + a lot of them in kernel/*, some in mm/* .)
> 
> > 
> > Ifdef checks in .c files are not great, but at least they
> > are much more common than __weak functions and self-documenting.
> 
> Ok. I don't have concretely strong opinion about what is better. Let's
> wait for what Thomas thinks about this.

I've taken your patches as we get rid of this alias thing. As long as
there is no big push against __weak I'm ok with this case.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

