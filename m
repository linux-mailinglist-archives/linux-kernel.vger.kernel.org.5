Return-Path: <linux-kernel+bounces-32223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E0D8358BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24831C218B2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139E338FBB;
	Sun, 21 Jan 2024 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKxyAHfq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA61374EA;
	Sun, 21 Jan 2024 23:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705879618; cv=none; b=E4opDRSF5hWGPuLTCN1RzVh02AsTAgo3DldVVOsnu8xeNhkxVOgiyDMOrZ+ofMnYwOPK4DTFECinsq6acOyouVo0LBV3VavlUw5QkY+AqpHs/pQFpcndYQWm8M8kKlzq4LbxX9BMvukZ/9OyK5nhMDvzqbYAhaNW73Bpw3x8ryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705879618; c=relaxed/simple;
	bh=IZKqemji+2s6xvPGp2TtVNB4piug/EwftkwK599XS2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYWYEgTys9VXYTNGkhrsBH0olTZdQHtSXiAqpUg/kfU0xv231vJ+ztBoqn9LdI7FLa4MOGhIAhajtPzFDVek38i7Meg6dOAsjIyk+NxFezXN5cgDwDhEpX4EDUqwWARknb0Eifpd7rrdwK+j8CCx8JwbeiOeL9b+F/VqgavZCak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKxyAHfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D300C433F1;
	Sun, 21 Jan 2024 23:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705879617;
	bh=IZKqemji+2s6xvPGp2TtVNB4piug/EwftkwK599XS2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKxyAHfqjltv4TVoYdRP+Yv7TGeRSJFucUrHpY0COq5Ld/NpFxTf5aspAV7tHdwzE
	 apDNDSJR8Rss9w2IHGMZcFQnfOPcLMvkgeetYlnPbzZDzUoRN77DbsOQ8iDFXWP5/2
	 nVHlyjvmXxnQUCtM6seBHVVFUtCU5K8B1LxyWov1StT8CIChpJpuRIewJSEc5qfFm0
	 NFjLrChoqx7XzNoMbzV7rBzH+bkB4rCJDC2yXaVCRzCK02fwLDusqWjImEVZFj1tjk
	 oVPv262myuspf90WDtO3TD4lR8OCAdrdM0XwcCqkYVsumUCPBH8Qmnq+Cf7lHBCx3a
	 u7BmjEpmBvKMQ==
Date: Mon, 22 Jan 2024 00:26:52 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: s3c64xx: Extract FIFO depth calculation to a
 dedicated macro
Message-ID: <gmj7lfno4qcxwk7qimnsnostvjah72fbgcstcykly6nkzqrtjo@2ck2ny3ifqqw>
References: <20240120170001.3356-1-semen.protsenko@linaro.org>
 <k5ih3vurmzrirgfzy62r5nezm2sxp3zf2qa2bhzowybthkvduv@wjywn55v5hmj>
 <CAPLW+4nJKt4xNxXbqQ=c5rXCEau56Xd9ocNKqcuHLo7+-CH8-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPLW+4nJKt4xNxXbqQ=c5rXCEau56Xd9ocNKqcuHLo7+-CH8-g@mail.gmail.com>

Hi Sam,

On Sun, Jan 21, 2024 at 04:11:21PM -0600, Sam Protsenko wrote:
> On Sun, Jan 21, 2024 at 2:24 PM Andi Shyti <andi.shyti@kernel.org> wrote:
> >
> > Hi Sam,
> >
> > >       void __iomem *regs = sdd->regs;
> > >       unsigned long val = 1;
> > >       u32 status;
> > > -
> > > -     /* max fifo depth available */
> > > -     u32 max_fifo = (FIFO_LVL_MASK(sdd) >> 1) + 1;
> > > +     u32 max_fifo = FIFO_DEPTH(sdd);
> >
> > Why have you removed the comment? Perhaps you could place it on
> > the side in order to remove that awful space.
> >
> 
> The fact that `max_fifo' contains max FIFO depth is already coded in
> the variable name itself. And with that new FIFO_DEPTH() macro, it
> would be basically stating the same thing the third time on the same
> string. Thought the removal of that comment only made the code easier
> to read. If you think I should bring the comment back, please let me
> know and I'll send v2.

No, that's fine... you have a point here :-)

Andi

