Return-Path: <linux-kernel+bounces-79743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A7D862623
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFAF1C210DD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E7741A87;
	Sat, 24 Feb 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNTtK/Li"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A8C4C6B;
	Sat, 24 Feb 2024 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793508; cv=none; b=ZVc2rcvG4fEVqzJc0h0dVj1zRf8RKuiY+sKNVewKoNM4TDNX2cQPAAFuZYOzjho5R+LBcSFv7Vub7Msp5qZTUAi9C4LG0duuuZPtLjvzqYBx8KhcJD0haYzaOojLQTOgSyhrj75geo2cRDGvC0+rz4KLrrodGL+QxbmUeZ1xcEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793508; c=relaxed/simple;
	bh=nihirJ4RZALZuGoBNINSTW4VKZsU1WnAfv17CGmeF8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxN2k5uazl3lpdYRhbs54a0oogvWC/i0DWuyYJ47InnS2ov7m8PlYcdM1kah+mItctBrjM35FW7IfbjN1jPGt9EZCHJqs7x5Ut16SZCbMRRFsZMLtKqpHhnlkZK+nkAISSt24yrt4blle3BZ2+dqEZ2tB28SMSeaYqLwEXQySiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNTtK/Li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A65C433F1;
	Sat, 24 Feb 2024 16:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708793506;
	bh=nihirJ4RZALZuGoBNINSTW4VKZsU1WnAfv17CGmeF8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dNTtK/Li5PCR0Sg1Ccnvl305yJ56h4eFbwZCT7S7n1lLZ44JKhTtzX9SjlZDIoF+M
	 VzoYFmO0d729WgRzmEG8T7dR6pWU6QvAB3gExw33F9y3z4k8Nmmeue1M5uQn7+7DkV
	 dplA7SXAHj84+JiuBT0Cu1xnBbjODy4qb+78Nv8AgRZJa2vMr/mBENpHY2l/mKzc0P
	 7CKFBpvcUs2atEmOYo9zrRl0/By0CzNPPdmsMuGnBpwFG87CrlqoW+ilCi3NPLeucx
	 5EAC4DBB7Q4N/VWNH24Jy1M+bFi7n3T4PzkWQ5ztdWgmoRagc8zgxe9RHx8F8jATlh
	 zUwlfl6/C8hIQ==
Date: Sat, 24 Feb 2024 16:51:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Martin Sperl <kernel@martin.sperl.org>,
 David Jander <david@protonic.nl>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, Julien
 Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH v2 4/5] spi: axi-spi-engine: move message compile to
 optimize_message
Message-ID: <20240224165133.33a6ad94@jic23-huawei>
In-Reply-To: <20240219-mainline-spi-precook-message-v2-4-4a762c6701b9@baylibre.com>
References: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
	<20240219-mainline-spi-precook-message-v2-4-4a762c6701b9@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 16:33:21 -0600
David Lechner <dlechner@baylibre.com> wrote:

> In the AXI SPI Engine driver, compiling the message is an expensive
> operation. Previously, it was done per message transfer in the
> prepare_message hook. This patch moves the message compile to the
> optimize_message hook so that it is only done once per message in
> cases where the peripheral driver calls spi_optimize_message().
> 
> This can be a significant performance improvement for some peripherals.
> For example, the ad7380 driver saw a 13% improvement in throughput
> when using the AXI SPI Engine driver with this patch.
> 
> Since we now need two message states, one for the optimization stage
> that doesn't change for the lifetime of the message and one that is
> reset on each transfer for managing the current transfer state, the old
> msg->state is split into msg->opt_state and spi_engine->msg_state. The
> latter is included in the driver struct now since there is only one
> current message at a time that can ever use it and it is in a hot path
> so avoiding allocating a new one on each message transfer saves a few
> cpu cycles and lets us get rid of the prepare_message callback.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Whilst I'm not familiar with this driver, from a quick look at this
patch and the driver code, looks fine to me. So FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

