Return-Path: <linux-kernel+bounces-81851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 369F8867AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A985F1F2759F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6826B12BF1C;
	Mon, 26 Feb 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cr1+/oE/"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB312BF01
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962994; cv=none; b=HfmNWX2CCQi/8fkdFknlQ/J5wWkG25K0GC2EemM3Pp807xW4VJOQTXxAW95VDWJMn+qsXmiOB2xaliJAU6F9E0PJIvnf4Hjpf5uuqpD/oBMdX2HqpUo/ApQtTxAaBqt5I+kmSSX63XAsCKngW235xiiPPNCBdgn3jaxZYuWkkGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962994; c=relaxed/simple;
	bh=wTNfxtjjEuUsYp1JNTlYg2x2iUW0rS+mI/kNL5uqq8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpQwM0qaMlRhJvLNPsMu1fb30zU91/494a6iVGzfFBdnlMddAPecBB1FiYtP+LK37fvDAfPqR+fJ+Zlnyua2VkvNsIMX4u6yAECnWRfdDUyy0xFCb5j1mR8tJ6K1IABkFQNnG6lqj9g4L+c5q1sDUGDNG8snohK52lGsjW8UNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cr1+/oE/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3e5d82ad86so455706066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708962988; x=1709567788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTNfxtjjEuUsYp1JNTlYg2x2iUW0rS+mI/kNL5uqq8k=;
        b=Cr1+/oE/lSCT/KHR3Phkvu0oyWtYMIRymC8UkSU5TJXl2DHLmMkZvmEUWnrxMPhvlL
         PR6nGU3T+QzVzvL5okTMXg/mgy5Y6JDhk0SZEPfVWcgdIpM2SAv2c2DpPqSguOPHdTBZ
         uguKnnCQyFtmGfBpGpC4DHwQScsNUUqc16GR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962988; x=1709567788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTNfxtjjEuUsYp1JNTlYg2x2iUW0rS+mI/kNL5uqq8k=;
        b=KJLO1WmltK3yePVIUtkVNU1/+SpfrlOziGQ3kCyy//fYBLI/x+6qlRFyjItCsv9u09
         W9AD02JMDZ1vLFXG6j/nLYc2dsvZ1fkS3cIx8ZxPcOTOumFLCnizzS8sVayYK/wxyH1N
         +lqLPk00dzingDd56Hv9titTKpVXpFwAE776c30hRHw5iniuZnrRVWKcrIq9fikKSA5H
         ZpkK7wiAf7sFfL1XwcGG+AKmSEXjVmWx9e9uyoH2MKAXbfB0u2pw+MsLXwqSpaIawBJO
         IGlgakdTJ3h6zjagSWCqYNA/4CI6piSjIIhMQEX6QZYYHRjk4VvmHEX5TCq7HRVb4lGs
         E+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJZl502jJtgYrE13a0vPuMlkdrb5+/0MnbcsdbgpyydoejpYWAE7BEiXWybs4PaQ1Vjx999sa8/t/JG2aQ8Y5ViAGo60eDYcS0J6B5
X-Gm-Message-State: AOJu0YxWFXnJIqj3GxX4igI/c+FlVlDrEWDRi28Oe5EfhkcorqB/S1V9
	tpC4dFgYgXmYAy1s/oaGLRZs82f9zLwvdKkRHsdK/s9LKGdstmgPZ7Y6kqtjoTnpueFAq+KeaUo
	Cpw==
X-Google-Smtp-Source: AGHT+IHpzRjINi4RgXeDk0okBNd4/uQ3D0c3yxLNEYCapSIcyD76PjMgUnylYBuBF7k2pmMR333fig==
X-Received: by 2002:a17:906:4bd4:b0:a3d:994a:791d with SMTP id x20-20020a1709064bd400b00a3d994a791dmr5025546ejv.59.1708962988623;
        Mon, 26 Feb 2024 07:56:28 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id i20-20020a1709061cd400b00a3f2bf468b9sm2568183ejh.173.2024.02.26.07.56.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:56:27 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56619428c41so5889a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:56:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVghL7jt3RrYi4ppRF70Uupt/bsATAX435/H04HT1vTyCVrzM9JaeKax1wnlgw5YToKWsMpVbKDdgehD3xvIWdY2uF64uW1eiuvVGFU
