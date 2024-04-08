Return-Path: <linux-kernel+bounces-135189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E421A89BC78
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214971C21937
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D518E524DB;
	Mon,  8 Apr 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/DMP6Jz"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDBC524BB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570314; cv=none; b=IYBispJxxosxy9jKvcDA0AmY5jaJz/Z4qOH/zRBsPf6pET+4SwvHDH0Ue+WCjr9rL0INRNDMgn9krUNs0YwsNoi33t5jtU9nQLUoWz/V9t1fGTwtd/uS43T1Pqz1DKKFa+bpoUjfet2y7XSLDnFdwL3R1e6EnIS1JJBLQQV/Zto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570314; c=relaxed/simple;
	bh=d8iO44D0OGPnCeyLspFgpHLjdLZswRNPTGmqk2q0quc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Faa5XJUckXeCLign36hP7bGuOa+eZ8aCV6b4MJX6fVN+dlyBM0a14h5epzNNUTTPcu1e5UrEeLpoy35cKLKMM1c2MkVKzxDFLfhahxAgO6OIDZE4eSy7BejGODJhdgtOQ3WqpjyYEXlMeN6CznHj0WvkiCkh6NDiFQ804b6PbFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d/DMP6Jz; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d717603aa5so50717421fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712570309; x=1713175109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hOCibkj9n2YGDsJnfwHwezgEyxL9relr5LeEYsYkEw=;
        b=d/DMP6Jzq9s6RaU/8ZwGS9BReJ3GVBu6Qa25bqP6GHxWlVwCuJjfGbQQWcH5y+TAGo
         AsDKWJm56CRbcZd8xjqrouiSs8r9CYNz9w13IX6W92SL66Q3KyyiSQomc0t4Pb5+3zaj
         Aw1SePoBf3Uvt8FLx66Dh8g6Eh241/1Qfuerml0coW1/2Uwcs+L4gqQTZReP2mxHaxt8
         9Ik15Ihvmi4R6xhXS+K8tohOjyibahdO2H647ZULgu9sCdLXB2dqmdcfuTjUzwtOuar0
         iuwifBBWZ7bqVREBvgj88ROn08xNx+NM0T+hZ7R1HkohWfcdREoSpj/ueCL29A5R/DJI
         p0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712570309; x=1713175109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hOCibkj9n2YGDsJnfwHwezgEyxL9relr5LeEYsYkEw=;
        b=ORlntpCqQr/soq6adKOz0U08+xE5GqAgLDd9P76wWpslZ8zEUkuCR37cVmY0CQNA/m
         T4IaZHvQHPVG18RkopfXzf8Gl5G5s5JtRTpDEnLMugYILiAnZlH43ZnUJbEf6X7gPgF7
         S391WrDIUGyCNYUtiw/IKv7tmpI6UnAcKJWJdTTBLLe5ec2YP8f6Rx5ySeLeffQ3qevf
         DqyrfFj268QN/vXjROREI2PvkEt9k3f0EKTXCIU7oQ3QOrzZG7ema/6lwaJm9bDDdXk8
         MmyGJMDkUA5f0Gu4o/AY27aLxNz6IMVL0sBHkLPZHFoQOdU6isa+IFBz7XW3X5frn2RF
         ER6A==
X-Forwarded-Encrypted: i=1; AJvYcCVVsWzNsMT0n4AEM5QBGTZnLvp1wr+d6O4M0YBUkT40TlsR0kWv73ylGMr+N8Ftj3SzEj0RZhzjzhLr7o9qadL657v21awSiZunPquM
X-Gm-Message-State: AOJu0Yy1UiUkMe5OSPBflSLiDd4NjuOW4CFAwpntOeec+ivIVQ9DBRXb
	7Cd9lJM2Bz7x+mSqf8Y6UDvQlwhP1YkggF5lW9xEqy+T4vjLqESn1BJqD90DJGL4cWTXNmGQqni
	LPDCYSTN60arbIC5P0fkSg6xSVf2cq3opdcAcyQ==
X-Google-Smtp-Source: AGHT+IF5c4jsXWpkr+/3vLya5n3g4BNibhFwlejcq2PyVJvdHniMxg/DIX5Gp4G6Yhf4NEEvzMeFaVsCDgpIQ9cZjiw=
X-Received: by 2002:a2e:97d6:0:b0:2d8:274a:db16 with SMTP id
 m22-20020a2e97d6000000b002d8274adb16mr5817920ljj.17.1712570309500; Mon, 08
 Apr 2024 02:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
 <20240403-msm-drm-dsc-dsi-video-upstream-v1-5-db5036443545@linaro.org> <CAA8EJprCf5V7jcR2XCkpkTtRr5f1beHKksL8PJJB_10EDLXEMQ@mail.gmail.com>
In-Reply-To: <CAA8EJprCf5V7jcR2XCkpkTtRr5f1beHKksL8PJJB_10EDLXEMQ@mail.gmail.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 8 Apr 2024 17:58:29 +0800
Message-ID: <CABymUCODHQ=bobQNhttY-RqLDjEGf75yAm2YD--ZnfXjAtzNMw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] drm/display: Add slice_per_pkt for dsc
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B44=E6=
=9C=883=E6=97=A5=E5=91=A8=E4=B8=89 17:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 3 Apr 2024 at 12:11, Jun Nie <jun.nie@linaro.org> wrote:
> >
> > Add variable for slice number of a DSC compression bit stream packet.
> > Its value shall be specified in panel driver, or default value can be s=
et
> > in display controller driver if panel driver does not set it.
>
> This is not a part of the standard. Please justify it.

Right, I read the standard but did not find any details of packet descripti=
on.
Looks like msm silicon support tuning of number of slice packing per downst=
ream
code.
The slice_per_pkt can be set in the downstream msm device tree. And I test =
the
values 1 and 2 on vtdr6130 panel and both work. So I guess this is related =
to
performance or something like that. I will have more test with different pa=
nel
to check the impact.
drivers/gpu/drm/panel/panel-raydium-rm692e5.c also mentions to pass new val=
ue
to slice_per_pkt.

Hi Konrad,
Do you remember why value 2 is TODO for slice_per_pkt for panel rm692e5?

>
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  include/drm/display/drm_dsc.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/drm/display/drm_dsc.h b/include/drm/display/drm_ds=
c.h
> > index bc90273d06a6..4fac0a2746ae 100644
> > --- a/include/drm/display/drm_dsc.h
> > +++ b/include/drm/display/drm_dsc.h
> > @@ -82,6 +82,10 @@ struct drm_dsc_config {
> >          * @bits_per_component: Bits per component to code (8/10/12)
> >          */
> >         u8 bits_per_component;
> > +       /**
> > +        * @slice_per_pkt: slice number per DSC bit stream packet
> > +        */
> > +       u8 slice_per_pkt;
> >         /**
> >          * @convert_rgb:
> >          * Flag to indicate if RGB - YCoCg conversion is needed
> >
> > --
> > 2.34.1
> >
>
>
> --
> With best wishes
> Dmitry

