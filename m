Return-Path: <linux-kernel+bounces-129635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B956F896D9C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C90A28C95A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE4A139588;
	Wed,  3 Apr 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4aKXYUK"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA94259C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142299; cv=none; b=Rglpf3+DbeLhlwvCRHgVQLrmzZkgK6NgfkNPHB3+o2qtTDPGedWNVOsI5Ve4D0webfN1Rhuk3mNns/dK8oKH+4ED06FhP0VsLyTqoqjcW2Zfk2ONz8QdCKCGN+TolmJeAiamh4C0qQN6yagDgB+No2ebZhX/v8LefLXPY2R8QJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142299; c=relaxed/simple;
	bh=qAXDnAQ20/ngldFN/9GzwB90qcvOX2UPkxSdCsBXvdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCCEzpK51k7FZoGKyaH7aJxHSQH5ItBFTvXojJE8zZ4DUQKhLLUYKk9sWkWQFXhULh+cpUswbVIiGFv9bk8VCxRricJMTeXZuUXKkKJQFxrWO4sJX9MXJa56e6YO6MOsTRsOG+xm1WfTGECtzanfIzykkhsIYAqdJq+vRI+dCoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U4aKXYUK; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso5680073276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 04:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712142297; x=1712747097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N5/oaXGaDXSfCFWNRLUlqUFokKx3b3oa0E7IyM+4V0U=;
        b=U4aKXYUKDOHk18ss2xfkB6ISdDfnhaV9M7b/qOQlpjYaUxCQ8Z9xdxnEbE8ISrklqE
         o1AvkV02jyN6pFhV4Rk/eNEuMRJBijGolfPUFqN+HeNZlYTURFiBVmntK/eAFviWFH/H
         lxCjbd8gmovR/rvPJKEaB9+FCtT6xN6bwRFBlBWIw96Ixlo4Gb8glBQycRfp5J1zFPT0
         BguljZeFh/83ZRPbLTR7ihxEwpku+mGY7H8afma2zt0A6SEHUtgCfWeThJqM7jSDi2nK
         +zjDXZ6PhpttoqJHowhzxgAW90fsovNJ7H1UZL+HR4B9hbPmMV9cjC+6gMgz8v0Dhy9M
         O2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712142297; x=1712747097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5/oaXGaDXSfCFWNRLUlqUFokKx3b3oa0E7IyM+4V0U=;
        b=SKAQZU2+mkwsBk4VCXlh6Xuz0OH97ttsbeslEp/huFWySvh9ZuCcSUm+YKi7dhIY0G
         Nm7yQgTeJ1W/iQDULkpnGBde6+YN2y7eNBLDy6MbSFKvEK1s/IDJaVvMuDqYHDs6/2YF
         WshyPTDsxt3RRzvXEWFH/9xM/rNDhqlhdbL1Xht6QS3kAk71Yc64RY2juwOB4oMwT9uQ
         rut7uEHiEL1IQ+cPLUFTt5EavqlVEv9sIbeKqLrKflCdz8ipaRXIM5jnHUpM9D9JhPxe
         1VKild23FUSm/mPFlbYD/2UCz5IRNQhykZRTEDnBJx+bN1TZP4CTyOlIeNLWx93NC2pC
         +e8A==
X-Forwarded-Encrypted: i=1; AJvYcCVh9lWvz9wMdvs6lTfv3nDLCgGRECmu7dq5ITtwQsDXZwouq6U0u1Qjz7FEMIheU+RnKYYpXMt8XvkpgM/TUBfz8l5EGm9o5ORcqznm
X-Gm-Message-State: AOJu0YyyHBf3GI/fY1AAx8RbY1cF9yC5CABCJbmc4vKgdkH36ggIKgvc
	kSg7c0gLZ8ikW2UGfNQX1G0EjTmfIRC7Yg++WSoKobcFVhwaYW0pItu7GZzCRkC7QjMHQ8d3lbj
	VTxoCA74oY/nwgYWB9oagO3yezRwTZ+2xMgpNNQ==
X-Google-Smtp-Source: AGHT+IE12sfKk+/XM1kPq4dc8JVlzR2lCkXFu/Nv2FXb7Fs+ZLOsbaq4fFXjYhjHFZTi4dzZn/QBvEeU9aiC510tGYo=
X-Received: by 2002:a25:3c42:0:b0:dc2:234d:214d with SMTP id
 j63-20020a253c42000000b00dc2234d214dmr8359198yba.40.1712142296721; Wed, 03
 Apr 2024 04:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403104220.1092431-1-quic_varada@quicinc.com> <20240403104220.1092431-3-quic_varada@quicinc.com>
In-Reply-To: <20240403104220.1092431-3-quic_varada@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Apr 2024 14:04:45 +0300
Message-ID: <CAA8EJpox3EmmV9o6HqRJkTwDHTwAYQ8kaiJr1PacGnwLPSweQQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] interconnect: icc-clk: Add devm_icc_clk_register
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	djakov@kernel.org, quic_anusha@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 13:42, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Wrap icc_clk_register to create devm_icc_clk_register to be
> able to release the resources properly.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v7: Simplify devm_icc_clk_register implementation as suggested in review
> v5: Introduced devm_icc_clk_register
> ---
>  drivers/interconnect/icc-clk.c   | 18 ++++++++++++++++++
>  include/linux/interconnect-clk.h |  2 ++
>  2 files changed, 20 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

