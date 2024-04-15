Return-Path: <linux-kernel+bounces-145855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89D08A5BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7811C21E10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAE7155A58;
	Mon, 15 Apr 2024 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mn7r/e9a"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10013AA31
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211177; cv=none; b=GKeHvz+J2ToTk/KG0I43vvnhTQecAGfe1nUunoZCfB4Ht54Hnw2VSFf3ICPcIy5fz0GyPg/pDAmH3APPsd1xD59trgX8zMdqgUZKcHGppVIZT07gHdtrOYfhpkcIWPi1LjdHZupQYN/63T9hMw2+U2Hey3rhH89ZkMwZn7SuOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211177; c=relaxed/simple;
	bh=3f44RVReelwdCSGbY3G3UnF/F1spdxFNz4KzB0EHUe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGGcUzQ3OP2mo1DxMQh41nCfGMrjpKd/cjgbn4wfr672bDrR3MMsGLrXyX0sNwxezhR+AFkHEBP2ZQW5yyuMqwwLxFdYZ9NGyGZtqirIKa//xz+pVXokJw0euCWF5GT+12MJf1N4JKMAM+OJHCQPv7S4X0JQpzVU7lwqz7MIciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mn7r/e9a; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ea128e4079so2328511a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713211175; x=1713815975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=naj/YQ9ncheD39vcOQ7UyQeYC8KWCng+2i7jmecCLPU=;
        b=mn7r/e9aW6LUCrA6eQKpKHv0wiXrVgFm68PpW8uBvBwQ/96i69YtdItWQ+YCYhNMwf
         8mzuDiGEuNTPbg+vJv7ixSjRC9mXat4jphY7K8Sa1ZXUpeAYp9wzWTrpkAlVd1Aiu4qT
         WE/8IsdIEYg62o8P843IlBeTufAk0fUDyqt10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713211175; x=1713815975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naj/YQ9ncheD39vcOQ7UyQeYC8KWCng+2i7jmecCLPU=;
        b=MtjSQfXMKIMiSCUBxwLEjv5oPhurEWa0/6uwfWx05Gtq6TBso+R/Ni8+lHJd9m7ife
         vKI0gkTkCQbJ+l58FZGPvO2j+0lX/G3N5wImZYIGW4totL3HHa332043lcsScazhus0l
         R/IJ0oB2sokedNyGChqiMrsU0YMzslEkfcQHIJy0KjvEW5ekeRSt4vPpXxJC+A0h0Ij0
         rVJAU2XtgxGc75gC3dmjOtKhXMMIYfuBu7DCVNTGIIMwbIiMy/cA8wrywO2gAIGNzOBt
         ilzy1APfKyfdTAlmbRzrqILx6pR3rJsn81t3tQm6sfAYYNNp4AInhpktSP5YT7Mf8AzD
         atXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVJfM2QUw5niGSSgYCbNCF0bEWhb7BRPrRkSYSYCz7JdVCBsnRySgfT2apipxYZg7VV54XrQwBKmSAa+12yFT+5e+egoC0lCSz9Ohk
X-Gm-Message-State: AOJu0YwvZ4jo6VYXEk7+AydREuw/RxB7Q0fh3h2bzWLBG+Ivu2151ges
	euVVBpFxsaNqtpbRnPiXPrS6oZ3vzBM3/SAtI8/k3TSI0bXBczuZGLh121KHP4F6poEZRXuSnaC
	anw==
X-Google-Smtp-Source: AGHT+IHwNwJRHKns8qsyOvk/s5u4lDs2invshsKTctYsL2pGyPZPIInJovtOG3fG1NT+quMEfef47w==
X-Received: by 2002:a05:6830:138f:b0:6eb:828c:96e5 with SMTP id d15-20020a056830138f00b006eb828c96e5mr2658578otq.27.1713211174790;
        Mon, 15 Apr 2024 12:59:34 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id w12-20020a9d538c000000b006eb7d53f9a4sm632399otg.75.2024.04.15.12.59.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 12:59:34 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c70964374bso863840b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:59:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrz5PPepxV0MRI2gBZdSidIGZmKSS4Qai9rN2Gu5cY/MOvRhTOKM0ZvWyWPQLR9f/jnaxm1yK2lInoJXzORH+6IUwdM4T9eNyT1jTu
X-Received: by 2002:a25:ab2c:0:b0:db9:794b:5733 with SMTP id
 u41-20020a25ab2c000000b00db9794b5733mr10827321ybi.19.1713211153708; Mon, 15
 Apr 2024 12:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org> <20240415195348.GD22954@pendragon.ideasonboard.com>
