Return-Path: <linux-kernel+bounces-124389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E201A8916D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD601C2381F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E2654662;
	Fri, 29 Mar 2024 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gEtLObBZ"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7914B53E01;
	Fri, 29 Mar 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708132; cv=none; b=N0Ugqg88vnr+yFO2Fmt+U4vnZA4Av7xTT6zNWTvAdxual5VD5Sl2Uk0MAme+ZqzItuuz6RtBb0Y+7ijWKCV+dX7050ujF4Idc922+6LhL2urKaWm6ERzMxa1QQ11rLsln5B5qOl8wuUCB72UJzI+I+4Uc/GlDdOluk5Lugr3ugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708132; c=relaxed/simple;
	bh=INoHp/pa5mQKkPJSEnhdMRcocNB4PmSJWa7zs42M1lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YN3pIqu23tvGzPfaiGQtr4V+Gea8dJJKXfhVulyClkxLPy+R1i4SOJYwDnp2881HiKrrIWtZ+asCkyYQzfaAjBXi6X1EsPbWsOQ0wt4KioADXSxXp04ehZpJNDqJ4EMZj/IMn51H9E7b95cH2zGyPuGHlxf6OuvNIuu7fjP+C7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gEtLObBZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7FFDCC0008;
	Fri, 29 Mar 2024 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711708127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jLCIWTLVye4PXFQW3QnPZ9wsvlBJeU7UwVpsnvSw6w=;
	b=gEtLObBZI40GFMjxYbApcxXhhVxY5fE+ZOFuVqKBUMGvGuOlEp31hsm7VbS68RsPeNtB8j
	aILG2nfC/+K9O5qN2cie/1aci9+MURBK5ocDj2a5KwX3Xv9qKYFl5ZaoEBo6MUIMBBkvkP
	dccQ8+5O0qOns3cGRL9f2vOnfTCPJYjvZZ61f/Y4hhmlhcA5O6jV2GIem6eFgW3Eu01+sI
	+l3+TDAiExWUoG0ckblTrfpl9e8L1RLbk1Cw9rdqn3pSgyjIBGfGrOkijADVHSvSaS1fPb
	a6bcl82HPQIEBHn/LQcHiTgIl6238ZbumelOOSZTtm/g0qNWfimrr5b3IL2OdQ==
Date: Fri, 29 Mar 2024 11:28:47 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	parthiban@linumiz.com, saravanan@linumiz.com
Subject: Re: [PATCH] drivers: rtc: rv3028: check and update PORF flag during
 probe
Message-ID: <20240329102847fcdca1cf@mail.local>
References: <20240329101940.1424643-1-karthikeyan@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329101940.1424643-1-karthikeyan@linumiz.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 29/03/2024 15:49:40+0530, Karthikeyan Krishnasamy wrote:
> PORF flag is set during power reset and voltage drop below Vpor
> data in rtc device is no longer valid if PORF flag is set
> and software must reset to 0, in order to perform sanity
> check on rtc data
> 
> Signed-off-by: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
> ---
>  drivers/rtc/rtc-rv3028.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
> index 2f001c59c61d..e9699ff0c4e8 100644
> --- a/drivers/rtc/rtc-rv3028.c
> +++ b/drivers/rtc/rtc-rv3028.c
> @@ -951,6 +951,13 @@ static int rv3028_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (status & RV3028_STATUS_PORF) {
> +		ret = regmap_update_bits(rv3028->regmap, RV3028_STATUS,
> +					 RV3028_STATUS_PORF, 0);
> +		if (ret < 0)
> +			return ret;
> +	}
> +

This breaks the workflow, you must set the time to reset PORF.

>  	if (status & RV3028_STATUS_AF)
>  		dev_warn(&client->dev, "An alarm may have been missed.\n");
>  
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

