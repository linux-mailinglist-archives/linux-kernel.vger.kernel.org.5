Return-Path: <linux-kernel+bounces-75324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D529F85E68C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9952881B8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132F985923;
	Wed, 21 Feb 2024 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvZaaxi7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8F85275;
	Wed, 21 Feb 2024 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541034; cv=none; b=F0ih1KTRNzT5U69gyv2IWmvs1WGLs6hrZz8RNDVBRGgXzaoEa6/Wc/bu+sbhe8GG72J3GrdWZIeU7+mK4Ax1VlYAjHyUi9yo9EQ6gqq+AlMq65M5eII+fKRvpYaEPzVdPEsbv1b28nwtfi7e5GUoQvGJdU6Rp6bn5A9W7FWmEYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541034; c=relaxed/simple;
	bh=t2HpRNiflnSsZJtZz3yc3MMR2wTWgUFquZMaeFJLPSw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tbusl4r80V84T2AgBeYydY8EWP8AGPvGvktqKp67qlsWCFw0LSNn5ISgtMHiMXjATnMsmJ8SYnvlS4LJMioN9BUW6iIZXbFQsfYBWZLF7lZGuVGjsMC2LH3dgyTurbM9EY49qYKPKrYAIUZBjIXlsI5jiyKfpQmQkrhpiG/oCKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvZaaxi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E10CC433F1;
	Wed, 21 Feb 2024 18:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708541033;
	bh=t2HpRNiflnSsZJtZz3yc3MMR2wTWgUFquZMaeFJLPSw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GvZaaxi7fIQg3gM2h8fVUZbLYlPVethc5CyaF1/MOyi5QY53lHIxoFRGQm4leduex
	 AYV2LLGR/YZ8CRCslmyAnIej59bAH5ljIFxYCarmpMlWCMjm2v3saArUxLedoQE4CG
	 BDfE4ACAcVwcgc9WH7Fm2kkbY1iiZM+ZSW8yca99+Gb863NTsVcv0rP9gUPD5mckDF
	 ERYCmv3fKn4KI9F5rla9fSob+Pomia5fcumoo8J1qeYI+FKzXEz81Xy/L8BwGLnb2G
	 E8jlWTzvQnQOSpUom0UCoyxbtU4EvYo/oSXOac+4gRMGKp0mk1+T3fJQBukktAcbWG
	 /dlv3gVbom6fw==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dhruva Gole <d-gole@ti.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
In-Reply-To: <20240209-cdns-qspi-cs-v1-0-a4f9dfed9ab4@bootlin.com>
References: <20240209-cdns-qspi-cs-v1-0-a4f9dfed9ab4@bootlin.com>
Subject: Re: [PATCH 0/4] spi: cadence-quadspi: correct chip-select logic
Message-Id: <170854103197.126065.16861664428081143203.b4-ty@kernel.org>
Date: Wed, 21 Feb 2024 18:43:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 09 Feb 2024 14:45:29 +0100, Théo Lebrun wrote:
> Here are three independent patches that relate to the handling of
> chip-select and the number of those in the spi-cadence-quadspi.c
> driver.
> 
>  - First one is about checking each flash node reg (ie CS) against the
>    ->num_chipselect value instead of the hardcoded max constant. That
>    means it checks against the num-cs DT prop if it existed. Previously
>    num-cs==1 with 2 flash nodes would have lead to no error,
>    a ->num_chipselect==1 and 2 flashes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: cadence-qspi: assert each subnode flash CS is valid
      commit: 0d62c64a8e48438545dcef7e5d2f4839ff5cfe4c
[2/4] spi: cadence-qspi: set maximum chip-select to 4
      commit: 7cc3522aedb5f4360c4502b2e89b279b7aa94ceb
[3/4] spi: cadence-qspi: report correct number of chip-select
      commit: 0f3841a5e1152eca1a58cfbd9ceb6d311aa7e647
[4/4] spi: cadence-qspi: switch from legacy names to modern ones
      (no commit info)

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


