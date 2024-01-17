Return-Path: <linux-kernel+bounces-29208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A9830AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1553B26D18
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBE322329;
	Wed, 17 Jan 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="AKAmZKN2"
Received: from smtp68.iad3b.emailsrvr.com (smtp68.iad3b.emailsrvr.com [146.20.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064414273
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508542; cv=none; b=j6PnWgXNcGDIwntpKlNnqUJioL2PMKZc0ZlNkJzvxvIqAwtldOpMAkMJqR4gGGzdput00YqgVJyhnWTrLYm+xtnsfZ7JvCTfg/lxgVqEhnYjqI4SumazEcsa5ogbh7r8lEhe1e4oQrzOnEn0bPuLPcPpWz6X50mVAPHvTZ407Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508542; c=relaxed/simple;
	bh=bnZ+5AE1obElm/T5IRAf2b28NzvSXqLt1dw/hEtldGM=;
	h=DKIM-Signature:X-Auth-ID:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Classification-ID; b=rFlDKN/ol6ZqPuuzys6x9fRxz+rIgPOdfMQBIuK6NNui5bkuy2ptuT66YDi/tF51EZYYV+DX43WXMvLad+k36SSOgy0/m2LsdAetajdxcJqoOR1WyQIeFOZgiURd3ziNIgUit3K+SgYwGAi1kCbpJIdk5smElKZbUs+oKtJ5/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=AKAmZKN2; arc=none smtp.client-ip=146.20.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1705499554;
	bh=bnZ+5AE1obElm/T5IRAf2b28NzvSXqLt1dw/hEtldGM=;
	h=Date:Subject:To:From:From;
	b=AKAmZKN230qTVMSLPOgahnLAuNg2vrXwP/93fXmTm8YbXaSxkBJ74ISby+OGwfuR+
	 JwBsca+r2iUaF0ZJoMf+EZdkwuSVgiOBQlozYLqC7D9A4NJUGeIlXaC0cwdKMCl7wv
	 nYGhWXu+nFPVTTjwBH5Zi1upOpq9X+DAXp2uhS8A=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp1.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id DF6EE60097;
	Wed, 17 Jan 2024 08:52:33 -0500 (EST)
Message-ID: <d4779143-bb91-4d8e-a336-eeefc3131c05@mev.co.uk>
Date: Wed, 17 Jan 2024 13:52:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: drivers: ni_tio: Fix arithmetic expression
 overflow
To: Denis Arefev <arefev@swemel.ru>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>,
 open list <linux-kernel@vger.kernel.org>, lvc-project@linuxtesting.org
References: <20240117124229.37455-1-arefev@swemel.ru>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20240117124229.37455-1-arefev@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 504b7891-3038-4700-bb61-960c5ba746dc-1-1

On 17/01/2024 12:42, Denis Arefev wrote:
> The value of an arithmetic expression period_ns * 1000 is subject
> to overflow due to a failure to cast operands to a larger data
> type before performing arithmetic
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>   drivers/comedi/drivers/ni_tio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/drivers/ni_tio.c b/drivers/comedi/drivers/ni_tio.c
> index da6826d77e60..acc914903c70 100644
> --- a/drivers/comedi/drivers/ni_tio.c
> +++ b/drivers/comedi/drivers/ni_tio.c
> @@ -800,7 +800,7 @@ static int ni_tio_set_clock_src(struct ni_gpct *counter,
>   				GI_PRESCALE_X2(counter_dev->variant) |
>   				GI_PRESCALE_X8(counter_dev->variant), bits);
>   	}
> -	counter->clock_period_ps = period_ns * 1000;
> +	counter->clock_period_ps = period_ns * 1000UL;
>   	ni_tio_set_sync_mode(counter);
>   	return 0;
>   }

Looks good, thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

Could you resend it and Cc Greg Kroah-Hartman 
<gregkh@linuxfoundation.org> ?  It's more likely to get applied that way 
because I don't maintain my own kernel tree for comedi.  Feel free to 
add my Reviewed-by line.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-


