Return-Path: <linux-kernel+bounces-29963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86168315DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55265B22995
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3062033B;
	Thu, 18 Jan 2024 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wVwiu7pR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC220305
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570323; cv=none; b=i9uYEfuzA0KCNgRZ2p6CYBPcpL8tjCc/DdJieiF7xL339eE4kFZ6kcXqljoMFy/g9ZB+83mBbgv6f+anjnjOrDtPC0tZ5Eh0Rzd9DDRc+DP36qaCk8aEhr7TLzllQQcob0zzrU/MeceYqKtQQHx9kZOaQwO5Xh0PAE99795cjAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570323; c=relaxed/simple;
	bh=Psy8zhcBGukXqyiejaoR2aS7c8Y5ZLj0cXsrrhHctas=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=EyIykxUlGSM1/C9bfdJ9z6Pv3lFvBq0+bKhOdzQc5MXf4QBoU6YxnUkVTi7+BTcROmDdMEMqRYEG1tnZnYzLWHJOyN3VBc1ZeEnMugsDaVZ1sQGW+5XHbz4NBtYcsA4+TbkN3AEpb4BXnfpUBHz2zDshBOSnqOH2bxipOuIVLcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wVwiu7pR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866E9C433F1;
	Thu, 18 Jan 2024 09:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705570322;
	bh=Psy8zhcBGukXqyiejaoR2aS7c8Y5ZLj0cXsrrhHctas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wVwiu7pROmUej7Z0ZKvzM1VkfNLwrpKVqrxVuBw8BKCde59N2piYQlJG0wu2D1rJ/
	 y5kW4NOXyh0veB6GTq+umOAm816L3keelyRtDIoQLDGvhi+Y3tOMbjvl1MDulXWPlD
	 ALgAig/WJH7VLR52ERnpGQTAi66Ol6jLLu+pIQWI=
Date: Thu, 18 Jan 2024 10:32:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Denis Arefev <arefev@swemel.ru>
Cc: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	open list <linux-kernel@vger.kernel.org>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] comedi: drivers: ni_tio: Fix arithmetic expression
 overflow
Message-ID: <2024011831-morphine-showroom-bc8f@gregkh>
References: <20240118073619.40538-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118073619.40538-1-arefev@swemel.ru>

On Thu, Jan 18, 2024 at 10:36:19AM +0300, Denis Arefev wrote:
> The value of an arithmetic expression period_ns * 1000 is subject
> to overflow due to a failure to cast operands to a larger data
> type before performing arithmetic
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  drivers/comedi/drivers/ni_tio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/drivers/ni_tio.c b/drivers/comedi/drivers/ni_tio.c
> index da6826d77e60..acc914903c70 100644
> --- a/drivers/comedi/drivers/ni_tio.c
> +++ b/drivers/comedi/drivers/ni_tio.c
> @@ -800,7 +800,7 @@ static int ni_tio_set_clock_src(struct ni_gpct *counter,
>  				GI_PRESCALE_X2(counter_dev->variant) |
>  				GI_PRESCALE_X8(counter_dev->variant), bits);
>  	}
> -	counter->clock_period_ps = period_ns * 1000;
> +	counter->clock_period_ps = period_ns * 1000UL;

Can period_ns ever be "too big" to cause such an overflow?

And what commit id does this fix?

thanks,

greg k-h

