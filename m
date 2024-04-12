Return-Path: <linux-kernel+bounces-142599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4510E8A2DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6898E1C211BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ACB5730A;
	Fri, 12 Apr 2024 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ozIHY03/"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB5055E43
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921802; cv=none; b=i3ZpJQpqjc25NT4K64Kbrqduj5DItELkbymFPP6zUMZkTHsbd92wsqbair/jgrQBeINMdfkYQWi6UIuBcO+Zm9J7Nn/0ijIWcPB7kunPBGPBuT9jQZKRbgIED1INThGsxcIjKJ4Hb2fGQU8sZBsHoi7XxxDBgJnqlCCp+8ZmDAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921802; c=relaxed/simple;
	bh=JQmPULKAKKMI1B10Eze+iMKfEwwEb7vwyYQxdaJovBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjblRYZ36BlI1IsAPmuPGLosT5GQV/mmkcxGRp8WXSXnAs4Jub6H1FSHjuLbHEJNrzwIptu2IBLTTcuxlHqS8PmkkDDi7ht6qW2vxvVWIrpb1qJA0pXwG98V5rUwnG15AQ3PbueZfjM/lpoUxa50ceyju09Vb2pwXe2jv1/FtNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ozIHY03/; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcc73148611so889623276.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712921799; x=1713526599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HGBpkgffnv2itiKDdWNZjHSJUW/0KojY7TNsqJx4VxA=;
        b=ozIHY03/UyhkUBxCuOJ3SJ7H+fiafgTqHbekvVetJndq0h1fQl3JB3hETFBxiABUoe
         WNeFY3Wr45UeP4Wn5C5w+5/j4BOAEQVI4SdQ4b87QEcmGhT7LjgukUGwRO5nA6NI6M2o
         h3HbL4Sp/ZrkmpHUUkkY695z1F5txgS5QY+d69lxKeTyQkOe66lvjJZjWXH1ReYqVymH
         ROkYiMlE3aNSDJyE0neN7nHM9uEDe+gu0Vr91RMuikzH9pzeHI5nMcwSTBZR/boWZxJl
         0faFsn//NLpDNhYYJ050DSgmMvEhzjjnLZ4e0E7emrPzlogSmheO8x3ggNR9RGpu9Z9s
         tSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712921800; x=1713526600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGBpkgffnv2itiKDdWNZjHSJUW/0KojY7TNsqJx4VxA=;
        b=ZlUfyhlZOJVTcWlIcDpHu1VndG2NHwK7/+8RH4Y7K8WK36QTrrFDph03PBB84cKf+1
         FLasY0KyJV+/in7ZTPzLnrSWVR6RdKX9KexrSNrFpuHos4ngrKAHhe6Iwi3goO+1BsBC
         yY9CDvlzWw+tc2XJ4AetDyzhOo5AJGKfDeqwCa7JRhyoChXLAObfmikLc63hXgOTjKbZ
         qYEmdQs9kV8PqtSHNlvUg0kUc4mqwYyZBFCseHR7RMkR3jZ+kTcCKVsgOoFH0kD38G2R
         EWtWBOHKe4+otRroDpvpiqTy+ejbQ8hpFpJTpjN1C5qAzY6ch6wG/1nZ/gLx9J72zOcl
         DBXg==
X-Forwarded-Encrypted: i=1; AJvYcCW3NG252YObtJXRrYVCSAAba0GMC6fOgiEXI8q0pA6hMqMyTRdvPyIGOM32gztxfGYOReRSXTrd8luL2stiJ15GjlReTyGpWp5akqCM
X-Gm-Message-State: AOJu0YzFxIhkrh4UXvS7hQ9xWZpSb8p3qQFuYGzRA0sU7jOnK867qN0p
	6fWii71XQPoYxqjrpoNrrajMOoc5kvc/w40t/7WMwIC8eJtaxYbRcDVhVFrVmWCKf/5GK2qVWN6
	/DCkX4c+/mlwhH39ztzMdHcWMlYFSa3voGT3aypj9KR628XYu
X-Google-Smtp-Source: AGHT+IHSEEns6ewLu8Mz5Jc/NCzdVzTmaahZgvNMBsPgn/554HUcVdF/3+cHuruSXAD2cV8kdZ7nUOSKbuFnxHo5JRw=
X-Received: by 2002:a05:6902:150b:b0:dc6:4d0c:e9de with SMTP id
 q11-20020a056902150b00b00dc64d0ce9demr2486954ybu.0.1712921799663; Fri, 12 Apr
 2024 04:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com>
 <20240411-pm8xxx-vibrator-new-design-v9-2-7bf56cb92b28@quicinc.com>
 <CAA8EJpoL9vCAUgWmHcoxppo_gJqaw_xqdYqcJkS6Xza-5aSh3A@mail.gmail.com>
 <fa6c8b30-11f3-bd80-67cb-713e4348eccf@quicinc.com> <CAA8EJpqa=5yaTRHuEiYynTDFy53YPFk4R3q_EV8rmsBN1iR5fA@mail.gmail.com>
 <00b8cea6-fed2-4224-8aeb-c731dc1b666f@quicinc.com>
In-Reply-To: <00b8cea6-fed2-4224-8aeb-c731dc1b666f@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 12 Apr 2024 14:36:32 +0300
Message-ID: <CAA8EJpoCYb=3=YVBe+xYO+ccUMLzddwY-jsdT6HuFNvE5GyoPQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] input: pm8xxx-vibrator: refactor to support new
 SPMI vibrator
