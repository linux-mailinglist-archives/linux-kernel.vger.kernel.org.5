Return-Path: <linux-kernel+bounces-57942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6B784DF51
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9C81C2903E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D406EB4B;
	Thu,  8 Feb 2024 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKrdyjPV"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922185427E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390268; cv=none; b=Z+n52Cqtm1YeuxZ5V0SUGesHHpJmB3FEt9Slnx1gT+1H5x+hZ6bOedKuCQeimNHb6v6N2bUDluSkPPflxo1te/XTIuGVcxROOIf2YbM+JALq0YazuVJres0O/3koH3Hk2SqLi9yMFtKmbuXX+meK3pVsMa4RCG76896dCspM/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390268; c=relaxed/simple;
	bh=M+dRcp4Mdg3swizMqeWm8YTp95g9PXZ/wHhoSa3YnNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyGwUSYsRQSo54Qhz5shf159orvYoSyuWbC/vqGP6QSyKLJ2quGJ9l5woWwlbxFCCOaP62EM9XFbhRgg8o+B61AzYPXX8OrOnRwfJE5UI0jW4iXV5XU25wC4gXkZ9VjwApRR5iXOcnUopB28xsvkOJ99EP9hz5YXhPe6rBmeYKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bKrdyjPV; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-db3a09e96daso1634668276.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 03:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707390265; x=1707995065; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E20n7hLeTsUtRZUlgw3etseFcnhWUpdK3reOyYMqK5E=;
        b=bKrdyjPVW+/8ztLhVFJ5J5j8My1PmgpxfYr4pvL14Kx9cdV8qRajmh+ebUTwMIqnKc
         /U8ZbT4+2RQtER1Q7Hdoy04dL9jzsZOj2GLz/6F5rqmCtgYeoUQkwiro3r7GXdhcc4tm
         CmVThu0RtU1IvdtcooxLHyVB5KAvmln349KEw8LWrztc/xeZkCF17+kwHuDhBxK3Li7G
         uq/VL0ChQOt/Za+Wq3Zdp+J+NrSJNQhWW34FDynHLzm/VsGzWwqp6J6v8S2mJlEAAhJB
         gLtGz8ycvLvZzk6M5sWnvET9iZHBb7F4RvgYhRJ1viOm5h4/mRkAaCXY7OrCY01bnkxt
         mijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707390265; x=1707995065;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E20n7hLeTsUtRZUlgw3etseFcnhWUpdK3reOyYMqK5E=;
        b=VU5xYJdb9Vpz7P1vYL5Fp+UnHY8Ff7HcneCo/Ongyk8ZN47dI6q6d0d9i1VO6pQkSL
         bVtMBQ9yGdLp0bcWuK5LNxTRRBAS3JU1OwBFzbj8TyXD95dGxk97uMb3wj1MxQxn1Ss7
         mghjuDxvgitVpyCy4R7fzUwkjqX0GHNqBcjqHd6lctUtlnPEISFqwrm8fLykqt0go8Za
         eYDPza/UoafGvjvMG+p2drHoA8DjDq885vfeYYkpqQoVNVm9zJ5h9ZT1Gr9Fe2KZ9QZt
         c7Cn3Xc/i9Y5yaZ9yx2rfCK1cC4uui11Z9f8lxjevvSUU2WvAo9nZ/cxEStgcDGMPsiX
         2NRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbzWxh0/tSS12j/4vgFVzz9FeBbrtFDGojF0UQN8p6HusHt7FsVDbtyACX00pGkh1vYugrp6ih4TBZLVax7prVeHDusuBtG8lxrmr9
X-Gm-Message-State: AOJu0Yz3wkUa9B99Zx2IX7fC157HnFNXeVaGaOdUGAUrcqAqPjop9tpz
	Qim70vR59mR37/tAqRTluEwjZSmqFXKIEkMJ2deICTrlDhMVkiwO0Z7T5u7TGvgc4PCSFuwMiHx
	6ePe7Xk8KYG+2ts50PN5UVpbJ8YNSFfo/dGPSAQ==
X-Google-Smtp-Source: AGHT+IGH6rdGfZLnWOM4BwmqKZJ//O8CWQTsF9VAkaFLM7YEQKP6ujHgl3G6xP1O6Q/bGTCGVocyNtRUwa1dAw1KBgM=
X-Received: by 2002:a05:6902:1243:b0:dc6:c2b2:c039 with SMTP id
 t3-20020a056902124300b00dc6c2b2c039mr7995213ybu.41.1707390265487; Thu, 08 Feb
 2024 03:04:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201101323.13676-1-quic_vdadhani@quicinc.com>
 <CAA8EJpqQtHDRK2pex+5F-fMRTosJuFCx59e89MWhnie1O3dHKA@mail.gmail.com>
 <60b5e755-352b-476d-8c6e-2170594ae80d@quicinc.com> <uswznu3h53gcefpdc4vxozz32ecdcjvzmr7admwc4h54o27bfy@qqoevrl3dcyt>
