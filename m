Return-Path: <linux-kernel+bounces-106573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A72D87F07E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00931F21F86
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224E356B65;
	Mon, 18 Mar 2024 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GYZqPjFR"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69681E4AD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710790676; cv=none; b=A/jA1925PWAu5KFFTr9LjYXGHbld/kXqLEBFlX1YVcDmvs5OVgPXcHZ/4UxBBkCQCoPWhWXXhcyCDk7Q+hS+mrIJ34Tww12vNS2IUG/WWSe6NlYYSGK6GAuGAINsIKK9GOaf9EgEkUz7wgZYT0rFxRaW59srYke1Z52kCRc0MFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710790676; c=relaxed/simple;
	bh=CI084V8cwdZvQyXNROxkn3IbY00cnN+dX3japdJLysk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xym2nrLbHZzeugjkS91aWMDpmPIGU5nTFJJP471zkg7tZZOd7gUMUlMI1BKOOs7XDEoOLb84B4G4ZU+7h02GhLgMm4hMMI5oIynYPKgNsBcpI19PdptDjkug5svwo8b9niQiFsUyahETFU5efXAPS6LO7FwKhdHIEYj1+pOiAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GYZqPjFR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-787edfea5adso194830385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710790671; x=1711395471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI084V8cwdZvQyXNROxkn3IbY00cnN+dX3japdJLysk=;
        b=GYZqPjFRNBcpSDja7aDpyZw8eNzJGQo/CqcRmMaUCTarn/3p2GI1bHa6U1+BGDPHOn
         Ppy2yPUvLf2EXFtEAhUj2VyHGX+X0KoHm4F/MuQqvTLK4fCNnqQXmFpb+28wOQDuI6hX
         ECGsq+XKyul2jZbLP92b3A4Pc+w57Yi0HMijk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710790671; x=1711395471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CI084V8cwdZvQyXNROxkn3IbY00cnN+dX3japdJLysk=;
        b=rlfjZFkXXPxu3IJ6SYx2CqDJr/S+XKKQEY94sQqBnQEKYwQVIpuIr7ZW9NrX05XhIq
         Rg53orIFvWaKioPsAG2FPPk32L1FPzadZtoZTxB5dAlKS4Pz96ADG7T7brKEcn2LJght
         mr6te6I9uTTdQPv0F8Uv1GLu9zJQmJjIMek+zQU2TgWXDrRwUCneswYcIsBVNp72CkSd
         rwajfGAS9hbYTKMCfXbiMQikJo9q2w3+z4wKEo26GzEj3b/eShyDQGEBuQFtqMCVQeRu
         0fSSkF3LFTibrdYMTadGKnbb5tFOOOraxgnl9aH7+89lzTJiunYmqFBJej8s84iFKKmT
         Elzw==
X-Forwarded-Encrypted: i=1; AJvYcCWvR7m2eGd8iwp6+GObNo69ncXeKo/xSygzOcz3bvqvw+0HupXU5RcKoh/PX/Nv8B55fHlRnWwug7ew6uQM7OOHFyjlIu32RkZtb/vW
X-Gm-Message-State: AOJu0YxuH4vdMvEfVEvdaDkOXMQmr/wEt0edIQgNQdIw9CnyHb3r/MWr
	i3W3vtWkqTcHrQM3zUH3NOXEQ1QSoRsMs8Hriqg1odu1N7FrAHnuiZSOhFn3dQNNk5bhWBMxoMY
	=
X-Google-Smtp-Source: AGHT+IHlMuHeznwojU7FvPovnsvJljhjYnAkgmks+XTqESSEYlrUro7gXi1vkl+Xfi+N+H95oPIqfQ==
X-Received: by 2002:a05:620a:25d6:b0:788:2f37:e7ff with SMTP id y22-20020a05620a25d600b007882f37e7ffmr13722507qko.32.1710790670926;
        Mon, 18 Mar 2024 12:37:50 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id e1-20020a37db01000000b0078a07fc259csm610411qki.40.2024.03.18.12.37.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 12:37:33 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42ee0c326e8so45761cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 12:37:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkvp0zj4dMm6ZscC1E2XGD32HfyPqGx/ll2Umf1mSsmQ0eQfps1qtfHRbGUjY8kpI8I8RWbqHZ+ZCVtxSEgP5CvW6LAmIiyEIQO+md
X-Received: by 2002:ac8:7fd0:0:b0:430:9ee1:a8 with SMTP id b16-20020ac87fd0000000b004309ee100a8mr5892qtk.3.1710790652484;
 Mon, 18 Mar 2024 12:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315213717.1411017-1-dianders@chromium.org>
 <20240315143621.v2.4.Ia5dd755f81d7cc9a4393c43f77b9be4ed2278ee3@changeid> <CAE-0n51baqN8cEubSqDegqDwL7O6=iEfN5Ho2OykqjmkjQDcvQ@mail.gmail.com>
In-Reply-To: <CAE-0n51baqN8cEubSqDegqDwL7O6=iEfN5Ho2OykqjmkjQDcvQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Mar 2024 12:37:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+kD852eCOxeJ97_483FMCXBZn+eaPPyb2VrXiGm6V1g@mail.gmail.com>
Message-ID: <CAD=FV=U+kD852eCOxeJ97_483FMCXBZn+eaPPyb2VrXiGm6V1g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/msm/dp: Fix typo in static function (ststus => status)
To: Stephen Boyd <swboyd@chromium.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Rob Clark <robdclark@gmail.com>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Sean Paul <sean@poorly.run>, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 18, 2024 at 12:26=E2=80=AFPM Stephen Boyd <swboyd@chromium.org>=
 wrote:
>
> Quoting Douglas Anderson (2024-03-15 14:36:32)
> > This is a no-op change to just fix a typo in the name of a static funct=
ion.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v2:
> > - ("Fix typo in static function (ststus =3D> status)") new for v2.
>
> This was sent at
> https://lore.kernel.org/r/20240306193515.455388-1-quic_abhinavk@quicinc.c=
om

Whoops! I guess we both noticed it at about the same time. My patch
should be dropped then. The rest of my series (patches #1 - #3) are
still relevant. I won't repost them since they can be applied just
fine even if this patch is dropped.

-Doug

