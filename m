Return-Path: <linux-kernel+bounces-116742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F37E88B0D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78099B334D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D11115821B;
	Mon, 25 Mar 2024 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jtqSLe7T"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD75384D1E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711358770; cv=none; b=k+qRqTIqWxz9ZeeW1tYPSf9+GFum2x+jtMSDPXQ/Y2uNr+ehFs5Wqi4XCqJbtKSLKhy4XgaxPlDOKIcIxUOXe3xDOiTAztDW1pffQj77MyWQOjPSvTeoyi9gKgzGEa627tC4hWxWy/0QlC/C0CyPkmLLMJNH9am1ZB1R+A+Ryag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711358770; c=relaxed/simple;
	bh=+UtR0NT011zyBW6pNpHFzKilg63ytC5qO0zyrg10zGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/BgEIaS/0QTx+ZbHk2YztCvxhvBjNduPhFnd8n52fbPlYjQJJN84xUgWSOYSoKV4lg4I4tAtnDjR6mhhmMnAYrwrCd0Me61IlJvC+LAcvzrtwNtjjpieBD80xHZXpyxd1Yw9LFayqE2eMJjmC3YOsK9KRhzAdsNli6wyyLQgHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jtqSLe7T; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78a4708a557so124487785a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711358767; x=1711963567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UtR0NT011zyBW6pNpHFzKilg63ytC5qO0zyrg10zGA=;
        b=jtqSLe7TaoJ/+V95xYpsB2A0CsojuHZsyifgC9A1KziLR5q8QBrJ1FVCnDwjC2nNkt
         R/tYmPSHVlKm9qfWolfVippLSDsEDgnynRbQiX7cQEwnlbawMOqKKzMYC0R/ubkNkZ1y
         PldBya+Wu/dXmMZOUMbrgzZSu0ePeU6j3y8i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711358767; x=1711963567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UtR0NT011zyBW6pNpHFzKilg63ytC5qO0zyrg10zGA=;
        b=aP05ec65OVirWQtdOr89IPiNaEgPgVHFNkizCRA+DbBECJ5585+hQxcVdZ8xFCiitz
         9pU27txNa5QO0vZGlq25xvRUuWEQrwrmsF4kMwoCgzQMXp0zES91QAu7s+pnEW2kYZ+f
         pgDeBcJaO3VGmTzoGRA6emOiATnkMGe7BL/Xj1871D86n2GPDsWj0xqJmeLzxSmTfpB/
         VV9eb07Sj/IbZu1OexfHYDPle0Vd3X3atmDkqEoqpltt+8QjbAk0kl8Em+tyO9ypQTSc
         +BwJJdQMA3iSvG586uQz8aCsWVny81Js6fjR2CJynbGp0ZRXV6WkMoW9UiSL3fYoOR9k
         zcfw==
X-Forwarded-Encrypted: i=1; AJvYcCU5yqcg69exT/I2nSuGoLHyp3JfCPNxV4u4mQx6ls1YJlvq/ToSQjrG87oFMzPYge3sVWuh2BEGQcmdtOQvm17G2ZFJBo8kg6wYO5f5
X-Gm-Message-State: AOJu0YwXOGi1Fenjpfp4APuxK0rczTEM2bZ8q354m14VC1rAtmJqtVsn
	zmYNiy5VOPZdTqANELrG/3RvygmsJzKpDrrlv9f6YbLQKtAUhjNW9ZKYDOgqSpXEVPrXyIB7u7H
	qxw==
X-Google-Smtp-Source: AGHT+IGk819OfMzhnUCGtilf6jGWlK72Dfm4MyeBcL4Fcw/aWH+7PkAiQ/mj1HdR5Ey43ZqwcVOhZg==
X-Received: by 2002:a05:6214:3002:b0:696:8e81:77bb with SMTP id ke2-20020a056214300200b006968e8177bbmr3277183qvb.32.1711358767211;
        Mon, 25 Mar 2024 02:26:07 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id eh12-20020a056214186c00b0069183a8de64sm3898362qvb.75.2024.03.25.02.26.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 02:26:06 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-690c1747c3cso31436586d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:26:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsVPuLjWukVzc05fAS6LwPtsY7lA1+00QytqYxa77YXBOFGG+IzHy8wnplmcbByGCsjpnIO7UCHx+149sCXmQLr2j3roKReegB5BuU
X-Received: by 2002:a05:6214:2465:b0:68f:f859:ee06 with SMTP id
 im5-20020a056214246500b0068ff859ee06mr11514858qvb.12.1711358765850; Mon, 25
 Mar 2024 02:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240323-resend-hwtimestamp-v10-0-b08e590d97c7@chromium.org>
 <2722561.mvXUDI8C0e@natalenko.name> <CANiDSCsnOdTaW0Eg68+-niPXwPhYc3Br6cWoGiHytZrFOGmcZA@mail.gmail.com>
 <12403186.O9o76ZdvQC@natalenko.name>
