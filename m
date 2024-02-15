Return-Path: <linux-kernel+bounces-67782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FAC8570AF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CEB1C21A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B161419A6;
	Thu, 15 Feb 2024 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lA4Jb1iX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23813AA3F;
	Thu, 15 Feb 2024 22:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037114; cv=none; b=J1r1IINnL3G9d4b4USuwq53hF+m39GDWPF2mtCRiKwK9XWZm1NB9DpJZgebtavJigdVZ+EJMfh411Jwk/2ZQ7uzqlQ3b8bJYMF81HBD0I6XslbiN+V9EUziP8ygZwytKlweqiOmmYgKsmvzUh2AZ2TPoQFAItlHFAcIlMV+44mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037114; c=relaxed/simple;
	bh=L76Sg0D6O8zeR7pfF8vTouMZ0eSszIjsF07eYosEf6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+hCQDhJXoRpKK4BbZF2DpDbsW+Dke5Jd49Asy3Q1K9c7LYwuGx72VJyBVt4ahP4In2PWfoR9uqh2FcHAGKbRnFd6328xqgcqZq2Rb5Z2vwva/guhFJsODQiFTXHLhlMOKJ35yOvo+loeBNwSEl26igXp49fon8pknstoNDLPf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lA4Jb1iX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293FAC433F1;
	Thu, 15 Feb 2024 22:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708037114;
	bh=L76Sg0D6O8zeR7pfF8vTouMZ0eSszIjsF07eYosEf6k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lA4Jb1iXhKL08Bf1XFoqRi8T42e8irvjslvPN6NkiJTTg51Buf3Xif+58Pumhaf9T
	 l3aypLUahg9+/WUiRERb6EoTr/R7qkBdUhY3dGml8eUNTT0P9z15OfbgTNmNdZTbkO
	 ukdK1KyBFjiOHiE3HQ6Z+35+Fz/XeI6pBsAt24PvTpFpS+oYXolrZiVlpEvznxVqGs
	 8OrIjt6DxnGzB2l6GS5uRWCqBhddgJqEXSJE58uX4oZetCw+F6hVrzU7cF2G3Vn6DQ
	 Jjd8QOR8SMTo1pX+eHT3G4UysDyZHVO4HrI+T1hPUj5zzJdttJ+YZ0mIASm8sqYcNR
	 9WQ4tqOOn/wDA==
Message-ID: <0b57d422-6b7f-43e2-8068-8ebae15dd1bc@kernel.org>
Date: Fri, 16 Feb 2024 07:45:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci_ceva: fix error handling for Xilinx GT PHY
 support
Content-Language: en-US
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, cassel@kernel.org,
 p.zabel@pengutronix.de, axboe@kernel.dk, michal.simek@amd.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1708020060-1439879-1-git-send-email-radhey.shyam.pandey@amd.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1708020060-1439879-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/16/24 03:01, Radhey Shyam Pandey wrote:
> Platform clock and phy error resources are not cleaned up in Xilinx GT PHY
> error path.
> 
> To fix it create a wrapper ceva_ahci_platform_enable_resources() API which

create a wrapper ceva_ahci_platform_enable_resources() API -> introduce the
function ceva_ahci_platform_enable_resources()

> is a customized version of ahci_platform_enable_resources() and inline with
> SATA IP programming sequence it does:
> 
> - Assert SATA reset
> - Program PS GTR phy
> - Bring SATA by de-asserting the reset
> - Wait for GT lane PLL to be locked
> 
> It switches to ceva_ahci_platform_enable_resources() in resume path
> as same SATA programming sequence (as in probe) should be followed.

What is "It" ?

> It also cleanup mix usage of ahci_platform_enable_resources() and custom
> implementation in probe function as both are not required.

Same here, but may be "It" == "this commit" ?
If that is the case, then simply rewrite your sentences simply like:

ceva_ahci_platform_enable_resources() is also used in the resume path
as the same SATA programming sequence (as in probe) should be followed.
Also cleanup the mixed usage of ahci_platform_enable_resources() and custom
implementation in the probe function as both are not required.

> Fixes: 9a9d3abe24bb ("ata: ahci: ceva: Update the driver to support xilinx GT phy")
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Other than these nits, this looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


