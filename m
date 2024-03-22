Return-Path: <linux-kernel+bounces-111247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D61298869A7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B25E284978
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E322230C;
	Fri, 22 Mar 2024 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VJpnvdDE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6618EC3;
	Fri, 22 Mar 2024 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100950; cv=none; b=TjhHIjzopgKjqOE+4QjsbPLrbhrz00T4HQ8SWRO2IJ2x94LWptaYfahf0+wdC4dxOmNHV71HuRQbcucPpoFpFcnsrtPio22qxaAFPahmwgwA6yYHAG2ZXjV/TQRQhRCSJyXnSeDcKKTcpw9VWb5NDNR76uatBkeZw802m7h98K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100950; c=relaxed/simple;
	bh=9fLC0UbZdJ7+5nONUsPmxWgSbpgOb5S6dM9hszw1wxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhhMboSDSvh/v1mROecnrnHOyZp9Y+RGKdn2g8kafkIJrycx7fxQc6oSg+Cj7r3NlnMKKu/Ocj2+HehCtH6PJmVl7GzQxH9vYdCosyhglfhoGMsPNTFNDsxSoWuDGnetGAM4vSRfZzr1IaX7ykbDIW/QpqE0GFteIhEpxa8jbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VJpnvdDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BBEC433C7;
	Fri, 22 Mar 2024 09:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711100949;
	bh=9fLC0UbZdJ7+5nONUsPmxWgSbpgOb5S6dM9hszw1wxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJpnvdDEgtMMh0T6kGcfh3PvHzDakRg2TCrWiiPp5XLkYWDDFauCeS1TPlDWAE5ps
	 2pv0bd7pgEopMAhK/RpzMjASXTcdkefQu1wSuFdtngGkTHjF+DR5gWeiz1R0IMA16f
	 9FOja5Egz+5SiqvP+nAnjuKaUIaXfs0x3WaG4coQ=
Date: Fri, 22 Mar 2024 10:49:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: sm750fb: Replace comparisons with NULL and 0
Message-ID: <2024032208-blunt-ferocity-22f4@gregkh>
References: <c4a5e9e8-214a-4ac0-b8ee-01a9e7a1e5f9@moroto.mountain>
 <20240320180943.3683-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320180943.3683-1-chandrapratap3519@gmail.com>

On Wed, Mar 20, 2024 at 11:39:43PM +0530, Chandra Pratap wrote:
> Replace '(opt != NULL)' with '(opt)' and '(*opt != 0)'
> with '(*opt != '\0')' to adhere to the coding standards.
> 
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
> Changes in v2:
>   - Update the commit message to reflect the changes better
>   - replace (*opt) with (*opt != '\0')
> 
>  drivers/staging/sm750fb/sm750.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
> index 04c1b32a22c5..0391235c5666 100644
> --- a/drivers/staging/sm750fb/sm750.c
> +++ b/drivers/staging/sm750fb/sm750.c
> @@ -926,7 +926,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
>  		goto NO_PARAM;
>  	}
>  
> -	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
> +	while ((opt = strsep(&src, ":"))  && *opt != '\0') {

Why 2 spaces?  Please fix in a new version.

thanks,

greg k-h