In-Reply-To: <12403186.O9o76ZdvQC@natalenko.name>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Mar 2024 10:25:51 +0100
X-Gmail-Original-Message-ID: <CANiDSCuma7aGxq7T2uYMgn_JEW223LdR4as83UT2Aj3QmVu4ig@mail.gmail.com>
Message-ID: <CANiDSCuma7aGxq7T2uYMgn_JEW223LdR4as83UT2Aj3QmVu4ig@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] media: uvcvideo: Quirk for invalid dev_sof in
 Logitech C922
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oleksandr

On Mon, 25 Mar 2024 at 10:23, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
>
> Hello.
>
> On pond=C4=9Bl=C3=AD 25. b=C5=99ezna 2024 8:52:57, CET Ricardo Ribalda wr=
ote:
> > Hi Oleksandr
> >
> > On Sat, 23 Mar 2024 at 13:16, Oleksandr Natalenko
> > <oleksandr@natalenko.name> wrote:
> >
> > >
> > > How do I check whether C920 (046d:082d) is affected too? I have got o=
ne, I can run tests on it as long as those will not blow the webcam up.
> > >
> > > Thanks.
> > >
> >
> > First of all you need to enable the hwtimestamps in the driver. You
> > could do that with
> >
> > ```
> > rmmod uvcvideo; modprobe uvcvideo hwtimestamps=3D1
> > ```
>
> ```
> $ cat /sys/module/uvcvideo/parameters/hwtimestamps
> 1
> ```
>
> > Then capture some frames with yavta
> > ```
> > yavta -c /dev/video0
> > ```
> >
> > After around 5 seconds all the frames should have a stable fps, the
> > fps is not stable then your camera is affected with this bug.
>
> ```
> $ ./yavta -c /dev/video1
> Device /dev/video1 opened.
> Device `HD Pro Webcam C920' on `usb-0000:0f:00.3-3.4' (driver 'uvcvideo')=
 supports video, capture, without mplanes.
> Video format: MJPEG (47504a4d) 1920x1080 (stride 0) field none buffer siz=
e 4147200
> =E2=80=A6
> 100 (4) [-] none 100 200717 B 212.919114 213.079004 33.727 fps ts mono/So=
E
> 101 (5) [-] none 101 200889 B 213.003703 213.114996 11.822 fps ts mono/So=
E
> 102 (6) [-] none 102 200926 B 213.035571 213.146999 31.379 fps ts mono/So=
E
> 103 (7) [-] none 103 200839 B 213.067424 213.179003 31.394 fps ts mono/So=
E
> 104 (0) [-] none 104 200692 B 213.293180 213.214991 4.430 fps ts mono/SoE
> 105 (1) [-] none 105 200937 B 213.322374 213.247001 34.254 fps ts mono/So=
E
> 106 (2) [-] none 106 201013 B 213.352228 213.279005 33.496 fps ts mono/So=
E
> =E2=80=A6
> 168 (0) [-] none 168 200914 B 215.183707 215.347066 33.676 fps ts mono/So=
E
> 169 (1) [-] none 169 201141 B 215.271693 215.379066 11.365 fps ts mono/So=
E
> 170 (2) [-] none 170 201005 B 215.303449 215.415057 31.490 fps ts mono/So=
E
> 171 (3) [-] none 171 201195 B 215.335295 215.447062 31.401 fps ts mono/So=
E
> 172 (4) [-] none 172 200933 B 215.557731 215.479072 4.496 fps ts mono/SoE
> 173 (5) [-] none 173 200973 B 215.587033 215.515063 34.127 fps ts mono/So=
E
> 174 (6) [-] none 174 200698 B 215.616811 215.547063 33.582 fps ts mono/So=
E
> 175 (7) [-] none 175 201290 B 215.646196 215.579075 34.031 fps ts mono/So=
E
> 176 (0) [-] none 176 200807 B 215.675857 215.615073 33.714 fps ts mono/So=
E
> =E2=80=A6
> ```
>
> Does the above mean the webcam is affected?

Looks like it.... could you try applying this patch and run with

rmmod uvcvideo; modprobe uvcvideo hwtimestamps=3D1 quirks=3D0x4000

to see if that fixes it for you?

Thanks!

>
> Thank you.
>
> >
> >
> > Thanks!
> >
>
>
> --
> Oleksandr Natalenko (post-factum)



--=20
Ricardo Ribalda

