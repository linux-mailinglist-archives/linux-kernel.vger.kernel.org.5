Return-Path: <linux-kernel+bounces-64337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F127F853D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA6628E714
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B32561684;
	Tue, 13 Feb 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQOZs+pj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B461361669;
	Tue, 13 Feb 2024 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860137; cv=none; b=a8xGelF6gpmn4ytmFaBmpysVcDDBNmOcNZd4crcTS7N4nsvkBl4OCkNKQAvzbL0IPKuKMD+Lgn9pIC9eRpObN6+STe+mDKUdGgoEFK9oBv1aa/10LL+tmRAM2fg4UosY+sZuchjEJMEoeLVKXHHASTpPf0ufcu1JCORHHAbP69s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860137; c=relaxed/simple;
	bh=v+7iuZKyFjMWBHC+thRv8pe5Npu+QdHBNo3PGFOhzmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p1fYAQg5bz9uf9abn2+Kl/p8Q+qNG8ukCMDw7f3RjE44tfRimlbWhAaIQLqUEtbAWWtq2vcWceK2KortNYe/mlnKHTtxozmnfFlVAiPhHlQ+XfK30wL+4Hl1PzIO3j01ryuoofigWZePcG6GJYtdC01KCaxqXKaNdhtqezxBzAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQOZs+pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA22C433C7;
	Tue, 13 Feb 2024 21:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707860137;
	bh=v+7iuZKyFjMWBHC+thRv8pe5Npu+QdHBNo3PGFOhzmM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rQOZs+pjpiJ6wgYMK/mF/mh3n2al/B4er7XnuGfrsG/1xaWBTS75kKGjKwJjYzfdd
	 Meh/Bh6qNKil5QwEqJxyf8G7l2l9u5EaQ1HqDc9ZZ/EfYcw6alzrdzEQT2n1BPwfh6
	 9Syr6dKYLKpc3Gebi4nKWVU/ENyNzaNJ1aCnD93Cf1ymKPEnmdgfGLCpkDA/Uh8UtS
	 wsjJ8OcgjQlckCPJZwQpqSWCglBvqp4l5t/oWKvQbyOuyt8cc94l2e0Pz7PblSVvxI
	 UutfQg+lDBOoc01hsV368XVUvsVtRVuOaJZrXtR1kmL3gBouZQtgLMuVKxvgUPdk5Z
	 qTRs3T1Yf44nQ==
From: Mark Brown <broonie@kernel.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <efc92197-4023-4bfe-bc63-452e7ed112e8@moroto.mountain>
References: <efc92197-4023-4bfe-bc63-452e7ed112e8@moroto.mountain>
Subject: Re: [PATCH] spi: mchp-pci1xxxx: release resources on error in
 probe()
Message-Id: <170786013490.1060731.9553383767510166601.b4-ty@kernel.org>
Date: Tue, 13 Feb 2024 21:35:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 13 Feb 2024 21:07:45 +0300, Dan Carpenter wrote:
> Call pci_release_regions(pdev) before returning on this error path.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mchp-pci1xxxx: release resources on error in probe()
      commit: df20385302eb01cb610b9edc71611a63d1683923

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


