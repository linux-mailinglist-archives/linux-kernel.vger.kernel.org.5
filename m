Return-Path: <linux-kernel+bounces-165978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03F98B942B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C326283CC6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1964D208A9;
	Thu,  2 May 2024 05:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n/Ltc0lD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388E51CD2D;
	Thu,  2 May 2024 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714627002; cv=none; b=edb/Cv1wXeNNTZ5bC060iIywMgVkZ7JzoRNaPOqG1WOCqYVCgLfKUJu2JTL7JuNgjmSD/uN71i7jPoS0St6TRKpjP6rgT5LvggI6Lm0+uMCiuhg8CGS5ktBswy8hEeEXVL6MzR4T0ChHsrQtSkjiojI0eEwVePUjKzqJ9eJtpr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714627002; c=relaxed/simple;
	bh=GNnjqZhf/EV01EZnYcWASg64MdiAwmf42mW2YxPHaxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJULcu1GPv2e1JBoddK7ypsOtl4ROr4Utgwme/I1sz6QMOtTSGL+gShFOjHGD0gqy9+lMWU7rKOkyQcB+1Va5xxRChjpH650qmzS19XmIXMEwM/HWA0pUPXkConh8iH1XihGb8AYQAsfsLwgpHb5My+s/S+Xr6oH3rQI7dmI3Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n/Ltc0lD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E0AC116B1;
	Thu,  2 May 2024 05:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714627001;
	bh=GNnjqZhf/EV01EZnYcWASg64MdiAwmf42mW2YxPHaxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/Ltc0lD8MMsd8O5/eh5TXW5PZfHqV9KLBuGZjvo6R33tnWxmR+z/9MP9vxHhVA8g
	 I0Wa4wzsBa1ovQutKDic9hDFfKsLPZSJsDrckBwC3qf6PTKLtPZpAqGya4gSrdJjID
	 nbnaK7T9VUNHG5/UR2ke8Z67NS06BZpI+25yQt8Y=
Date: Thu, 2 May 2024 07:16:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rengarajan S <rengarajan.s@microchip.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] lan78xx: Fix crash with multiple device attach
Message-ID: <2024050224-robust-ramble-7a56@gregkh>
References: <20240502045748.37627-1-rengarajan.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502045748.37627-1-rengarajan.s@microchip.com>

On Thu, May 02, 2024 at 10:27:48AM +0530, Rengarajan S wrote:
> After the first device(MAC + PHY) is attached, the corresponding
> fixup gets registered and before it is unregistered next device
> is attached causing the dev pointer of second device to be NULL.
> Fixed the issue with multiple PHY attach by unregistering PHY
> at the end of probe. Removed the unregistration during phy_init
> since the handling has been taken care in probe.
> 
> Fixes: 89b36fb5e532 ("lan78xx: Lan7801 Support for Fixed PHY")
> Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
> ---
> 
>  drivers/net/usb/lan78xx.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 

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

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

