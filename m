Return-Path: <linux-kernel+bounces-53055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EA884A01E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3967285C73
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B9C3F8DA;
	Mon,  5 Feb 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMQfKs7b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC983C097;
	Mon,  5 Feb 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152326; cv=none; b=kH/9kDYsPK+aWKYUSILY+kx5BYOpXYEuV7VvLmcJPbnyFCGX7/kkvSLdIYcKxvNFYJAz3MItl6oUSwGNSaGizg814+8b2vvsug5pSul6LXapvx8BKNg84VexgEEQb+0jHiAm1/f3WoR1+XKFObQrJcEuenpc+I6HtK4i4SjQOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152326; c=relaxed/simple;
	bh=VRTN3Dv3YqaGLWiQ45v40VoTuQnxlGeffm0Q415W9do=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y9L5mQJTx07T94IY3BvH/ooHOGjb1TCOChEcqXCtPrdYolmnyZe/E900uVkk3ULoaVA500WdUvZn4fIurryCsHiemL2YbRfI9HeEr/1uaChN5bdOl4F4kPjsV73hU98W3HgwBRsIJ/zjeBm1HwUyA7UavvGaLbVOZWFWX10ZzZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMQfKs7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04722C43399;
	Mon,  5 Feb 2024 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707152326;
	bh=VRTN3Dv3YqaGLWiQ45v40VoTuQnxlGeffm0Q415W9do=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sMQfKs7bfBQW8WnJ0FfpCcai0NlmCFM8t7X6YmNoatsPD3MywYRbT44Ju8TBU2BGM
	 7yxmmvUBxY57qK9QAJ1hIZwvg9TEmLJf5nX18N3w3D3SwXKerD/r7HJyyw7r+dMHEo
	 bqQIdlok+mZTcJJHIKgRXhMTSdRoz4WlP7PPqV2xfFSVYccMgUxy05zyLue7cURGZE
	 eoh5mE0m/6eQK4AF4nWMnVWwCi0S4KOOoJNE7AQ9Xi/2XhsMfHa+1c05obkReNZLV9
	 yLXjACvOEd7SLJ8ZJun8VBhjc4JQEsSZLgpu6X++CFvaQUMlK/u0aiUkokT8etZSe1
	 tSID3QpVwESzg==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Gergo Koteles <soyer@irl.hu>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, stable@vger.kernel.org
In-Reply-To: <118dad922cef50525e5aab09badef2fa0eb796e5.1707076603.git.soyer@irl.hu>
References: <118dad922cef50525e5aab09badef2fa0eb796e5.1707076603.git.soyer@irl.hu>
Subject: Re: [PATCH] ASoC: tas2781: add module parameter to tascodec_init()
Message-Id: <170715232269.801804.9210971697925067313.b4-ty@kernel.org>
Date: Mon, 05 Feb 2024 16:58:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Sun, 04 Feb 2024 21:01:17 +0100, Gergo Koteles wrote:
> The tascodec_init() of the snd-soc-tas2781-comlib module is called from
> snd-soc-tas2781-i2c and snd-hda-scodec-tas2781-i2c modules. It calls
> request_firmware_nowait() with parameter THIS_MODULE and a cont/callback
> from the latter modules.
> 
> The latter modules can be removed while their callbacks are running,
> resulting in a general protection failure.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: add module parameter to tascodec_init()
      commit: 34a1066981a967eab619938e7b35a9be6b4c34e1

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


