Return-Path: <linux-kernel+bounces-93083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E798872AE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A43F1F27C9F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDEC12D201;
	Tue,  5 Mar 2024 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NAfDVBqM"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4BA12D218
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709680439; cv=none; b=PTuSgZI5P+UMKeX2W52GS1G4PD+iB35bhAiy4+8JOWjkJFf13WRLOWHf1ttg2swe80xePE9T3SsaI69hZGePC2xpqatmNWRkc6sfVYr00uTw4vMa+hUDaugQDDO/MH5Atznt2y/OqBQMmSCG2tOkjiYe1ezZT2pp5uoJda0YXX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709680439; c=relaxed/simple;
	bh=ZSE908MrL3W9EF4A9/FeE48VeA9QUapWInD9HpQG3I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGQeZVxedNKnwltrCfWPRsAPiGm6CC3QiMfTCfmY2zoZJjkFSYR0BbJADp2JTEXHewiZdYeMKNEDEi3Gt/NHbS5cuqtO6gyjvmgMAFRuMMcFOuy5Zo7ves3i8X9AjXDOrDIJf4NhEA8dM7QlCaJTgvwbPZrR7rPjmQMnJjazWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NAfDVBqM; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36523b9fa11so26710365ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 15:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709680437; x=1710285237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZKWR0J2srML+eyhC61XR43/wjQEkRkTGp8CW9dDv+M=;
        b=NAfDVBqM+p5SRXWtSIgOYxV9sxY/2zgZfqzQCPpIYxRFqFXeQ5isK3k7txHHdhTuAo
         NDu6m7gpRJRyJBDq5OJg7LNq5YEq7sHrhfWl/2mzVB26dNdsIPuFXVgZFv60c4cQ9AlY
         T+ri09c0i6+A8oFm1NTtbz4pWQpPQtftBxI8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709680437; x=1710285237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZKWR0J2srML+eyhC61XR43/wjQEkRkTGp8CW9dDv+M=;
        b=LChFOukNB8toY284WVOBT7k36jPzros9taw50g1Vzho28bpkcQcRObQbyyU7xAWH06
         /35Kdcj1SAgTNBqvkQ8WdVFTN/Do2C/4PMsm4iao4IROpiRd+/Ed2hmEf8jKOLbt+hXx
         U3bVJn9ROHZy/ieAdHRNr3zc7mbMNJIxgrdyBpJgU2PVuu9m0bq9XWjPqHadYg1V5aP4
         G7W8TmtyNAhS8q51dbJqsKRFuNx0dmRaryt71Ar7qeYWySuYYKGQ2NbV1tLX+d+hul1K
         R3msQO5HFpaWQSSh3XfD4h50UYDxmiVjymHyCScMCB3xBZ3dxcjWVZVjZx73lf1cWLFm
         sluw==
X-Forwarded-Encrypted: i=1; AJvYcCWjLg3E68cLTt6FfqdB4LyQUpN2gPytDicAnY/33R+N1Hlo5b4RbuXYBQvvbI3JOYHTXquvYB1+KIyfPHQLK3pe5zFGWVtIF5Qz0Ydu
X-Gm-Message-State: AOJu0YyWLQ4IOLzM/83rRothCiIEt4g+YZ3c0nKh1XEYGmRoo8LYa05h
	kro6wei6FgHG56KBr+o1lA9UjI5EiIfgaM2niaanqVfwR8ttJPm9xM82Mjfs+KK6Yo/u+ZceSv/
	XJ9aqvfFHnLdePiU+cBweLWcp67ank//JaT7E8QWI2dpwToA=
X-Google-Smtp-Source: AGHT+IFDvVCNWLD5UqLerMM90o3fXxlm8K2ifoYGV8gIMJPQStPoeWDTtvtRilg2YO2qtDVgyzI7zQsgcgd4+aqlVDw=
X-Received: by 2002:a05:6e02:1a68:b0:365:7607:3f5d with SMTP id
 w8-20020a056e021a6800b0036576073f5dmr17242881ilv.3.1709680436858; Tue, 05 Mar
 2024 15:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305225652.22872-1-quic_mdtipton@quicinc.com>
