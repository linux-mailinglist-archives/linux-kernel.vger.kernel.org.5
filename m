Return-Path: <linux-kernel+bounces-162693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1598B5F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2CBCB213AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB6584A58;
	Mon, 29 Apr 2024 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDHwpBwM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352EE84E1B;
	Mon, 29 Apr 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408598; cv=none; b=n4TYRqOLE863M5/+dOKeIV0NxB7WEfr7XZnWatqHCSUW3ilkl/q9nK9G9iDR0QS98TWArBjvEP8kqrj3hNLMwT9wogxX+4IKFL3U+bHk+/BUFVgft5mWDRLn8aUL0fHv9Wysq1Xfs9PYp5rOHdzw2OjzvQoA0AZZdjn2uhW4Ko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408598; c=relaxed/simple;
	bh=fgSKb2lwvDBvPMmVmRJwxhth9YzFQDQdsEr9HfbL5yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iibVxYdeWYCp+ibUpkPiYDdiXuSWw1fdp7e5pwIRY4zDH8qwxJU8hmq4cCBQPelHS5hxxMk11WlDszwENfJn0HM/WJpMZ28Q2gRnHOSj9v3hoZ1i52HcJXnNN77tlhfgU3L68OQr/0yNoZDZRq3AofEGCCorpj1UCIcytHkWxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDHwpBwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA721C4AF18;
	Mon, 29 Apr 2024 16:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714408597;
	bh=fgSKb2lwvDBvPMmVmRJwxhth9YzFQDQdsEr9HfbL5yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDHwpBwM0YY0dIOhxTwSvBih1XHfmxFemrNC7H1vsZlRU9dtpxx+3aGi8e6qGXSet
	 ++0V0LqyYXCYxdCJbv/FJtIqcUxL+tIm9bLc9lziMj1QFk6JJo9oG4MP7R25D9+gWS
	 GoFcqyCB2oYcF45xMN1Tfvgf6YxbNmKJTXlPFDTgsNektWqutM5oXTGFPrsX+xLBsc
	 9HAYUsH4KqkjGYt9dy3SWzopNfYlE9svOuR7WTvN12yJqF15MLOSDDKSq6Mj80iLUw
	 RswJOryh47sAEEpxriPPbqALSbvVRmP2UmXWDXO12grOycXywOeSNeUgx3EO6hy+17
	 fbvSEa5+nanbg==
Date: Mon, 29 Apr 2024 17:36:30 +0100
From: Simon Horman <horms@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, saeedm@nvidia.com, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	andrew@lunn.ch, corbet@lwn.net, linux-doc@vger.kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	horatiu.vultur@microchip.com, ruanjinjie@huawei.com,
	steen.hegelund@microchip.com, vladimir.oltean@nxp.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
	Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 02/12] net: ethernet: oa_tc6: implement
 register write operation
Message-ID: <20240429163630.GA516117@kernel.org>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-3-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-3-Parthiban.Veerasooran@microchip.com>

On Thu, Apr 18, 2024 at 06:26:38PM +0530, Parthiban Veerasooran wrote:
> Implement register write operation according to the control communication
> specified in the OPEN Alliance 10BASE-T1x MACPHY Serial Interface
> document. Control write commands are used by the SPI host to write
> registers within the MAC-PHY. Each control write commands are composed of
> a 32 bits control command header followed by register write data.
> 
> The MAC-PHY ignores the final 32 bits of data from the SPI host at the
> end of the control write command. The write command and data is also
> echoed from the MAC-PHY back to the SPI host to enable the SPI host to
> identify which register write failed in the case of any bus errors.
> Control write commands can write either a single register or multiple
> consecutive registers. When multiple consecutive registers are written,
> the address is automatically post-incremented by the MAC-PHY. Writing to
> any unimplemented or undefined registers shall be ignored and yield no
> effect.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

..

> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c

..

> +/**
> + * oa_tc6_write_registers - function for writing multiple consecutive registers.
> + * @tc6: oa_tc6 struct.
> + * @address: address of the first register to be written in the MAC-PHY.
> + * @value: values to be written from the starting register address @address.
> + * @length: number of consecutive registers to be written from @address.
> + *
> + * Maximum of 128 consecutive registers can be written starting at @address.
> + *
> + * Returns 0 on success otherwise failed.

Nit: I think you need a ':' after "Returns" (or "Return")
     in order for kernel-doc -Wall to recognise this as a return section.

Likewise elsewhere in this patch(set).

> + */
> +int oa_tc6_write_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
> +			   u8 length)
> +{

..

