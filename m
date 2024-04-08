Return-Path: <linux-kernel+bounces-135190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF6689BC7C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5A72837EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C7952F63;
	Mon,  8 Apr 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnFlnxVH"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC0952F62
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570363; cv=none; b=eufhAulOaB/eW9sfKbeKZxKb3Mj8YCOtcJIElalsQolPAwpASq9Hf6Q9F5QgC7UbcW5jcmJZ7nfSb8EFK8nXR2D1ruVD4Fu1X9JRXkrUod4B3X4UJ+uLrrD1noJCRnzDGmUCwX62dLyg/izL7dRrWiZKB56S59RSeA9xO7Vt1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570363; c=relaxed/simple;
	bh=P9KvZdO6slCJDjFtM9O7W2ol2wm72dfbTBqp5WmjxYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUmIoD2Ti+QISqlbyC/p9vuTDbl2ifpUnMsaq4RdbNTLEvylm6AqdMFnRUVkaadwErB8Jkb0W6Q9pnNrJ4SwM3Je/5FaniGp1kbOkdeyUEgfcMTaN+771h5GqgbVSTRUVwNah592EpneVI/0cTYNlVBuvTZ2F54f2ZEkScJ1UGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jnFlnxVH; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d886f17740so10937791fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712570360; x=1713175160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aX6aDaiTDQQKwwQqDMi3cKuVKSE0XZ2PoAlIbyTQoEY=;
        b=jnFlnxVHYNFPXlRkhXl76MR8YAwDFwRaxWO1HahNf9IxEc2x9IPnACVHRcBL2nKAu/
         qenENkkb5pOye0PixTWnNinpARHtCLKrkZD56tZTuwtFejeGdH9WbuerRgxVgzC2x5/h
         hiap01kk+VH3OrSk5K1E+4WrMSo2gHRSb8UYZsJiJS5AXw8HGPaUSq+F2hcVUJNW8D/M
         vnhCUS8nnRdw4DsAh27blg4CYM6NIQGxfv1ghX8Lw8Uf8iwcYHUKHevaFABvAOuCR5Dc
         BmcL54YKaYkCndezPNevYut2QHvMroXGh8d+Cf7zQdpch9R9pVCRo2xo8fNIuW0gmGbD
         sQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712570360; x=1713175160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aX6aDaiTDQQKwwQqDMi3cKuVKSE0XZ2PoAlIbyTQoEY=;
        b=p8yQchk0uaAClMi+3IsJEaosnyBItJIxxgwND7mGO+jNP1bnbhGDGJ1AtTPvzMXfOJ
         mh+LYO+NQHLpPjsbpOk5b9DqfAfS2wh5ewSlusRjXGVtZiF4cjaitZED1X7iOvMy4C0a
         CprpYMqcVaAkO68xFMHCqjs+m94lSABWokVNSXurtjlXBPE005QrDXr8RmY1rO2c83zt
         6T7tko+2L9FHPOSq1tDsGTSu+COCT+AxYS1HbUhRtE+nDaCJR5CEyjAT+x5Sez2EY6fD
         8h/DrkD97aEwfHLfriaJoASShjeZXCE8hpyA3r453JReVv+hA/6Tkzf+1nFY1vyb+Heo
         sdeA==
X-Forwarded-Encrypted: i=1; AJvYcCUrquqnDrFfDzJeauxAt24YIp50WYjBJWFaUveYlo2ozv2Bih3WAAKLn3nNWXqjfpW8sIhYPn2DWDHI80r3QcpYHf9RLy2lDHQf5ELz
X-Gm-Message-State: AOJu0YxTeFBTZvrCFRxfDhkKauQhdIVXeW/dh5Taclw5u+tn41T6oN8r
	RDHdlgIwLzj/NRmRGyORfGEQqhSZx7p56lIbWrS1tEsXcawDEwuhv00uy6jFu3F7VN0iQJF6ENG
	dtg72W7kQDnme3SEkELYrunjyPA8DClLLKucqUg==
X-Google-Smtp-Source: AGHT+IHpETVzYi9e2vtA/Z+GVefLYWp8VsykEgivacn22jHDLXO0DnsTxWYCv5yeCFyTRv4rCSYQ6OxQVFNE84nksC0=
X-Received: by 2002:a2e:4942:0:b0:2d7:1805:1071 with SMTP id
 b2-20020a2e4942000000b002d718051071mr2997230ljd.14.1712570359813; Mon, 08 Apr
 2024 02:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
 <20240403-msm-drm-dsc-dsi-video-upstream-v1-6-db5036443545@linaro.org> <CAA8EJprvAiOYnzJNduhr9MZe6asfE5ygtupTNbp4dcXD-U8jsA@mail.gmail.com>
In-Reply-To: <CAA8EJprvAiOYnzJNduhr9MZe6asfE5ygtupTNbp4dcXD-U8jsA@mail.gmail.com>
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 8 Apr 2024 17:59:19 +0800
Message-ID: <CABymUCNW4zpP4H+gKw8+7NPR0D08jM2ze4AVG89+KSwZYoozkQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] drm/msm/dsi: support DSC configurations with
 slice_per_pkt > 1
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2024=E5=B9=B44=E6=
=9C=883=E6=97=A5=E5=91=A8=E4=B8=89 18:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 3 Apr 2024 at 12:11, Jun Nie <jun.nie@linaro.org> wrote:
> >
> > From: Jonathan Marek <jonathan@marek.ca>
> >
> > Support slice_per_pkt in msm driver.
> >
> > Note that the removed "pkt_per_line =3D slice_per_intf * slice_per_pkt"
> > comment is incorrect.
> >
> > Also trim the code to simplify the dsc reference.
> >
> > Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/dsi/dsi_host.c | 35 ++++++++++++++----------------=
-----
> >  1 file changed, 14 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/d=
si/dsi_host.c
> > index b0507a42ee6a..0c6f40dbd25c 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> > +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > @@ -866,17 +866,10 @@ static void dsi_update_dsc_timing(struct msm_dsi_=
host *msm_host, bool is_cmd_mod
> >         slice_per_intf =3D msm_dsc_get_slices_per_intf(dsc, hdisplay);
> >
> >         total_bytes_per_intf =3D dsc->slice_chunk_size * slice_per_intf=
;
> > -       bytes_per_pkt =3D dsc->slice_chunk_size; /* * slice_per_pkt; */
> > -
> > +       bytes_per_pkt =3D dsc->slice_chunk_size * dsc->slice_per_pkt;
>
> Please don't mix cleanup and functional changes.

OK. Will fix this.

