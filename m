Return-Path: <linux-kernel+bounces-58353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF6684E510
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB49D281059
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E58280BFE;
	Thu,  8 Feb 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dkt6kzy7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C9D7FBB5;
	Thu,  8 Feb 2024 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409999; cv=none; b=eDgSMLRszYFyjf6mkT+t+RYa3di3pOGBhIwJgU0o2lnGduu0cJcZl7KTlKh0QedXWZ8QWNq/lQxXCn5Pn9wgIIGFwyBWg7PFSGqSmJIs4bLcWtAuzOSJmftH0sruncmJu8aT405BwFV86QlDkkpqLkaBwQ5DafRiHaPsOxxoq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409999; c=relaxed/simple;
	bh=HyKWGOoTXcs2ChFv1u3MjXWUCskJmDW36XEKmdT9KuY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mz1vd6leK7YoLbr1UK1IYAq4gj+uOxtBDc+9lzZ97xsxL9ODK7bkO/W1k+PBZyn68lYwG80VLbOdoioQB8X+Vj26AiSdNdKM/mvp699psZ44Mh0Zw5RuGZVR/OujYad/nqyUcGrxfkp4n81xSOgbUE+olRzSfs56GIUcs4LM1R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dkt6kzy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEDFC433F1;
	Thu,  8 Feb 2024 16:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707409999;
	bh=HyKWGOoTXcs2ChFv1u3MjXWUCskJmDW36XEKmdT9KuY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Dkt6kzy7e2dwdynaHUSSHrV4NqrKGxxBYIZFyZey5deAfC2IO/cNJc+x1TfgZdqVn
	 iMh6himRbc421qyxoRZW7WguudCiRkmRkOXfY+s0iLVDgTfi70+QMo/H6zFjE7SAlD
	 AiFuwB8jOIH1GeMClCZsg2ASG9Lb3qWvz2vmUsup2OfldYRSE0wxMHXFN3dPnrOKrR
	 RL4BGn0nv7h2B+SW0lkzd6zfU+d03sTro80Ds9JYNThmj++64e88O6iZ07n7N3gDCP
	 NqcZuNOCYAhAY/fKd3UryGiUTzp55WhmihZGtBqVbFM7AFbIIES6jvrw/aohXf4j6w
	 kQHnE6GGxSE9g==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20240207-axi-spi-engine-round-2-1-v2-0-40c0b4e85352@baylibre.com>
References: <20240207-axi-spi-engine-round-2-1-v2-0-40c0b4e85352@baylibre.com>
Subject: Re: [PATCH v2 0/2] spi: axi-spi-engine: performance improvements
Message-Id: <170740999742.1643259.15722481227553844902.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 16:33:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Wed, 07 Feb 2024 08:51:23 -0600, David Lechner wrote:
> While researching potential performance improvements in the core SPI
> code, we found a few low-hanging opportunities for improvements in the
> AXI SPI engine driver.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: axi-spi-engine: remove use of ida for sync id
      commit: 531860e12da76a444e0ecfd37a9d786e7986957a
[2/2] spi: axi-spi-engine: move msg finalization out of irq handler
      commit: abb4b46c43689dd1f4d80c41e49127ca0ede75b3

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


