Return-Path: <linux-kernel+bounces-1270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AD3814CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD0FB20F07
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757443BB27;
	Fri, 15 Dec 2023 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zYiCweUb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FF13A8F0;
	Fri, 15 Dec 2023 16:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7EAC433C8;
	Fri, 15 Dec 2023 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702656752;
	bh=aUbwALdJfaWsm15Cj8LhFXmdPuNIvb9+6Oi7fbKXNsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zYiCweUbM8g2af0YAsMrv7bIPEAGKCuq6oHuWVmRWmu6ag0JqMS8UsxXju64J9R/j
	 trhkjsyi3nh8XO6FTVRIncvKZO6aHr8wMj0FSEOqWxSL8wYhDF/aXlWNQkPZo/BOry
	 9plBZ+1F+mim8IHeDnYZaALgwgBHLc2iCT0j2N7M=
Date: Fri, 15 Dec 2023 17:12:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH 1/8] spmi: mtk-pmif: Serialize PMIF status check and
 command submission
Message-ID: <2023121518-borax-wham-3d0e@gregkh>
References: <20231206231733.4031901-1-sboyd@kernel.org>
 <20231206231733.4031901-2-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231206231733.4031901-2-sboyd@kernel.org>

On Wed, Dec 06, 2023 at 03:17:24PM -0800, Stephen Boyd wrote:
> From: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> Before writing the read or write command to the SPMI arbiter through the
> PMIF interface, the current status of the channel is checked to ensure
> it is idle. However, since the status only changes from idle when the
> command is written, it is possible for two concurrent calls to determine
> that the channel is idle and simultaneously send their commands. At this
> point the PMIF interface hangs, with the status register no longer being
> updated, and thus causing all subsequent operations to time out.
> 
> This was observed on the mt8195-cherry-tomato-r2 machine, particularly
> after commit 46600ab142f8 ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for
> drivers between 5.10 and 5.15") was applied, since then the two MT6315
> devices present on the SPMI bus would probe assynchronously and
> sometimes (during probe or at a later point) read the bus
> simultaneously, breaking the PMIF interface and consequently slowing
> down the whole system.
> 
> To fix the issue at its root cause, introduce locking around the channel
> status check and the command write, so that both become an atomic
> operation, preventing race conditions between two (or more) SPMI bus
> read/write operations. A spinlock is used since this is a fast bus, as
> indicated by the usage of the atomic variant of readl_poll, and
> '.fast_io = true' being used in the mt6315 driver, so spinlocks are
> already used for the regmap access.
> 
> Fixes: b45b3ccef8c0 ("spmi: mediatek: Add support for MT6873/8192")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Link: https://lore.kernel.org/r/20230724154739.493724-1-nfraprado@collabora.com
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/spmi/spmi-mtk-pmif.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)

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

