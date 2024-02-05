Return-Path: <linux-kernel+bounces-53053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6125584A018
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8651F223E4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB28940BEB;
	Mon,  5 Feb 2024 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxLNYSsg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AA44C7B;
	Mon,  5 Feb 2024 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152316; cv=none; b=Fw3Q0OuSX5yzL0Cb4SKcw2d7PCOHSxje7CRGKRNvU7qPPTJ+7AVnSczEbhlbZsbkcn38tDwxcKMhSu4P/SXqDwR88gVYyEbD02HWsvmADWGwU7eu0lwoXgA582+bckKtQZqeqTV/0tPYAi4ry/pG/eWelceaB0cbLoXww4p4LhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152316; c=relaxed/simple;
	bh=d3MHcE60+aEolo8yoxGkE+jYHNZc2enKn6A6LrbJtfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m4cVLsUUKDYPBxK2UORkXIfkLFTkW/ySfZqNdftLPp+7/QZhckwIhQlBTksVHrBkrsI7vO05kChGk3pQCxX5IGTC/mcuqtrKBScjoFg9mBTi3PQRXLSbeZFadFOYgqkTBOs5YdeyCfe3TgqClQ5TzpQZjr6KhHkC4Z9gInIycAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxLNYSsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E628C433F1;
	Mon,  5 Feb 2024 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707152315;
	bh=d3MHcE60+aEolo8yoxGkE+jYHNZc2enKn6A6LrbJtfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BxLNYSsgyWXjOQlBq/UM1PQu9D8GiKu7jgV85Pbc7gZldree/qIejh3lw0cGvR3rG
	 mjHGNXTRMV7oftGNdv+wz8bcIhV57ysafTzHPN5+uAUO/G0DsgqW0+mDH5D7ITHeri
	 5Jq5ddr6NJ0P2KUdljd8c+Cfjw4rgTCL/JWAISw50RsQLVSb3xaZdNHdXkCxktD9dE
	 y5Gk+QYbq06q/JWMe+h3p8z3fg5mw4uVihCMXI1tzis15RJqqCK6vDRGLBXkOhVGLa
	 3FQyi0Wj++Neairf9Y1DSQjlqgqHqBOqsmK5V0gIotRxkJ11WBc8zoHYMa4heTyCr1
	 xSpriaNwY7XkA==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: James Schulman <james.schulman@cirrus.com>, 
 David Rhodes <david.rhodes@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <0c254c07-d1c0-4a5c-a22b-7e135cab032c@moroto.mountain>
References: <0c254c07-d1c0-4a5c-a22b-7e135cab032c@moroto.mountain>
Subject: Re: [PATCH] ASoC: cs35l56: fix reversed if statement in
 cs35l56_dspwait_asp1tx_put()
Message-Id: <170715231128.801804.92834537524909316.b4-ty@kernel.org>
Date: Mon, 05 Feb 2024 16:58:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Mon, 05 Feb 2024 15:44:30 +0300, Dan Carpenter wrote:
> It looks like the "!" character was added accidentally.  The
> regmap_update_bits_check() function is normally going to succeed.  This
> means the rest of the function is unreachable and we don't handle the
> situation where "changed" is true correctly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l56: fix reversed if statement in cs35l56_dspwait_asp1tx_put()
      commit: 4703b014f28bf7a2e56d1da238ee95ef6c5ce76b

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


