Return-Path: <linux-kernel+bounces-75073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1193E85E292
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81032855EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E48E85922;
	Wed, 21 Feb 2024 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXKV4C4/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7D8565A;
	Wed, 21 Feb 2024 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531377; cv=none; b=KKHZ8e259TnQbpiB5o5skHCbUvKmdp6sr0gDVoXtbok/3w8+KIPb+bw1pVJjvmfNUcFwcqSPmef4em5mgINGaa577LyLU3E0WAK4kGt9xSaamznOYPcYkx5HeBHy34fJdLwZIfD+3pYZAzfFHBMCKwJjzTtHTuq6kb/nX/0w9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531377; c=relaxed/simple;
	bh=9fJX9oO0DGcUweTUdjv0zxo4kkH5IB9QrIr5JPgthHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ii5yhYcrLoLkANsT5sWNYyykmp6a5p3S1hNS65jgSEuK2By/YTQGRwnNeXt1nOPgQcf4XkkW7KYqCcDzOuVmLIQ+/mqXimZcMPZrdxBbiXFG04vuQpTBXHnM7mxJkM3AmklfClWE4cHBvaf9GYRQg0390Xo38JEZ24mjBooGED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXKV4C4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2C8C43394;
	Wed, 21 Feb 2024 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708531377;
	bh=9fJX9oO0DGcUweTUdjv0zxo4kkH5IB9QrIr5JPgthHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pXKV4C4/Z6bGtoSgNen3zLm43KFCgUokA3jbBRFCTHGJyzEyqu9KsXR6uIPPJS5s4
	 7WPR+dOTn1cC57QOy9m1vVwn8jTo/NAnlIWbUdMfMZQo4LuiQ5vpOL+QzjOJf7YHHw
	 hZKHAdgOcZzszBRFQ0utz5PybEg+dQ8PRliweOsQwV/lmJlGkiaj2dRcwDbPAY3TeO
	 GjjhfvblX9gkBcZXa2mJCrMbojgsCnnzsKrPdH0rOu3FDlFKyzK0/fk/Ff3fj1SnKo
	 iI+uSV44VCnWMaGhSxzl87b/yS7yZYhamNpMGLQixB9gJJzM9cbWCBhpa9n3uxYVDW
	 6bHIOctxbhvIQ==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>, 
 Venkata Prasad Potturu <quic_potturu@quicinc.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240221134804.3475989-1-colin.i.king@gmail.com>
References: <20240221134804.3475989-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] ASoC: qcom: Fix uninitialized pointer dmactl
Message-Id: <170853137427.40410.4918124750403655559.b4-ty@kernel.org>
Date: Wed, 21 Feb 2024 16:02:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 21 Feb 2024 13:48:04 +0000, Colin Ian King wrote:
> In the case where __lpass_get_dmactl_handle is called and the driver
> id dai_id is invalid the pointer dmactl is not being assigned a value,
> and dmactl contains a garbage value since it has not been initialized
> and so the null check may not work. Fix this to initialize dmactl to
> NULL. One could argue that modern compilers will set this to zero, but
> it is useful to keep this initialized as per the same way in functions
> __lpass_platform_codec_intf_init and lpass_cdc_dma_daiops_hw_params.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: Fix uninitialized pointer dmactl
      commit: 1382d8b55129875b2e07c4d2a7ebc790183769ee

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