In-Reply-To: <20240415195348.GD22954@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 15 Apr 2024 21:58:58 +0200
X-Gmail-Original-Message-ID: <CANiDSCteGngbSS6CCuUxM-PQiBz0W0WfoFr2E2oH2d8qt746_A@mail.gmail.com>
Message-ID: <CANiDSCteGngbSS6CCuUxM-PQiBz0W0WfoFr2E2oH2d8qt746_A@mail.gmail.com>
Subject: Re: [PATCH 00/35] media: Fix coccinelle warning/errors
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
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
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Mon, 15 Apr 2024 at 21:54, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> I'm afraid I won't have time to review any of this for the time being.
> Unless you would like me to put uvcvideo reviews on hold ;-)
>
> Jokes aside, my first reaction was that this feels like a bit of a waste
> of maintainer's time :-S

This is part of the media-ci effort.

It is definitely not the most fun patches to do or review, but someone
has to do it :)

The whole idea is that we want to get as little warnings as possible
from the static analysers, after this patchset we almost achieve that.

It is only 2 trivial uvc patches, I can ask someone from my team to
review it if you want and trust them ;)

Regards!

>
> On Mon, Apr 15, 2024 at 07:34:17PM +0000, Ricardo Ribalda wrote:
> > After this set is applied, these are the only warnings left:
> > drivers/media/pci/ivtv/ivtv-fileops.c:223:4-10: preceding lock on line 267
> > drivers/media/pci/ivtv/ivtv-fileops.c:230:3-9: preceding lock on line 267
> > drivers/media/pci/ivtv/ivtv-fileops.c:236:4-10: preceding lock on line 267
> > drivers/media/pci/ivtv/ivtv-fileops.c:245:3-9: preceding lock on line 267
> > drivers/media/pci/ivtv/ivtv-fileops.c:251:3-9: preceding lock on line 267
> > drivers/media/pci/ivtv/ivtv-fileops.c:257:3-9: preceding lock on line 267
> > drivers/media/pci/ivtv/ivtv-fileops.c:272:3-9: preceding lock on line 267
> > drivers/media/pci/ivtv/ivtv-fileops.c:598:4-10: preceding lock on line 627
> > drivers/media/pci/ivtv/ivtv-fileops.c:598:4-10: preceding lock on line 689
> > drivers/media/pci/ivtv/ivtv-fileops.c:606:3-9: preceding lock on line 627
> > drivers/media/pci/ivtv/ivtv-fileops.c:606:3-9: preceding lock on line 689
> > drivers/media/pci/ivtv/ivtv-fileops.c:648:3-9: preceding lock on line 627
> > drivers/media/pci/ivtv/ivtv-fileops.c:648:3-9: preceding lock on line 689
> > drivers/media/pci/ivtv/ivtv-fileops.c:692:4-10: preceding lock on line 689
> > drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2776
> > drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2786
> > drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2809
> > drivers/media/dvb-frontends/stv090x.c:799:1-7: preceding lock on line 768
> > drivers/media/usb/go7007/go7007-i2c.c:125:1-7: preceding lock on line 61
> > drivers/media/rc/imon.c:1167:1-7: preceding lock on line 1153
> > drivers/media/pci/cx18/cx18-scb.h:261:22-29: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_cmds.h:77:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_cmds.h:85:5-16: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_cmds.h:154:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_cmds.h:171:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_cmds.h:180:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_cmds.h:189:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_cmds.h:201:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_cmds.h:220:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_cmds.h:230:5-16: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_helper.h:764:5-15: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_helper.h:1008:43-60: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_helper.h:1014:36-46: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_helper.h:1041:5-15: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_helper.h:1088:39-51: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_helper.h:1093:5-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_helper.h:1144:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_helper.h:1239:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_helper.h:1267:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/qcom/venus/hfi_helper.h:1272:4-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/common/siano/smscoreapi.h:619:5-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/common/siano/smscoreapi.h:669:6-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/common/siano/smscoreapi.h:1049:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/common/siano/smscoreapi.h:1055:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/dvb-frontends/mxl5xx_defs.h:171:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/dvb-frontends/mxl5xx_defs.h:182:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/allegro-dvt/nal-hevc.h:102:14-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/media/platform/xilinx/xilinx-dma.h:100:19-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> > drivers/staging/media/atomisp/pci/atomisp_tpg.h:30:18-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> >
> > CI tested:
> > https://gitlab.freedesktop.org/linux-media/media-staging/-/commit/055b5211c68e721c3a7090be5373cf44859da1a7/pipelines?ref=ribalda%2Ftest-cocci
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > Ricardo Ribalda (35):
> >       media: pci: mgb4: Refactor struct resources
> >       media: stb0899: Remove unreacheable code
> >       media: uvcvideo: Refactor iterators
> >       media: uvcvideo: Use max() macro
> >       media: go7007: Use min and max macros
> >       media: stm32-dcmipp: Remove redundant printk
> >       media: staging: sun6i-isp: Remove redundant printk
> >       media: dvb-frontends: tda18271c2dd: Remove casting during div
> >       media: v4l: async: refactor v4l2_async_create_ancillary_links
> >       staging: media: tegra-video: Use swap macro
> >       media: s2255: Use refcount_t instead of atomic_t for num_channels
> >       media: platform: mtk-mdp3: Use refcount_t for job_count
> >       media: common: saa7146: Use min macro
> >       media: dvb-frontends: drx39xyj: Use min macro
> >       media: netup_unidvb: Use min macro
> >       media: au0828: Use min macro
> >       media: flexcop-usb: Use min macro
> >       media: gspca: cpia1: Use min macro
> >       media: stk1160: Use min macro
> >       media: tegra-vde: Refactor timeout handling
> >       media: venus: Use div64_u64
> >       media: i2c: st-mipid02: Use the correct div function
> >       media: dvb-frontends: tda10048: Use the right div
> >       media: tc358746: Use the correct div_ function
> >       media: venus: Use the correct div_ function
> >       media: venus: Refator return path
> >       media: dib0700: Refator return path
> >       media: usb: cx231xx: Refator return path
> >       media: i2c: rdacm20: Refator return path
> >       media: i2c: et8ek8: Refator return path
> >       media: cx231xx: Refator return path
> >       media: si4713: Refator return path
> >       media: ttpci: Refator return path
> >       media: hdpvr: Refator return path
> >       media: venus: Refator return path
> >
> >  drivers/media/common/saa7146/saa7146_hlp.c         |  8 +++----
> >  drivers/media/dvb-frontends/drx39xyj/drxj.c        |  9 +++-----
> >  drivers/media/dvb-frontends/stb0899_drv.c          |  5 -----
> >  drivers/media/dvb-frontends/tda10048.c             |  3 +--
> >  drivers/media/dvb-frontends/tda18271c2dd.c         |  4 ++--
> >  drivers/media/i2c/et8ek8/et8ek8_driver.c           |  4 +++-
> >  drivers/media/i2c/rdacm20.c                        |  5 ++++-
> >  drivers/media/i2c/st-mipid02.c                     |  2 +-
> >  drivers/media/i2c/tc358746.c                       |  3 +--
> >  drivers/media/pci/mgb4/mgb4_core.c                 |  4 ++--
> >  drivers/media/pci/mgb4/mgb4_regs.c                 |  2 +-
> >  drivers/media/pci/netup_unidvb/netup_unidvb_i2c.c  |  2 +-
> >  drivers/media/pci/ttpci/budget-core.c              |  5 ++++-
> >  .../media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c   | 10 ++++-----
> >  .../media/platform/mediatek/mdp3/mtk-mdp3-core.c   |  6 ++---
> >  .../media/platform/mediatek/mdp3/mtk-mdp3-core.h   |  2 +-
> >  .../media/platform/mediatek/mdp3/mtk-mdp3-m2m.c    |  6 ++---
> >  drivers/media/platform/nvidia/tegra-vde/h264.c     |  6 ++---
> >  drivers/media/platform/qcom/venus/vdec.c           | 15 +++++++------
> >  drivers/media/platform/qcom/venus/venc.c           | 19 +++++++++-------
> >  .../platform/st/stm32/stm32-dcmipp/dcmipp-core.c   |  5 +----
> >  drivers/media/radio/si4713/radio-usb-si4713.c      |  8 +++++--
> >  drivers/media/usb/au0828/au0828-video.c            |  5 +----
> >  drivers/media/usb/b2c2/flexcop-usb.c               |  5 +----
> >  drivers/media/usb/cx231xx/cx231xx-i2c.c            | 16 +++++++++----
> >  drivers/media/usb/cx231xx/cx231xx-video.c          | 10 +++++++--
> >  drivers/media/usb/dvb-usb/dib0700_core.c           |  4 +++-
> >  drivers/media/usb/go7007/go7007-fw.c               |  4 ++--
> >  drivers/media/usb/gspca/cpia1.c                    |  6 ++---
> >  drivers/media/usb/hdpvr/hdpvr-control.c            |  4 +++-
> >  drivers/media/usb/s2255/s2255drv.c                 | 20 ++++++++---------
> >  drivers/media/usb/stk1160/stk1160-video.c          | 10 ++-------
> >  drivers/media/usb/uvc/uvc_ctrl.c                   | 26 ++++++++++++----------
> >  drivers/media/v4l2-core/v4l2-async.c               |  8 +++----
> >  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c  |  1 -
> >  drivers/staging/media/tegra-video/tegra20.c        |  9 ++------
> >  36 files changed, 132 insertions(+), 129 deletions(-)
> > ---
> > base-commit: 71b3ed53b08d87212fbbe51bdc3bf44eb8c462f8
> > change-id: 20240415-fix-cocci-2df3ef22a6f7
> >
> > Best regards,
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

