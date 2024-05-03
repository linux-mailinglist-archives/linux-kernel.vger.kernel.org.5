Return-Path: <linux-kernel+bounces-167263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7AD8BA6A9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCBD1F22AA4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD02139CE4;
	Fri,  3 May 2024 05:34:57 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBEA13959A;
	Fri,  3 May 2024 05:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714714497; cv=none; b=s0ejMJh+xAm3qvftBUOqnrI3qi2Dwy3yj5neeyPkDm6nMRjNiWA58g3szj8bJXU9mFTGPpVPwWR1gbqMbytAbLkH7bY9bTFLBitFNsZ6jICNPLFVNHqyCBMIvi4xFcihIyvugPpkUlAENzbZtmSPqspf+d9VZy5fjb/gcqOfY5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714714497; c=relaxed/simple;
	bh=Rf7BNULsIILDBBx8Kx5UFYUTpLCCGsnOd4XtYj0Uwjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9jZbsAsuruHqDBvCxAV8j9h6C8zGwE6tHfkrMktzhIp9FkkS5xY1JcJjXl39FUo/sHefq0oOHGoBLXpr4o3ZqnJNl7BpxwMboGLqjTb3+vmHJxC4VrCr/dgNS6M+xU14mN3Jzvxglj+KggDROLEv4ye1eiNOpNfvK5W7U8pVws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.50.1.206] (unknown [89.187.201.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EAB1361E5FE35;
	Fri,  3 May 2024 07:34:02 +0200 (CEST)
Message-ID: <4bd85100-0f3d-4e38-973c-e6938f304dde@molgen.mpg.de>
Date: Fri, 3 May 2024 07:33:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: fix link fluctuations problem
To: Ricky Wu <en-wei.wu@canonical.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org,
 rickywu0421@gmail.com, linux-kernel@vger.kernel.org, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 anthony.l.nguyen@intel.com, pabeni@redhat.com, davem@davemloft.net
References: <20240502091215.13068-1-en-wei.wu@canonical.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240502091215.13068-1-en-wei.wu@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Fix address jesse.brandeburg@intel.co*m*]


Dear Ricky,


Thank you for your patch.


Am 02.05.24 um 11:12 schrieb Ricky Wu:
> As described in https://bugzilla.kernel.org/show_bug.cgi?id=218642,
> some e1000e NIC reports link up -> link down -> link up when hog-plugging

Do you mean ho*t*-plugging?

> the Ethernet cable.
> 
> The problem is because the unstable behavior of Link Status bit in
> PHY Status Register of some e1000e NIC. When we re-plug the cable,
> the e1000e_phy_has_link_generic() (called after the Link-Status-Changed
> interrupt) has read this bit with 1->0->1 (1=link up, 0=link down)
> and e1000e reports it to net device layer respectively.

Wow. I guess this was “fun” to debug. Could you please document, what 
NICs you saw this, and if it is documented in any datasheet/errata?

> This patch solves the problem by passing polling delays on
> e1000e_phy_has_link_generic() so that it will not get the unstable
> states of Link Status bit.

Does this have any downsides on systems with non-buggy hardware?

> Also, the sleep codes in e1000e_phy_has_link_generic() only take
> effect when error occurs reading the MII register. Moving these codes
> forward to the beginning of the loop so that the polling delays passed
> into this function can take effect on any situation.

Could you please split this hunk into a separate patch?

Should it Fixes: tag be added?

Are there any other  public bug reports and discussions you could reference?

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218642

> Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c |  5 ++++-
>   drivers/net/ethernet/intel/e1000e/phy.c     | 10 ++++++----
>   2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index f9e94be36e97..c462aa6e6dee 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1427,8 +1427,11 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
>   	/* First we want to see if the MII Status Register reports
>   	 * link.  If so, then we want to get the current speed/duplex
>   	 * of the PHY.
> +	 * Some PHYs have link fluctuations with the instability of
> +	 * Link Status bit (BMSR_LSTATUS) in MII Status Register.
> +	 * Increase the iteration times and delay solves the problem.

Increas*ing*?

>   	 */
> -	ret_val = e1000e_phy_has_link_generic(hw, 1, 0, &link);
> +	ret_val = e1000e_phy_has_link_generic(hw, COPPER_LINK_UP_LIMIT, 100000, &link);

Could you please document how 100000 was chosen?

>   	if (ret_val)
>   		goto out;
>   
> diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
> index 93544f1cc2a5..ef056363d721 100644
> --- a/drivers/net/ethernet/intel/e1000e/phy.c
> +++ b/drivers/net/ethernet/intel/e1000e/phy.c
> @@ -1776,7 +1776,13 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
>   	u16 i, phy_status;
>   
>   	*success = false;
> +
>   	for (i = 0; i < iterations; i++) {
> +		if (usec_interval >= 1000)
> +			msleep(usec_interval / 1000);
> +		else
> +			udelay(usec_interval);
> +
>   		/* Some PHYs require the MII_BMSR register to be read
>   		 * twice due to the link bit being sticky.  No harm doing
>   		 * it across the board.
> @@ -1799,10 +1805,6 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
>   			*success = true;
>   			break;
>   		}
> -		if (usec_interval >= 1000)
> -			msleep(usec_interval / 1000);
> -		else
> -			udelay(usec_interval);
>   	}
>   
>   	return ret_val;

