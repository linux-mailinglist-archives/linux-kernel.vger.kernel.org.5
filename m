Return-Path: <linux-kernel+bounces-118377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7759588B9DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F017BB2358F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7735712AACE;
	Tue, 26 Mar 2024 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tc3m4wmD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD58E129A7A;
	Tue, 26 Mar 2024 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711431715; cv=none; b=qkKTtYsqbOS44UtOrUpLv/Mez0jV9AXJUzhsvbBPPcoJ/HznWUJw7sbkAZl7t8MUVSRAGscH3p+bgEzLdfJjobq1hozPVgwso7g5nJAVe32p+vr/D007iFC/pmpKVv7d5CNcG1VIU62x0N07ckY4CCxd9T6BsgLZJPcY2qDUI6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711431715; c=relaxed/simple;
	bh=iiMo2n+uaaAGl5wm2iwHCxN6PJ6Jdv4z76DpPeNrixk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7lV+B+iMaQbwogcCxKrbvtbZGOsEcRLxUXM/MBnrdGic1IC1sf3GgCmG1YqE3hDZ02K8dlhkaliUnB1hasv9KeulIMepf4X/04TcyBpemTpGRwgDsRsrSZd5gP1jPPCaTforpJAAmcnmF8iSIKYoV3FMElkeCHYDPURpmpaLAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tc3m4wmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A2DC433C7;
	Tue, 26 Mar 2024 05:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711431715;
	bh=iiMo2n+uaaAGl5wm2iwHCxN6PJ6Jdv4z76DpPeNrixk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tc3m4wmDGc8hc/rm2flEsw7sCWhhHCOEvgfOr5Mz2mDL3J7GRihVukiza3b5oj7ek
	 +joGSipLS/W4Ym7okQzThkvDnoV06HNNNUzpGwaftpBLZjY4ydz+aTk4fSwOfBl0Ci
	 w03QBZWawFtbC47sQqFD+dUG+UAtnEUnJ0Tf/EOA=
Date: Tue, 26 Mar 2024 06:41:51 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrew Davis <afd@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: pruss: Deprecate use of this driver
Message-ID: <2024032631-excursion-opposing-be36@gregkh>
References: <20240325210045.153827-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325210045.153827-1-afd@ti.com>

On Mon, Mar 25, 2024 at 04:00:45PM -0500, Andrew Davis wrote:
> This UIO driver was used to control the PRU processors found on various
> TI SoCs. It was created before the Remoteproc framework, but now with
> that we have a standard way to program and manage the PRU processors.
> The proper PRU Remoteproc driver should be used instead of this driver.
> Mark this driver deprecated.
> 
> The userspace tools to use this are no longer available, so also remove
> those dead links from the Kconfig description.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/uio/Kconfig | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index 2e16c5338e5b1..358dc2d19b885 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -126,19 +126,13 @@ config UIO_FSL_ELBC_GPCM_NETX5152
>  	  http://www.hilscher.com/netx
>  
>  config UIO_PRUSS
> -	tristate "Texas Instruments PRUSS driver"
> +	tristate "Texas Instruments PRUSS driver (DEPRECATED)"

This isn't going to do much, why not just delete the driver entirely if
no one uses it?

thanks,

greg k-h