In-Reply-To: <20240305225652.22872-1-quic_mdtipton@quicinc.com>
From: Rob Clark <robdclark@chromium.org>
Date: Tue, 5 Mar 2024 15:13:46 -0800
Message-ID: <CAJs_Fx4DKiBjzh0-F6aBFdsqGDiE9uppXAE84yrO3hxMSzwgjA@mail.gmail.com>
Subject: Re: [PATCH] interconnect: Don't access req_list while it's being manipulated
To: Mike Tipton <quic_mdtipton@quicinc.com>
Cc: djakov@kernel.org, quic_rlaggysh@quicinc.com, quic_okukatla@quicinc.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 2:57=E2=80=AFPM Mike Tipton <quic_mdtipton@quicinc.c=
om> wrote:
>
> The icc_lock mutex was split into separate icc_lock and icc_bw_lock
> mutexes in [1] to avoid lockdep splats. However, this didn't adequately
> protect access to icc_node::req_list.
>
> The icc_set_bw() function will eventually iterate over req_list while
> only holding icc_bw_lock, but req_list can be modified while only
> holding icc_lock. This causes races between icc_set_bw(), of_icc_get(),
> and icc_put().
>
> Example A:
>
>   CPU0                               CPU1
>   ----                               ----
>   icc_set_bw(path_a)
>     mutex_lock(&icc_bw_lock);
>                                      icc_put(path_b)
>                                        mutex_lock(&icc_lock);
>     aggregate_requests()
>       hlist_for_each_entry(r, ...
>                                        hlist_del(...
>         <r =3D invalid pointer>
>
> Example B:
>
>   CPU0                               CPU1
>   ----                               ----
>   icc_set_bw(path_a)
>     mutex_lock(&icc_bw_lock);
>                                      path_b =3D of_icc_get()
>                                        of_icc_get_by_index()
>                                          mutex_lock(&icc_lock);
>                                          path_find()
>                                            path_init()
>     aggregate_requests()
>       hlist_for_each_entry(r, ...
>                                              hlist_add_head(...
>         <r =3D invalid pointer>
>
> Fix this by ensuring icc_bw_lock is always held before manipulating
> icc_node::req_list. The additional places icc_bw_lock is held don't
> perform any memory allocations, so we should still be safe from the
> original lockdep splats that motivated the separate locks.
>
> [1] commit af42269c3523 ("interconnect: Fix locking for runpm vs reclaim"=
)
>
> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> Fixes: af42269c3523 ("interconnect: Fix locking for runpm vs reclaim")

Looks good from a memory/lockdep standpoint,

Reviewed-by: Rob Clark <robdclark@chromium.org>

> ---
>  drivers/interconnect/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 5d1010cafed8..7e9b996b47c8 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -176,6 +176,8 @@ static struct icc_path *path_init(struct device *dev,=
 struct icc_node *dst,
>
>         path->num_nodes =3D num_nodes;
>
> +       mutex_lock(&icc_bw_lock);
> +
>         for (i =3D num_nodes - 1; i >=3D 0; i--) {
>                 node->provider->users++;
>                 hlist_add_head(&path->reqs[i].req_node, &node->req_list);
> @@ -186,6 +188,8 @@ static struct icc_path *path_init(struct device *dev,=
 struct icc_node *dst,
>                 node =3D node->reverse;
>         }
>
> +       mutex_unlock(&icc_bw_lock);
> +
>         return path;
>  }
>
> @@ -792,12 +796,16 @@ void icc_put(struct icc_path *path)
>                 pr_err("%s: error (%d)\n", __func__, ret);
>
>         mutex_lock(&icc_lock);
> +       mutex_lock(&icc_bw_lock);
> +
>         for (i =3D 0; i < path->num_nodes; i++) {
>                 node =3D path->reqs[i].node;
>                 hlist_del(&path->reqs[i].req_node);
>                 if (!WARN_ON(!node->provider->users))
>                         node->provider->users--;
>         }
> +
> +       mutex_unlock(&icc_bw_lock);
>         mutex_unlock(&icc_lock);
>
>         kfree_const(path->name);
> --
> 2.17.1
>