In-Reply-To: <uswznu3h53gcefpdc4vxozz32ecdcjvzmr7admwc4h54o27bfy@qqoevrl3dcyt>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 8 Feb 2024 13:04:14 +0200
Message-ID: <CAA8EJpqzdp4xYSp+JCExP+Oeu9KhLpsXNUbDxfZ0g+C07xR6dg@mail.gmail.com>
Subject: Re: [V3] i2c: i2c-qcom-geni: Correct I2C TRE sequence
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Viken Dadhaniya <quic_vdadhani@quicinc.com>, andersson@kernel.org, 
	konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, 
	quic_bjorande@quicinc.com, manivannan.sadhasivam@linaro.org, 
	bryan.odonoghue@linaro.org, quic_msavaliy@quicinc.com, 
	quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Feb 2024 at 12:02, Andi Shyti <andi.shyti@kernel.org> wrote:
>
> Hi Viken, Dmitry,
>
> On Fri, Feb 02, 2024 at 04:13:06PM +0530, Viken Dadhaniya wrote:
> >
> > On 2/1/2024 5:24 PM, Dmitry Baryshkov wrote:
> > > On Thu, 1 Feb 2024 at 12:13, Viken Dadhaniya <quic_vdadhani@quicinc.com> wrote:
> > > >
> > > > For i2c read operation in GSI mode, we are getting timeout
> > > > due to malformed TRE basically incorrect TRE sequence
> > > > in gpi(drivers/dma/qcom/gpi.c) driver.
> > > >
> > > > TRE stands for Transfer Ring Element - which is basically an element with
> > > > size of 4 words. It contains all information like slave address,
> > > > clk divider, dma address value data size etc).
> > > >
> > > > Mainly we have 3 TREs(Config, GO and DMA tre).
> > > > - CONFIG TRE : consists of internal register configuration which is
> > > >                 required before start of the transfer.
> > > > - DMA TRE :    contains DDR/Memory address, called as DMA descriptor.
> > > > - GO TRE :     contains Transfer directions, slave ID, Delay flags, Length
> > > >                 of the transfer.
> > > >
> > > > Driver calls GPI driver API to config each TRE depending on the protocol.
> > > > If we see GPI driver, for RX operation we are configuring DMA tre and
> > > > for TX operation we are configuring GO tre.
> > > >
> > > > For read operation tre sequence will be as below which is not aligned
> > > > to hardware programming guide.
> > > >
> > > > - CONFIG tre
> > > > - DMA tre
> > > > - GO tre
> > > >
> > > > As per Qualcomm's internal Hardware Programming Guide, we should configure
> > > > TREs in below sequence for any RX only transfer.
> > > >
> > > > - CONFIG tre
> > > > - GO tre
> > > > - DMA tre
> > > >
> > > > In summary, for RX only transfers, we are reordering DMA and GO TREs.
> > > > Tested covering i2c read/write transfer on QCM6490 RB3 board.
> > >
> > > This hasn't improved. You must describe what is the connection between
> > > TRE types and the geni_i2c_gpi calls.
> > > It is not obvious until somebody looks into the GPI DMA driver.
> > >
> > > Another point, for some reason you are still using just the patch
> > > version in email subject. Please fix your setup so that the email
> > > subject also includes the `[PATCH` part in the subject, which is there
> > > by default.
> > > Hint: git format-patch -1 -v4 will do that for you without a need to
> > > correct anything afterwards.
> > >
> >
> > At high level, let me explain the I2C to GPI driver flow in general.
> >
> > I2C driver calls GPI driver exposed functions which will prepare all the
> > TREs as per programming guide and
> > queues to the GPI DMA engine for execution. Upon completion of the Transfer,
> > GPI DMA engine will generate an
> > interrupt which will be handled inside the GPIO driver. Then GPI driver will
> > call DMA framework registered callback by i2c.
> > Upon receiving this callback, i2c driver marks the transfer completion.
>
> Any news about this? Dmitry do you still have concerns? We can
> add this last description in the commit log, as well, if needed.

I was looking for pretty simple addition to the commit message, that
links existing commit message to the actual source code change: that
geni_i2c_gpi(I2C_WRITE) results in the GO TRE and
geni_i2c_gpi(I2C_READ) generates DMA TRE. But I haven't seen anything
sensible up to now. So far we have a nice description of required
programming sequence in terms of CONFIG, GO, DMA TREs and then source
code change that seems completely unrelated to the commit message,
unless one actually goes deep into the corresponding GPI DMA driver.

-- 
With best wishes
Dmitry

