Return-Path: <linux-kernel+bounces-8240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E020D81B44B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E51E288F79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7744B6D1B6;
	Thu, 21 Dec 2023 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZRA0brZT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AF16BB42;
	Thu, 21 Dec 2023 10:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BDFC433CA;
	Thu, 21 Dec 2023 10:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703155723;
	bh=xBJcV4OMhJoXl7qkczHc+1YvxJ1wQh6siGSG4yUXEO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRA0brZT7oL4W5exoi8DBZmdiZOjy00+FqDTtvp3UMcVo7QfReUkeMCGGIRdSKSIN
	 X2bGUyCKEk5o9vG0N+NcmUSqDl8dvy2tiFQG83FSXgDCeEPc7klY4qqEcrhMOgJiE6
	 AxBcx5Er7LFjhJUhQ0gBWZbR0wbNBV9rbJ/OqdXw=
Date: Thu, 21 Dec 2023 11:48:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gui-Dong Han <2045gemini@gmail.com>
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, mcgrof@kernel.org,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@outlook.com, BassCheck <bass@buaa.edu.cn>
Subject: Re: [PATCH] [media] xc4000: Fix atomicity violation in
 xc4000_get_frequency
Message-ID: <2023122130-unmindful-raider-637b@gregkh>
References: <20231221103707.4129-1-2045gemini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221103707.4129-1-2045gemini@gmail.com>

On Thu, Dec 21, 2023 at 06:37:07PM +0800, Gui-Dong Han wrote:
> In xc4000_get_frequency():
> 	*freq = priv->freq_hz + priv->freq_offset;
> The code accesses priv->freq_hz and priv->freq_offset without holding any
> lock.
> 
> In xc4000_set_params():
> 	// Code that updates priv->freq_hz and priv->freq_offset
> 	...
> 
> xc4000_get_frequency() and xc4000_set_params() may execute concurrently,
> risking inconsistent reads of priv->freq_hz and priv->freq_offset. Since
> these related data may update during reading, it can result in incorrect
> frequency calculation, leading to atomicity violations.
> 
> This possible bug is found by an experimental static analysis tool
> developed by our team. This tool analyzes the locking APIs to extract
> function pairs that can be concurrently executed, and then analyzes the
> instructions in the paired functions to identify possible concurrency bugs
> including data races and atomicity violations. The above possible bug is
> reported when our tool analyzes the source code of Linux 6.2.
> 
> To address this issue, it is proposed to add a mutex lock pair in
> xc4000_get_frequency() to ensure atomicity. With this patch applied, our
> tool no longer reports the possible bug, with the kernel configuration
> allyesconfig for x86_64. Due to the lack of associated hardware, we cannot
> test the patch in runtime testing, and just verify it according to the
> code logic.
> 
> Fixes: 4c07e32884ab6 ("[media] xc4000: Fix get_frequency()")
> Reported-by: BassCheck <bass@buaa.edu.cn>
> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
> ---
>  drivers/media/tuners/xc4000.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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

