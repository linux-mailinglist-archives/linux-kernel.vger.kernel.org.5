Return-Path: <linux-kernel+bounces-45210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F9842D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFC71F22389
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9F169974;
	Tue, 30 Jan 2024 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN2TGb4j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75864CE9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643535; cv=none; b=mi6fbjPnhBN7L7ckVDZLSE/YAoBiWTyc8ErhEGqgjexRnCnsdVmNcuvKoizprQug4d/eGsYVSo9SHlSvn/jkXSTV98zfMGEqA00rNg+ifOp2WYx/HBLJfuAXzzcO1r/MWkjJJZIb5eNXlhKUQWPxtesLCpnShy1OSt5rj8OBoEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643535; c=relaxed/simple;
	bh=dwESQcV6HQIbzWzmGdGTthxkxLibETSzJOlXaY+qF8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pFc2Sj+/DJ2W5JiHz4vTNrpFiEiA5J3O3bUwvF2JZ8lBQcgZ7VRxaD8hdGKy85scL0FxUVviIuO1FnmtWDb6TraGZ5FBPyLw0mcBmCzRmEpc2GLQCJdlZ32bGtTvdnSaETRWGVnzzDQ5BNzB1wzTp515qtCwYYCb8A2I49pHGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN2TGb4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B964C433C7;
	Tue, 30 Jan 2024 19:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706643535;
	bh=dwESQcV6HQIbzWzmGdGTthxkxLibETSzJOlXaY+qF8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eN2TGb4j8oP3z71NQN2NAshCr+Nh+31pblw12XXox2zau32VHX4+0MzL9rsKCwKNZ
	 jEBo+zx1AP1r9/s26ANbzaKDgqlS2lNDLX3l2T978ZJONrH/C4qKo5YBYfoMQ9hfi0
	 4fYKMarKA5eW+Y/xWicZ2bqbnM7LLmvGFWRF0iI2xYbRvEVZuzbrI+/NUnzX4dnITg
	 qDh5qSJoF90gKkWgEXiRNyMxDqnmLUFMybF5eIPs0p70XoyNPXMwk00jfXZoNVJfsw
	 Py3Pxm8G2FW6UyDfSg/t/7V2vcXno8wgaPjRAIUChcmEGkUoorCaSHZP+ObwlvDgUD
	 mI+X4w7gsIkFQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Naresh Solanki <naresh.solanki@9elements.com>
Cc: mazziesaccount@gmail.com, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240130150257.3643657-1-naresh.solanki@9elements.com>
References: <20240130150257.3643657-1-naresh.solanki@9elements.com>
Subject: Re: [PATCH] regulator (max5970): Fix IRQ handler
Message-Id: <170664353402.52247.17282452218035818991.b4-ty@kernel.org>
Date: Tue, 30 Jan 2024 19:38:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 30 Jan 2024 20:32:56 +0530, Naresh Solanki wrote:
> The max5970 datasheet gives the impression that IRQ status bits must
> be cleared by writing a one to set bits, as those are marked with 'R/C',
> however tests showed that a zero must be written.
> 
> Fixes an IRQ storm as the interrupt handler actually clears the IRQ
> status bits.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator (max5970): Fix IRQ handler
      commit: a3fa9838e8140584a6f338e8516f2b05d3bea812

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


