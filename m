Return-Path: <linux-kernel+bounces-140591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9013C8A1698
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F951C20F46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D5114F12A;
	Thu, 11 Apr 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0NcGI5ol"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE3914D443
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844183; cv=none; b=ShY+eCfSuPDg6gVmQdF36YHY2ZBF+joyP2mtfw0CdTONa7m32bscSctIBi/aPiaCEihGEjp7OgemYIdocOYlecedurFK9iMDZhiGqDf27y0Tl4dcpMLQQ2hlHR9t+TXYWM80lz3nWRt7FAIkPbKi4zDOBmDmncROwA65WKndQF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844183; c=relaxed/simple;
	bh=6UJZZ6IjHCrKomyVcGWFI8QkbjcakZqKcaKnyTXHAhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPFoi6fnlV/J36uzFdoSuYJibgIK0X18L6BmUgsQwADlQlOfXV3zlyFySmSMhWxOnRdoueiiZV60tf+uyMpgFlVrRZrm2Lq17sBACBaU7K74rmxt0v/Mkr0jKKYcwq89F5vxUByl1tQ15oyvtg2fg3rtAGdql+f4oMSwKjbm+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0NcGI5ol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE959C072AA;
	Thu, 11 Apr 2024 14:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712844183;
	bh=6UJZZ6IjHCrKomyVcGWFI8QkbjcakZqKcaKnyTXHAhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0NcGI5oljWMkz32EWruHRpi43mJPvYvSKu4mleZsj5+GOQTshIcV111wtKcQHvsNp
	 XXfxmBKYOpZh4N6vL8eBzbUdsIlu//opGukHcs5BzJI+9f8trzvxeTsj6dlgnoiYd/
	 32oIUS7dqxBHJXAPFn+chDjOyRDZHMGN0+u/Y2ts=
Date: Thu, 11 Apr 2024 16:03:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: li.hao40@zte.com.cn
Cc: jirislaby@kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: hvc: wakeup hvc console immediately when needed
Message-ID: <2024041151-crewmate-entail-62a5@gregkh>
References: <20240411215017604oDcKsSipiLnfwd2SzAnsj@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411215017604oDcKsSipiLnfwd2SzAnsj@zte.com.cn>

On Thu, Apr 11, 2024 at 09:50:17PM +0800, li.hao40@zte.com.cn wrote:
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
> this round&apos;s tty_poll). Unless the next key input character comes,
> hvc_poll will be executed, and tty_wakeup() will be performed through
> the do_wakeup flag.
> 
> Signed-off-by: Li Hao

Did checkpatch say this was ok?


