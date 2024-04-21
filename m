Return-Path: <linux-kernel+bounces-152497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 702898ABF59
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 15:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EC01C20F7B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 13:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDDB17995;
	Sun, 21 Apr 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E2HQZsOp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470FE625;
	Sun, 21 Apr 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713707301; cv=none; b=b//wm8rHjM/AcJSeoV3M/o23F44GBlbYt5rjyZlFaca+GFejDok+57Ius+zF7cFyYNfHE/UL3d3utJP9VGvtwJT+cInhBv0r6UTgG6dIbBkRznB2x90A5nKgOusMRVULKetDbGJkWb00t9OFBtGH1A4NnUyQ+vozETwBkElnK3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713707301; c=relaxed/simple;
	bh=LlUgqYs3MCsI8tfMXyODmqS8Vxzo+bhP7dqc9s6OIOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhoKJOAHNS55Huy4qMlLadai1Pj8Q9MhGJYVUcav1+3Umlp3ubglNpIu3pljNwItCAl/tQS8rcAaucJEsWjYBxJUapIaeVP4k2wuQUME+8ux+CeNIEcMSR6+E60wREFLHnie32XlEbSJ/9AoFILqYZ3+PLCrI74FwZCI9ChsmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E2HQZsOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D77EC113CE;
	Sun, 21 Apr 2024 13:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713707300;
	bh=LlUgqYs3MCsI8tfMXyODmqS8Vxzo+bhP7dqc9s6OIOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2HQZsOpXkpKHudpdluczuDQnp4aiFdqJ82dLDH1II7kBwQkMvcWNiCIkeSoP5rWm
	 m9nZ2jQglkE44ukF7sxlCBCK/PQXihvUDzufJomZBn2n9OqRQMJ6Ud/dSxNSDJpwTv
	 Lg9wQiO5BEJ/8jDnKp9G7q+/3ehh9dAKnAX9ycsg=
Date: Sun, 21 Apr 2024 15:48:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Ricardo Ribalda <ribalda@chromium.org>, linux-media@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
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
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Samuel Holland <samuel@sholland.org>,
	Sergey Kozlov <serjk@netup.ru>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 24/26] media: venus: venc: Make explicit the range of
 us_per_frame
Message-ID: <2024042112-deferred-fantastic-5b4b@gregkh>
References: <20240419-fix-cocci-v2-24-2119e692309c@chromium.org>
 <0ab13de0-0fde-40e2-958f-6a0818911009@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ab13de0-0fde-40e2-958f-6a0818911009@web.de>

On Sun, Apr 21, 2024 at 03:25:31PM +0200, Markus Elfring wrote:
> > Unless the fps is smaller than 0.000232829 fps, this fits in a 32 bit number.
> > Make that explicit.
> 
> Would it be more appropriate to move the word “explicit” to the end
> of the summary phrase?
> 
> Regards,
> Markus
> 

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

