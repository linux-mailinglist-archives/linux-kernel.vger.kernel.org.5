Return-Path: <linux-kernel+bounces-53148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEDE84A140
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5F01F2332C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B896045036;
	Mon,  5 Feb 2024 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkQbR8ry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BCF4C3DE;
	Mon,  5 Feb 2024 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155227; cv=none; b=KMibr7x0MgE2A11d4FmRPHcDhDH8O8xIut3jW9r/4JBxKb1T+P44VqfOuU/UFU4OlIaKGaDoEQP7kj+4UFkbr3gwOATePcupXlv2mtGhaTg0sWCC6wa+xkKwOLSylmaYVlzxDrNTAv+5Kcdc8VdxZXvnDHdtTDwrVaykzJBAp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155227; c=relaxed/simple;
	bh=t0Fq0WXmbMucgmOmwSYS+aPHvKDJFLdfjqPqiLKnnrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YI7z6Q9jIyJls4/bin69Tcr1fMe/xl9SR04wRFNu9JI05eRtHd/gL49jd75shCryoTq//hefK2QYdAr1euN/1BJGEOw4FA++biQMQ4EjYx+EM5945frxJyzyRW/ruaJm7TXcbw2Y1ggpu1meUljq/uJcTHNUjzDMj7T2jIIg5f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkQbR8ry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E750CC43390;
	Mon,  5 Feb 2024 17:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707155226;
	bh=t0Fq0WXmbMucgmOmwSYS+aPHvKDJFLdfjqPqiLKnnrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FkQbR8ryOlJ/L5mjSSAfsmZ0ZXMQ6X60gRpXvPM3dlaSlonGRQJScjimweTGs+haF
	 J/chnHKM0KLzJUSfN+iH3babfzdKKOGRx5HNPDrioqxcwYpflrdHgW8g3TmoHVhQsx
	 GdEC7Q9AYMDSSAHqgbpdY8i3FvgmWo1Up/nFNOltHvKjJ5w3BvXiMg/nS6o2knU0p9
	 RDPj9zS4aqUbkABlFegc5xatWqETg7FvhdMzF2FeH1CmJJAL5JDAJSKWql5C8l+U+C
	 sUXLE59qAJt63w888YmVV6cdHRNEYOBikgf4r6x0N/v6q/Tfquag3/tuKM3AIFlIBS
	 AWTf3jJ9VLlqw==
From: Mark Brown <broonie@kernel.org>
To: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 linux-imx@nxp.com, benjamin@bigler.one, stefanmoring@gmail.com, 
 carlos.song@nxp.com
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240204091912.36488-1-carlos.song@nxp.com>
References: <20240204091912.36488-1-carlos.song@nxp.com>
Subject: Re: [PATCH v5] spi: imx: fix the burst length at DMA mode and CPU
 mode
Message-Id: <170715522367.847267.14071106009498726230.b4-ty@kernel.org>
Date: Mon, 05 Feb 2024 17:47:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Sun, 04 Feb 2024 17:19:12 +0800, carlos.song@nxp.com wrote:
> For DMA mode, the bus width of the DMA is equal to the size of data
> word, so burst length should be configured as bits per word.
> 
> For CPU mode, because of the spi transfer len is in byte, so calculate
> the total number of words according to spi transfer len and bits per
> word, burst length should be configured as total data bits.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: imx: fix the burst length at DMA mode and CPU mode
      commit: c712c05e46c8ce550842951e9e2606e24dbf0475

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


