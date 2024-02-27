Return-Path: <linux-kernel+bounces-83571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F050869BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7CCB2CDC6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1341474DC;
	Tue, 27 Feb 2024 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh/nTfR1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD54146E8D;
	Tue, 27 Feb 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050219; cv=none; b=LZvlzEAp2bFVHZgmORmdI1hxMmLCeZapIBNWlJyxmfU4bG6HEbymTvi1YgcVgWEFtRHgbypwnIwDwtp1jX7nfE1+OAvIdDiR18ktetB8JrzlFQH0TlEU9Ec0+rveaS1LsyjZN2AIrS6VVTWCoL9qlZmwx1qHWoTlC+ayHz8G86s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050219; c=relaxed/simple;
	bh=cN+V1mjBJaEyjI2HaATBxgd/1peblTgEH/q3L/Z12ag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XkQv3z+1P3S4fMEEgTjrGXEeGmdC9HdJDrfxk4t2+5TJJwNLnOyar19i2iMGnx2y/ByOdj1/MOsEbN1dx5oOcjv/hSKFP0Tum7uP6BlcFOoAljJUNxaHrA/BK5mT/KDMtIOFfbPJnIPAVtqh3tZjEFeEZPFcc09GUa/RMJkoGDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh/nTfR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688D5C433C7;
	Tue, 27 Feb 2024 16:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709050219;
	bh=cN+V1mjBJaEyjI2HaATBxgd/1peblTgEH/q3L/Z12ag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Kh/nTfR1g7N/a4Z1HS9yyw7PCkABwUuz4oRVzyIoxnXWQpZ2aiiMog3OwwGtxW5Iv
	 SlrooLi9nUTXV8f8eY86kjjrB/RRQiGmZTAyHPbNZg0e4JvMzb3TP5HWifH2hKq+tQ
	 WhI96RDzEQ3pMzNTez5jUYCket9p6M3rUU52wfVIZT5wVwk9wGEiMQL80+KTtpHCDx
	 thOXQT9rSzV1wqi/RKPnNODUK31ALXGM20UVoyWKvUHSgkeRSygGLKF++GFkbVqZsg
	 Ch8rT9GKKZbansHF4ZlUfDqo8CzE800H47arHb4sgTeKHVKTaYXZOA87xwVDgvmSVM
	 vlAj3QWh3zgcQ==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240227100042.99-1-rf@opensource.cirrus.com>
References: <20240227100042.99-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l56: Prevent bad sign extension in
 cs35l56_read_silicon_uid()
Message-Id: <170905021816.83159.8702222315975677755.b4-ty@kernel.org>
Date: Tue, 27 Feb 2024 16:10:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 27 Feb 2024 10:00:42 +0000, Richard Fitzgerald wrote:
> Cast u8 values to u32 when using them to build a 32-bit unsigned value
> that is then stored in a u64. This avoids the possibility of a bad sign
> extension where the u8 is implicitly extended to an int, thus changing it
> from an unsigned to a signed value.
> 
> Whether this is a real problem is debatable, but it does no harm to
> ensure that the u8 are cast to a suitable type for shifting.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: Prevent bad sign extension in cs35l56_read_silicon_uid()
      commit: cb9d8a2c6cb7cbb0fc919defe4fae741bfcae9de

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


