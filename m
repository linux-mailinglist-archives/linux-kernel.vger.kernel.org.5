Return-Path: <linux-kernel+bounces-56903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A898E84D10D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A3B1C25F79
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1082D97;
	Wed,  7 Feb 2024 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdLSF95R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB571B7F0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330061; cv=none; b=lEi3G/Gw1HFyyyuMgAsgH76L5ysjTIL4eygf2dGCOz/IsHJxM8iwQaUtcF5TF5eZi9ri7azbZ51/PrM4V28wnt7d5rYRgfBR2HLMrerlO18v6n1VcO3hhDe1DxS3QCA1qwQhXQMJlni3PQf8ppjB6v6i//cM55x6RuamIQ1TviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330061; c=relaxed/simple;
	bh=wLd0ptiOLe++cgHkBGPDLsldtjGM/4fSCRnqqtGdg3k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n5pyvTNyqDsuq5oD4MN96kY//JuIp8IDF0H3FHxodXFY3vbki6pMneIkOyZ6Gbuxd7T6flKKoYZtQkYtnmS0+ndsaphmUt+KFI2/Iw4g9wTG7UvdDmtlSXxtyN+IsP6+Smuyuj3zAL+5nZKmrpcQKDK6Ub5LZtPTWi+ZMmCZmOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdLSF95R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E6BC433C7;
	Wed,  7 Feb 2024 18:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707330061;
	bh=wLd0ptiOLe++cgHkBGPDLsldtjGM/4fSCRnqqtGdg3k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fdLSF95RmeFkkDcC+WiTV1CfYarJm6wO3LqG7cIywdo7f2eqcc4wnD3ZTfL+YlTrh
	 MzbSWr5aDYLCcmW2hhLnKVbuOO1wPzaXGEjzJBU7vF37Ah8JGBBNc+Xt1V8gaDfBHp
	 5UOSrZhiMqRtq8ybi5/nqC38wAH86H+z2w2Lzy7k+pgw3xXRyilVscjEkj09mGKULX
	 Gp3RhYgGdGTxHl5bVxA5DE6ATQSPi0xPSKMeEluw5kzFZKKQ0eiMlRJxOwcnWPrO+e
	 pDAdlDvFahFWDnR+5jVupNE6qndJtdcGYstA3nc8gEkgQ1pUxqscrcFP3llpRU8dDP
	 YKISvSrxaI3Pg==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20240206151004.1636761-2-ben.wolsieffer@hefring.com>
References: <20240206151004.1636761-2-ben.wolsieffer@hefring.com>
Subject: Re: [PATCH] regmap: kunit: fix raw noinc write test wrapping
Message-Id: <170733005913.1096790.12036692137132964034.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 18:20:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Tue, 06 Feb 2024 10:10:05 -0500, Ben Wolsieffer wrote:
> The raw noinc write test places a known value in the register following
> the noinc register to verify that it is not disturbed by the noinc
> write. This test ensures this value is distinct by adding 100 to the
> second element of the noinc write data.
> 
> The regmap registers are 16-bit, while the test value is stored in an
> unsigned int. Therefore, adding 100 may cause the register to wrap while
> the test value does not, causing the test to fail. This patch fixes this
> by changing val_test and val_last from unsigned int to u16.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: kunit: fix raw noinc write test wrapping
      commit: 7011b51f13b391ee06708bb1f82653a2953f8cfc

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


