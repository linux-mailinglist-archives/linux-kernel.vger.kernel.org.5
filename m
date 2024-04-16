Return-Path: <linux-kernel+bounces-146403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FDD8A64D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E54A281C14
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294CF136E13;
	Tue, 16 Apr 2024 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GM0HpOKv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB578C68;
	Tue, 16 Apr 2024 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251758; cv=none; b=cxhz3eHZewc0O9x0r6BUXoMpwSwvdkYwbMtLl5tBPQ8oofJHXyzTfZUbMsvkl54AGHfBCo19vDspEd4E6N4/JTi3sv7U0H8dpRfCLlGqcy1Prg36JYMq6yaQ9lH5uCsQAluZhaV0465eZJLx8zk3NjBMFJGyp62CN4wp7spcMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251758; c=relaxed/simple;
	bh=fUF2u2LQ3yYejHYR20qqNgEGI+K7DgTOWHNB8ygVkHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uh68zfKtV+AAYP3dEjz1yw118DwuA4SaiD0F2JJbcZcCLY2hWr0R/vbYUwITmc/sXdaaoBvIhTZan8IKlbBPeTm6FJ1BVHajMyYRxZGGQzl+HE++jcgJnAF1kP84JFspp+XIzn2WM36TP5u1HcVCFL5lFoYDBrtZUlNNM4KHLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GM0HpOKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BB3C113CE;
	Tue, 16 Apr 2024 07:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713251757;
	bh=fUF2u2LQ3yYejHYR20qqNgEGI+K7DgTOWHNB8ygVkHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GM0HpOKvvu3P9UCy4cNIuJYRWvPq5BYD+56S81mhe9N1R9IceqdpHoryxgbw1kGhY
	 +JxBBgH51if0tF9gFdKZ10CJHe/4KxL0pZvEaarQ/+kXVYQlIYT+qamLhpoqug094G
	 KERgownT5RTB7lAp9I7wg+v4Q+AsaMKUMMeXjVMY=
Date: Tue, 16 Apr 2024 09:15:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Ricardo Ribalda <ribalda@chromium.org>, linux-media@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Abylay Ospan <aospan@netup.ru>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>, Dmitry Osipenko <digetx@gmail.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Hugues Fruchet <hugues.fruchet@foss.st.com>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Pavel Machek <pavel@ucw.cz>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Samuel Holland <samuel@sholland.org>,
	Sergey Kozlov <serjk@netup.ru>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 03/35] media: uvcvideo: Refactor iterators
Message-ID: <2024041643-unshaven-happiest-1405@gregkh>
References: <20240415-fix-cocci-v1-3-477afb23728b@chromium.org>
 <e0377059-4073-4779-8385-506b9b39301e@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0377059-4073-4779-8385-506b9b39301e@web.de>

On Tue, Apr 16, 2024 at 09:03:36AM +0200, Markus Elfring wrote:
> I would find a hint for a variable change more appropriate in the patch subject
> instead of the word “iterators”.
> 
> 
> …
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> …
> > @@ -2175,16 +2177,16 @@ int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
> >  	int ret;
> >
> >  	/* Find the extension unit. */
> …
> > +	entity = NULL;
> > +	list_for_each_entry(iter, &chain->entities, chain) {
> …
> 
> I suggest to move this assignment into the definition for the affected local variable.
> 
> 
> By the way:
> I see another source code adjustment opportunity in this function implementation.
> https://elixir.bootlin.com/linux/v6.9-rc4/source/drivers/media/usb/uvc/uvc_ctrl.c#L2165
> 
> Can it be nicer to use labels “free_data” and “unlock” (instead of “done”)?
> How do you think about to increase the application of scope-based resource management here?

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

