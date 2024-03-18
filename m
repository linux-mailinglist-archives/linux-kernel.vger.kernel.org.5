Return-Path: <linux-kernel+bounces-106416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C148087EE5E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAA9281DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E601454FA4;
	Mon, 18 Mar 2024 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3vdb6NI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4954BFA;
	Mon, 18 Mar 2024 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781559; cv=none; b=tNWQoz45MM+1+V3oFjAM4TVtEPMrP+P3cen+JQhPtb5JM/jJye3SLr6tDBy3VQn3+YWqlJm5C6kxzuAJ5hCF7Jfm6cwY6v7gZE7L5Lh5RccdsaubGuf2CVO8Cb1QrE3wGXKookX8JDDcm+z4QfUJHZcMzDB5lzo1J2TErFoxYAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781559; c=relaxed/simple;
	bh=RMu+UgtWOoWOd40qpPWbxTK8o8oT/Dhw5wdWdscpVC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=b6j34+MRfDt8uLBlW4GIEE3cRnFVgnJnRQO5LtK/UKDla+4iouNTOqiJHsT+pkMBVJ73dQ+eRmqazJuReLlNb54iq/qCuWs5gVsWS8hVvB2uGz1ntry+ipyjA5/oOl/A0jkmzfRtauXNgWqB8uXYTn1xBY/4SRCljEx/EuTR9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3vdb6NI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF234C433F1;
	Mon, 18 Mar 2024 17:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710781558;
	bh=RMu+UgtWOoWOd40qpPWbxTK8o8oT/Dhw5wdWdscpVC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I3vdb6NIMZ5k+EUETXe6wgll2bT6s8O/DyFEwdaUsYB6Tvi7eEra8o3xggZUqaPXR
	 M3fVj4aLzWkJ4l2/hILhc+deIAZspqYnePzG6WhsWLxszVZhJHbJT0IEURAFJcX6xM
	 2IRUFPgTwYaojNdxc1j7Eg3zQTXbtxGA/5u8K71ynodT8qiYClwJLMecygIDAi7xNT
	 PZF+iusEQBUUxkUB3UahjC6F/Um1NhsKWWcoTZRCK1f7AJI0+XsvnUnUA3hkkbTz/N
	 ryjgHqSaxFGvLIda7/nai9BM/FQnaVYBTdMOqxzUxQ/nZ9I6dR2XCsgiPj9DrWDO8L
	 HPEeFAmSsdFrA==
From: Mark Brown <broonie@kernel.org>
To: Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Raghu Bankapur <quic_rbankapu@quicinc.com>, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shalini Manjunatha <quic_c_shalma@quicinc.com>
Cc: Krishna Jha <quic_kkishorj@quicinc.com>
In-Reply-To: <cover.1709720380.git.quic_c_shalma@quicinc.com>
References: <cover.1709720380.git.quic_c_shalma@quicinc.com>
Subject: Re: [PATCH V0 0/1] ASoC: soc-compress: Fix and add missing DPCM
 locking
Message-Id: <171078155643.88150.1151704190402668326.b4-ty@kernel.org>
Date: Mon, 18 Mar 2024 17:05:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Wed, 06 Mar 2024 16:23:19 +0530, Shalini Manjunatha wrote:
> We find mising DPCM locking inside soc_compr_set_params_fe()
> before calling dpcm_be_dai_hw_params() and dpcm_be_dai_prepare()
> which cause lockdep assert for DPCM lock not held in
> __soc_pcm_hw_params() and __soc_pcm_prepare() in above flow
> when ever we play compress offload audio playback use case.
> 
> To fix this issue added DPCM lock and unlock in both places of
> above code flow mentioned.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-compress: Fix and add DPCM locking
      commit: 9a8b202f8cb7ebebc71f1f2a353a21c76d3063a8

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


