Return-Path: <linux-kernel+bounces-146014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E818A5EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F37428505D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB9415A48D;
	Mon, 15 Apr 2024 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd2+qi1s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF25158DB0;
	Mon, 15 Apr 2024 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224596; cv=none; b=mF+X699dzbIMyLBknzt7rX6mXyGyl+x4MElxk4fbtQvB5G30nLhhL2hKn9qogF3GAqQshNtYb8n23/g2blmL1r/k/VQwNza/oXL2DF7viHzgKq9QJ2IyeumNrER5ecx+sUc02y7UGTgrQMxNONOSc2vJVnKDLuB3ILp3+3hwkNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224596; c=relaxed/simple;
	bh=X9nCD4qkBQfBS8dnQLJRtmMUHEovcEJatZMQOk0SGew=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WZagyP0tCltT5Hu5/vlG2mU7YcGaYFqnJAhde6q8i5yXR6dyPe4icAiOizpIl+2JT+qW23kHHq/CExbXe+GLR3P9Ecxy99qcC5Gs5pA37uZb0AfPcEOUDmSPyO1c4YJivYjENhXoWRO9tpb4Ij+q9cYZdt3gp7gWROMMc4dzuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd2+qi1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4386CC32781;
	Mon, 15 Apr 2024 23:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224596;
	bh=X9nCD4qkBQfBS8dnQLJRtmMUHEovcEJatZMQOk0SGew=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Cd2+qi1sdibVeoUlXsaxLhCQyPBmi8pKhJTauFRkTwlSLupXQeLatImiezIBSeoYT
	 BFKeqIl55DJcit5pEpIi6WZgVviA5ayYgwHUlcRaV64kyi6MAN3utg8r3dKHoNdgqa
	 NSmnd2Hyt10sfgl2KR1DutTaF8cb0Ihp2FqcIjHrlCMLR2bdB8oVmNKeIcmyDdQMfc
	 L0JEhYsitvzJe4lxVxZXiFwRHqnP30vC/DGCXkKoDEvh7iRr9p/bqZjeifQn57X20u
	 gP+FJ4HVsIF3RrD32yYZrVQvM/p5gJyca0PXpbn0t2MgwwS1nYFJ6t780AmTxif0Ix
	 zarBZuunsxE3A==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <b32e80cf-b385-40cd-b8ec-77ec73e07530@moroto.mountain>
References: <b32e80cf-b385-40cd-b8ec-77ec73e07530@moroto.mountain>
Subject: Re: [PATCH] regmap: kunit: Fix an NULL vs IS_ERR() check
Message-Id: <171322459456.1659174.4759607099482706461.b4-ty@kernel.org>
Date: Tue, 16 Apr 2024 08:43:14 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Mon, 15 Apr 2024 13:34:54 +0300, Dan Carpenter wrote:
> The kunit_device_register() function returns error pointers, not NULL.
> Passing an error pointer to get_device() will lead to an Oops.  Also
> get_device() returns the same device you passed to it.  Fix it!  ;)
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: kunit: Fix an NULL vs IS_ERR() check
      commit: 991b5e2aad870828669ca105f424ef1b2534f820

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


