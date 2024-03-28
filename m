Return-Path: <linux-kernel+bounces-122949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A778789001F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A2A3B222AF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1232F8004A;
	Thu, 28 Mar 2024 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWMV9tpt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554CA7E572;
	Thu, 28 Mar 2024 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632207; cv=none; b=M1oA7VHR+RrVAnp6oTvFCKnliw0xTnIFZyn4uc4vTP9zQyXE/yQCCeTut0HewmQYAVVG3KwDPA9DPa6tP0L3HD1Yls6z0S/xj4tuaFgMmyG+8cdgXEz35ryMoaBNGQkBQmAWdUei1KSejDsyN64SOgVK/gAU7U333qhwWCQq9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632207; c=relaxed/simple;
	bh=WwrHa0cIn3sLHwgL4ee6fSwgygq41ZkzFEiD39Kmi60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYITA/k4DC9YtwAnHrXqb1rc/CLK7ddU8+4MwkgP1vJ4NAMnB4ieKsY/E06wLEOtHDu5isdl3drAmsxEi5+zjqIY5gAK4L/w5ORiU0LoQ5KR1COtnJQWueh5z5RCzeFVwQFR4pHSIRNsV5FgbNPNo3F3mXMDaUhK0zz/ioJXcwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWMV9tpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4158C433C7;
	Thu, 28 Mar 2024 13:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711632207;
	bh=WwrHa0cIn3sLHwgL4ee6fSwgygq41ZkzFEiD39Kmi60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pWMV9tptovIXjeBwemw0pnxq1huQpLWmAQqPv35HutFscCATEVH48Gw4BHVSD41Q0
	 6M0Tz9i9I+pXKZuiWRy0D0YvHa4+lg9hNVlOol4roJelanQLGcjOizTSsb2gP0cWCJ
	 rz1F8qDnJyWHkeG9Fd/JsoPv9I2LZGxp2y5ttGHBeOlcTOHEgC1Xz8YAjajpWa0fdG
	 2wm09Roj1SuLT5LwGutE2M9ZSyxFuI96O9R+ZTGrsH184Ty4LuXzrkZIB/x5+ClMz3
	 06i6yAD6D4GwmF0Q8Vd8YCAFuyxzYrzpFTfNagJqdRNwv/vhsdRYiVgh2IuNJ0srq4
	 DUdoKfHIpiyng==
Date: Thu, 28 Mar 2024 13:23:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] iio: adc: ad7944: simplify adi,spi-mode property
 parsing
Message-ID: <20240328132312.52f34df4@jic23-huawei>
In-Reply-To: <20240325-ad7944-cleanups-v3-1-3a19120cdd06@baylibre.com>
References: <20240325-ad7944-cleanups-v3-1-3a19120cdd06@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 14:40:36 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This simplifies the adi,spi-mode property parsing by using
> device_property_match_property_string() instead of two separate
> functions. Also, the error return value is now more informative
> in cases where there was a problem parsing the property.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

For this I'd already picked up part of an earlier version so hopefully
the rebase of my togreg branch needed to take this didn't cause anyone
any major problems.

Anyhow, dropped earlier version in favour of this one.

Jonathan


