Return-Path: <linux-kernel+bounces-126491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0A0893898
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EB9DB20DA0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4953B66C;
	Mon,  1 Apr 2024 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDTOR+H1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5CF8F6E;
	Mon,  1 Apr 2024 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711955444; cv=none; b=aBGCozxoQO1YpBhV9lImyU2YV4vo3pHLGAZnGZLMIwOm6Pf/3O7kJEto+oULGtSJG+8zhJi0UvOx/KKKshbAu2KtrBqSC9EfOxMyhobdCXlieplTELoanndNXi1bMFxEPO64b3zlAFPjjC/ZWUrjqOpM6J2wO1HvXkCOycLkt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711955444; c=relaxed/simple;
	bh=+A1rPpI0d7vMik1H+QiVUQjCpbJ9cTWrwNyONGXtCPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTSH/Vz8WsKLLOknn+e+u+Pi9djKZdeoOMWPJxlQQzdQ/y2fn21od6s80GUmsa7H6CH58MGhYR2yR8Gt07HHa/u9D68sCb/FGNfyvegyywUNRecZHmNpo65Vp67sx1ob8mvxiMnZfbd70Sv6NpiCEq3XlwgQ8+ukDx7Z5cocjHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDTOR+H1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C0AFC433C7;
	Mon,  1 Apr 2024 07:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711955443;
	bh=+A1rPpI0d7vMik1H+QiVUQjCpbJ9cTWrwNyONGXtCPg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lDTOR+H1yS/BG7Vztln4l/c526aQwgZxmigxH1YEntEe+SqRt4rgqU4hftYRkvVt6
	 DQq+qCE/NxAqLWe698XqIboNthy3Wf0FeteL2KMN5AgY7n119vmfjuAVuWJYi60jQy
	 V2BWJrgL95BLBVCevfDx4MWI0FMR8ZR3fZrT7M7tnuLHwj3ZMG4rzkDWDy7rXWlhau
	 h5rFkZry/NX1+W/RK1CNW55G2XgUxUlkJvbZYWfZZ1Lk2ppWAB/jTmFFmGyevRC/wv
	 FwhC1aXLvvM/Q4u78De5sEWLAJvvqQUPXZvNyGhrRPT7372nY15MteuU5kzbtbY9V2
	 JQPQHtiAz8Byg==
Message-ID: <22ccaa0a-96d4-42f2-b7e2-8b4113cacb58@kernel.org>
Date: Mon, 1 Apr 2024 16:10:41 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: aic79xx: add scb NULL check in
 ahd_handle_msg_reject()
To: Aleksandr Aprelkov <aaprelkov@usergate.com>,
 Hannes Reinecke <hare@suse.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240401061010.589751-1-aaprelkov@usergate.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240401061010.589751-1-aaprelkov@usergate.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/24 15:10, Aleksandr Aprelkov wrote:
> If ahd_lookup_scb() returns NULL and ahd_sent_msg() checks are false,
> then NULL pointer dereference happens
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
> ---
>  drivers/scsi/aic7xxx/aic79xx_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
> index 3e3100dbfda3..9e0fafa12e87 100644
> --- a/drivers/scsi/aic7xxx/aic79xx_core.c
> +++ b/drivers/scsi/aic7xxx/aic79xx_core.c
> @@ -5577,7 +5577,7 @@ ahd_handle_msg_reject(struct ahd_softc *ahd, struct ahd_devinfo *devinfo)
>  		       "Using asynchronous transfers\n",
>  		       ahd_name(ahd), devinfo->channel,
>  		       devinfo->target, devinfo->lun);
> -	} else if ((scb->hscb->control & SIMPLE_QUEUE_TAG) != 0) {
> +	} else if (scb && (scb->hscb->control & SIMPLE_QUEUE_TAG) != 0) {

"!= 0" is not needed.

>  		int tag_type;
>  		int mask;
>  

-- 
Damien Le Moal
Western Digital Research


