Return-Path: <linux-kernel+bounces-79749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFB6862631
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED841C213BB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF92A41A87;
	Sat, 24 Feb 2024 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0SNdABS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E312B69;
	Sat, 24 Feb 2024 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793844; cv=none; b=VGFrogss3SA9J3B2hBjDJ+d0wO3mb33ppJ+ykP6YuQVqHav4+D+bGZBCnFAfaxO76kf3IsY52l+7n4Q7i3i7kCW3GZaCZOeFXoFRZt4ny7lRdj7ur5ckXW85yoBj24YAqvPDMtddm9Mb6leYth/ZCD/H0D3UQuwHHDmvnhg4I1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793844; c=relaxed/simple;
	bh=b1/O19NtIgvo/C+lW8h+C0KQWgkOYejs2p1WPoFlrhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEMgUgOO/pGUS9BkRJDVEJ47OrU6I7/VtIczCCIkps6EAHu8FOxSpNGdEyO4rlKKpa+tgLjyrYtiawUUxsKHyqSPogSxitPORzWK2HPFdC3s7Jn2Hd074f+6VAZy2kze7REtoTPbIZ5JXz/sawsQIItCUBMyuqYoaPUayykRTRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0SNdABS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09E2C433C7;
	Sat, 24 Feb 2024 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708793843;
	bh=b1/O19NtIgvo/C+lW8h+C0KQWgkOYejs2p1WPoFlrhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o0SNdABSZnstzIU5Tkf/2awpLbq6irmAkpVOB826tfoe+pTjmSkJv7cWfXBql67Cy
	 2ykl6W0SfHuZQKaM7IDFV4s0rolTsZlDVJD6weRIv1T2x5EEmbpa+ACLQScmDPEYcu
	 YKhO5EHBaxgAeMKVyF788hgYzJIuqnLPfH9frtZS/zJm1jJ59LlFsXXNja5y+60Rlw
	 Dbzo/da4Zum8Sdp/+fuiXvZAkU3ultlDRy0pZMZaWWcCpdfnMGdoJ7ys4tBN1LYXnC
	 NG5yZTgqyODzmpC773fHbt+nCY6qm4yGyx44JMj6nxrI3QXhybydAkPiZhFnnVVrUg
	 GgCeUxwIy2yMg==
Date: Sat, 24 Feb 2024 16:57:06 +0000
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
Subject: Re: [PATCH v2 5/5] iio: adc: ad7380: use spi_optimize_message()
Message-ID: <20240224165706.18cc0d7e@jic23-huawei>
In-Reply-To: <20240219-mainline-spi-precook-message-v2-5-4a762c6701b9@baylibre.com>
References: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
	<20240219-mainline-spi-precook-message-v2-5-4a762c6701b9@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 16:33:22 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This modifies the ad7380 ADC driver to use spi_optimize_message() to
> optimize the SPI message for the buffered read operation. Since buffered
> reads reuse the same SPI message for each read, this can improve
> performance by reducing the overhead of setting up some parts the SPI
> message in each spi_sync() call.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Looks good to me.

As this is the driver you asked me to drop earlier this cycle,
how do we plan to merge this series?

If Mark is fine taking 1-4 with the user following along that's
fine by me, if not I guess we are in immutable tree territory for
next cycle?

Jonathan

