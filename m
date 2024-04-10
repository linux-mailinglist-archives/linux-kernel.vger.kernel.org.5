Return-Path: <linux-kernel+bounces-139310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 848538A013E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06469B21BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F95181BAF;
	Wed, 10 Apr 2024 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWfND4+z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AEC181B8B;
	Wed, 10 Apr 2024 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780631; cv=none; b=FM/1Mo/W2y1GBQx7UEvPHlhM5GHq4euohAVQVZQq0ee65/V/6xaeDvRTuFxjQHLzYpLj80GAR4AMCT/6+YPlyfVnBx5+Eyi5zom+zN1Sb6d6b/2ZWeNCFbidnD6b20MtXWxFHGCJgQ/4flLCZoDcwjnO6vV47HYOO0dDU8MdGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780631; c=relaxed/simple;
	bh=h2S8k2uo3F0CoEmDk/7q8dSzWeVwKRVs/lxza4rRZhA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BiyYj+otpO7vAOupDPtwrusGwyxrQK7OnpfbKHT7oECmhYKri7bTLPe4KkBVGL3n954iD1W5Etr9eN8eQrsc1QUHxkrZ1iA1CgJ2JpJt/4oyJbYmNw8ZFrcBlHOTtZh+dRKix64BVMgrGn+f99odGfpNOphQcwGdc8D8mRHeb2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWfND4+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE3EC433C7;
	Wed, 10 Apr 2024 20:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712780630;
	bh=h2S8k2uo3F0CoEmDk/7q8dSzWeVwKRVs/lxza4rRZhA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=bWfND4+zlLUp504AK8AGL9ZsDeHilvWsR57l/RmT6F8zbik+7f3ejq0TEXlFIsW7x
	 gEH3yLYDiFVmAYhUFHhJXoB97aAK+TrKeEjBAbzg4nUCvfitdPMT7ik+fEjrItfGTR
	 rD/U+jYAE5+TkUwseUfG26NlhdBpNCGnwgT7O/pMaGFwtVvZrDOK49RrFdvisTCZCy
	 HOzIXqZnHb4IA1h7rfEE+CX7IyXSoCroKRQSbzZ2KJQFPeNq7aXft/AyQvgu+RCost
	 lU3+/WtemdyYGWg5yNjnnBShLA+7KHToeOZ6l9hlyELFZDfbaTyRnG4OiesKSVYZdz
	 AIwZ5V403si8g==
From: Mark Brown <broonie@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Robert Marko <robert.marko@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20240410172615.255424-1-krzk@kernel.org>
References: <20240410172615.255424-1-krzk@kernel.org>
Subject: Re: [PATCH 1/2] regulator: qcom-refgen: fix module autoloading
Message-Id: <171278062883.65289.6340690792039519391.b4-ty@kernel.org>
Date: Wed, 10 Apr 2024 21:23:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 10 Apr 2024 19:26:14 +0200, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: qcom-refgen: fix module autoloading
      commit: ddd3f34c10002e41ed3cd89c9bd8f1d05a22506a
[2/2] regulator: vqmmc-ipq4019: fix module autoloading
      commit: 68adb581a39ae63a0ed082c47f01fbbe515efa0e

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


