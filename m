Return-Path: <linux-kernel+bounces-110062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7FB88597D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8091C2101B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3025B83CDE;
	Thu, 21 Mar 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="foPd5OhR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732679B8E;
	Thu, 21 Mar 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025983; cv=none; b=K/C3XrgajfPt8xPtFi3JXXHpkXoXrISBoSwpX3NsLYaq6cNAH5gDCItNB2CWjgCjAhN/0gXHykPXlyVmgwhDXhZEBo2eOqxh34pmwOqFQ3OzbgjjSTGVAgLfSWugIb+7Iv5chjLs428Op0t3QA16x/2TSB5Puqk3P6mcKl5LIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025983; c=relaxed/simple;
	bh=KHjmAyhrr6qV9dltsOKbiT+xGu3n4aULT3NAPZOj7xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMrSwbQXnAfyOLMCNqCZtjzMI420e0hUjo98WLFF6JwfiJk8S9IC1RPF3uSJaMb+qkcAJWImfKq+vIg2Zcr0Zl8rgpJm/qRpfKaunQ8Jfyth6jRZK1lDixGiHEZqXhRcZe4mBf/XIH9E2Kbt4rzRZHhG/87qTs3C47YPk+2CTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=foPd5OhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8490CC433F1;
	Thu, 21 Mar 2024 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711025982;
	bh=KHjmAyhrr6qV9dltsOKbiT+xGu3n4aULT3NAPZOj7xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=foPd5OhRJil3riBqj3QjGquPL3UqI2aWKCEZpF8u1hmHdbmjhTkqluXwyBUZCVj5r
	 WoHO2lLEAh/J56HKrE/jZhz4oVz3Ly3vluFyrG9Cwfu0BMxkmf9TGya7dLsss7T/vx
	 g7IUZCepnAIg4tiO78L2Y4b7wCglfq6y+eI1DxRo=
Date: Thu, 21 Mar 2024 13:59:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next] usbnet: fix cyclical race on disconnect with
 work queue
Message-ID: <2024032125-repent-wafer-51fc@gregkh>
References: <20240321124758.6302-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321124758.6302-1-oneukum@suse.com>

On Thu, Mar 21, 2024 at 01:46:41PM +0100, Oliver Neukum wrote:
> The work can submit URBs and the URBs can schedule the work.
> This cycle needs to be broken, when a device is to be stopped.
> Use a flag to do so.
> 
> Fixes: f29fc259976e9 ("[PATCH] USB: usbnet (1/9) clean up framing")
> Reported-by: syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/net/usb/usbnet.c   | 37 ++++++++++++++++++++++++++++---------
>  include/linux/usb/usbnet.h | 18 ++++++++++++++++++
>  2 files changed, 46 insertions(+), 9 deletions(-)
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