To: Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: kernel@quicinc.com, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Apr 2024 at 06:41, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
>
>
>
> On 4/11/2024 10:05 PM, Dmitry Baryshkov wrote:
> > On Thu, 11 Apr 2024 at 16:45, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 2024/4/11 18:58, Dmitry Baryshkov wrote:
> >>> On Thu, 11 Apr 2024 at 11:32, Fenglin Wu via B4 Relay
> >>> <devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
> >>>>
> >>>> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> >>>>
> >>>> Currently, vibrator control register addresses are hard coded,
> >>>> including the base address and offsets, it's not flexible to
> >>>> support new SPMI vibrator module which is usually included in
> >>>> different PMICs with different base address. Refactor it by using
> >>>> the base address defined in devicetree.
> >>>>
> >>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> >>>> ---
> >>>>    drivers/input/misc/pm8xxx-vibrator.c | 42 ++++++++++++++++++++++++------------
> >>>>    1 file changed, 28 insertions(+), 14 deletions(-)
> >>>>
> >>>> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
> >>>> index 89f0f1c810d8..2959edca8eb9 100644
> >>>> --- a/drivers/input/misc/pm8xxx-vibrator.c
> >>>> +++ b/drivers/input/misc/pm8xxx-vibrator.c
> >>>> @@ -20,26 +20,26 @@
> >>>>    #define MAX_FF_SPEED           0xff
> >>>>
> >>>>    struct pm8xxx_regs {
> >>>> -       unsigned int enable_addr;
> >>>> +       unsigned int enable_offset;
> >>>>           unsigned int enable_mask;
> >>>>
> >>>> -       unsigned int drv_addr;
> >>>> +       unsigned int drv_offset;
> >>>>           unsigned int drv_mask;
> >>>>           unsigned int drv_shift;
> >>>>           unsigned int drv_en_manual_mask;
> >>>>    };
> >>>>
> >>>>    static const struct pm8xxx_regs pm8058_regs = {
> >>>> -       .drv_addr = 0x4A,
> >>>> +       .drv_offset = 0x4A,
> >>>
> >>> If the DT already has reg = <0x4a> and you add drv_offset = 0x4a,
> >>> which register will be used by the driver?
> >>>
> >>> Also, while we are at it, please downcase all the hex numbers that you
> >>> are touching.
> >>>
> >> For SSBI vibrator, the "reg" value defined in DT is not used, see below.
> >>
> >>
> >>>>           .drv_mask = 0xf8,
> >>>>           .drv_shift = 3,
> >>>>           .drv_en_manual_mask = 0xfc,
> >>>>    };
> >>>>
> >>>>    static struct pm8xxx_regs pm8916_regs = {
> >>>> -       .enable_addr = 0xc046,
> >>>> +       .enable_offset = 0x46,
> >>
> >> [...]
> >>
> >>>> @@ -170,7 +173,7 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
> >>>>           struct pm8xxx_vib *vib;
> >>>>           struct input_dev *input_dev;
> >>>>           int error;
> >>>> -       unsigned int val;
> >>>> +       unsigned int val, reg_base = 0;
> >>>>           const struct pm8xxx_regs *regs;
> >>>>
> >>>>           vib = devm_kzalloc(&pdev->dev, sizeof(*vib), GFP_KERNEL);
> >>>> @@ -190,13 +193,24 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
> >>>>
> >>>>           regs = of_device_get_match_data(&pdev->dev);
> >>>>
> >>>> +       if (regs->enable_offset != 0) {
> >>>> +               error = fwnode_property_read_u32(pdev->dev.fwnode, "reg", &reg_base);
> >>>> +               if (error < 0) {
> >>>> +                       dev_err(&pdev->dev, "Failed to read reg address, rc=%d\n", error);
> >>>> +                       return error;
> >>>> +               }
> >>>> +       }
> >>>> +
> >>>> +       vib->enable_addr = reg_base + regs->enable_offset;
> >>>> +       vib->drv_addr = reg_base + regs->drv_offset;
> >>
> >> The reg_base is initialized as 0 and it is assigned as the "reg" value
> >> defined in DT only for SPMI vibrators.
> >
> > Please don't. This is counterintuitive. We have reg in DT. We should
> > be using it.
> >
> Hmm, the original driver doesn't use the reg value defined in DT at all,
> Anyway, I can make the SSBI offset to 0, so the base address defined in
> the DT will be always added regardless of SSBI or SPMI vibrator. Let me
> know.

Yes, please. This follows the logic of the SPMI change too.

> Thanks
>
> >>
> >>>> +
> >>>>           /* operate in manual mode */
> >>>> -       error = regmap_read(vib->regmap, regs->drv_addr, &val);
> >>>> +       error = regmap_read(vib->regmap, vib->drv_addr, &val);
> >>>>           if (error < 0)
> >>>>                   return error;
> >>>>
> >>>>           val &= regs->drv_en_manual_mask;
> >>>> -       error = regmap_write(vib->regmap, regs->drv_addr, val);
> >>>> +       error = regmap_write(vib->regmap, vib->drv_addr, val);
> >>>>           if (error < 0)
> >>>>                   return error;
> >>>>
> >>>>
> >>>> --
> >>>> 2.25.1
> >>>>
> >>>>
> >>>
> >>>
> >
> >
> >



-- 
With best wishes
Dmitry

