Return-Path: <linux-kernel+bounces-150104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7C58A9A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCEF1C20D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282BB13441D;
	Thu, 18 Apr 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jkNv9W4h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3FF3BBFC;
	Thu, 18 Apr 2024 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444827; cv=none; b=ArD206o0OaW+igCNP5YR3TeHKeB1Bq99gxTeOnP23wnz3LDvPM0YvILd321NexRrG6h76y/s5JV8KNGCybq5sj9l4xUpxJ7bwksW2ODBtwdBmiRyaAte7RPhyOOwPp+g8pRmn4w9b7mUht70lj2dpLZGpUCRenUVMeIYWyUdE+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444827; c=relaxed/simple;
	bh=cd5GCDK/G48xSuAbOMhQrk8lVG2NxKLgC/xw9vUHX78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/4Upa61odFJSkZKsBWJDApgEP5/36k3+gzntI2M8kA6/5puAPBe1OgGXImngr5cDTLJu4vmU0sYNvSTDr5cE6Y5PCx+p3TPVUcf7DrpiOmg3TF8xGYqMGfhx2N2+1sGHpzhwx49AZ55XnKu3kYZmVL0eRXB2q116q5mbBMTrwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jkNv9W4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42153C113CC;
	Thu, 18 Apr 2024 12:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713444826;
	bh=cd5GCDK/G48xSuAbOMhQrk8lVG2NxKLgC/xw9vUHX78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jkNv9W4hd93ZsM8aK1xjTVEDXSCnK5OdQBXJBdBgO2POJlbr0QLs58HYwmGlnl7q3
	 rP/f+eQ/m5W5a2CmSuCgAJ8VyHx7YaXva9PR5s83KlFc7oMtJo2IcBmJY5wQg1giBc
	 3of8JUMIt4GCllbMU5olLOo5Uq78MspqjZm9Zkzs=
Date: Thu, 18 Apr 2024 14:53:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Esa Laakso <fidelix.laakso@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	kari.argillander@gmail.com, linux-kernel@vger.kernel.org,
	Esa Laakso <esa.laakso@fidelix.com>
Subject: Re: [PATCH RFC] pty: Add parity enabling routine
Message-ID: <2024041840-roundworm-sedate-9167@gregkh>
References: <20240418124349.26289-1-esa.laakso@fidelix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418124349.26289-1-esa.laakso@fidelix.com>

On Thu, Apr 18, 2024 at 03:43:49PM +0300, Esa Laakso wrote:
> There are some cases where parity selection is required for passing
> it forward to a virtualized terminal. In this sepcific use-case, we
> want to use pty to send and receive serial data to a serial
> multiplexer. By using a pty, we avoid writing a custom tty driver.
> 
> There is very little evidence on the reasoning on why this option is
> hard-coded to be disabled. AFAIK it has been as such since 1996. With
> the lack of information about why this is, and based on the fact there
> are other similar fields that are not hard-coded, it is considered safe
> to enable this option.
> 
> Still, in order not to be too intrusive about the change, add it only on
> the condition that the termios flag `EXTPROC` is turned on. This way
> there is very little chance it will cause any unintended problems in any
> other implementation.

You need to document that EXTPROC thing somewhere, otherwise someone is
going to ask about this in 20 years and be confused :)

> Signed-off-by: Esa Laakso <esa.laakso@fidelix.com>
> Signed-off-by: Esa Laakso <fidelix.laakso@gmail.com>

Do not sign off on something twice, use your real email address only
once, that's all that is needed.

> ---
> 
> We are looking for some assistance on this patch, or just a green light
> to submit it, if it is good to go.
> 
> We would need to know if the change is valid in context of pty, as
> there seems to be fairly little information about the reasoning behind
> the hard-coded values.
> 
> Our guess is that they have been as such forever and nobody has had a
> reason to change them. We have a reason to change them, and we would
> like to know if it is safe to do so and possibly contribute in the
> process. Either by just using the patch for ourselves or submitting
> it here.
> 
> For the record, this is my first patch submitted upstream. Please let
> me know if something is incorrect or missing.
> ---
> 
>  drivers/tty/pty.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index 07394fdaf522..e2d9718dcea0 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -267,7 +267,9 @@ static void pty_set_termios(struct tty_struct *tty,
>  		}
>  	}
>  
> -	tty->termios.c_cflag &= ~(CSIZE | PARENB);
> +	tty->termios.c_cflag &= ~(CSIZE);
> +	if (!L_EXTPROC(tty))
> +		tty->termios.c_cflag &= ~(PARENB);

Some description of how you tested this in the changelog would also be
good, and a comment here too as to what you are doing.

thanks,

greg k-h

