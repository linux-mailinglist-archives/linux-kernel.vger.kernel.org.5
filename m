Return-Path: <linux-kernel+bounces-78404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECCD861305
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEAB9286937
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849AA81749;
	Fri, 23 Feb 2024 13:41:21 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ADB7F493;
	Fri, 23 Feb 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695681; cv=none; b=Z/3VclEkFiFBloisjt1nwePNwcksYgPb87KkIFxs04b4I+ICzxqnxIKp7wzpwuoF4/G9zDiHWL0rC84yhCACQnukMFbr1zed4pNp5tUlipRN4m+yvCEtZAa/iqNPu/VZ1bqQZr3T7jWSZFJ1yK2soo0Ja6rn2G7I0w4ZGatltcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695681; c=relaxed/simple;
	bh=yuJXpRYUJshMxuzMieG1EFSg+djx7nwtZ8wXWiT2ueU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XyqZQ3PmjRowuKuXFvjN3jMoBqaNPDWK9kVNxqLshCmXEPJIG1uI2o2JwMhSzol9jwtcEuNQh92LxMtqCn/3/b3nPdpXQNZBTU+m5LJ07oxoUCOEih5mpWp0FudJQi9oj7ZRtr6mb4pG/ok5NsLAgjZvXVzfZyoFYiYu6qoa6mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rdVn4-0001FZ-Ou; Fri, 23 Feb 2024 14:40:38 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Shreeya Patel <shreeya.patel@collabora.com>, Simon Xue <xxm@rock-chips.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Quentin Schulz <foss+kernel@0leil.net>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Quentin Schulz <foss+kernel@0leil.net>
Subject:
 Re: [PATCH 1/3] iio: adc: rockchip_saradc: fix bitmask for channels on
 SARADCv2
Date: Fri, 23 Feb 2024 14:40:37 +0100
Message-ID: <4499105.Wku2Vz74k6@diego>
In-Reply-To:
 <20240223-saradcv2-chan-mask-v1-1-84b06a0f623a@theobroma-systems.com>
References:
 <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
 <20240223-saradcv2-chan-mask-v1-1-84b06a0f623a@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 23. Februar 2024, 13:45:21 CET schrieb Quentin Schulz:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> The SARADCv2 on RK3588 (the only SoC currently supported that has an
> SARADCv2) selects the channel through the channel_sel bitfield which is
> the 4 lowest bits, therefore the mask should be GENMASK(3, 0) and not
> GENMASK(15, 0).
> 
> Fixes: 757953f8ec69 ("iio: adc: rockchip_saradc: Add support for RK3588")
> Cc: Quentin Schulz <foss+kernel@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

after checking against the TRM

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



