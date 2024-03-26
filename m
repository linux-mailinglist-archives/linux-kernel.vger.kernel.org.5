Return-Path: <linux-kernel+bounces-119598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66DF88CAF2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC07B29511
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6F21C6A0;
	Tue, 26 Mar 2024 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bb2LxkaE"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6951CFBE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474306; cv=none; b=WEx0GYucoX1xR+Wn+6hBBW4b4QpoUfkwCrwBvU3CBIk5se5flPpQPpJ/AYCWNgH7DZuf41JJfVTlpLCdDO9Mc8n6XfHTysw1bAPgzq2fJck9ZEAKa5wMesA9rD06Ix0DT07+m0reKPGzWumbSrgnavd5BqIvxauA4cOIIWvUrzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474306; c=relaxed/simple;
	bh=SbAoClBp6vcfCL54MkSlIoYTIV7r1b+nCCdUl2D5njA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTNuhTInlM+FJu0XywOoEiIJHX3Y488zZTuK8j1Bj8Uk3ys2gKLdS99B/l1ccYITQgPmx6d0lDy5Annhys/cc9AqfxbJPj4IyVOoPc+UcpqpXX+7kHhoReTrJ6LnuidwXbjH/U4JKNyUKFOHRLO8Kxhx/VX4ULDmY+QQ4EVJAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bb2LxkaE; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60a5a11b59dso63753067b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711474304; x=1712079104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9zt/phGBfZSdp8qy9N6Gw8zdXEBb0+nioLRknU84U6I=;
        b=bb2LxkaElAqiObuviNo2utz9kb5g7gX6/zhj3E83ANUvnBUK7MvYc+bS05fc+GcNst
         qArvvBL3Buoz0iMtiJFbtBwvEe7+oA8DT121n7lP9Wj/Q4RsNCvJXoZ1LYTR9EvZhXFI
         SWvkoyQj7Y3cOeoQZqDG6cJnSvADWaPhIDlCco/gBJIkTzW4Q84+piy9P5wSfrO9wf5l
         i/G+p0+ubv9pMzPmwvgQtSKU3b3sNgq4AyEBX5yEs2Z64buqRC7bqyT4QMqATlaN93m7
         b7j94z/BCjEk8MvD7GGk73G3zV0lT5dvztOuqw8TqlNLEq1x4bTi7nmNnBBnxV3GotyS
         zRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474304; x=1712079104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zt/phGBfZSdp8qy9N6Gw8zdXEBb0+nioLRknU84U6I=;
        b=OSE6mcuctgyHyVcEutTwByV8Sa1xq7IV10L9deawPiewl1IQVtMISyCm2LxqbTKyxh
         TAASTmzccrBwK8f67OJNIV6C8uxbYC8p2LWSQc3LUVkhRmNiT+1rBhVTt+rMlIfKf0dO
         gOcS7m/Xo6SCWFSbV7tDjpHq1wwPXJVXEPL2o5O/9qv0tt5QAoelyeLnOmEfg4A0hEwX
         ZbxQy/me/VfPG3Fv1WZL9lWNUUfHv6MR9qtIEJzs4+aDyp3i5yRuZI7tKeBmCD39BWB/
         A+QvClTg546x/9zCy7Li7NO4g5z8VAXtoQgfc5ExBsXzjLYySf4br9x9Y63iOC2sBJjq
         N4gw==
X-Forwarded-Encrypted: i=1; AJvYcCVMLBMSPEBpscf6/7Eq3CQdkFN61nG50+rmPMysB4/V55edWKOKXPRM+VgaWszHRG+wYMBnhTx9YFUOdPYgAtFb+3aE4f3D9hetXTuc
X-Gm-Message-State: AOJu0YxSgiMBdf0tKLV8OYHvg3E479Ca1u0ri/PWDi6c4QbZUVl0alPp
	YsRFkWMvhm8tie1cUXgDQq8fwV4tTexeWo4k1cd3dagglBEJO9zesWwNtfueov8HOPl8e0Mafh0
	sk6qiERvIAgW9LTTEiTFEw/6/+ScEcXqu/ysq8A==
X-Google-Smtp-Source: AGHT+IHKvErihvCqyYvqxnaKemrvy7TNx3gwuqYnQoUJPA6s9U6270M569opHM8owaC5W9WEJhp8lM+R6e3WArVuFyo=
X-Received: by 2002:a25:db10:0:b0:dcb:be59:25e1 with SMTP id
 g16-20020a25db10000000b00dcbbe5925e1mr291813ybf.30.1711474304335; Tue, 26 Mar
 2024 10:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-msm-dp-cleanup-v1-0-e775556ecec0@quicinc.com> <20240326-msm-dp-cleanup-v1-4-e775556ecec0@quicinc.com>
In-Reply-To: <20240326-msm-dp-cleanup-v1-4-e775556ecec0@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 26 Mar 2024 19:31:33 +0200
Message-ID: <CAA8EJpoJQ+K6S7PbeWt740WhaMRWbNmu2LXz1Js+x8HgzuH24A@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/msm/dp: Use function arguments for aux writes
To: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 17:06, Bjorn Andersson <andersson@kernel.org> wrote:
>
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
>
> The dp_aux write operations takes the data to be operated on through a
> member of struct dp_catalog, rather than as an argument to the function.
>
> No state is maintained other than across the calling of the functions,
> so replace this member with a function argument.

Definitely yes, thank you!

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_aux.c     | 9 +++------
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 8 ++++----
>  drivers/gpu/drm/msm/dp/dp_catalog.h | 5 ++---
>  3 files changed, 9 insertions(+), 13 deletions(-)

-- 
With best wishes
Dmitry

