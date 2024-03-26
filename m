Return-Path: <linux-kernel+bounces-118991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413D788C259
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725071C3F901
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936916D1CC;
	Tue, 26 Mar 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3MPJ6sO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91FD14A8E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456748; cv=none; b=PHKWT2tsc9yai+GhmQyObHzR6MIzJvL98uukJ4/nElIZhUxOCzA26atkNFfxm9R8RrO6wSZ+kUXcqZ0HARB1jyqLpe7aOyfu7o3mg/fZo4lnsrXlYheWZi8DKMUBOC+SJFNDM/+XhozVCO932PndyTt9ZSmB1LN7imMSY0LPvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456748; c=relaxed/simple;
	bh=aIZN4ayFWAxqe4bKOQlECj+NTdd2YL5f3lY7krQamOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PvNS2KdTc7VT7Lf06mCqydgWIgk4PQF5vFpysdXpnIxCGPbm+9iKlDpaWQu1DBlYDSbHhtJ0b9NteqqBTwWzZzCUakVNA+NCn1CpPZovjG7vtC+84ArD4FQgef9v0QIxTXbhahsEYhk7mgi04Ww/vy52w5FIVDkc24jtcPPjw/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3MPJ6sO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FD2C43394;
	Tue, 26 Mar 2024 12:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711456748;
	bh=aIZN4ayFWAxqe4bKOQlECj+NTdd2YL5f3lY7krQamOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=H3MPJ6sOxaDeI8bHhLDFMP2Ffwr6cvCkA0U+3nDbvylo/g0j9l/OlkyHD2TGM9HRl
	 ds1FvyfPZDloy+G7iQUEMRqlHqigq2GM8bAKN8ZPfLQaQ3ZD7oytI//3lTWoIFpuJq
	 DyAG/rjOUhjYxChskOOmq/wj/OV7WJNdfGiDQSfi1trxwiswy/dtFi53pXx+93mIHn
	 Q8pkaS+ZQ5thrA8EJIKCrBoSJjzwPLyC37q/dg/XSsjfBIDi4Pynsopu5HV/I+gR0K
	 /ObQQa+0ONrCFOyLy+6pe52oj312ufuQ76nd5g8ZKXJUlAMxsOnIRDdhDVJrwK+gK8
	 FzMvcEDHC9Ryw==
From: Mark Brown <broonie@kernel.org>
To: support.opensource@diasemi.com, lgirdwood@gmail.com, 
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 jagan@amarulasolutions.com, Bo Liu <liubo03@inspur.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240320085740.4604-1-liubo03@inspur.com>
References: <20240320085740.4604-1-liubo03@inspur.com>
Subject: Re: [PATCH v1 00/13] regulator: convert to use maple tree register
 cache
Message-Id: <171145674540.65165.16145640493562999646.b4-ty@kernel.org>
Date: Tue, 26 Mar 2024 12:39:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 20 Mar 2024 04:57:27 -0400, Bo Liu wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Bo Liu (13):
>   regulator: da9121: convert to use maple tree register cache
>   regulator: da9211: convert to use maple tree register cache
>   regulator: isl9305: convert to use maple tree register cache
>   regulator: max8973: convert to use maple tree register cache
>   regulator: mt6311: convert to use maple tree register cache
>   regulator: pca9450: convert to use maple tree register cache
>   regulator: pf8x00: convert to use maple tree register cache
>   regulator: pfuze100: convert to use maple tree register cache
>   regulator: rtmv20: convert to use maple tree register cache
>   regulator: rtq6752: convert to use maple tree register cache
>   regulator: tps51632: convert to use maple tree register cache
>   regulator: tps62360: convert to use maple tree register cache
>   regulator: rpi-panel-attiny: convert to use maple tree register cache
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[01/13] regulator: da9121: convert to use maple tree register cache
        commit: d92eb7c333c5ac8d8add10d5a211ac9c405e4393
[02/13] regulator: da9211: convert to use maple tree register cache
        commit: 03ddbcbe2f1ca9fac2759849be6714d8e82aa331
[03/13] regulator: isl9305: convert to use maple tree register cache
        commit: 66a4ead5ed9393d250105fcbe6e3525e1cdd977a
[04/13] regulator: max8973: convert to use maple tree register cache
        commit: 36649db5b216a85cfd7937a289c4cdd0b4b69126
[05/13] regulator: mt6311: convert to use maple tree register cache
        commit: bc125125125c10ec14764d153227c95ad0fd0b48
[06/13] regulator: pca9450: convert to use maple tree register cache
        commit: 0b03e9cb8b137490f4adedf07482384ffeee7145
[07/13] regulator: pf8x00: convert to use maple tree register cache
        commit: cea065dced280306ff5a4f7adfeb3773c49b2818
[08/13] regulator: pfuze100: convert to use maple tree register cache
        commit: 0332f074f5c3d8c2a32db24c9dcc3c3f13056cef
[09/13] regulator: rtmv20: convert to use maple tree register cache
        commit: 43edba6b670bc4f5426e77873b400fe91f8d3c75
[10/13] regulator: rtq6752: convert to use maple tree register cache
        commit: 81c180e77d60755ca5ff217786e2f427ccab04e0
[11/13] regulator: tps51632: convert to use maple tree register cache
        commit: 9500d38e50d0cfd33536454a204dedb9d47d84a3
[12/13] regulator: tps62360: convert to use maple tree register cache
        commit: fe258f54c0a85c1bfc0e836e20c3e4e52f1a8318
[13/13] regulator: rpi-panel-attiny: convert to use maple tree register cache
        commit: ab470abe58c09b2fbe2c1478e67a904fd803e84f

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


