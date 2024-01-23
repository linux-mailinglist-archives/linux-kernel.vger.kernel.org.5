Return-Path: <linux-kernel+bounces-35315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C0C838F69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8762EB2706D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6735F867;
	Tue, 23 Jan 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3hjJOW7"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E295F866
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015275; cv=none; b=V/MkXL8LmVSvlAjMTkiqZrBZv7d3DsUqCCj5Io6t5wYSjYHt9bNdLVOiUqVxMGHy/V6qkQilUrjOII0/8qpKOOZlzorrUVwjOw+7BUb1qynqxZfEzy6ZVyPSL18J5GFFxDjO2RrO+eIlCUEpcLBnFoSkO9tZClCvTQW3CYsbvgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015275; c=relaxed/simple;
	bh=nENCJzfg8kLaw+xOwN6nVFSakH5k6qwqeLnp2qI/5W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8nmzNIrBhddBkLkcsl4L9xKcb3DWKyG2xEaKP9egedoMimLm9Zm8GgH8hDn/WwlfSJJtVqgszdqu3qPGZfDprS/ruizfhqBrK9xGBaAPq/q5+daByiLjigJkdA1UqpIakPnEANPFWnFixteqf+KzfVbNRbQpi4VxJRyIXQaCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B3hjJOW7; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6000bbdbeceso17502707b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 05:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706015272; x=1706620072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0h+KxHo6zyFelz9bwRo7wSwVd6I2bFGua0EClSwuRfg=;
        b=B3hjJOW7By6jVRqpTYX8c/q92zWdSmFRr60FkRvBBPQoXrV//LmUOjR24RiNJGhObj
         xIvxR2T5MyAj5tPZvDLisOGI7c8dvi1M34QPDKiTEBwiJftl0OcCybpQAPNjPyRWDrhJ
         LrlfHomCjxSCo/T8q2AdXXJXwjRNCR0UOmk5hK18NcV+ElFAgISAt35fICWg6e5e6p53
         xEDhNj97v4/YnMaJJ0aEN3aJtnLNkC7tOyXKIa9h5nUbncYeYZl/5iFc6BgzM3/7YJHC
         pc6Ey+skJeFKkgu4aYsWKzs279hqnuy6ocBtIaz39Y2yQXnAg18rqObS1eWOxJxfDhI6
         F/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706015272; x=1706620072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0h+KxHo6zyFelz9bwRo7wSwVd6I2bFGua0EClSwuRfg=;
        b=eutUA8h3//Q3cQYdg4zX8a/7nLQRp4ZS/e1QFxPapk7Ag4YreLbkcLcv9+54rGRULj
         Hfr5CuPaFn3tOv7wHZNzX+2PzGEMGZ3L6zoVjKSIF/5z5gLC/ui8QeDuy39gDsTKnYuV
         WaXE1RZCXa22fNZsvmM08Sp/CykQc1DQOFjMZc8uZJ304g6yjwcrN8khWM7b81K31lFC
         yYQHS0Ur32YjHwNAEh4D3YgOW8tvq1xmgB+LnRGpmcsUj2oF7ttwjd94mtvPB1vrUSht
         LHD0ecJolnuwGUE0zVz3qxqijmirBsN5w/JxczNsbf+Jww+pScEB04yqBqGaSfNdOt9V
         FEqA==
X-Gm-Message-State: AOJu0YzhudUG7NBFcPDhu5bSdblcFbfrUprzsc+5ayG347ozQsEv+Bvv
	g+ULSfw5H8fvvOn9WgX1ktf0hMZJMsDDs0JRoezh6GudPSpfgwsH8s27jl3l07buXXpeVv+jcIw
	5E0AXBT6hqm9Cuhcc4Vu2V192kXRQ9iQZszTGuQ==
X-Google-Smtp-Source: AGHT+IH40SsVqCfKV7MCl5J25tlYVLHihl6geu98LpF3DgLOVi45HGE/066ut55wd5gnxEztUyh8umbJBgplDyJU0jA=
X-Received: by 2002:a0d:e647:0:b0:5e9:dca:1b14 with SMTP id
 p68-20020a0de647000000b005e90dca1b14mr5063978ywe.7.1706015272184; Tue, 23 Jan
 2024 05:07:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116094935.9988-1-quic_riteshk@quicinc.com>
 <20240116094935.9988-3-quic_riteshk@quicinc.com> <CAA8EJpp3WJ8132aB-tyzJPXsdczvQC+TvKemm9NvUNYNrEntow@mail.gmail.com>
 <b9012927-b357-4875-9e8e-90df5cc8d8bb@quicinc.com>
In-Reply-To: <b9012927-b357-4875-9e8e-90df5cc8d8bb@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jan 2024 15:07:41 +0200
Message-ID: <CAA8EJprdCdTVbL_vXWhcEVKgOwZHNCPfg8DPz8Ob01hnVcHRtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcm6490-idp: add display and panel
To: Ritesh Kumar <quic_riteshk@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, quic_bjorande@quicinc.com, 
	geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org, 
	nfraprado@collabora.com, m.szyprowski@samsung.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_abhinavk@quicinc.com, quic_rajeevny@quicinc.com, 
	quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 14:43, Ritesh Kumar <quic_riteshk@quicinc.com> wrote:
>
>
> On 1/16/2024 3:28 PM, Dmitry Baryshkov wrote:
>
> > On Tue, 16 Jan 2024 at 11:49, Ritesh Kumar <quic_riteshk@quicinc.com> wrote:
> >> Enable Display Subsystem with Novatek NT36672E Panel
> >> on qcm6490 idp platform.
> > Is this panel always present on the IDP board or is it an optional
> > addon, like the panels for all the RBn boards?
>
> This panel is always present on the IDP board.

Ack, please drop the gpu chunk, fix other review comments and send  v2.

>
> >> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 100 +++++++++++++++++++++++
> >>   1 file changed, 100 insertions(+)
> >>


-- 
With best wishes
Dmitry

