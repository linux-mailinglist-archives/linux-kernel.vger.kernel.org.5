Return-Path: <linux-kernel+bounces-44863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB464842842
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EC6281B64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68C986138;
	Tue, 30 Jan 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fet2r2Xm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D4585C67;
	Tue, 30 Jan 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629423; cv=none; b=kJ3aES5lM5TxNKXGRxsQrs1ki0FCH5s/64xnBylS+0g6i/80AHqzOO/kwHPwcs9DpGcq6uvk0W+LxMFCXH376PMKIYbRYHzjTLD3Hdc4U6hOS/t/6YjT4eJiKkHAWNov/RhHh0Bxy+4rgmIknoyBAH8k5R9tKxkFjdPwcZvp1qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629423; c=relaxed/simple;
	bh=pNWT5OlTiyqv3QvYZIhiFVUlSQd/qptTPUKWYGPAt34=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FQr59VYtGkeOkb/CEZH/WyeHQ8A7u6uz+ehA8ibl5/SL2omdo7f84Eowvj9KuMSdXt/Gg3u8IWPy8z2ovJD30wOswp92qOx5by5SbUN1TIQWRiCTvd+VPI9l1S0sNchAxln2ltvcQZfjtWNBph4/XdUH4US+2GnPdQ82SjnOpuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fet2r2Xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62165C433C7;
	Tue, 30 Jan 2024 15:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706629422;
	bh=pNWT5OlTiyqv3QvYZIhiFVUlSQd/qptTPUKWYGPAt34=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fet2r2Xm6Hv0hxJ4p3lKxYY2NgGYhROGyBg+6Qm6jYw5bYYYmpZ+b7kPRcl5xeMwH
	 ZfFx/npdn4MnpeJZ+bCxa5NBy71p+NB0p7d7r9z4Tw1KoKbB5VXpKxQ2K3r6KDGWtZ
	 1a/y+t0YOWRKAH/41yTF8Yx+sPclwVIOxhrTAykT48757Wa4lbBMhY9Vf6R1oXuBTp
	 Mp4DMzsXa231wzkToqVw5R+3wr+ZhC3b9nOQ9FwMba9S2p14hB95v1T2J8xYDI8XYB
	 gGNq+iB6Q8QOKF18TtlgZLIgvUm8Plwyniu5rMfxK27Yhb3yKb6OWlGrl3tW8YvqrT
	 fPeJqh+o/Pm3Q==
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org, bgoswami@quicinc.com, tiwai@suse.com, 
 Fullway Wang <fullwaywang@outlook.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 fullwaywang@tencent.com
In-Reply-To: <PH7PR20MB59255EF9DFFB022CB1BBB574BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
References: <PH7PR20MB59255EF9DFFB022CB1BBB574BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
Subject: Re: [PATCH] sound: soc: wcd934x: fix an incorrect use of
 kstrndup()
Message-Id: <170662942110.37296.1277489815994094565.b4-ty@kernel.org>
Date: Tue, 30 Jan 2024 15:43:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 18 Jan 2024 15:52:49 +0800, Fullway Wang wrote:
> In wcd934x_codec_enable_dec(), kstrndup() is used to alloc memory.
> However, kmemdup_nul() should be used instead with the size known.
> 
> This is similar to CVE-2019-12454 which was fixed in commit
> a549881.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound: soc: wcd934x: fix an incorrect use of kstrndup()
      commit: eeab239d6a2418fc5d2cd7ea76187085a97acde0

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


