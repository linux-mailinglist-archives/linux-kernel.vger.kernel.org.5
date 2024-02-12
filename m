Return-Path: <linux-kernel+bounces-62385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF7B851F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67788284D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997E14DA04;
	Mon, 12 Feb 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AW8hhmHM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36014D9FF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772940; cv=none; b=R2ps9BKjlgKvhFTF4o+7c3NgbRmMV71zQWEgnlooujNJh71VP/aj1bCbyLvXSmRf6Z1eAmHeIo9qelzGhBj0dhgw8hbXCHaephfpAXGgBYseZ3XIIv7Nss4j/ci5mTmfuI/dzcjMbMRoFRbmZ8jce1oerxkqy78ER3/yufPr6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772940; c=relaxed/simple;
	bh=LIxTccWoorHIITd/VDAjFkiUFMVSOZQnVaGfkd11HPE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C1kX82oJRQ1wGtZP5W15JLv34dpPr+Expy9gfUKHBP88+DHYEdPasBYmgo4/V6XN3Qwv02LPZzZDvY6q7Ohp4Fr/u4HSuo1+rxgFNFIjcJFe2v04P7dSx+w6V+NWjdywJEDoXlaEXKrwa13JjixU0/4Y5A7miJyikL+VDeCd210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AW8hhmHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E316C433F1;
	Mon, 12 Feb 2024 21:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707772939;
	bh=LIxTccWoorHIITd/VDAjFkiUFMVSOZQnVaGfkd11HPE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AW8hhmHMQ5JVuBthO7B07l0I9ZPtJ+so7ArXB8yDNhVvlSJREy00udRRbht1gsQtv
	 dWWjovdIB4Dkf2/GVGX+yO52KInnJRx5cY/7Y6H0wLp6pWPIyIA2URG0wUDEOFRxiN
	 YHT2ghdk9YG7XdTLMFrBHXiphBQF+uT2X7H8V4m5ZRzJwArCDrjGjdmG7PcGcPLEHm
	 IQU7sKMBgjwzcrUvy2RUSrNS6T0pC/y0hqZbC7n0QWkaYbm/aQP/15rUHBLo42gJqJ
	 tIT9OdB6bW/AWmC7JCLbvhUtKtWV9eOJqv0IwP34o5ijriiOluq+T/o0MM/wtFmY9Q
	 RmAruQZ5doNog==
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240211-regmap-kunit-random-change-v3-1-e387a9ea4468@kernel.org>
References: <20240211-regmap-kunit-random-change-v3-1-e387a9ea4468@kernel.org>
Subject: Re: [PATCH v3] regmap: kunit: Ensure that changed bytes are
 actually different
Message-Id: <170777293827.74177.17171982249680601088.b4-ty@kernel.org>
Date: Mon, 12 Feb 2024 21:22:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Sun, 11 Feb 2024 16:58:17 +0000, Mark Brown wrote:
> During the cache sync test we verify that values we expect to have been
> written only to the cache do not appear in the hardware. This works most
> of the time but since we randomly generate both the original and new values
> there is a low probability that these values may actually be the same.
> Wrap get_random_bytes() to ensure that the values are different, there
> are other tests which should have similar verification that we actually
> changed something.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: kunit: Ensure that changed bytes are actually different
      commit: 2f0dbb24f78a333433a2b875c0b76bf55c119cd4

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


