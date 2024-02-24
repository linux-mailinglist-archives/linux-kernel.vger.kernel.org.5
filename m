Return-Path: <linux-kernel+bounces-79740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAFA862609
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FA71C20D9D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8663224B29;
	Sat, 24 Feb 2024 16:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eS2pHSNT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D6FC129;
	Sat, 24 Feb 2024 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708792595; cv=none; b=P9xTRp230hvnudXI7A0Z2hTbKejWZptBVhny++vKir2gzOR37skgLfKf/yAlKokxBIhIDq37fJgRf124FFK2oL05cNH6XujnWegEozNcyYOEqgtbawMVcigbSQK640O2DpDZ1sNhiyryJuX5AUi/8p/IgsMXFdDpA7LnN6uu0BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708792595; c=relaxed/simple;
	bh=gM276SnHL2yQRhjWluMy72+pHXOACMKdHCyQEkwDvW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbnqZ0HfLxlH2MlbbDqDMHitzQGuMMV+E/NtZmER6xV7J0K2ohL1rNLdBryon37vyXbLrJ+H67l2Adm6nfpu+l8n8GWTZ6Wc4YT/JJlg6qG1bpiOxSIl7HiABWPjUpPXT5Klwk2vWCO3RGQJTri3SF7+Wl95MkOqdxDivhOW/KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eS2pHSNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625D2C433C7;
	Sat, 24 Feb 2024 16:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708792595;
	bh=gM276SnHL2yQRhjWluMy72+pHXOACMKdHCyQEkwDvW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eS2pHSNTctVqZzjxj55wZ7G7ek+cOc48r61zURdfat6qlFaGzGcVpU3AyLll0ReE8
	 m687ScBjqS9ptwEn7+/GQS0vXXvQERJbTmzekOQMPsAE+Rm5l7xqdUBQsIFTpNvVan
	 tGNBuon5fdADFZjSTB3syn4s8w553xVYOtAQ8lhfvCJTPMwr0QY6llrhkVCuzlKIi7
	 HYNWKvi1US/l8T+p5PsbZn2jOKMLJhEF4ybzMMJboMSz5z41h1MSBhTqFKvjzRIZbj
	 Suv2ANY/0FEO5GbXSBdxnIveTn4HZI1JuPPeveMFAcZvNZ39uRuR7yXC5C4kJM3+qa
	 uWjP+05puz6Sg==
Date: Sat, 24 Feb 2024 16:36:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Martin Sperl <kernel@martin.sperl.org>,
 David Jander <david@protonic.nl>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/5] spi: add spi_optimize_message() APIs
Message-ID: <20240224163622.7499cdd0@jic23-huawei>
In-Reply-To: <20240219-mainline-spi-precook-message-v2-1-4a762c6701b9@baylibre.com>
References: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
	<20240219-mainline-spi-precook-message-v2-1-4a762c6701b9@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 16:33:18 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This adds a new spi_optimize_message() function that can be used to
> optimize SPI messages that are used more than once. Peripheral drivers
> that use the same message multiple times can use this API to perform SPI
> message validation and controller-specific optimizations once and then
> reuse the message while avoiding the overhead of revalidating the
> message on each spi_(a)sync() call.
> 
> Internally, the SPI core will also call this function for each message
> if the peripheral driver did not explicitly call it. This is done to so
> that controller drivers don't have to have multiple code paths for
> optimized and non-optimized messages.
> 
> A hook is provided for controller drivers to perform controller-specific
> optimizations.
> 
> Suggested-by: Martin Sperl <kernel@martin.sperl.org>
> Link: https://lore.kernel.org/linux-spi/39DEC004-10A1-47EF-9D77-276188D2580C@martin.sperl.org/
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Very nice.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