X-Received: by 2002:a50:9f28:0:b0:562:9d2:8857 with SMTP id
 b37-20020a509f28000000b0056209d28857mr330238edf.6.1708962985791; Mon, 26 Feb
 2024 07:56:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
 <20240221-rb3gen2-dp-connector-v1-3-dc0964ef7d96@quicinc.com>
 <CAA8EJpo=9vhM+5YzaFxUoYRuEWQyrMS8wLNPSF3K=bN5JwWyDw@mail.gmail.com>
 <8313a7c3-3ace-4dee-ad27-8f51a06cd58c@linaro.org> <CAA8EJpqFj5nf8d_=Uoup7qg+nQrxqQU-DHbL3uSP138m9AcXLw@mail.gmail.com>
 <8fcb5816-2d59-4e27-ba68-8e0ed6e7d839@linaro.org> <CAA8EJporaUuddHHqpyYHiYSu=toHmrDxSHf9msZUJoym4Nz72g@mail.gmail.com>
 <20240222150423.GI2936378@hu-bjorande-lv.qualcomm.com> <CAA8EJpqd=1KV_dN8AURQDcFDDyO+YtbC59gM7ftt+HohGM93hg@mail.gmail.com>
In-Reply-To: <CAA8EJpqd=1KV_dN8AURQDcFDDyO+YtbC59gM7ftt+HohGM93hg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Feb 2024 07:56:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XJVFX-GkL-wiAoi=r6tdiDHkJ_aFSpx6FE6+gFT5xJjA@mail.gmail.com>
Message-ID: <CAD=FV=XJVFX-GkL-wiAoi=r6tdiDHkJ_aFSpx6FE6+gFT5xJjA@mail.gmail.com>
Subject: Re: [PATCH 3/9] arm64: dts: qcom: sc7280: Enable MDP turbo mode
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 22, 2024 at 9:32=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 22 Feb 2024 at 17:04, Bjorn Andersson <quic_bjorande@quicinc.com>=
 wrote:
> >
> > On Thu, Feb 22, 2024 at 11:46:26AM +0200, Dmitry Baryshkov wrote:
> > > On Thu, 22 Feb 2024 at 11:28, Konrad Dybcio <konrad.dybcio@linaro.org=
> wrote:
> > > >
> > > >
> > > >
> > > > On 2/22/24 10:04, Dmitry Baryshkov wrote:
> > > > > On Thu, 22 Feb 2024 at 10:56, Konrad Dybcio <konrad.dybcio@linaro=
org> wrote:
> > > > >>
> > > > >>
> > > > >>
> > > > >> On 2/22/24 00:41, Dmitry Baryshkov wrote:
> > > > >>> On Thu, 22 Feb 2024 at 01:19, Bjorn Andersson <quic_bjorande@qu=
icinc.com> wrote:
> > > > >>>>
> > > > >>>> The max frequency listed in the DPU opp-table is 506MHz, this =
is not
> > > > >>>> sufficient to drive a 4k@60 display, resulting in constant und=
errun.
> > > > >>>>
> > > > >>>> Add the missing MDP_CLK turbo frequency of 608MHz to the opp-t=
able to
> > > > >>>> fix this.
> > > > >>>
> > > > >>> I think we might want to keep this disabled for ChromeOS device=
s. Doug?
> > > > >>
> > > > >> ChromeOS devices don't get a special SoC
> > > > >
> > > > > But they have the sc7280-chrome-common.dtsi, which might contain =
a
> > > > > corresponding /delete-node/ .
> > > >
> > > > What does that change? The clock rates are bound to the
> > > > SoC and the effective values are limited by link-frequencies
> > > > or the panel driver.
> > >
> > > Preventing the DPU from overheating? Or spending too much power?
> > >
> >
> > Perhaps I'm misunderstanding the implementation then, are we always
> > running at the max opp? I thought the opp was selected based on the
> > current need for performance?
>
> Yes. My concern was whether the Chrome people purposely skipped this
> top/turbo freq for any reason. In such a case, surprising them by
> adding it to all platforms might be not the best idea. I hope Doug can
> comment here.

Thanks for thinking of us! In this case, I think the only users left
of the sc7280 Chrome devices are folks like Rob and then a few folks
on Qualcomm's display team (like Abhinav), so if they're happy with
the change then I have no objections.

In any case, I'm not aware of any reason why this would have been
skipped for Chrome. The Chrome devices were always intended to support
4K so I assume this was an oversight and nothing more. ...of course,
as Abhinav points out Chrome devices are currently limited to HBR2 + 2
lanes DP so they can't go 4K60 anyway.

In any case, in case it matters, feel free to have:

Acked-by: Douglas Anderson <dianders@chromium.org>

