Return-Path: <linux-kernel+bounces-53836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A37E84A71C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A9F28D8CD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620586311C;
	Mon,  5 Feb 2024 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J+gy3rBO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F7163128
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162237; cv=none; b=FFEyAFgm2f4x1j6tE9PswejCKBePELYZgxHGTvR+2/B1LW2NUztrHPK2pN4pCLn7oLvD/l7FyyazLYy2qo5/vqhoTltsQolIOohGyJ5n1LatYz2WyiTpEzhZ66w1wwSu7I+jwAcPXAy6YtLmWE6EKGpHNrSyYxJCb4f83eeGzjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162237; c=relaxed/simple;
	bh=Pj7VY2Giu+inEmjQqEhN8ymRYMC/3tJNKNSk6wehCUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkNtfPB+qplm7knrxEa9zfen0atqywaMRsmSHMwCQ00/XXjpNelX231CGPdGgv4DAMcyR/1qC8bAyJl22tewoDXorz1jSmMkpwt1ng+FeQBiwsWA9wbNU/38Tt9lJafCCnsfBIHYMBqqltJkeaJ0z9RdMmYZcDsAGC5VeKP8XYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J+gy3rBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC4FC433F1;
	Mon,  5 Feb 2024 19:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707162236;
	bh=Pj7VY2Giu+inEmjQqEhN8ymRYMC/3tJNKNSk6wehCUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+gy3rBOdUHRQpu3UB5aYQ/Jx8BFzGpi0VhmyQ6qoLumGYiJKUzJcLDW396ujMNQ7
	 fCy/d6EcnVLjZ8odN4/WkQ/tRRTCvXxOZRwJC5gPl0hYk2KgJGIhsUqDVsywakeZ3V
	 BtsOQWADSF0dXuqdQcqo7JOlXVm9F7wsEfmsoP14=
Date: Mon, 5 Feb 2024 19:43:54 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	linux-kernel@vger.kernel.org, manugautam@google.com
Subject: Re: [PATCH] nvmem: rmem: Fix return value of rmem_read()
Message-ID: <2024020544-lucid-nervous-2cbd@gregkh>
References: <20240205114826.39036-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205114826.39036-1-joychakr@google.com>

On Mon, Feb 05, 2024 at 11:48:26AM +0000, Joy Chakraborty wrote:
> reg_read() callback registered with nvmem core expects an integer error
> as a return value but rmem_read() returns the number of bytes read, as a
> result error checks in nvmem core fail even when they shouldn't.
> 
> Return 0 on success where number of bytes read match the number of bytes
> requested and a negative error -EINVAL on all other cases.
> 
> Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> ---
>  drivers/nvmem/rmem.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

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

