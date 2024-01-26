Return-Path: <linux-kernel+bounces-40421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6A983DFDA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF082823C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB01200DD;
	Fri, 26 Jan 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHwUwIJ/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6D208A2;
	Fri, 26 Jan 2024 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289592; cv=none; b=HSKfIeccHgbxM38W2QX9tFMQfCvFwBq6EsMDgLs1CjHrKPSqHnFV927b+Ojt4evTRgkVVhLfeF8JdHi2uVZf3gxYl7XhkR40rq4Mxcm3kuzeRTxShiL/tquUjXa1XO1cD8Kfqf6AGrxOFyO9Qyzbn7T3QpbTXdkq7UlzDStfF2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289592; c=relaxed/simple;
	bh=oLhJ0TDofStmHxmS0hOT9Ye/hGgu53RmaintzDkDkLE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WPuIv8IsGGD8Ltx+jr4VbtZ/aV2sa6eGw8ZsuSpHYNIOIxim9ecpRBA9lPAIBtPraPdVx+6IDpCQBbA0H7ESxqyntqzvjzNWgZHtLtIQlpsfaUBCm8lt5oUOpNFF7sDsXRpGfmCggSOjiYHfT3BjARteBJmPBt6tVkb6l4+xIIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHwUwIJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF24C433C7;
	Fri, 26 Jan 2024 17:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706289591;
	bh=oLhJ0TDofStmHxmS0hOT9Ye/hGgu53RmaintzDkDkLE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mHwUwIJ/DZHQ5PacrvTDfABCVoZEeSGhS4RavijWYCyMyZZB+wynH1t6NBnzJ86hz
	 RoVOplBC25mQI6T0MBaVvSDNm3MWSI0c9CBHeLC0n/9ntvKVJWYEAfWqT/YzDChX/S
	 Lk3b/DesmYDbcRAFuwnPySrOX5O/GaA4/Zt725cpxJxHh5s9918hZp4+ToIBChFBjB
	 5ouqPMGYslTfuTbYo4sT4Uh8PYrL69YVNz7Np/XKh4c4oS/6MrQQTmxb1JYxaIdBj4
	 XhmLOBFRZ+s5KhT8uDJGvM/jVW3J7y995EJevDy07J252cugXJkty+x3IDgGk7AjZe
	 Dh11kdO+XGGuQ==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240125234732.3530278-2-dlechner@baylibre.com>
References: <20240125234732.3530278-2-dlechner@baylibre.com>
Subject: Re: [PATCH] spi: avoid double validation in __spi_sync()
Message-Id: <170628959040.45943.13524848368852382338.b4-ty@kernel.org>
Date: Fri, 26 Jan 2024 17:19:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 25 Jan 2024 17:47:31 -0600, David Lechner wrote:
> The __spi_sync() function calls __spi_validate() early in the function.
> Later, it can call spi_async_locked() which calls __spi_validate()
> again. __spi_validate() is an expensive function, so we can improve
> performance measurably by avoiding calling it twice.
> 
> Instead of calling spi_async_locked(), we can call __spi_async() with
> the spin lock held.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: avoid double validation in __spi_sync()
      commit: 0da9a5794cfda615668eaefde811e8ef378134fe

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


