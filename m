Return-Path: <linux-kernel+bounces-34148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA293837468
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5728CB25F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB7947F70;
	Mon, 22 Jan 2024 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q64sLgNz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9924BA85;
	Mon, 22 Jan 2024 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956288; cv=none; b=XGMChzfu8Qb2Kl/nln4rXzFoW6gu45rZng15jZ3xvFoBq5EKEF85fVcuwYgSjJBzGnNRKa3fS9V1U0Q8RtZ0QWnVfuZoW6co52cjRRTaIxZnK/cytPSa7OUXl70sOU2+/imb56hVBLXXuZgnP6VNCJ/v2pdHRB47oiKTQ0eWRj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956288; c=relaxed/simple;
	bh=JQvciz5jsv44g++hdQc9lWTAzEqEpcuF2+K9B8lenj4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PmO7h+4Wv4ICZHvddteKLjNAbhdLCPNO9v7l3ubVcTxLIorhFJ10WWHZ/vDaPeo9YIHgRIG4PH01hoWF+PyJrUa+fwCzkL2WvvBqsG0ehLkk8N/not1IZNn5pQPuLsxZY6FnhP+EW7o7SRyJey8EYLN6t+aBrArcYZmPXcHsIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q64sLgNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ECFC43390;
	Mon, 22 Jan 2024 20:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956288;
	bh=JQvciz5jsv44g++hdQc9lWTAzEqEpcuF2+K9B8lenj4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Q64sLgNzWIimoImgRHbvx3ATfMnHfZHu3TFmnJFYr5xqXnag1ZIKdC/rwXSPBFvaD
	 SdsK24rappa6uJFYkrQqn0+7FILiCH6Lya0J9hE9uzyZYDtNNU1VHfSzdMjSNl5DcF
	 gpIlPh7hlyfPB8MwDiAaCnyXWs7YcOIfpRM+gLITT6+8cnqomp+WAJYcqiUAa6kxz3
	 REdWg3Z/Af84kIvJ2CgNtOEY5QrwUT6CZ0oZS+6XTkiHgWsekmwSlE4Az6k+z6QRJb
	 1+rSQ69Y65T3iJf1ZfDnVQRR/XkxDI7dFvi2FMwwFhNpDpBXNyO4QsRYBpsnrQe3Lj
	 A41Wfhbj+ZuiQ==
From: Mark Brown <broonie@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, linux-spi@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240120170001.3356-1-semen.protsenko@linaro.org>
References: <20240120170001.3356-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH] spi: s3c64xx: Extract FIFO depth calculation to a
 dedicated macro
Message-Id: <170595628644.145694.4107677394657864238.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 20:44:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Sat, 20 Jan 2024 11:00:01 -0600, Sam Protsenko wrote:
> Simplify the code by extracting all cases of FIFO depth calculation into
> a dedicated macro. No functional change.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: Extract FIFO depth calculation to a dedicated macro
      commit: 460efee706c2b6a4daba62ec143fea29c2e7b358

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


