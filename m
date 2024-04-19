Return-Path: <linux-kernel+bounces-151857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FBB8AB4D7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EB11C2209D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BD813AD02;
	Fri, 19 Apr 2024 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nfetJ4Ni"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F113A86D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550340; cv=none; b=f+8uaV2aGvLMXb4ayonQMkU25XvJGsV2zHFmCG+zFmAEO6MP5y2Wn/t+E1jasIeoTrpUhzF9ytKqlSrX+6AnzIxNReeWgbU2GOr3H7eQAys5OvXSnxX9GjbG/TKyVM+zn/swkykRE5GTlH8GnEDOvmGAnMtdSCYtTQa0S3ir0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550340; c=relaxed/simple;
	bh=Wz+7M6kLV5/j49HNQftiuWnlx11DArswdMRdOqQ/jc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Glkxxf4m8teVxar6D5AXwsRK+3/mfvAndUN2KzNTRfeQm+GN9JZWPu8jrPAS+DCQ2B5O1u134Rnp+kF5XW307H/oTYljq5LnZIW4mINzE2aEg4xNsZGTDdYpqaitcBCmPjDYVCFSxGUhjNE6ocoRrBvDO4P/lEKwegL35AZVz2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nfetJ4Ni; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so2583864276.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713550338; x=1714155138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qOPICZmb4msrHYUkaQcpA3qKXuhnZGxWuMEasDEx0MA=;
        b=nfetJ4NiMriS8KFIu7znDhCUzNpTirbEaEp4dZzKyLnrzO/lkXCkw4XEo6N1dNI/zx
         R4EdbvKLluwQRepP1AxngCUpW/pD5xBYvQyAZazmQkVJ2M36rmAbEhdd/iq2wKmWUga8
         jnlwYoJASHcXV625aURO8JOx3pDc17PyI23E4Zd6TOdbeE4llPu0DpHBVgbRVU5K7AYn
         rJmbrK2vcJErLbmyv55rfzNjvHXgNhq+CYWK81Z0hskB26xhdkDgSnvaS4DSks5XEUYV
         gdO4YfWKthYLdYx6Es0Z0vchuJETR1qfRQf7IZ8cWUD96wz3zsbT8XCgkBHvxT+4hFPY
         0IXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550338; x=1714155138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOPICZmb4msrHYUkaQcpA3qKXuhnZGxWuMEasDEx0MA=;
        b=Sk+6wgXF8B7MjRtat1Jp69anB0/aS0q3ie1jr484Rp6z0h6+B++ylM7xtmr1Pjg8ln
         E9PMCsKXeEl2+phf3EtayaAMX2HtsnGVh/xOKTepdzLLEG6auUN0L7kY7fmaKIdhvDYx
         8Yrz53IKRsqqfPPusrG3jxrGnqnuJUWNeGNsVkl4rZLU+MuLsYbI55h6JeQgUymF2TJD
         xvH5Mb5DJRoWx6h07PoxUF+/u+/Zy7k3Xh0NZn9i+4oYACDf3GGBTqBdlv9LW2pZ2q9O
         wKmZPC4+WZYSfAdXjYgACAJJTip+V0OViKPnJZbxN0yS7mOHmg8bp4F75xCzO0w8DvuQ
         b4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUXTRsZwXWr0MiITOctSlGRxOVBVeJn413T4SsQ9/YOTc31yXVXk4hfz55ryVwhyqjGrxiq6kxsuFl5Fdkkn5DxSl2jQ247RKyPEtad
X-Gm-Message-State: AOJu0YzZ0uJygXjilp5wr44XxvTAZooZVhk5bu3pwCsTa7iv2nqlftvH
	L68f+S4lDjPLL9pUq0aOySBzAEIUauO/XGDCz2Jg62jZ9D2/AV6wNsY0v5/9CFBv1hcqmXWWEsy
	ipGLvti0jI2yq9pYO47Q88KZB3GAvVcFcNsykig==
X-Google-Smtp-Source: AGHT+IGxhkLPIsofUv6p/cU6MHWkhFG1QRKjgtI0vTLgun0UHmUTqcgaXxpBHh1DwVbCWGl418JAxbU/8nZLjPJmAms=
X-Received: by 2002:a25:bc85:0:b0:dc7:8c3a:4e42 with SMTP id
 e5-20020a25bc85000000b00dc78c3a4e42mr2771282ybk.30.1713550338352; Fri, 19 Apr
 2024 11:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419-x1e80100-dts-fix-mdss-dp3-v2-0-10f4ed7a09b4@linaro.org> <20240419-x1e80100-dts-fix-mdss-dp3-v2-2-10f4ed7a09b4@linaro.org>
In-Reply-To: <20240419-x1e80100-dts-fix-mdss-dp3-v2-2-10f4ed7a09b4@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 19 Apr 2024 21:12:08 +0300
Message-ID: <CAA8EJpod25xV_0Mdx5vipaggpu74+NWrDdQOFD=wT6t6Z-sEAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: x1e80100-crd: Add data-lanes and
 link-frequencies to DP3
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Apr 2024 at 19:14, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The data-lanes are a property of the out remote endpoint, so move them
> from mdss_dp3 to the mdss_dp3_out. Also add the link-frequencies to
> mdss_dp3_out and make sure to include all frequencies.
>
> Fixes: d7e03cce0400 ("arm64: dts: qcom: x1e80100-crd: Enable more support")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

