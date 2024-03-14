Return-Path: <linux-kernel+bounces-103117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F5087BB40
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E89BCB22E06
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE84A6EB49;
	Thu, 14 Mar 2024 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDxU1XBo"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407366E616
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412203; cv=none; b=W5/dM9DEO0XdMQ1IODa/GHoZpPSDqIQrp8ftX1rQHJZXtOVzatNUakO9XCt2h5Pxlb0HR8CVdh/UCPXbeF7eZ03drJGQWmpscvM0RBkAbnVxKbVAqvxN897c53lMsJJSdOVmR1olV8e2hCPJJk708dJQH8gfoNQQDiOlYr4RZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412203; c=relaxed/simple;
	bh=l85vnkr5IVShaY0q/S02bkIi9AiEbiKbWt69y83fl00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHAI2OsNyoiN3AHyOLjT+zpH+4TwhF6puMYdli98G0eK35kl0hCGIr5umxEm6DwbC6op495SR4mlhcJdSBzfedXo3k11SyI2gFHqtf7DzZKZs0vjVtMjzYD2AfUVH607nTcViIriR4OA4OHSGqNvHIiyR1TuMPIFwi6AiPhNLk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDxU1XBo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a45bb2a9c20so73023566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710412201; x=1711017001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcGu0HbVhJ43nJUYs2HgED0p2686qNZu20aPF6xMbD0=;
        b=tDxU1XBo8Yy3CGE41rhPNSftVACrFGazPrIt3QB9KNqkNRFwR8qPf2sKC8Yu9vGvYo
         7MZAg9u6twmvy2pht4oFXxquE67+Y0wGbVqy7Ijkq6NdOHoyXHJFCA4hLLnk4IKmBk6P
         DVwaEMHzE7blXcii4HuW2aArMm8yZ3Ptt8yEy0fOeDZwAjEHd0hWmY65MzEdfwyQMUj5
         VoyX4N6dWvjp05Dh1xP1FO3D9Yovfv8v9vduIw71RH5QIPxRJyWBWGenELH25dJ+OnJ7
         xdM69HwdQlCznhgf0sBJyFIyQdCvzJw24QObFzj6+MDGF6ugnJcqfZrYa3wOtu4Jcn1f
         J3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710412201; x=1711017001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcGu0HbVhJ43nJUYs2HgED0p2686qNZu20aPF6xMbD0=;
        b=Pnewq2/+7gGuRLdsdToXuf4K1VwvMxMj8zERH1b6JoEUgnAnSeFoXxwQWPd442g+q8
         4x8gRvaAy7hWT943Nn6Wt/Rt6RH/fQafN/4F2qBIVZxErmyoIz8czjv1eiHSGqLL3Wk/
         q/Q48CBkFUmFZpcmBb07yI51pX0+cGLKhLaw6fBiexqm90FVeY8/06XRSDXKR/Ww9ytV
         t0ZqyqahQ03NU0GepT3VTNG0z7Ra8HxUy7NaGWBzpQAs+92d6oCWBbvWfiNLM4DydCAr
         0L0SZm5dIYxq6EBTILJlzMOPZR9yakMUk4SHahSeqq1OhFFghvPfCmAOJBuj4u78275Z
         L8wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVdktelXiK+TOiwGJNRYuk4E05hYt67TiXaAWuB61UeHGX6N8xajq8ObSxH83HD8AYk5hB9fd5Z+Kx2Wj10VXdslPzjY33laS0UbBD
X-Gm-Message-State: AOJu0Yz/jh6ox7le7ViIUE8O04drV4mYJQenDoImBE9xIGFkuMidpiKt
	mFMqkiYUPLjgUXnB9f5ergLEUf/DKg+G4BvH3JmaZ/pzDLo1b4DF0NfdCIRz+QKXsnd2eS6B3Sh
	nV8JPeXJDcZBq1cfSdWyBfDJJ6ICsZckHvsCI
X-Google-Smtp-Source: AGHT+IGON9Se+9pz19hDr8yNzBsEwejkS9/dMYiC1+kL2sDCzCuSpkLFSJJXHnc5NytKjijIcb1mX2sR+v6mI2ND08I=
X-Received: by 2002:a17:906:99d3:b0:a46:749b:58a with SMTP id
 s19-20020a17090699d300b00a46749b058amr784155ejn.57.1710412200434; Thu, 14 Mar
 2024 03:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228013619.29758-1-quic_wcheng@quicinc.com>
 <20240228013619.29758-21-quic_wcheng@quicinc.com> <CANqn-rjTgHgzssxZiuwvTKzOS31wzjS4Y9G-XacZN4a7c82MaA@mail.gmail.com>
 <d97f635f-053b-70a7-5ffe-a1ae273091d1@quicinc.com>
In-Reply-To: <d97f635f-053b-70a7-5ffe-a1ae273091d1@quicinc.com>
From: Albert Wang <albertccwang@google.com>
Date: Thu, 14 Mar 2024 18:29:47 +0800
Message-ID: <CANqn-ring2uf=A-F7VuRwnJ--n=FtFzSddCmR-=nfxCGcFAF2g@mail.gmail.com>
Subject: Re: [PATCH v18 20/41] ALSA: usb-audio: qcom: Introduce QC USB SND
 offloading support
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, mathias.nyman@intel.com, perex@perex.cz, 
	conor+dt@kernel.org, corbet@lwn.net, lgirdwood@gmail.com, 
	andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com, broonie@kernel.org, 
	bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org, 
	konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-doc@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 3:18=E2=80=AFAM Wesley Cheng <quic_wcheng@quicinc.c=
om> wrote:
>
> Hi Albert,
>
> On 3/13/2024 1:03 AM, Albert Wang wrote:
> > Hi Wesley,
> >
> > The suspend function `qc_usb_audio_offload_suspend()` looks to stop
> > the traffic on the bus, so that the bus can be suspended. That allows
> > the application processor(AP) to enter suspend. There is a subtle
> > difference with our feature, which is to allow AP suspend with the
> > Host and USB controller active to continue the audio offloading. We
> > call this feature `allow AP suspend in playback`. So, I have some
> > points to clarify with you:
>
> Yes, I'm aware of that feature also.
>
> > 1. Will the suspend flow `usb_audio_suspend() -->
> > platform_ops->suspend_cb() --> qc_usb_audio_offload_suspend()` be
> > called when offloading is active?
>
> It can be.  This is why in our case, we are going to issue the
> disconnect event to the audio DSP to stop the session if it is currently
> in one.
>
> > 2. As my understanding, the suspend function is to allow AP suspend
> > when the offloading is IDLE, but it won't allow AP suspend when in
> > playback or capture. Please correct me if anything is wrong.
>
> As mentioned above, it will let apps go into PM suspend after forcing
> the audio stream to be idle.  We won't block PM suspend entry.
>
Right. Your design is to force the audio stream idle, or say, inform
the audio DSP
to stop the current offloading session first, then AP can go into PM
suspend as usual.
Then I can say the current design did not support the `allow AP
suspend in playback`
feature, right?

> Yes, I saw that patch as well.  I'll take a look once this series lands
> upstream.

That patch is rejected and archived now. So we need to find another
approach to do
that, even based on your framework.

Thanks,
Albert


> > 3. We would like to integrate the `allow AP suspend in playback`
> > feature with your framework to become one upstream offload solution.
> > Here is the patch:
> > https://patchwork.kernel.org/project/linux-pm/patch/20240223143833.1509=
961-1-guanyulin@google.com/
> > .
>
> Yes, I saw that patch as well.  I'll take a look once this series lands
> upstream.
>
> Thanks
> Wesley Cheng

