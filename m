Return-Path: <linux-kernel+bounces-144677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37128A4915
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35471C20F39
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C76624B2A;
	Mon, 15 Apr 2024 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K46aGOps"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5E23763
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166384; cv=none; b=qa2/+mynElCm6NmTYDk+fBBdXHwDU0MJPIW5hL1lf8pfn1I3fsTaiYCytvwfnA7Qge4UZz0YX3MuE20yPQ0aMSxcuoBq9C89UGyaptLrloDQyUPk18RpEZPEhaTydHM0Uw9F3FPB/acgtxmSXVIgB6MW1W/jXjgB4Vum2ft6H44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166384; c=relaxed/simple;
	bh=HulXt605iuUDWNZIZsCC+JKKUiQZcW1J0o0UnNGNdvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hL4apzN6O+MJhlvcCH+Qnl13GBvh8m7MkArAxVv8jRODLFmXtJ0FiiyADqw7Xmns1/bDTNNxyyTrZ3DbNdn7Ai6DwAAdIKDrrEtu/JBhFSH6V0tegNZBetfqdiLpt8MVzaL+h6A6rDGfxnAIfiyyBRz+oBg54vJfaFZ2Yy73mKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K46aGOps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CB6C113CC;
	Mon, 15 Apr 2024 07:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713166383;
	bh=HulXt605iuUDWNZIZsCC+JKKUiQZcW1J0o0UnNGNdvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K46aGOpsj6wmLaobqllJwK4TnGyGVXDuTVnR8nBLVeWjxALN0+QdN+IFw1JCVWPnJ
	 GeeNTiCUxWcnXevgo/1tti3AkCZUYM5qP4d4RwEArlbOz4UOFYhxQ7Q6JELQsZt58B
	 tnU/8GTYNH/CZ+NXJbTo83skk62F3bGhkieDydVY=
Date: Mon, 15 Apr 2024 09:33:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: li.hao40@zte.com.cn
Cc: jirislaby@kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: hvc: wakeup hvc console immediately when needed
Message-ID: <2024041531-caliber-overreach-2d4e@gregkh>
References: <20240415152617552rmRLJBUV8aJ4lLJILh6-Z@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415152617552rmRLJBUV8aJ4lLJILh6-Z@zte.com.cn>

On Mon, Apr 15, 2024 at 03:26:17PM +0800, li.hao40@zte.com.cn wrote:
> From: Li Hao <li.hao40@zte.com.cn>
> 
> Cancel the do_wakeup flag in hvc_struct, and change it to immediately
> wake up tty when hp->n_outbuf is 0 in hvc_push().
> 
> When we receive a key input character, the interrupt handling function
> hvc_handle_interrupt() will be executed, and the echo thread
> flush_to_ldisc() will be added to the queue.
> 
> If the user is currently using tcsetattr(), a hang may occur. tcsetattr()
> enters kernel and waits for hp->n_outbuf to become 0 via
> tty_wait_until_sent(). If the echo thread finishes executing before
> reaching tty_wait_until_sent (for example, put_chars() takes too long),
> it will cause while meeting the wakeup condition (hp->do_wakeup = 1),
> tty_wait_until_sent() cannot be woken up (missed the tty_wakeup() of
> this round's tty_poll). Unless the next key input character comes,
> hvc_poll will be executed, and tty_wakeup() will be performed through
> the do_wakeup flag.
> 
> v1->v2:
> Some fixes according to:
> https://lore.kernel.org/all/75dff5cd-7b0e-4039-9157-8bf10cf7ba29@kernel.org/
>     use tty_port_tty_wakeup() instead of tty_wakeup() to wake up tty

As per the documentation, the v1... stuff needs to go below the --- line
so git will strip it away.

Please fix up and send a v3.

thanks,

greg k-h

