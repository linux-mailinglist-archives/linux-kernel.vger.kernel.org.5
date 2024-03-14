Return-Path: <linux-kernel+bounces-103491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AD787C02F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E6C1F2366A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAEF71B50;
	Thu, 14 Mar 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n5glVOxG"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C7C71B39
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430176; cv=none; b=VhgS0fNHvpt1Lj54tddEUjQx+JfkS+GL8iMJ4byY7ia2pSRz4rgYafd6hpbUiYB88EcDsbcxKg23CagiCZ2O2Ixn66ivGUDnIPxcD08yOImqWRteUfHXi70Y7t+wuxXcuFsKibVZ0HDlFLkcLaKV8SROOgn8UzdlQVXssFlHuws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430176; c=relaxed/simple;
	bh=BK5vGjzgLHTG5Uy0fF+PO/iDPbQ/wrXrAZUSjAUJ9iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PW0bOMt+q0oUYIsiJwTpGMkPXwHDZY/0QSmq1jddHI4r7gLi5efoTfiIHKhR6v7wY54MFFXVWQ8fn8NbJy7SbWSNEmNpgB/YuNI9OZDdlZGEuZWoE06Czrl35H5+mcobMFfoz2b8vY2P5UI75rX7n7BeeYkHzdIVLt62luQ4e9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n5glVOxG; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-690b100da62so7918366d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710430171; x=1711034971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuhQc5l9apEej2H4LOTY9yaoxPUBJy/wLmmpg/Pkruk=;
        b=n5glVOxGsnctw/5jZnWEKcMdDcXqTWHRBa+sWfvNfJ+BO8d4+frFSRW/QA/2Qx3Ke9
         hUJM+itue+MdCyOai+U8nHCVqLpmtrBA6Y58DQw8e2OLKuHDVhX0prB4IQzsK6qa/aa1
         NJeQkjVjrrjdlINJwe2W6E3IJ39d4ZOE+Rh4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710430171; x=1711034971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuhQc5l9apEej2H4LOTY9yaoxPUBJy/wLmmpg/Pkruk=;
        b=a5O4rAKys7mTV9BbEWX9ZQSIi6Di2rJvOtAJUajR6xNG+yQ+krHTQO9U0bqBb88SbW
         rGk5/CsE/q3ot8yYndxPQ8OE11mScBBd+cYiDXVznpjEm1Mxedn+s9jqs97VNYXN4BSV
         AW4Xi2DU0QXqGpzkRAR7Qo3spdPMJx67IGzU5V5+XAn1vZhemFrJIJL2pb3hb7J+6eih
         Bpv60YGCZNx4+wIxFhbN8pOVZmFIYIfeXOBME6yvT/wLqrOThTZn3tlouBYb2blq2Rbr
         /1ipb2NGc2DqEW0tVRdSB7RRSpns65hg7rD/t19DbbJAxiCIdOEJrcsSCyze1eadpnzg
         Y1ag==
X-Forwarded-Encrypted: i=1; AJvYcCWHH6l/CyXOKpj2cnCGidK0k27TylzZzlglwrMhX5TB2PIZfZuSiOFvj3rWq36UsciwyVO2KoHr3eM6yTF4HzAqYX4MwJIRD3HU5yCx
X-Gm-Message-State: AOJu0Yyn8y+a+O525TUwvJ7DNqhl7od8xlfVOjYIJhGm3dOQXAgPBDdA
	elgLoHsWMhlq53olE18JIGPSxTSkyzKNPszgoIlvLGsbV409XpehuzWP3AlidSE6ASqCNar79Yt
	xSA==
X-Google-Smtp-Source: AGHT+IEyhH92nJ8+0yKJ13z7VTQAtKhf6ZpwXpB3lh0j4RKQiQx/ruh8/h2qK4X2dP6t9c9PYOAujw==
X-Received: by 2002:a05:6214:4c0a:b0:690:ae50:780b with SMTP id qh10-20020a0562144c0a00b00690ae50780bmr2006647qvb.34.1710430171449;
        Thu, 14 Mar 2024 08:29:31 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id gi6-20020a056214248600b0069068161388sm576787qvb.131.2024.03.14.08.29.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 08:29:30 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43095dcbee6so324231cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:29:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQV3wnuxULHtyiCLAWqjZi2XyDReltfBtLKWFcN3/Tb71hbuo0F3rpIKEl/y1cWv5dIK+oJcsCcPhhhejzZf5OjeG8+BGar16xck2V
X-Received: by 2002:ac8:474e:0:b0:430:90af:43c3 with SMTP id
 k14-20020ac8474e000000b0043090af43c3mr272846qtp.21.1710430169466; Thu, 14 Mar
 2024 08:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307093727.1978126-1-colin.i.king@gmail.com>
In-Reply-To: <20240307093727.1978126-1-colin.i.king@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Mar 2024 08:29:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XQ5XBT4Jt6VUgVqxsn7NQZjDCTRFOFk5Fr+Fxkpv55SQ@mail.gmail.com>
Message-ID: <CAD=FV=XQ5XBT4Jt6VUgVqxsn7NQZjDCTRFOFk5Fr+Fxkpv55SQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/msm: remove unused variable 'out'
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 7, 2024 at 1:37=E2=80=AFAM Colin Ian King <colin.i.king@gmail.c=
om> wrote:
>
> The variable out is being initialized and incremented but it is never
> actually referenced in any other way. The variable is redundant and can
> be removed.
>
> Cleans up clang scan build warning:
> drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:843:6: warning: variable
> 'out' set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 3 ---
>  1 file changed, 3 deletions(-)

Tested-by: Douglas Anderson <dianders@chromium.org>

