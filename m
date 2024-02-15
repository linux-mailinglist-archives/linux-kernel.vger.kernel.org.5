Return-Path: <linux-kernel+bounces-66352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE540855B77
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52CE5B22823
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECF8DDC4;
	Thu, 15 Feb 2024 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhBDojdl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2BB33C5;
	Thu, 15 Feb 2024 07:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707981383; cv=none; b=nRpfNzLahTsMmUaeN2iqA9e3RgqibcRYEa5cEV0lpnrxR7FzUMY7pWgHo2MJgXRV6IQB3UxyiXzJcqinPpFy+hW/9x2K7Gl8akJ7KtK4/XHzQ66Pz3Po7PfcHLCWmwhSfv7jKfp7IX+u2fA9OCpAWk+I/ibWF7V+8JT+xXuTkTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707981383; c=relaxed/simple;
	bh=zwf/v9ehW4cFJdu8wIHwRPfcAJT+SRSX3JvxeAL8Fqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnddSgFxhOC2yCxEV85eGXYC2YN7UfpvZEGBpfjo6I55h7mEX/ukSveNAL2xKk/TSRQcIiTe1aSPRcxSU2776iRWVSX2qBC0+ITJR/205c0xlhi43bp4aVgb2/XhMYvPUfs9swXjhb/GrF83duhCjNxsB3ZLnBGVYj89+6z7krU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhBDojdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0ADC433F1;
	Thu, 15 Feb 2024 07:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707981382;
	bh=zwf/v9ehW4cFJdu8wIHwRPfcAJT+SRSX3JvxeAL8Fqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MhBDojdlLk13ZLeX/38gxdo8+tFWxfrLbHZzfVmPs6ZfvxlNA29dSN0FGj/Bk9hdH
	 /0vlXfph4rwspX0Hj9F18zPgJVCp7kXWO1dSwJMaUcsS8eZw/pWTyX2XBP8HLb3EMY
	 Tp0e/BO218uvTJABLZnKFYPyGpBYBQnu8AswWeP3/V35xm3EP4MfJIfOb8gqdouJCY
	 K9zp9d63Fiu90s2vFCmboJ52ujsfVuxSgWMyLBH7xBSiKIOtIoRP07RQlNmxpryu3+
	 mU8s7Oz3AxHQJaO5EVJcPM9OLURPFRsZ+f9zzaszI8UdG0yU2XwE8piIp61CAXXzyo
	 f4K7av7rH+hpg==
Date: Thu, 15 Feb 2024 15:16:13 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, peter.chen@cixtech.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: cdnsp: fixed issue with incorrect detecting CDNSP
 family controllers
Message-ID: <20240215071613.GA1256251@nchen-desktop>
References: <20240206104325.55456-1-pawell@cadence.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206104325.55456-1-pawell@cadence.com>

On 24-02-06 11:43:25, Pawel Laszczak wrote:
> Cadence have several controllers from 0x000403xx family but current
> driver suuport detecting only one with DID equal 0x0004034E.
> It causes that if someone use different CDNSP controller then driver

%s/use/uses

> will use incorrect version and register space.
> Patch fix this issue.
> 
> cc: <stable@vger.kernel.org>
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/core.c |  1 -
>  drivers/usb/cdns3/drd.c  | 13 +++++++++----
>  drivers/usb/cdns3/drd.h  |  6 +++++-
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 33548771a0d3..465e9267b49c 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -395,7 +395,6 @@ static int cdns_role_set(struct usb_role_switch *sw, enum usb_role role)
>  	return ret;
>  }
>  
> -
>  /**
>   * cdns_wakeup_irq - interrupt handler for wakeup events
>   * @irq: irq number for cdns3/cdnsp core device
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 04b6d12f2b9a..ee917f1b091c 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -156,7 +156,8 @@ bool cdns_is_device(struct cdns *cdns)
>   */
>  static void cdns_otg_disable_irq(struct cdns *cdns)
>  {
> -	writel(0, &cdns->otg_irq_regs->ien);
> +	if (cdns->version)
> +		writel(0, &cdns->otg_irq_regs->ien);
>  }
>  
>  /**
> @@ -422,15 +423,20 @@ int cdns_drd_init(struct cdns *cdns)
>  
>  		cdns->otg_regs = (void __iomem *)&cdns->otg_v1_regs->cmd;
>  
> -		if (readl(&cdns->otg_cdnsp_regs->did) == OTG_CDNSP_DID) {
> +		state = readl(&cdns->otg_cdnsp_regs->did);

Use a meaningful variable.

> +
> +		if (OTG_CDNSP_CHECK_DID(state)) {
>  			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
>  					      &cdns->otg_cdnsp_regs->ien;
>  			cdns->version  = CDNSP_CONTROLLER_V2;
> -		} else {
> +		} else if (OTG_CDNS3_CHECK_DID(state)) {
>  			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
>  					      &cdns->otg_v1_regs->ien;
>  			writel(1, &cdns->otg_v1_regs->simulate);
>  			cdns->version  = CDNS3_CONTROLLER_V1;
> +		} else {
> +			dev_err(cdns->dev, "not supporte DID=0x%08x\n", state);
> +			return -EINVAL;
>  		}
>  
>  		dev_dbg(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
> @@ -483,7 +489,6 @@ int cdns_drd_exit(struct cdns *cdns)
>  	return 0;
>  }
>  
> -
>  /* Indicate the cdns3 core was power lost before */
>  bool cdns_power_is_lost(struct cdns *cdns)
>  {
> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> index cbdf94f73ed9..d72370c321d3 100644
> --- a/drivers/usb/cdns3/drd.h
> +++ b/drivers/usb/cdns3/drd.h
> @@ -79,7 +79,11 @@ struct cdnsp_otg_regs {
>  	__le32 susp_timing_ctrl;
>  };
>  
> -#define OTG_CDNSP_DID	0x0004034E
> +/* CDNSP driver supports 0x000403xx Cadence USB controller family. */
> +#define OTG_CDNSP_CHECK_DID(did) (((did) & GENMASK(31, 8)) == 0x00040300)

GENMASK(19, 8)?

> +
> +/* CDNS3 driver supports 0x000402xx Cadence USB controller family. */
> +#define OTG_CDNS3_CHECK_DID(did) (((did) & GENMASK(31, 8)) == 0x00040200)
>  
>  /*
>   * Common registers interface for both CDNS3 and CDNSP version of DRD.
> -- 
> 2.37.2
> 

-- 

Thanks,
Peter Chen

