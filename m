Return-Path: <linux-kernel+bounces-30893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D23C8325A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA4A1C21017
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C83D1F5E6;
	Fri, 19 Jan 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kYTYHsAM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E96AA0;
	Fri, 19 Jan 2024 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652463; cv=none; b=giYBxXH3/YzJwozds+gUnf+h4uqnSIRVHrG7jKcfv6mBulUGGawN1oTRRQuko5Aext3DuJt5bF4pGYItr6n5sHjAopJc7L0Vz0IBLgkF2RqZNBX1PL1Mb9o2m4dAz0f3YBvQnQ/IFFXUSKsMf39Qm5rIYniTQu80bgyFGdJIqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652463; c=relaxed/simple;
	bh=VN3W5znShoWe5oBeYGybruQe/c44tyaC01yxzyq2waw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8pAh0BzdD/3dmpa/3sLbS3LcLMTK6cUmuxW6sQCsn5eWKxJ8vsXuPHMi5KGIpesv7a58VxwQkhfVa/JcwXPY7hleueAImvTNnZnWU59vI8iawE9ObtS5aBMZv/t2hF4EIihK1tRvsO7kIdpVsc1uZGNSD3TNm8Ab+/q+oyB5gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kYTYHsAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44155C433F1;
	Fri, 19 Jan 2024 08:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705652461;
	bh=VN3W5znShoWe5oBeYGybruQe/c44tyaC01yxzyq2waw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kYTYHsAM1iECuefu1ZuF4y+7PSu+rg4407HYxsFREPBuJgLsOIVBqZgKiaaLvq0lv
	 1DA2e5q7gPsLyPQSmRp9SPd7GU3/3Psu1lwg2hgj81skjrygs85zXirppBHv2XuZJt
	 1s9qmfC8iUOyJheshudhWTm6E9t6uX8xPeDS1NRw=
Date: Fri, 19 Jan 2024 09:20:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Seunghui Lee <sh043.lee@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, avri.altman@wdc.com, grant.jung@samsung.com,
	jt77.jang@samsung.com, dh0421.hwang@samsung.com,
	junwoo80.lee@samsung.com, jangsub.yi@samsung.com,
	cw9316.lee@samsung.com, sh8267.baek@samsung.com,
	wkon.kim@samsung.com
Subject: Re: [PATCH] mmc: core: Fix null pointer dereference in bus_shutdown
Message-ID: <2024011945-studio-smitten-300e@gregkh>
References: <CGME20240119073011epcas1p1841e79c8f673c3c69ef696edc9eb47b0@epcas1p1.samsung.com>
 <20240119073247.7441-1-sh043.lee@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119073247.7441-1-sh043.lee@samsung.com>

On Fri, Jan 19, 2024 at 04:32:47PM +0900, Seunghui Lee wrote:
> When shutting down removable device,
> it can be occurred null pointer dereference.

How?

And please wrap your lines properly.

> To prevent null pointer dereference,
> At first, check null pointer.
> Next, block rescan worker to scan removable device during shutdown.

Why do two things?

> 
> Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
> ---
>  drivers/mmc/core/bus.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 0af96548e7da..4f370a6577aa 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -143,9 +143,17 @@ static void mmc_bus_shutdown(struct device *dev)
>  {
>  	struct mmc_driver *drv = to_mmc_driver(dev->driver);
>  	struct mmc_card *card = mmc_dev_to_card(dev);
> -	struct mmc_host *host = card->host;
> +	struct mmc_host *host;
>  	int ret;
>  
> +	if (!drv || !card) {
> +		pr_debug("%s: drv or card is NULL.\n", dev_name(dev));

What is this going to help with?  And why not use dev_dbg()?

How can drv ever be NULL?  That looks impossible to me based on just the
code shown here.

> +		return;
> +	}
> +
> +	host = card->host;

Why is this change needed?  This line can go back to the top just fine,
right?

> +	host->rescan_disable = 1;

Shouldn't this be a separate change?  And what happens if the check for
this is right before you set it?  Where is the locking to prevent the
issue you are attempting to solve?

thanks,

greg k-h

