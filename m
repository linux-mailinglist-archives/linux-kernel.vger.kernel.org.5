Return-Path: <linux-kernel+bounces-157025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0298B0BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F01D1F260F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370F115D5C8;
	Wed, 24 Apr 2024 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F07vCwnL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3C015AABA;
	Wed, 24 Apr 2024 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967097; cv=none; b=ZO21wCkp2X7hQjxQSfpeGkSKAw7KBebHo+oC4dZ/zsBgBMot7cK4qgqfkIWm5GNXd7ASfdUlVKq7VuJqGl9BMtWDE+TvuI88zEdryJu9dPkV/LBOHy+PC0Yi/OHT6vmX0rQ/R727YJPfwZznS2z9SfkkQDss/6SYRWKv+gKYdsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967097; c=relaxed/simple;
	bh=Afq8vLmAE+qCCl2HmnmDP+o9JdHQk9PnlwEPI8RcoBs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CVVgdpJAf5ybNodZlmfIABj9ablXVK/0eIs10z3S49083b6eocp8OodoEehepbPDUl24dGa0PYuKPS1cjsChDPL7lP6OUeQm1Bwz36fuerr6zwiWi80usWh2oNPNCBzV3ThNDFWbCBO7kVhtQH26jvymlPm+n/nttHfTklhAY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F07vCwnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F01EC113CD;
	Wed, 24 Apr 2024 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713967097;
	bh=Afq8vLmAE+qCCl2HmnmDP+o9JdHQk9PnlwEPI8RcoBs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=F07vCwnLUDITkyHbO7sRvmeoHVumKv/tMB2rYMt21SAhH1Sio36ZjznBvnYA2aHCg
	 D5lVguP1spjgSIl94M4ykdxT+Q9g0qXWuWgwxX6HFYNXh8ahhfxxtNGR0TJ8F91s51
	 ssHAAkPcnH1UnAXv/n4fYugSUSIBe7BHf/qTonWOCuPlZC/ftBwqpYOFfoOuTpWejM
	 Fma6w+IFDza+s2YfIxNknwwATDzI/bbO7r8Zo64LDentxSDAs6d99xCFjr5jEIxFav
	 ID8jeGXcZi1pvrPgnS7mU42QI+eGvXL3TgOYAoAf/1NF5j/K/q5uTFtgy5igOjZuYL
	 Pbk53lCF6JMTw==
From: Mark Brown <broonie@kernel.org>
To: andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org, 
 alim.akhtar@samsung.com, Shivani Gupta <shivani07g@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com, 
 Julia Lawall <julia.lawall@inria.fr>
In-Reply-To: <20240418000505.731724-1-shivani07g@gmail.com>
References: <20240418000505.731724-1-shivani07g@gmail.com>
Subject: Re: [PATCH] spi: spi-s3c64xx.c: Remove of_node_put for auto
 cleanup
Message-Id: <171396709284.1797640.6026362113699687178.b4-ty@kernel.org>
Date: Wed, 24 Apr 2024 22:58:12 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 18 Apr 2024 00:05:05 +0000, Shivani Gupta wrote:
> Use the scope based of_node_put() cleanup in s3c64xx_spi_csinfo to
> automatically release the device node with the __free() cleanup handler
> Initialize data_np at the point of declaration for clarity of scope.
> 
> This change reduces the risk of memory leaks and simplifies the code by
> removing manual node put call.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-s3c64xx.c: Remove of_node_put for auto cleanup
      commit: abba116f601800a0c74b9a9c2c91e2eebca791c1

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


