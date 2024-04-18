Return-Path: <linux-kernel+bounces-150340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BEA8A9DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9A42834EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4707616ABC3;
	Thu, 18 Apr 2024 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k3zhLfRT"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5406168B1A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451909; cv=none; b=EY3BwY6RKh7khWMilAHunv/i/82ZHmVTCAusntevXYQmCTMk9E8QAEnFU4Vcg6sAP62aBIKo1pFsLPUru+tOMvN1qXe1TG9NqIKaelZf1b/TWLbVWMxP2apt6AZ92riRxly6aJ2h8T5AcG+IAKI4wJ8BtCZP69JkShtmw4ws02Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451909; c=relaxed/simple;
	bh=CbuQk1PghdDnmrxhojCwmpRorta2iCVuoxXGBVbnZE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=momO8sLeaF5P6IlixvAPyZBcz8Fm6ZO9gIuPuQrZX4oiatM6eZPg3tPmTo+sTEspCe5zFQepMurHhvflIiI8z48dxV1QZXsrqToAxk42VHOX1QOnvSEUM79JvQP9cMvESjS0x7w8P1Sj30iriPochTvynoqXzMMWdPmA5ij8p18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k3zhLfRT; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-479ccc89792so488328137.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713451907; x=1714056707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oMqAEiiN7av4J6wM+O4afdcaiaOjYq8V1FKf5PLPclI=;
        b=k3zhLfRTZ3CUo37HntuQozk+xsQqNFpS0d69qYWfIOHdrvxsMtFir1VCDP6bVMqez+
         mIalxl6VkRGjmqEjJeAUI/qc6uOILh5PJ4jvabr+nlVuXQsmGLtUdwGoW/nYaCLYREUn
         Uiou1n+7/u+1aoNa3nV6zhQy9/xnV+DTz7SKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713451907; x=1714056707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMqAEiiN7av4J6wM+O4afdcaiaOjYq8V1FKf5PLPclI=;
        b=usWG7+HsCHAxacIJOm457i8+9pt20lpXZ91AZfDgr1CVJfH9/qUeSA3pyGt8w0UUuI
         JZ0MvDikZVCL1otVD0OLI67OMHQNfTvxxYtyssW1AZWx7hui9nTHAhInd4Sw5MAeNbhY
         RRLu5EM/PL4J/WHgz9Knws++Kn7CLBKUxMi5mLi0HCGEaGKXLzGH+VnzXXi7xbrKocPx
         od9dghVxFWyzw6nTqmcusqgCSPQxLvp7t4bctHhDujnHxyiHAZxD4qV1rd22Am1W2fJQ
         nFbqfxnE92/8rBBPuRUwgfRWQnjn3joBoQrNPuHl/sNbHI58wFNtyedMPFblJsk36CA2
         9sbQ==
X-Forwarded-Encrypted: i=1; AJvYcCURc40+LgR1sUcXxHvQ3DRCaak1xa3KVUY7eaVwegIrNUOS/OoL2xD/MzZT5hRYVKMXmgN+VsZQBILsDMTRwG9cUhuDrfeEnx709/dn
X-Gm-Message-State: AOJu0YxkJiECzkNExvGrQXNRJAQn92J3F14yvuFQ+m2hDU94zdauupIy
	FhQoilGmkc3bXXaFNSVo9cKaa66VrmIDtfVRva9yyUvIeUSfMRvh1Ea2B67H+Ud2SDJQNvrg6iM
	=
X-Google-Smtp-Source: AGHT+IGgO3zQA1gHdS4u1UgvoeMkJbjPr+uq1mzxg8l56VtR9SnQYc19m4a+Z40X0eTox1PvLIA0CQ==
X-Received: by 2002:a67:b404:0:b0:47b:bda4:c30d with SMTP id x4-20020a67b404000000b0047bbda4c30dmr2036972vsl.3.1713451906742;
        Thu, 18 Apr 2024 07:51:46 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id j18-20020a0561023e1200b0047a1f4aa6d9sm224720vsv.27.2024.04.18.07.51.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 07:51:46 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4dad4b35d08so1207392e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:51:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIdw6MDPJ0htB8rjPBjHWQrX60jAH0UPqBac1YpdgN8Ag09P7uUbjYEoaf0PTAHIM3OvhZzx9hoaXfcNRixpx+aFoewkh1wY45NCgz
