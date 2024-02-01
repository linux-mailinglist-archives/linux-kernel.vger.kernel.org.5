Return-Path: <linux-kernel+bounces-48252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65107845925
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82C5B215DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FF75CDF4;
	Thu,  1 Feb 2024 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpvwpqNH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372E25CDE2;
	Thu,  1 Feb 2024 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795056; cv=none; b=rneNXuxXY/QrpOvurVxQqlzcmTJqUcEZ5DwVwriiH+Fr2PsdPevIb/R2AnRR3kIJTzs4/LFY3c2hPLditeDtKJIW5ajWVH58Jwk9U4zktFdccTIXhVSI9e2El95+sS36Ts8fSaZu/l6UiXimy0nkvVReeGYnARFClLxlycLb7I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795056; c=relaxed/simple;
	bh=Msf2lTT82pvd+Y2JFn9SvqSk+OAHLJCSOGfkBm5c9aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfRYSQjJ6D6m6t8Q7W0sdLX5mbGs1barV0LMC+/ONd9vvFM3iLJEbFDkkT8kz3MB8V7eXYVBlv/uz2d5U+0W/SRI78twtcx1FlFpm3XJM58H8zieWhO7p+qejaVUU3x7s6UHTxUCDyhRxCvuswbP4c6HkaexweZ1bfujW0buTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpvwpqNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3CDC433C7;
	Thu,  1 Feb 2024 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706795055;
	bh=Msf2lTT82pvd+Y2JFn9SvqSk+OAHLJCSOGfkBm5c9aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpvwpqNHfGxpiG5WFFWI74s4F2ZciU5GrmZYIAennh8bH+DenvJ9lfuxHSuVXgIwI
	 ulX4YyFhwDseSLSpCyQPCPtbv274afIykVymHUM1DpTRsYQQin4sKAIY/zrd5JFH7L
	 piRAEUXENuq49IRH58HqIYwuP8fxLft0aizTUlydFWzbXRcXOk8Q54C4CIilr14eZ6
	 rwiPUhqkKFh8IDptO2xiEh60BkAD1xYQ6quOyvasDjn8PfnMun669laS1zUnUc0oNG
	 +nBhNUTLiwLGbEeS5WUuvxxr4uDNGVNBEFRumokVgqzHysJ5taoYCOVmHiE12QhU6r
	 pm9pS7cygFoPQ==
Date: Thu, 1 Feb 2024 14:44:09 +0100
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net v3] net: stmmac: xgmac: fix handling of DPP safety
 error for DMA channels
Message-ID: <20240201134409.GD530335@kernel.org>
References: <20240131020828.2007741-1-0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131020828.2007741-1-0x1207@gmail.com>

On Wed, Jan 31, 2024 at 10:08:28AM +0800, Furong Xu wrote:
> Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> XGMAC core") checks and reports safety errors, but leaves the
> Data Path Parity Errors for each channel in DMA unhandled at all, lead to
> a storm of interrupt.
> Fix it by checking and clearing the DMA_DPP_Interrupt_Status register.
> 
> Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> Changes in v3:
>  - code style fix, thanks Paolo Abeni
> 
> Changes in v2:
>   - explicit enable Data Path Parity Protection
>   - add new counters to stmmac_safety_stats
>   - add detailed log

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


