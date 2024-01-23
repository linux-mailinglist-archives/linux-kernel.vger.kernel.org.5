Return-Path: <linux-kernel+bounces-35685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BB283951C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C5E1F2DFE0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015BE81AC6;
	Tue, 23 Jan 2024 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxZqdEO1"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D577F7E2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028008; cv=none; b=rgomsW1dYS+cXp9gRpq3C9CzjxkI4u69EyFNL5WfCRm9y9RfW5Dt3ECYPsvmNPzRIRpnuOSQr1deifwsSG3wRWnjZtB2q1SvsgxHJO5ng+vZj5bIo8yamBiX22cvI4QlWO5wvwvcc9tegJf+3omt4WPNsEvgjPqYEDF+8n4lePU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028008; c=relaxed/simple;
	bh=/Lxu3ibdZFwYSpIB8dDpNCNVTxZpLUd0wwrOHEKIIQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdoiL1Uuyrs9eO43mhFNVNlkNeGSsFswMI4yCB8vQweASMM9MNCkCPNrXeUv9dzfb7FfSO23wr9cduyXT++LYnWFP6AOvTJfQp9Sa98PTLii0p29wkLt6DKGoZw2PNfgKeKGx+qHEzgniPd3hqOzHL2mYolBDUjPKfFiYPwV3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dxZqdEO1; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ff790d41bdso31702567b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706028006; x=1706632806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kYAfHM7R7rnCSNUY4kqAV2WMKXhdQppzOOG2/3x8MBw=;
        b=dxZqdEO1gwZXch2pvaryaG1ruVjEpNldw2gEI+BcuOJsGkzssciyTeEPBs1En7uh5q
         EXfWLKmnsDISDuT2cY/6l9h8RGTcX+hlvyv2mIp52ngVPbhdirRaewI5cU9l5eqcLQ+3
         WT6Puk8/uxKKjGjCAQRO4Q/Hf4kVPdWi/g/AZ/pWcRthujHpiT1kU3EyyzV51pTeRrvt
         xmLXThbQRUikjifQn3JJnG5Aeaee/RkI0TsS3jOLE//JD8b/upxGb0hfi+Lc3iuRzXbs
         g5l6Y1Q5KX1aWqrlF/CxuoLeOu5cTmOfNzINjfpvctP2gMEqCnMI11/Lqv40jw7e805m
         +Wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706028006; x=1706632806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYAfHM7R7rnCSNUY4kqAV2WMKXhdQppzOOG2/3x8MBw=;
        b=ArOouiF59xABmsh7tcEt57nls+zn/0Tl097Z7KPEjyag4tVwTtUw7WraoVjDXDGiXd
         ic0FsFNw+AaRs0hBnq8a7pRaIJ8I4Cl7aFNeThq0dreTawotszB6A1Kmn8HrGexpv3s8
         qxhLpKAMHax//9q0ksvVR7eshZC8gyYG/zvwYNj0+xXoxiSLmty1VLHZZxa/ZW26HVp0
         melJOhw/he+v3qUx5ymshXzxXeKqsZnee5yLx3mMXF8mz4lOu3jgXVTtGil/r29ZskZx
         VfEc366G2BNfy3f976CMi7fbNwzOCAJlRrooI6VjrkDxJLdth2b23pECxdzXZzM8jZk1
         1/4w==
X-Gm-Message-State: AOJu0Ywgf+4m4Hb5j8esIkx9vWx7I9QAWRottFNI9UrFwjs4xRZdMYXK
	3J1HjkfbXfaGK1LK4ij2IMh1WQmeHvIwQjP4yfsn57pB04Jn8qYUB2E64RMrMCsUmaLsWauhFjX
	0MXDIpFF8LGC3LSvFCs9RG4DPhP4Ydq/EliaTeA==
X-Google-Smtp-Source: AGHT+IGC6FCCx/JUl5ZF8p8TNRTwdcBW/FXg69irqngvfoaQBTfEyAlrxYiVawNtHkSVTMOs3vcjUvi8P3kIalAiNeE=
X-Received: by 2002:a0d:ca95:0:b0:5ff:e530:eeaf with SMTP id
 m143-20020a0dca95000000b005ffe530eeafmr3085307ywd.2.1706028005745; Tue, 23
 Jan 2024 08:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706026160-17520-1-git-send-email-mantas@8devices.com> <1706026160-17520-3-git-send-email-mantas@8devices.com>
In-Reply-To: <1706026160-17520-3-git-send-email-mantas@8devices.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jan 2024 18:39:54 +0200
Message-ID: <CAA8EJpqLYmpAt5D6g01Urg21ie7PpHkj3DRuxkqm6Epanzuksw@mail.gmail.com>
Subject: Re: [PATCH 2/2] phy: qcom-qmp-usb: fix serdes init sequence for IPQ6018
To: Mantas Pucka <mantas@8devices.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 18:10, Mantas Pucka <mantas@8devices.com> wrote:
>
> Commit 23fd679249df ("phy: qcom-qmp: add USB3 PHY support for IPQ6018")
> noted that IPQ6018 init is identical to IPQ8074. Yet downstream uses
> separate serdes init sequence for IPQ6018. Since already existing IPQ9574
> serdes init sequence is identical, just reuse it and fix failing USB3 mode
> in IPQ6018.
>
> Fixes: 23fd679249df ("phy: qcom-qmp: add USB3 PHY support for IPQ6018")
> Signed-off-by: Mantas Pucka <mantas@8devices.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

