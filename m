Return-Path: <linux-kernel+bounces-59847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5D084FC76
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5838289E5D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F4C83CAA;
	Fri,  9 Feb 2024 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uf/pj6DS"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1110883CA2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505102; cv=none; b=Ha3PAP2qmoJUspmp0EBEJPGyIbyriReHe2nMJ2O7b/im8ZQktBEMCOi0RRw68MBzLY9kWFpNuqXeuUYUI9bTViJU2/2M1rWEtVNJhbP3t+CSktO6oL9bgQ7iHo8+uQeiKL/jqh8l+SsKhfQoggtiofDF3847fYubY1n16GTwNmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505102; c=relaxed/simple;
	bh=Lk3JaFxs2CfEJ8pA6iMQU8xmMZxQ9mIMQ/A1Nh5p8qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brlMzFUU/jDh//6PlgAJ+ma+NxUBhmy1AY7s7e9X4wuDN6fIE3kZ4Qz3riwWyWsZq8PkQ3zF/wzwC2iwMXtPbVp0R90hTef8/90q3blfWmai7u3il9JZ5hUx2i3737KcQF4iHGN5KawquZJ2srgDTW+th0Nex8m+nFv2DtJiOe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uf/pj6DS; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc755afdecfso825395276.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 10:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707505100; x=1708109900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=awo/BCeLbFkRz9Dlg6VrbH43FXLlqcjUWJcmSLZJJiM=;
        b=Uf/pj6DSatD2Id+EVE6mRscNrKXJagoikiBImmxxLtD4cWI8i7vooq9yzYIbSqFwc0
         reLmFsS/cDczuSTZ21mvInTDlq4RbrWvCjgJyqyJvB1SacCc0Kv8iKzpF6YGRmtKMz3h
         IuX+HQXrSOqkByHbJUenGjhYR/evVd2qNVpJv5Dbgt7u3/f6URUJDsgeUH7zWdZV2os8
         qK922fWZ2z+sOHNabf5kta12SxCdRLXqF90POtuJ7e8SRVW4IlhPNjsbbw9KdYCz00mt
         GPV28j9Ure3FQfW2QmZLs615krQ3TKynsMAMHbA1OlpD6ixEI7g7yXPM9+OaVsNM8qzq
         DKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505100; x=1708109900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awo/BCeLbFkRz9Dlg6VrbH43FXLlqcjUWJcmSLZJJiM=;
        b=AUcOiEqRJYNaKQ1+0cvccJEFq0oibu1HT4w6WfDqETNAQ8q4FKvwdXD8w/aRKaZ06a
         WT4iKW0MCOwJIdjaKchFEczCsF1PavbnOIn1QzotWvZcO74WK0KUfm5j7m1sfhy9G7Y8
         nb/njO/vpLsmR4eE0xhpy8c11oyryaQfhkh2JUVYbhnW90NWxnvqvSgTTgw4xGkGhHBT
         e73cCVUQ4oV7fVp5pYNvY7xUZmvcZUT1FGwZMsHe/ayfZa52OkfuZfn0WdpGpFaCSsOT
         lVYPWJvN8dZSAs4oTd6RpEOp219HsGVsBSgWEnoN1MUS5GL4enImyxkMom5+ZNK8nGEt
         pMwg==
X-Gm-Message-State: AOJu0YzJZTMNfoCGV1AwyZEGvsb8Hss7t9cFMUP/lfcHRHswwpwIGWdY
	S3M3A0afaNy6P/rXhfFoGJyhhdMktTSbh1cJEoZobeFCIWJTsfTPWnujOW7HEgr+NfbMfe+HnP4
	5BEMpeOvX0LODdayJCNTkIvgS52n054YXOtMINA==
X-Google-Smtp-Source: AGHT+IEb9542YJRhGlr5tTb655Bco/sIqzumPYkKYYv3shLKDvBLR/Rw+lw7ROAYYvzXuW7vbjo071txTmkH+A3fY7k=
X-Received: by 2002:a25:6645:0:b0:dc7:492b:aad with SMTP id
 z5-20020a256645000000b00dc7492b0aadmr49982ybm.2.1707505099966; Fri, 09 Feb
 2024 10:58:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208-fd-migrate-mdp5-v4-0-945d08ef3fa8@linaro.org>
 <20240208-fd-migrate-mdp5-v4-2-945d08ef3fa8@linaro.org> <9a4bf513-4390-3e36-f3b7-f9fef1c296fd@quicinc.com>
In-Reply-To: <9a4bf513-4390-3e36-f3b7-f9fef1c296fd@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 9 Feb 2024 20:58:08 +0200
Message-ID: <CAA8EJpoVivjg2KKVgf725C2cwMCOk=JK6hz65ewTheBAb8t_vQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] drm/msm/dpu: support binding to the mdp5 devices
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 20:44, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 2/8/2024 7:01 AM, Dmitry Baryshkov wrote:
> > Existing MDP5 devices have slightly different bindings. The main
> > register region is called `mdp_phys' instead of `mdp'. Also vbif
> > register regions are a part of the parent, MDSS device. Add support for
> > handling this binding differences.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 98 ++++++++++++++++++++++++++-------
> >   drivers/gpu/drm/msm/msm_drv.h           |  3 +
> >   drivers/gpu/drm/msm/msm_io_utils.c      | 13 +++++
> >   3 files changed, 93 insertions(+), 21 deletions(-)
> >
>
> I thought we had agreed on a quite version of msm_ioremap_mdss for
> vbif_nrt_phys?
>
> Anyway, its not something to block this change. Hence,

Excuse me, I'll fix it when applying, if I don't forget.

>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>



-- 
With best wishes
Dmitry

