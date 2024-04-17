Return-Path: <linux-kernel+bounces-148392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 302238A81E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15E3B26553
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F013C8FE;
	Wed, 17 Apr 2024 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZoVBz0gF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892B13C68E;
	Wed, 17 Apr 2024 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352749; cv=none; b=sJmZbWRYT24KslvtJLSAYiGAI7QQSveCIWKpBn6TYdOPpQdYjclNthmJcRlRwoKlEIBhWXRI9dYs1wWapPM55bA4rjWBY8gqs+40CS1cZamloGBhA8K8+CMOerV371vju5kp/212Oxqm6NC4z2km8Idfx3mDMFLfEOJNPcWm8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352749; c=relaxed/simple;
	bh=OUmscy4N4P8Jk2gTRlKg8QoiDcFeKHpdLLSRDJuAFUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoQ0Zkvm5NXRc1pGvlh4lx+ubKLccZF5pgtJcVNtrcNWbTZBsqJ3WI1PEKHZq9IPcenLThPqkqwsXWbN4GjBm8DLt2QEGImBVQZPVwzTgNOCLtkCHQlxMoJo5NFaejlgLtWo/GEeQPa7dk0cANz4EMAQspjJosaq4RKCktjnjFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZoVBz0gF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0BBC072AA;
	Wed, 17 Apr 2024 11:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713352749;
	bh=OUmscy4N4P8Jk2gTRlKg8QoiDcFeKHpdLLSRDJuAFUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZoVBz0gFmumlP0r3VGjZnjMIWstMpSiEMcc5ylLCjx0s2EH0pz29JXox1qJPClen3
	 EeXnXZORb8fBYU7G0hcyEPRLh8TOCYW89wXPqclKJIFzZX1NacnWnWq9P6GBDteWU/
	 zlQjL0n86lGFd/vXCGv3zXIVScFoASpavFGigGX0=
Date: Wed, 17 Apr 2024 13:19:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v3 8/8] serial: exar: fix: fix crash during shutdown if
 setup fails
Message-ID: <2024041746-galvanize-satchel-09a4@gregkh>
References: <cover.1713270624.git.pnewman@connecttech.com>
 <1a21fffe403d7181e0404db1ed92140c306f97b7.1713270624.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a21fffe403d7181e0404db1ed92140c306f97b7.1713270624.git.pnewman@connecttech.com>

On Tue, Apr 16, 2024 at 08:55:35AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> If a port fails to register with serial8250_register_8250_port() the
> kernel can crash when shutting down or module removal.
> 
> This is because "priv->line[i]" will be set to a negative error code
> and in the exar_pci_remove() function serial8250_unregister_port() is
> called without checking if the "priv->line[i]" value is valid.
> 
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 501b9f3e9c89..f5a395ed69d1 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -1671,7 +1671,8 @@ static void exar_pci_remove(struct pci_dev *pcidev)
>  	unsigned int i;
> 
>  	for (i = 0; i < priv->nr; i++)
> -		serial8250_unregister_port(priv->line[i]);
> +		if (priv->line[i] >= 0)
> +			serial8250_unregister_port(priv->line[i]);

Is this a bug in the current driver?  If so, can you resend it on its
own so we can get it merged now?

thanks,

greg k-h

