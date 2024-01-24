Return-Path: <linux-kernel+bounces-37533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA9E83B154
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B15AB233EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17604131734;
	Wed, 24 Jan 2024 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dcp0y/ua"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5612A129A8D;
	Wed, 24 Jan 2024 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121659; cv=none; b=X1/j/is4TtfxTvPErykTye+abYc+wi3q9kGS1AqDn3HnheP6/uyAHe0Djr2IzXdW/KzIJN+93I/MsFi2abctpaPYGhhKXweiHVinPX7H0LuXEoSTnpaDgkJiXtDGrCIS4Ft1HIDRoJ7nroaR92y0ja0g24raOSU+5Z46+ZA2Czw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121659; c=relaxed/simple;
	bh=CD0P2lw5oXLogRsRLzTek6ZfHZb81pFRquTqHx1bOgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B7yOussxJUdZByrzODA/90ACYQqYw5QkGimwYGyVicF7g8CxSnjBsOEe3z2ei/e7lzzuPnwC29x7DuAP1MkvPd2Pyq2pcRKD/FObyh0CXE5U+ldtM6cZLHqZr4kWY6ddPNPLJrjpsi3iDTZLnUJa4U0hHtNM1Rrq1rTSl9EEUns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dcp0y/ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A25C433F1;
	Wed, 24 Jan 2024 18:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706121658;
	bh=CD0P2lw5oXLogRsRLzTek6ZfHZb81pFRquTqHx1bOgc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Dcp0y/uah+1+g5RyWVip63ZQ5inphhK9LDiLCahWOg8RwUyordwtC7Ljlnlmd+ElD
	 yiOAc2WPZhj+U6otS57YVyB22+ytDs0JjRhJ0HF/a/a0aK7lPOZwu3jjBrdXPZu3cn
	 WZrGaeHVk8NfwwNpfbb8lwuDWczv76a7XG/vZkzcOt+1obPvuHQe24NVYd++4voF29
	 ZJrbIRvjZ0hJ+xhp1oNMp84TvYScFpyWrZSdwKUyYKgo3Nc53rkB/XFJWKr/rp7ugu
	 S0PS/K1uHPDISpMzct+WwExPWs4szRwQTMZ2DuJzn5/bJsTCsTiCBHHK0nqcdBLaCd
	 3AM+CCGtIuyRg==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240123214946.2616786-1-dlechner@baylibre.com>
References: <20240123214946.2616786-1-dlechner@baylibre.com>
Subject: Re: [PATCH] spi: consolidate setting message->spi
Message-Id: <170612165784.61704.2785913923868327275.b4-ty@kernel.org>
Date: Wed, 24 Jan 2024 18:40:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Tue, 23 Jan 2024 15:49:46 -0600, David Lechner wrote:
> Previously, __spi_sync() and __spi_async() set message->spi to the spi
> device independently after calling __spi_validate(). __spi_validate()
> also would conditionally set this if it needed to split the message
> since it wasn't set yet.
> 
> Since both __spi_sync() and __spi_async() call __spi_validate(), we can
> consolidate this into only setting message->spi once (unconditionally)
> in __spi_validate(). This will also save any future callers of
> __spi_validate() from also needing to set message->spi.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: consolidate setting message->spi
      commit: b204aa0f99cfe3c9d796ecfc0bc6f3f89585789e

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


