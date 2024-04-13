Return-Path: <linux-kernel+bounces-143702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0121D8A3C6B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60322281FEC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E58C3DBBE;
	Sat, 13 Apr 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAOnqAN4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A51DFD0;
	Sat, 13 Apr 2024 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713006321; cv=none; b=ShgOGf6gbl2K3LWCo0IKFRGpIag1k3gbR4WJ0SiVclMlinfQs+w3zQNOsazuoVMnzuce3RQ4HwksBdNb9TE/EDXzxrd8REtCihznNzdlJi+b5hEtC9RjedPvi1M9/nw1lZ4jY3FB7hW+ngWVZQ1HbT7kQNFjHAT7oTnibGqP+Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713006321; c=relaxed/simple;
	bh=V3Zu5G77tqEQ8hNClJQcGwH8VEW5Nfg9tKuIPYVYU/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMTijhrXscnLDv1ToVSCJFfFWumoQ8cGuetXsdMf4NXDuLpg1F2oElzOjPtcbv0DxKn09NDtdndW3aJ7HBTHAYENAFhasz2HWj6kAiOrX90w0dCfb1Lqb0VjvyDMJjhuQZhhpRArUAFsjZIm7ytIA6KyARTY51TpbKF7ZCz8fRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAOnqAN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DFFC2BBFC;
	Sat, 13 Apr 2024 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713006320;
	bh=V3Zu5G77tqEQ8hNClJQcGwH8VEW5Nfg9tKuIPYVYU/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SAOnqAN4DVepX+AHbcnLGgFGqdPWgawkgnuUO7Uw/WbTUBZBGvY7w3fh3mspPVuxm
	 SbNPi3gz5vVfI8tguUWt3DRZGiZrAsGsRwkjgkmzNDmTab8mm/SJaMvne7ybzuxY98
	 lRLFePdmClDha7jI8+XaWRvdwBbGtzP1gDn180aJHcVte76yDI5hvXlV/f+QkFWcjw
	 gXf4XiEqrNpW2XsJVjzfb+z91f0VT545FMkj+2DOaBI5MSwFM9JDKnW7vlNmPhc0UR
	 j8j+U3XviYRSH1Lq+F+nyjJii/88J5PI86HuPl4oMYQH4XnYGXW5Z9pZWjP5Z2b1Hx
	 ym0cUnmAheL2A==
Date: Sat, 13 Apr 2024 12:05:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7944: Consolidate spi_sync() wrapper
Message-ID: <20240413120507.05bbd229@jic23-huawei>
In-Reply-To: <20240412-ad7944-consolidate-msg-v1-1-7fdeff89172f@baylibre.com>
References: <20240412-ad7944-consolidate-msg-v1-1-7fdeff89172f@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 18:25:02 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Since commit 6020ca4de8e5 ("iio: adc: ad7944: use spi_optimize_message()"),
> The helper functions wrapping spi_sync() for 3-wire and 4-wire modes are
> virtually identical. Since gpiod_set_value_cansleep() does a NULL check
> internally, we can consolidate the two functions into one and avoid
> switch statements at the call sites.
> 
> The default cases of the removed switch statement were just to make the
> compiler happy and are not reachable since the mode is validated in the
> probe function. So removing those should be safe.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
I was initially dubious about implying the need to change a GPIO when we don't,
but given that the resulting function is really simple and the comment on that
is immediately above the code (not obvious from this diff) this seems fine to
me.

Applied.

