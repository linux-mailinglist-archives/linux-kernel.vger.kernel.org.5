Return-Path: <linux-kernel+bounces-148850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4684A8A881E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7480B24C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E4E1487C8;
	Wed, 17 Apr 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JZgtL9Xg"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D1A1474A1;
	Wed, 17 Apr 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369087; cv=none; b=bT1t7FseD3UZcVd+MvGnjrLp48d2Xv1wW31YcZ8v87bkHnWlUvHDItxreephrgVsbVLoNNibsYIYTxqbdYl75Edw6N08PTM2tOuiRr9Que7F7KiJr3/0MnCYtUR/Quok8nh/avYuZsBx3O3F/Na9rr4dirCNszjm6Oc+9fZm2XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369087; c=relaxed/simple;
	bh=edMEOEGuTlM3PAdEmFEfjl2jYJNl85TN3kgL+Uyi5vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pne6b7UcdYWSaHG/QQ2XUqA2QQ03VAkcEASablsp7iZr7xr+qotKVydP1O4V6+2JTZCIxZnhjXdI5qzR7PbGa505lARbEQ38S6EWI29U55UtrCL7Hw5O4tAq4PlosL5baJD8CEKUAVV9q+gJ/Dt/k3DlgeCcGGTk4uzkVkTsDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=JZgtL9Xg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-15-230-nat.elisa-mobile.fi [85.76.15.230])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA4CB1815;
	Wed, 17 Apr 2024 17:50:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713369034;
	bh=edMEOEGuTlM3PAdEmFEfjl2jYJNl85TN3kgL+Uyi5vI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZgtL9XgcBbTfPXnFAZgCDPtfvA9dKRTMOKsCQP54tvG+vgRvyoUVmKyvHqZUW8+9
	 LNXSsOnYHGLTgFNjFxrIi0HOt16nKFhbM2X/j3JnMIJzK5z7DcFFop4CUa4dg8LTzE
	 vNZ8xAy3r+pQq+qAKQ6gJZoeSd1hXqjf9ytYbmBY=
Date: Wed, 17 Apr 2024 18:51:12 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Hugues Fruchet <hugues.fruchet@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>,
	Abylay Ospan <aospan@netup.ru>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Dmitry Osipenko <digetx@gmail.com>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Pavel Machek <pavel@ucw.cz>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [PATCH 00/35] media: Fix coccinelle warning/errors
Message-ID: <20240417155112.GQ12561@pendragon.ideasonboard.com>
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
 <a003494c-a1a9-4fcd-83d8-766a75d6bbb2@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a003494c-a1a9-4fcd-83d8-766a75d6bbb2@moroto.mountain>

On Tue, Apr 16, 2024 at 11:47:17AM +0300, Dan Carpenter wrote:
> In my opinion, it's better to just ignore old warnings.

I agree. Whatever checkers we enable, whatever code we test, there will
always be false positives. A CI system needs to be able to ignore those
false positives and only warn about new issues.

> When code is new the warnings are going to be mostly correct.  The
> original author is there and knows what the code does.  Someone has
> the hardware ready to test any changes.  High value, low burden.
> 
> When the code is old only the false positives are left.  No one is
> testing the code.  It's low value, high burden.
> 
> Plus it puts static checker authors in a difficult place because now
> people have to work around our mistakes.  It creates animosity.
> 
> Now we have to hold ourselves to a much higher standard for false
> positives.  It sounds like I'm complaining and lazy, right?  But Oleg
> Drokin has told me previously that I spend too much time trying to
> silence false positives instead of working on new code.  He's has a
> point which is that actually we have limited amount of time and we have
> to make choices about what's the most useful thing we can do.
> 
> So what I do and what the zero day bot does is we look at warnings one
> time and we re-review old warnings whenever a file is changed.
> 
> Kernel developers are very good at addressing static checker warnings
> and fixing the real issues...  People sometimes ask me to create a
> database of warnings which I have reviewed but the answer is that
> anything old can be ignored.  As I write this, I've had a thought that
> instead of a database of false positives maybe we should record a
> database of real bugs to ensure that the fixes for anything real is
> applied.

-- 
Regards,

Laurent Pinchart

