Return-Path: <linux-kernel+bounces-96247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C88875931
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A564F1C209FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042A613A256;
	Thu,  7 Mar 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7ICLbZE"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B3A13B783
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709846655; cv=none; b=KFpTsxBB70vn74U5ZZ+aneqXPy4VXkLsPNwEH2aph0bsCFUIGXdPO5qQg2Fg9od/gfD2U9CaUwgsNKJupgyZhUehVOIr60BEuz5mJmVQc0jE2ViJbbZWvF27QQ08Q0Teyz3u+HqZ6WhqnVVfhKAXcnQz80MUepRLSXBs6W+WGr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709846655; c=relaxed/simple;
	bh=XhLpJmKl8D67t5fVzFGtRUMDvdKFUlQhaLIrJCBuf50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltH8q3mdmaXwa3cdPexiNw9a+5XKDZ7tP9Iz5BJlQZ0dWm8Oq2zbc0d5JdFnvQI55MOLmLrpP+1OyXK8fIJn3jvyZ5Iit4zS63G/JxUSmeS3k+BwPQsnnWMLiAp8CbXf07/sr4Wy9YZOQybFP+aqmH6OcOz1hLJn7yG7tKZthjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F7ICLbZE; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc745927098so1283193276.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 13:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709846652; x=1710451452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Lcyhwp0hIu6sGE2SbZMpxEJNdbFhr0oYQvghcO+6Mo=;
        b=F7ICLbZEgwjVHbluNp+5edKKrOv74ynP1U1dSsvvYIv0+lIXlH2LRS1eQ8IJuMpLdn
         FDySmb8/P0sgeswHZ3c7WAIGTbPeV9UN8V1DOa2nxobKYWTMMYykyk0dxYR8vp7EOMmI
         igmiVGK2ulQi0RTHCctZM0l2U4UxKZEqofBf4RAIzunff1GBOPNy/JeA6b3fXFYVilXC
         FjBa9mcAntvCVMIl/+iVzuzFXggt6tRYx+zBiJTdS0pIU0ytHNti+VeMssUmWAnOjiFd
         sjAibN13vtQPu9h41Q/GyUo7FEvtm3pJhbrnbdkJOjEYTiS5+hO0/fybJx6lRSNuXt46
         3PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709846652; x=1710451452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Lcyhwp0hIu6sGE2SbZMpxEJNdbFhr0oYQvghcO+6Mo=;
        b=coxllbFrn2cZnK0Me9bxNx7MeMltUNTyWEbBg019tyW3Uo3Z+KMtiNBtI6pCOuUyQl
         B/WPPbGC6chzPo+LJgQua1fh+TbW3ec8TOqyATLs3eNlfhTqBB2R7nWuWVUMqlnNt2Bk
         2wnLIan6aHvXMIFLH3btULtrncGZer1Gm+zWLb7YeN0NjCRU54ZhR0UwGf8wUFLC3jV6
         CIE4q3bcI/n2o0of94S0EZFEasBDZB89OEIvc1g1bNHjwV5VlzWIzc1DJTJPKUFZW3yl
         RiJfvHcwZpOKIhNOWvLFNWFsclEuDn55jMfXLdwPIUVHWoBH0BjkH9MJdDiGXL8To51/
         R9rw==
X-Forwarded-Encrypted: i=1; AJvYcCUSesOGfNszei9js5fypi2pvVabbDLAMp1Ca1N6UcV3v3rXm39WVXL0Clt5/iejvFeskQk/ertPwMNjF0Q0fx/jLEhwwoARf9J4LELz
X-Gm-Message-State: AOJu0YwOYCUZMOXU5iReBTTDF5bVFgL41UdOeoyzvEm0gpR5N2IQhXEA
	BGgareOiEu1xFCDvmzh+WYoOpkOZsvdE3SojHpjd+xhkxq4lO3zHUTSKleE4egnhaWRseC/4Hvl
	aCnlgapfGwakhrmHC8+BHNJCgbzrBHov15lb+M2JswHRgqC8R
