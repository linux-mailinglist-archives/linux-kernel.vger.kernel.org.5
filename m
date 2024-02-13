Return-Path: <linux-kernel+bounces-63456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF28852FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665342841A4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF1A381C6;
	Tue, 13 Feb 2024 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QiErncEu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B1A374DB;
	Tue, 13 Feb 2024 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824692; cv=none; b=pWIvbWpFJScPGkbM6P/b1vQt6hqlxR7T2Wk4V2Wqj1MU0sCNB2EmmNIDIzHdiPlgioUb0DPTqQ5oyDNJMTJ5uMDDMIv7KtYjfQnek+p4HDD7P9D8YekenUV3a+FDJ2ovu4YOKgOJln8RP33c8Nh3DVM8RLbncx7yrGN7x68BBIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824692; c=relaxed/simple;
	bh=YsA5rcnQOqQefsgkqKUHu8Tcv5mndPsFn90D+UEQJHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU9S1toKrQenrTs7pYNxI1n93f21kz1Bs7kZx7oJ618kA8cnTIzgDE2qLVJhnB/aryZBtNIQWO6HMX9JUV0w9H2eWtbTC7tWKNBN8MccjwWTZwrW4Xelxkj4uje42mhc9dh/x4PjDI296w20sqW9GMB4yVNRF3Of9V3sAKnOfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QiErncEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6CAC433F1;
	Tue, 13 Feb 2024 11:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707824691;
	bh=YsA5rcnQOqQefsgkqKUHu8Tcv5mndPsFn90D+UEQJHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiErncEuoyi8s1KPCXYV5phn5M8hM+j0J3fGc2+jIZyiVxzwEqvhnwjS/DFFTa+8B
	 6ZDRFXR5Ja9uyaf3cmL+bW3vn6YdLg04ZHDg4+4od9Cd65KDHwAf6n7IiLhdXcl6FC
	 lDhtgbS/vDOh5OjWTQ0IswHaK7nf6LEeNiXYZI1I=
Date: Tue, 13 Feb 2024 12:44:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev,
	Max Krummenacher <max.krummenacher@toradex.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: Regression, i.MX7 boot failure, Linux v6.1.77
Message-ID: <2024021300-traverse-anyplace-7910@gregkh>
References: <20240213112146.GA5874@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213112146.GA5874@francesco-nb>

On Tue, Feb 13, 2024 at 12:21:46PM +0100, Francesco Dolcini wrote:
> Hello Sasha,
> kernel v6.1.77 introduces a regression, with a boot failure, on i.MX7,
> with commit db30f469ae8b ("ARM: dts: imx7s: Fix nand-controller #size-cells").
> 
> The issue is known [1][2], changing `#size-cells = <0>` is formally
> correct, but do not play well with the firmware that are deployed on
> those embedded devices, leading to a boot failure.
> 
> A mitigation was implemented in the Linux kernel,
> commit 84549c816dc3 ("mtd: parsers: ofpart: add workaround for #size-cells 0")
> that was merged into v6.3, the firmware was also fixed, however existing
> device using old firmware will not boot anymore if updating to a newer
> kernel.
> 
> I would ask you to drop such a patch from any stable patches queue and
> not backport it to any older kernel.
> 
> To fix v6.1.y I see two options:
>  - backport 84549c816dc3
>  - revert db30f469ae8b
> 
> What do you prefer? Should I send myself a patch?

Backport would be best, that way we are in sync with newer releases.

I'll go queue it up now, thanks.

greg k-h

