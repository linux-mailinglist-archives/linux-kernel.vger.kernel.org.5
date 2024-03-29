Return-Path: <linux-kernel+bounces-125286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D67DD892370
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4481F240ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73F23AC0C;
	Fri, 29 Mar 2024 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9x0ClOe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4CB225A8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737510; cv=none; b=Bq+itrUCfJdN58xn3PKGliKCJ3sroFr8PYw4QZey4SN2nPOvvWkPx+gTzXue/r1kTXxHbyg2yEq8mhp/fzKTvaRKSDdxmVmUUH65O9RvtRd90l8pX77eBUfiVi9BvDLBJNc0JrCatZ7OZLydSFESCzIuxuR6bVGUMDjDX7ZRYYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737510; c=relaxed/simple;
	bh=GFlacmoNIIWiOCJCjB+aroeoVLJDrdh1Krl6zKl0MI8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LV8LDTmIFraL4BC+RkSTzqdXCx7QNNAGRmCovBjcBua0AsXHgMXHZgNEi43jECBOl/OfY6zAwucvx0n9ZtIDV8t7veuFUW4gt0eaM7RiyuwydhEBaYRZgtorgUj9ciZl17GSTn24eqamyRJUcQxS8UO9xlFJ6XXmK2FYiPti/TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9x0ClOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F233C433F1;
	Fri, 29 Mar 2024 18:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711737509;
	bh=GFlacmoNIIWiOCJCjB+aroeoVLJDrdh1Krl6zKl0MI8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b9x0ClOen18FWgKaM42OSvN4RNO9JjFqwJgipEsRraAsHgLScti+MNNf5zvN6/RrJ
	 9p1kNgCEAmtEOR3S8zJYYBSalmyZZfk6IGNiqkIvhdoOl2ezAFMiIprhD942+8ro0o
	 lGtmJGLWarMKztO511kUqgcEiUFBUpv3MzObzGE1jNybG/U0uSGE6+ovwHls6Esija
	 QWOLqQ5zL/PlXGLvaO5m6jqhgB0OiHxaWop2FQXC7HohUvrzk4fdn9VcjbeID7wP9f
	 RE0ObtmedkR7KU4Q6AGQTBJ07O9SlkROiehy9Uuwj4zp+ZQNPn07L0hPjcjd6niB8p
	 8VZUane2WacIQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240329144630.1965159-1-rf@opensource.cirrus.com>
References: <20240329144630.1965159-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] regmap: maple: Fix uninitialized symbol 'ret' warnings
Message-Id: <171173750738.1608278.15466912319940390970.b4-ty@kernel.org>
Date: Fri, 29 Mar 2024 18:38:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 29 Mar 2024 14:46:30 +0000, Richard Fitzgerald wrote:
> Fix warnings reported by smatch by initializing local 'ret' variable
> to 0.
> 
> drivers/base/regmap/regcache-maple.c:186 regcache_maple_drop()
> error: uninitialized symbol 'ret'.
> drivers/base/regmap/regcache-maple.c:290 regcache_maple_sync()
> error: uninitialized symbol 'ret'.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: maple: Fix uninitialized symbol 'ret' warnings
      commit: eaa03486d932572dfd1c5f64f9dfebe572ad88c0

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