X-Received: by 2002:a05:6214:4a5b:b0:6a0:4571:e0c8 with SMTP id
 ph27-20020a0562144a5b00b006a04571e0c8mr3999896qvb.18.1713451882078; Thu, 18
 Apr 2024 07:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
 <a003494c-a1a9-4fcd-83d8-766a75d6bbb2@moroto.mountain> <20240417155112.GQ12561@pendragon.ideasonboard.com>
 <CANiDSCs_qOXkhzuL+cFhpw0hvFMwU0TYyN2B5ZdAStb96TTKFA@mail.gmail.com> <20240418105310.GV12561@pendragon.ideasonboard.com>
In-Reply-To: <20240418105310.GV12561@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 18 Apr 2024 16:51:06 +0200
X-Gmail-Original-Message-ID: <CANiDSCuS3KQK9H37sDZJ+mcqheNSh7NBwchS3dPccVXcPTSNRA@mail.gmail.com>
Message-ID: <CANiDSCuS3KQK9H37sDZJ+mcqheNSh7NBwchS3dPccVXcPTSNRA@mail.gmail.com>
Subject: Re: [PATCH 00/35] media: Fix coccinelle warning/errors
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
	Martin Tuma <martin.tuma@digiteqautomotive.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Hugues Fruchet <hugues.fruchet@foss.st.com>, Alain Volmat <alain.volmat@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>, 
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Dmitry Osipenko <digetx@gmail.com>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
	Sylvain Petinot <sylvain.petinot@foss.st.com>, Jacopo Mondi <jacopo+renesas@jmondi.org>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Pavel Machek <pavel@ucw.cz>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	Oleg Drokin <green@linuxhacker.ru>
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Thu, 18 Apr 2024 at 12:53, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Wed, Apr 17, 2024 at 06:19:14PM +0200, Ricardo Ribalda wrote:
> > On Wed, 17 Apr 2024 at 17:51, Laurent Pinchart wrote:
> > > On Tue, Apr 16, 2024 at 11:47:17AM +0300, Dan Carpenter wrote:
> > > > In my opinion, it's better to just ignore old warnings.
> > >
> > > I agree. Whatever checkers we enable, whatever code we test, there will
> > > always be false positives. A CI system needs to be able to ignore those
> > > false positives and only warn about new issues.
> >
> > We already have support for that:
> > https://gitlab.freedesktop.org/linux-media/media-ci/-/tree/main/testdata/static?ref_type=heads
>
> Those are manually written filters. Would it be possible to reduce the
> manual step to flagging something as a false positive, and have a
> machine build the filters ?
>

Do you expect that the list of exceptions will grow?

I hope that once the CI is in place we will fix the warnings before
they land in the tree.


> > But it would be great if those lists were as small as possible:
> >
> > - If we have a lot of warnings, two error messages can be combined and
> > will scape the filters
> > eg:
> > print(AAAA);
> > print(BBBB);
> > > AABBBAAB
> >
> > - The filters might hide new errors if they are too broad
> >
> >
> > Most of the patches in this series are simple and make a nicer code:
> > Eg the non return minmax() ,
> > Other patches show real integer overflows.
> >
> > Now that the patches are ready, let's bite the bullet and try to
> > reduce our technical debt.
> >
> > > > When code is new the warnings are going to be mostly correct.  The
> > > > original author is there and knows what the code does.  Someone has
> > > > the hardware ready to test any changes.  High value, low burden.
> > > >
> > > > When the code is old only the false positives are left.  No one is
> > > > testing the code.  It's low value, high burden.
> > > >
> > > > Plus it puts static checker authors in a difficult place because now
> > > > people have to work around our mistakes.  It creates animosity.
> > > >
> > > > Now we have to hold ourselves to a much higher standard for false
> > > > positives.  It sounds like I'm complaining and lazy, right?  But Oleg
> > > > Drokin has told me previously that I spend too much time trying to
> > > > silence false positives instead of working on new code.  He's has a
> > > > point which is that actually we have limited amount of time and we have
> > > > to make choices about what's the most useful thing we can do.
> > > >
> > > > So what I do and what the zero day bot does is we look at warnings one
> > > > time and we re-review old warnings whenever a file is changed.
> > > >
> > > > Kernel developers are very good at addressing static checker warnings
> > > > and fixing the real issues...  People sometimes ask me to create a
> > > > database of warnings which I have reviewed but the answer is that
> > > > anything old can be ignored.  As I write this, I've had a thought that
> > > > instead of a database of false positives maybe we should record a
> > > > database of real bugs to ensure that the fixes for anything real is
> > > > applied.
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