X-Google-Smtp-Source: AGHT+IEZtKFfdvbPeUIrxS4XVLFE0P6vhrrsUowaIoDUL/3Q/uJbZtYQ3BrtlJvKHCcrPgR/wDY1Zvui/M/y85sx3Vw=
X-Received: by 2002:a25:dc12:0:b0:dcc:a5dc:e9d6 with SMTP id
 y18-20020a25dc12000000b00dcca5dce9d6mr17330947ybe.30.1709846652482; Thu, 07
 Mar 2024 13:24:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307093605.4142639-1-quic_msavaliy@quicinc.com>
 <CAA8EJprndszVSjAVs_UzAjhb+x1B1Of4JCkygZ=8kgzuY2RwCQ@mail.gmail.com>
 <25ec87af-c911-46b7-87c9-b21065d70f9f@quicinc.com> <CAA8EJprky=tFjJbGTBL7+9E=kqxQKjxB_RcmzHUt31GqUVfNmQ@mail.gmail.com>
 <eeefab74-1303-470f-bd3c-618d9522d24b@quicinc.com>
In-Reply-To: <eeefab74-1303-470f-bd3c-618d9522d24b@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 7 Mar 2024 23:24:01 +0200
Message-ID: <CAA8EJpqt5H03P-FkpJZCE-9N4=qnd9v+LxcehZmfO6xFz0w9UA@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: i2c-qcom-geni: Parse Error correctly in i2c GSI mode
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: konrad.dybcio@linaro.org, vkoul@kernel.org, andi.shyti@kernel.org, 
	wsa@kernel.org, linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	quic_vdadhani@quicinc.com, Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 22:58, Mukesh Kumar Savaliya
<quic_msavaliy@quicinc.com> wrote:
>
>
>
> On 3/7/2024 8:15 PM, Dmitry Baryshkov wrote:
> > On Thu, 7 Mar 2024 at 15:46, Mukesh Kumar Savaliya
> > <quic_msavaliy@quicinc.com> wrote:
> >>
> >>
> >>
> >>
> >> On 3/7/2024 3:23 PM, Dmitry Baryshkov wrote:
> >>> On Thu, 7 Mar 2024 at 11:36, Mukesh Kumar Savaliya
> >>> <quic_msavaliy@quicinc.com> wrote:


> >>>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> >>>> index 1c93864e0e4d..e3508d51fdc9 100644
> >>>> --- a/drivers/dma/qcom/gpi.c
> >>>> +++ b/drivers/dma/qcom/gpi.c
> >>>> @@ -1076,7 +1076,17 @@ static void gpi_process_xfer_compl_event(struct gchan *gchan,
> >>>>           dev_dbg(gpii->gpi_dev->dev, "Residue %d\n", result.residue);
> >>>>
> >>>>           dma_cookie_complete(&vd->tx);
> >>>> -       dmaengine_desc_get_callback_invoke(&vd->tx, &result);
> >>>> +       if (gchan->protocol == QCOM_GPI_I2C) {
> >>>> +               struct dmaengine_desc_callback cb;
> >>>> +               struct gpi_i2c_result *i2c;
> >>>> +
> >>>> +               dmaengine_desc_get_callback(&vd->tx, &cb);
> >>>> +               i2c = cb.callback_param;
> >>>> +               i2c->status = compl_event->status;
> >>>> +               dmaengine_desc_callback_invoke(&cb, &result);
> >>>> +       } else {
> >>>> +               dmaengine_desc_get_callback_invoke(&vd->tx, &result);
> >>>
> >>> Is there such error reporting for SPI or UART protocols?
> >>>
> >>
> >> Such errors are not there for SPI or UART because
> >> NACK/BUS_PROTO/ARB_LOST errors are protocol specific errors. These error
> >> comes in
> >> middle of the transfers. As these are like expected protocol errors
> >> depending on the slave device/s response.
> >
> > Yes, these particular errors are I2C specific. My question was more
> > generic: do we have any similar errors for SPI or UART GENI protocols
> > that we should report from GPI to the corresponding driver?
> >
>
> Got it. Reviewed and confirming that UART and SPI GENI drivers doesn't
> have such error bits unlike I2C, it simply reports transfer fail OR
> success.

Thank you for the confirmation!


-- 
With best wishes
Dmitry

