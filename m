Return-Path: <linux-kernel+bounces-150417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 801678A9EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C27287BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D0416F82C;
	Thu, 18 Apr 2024 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mNiKJAJD"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41A116E89A;
	Thu, 18 Apr 2024 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455205; cv=none; b=YR//jvise81xYQ2aQEMmbPtmnrRDx4bZGp6Um27E4jtfc0u6ohLe78f/y0pGsRg17q7oCwr49QPSB9bUi2P2ovbsF/is64C/Cc20yLaeKWJtZBOfYOwLuZmFub/QKrPv3EgnyriyPBeod7z4cxdK6YST2cyBlqwNRh/QPl3nMf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455205; c=relaxed/simple;
	bh=K6H40zZOBruNXEKy+mLBxL40J3Voj2XWEqqGuvJ9w94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfVRCHVMHNoh9wGLSl4uMOSmJROR8cKJdQYUjvElGmsW/wkiKcZqQx570pEsg6O15wwQ7y12722j5dbSyH0ZIEE2auO+fa1uiNhnzkJqgCa0Lb2JpDB8ZnebOYXznVgx5eOrAws7/H/yqow9cd68DaSZSgyBnyD5QDfhW7jmF8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=mNiKJAJD; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2A03C802;
	Thu, 18 Apr 2024 17:45:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713455153;
	bh=K6H40zZOBruNXEKy+mLBxL40J3Voj2XWEqqGuvJ9w94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mNiKJAJDsTkJYMYK4ZtsZ9zlV7xPYE85xk9V7yAnZZ4lXnvj+UhwJ4fKqYaFra0Xc
	 2eBi44CBZWoMWyMkwDoCJV3GUcE9zfI7hzMI60oHIg/o5NGSS92iXbFgMGqv+gOkZe
	 2N/SspWfXOLe5x5IbsUKTfY8A/Ga1vjvyZkxLsrw=
Date: Thu, 18 Apr 2024 18:46:33 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
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
Message-ID: <20240418154633.GD31776@pendragon.ideasonboard.com>
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
 <a003494c-a1a9-4fcd-83d8-766a75d6bbb2@moroto.mountain>
 <20240417155112.GQ12561@pendragon.ideasonboard.com>
 <CANiDSCs_qOXkhzuL+cFhpw0hvFMwU0TYyN2B5ZdAStb96TTKFA@mail.gmail.com>
 <20240418105310.GV12561@pendragon.ideasonboard.com>
 <CANiDSCuS3KQK9H37sDZJ+mcqheNSh7NBwchS3dPccVXcPTSNRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCuS3KQK9H37sDZJ+mcqheNSh7NBwchS3dPccVXcPTSNRA@mail.gmail.com>

Hi Ricardo,

On Thu, Apr 18, 2024 at 04:51:06PM +0200, Ricardo Ribalda wrote:
> On Thu, 18 Apr 2024 at 12:53, Laurent Pinchart wrote:
> > On Wed, Apr 17, 2024 at 06:19:14PM +0200, Ricardo Ribalda wrote:
> > > On Wed, 17 Apr 2024 at 17:51, Laurent Pinchart wrote:
> > > > On Tue, Apr 16, 2024 at 11:47:17AM +0300, Dan Carpenter wrote:
> > > > > In my opinion, it's better to just ignore old warnings.
> > > >
> > > > I agree. Whatever checkers we enable, whatever code we test, there will
> > > > always be false positives. A CI system needs to be able to ignore those
> > > > false positives and only warn about new issues.
> > >
> > > We already have support for that:
> > > https://gitlab.freedesktop.org/linux-media/media-ci/-/tree/main/testdata/static?ref_type=heads
> >
> > Those are manually written filters. Would it be possible to reduce the
> > manual step to flagging something as a false positive, and have a
> > machine build the filters ?
> 
> Do you expect that the list of exceptions will grow?
> 
> I hope that once the CI is in place we will fix the warnings before
> they land in the tree.

Any static checker is bound to produce false positives. Some of them can
be addressed by improving the checker, others by modifying the source
code, but in some cases the first option would be too difficult and the
second would reduce readability of the code. I thus thing the list of
accepted false positives will grow over time.

> > > But it would be great if those lists were as small as possible:
> > >
> > > - If we have a lot of warnings, two error messages can be combined and
> > > will scape the filters
> > > eg:
> > > print(AAAA);
> > > print(BBBB);
> > > > AABBBAAB
> > >
> > > - The filters might hide new errors if they are too broad
> > >
> > >
> > > Most of the patches in this series are simple and make a nicer code:
> > > Eg the non return minmax() ,
> > > Other patches show real integer overflows.
> > >
> > > Now that the patches are ready, let's bite the bullet and try to
> > > reduce our technical debt.
> > >
> > > > > When code is new the warnings are going to be mostly correct.  The
> > > > > original author is there and knows what the code does.  Someone has
> > > > > the hardware ready to test any changes.  High value, low burden.
> > > > >
> > > > > When the code is old only the false positives are left.  No one is
> > > > > testing the code.  It's low value, high burden.
> > > > >
> > > > > Plus it puts static checker authors in a difficult place because now
> > > > > people have to work around our mistakes.  It creates animosity.
> > > > >
> > > > > Now we have to hold ourselves to a much higher standard for false
> > > > > positives.  It sounds like I'm complaining and lazy, right?  But Oleg
> > > > > Drokin has told me previously that I spend too much time trying to
> > > > > silence false positives instead of working on new code.  He's has a
> > > > > point which is that actually we have limited amount of time and we have
> > > > > to make choices about what's the most useful thing we can do.
> > > > >
> > > > > So what I do and what the zero day bot does is we look at warnings one
> > > > > time and we re-review old warnings whenever a file is changed.
> > > > >
> > > > > Kernel developers are very good at addressing static checker warnings
> > > > > and fixing the real issues...  People sometimes ask me to create a
> > > > > database of warnings which I have reviewed but the answer is that
> > > > > anything old can be ignored.  As I write this, I've had a thought that
> > > > > instead of a database of false positives maybe we should record a
> > > > > database of real bugs to ensure that the fixes for anything real is
> > > > > applied.

-- 
Regards,

Laurent Pinchart

