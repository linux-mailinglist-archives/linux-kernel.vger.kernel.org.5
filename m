Return-Path: <linux-kernel+bounces-151672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D918AB1E0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D6E2820A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8FC12F38C;
	Fri, 19 Apr 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDM5Juur"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B0912E1D2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540675; cv=none; b=gHJIAexLsfeL8PaF/ew7SmQfIwKVTu5qHnA6JWqJzWZROHoeLDqWI4b7+mDid8NHc8DgFcwCRrbGm2+o1kWlKdpfXwD/dEpkB9KWJhm3w2kPuUb7T3LkdCiur45kHasFQF0aK3zIsDkOeatnA/OTfhgjtxDTpbuSG+nKeZ5E9DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540675; c=relaxed/simple;
	bh=iyORyWpSBMWMCLstc8MOWi6t89RmrF3ru6q2Rw2Q2Y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcHYl0ERjiBiwL/XP5AqTmcM/quV87RlBNbiJhwhyubrg5Rz+ZFtQIxQiS8SgeJT2W4vyi4G2LKJnZ2cA5Jz+3LFtcdzNcWUbIumshIEDVVQ1RKbEo5EKhJMSCWa/p3YSBLPP5QJYc1/tPPPj0cxEhUqJcqZK5soUOAUecBWSmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jDM5Juur; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de45e5c3c68so2454512276.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713540673; x=1714145473; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UOhFLujYxKZnKXu9a33FDTIua+PpsCvzUprH7ByhBWw=;
        b=jDM5Juur0PD7bkKzTsca2p4Iv7TQMDnIOcLIdCImTY4dpZrd0MBZXlX8A0pvyRzuC7
         o/9dxPoJxl93uOgMHDdERKvoJ+Qc20Ni45M3uaRCdXNyUgO7v2qr85nMVvQt34BNxw/k
         sc7QkMAHA1iZqoRNDJLrrb8mzJRCEe2+a707nbKvFoSxyk+FNCwFTPMZghjoj6pYpJMs
         dSvpptkmR9FlUfc8AGJmjbqXhoDlnnmIDNTWmN04wj+SFvgastH43z9+E4gZY5PxbhHA
         jyg4feK1MFUNrezVvh0DMis0HDTU5X2l2gP9b1TwqiqiQnu6n59IAEfC9aZBY7brFeXL
         jMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713540673; x=1714145473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UOhFLujYxKZnKXu9a33FDTIua+PpsCvzUprH7ByhBWw=;
        b=EqbyfCRhdkZ7gqFe8PVamgyFb54tYoAlqt159zi4pG+pTat/HsA/XEQrFUASO2sq7U
         7oFtV2HtYPMzk35QKHi39CeG0UcXBkdJkUEme5jkw+U7MUzRe/Exlx4figQrcWfT/v+/
         VAfaw12r3pvShBUcHWBzsdemWWSpZe5T5txxSkitlI50mbaql+GEkerqODRpxnWAGj8m
         2aKBNZjMGRRkAsdM79IxwDSzHvleHFZjHn7zwF09mmKIlUSiUsens7KjI7H5xqq70KYY
         87qCRgJHeCJXwmxOSY9OVjSm7kmhNSEVDJ3+19cx7kJBu/TXv96mrAOfcLf1EqfbJb/K
         p8dA==
X-Forwarded-Encrypted: i=1; AJvYcCVCIrBph2H4ai6u2Bg9p7cgcGffn8m0cBlWEOfos0nYp/InQaK85/yuYUtY/mU0sAWgCnf4X2UyXudAn9FD1QYLVX7K3nxkXMfPMvT+
X-Gm-Message-State: AOJu0YwG7sd9luftHTY7yV2eMD2LX+9kAY8cu8ps4cXd5q8xqeqj23EC
	87DwLblOeqEJPiJxoap8HRGkbaLiIhVMKPHRIt8RVfNuWCnEL93Gpfm61gTu2eTdvqRu6VQ6Xfn
	Ch9ElIgpzlCbtMCd+5KH1l7lQzP96HfNpgulXSQ==
X-Google-Smtp-Source: AGHT+IFuq+KlOolhiQ+NHAAq8t1+6TVTfRh2XE/ClYxC+SNRITjdX3YHAzkPtLbPf7S1Y9gyH6+1IPTqOXEALwqSWu0=
X-Received: by 2002:a25:ceca:0:b0:de4:5d8f:eca8 with SMTP id
 x193-20020a25ceca000000b00de45d8feca8mr2363800ybe.5.1713540673130; Fri, 19
 Apr 2024 08:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403043416.3800259-1-sumit.garg@linaro.org>
 <CAFA6WYNxTPgiq6WLQaKGMTenuKe51SXXhgGYkdyRibghXAMfnA@mail.gmail.com> <CAFA6WYPk6E8JM8z62Skxq454WwPFYQ9EDx7FD--inqe7YoNJkg@mail.gmail.com>
In-Reply-To: <CAFA6WYPk6E8JM8z62Skxq454WwPFYQ9EDx7FD--inqe7YoNJkg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 19 Apr 2024 18:31:02 +0300
Message-ID: <CAA8EJpont5jn9X24saBiM_TVRNh9984xoRXFojj-wmTiK0nU+g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
To: Sumit Garg <sumit.garg@linaro.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, stephan@gerhold.net, 
	caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
	laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com, 
	jimmy.lalande@se.com, benjamin.missey@non.se.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Apr 2024 at 18:27, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Tue, 9 Apr 2024 at 23:24, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Bjorn, Konrad,
> >
> > On Wed, 3 Apr 2024 at 10:04, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> > > Box Core board based on the Qualcomm APQ8016E SoC. For more information
> > > refer to the product page [1].
> > >
> > > One of the major difference from db410c is serial port where HMIBSC board
> > > uses UART1 as the debug console with a default RS232 mode (UART1 mode mux
> > > configured via gpio99 and gpio100).
> > >
> > > Support for Schneider Electric HMIBSC. Features:
> > > - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > > - 1GiB RAM
> > > - 8GiB eMMC, SD slot
> > > - WiFi and Bluetooth
> > > - 2x Host, 1x Device USB port
> > > - HDMI
> > > - Discrete TPM2 chip over SPI
> > > - USB ethernet adaptors (soldered)
> > >
> > > This series is a v2 since v1 of this DTS file has been reviewed on the
> > > U-Boot mailing list [2].
> > >
> > > Changes in v5:
> > > - Addressed another nitpick from Stephen.
> > > - Collected Stephen's review tag.
> > > - Warnings reported by Rob's DT check bot aren't related to HMIBSC
> > >   board DTS but rather they are due to msm8916.dtsi or extcon-usb-gpio.txt
> > >   still not converted to YAML format.
> > >
> >
> > I haven't seen any further comments on this series, can you help to pick it up?
>
> Gentle reminder.

I see an email from Rob. At least GPIO-related warnings are related to HMIBSC


-- 
With best wishes
Dmitry

