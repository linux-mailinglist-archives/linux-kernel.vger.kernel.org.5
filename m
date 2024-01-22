Return-Path: <linux-kernel+bounces-33704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC31836E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3FBFB32FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE2356750;
	Mon, 22 Jan 2024 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3ghcF4U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C33755C0A;
	Mon, 22 Jan 2024 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941226; cv=none; b=n8QNbNwHInHiOFV8wIo6n43BAeDG0gjV6m+2BIQo/fKbigr2UJvkKHux4Mo3YMYhR2Zb5mrHZs07mvCRrlA/+KCFaaPY9OxUP2U7wOlcxFvkCCyTEBTOE53rx3/jJzokLfmyrpJOJiLngpUQhL2KrfgLL++H0QMWEjCFFvRp9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941226; c=relaxed/simple;
	bh=qx0slvzEJDNEhcWL6ARnxl5FKczNxXGG4ZvuQmczmUY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PYd+FnlCcrcN/hOvzNhF46WGiXTvTCgDa0bEoZ+wr2a1+ARMWavZiJJBGWz1dkOhB8RoBz16XlU9MixEQhsSaBqDCQgRzEzmZhv9oAnrarfCKEYJQ7C4gaZ4HO7Y/ob8OWLx99ohmisy9PeNcgIxAgUeR+aO2FwdnIPLYtJIIgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3ghcF4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F67BC433C7;
	Mon, 22 Jan 2024 16:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705941225;
	bh=qx0slvzEJDNEhcWL6ARnxl5FKczNxXGG4ZvuQmczmUY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Y3ghcF4UrCUd9YkeyOT4JqiVFg+oSn3mn4svk02eISuC1tjXDUbOBo2hrbHRw1vSk
	 rFYgXdt8kD/h5lFkjkYFCh2CQimZ2uJVrhf5EBj+w8m+gESgKn9ow7kxxDpz8nHMqa
	 Mpk1XOJzQabJ3hmLC81iYEEVJRX2DFOPyQLK/AY8nH1zjDFU2zzbrNaZmFcTi62NMU
	 MLWjyaTwxK7dThpCrMPwZGq1xsupEdsPiJKzFCdJelPIYEYVv+hEljN2F461m3121U
	 DYKMilYhGFt9R4e4YBvT15goJhMO4etaEIcCXbBr+nq8qziqjCLZk0gUY8xSGTvcUm
	 HERAy44RSFeog==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Erick Archer <erick.archer@gmx.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20240106171635.19881-1-erick.archer@gmx.com>
References: <20240106171635.19881-1-erick.archer@gmx.com>
Subject: Re: [PATCH] ASoC: qcom: Use devm_kcalloc() instead of
 devm_kzalloc()
Message-Id: <170594122282.63484.7192392650857534262.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 16:33:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Sat, 06 Jan 2024 18:16:35 +0100, Erick Archer wrote:
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: Use devm_kcalloc() instead of devm_kzalloc()
      commit: 322ed3a10bf2dc85568aa9ed285aba448347080c

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


