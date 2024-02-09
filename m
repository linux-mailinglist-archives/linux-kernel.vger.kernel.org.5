Return-Path: <linux-kernel+bounces-59242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C66D84F3B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1BA28218A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44958208AB;
	Fri,  9 Feb 2024 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sVyHqT+R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD6D200AA;
	Fri,  9 Feb 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475624; cv=none; b=HkW7uq52qs1zzIMppF26p95a5F55hFd7GK1VFR0MbmN8zHnsmv+OK/NmrFjTzXD37i9N20oBRQFqPno7SsuUMt2QTXT3uCjjHyNk6k0mFpLcv18TlDHOjTiuSBgOsMeIkBN8k+LdWJJBo705XpdsWm5TpEre0fBX+Y1Up4M0Ytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475624; c=relaxed/simple;
	bh=M1KN1O2OGToULrH7zWVaasDYrdX92EAFF1UjLzL47UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajPy2JqpUFj782uKSn6/0ZgqqR+PjQYigjMqd692sLmCSom0Z8VTaRC33LK29B2g6uIRX/f2DolCP0dsMeeghPZmc7ezT2ZlONDUDm4cT4/qEiKLRA3amqy4rA0Ag4mMb9wEfVJ3+PAAwcl/DiorTG02Wn0BvARdljpNXHjYhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sVyHqT+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA95C433F1;
	Fri,  9 Feb 2024 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707475624;
	bh=M1KN1O2OGToULrH7zWVaasDYrdX92EAFF1UjLzL47UM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVyHqT+R6Ay7Sq7VzQbPGyVge/WP49CYIyE44vYGhqGFTqF+XyXVBlEvYh6itQgr0
	 jsUI7K8VipuZr03sdJp8G2mV7AcIEwPNeiCyzXp3aVOJrHPp0QRuYwwpKb/Q9wTgz3
	 LLie7AsXTRKI4zFYMD6v5UJgIqAJKLl8s0/32K+w=
Date: Fri, 9 Feb 2024 10:47:01 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: niko.mauno@vaisala.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	vesa.jaaskelainen@vaisala.com, geert@linux-m68k.org
Subject: Re: [PATCH v3 1/2] usb: core: Amend initial authorized_default value
Message-ID: <2024020944-clarinet-nuclear-fe0e@gregkh>
References: <20240209094651.5379-1-niko.mauno@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209094651.5379-1-niko.mauno@vaisala.com>

On Fri, Feb 09, 2024 at 11:46:50AM +0200, niko.mauno@vaisala.com wrote:
> From: Niko Mauno <niko.mauno@vaisala.com>
> 
> Since the wireless USB implementation has been removed and since the
> behavior with authorized_default values -1 and 1 is now effectively
> same, change the initial value to latter in order to stop using the
> leftover value. The former value can still be passed as a module
> parameter to retain backwards compatibility.
> 
> Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
> ---
>  drivers/usb/core/hcd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

