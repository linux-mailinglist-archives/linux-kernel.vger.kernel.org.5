Return-Path: <linux-kernel+bounces-37490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B54983B0BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E2E1F2965D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE812AAC6;
	Wed, 24 Jan 2024 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnA8TTVB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D012A17D;
	Wed, 24 Jan 2024 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119895; cv=none; b=FzcLXpblaYXopXJ6/ZqK/LzS6O56fRaulSkn+8JheiC/8GIxlVf7LpZLEJSt+tDUW/lrTuftA3KF/KPsYZx7I+op5ueROeoZVdx/Rbjr26sWj2QP4MueGPQWt7poCPYM8hv1bvbF2A6i16Ubi0kmUASyXxY3A4QSyJxof/Pfn1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119895; c=relaxed/simple;
	bh=vyaNz76pF6mFaajQlKpV5NbLpLHuDeqRa5IsQd/JmWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fayBlmJ8Oj4Ju/ANJAvzPZLrMOPO+ty0nIPtRkCGTqhlc/vcx3G7ftFzsTitdHWYpM2pvdD4IjQ2Rw+f4JVu23jAturPV5nVzRa/ofhIvmQ1gaMInh9uOLVMznqzlfb9a+80OhLDqRD2HHo5dngYYMCf2oRqmiCen91+YjP7Q+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnA8TTVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B93C433C7;
	Wed, 24 Jan 2024 18:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706119894;
	bh=vyaNz76pF6mFaajQlKpV5NbLpLHuDeqRa5IsQd/JmWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BnA8TTVBaVX3Mg4aJjYV0OQgeipG6mUaUdqptTl4xYhq/jCRAFdJ1roN/adnrnZJ4
	 HiMqlpxOju+IYYu25gXgRR6LBZLo8Plxikm0F0zTtF39Czw4QoFhtQJX0hq1PikZ8p
	 0/0AVembeB6dRsBlnyn4+wY7uswC7oPmlNF6Ebbl0KDxLviJxG1v6o4ibXHveAhR8r
	 nQ9eflFxG/J3iMiwxkJ7SQ4L5sYHmbdwUUbnD/DLuEsdWkeu7Hw8GrQdT4PNTmIp2Z
	 RH41vM0h3EekaHJAX41id1DxX6iLEjFZvPkVzWhvjbxuxXsl/k8dy1dW5hHadaAq2T
	 MeCjIKMmPuilA==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Romain Naour <romain.naour@smile.fr>
Cc: tony@atomide.com, lgirdwood@gmail.com, 
 Romain Naour <romain.naour@skf.com>, Yoann Congal <yoann.congal@smile.fr>
In-Reply-To: <20240123111456.739381-1-romain.naour@smile.fr>
References: <20240123111456.739381-1-romain.naour@smile.fr>
Subject: Re: [PATCH v2] regulator: ti-abb: don't use
 devm_platform_ioremap_resource_byname for shared interrupt register
Message-Id: <170611989327.57373.13632353759859941930.b4-ty@kernel.org>
Date: Wed, 24 Jan 2024 18:11:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 23 Jan 2024 12:14:56 +0100, Romain Naour wrote:
> We can't use devm_platform_ioremap_resource_byname() to remap the
> interrupt register that can be shared between
> regulator-abb-{ivahd,dspeve,gpu} drivers instances.
> 
> The combined helper introduce a call to devm_request_mem_region() that
> creates a new busy resource region on PRM_IRQSTATUS_MPU register
> (0x4ae06010). The first devm_request_mem_region() call succeeds for
> regulator-abb-ivahd but fails for the two other regulator-abb-dspeve
> and regulator-abb-gpu.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: ti-abb: don't use devm_platform_ioremap_resource_byname for shared interrupt register
      commit: a67e1f0bd4564b485e0f0c3ed7f6bf17688be268

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


