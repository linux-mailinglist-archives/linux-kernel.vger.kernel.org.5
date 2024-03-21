Return-Path: <linux-kernel+bounces-110190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABB3885B52
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F121F23336
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2D186241;
	Thu, 21 Mar 2024 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBS3hh6a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD21E522;
	Thu, 21 Mar 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033319; cv=none; b=VDHYo5P0gsSwSMEALbyka+ltC7M49eCUXOUwrmT90XvAQ/vxwj/dycV94aQLmsGfaEzuovW0RW/d9fyjsvv/hC9F6o7w7/B2d3um775r7AI+3cmXKsTnWKVHJXc7V1+2w8y3zXEc7aAyhtU8D33jl5gxZmEzZkDXwoFwZDxX2NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033319; c=relaxed/simple;
	bh=kmMw7UrxyYm+FrW2p/kXhJw0xpkOp6iNmX0mZMs6h10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CknHHaSmFcnQZbWAPUXBPBvQfNPtsT2wjoe/PFkQd3OYgT4vSdwzLamztvKy/MChjNUucC5+k+I3l2VSIkRWnElSLnV+/BO53B19qOr7IfwCywL+LotzTtpooVlZMugl4INyGB75R55NVzyGTX2Zp8srKsjs6JPnbVNk0I7+GYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBS3hh6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA1CC433F1;
	Thu, 21 Mar 2024 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711033319;
	bh=kmMw7UrxyYm+FrW2p/kXhJw0xpkOp6iNmX0mZMs6h10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rBS3hh6a7XnbPCyETgHuyP4Gzi5T8ulrzuCZY+NwYdZDihY0vZO3F5Mjz7RHz3+fT
	 LMjOby+wmiv4ooIDcbTGjMopnVv9ktbF7vA0sbV5mymIByAjdI0VH45ZIxILykinyn
	 Vwjmre3d4jdgMUY7Zwj/otTwNTOB9/TJrDCgDcOjye4EiEDXn6l+yvfj3bXa1gshLG
	 Jwxv9UHOk60VLQatPPF3B93u2lR+AWnYxCfx8I9qirKVjQ3iRsSHR1cHg/isw8jZ6g
	 RDYqlvFNBoUj50Au2d5INpAkMPtMcqDpp7kbDDw+6Tu1N9f9ziHSejrBzjSTrVSUZU
	 rWnd+1I9UpKlA==
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Fei Shao <fshao@chromium.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org
In-Reply-To: <20240321070942.1587146-1-fshao@chromium.org>
References: <20240321070942.1587146-1-fshao@chromium.org>
Subject: Re: [PATCH v2 0/2] Fixes NULL pointer access in spi-mt65xx.c
Message-Id: <171103331749.114773.10634941088175436463.b4-ty@kernel.org>
Date: Thu, 21 Mar 2024 15:01:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 21 Mar 2024 15:08:56 +0800, Fei Shao wrote:
> This series contains two patches for spi-mt65xx.c, both focusing on its
> interrupt handler mtk_spi_interrupt().
> 
> The first patch is to fix a NULL pointer access in the interrupt
> handler, which is first found on a MT8186 Chromebook device when the
> system tries to establish host communication with its embedded
> controller.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
      commit: a20ad45008a7c82f1184dc6dee280096009ece55
[2/2] spi: spi-mt65xx: Rename a variable in interrupt handler
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


