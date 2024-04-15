Return-Path: <linux-kernel+bounces-144486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342548A46EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CBE8B224C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD18117556;
	Mon, 15 Apr 2024 02:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7lZRSEd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0483A848D;
	Mon, 15 Apr 2024 02:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713147976; cv=none; b=egIieX4GoC6/Ajct+1IsmxZVpda3pOvzCsrUq60UuLeOd7W54n0i7qyZFKEEVqCqBA7qqn+XQhIpn+zxMGf4tgBDl+SEFZ4ihucuAMcsxhkwW+qIzF3f0cuE+jxu68Ui6FceiYEeSKoXo6Ulmo3PG8lXv86oM9qZW+VeHQEzGuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713147976; c=relaxed/simple;
	bh=d+sWxRJcFYWDfl1g1hpky8Wk0cZLGATyDM6LOemMcEs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b7wJjcHLsgH+JZQ7/O26lf/aQsuY++iDJsnOieKghcwxZxZpvlEReElssWbClwvjZg9uJT9AAJ3D9gMtLGRo10t8Aw4GQw4Nv13fkex9XrIGeS+eOYKizidl1GOWi0WaBA+j0exkhIS8sxOkH5S+EWlCEGYaLk2yO6BAJ+RQNYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7lZRSEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8306C072AA;
	Mon, 15 Apr 2024 02:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713147975;
	bh=d+sWxRJcFYWDfl1g1hpky8Wk0cZLGATyDM6LOemMcEs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=c7lZRSEdzsr9Nn7/FXaeq0JgYid1V+ueNmv08TM4w20O7u2isRkZaFyTN0gTv1gcB
	 fqyHyfU+Syw8NJXZaye4+LLW6qH9bOu1knw/wzrFgBsFI+l6RdK1I7bPTDDDZILTsU
	 NzQtbQDWnGgVSY96N9+CtIxVzw1JQRh2K1rPP+TkgRNEKohtaDRDZsegsptcIrSURD
	 ZFUkqCUOXuv+ot8BgXOsraZFEoF5sZOox0htdfFumc+5wgfsJuQys10/rPg86RcrMP
	 U31q/+ivTZ02F/DhCUhUcTm9tlU6pNKt6ydIAwGSoLhR9jhEw3C5q4ghIaf6YD+/OT
	 4tr3KWl6/r76Q==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <450dd21a-b24b-48ba-9aa4-c02e4617852f@moroto.mountain>
References: <450dd21a-b24b-48ba-9aa4-c02e4617852f@moroto.mountain>
Subject: Re: [PATCH v3] ASoC: soc-card: soc-card-test: Fix some error
 handling in init()
Message-Id: <171314797306.1649319.17265441558891168082.b4-ty@kernel.org>
Date: Mon, 15 Apr 2024 11:26:13 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 12 Apr 2024 15:07:01 +0300, Dan Carpenter wrote:
> There are two issues here:
> 1) The get_device() needs a matching put_device() on error paths.
> 2) The "if (!ret)" was supposed to be "if (ret)".
> 
> I re-arranged the code a bit to do the allocation before the
> get_device().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-card: soc-card-test: Fix some error handling in init()
      commit: a8cad4a4e431e250edc05242a8ca1be6e4b33749

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


