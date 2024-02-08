Return-Path: <linux-kernel+bounces-58228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAB784E31F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B744291BCA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8573C6A347;
	Thu,  8 Feb 2024 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mzw/vndl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD87640C;
	Thu,  8 Feb 2024 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402393; cv=none; b=tlz6hkSdKcJfHYhlqJFDgpdpnHlwp6m050Jppd3NDlgFh1lh0J+BZi3M0S14I/ufxPEgGZA4cFEupbp3xo0VTgT/V2yyRpeZWD1/l58FgqnGED2Kr7bGUV3WPmvsmHBWDiT53BsTvPbPsXbMc3q8rNwHgyTPDml5TSx5Cu4lhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402393; c=relaxed/simple;
	bh=74U9Xloo387R0IhhlVAzj5N29H04adqCBrWyKIMXu3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/WvXwMtpKcnYRnCPiJqYELkliSDxNTMD+GN2uMpiPhj7NCp+tdiyQmj4Iwbv88wqyntQprCYPUPhen1CiW6YSXNAId/sRHAAJjIJyIGPHGxuQktbf5t7+Riuxhx3OLVIZLlIlVVY/CdrN0ilsDsGkrrv6En//LXMpBQ/d8cHBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mzw/vndl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F4AC433F1;
	Thu,  8 Feb 2024 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707402393;
	bh=74U9Xloo387R0IhhlVAzj5N29H04adqCBrWyKIMXu3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mzw/vndl+wVBmlcMrrQ6MYI78PsADo5rR8uoj68ZNXw/NrF9o5nTp7XYuH6HTgK0n
	 jFeOWrfo/nwQxR9yDFbQjDt+JofvgkZV0ucOyYg2CrUud1DdUJ1obso7IFHeHZuGu1
	 eomDGKLh35kpPO50ozRxObPv9r5bO66fgYTyvWEFExv6bbYpzYkqVK6CcWMPvY7L7o
	 7w0xqajOLC6/p2eDjdicKoQNVtYF9CgK3vvbxL10bZ+WjeXI1E5rRDMdH8Se5GHDaw
	 dPZ0GPRl7DgR8fD5gJ9QFHs7xpyfzTPHggI5eMvjmA6CPOkRgDDW+c+ixrlHqfH23L
	 +KDraKyxtNoaA==
Date: Thu, 8 Feb 2024 14:26:27 +0000
From: Lee Jones <lee@kernel.org>
To: wens@csie.org, marek.vasut+renesas@gmail.com,
	support.opensource@diasemi.com, neil.armstrong@linaro.org,
	ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
	mazziesaccount@gmail.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, Bo Liu <liubo03@inspur.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-amlogic@lists.infradead.org, patches@opensource.cirrus.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/18] mfd: convert to use maple tree register cache
Message-ID: <20240208142627.GT689448@google.com>
References: <20240206071314.8721-1-liubo03@inspur.com>
 <170740229742.1068783.15434523911244194304.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170740229742.1068783.15434523911244194304.b4-ty@kernel.org>

On Thu, 08 Feb 2024, Lee Jones wrote:

> On Tue, 06 Feb 2024 02:12:56 -0500, Bo Liu wrote:
> > The maple tree register cache is based on a much more modern data structure
> > than the rbtree cache and makes optimisation choices which are probably
> > more appropriate for modern systems than those made by the rbtree cache.
> > 
> > Bo Liu (18):
> >   mfd: ac100: convert to use maple tree register cache
> >   mfd: as3711: convert to use maple tree register cache
> >   mfd: as3722: convert to use maple tree register cache
> >   mfd: axp20x: convert to use maple tree register cache
> >   mfd: bcm590xx: convert to use maple tree register cache
> >   mfd: bd9571mwv: convert to use maple tree register cache
> >   mfd: dialog: convert to use maple tree register cache
> >   mfd: khadas-mcu: convert to use maple tree register cache
> >   mfd: lochnagar-i2c: convert to use maple tree register cache
> >   mfd: wolfson: convert to use maple tree register cache
> >   mfd: rohm: convert to use maple tree register cache
> >   mfd: rk8xx: convert to use maple tree register cache
> >   mfd: rn5t618: convert to use maple tree register cache
> >   mfd: rsmu_i2c: convert to use maple tree register cache
> >   mfd: si476x: convert to use maple tree register cache
> >   mfd: stmfx: convert to use maple tree register cache
> >   mfd: stpmic1: convert to use maple tree register cache
> >   mfd: rc5t583: convert to use maple tree register cache
> > 
> > [...]
> 
> Applied, thanks!
> 
> [01/18] mfd: ac100: convert to use maple tree register cache
>         commit: 8745a81ac22f42c7233fbddc6aa5922b231aac2a
> [02/18] mfd: as3711: convert to use maple tree register cache
>         commit: 780b1aa441a3d64e400cb2ea96bc3e162322eb31
> [03/18] mfd: as3722: convert to use maple tree register cache
>         commit: aea5c3cbc51eee3ac25ff8f936252901c4549011
> [04/18] mfd: axp20x: convert to use maple tree register cache
>         commit: 009073d504f67146d936cc45f21cc27c1bc15490
> [05/18] mfd: bcm590xx: convert to use maple tree register cache
>         commit: 684c1f0b79417cf08810dfd57c5a549a9741ad7a
> [06/18] mfd: bd9571mwv: convert to use maple tree register cache
>         commit: 35b1b8622ca3172b3c6b2a377e5913bac0367634
> [07/18] mfd: dialog: convert to use maple tree register cache
>         commit: 1cb7a3bca56c124ca9e5c13fcac7de884c195c5c
> [08/18] mfd: khadas-mcu: convert to use maple tree register cache
>         commit: 5f734f5f374f68960afd2130a5ce982912c14c15
> [09/18] mfd: lochnagar-i2c: convert to use maple tree register cache
>         commit: 8881896e05b6a91251dde0ce21ce79c2c201888d
> [10/18] mfd: wolfson: convert to use maple tree register cache
>         commit: f353b2c639e4f4ac9831d94c8237026cebaa8e73
> [11/18] mfd: rohm: convert to use maple tree register cache
>         commit: aabd38f3779b8108b65cc7ae8b5c20a6c352b0a2
> [12/18] mfd: rk8xx: convert to use maple tree register cache
>         commit: 08aa1e797a5cc97d2106476263f938342e72015e
> [13/18] mfd: rn5t618: convert to use maple tree register cache
>         commit: a011cacb63c3ff6562bd86afae8cdd49d0f075c9
> [14/18] mfd: rsmu_i2c: convert to use maple tree register cache
>         commit: b85821cecdf933420a6ba93658e1e4710644f5c1
> [15/18] mfd: si476x: convert to use maple tree register cache
>         commit: 030473871c3f4f126bd43018517abfcb070f6b95
> [16/18] mfd: stmfx: convert to use maple tree register cache
>         commit: 87a48e35ce2ef992287b828b1268bedc7415d2de
> [17/18] mfd: stpmic1: convert to use maple tree register cache
>         commit: ab993d2d68951db3ebfeaa44567a790ec566526d
> [18/18] mfd: rc5t583: convert to use maple tree register cache
>         commit: d5132d176d6f21742ac67fd311ccc61fe830e999

Next time you send a large patch-set, could you please ensure the
subject line format matches that of the subsystem you're submitting to
please?  It would have a saved me from a whole bunch of fix-ups.

Thanks.

-- 
Lee Jones [李琼斯]

