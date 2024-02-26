Return-Path: <linux-kernel+bounces-81924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BFF867C43
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1BA61F24062
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F9812BF39;
	Mon, 26 Feb 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o84UwnpX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081E2127B4D;
	Mon, 26 Feb 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965745; cv=none; b=EfdLEfzBUmH2PINshBbmGmofG6/dmM4ZTf7OwgZjxUeQPF2LxTYU83rJSnyec6FU0ISG2EiiZ7uOfxO7eyLhL6fBPyB8J+ZoW5XGrcVsaus3CF1QhTWP4HdID+v6aYqzKY7TLh3F8lCMwfNgy6KrB6uh09ei/+MhyhPWgcaLXo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965745; c=relaxed/simple;
	bh=8AG640OYZqzQ6LxfJTFmsUon+8trCgiaSh3ZzJntRzE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OXDVoOgUsNHzgYJDljIDQpopNkTDEiTQZt6G/pWfC0NMmmS+tyqAgqAOiCTvPrW1jdEoYc0Kbkm0C4O7tpjA13jKP9z60bGtswYMfJz9ILE4lDbhVFWdzmdqWTBMEwu5aRPvkcXy7iBnxEqNsjRMhPYntBggSROKixxCgJ6+kLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o84UwnpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05532C433C7;
	Mon, 26 Feb 2024 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708965744;
	bh=8AG640OYZqzQ6LxfJTFmsUon+8trCgiaSh3ZzJntRzE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o84UwnpXxDnWwEFrDF5GP6RZqVe7tw+qlz6am4i/lT0tYYJjoIDglsB41Tstm/5JD
	 080Z6WJdV1zSCjXCOlms18v3gZQCXVpE8M0mE6KTyysSc8SgeI/5l/MkecMbWPIS56
	 kQkY6b5D9rHDkWLr/DwV3bYqc4V5Jfj5inIqGfrGwYzHShdRkUPujzVRrHyblNTCQO
	 akhVkZoT7spphMgb8vZ9jyk4eiZi97VSn28yYyif/UfpHSCv0Yro9lPviG9HSRweiM
	 oYGSJCWrpjTllp9undabBbksord4JQPtJsN8Czuau7NMdAKB5q6oToeLblOAUKXbxQ
	 VAlTVnSOFcPbQ==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dhruva Gole <d-gole@ti.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
In-Reply-To: <20240216-spi-mem-stats-v2-1-9256dfe4887d@bootlin.com>
References: <20240216-spi-mem-stats-v2-1-9256dfe4887d@bootlin.com>
Subject: Re: [PATCH v2] spi: spi-mem: add statistics support to ->exec_op()
 calls
Message-Id: <170896574275.55258.9342782385435188138.b4-ty@kernel.org>
Date: Mon, 26 Feb 2024 16:42:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 16 Feb 2024 17:42:19 +0100, Théo Lebrun wrote:
> Current behavior is that spi-mem operations do not increment statistics,
> neither per-controller nor per-device, if ->exec_op() is used. For
> operations that do NOT use ->exec_op(), stats are increased as the
> usual spi_sync() is called.
> 
> The newly implemented spi_mem_add_op_stats() function is strongly
> inspired by spi_statistics_add_transfer_stats(); locking logic and
> l2len computation comes from there.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mem: add statistics support to ->exec_op() calls
      commit: e63aef9c9121e5061cbf5112d12cadc9da399692

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


