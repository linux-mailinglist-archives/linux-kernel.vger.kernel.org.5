Return-Path: <linux-kernel+bounces-136915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE9989D9CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A111F2268B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDE912F599;
	Tue,  9 Apr 2024 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEUwV5u/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A7F12E1F0;
	Tue,  9 Apr 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668073; cv=none; b=t35JGuB4g17+QzGq0i4A4F+H+pa/j3DORaACAYBaPNm0ytzsxrxUHmpyzKKq9oVfIf7z1L2EtIOfnLb7yLw9/M4soBjS7yhl46LvFmfH6SrQ7Z3lFTo3jASlCSbMHNO4tZdG2gQyO0kLOGpkXIG2HkLBSE3V0dG/v8tarOqwjL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668073; c=relaxed/simple;
	bh=ouy2Y6x2V5/uoESyJnNA235PE5cU8gwdY/QEcC9jK9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EE/X0h0p5ji8I2AzMRveXJmNfE0yJmrqn3Vvki3iop1wUPq2Yve4v0lWgBpxBqhz7rp34eJTKhOctiTcLshynXfMFStPL08h84Y/iDzT5F9oCIJCdVYROVTQoB2I+V/5s4f0ln9N8eG0y5O0QmVvNiZ7Pf8FJNqLut4Jc8KgM6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEUwV5u/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E36BC433F1;
	Tue,  9 Apr 2024 13:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712668073;
	bh=ouy2Y6x2V5/uoESyJnNA235PE5cU8gwdY/QEcC9jK9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jEUwV5u/RKtUi7ai+UUBmn1fKwYn+9jGR2SXBlyansUuEsQgR8HXXtm31IPJtost4
	 QfA5GafyjBNcPOXqu+NrYi77jpsDrC+ZuPMcgFZjTNJ+6ARc7lsuGc+VDs3KHokycl
	 sjHX+BV6Xn0IZ6E58P/whNgejKdwbqyK/FHtL0JhYcEYQJ/ZPhUYN/Mag1ER44pINz
	 iYhCsEWtBBeCdWMpB+Ps65LDRILWcvdXg+bv4ZuENQJ92eGqXeL8GqUGSixfQTnUGJ
	 oERhOfzi6CyWML3nUoZ3EoWjnwuaFCYcfFNquEqpZiDWcaCVocaTD01T/liOD92UYh
	 ejo3unZrpJgIg==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, 
 Sameer Pujar <spujar@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lgirdwood@gmail.com, thierry.reding@gmail.com, jonathanh@nvidia.com, 
 mkumard@nvidia.com, stable@vger.kernel.org
In-Reply-To: <20240405104306.551036-1-spujar@nvidia.com>
References: <20240405104306.551036-1-spujar@nvidia.com>
Subject: Re: [RESEND PATCH v2] ASoC: tegra: Fix DSPK 16-bit playback
Message-Id: <171266807089.28088.2212378797581391571.b4-ty@kernel.org>
Date: Tue, 09 Apr 2024 14:07:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 05 Apr 2024 10:43:06 +0000, Sameer Pujar wrote:
> DSPK configuration is wrong for 16-bit playback and this happens because
> the client config is always fixed at 24-bit in hw_params(). Fix this by
> updating the client config to 16-bit for the respective playback.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: Fix DSPK 16-bit playback
      commit: 2e93a29b48a017c777d4fcbfcc51aba4e6a90d38

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


