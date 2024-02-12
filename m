Return-Path: <linux-kernel+bounces-61342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D812385114B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174F71C22318
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606942BAF0;
	Mon, 12 Feb 2024 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uTT7Bizo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484C2555B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734660; cv=none; b=UxUkGYRyxdVYClRD+g79hSI1mm/L/VyaT0gQ+CjCAbihfyzw7n5AJOjJNWnBecUfoayEExAkIvguQdO32Z4H9sbigHftEkC9gIDb6j/udQzB0ah8rchbTbvdkrg17Jry4Kinr6FHTrisV+lh5gcilmG5uJJluvaDqieEzFovWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734660; c=relaxed/simple;
	bh=vNzkjdn0gSBwAlVWWR/zTEpCS7Bsjr2/ZcZyQ7gmWmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=groAQmoknAwazcQO8CTgKyOcsE+HqVGgx3IMphRjAhzv/c3jVzd/JmEBoUkX92jxV2dKiheXen/L1Io6h6mZLFAErr5ekuHdoCDkrtl7yHW6iFheRCMA1+6jwCZ0i/3EobNqmWf+9Z2D6n5hKUXZnCCRg29gZxcg1rFUJEZCKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uTT7Bizo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D75EC43390;
	Mon, 12 Feb 2024 10:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707734660;
	bh=vNzkjdn0gSBwAlVWWR/zTEpCS7Bsjr2/ZcZyQ7gmWmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uTT7Bizo1IVswwVdUAgDWtuso5a5RKUVEe82fo7N9uwSqB5B0t7AIC0m1l22rsRn1
	 rAhlKSndlqjS4H8+we9U7Qcoi03fObS+2eUQilBMRFr68qIXejve0TVvp48LpCCAOf
	 OYrqaHbBcx6I3ElR8x/Y5FhSHoY6R52S3JuQ/npQ=
Date: Mon, 12 Feb 2024 11:44:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dio: make dio_bus_type const
Message-ID: <2024021249-attentive-entity-70d1@gregkh>
References: <20240211-bus_cleanup-dio-v1-1-02140fbc5289@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211-bus_cleanup-dio-v1-1-02140fbc5289@marliere.net>

On Sun, Feb 11, 2024 at 12:40:16PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the dio_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/dio/dio-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dio/dio-driver.c b/drivers/dio/dio-driver.c
> index 69c46935ffc7..2d9fa6011945 100644
> --- a/drivers/dio/dio-driver.c
> +++ b/drivers/dio/dio-driver.c
> @@ -123,7 +123,7 @@ static int dio_bus_match(struct device *dev, struct device_driver *drv)
>  }
>  
>  
> -struct bus_type dio_bus_type = {
> +const struct bus_type dio_bus_type = {
>  	.name	= "dio",
>  	.match	= dio_bus_match,
>  	.probe	= dio_device_probe,
> 

Don't you also have to change this in include/linux/dio.h?

thanks,

greg k-h

