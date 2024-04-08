Return-Path: <linux-kernel+bounces-135195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3CB89BC8F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CCB1C21CF2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D595D52F71;
	Mon,  8 Apr 2024 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AliY2OXz"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2694C5339B;
	Mon,  8 Apr 2024 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570544; cv=none; b=F/2Fq+3ek+LN0Mmd+89K2pjPW1eR7/03E7rys6XviahpyQ8CzpM7JSDuUcxeM1l++Uj5l5xJ/MgfHqvwRu5CTTpLhZuPtLaG2PiGQ9FSIwtIz/uNZIl3v8hZz4gHXGxJNBk+wBK69tCP2PPNxbaFO21mvE+a/6Qeg+Ht1/tQ9Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570544; c=relaxed/simple;
	bh=G0ku0dDFdTLc1pYqQSxUGgaQIlylzP539QExCGqMIzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vjgw5ynr8hWpGHtAZIaKy5UdKn/k3J4WSXID9AZ0a4wP19dPfyS3cxqjt9G+wbxlIOjE/RxYCn7FU2A2CgkqJncywdcWBe8V2zqs2CR+mQNwD/RxFBCuY/Ls9DXcbM+blk24dmMxtbplEibbBEcfL9MmkLBTzymmHYH2xnZs4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AliY2OXz; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-22edb0ca19bso2071419fac.2;
        Mon, 08 Apr 2024 03:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712570542; x=1713175342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPEmMPD9A+hZEcFAt1PdPzHj0S7+4U/Ump7cFa0dIPw=;
        b=AliY2OXzoJZYps1a/PkvLY+MsS4eja4OpveLMbdA+77tDLqidy0Gks+TsS3F5Cnl00
         zS9joIVnv48jkvBAy1NazStsB+u9o43ni8R9kfXu4kBG/wt2tWzljKS9rE+pKMUVT3LD
         TZ0r53h9N/iLbwxVk9pHKPHkzu2Q4F570Jx7x5OzMijBFVJsWKoDiaj6l+/FeuABnlZU
         dLkVSR+X7+C9kalsRwN69G3Mx7JTQFJ4dC6FrUEpv3Ak7cfI/Pef7kQjQ1S/gyiyUvvI
         x3NiZqVJ6qUX1cDBypM2nP6izIIo4SUzNVKhVujfZpk6geWxMCRKnU/SbRQB5tqYGszN
         bOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712570542; x=1713175342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPEmMPD9A+hZEcFAt1PdPzHj0S7+4U/Ump7cFa0dIPw=;
        b=QWj12NREEMV02+X1lFznevWhJ3LDDPeifSTeJ4YsYtc+iXg0SpvTflKIINdN2Abkpt
         ECmBG4pWqnE25Wdm8vHMVf1FEa+/KhttNR6soAIubB9RzDe6nMV1Gnr84fQ+1YEaTLkF
         Dli6hKzFlgIKAD4fdeOeEN16nfEhdPPe+CFgy4vdas8e9UDC/wNb0DP0jt3kEcrqXrU5
         ccOMLETejRmuSx//4TOAyEA7xCBSFwoP3qBbFd5tBHBJf8Nx4tFqZOo1T7CbjrxjNOL2
         oNdLSDLHOlvmhD4mFiUJIR0aL2c47A2UllqiTVkguI02BmzWc3IDmYdE1xDtf1xhlOau
         ieAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsk/+TwXEjjJ6vW4k00w3s4PrieN6A27l0f8ALh4gvUCA70iQ4JatvgTnhsrkHaVSZ1uSNbBFvgmLn96+vWS+2PYzd/CpZiNQo2Jor20BAvRFi7UPYFtuW3vS103bQlKD4/XPD2LF+IK40o/Yr/ObNpkSWMVMRuStYtOQCnxd6q3Mujx0SHlkBjF0=
X-Gm-Message-State: AOJu0YxJonxgH4YYq+PvO5sWp/LmGv08h+6n5Vkbe5ZFVrgq6w1jAZ4J
	KfF0QSuHUgEmMY6M5b/rJXSu4rQcfihBSqGqI5egv3Vq9udnB1BJ4JPOpt5l5PasPa4PR3MtvhH
	5mZmr4iYb2pn3ttjEs06P8WiT+E0=
X-Google-Smtp-Source: AGHT+IEmpFRODcH4mOqBevHssvRTSi09L5ZlGtdmOwaxO0NzU0IoOHDQYE5m0GIfABZy5itcHhOErpFNTK2Kf3HzlBk=
X-Received: by 2002:a05:6870:3927:b0:221:bcde:29cc with SMTP id
 b39-20020a056870392700b00221bcde29ccmr9107148oap.21.1712570542235; Mon, 08
 Apr 2024 03:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301193831.3346-1-linux.amoon@gmail.com> <20240301193831.3346-4-linux.amoon@gmail.com>
 <52158bf6-16fe-4ce2-b9b6-bbc6550a6e14@wanadoo.fr> <CANAwSgTCaSSMN2QCw5fr=RBp0WwWaLuebzQDO=scnABNFNctJQ@mail.gmail.com>
 <e85ad80f-af7d-4eaf-9d14-dff13451f7e5@wanadoo.fr> <CANAwSgRrOw+6MHLPDP8RwLwzwB1EVGBTovtR2ChhqR3b5uWowA@mail.gmail.com>
 <CANAwSgQk10=K6Z5OzvT3OUncfr6BWyx7oH2JKN5CJAnS+uO7QQ@mail.gmail.com> <ed5153e1-f4de-4268-a9d0-e74b779d2587@wanadoo.fr>
In-Reply-To: <ed5153e1-f4de-4268-a9d0-e74b779d2587@wanadoo.fr>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 8 Apr 2024 15:32:06 +0530
Message-ID: <CANAwSgQ6_bxpKmanPwXvKEQJ0p7AvwTs3on9ubOegaDn3nkdxw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] usb: dwc3: exynos: Use devm_regulator_bulk_get_enable()
 helper function
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Fri, 5 Apr 2024 at 21:42, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 05/04/2024 =C3=A0 08:10, Anand Moon a =C3=A9crit :
> >   Hi Christophe, Krzysztof,
> >
> > On Mon, 4 Mar 2024 at 17:16, Anand Moon <linux.amoon@gmail.com> wrote:
> >>
> >> Hi Christophe,
> >>
> >> On Sun, 3 Mar 2024 at 00:07, Christophe JAILLET
> >> <christophe.jaillet@wanadoo.fr> wrote:
> >>>
> >>> Le 02/03/2024 =C3=A0 17:48, Anand Moon a =C3=A9crit :
> >>>> Hi Christophe,
> >>>>
> >>>> On Sat, 2 Mar 2024 at 21:20, Christophe JAILLET
> >>>> <christophe.jaillet@wanadoo.fr> wrote:
> >>>>>
> >>>>> Le 01/03/2024 =C3=A0 20:38, Anand Moon a =C3=A9crit :
> >>>>>> Use devm_regulator_bulk_get_enable() instead of open coded
> >>>>>> 'devm_regulator_get(), regulator_enable(), regulator_disable().
> >>>>>>
> >>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>>>>> ---
> >>>>>>     drivers/usb/dwc3/dwc3-exynos.c | 49 +++-----------------------=
--------
> >>>>>>     1 file changed, 4 insertions(+), 45 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc=
3-exynos.c
> >>>>>> index 5d365ca51771..7c77f3c69825 100644
> >>>>>> --- a/drivers/usb/dwc3/dwc3-exynos.c
> >>>>>> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> >>>>>> @@ -32,9 +32,6 @@ struct dwc3_exynos {
> >>>>>>         struct clk              *clks[DWC3_EXYNOS_MAX_CLOCKS];
> >>>>>>         int                     num_clks;
> >>>>>>         int                     suspend_clk_idx;
> >>>>>> -
> >>>>>> -     struct regulator        *vdd33;
> >>>>>> -     struct regulator        *vdd10;
> >>>>>>     };
> >>>>>>
> >>>>>>     static int dwc3_exynos_probe(struct platform_device *pdev)
> >>>>>> @@ -44,6 +41,7 @@ static int dwc3_exynos_probe(struct platform_dev=
ice *pdev)
> >>>>>>         struct device_node      *node =3D dev->of_node;
> >>>>>>         const struct dwc3_exynos_driverdata *driver_data;
> >>>>>>         int                     i, ret;
> >>>>>> +     static const char * const regulators[] =3D { "vdd33", "vdd10=
" };
> >>>>>>
> >>>>>>         exynos =3D devm_kzalloc(dev, sizeof(*exynos), GFP_KERNEL);
> >>>>>>         if (!exynos)
> >>>>>> @@ -78,27 +76,9 @@ static int dwc3_exynos_probe(struct platform_de=
vice *pdev)
> >>>>>>         if (exynos->suspend_clk_idx >=3D 0)
> >>>>>>                 clk_prepare_enable(exynos->clks[exynos->suspend_cl=
k_idx]);
> >>>>>>
> >>>>>> -     exynos->vdd33 =3D devm_regulator_get(dev, "vdd33");
> >>>>>> -     if (IS_ERR(exynos->vdd33)) {
> >>>>>> -             ret =3D PTR_ERR(exynos->vdd33);
> >>>>>> -             goto vdd33_err;
> >>>>>> -     }
> >>>>>> -     ret =3D regulator_enable(exynos->vdd33);
> >>>>>> -     if (ret) {
> >>>>>> -             dev_err(dev, "Failed to enable VDD33 supply\n");
> >>>>>> -             goto vdd33_err;
> >>>>>> -     }
> >>>>>> -
> >>>>>> -     exynos->vdd10 =3D devm_regulator_get(dev, "vdd10");
> >>>>>> -     if (IS_ERR(exynos->vdd10)) {
> >>>>>> -             ret =3D PTR_ERR(exynos->vdd10);
> >>>>>> -             goto vdd10_err;
> >>>>>> -     }
> >>>>>> -     ret =3D regulator_enable(exynos->vdd10);
> >>>>>> -     if (ret) {
> >>>>>> -             dev_err(dev, "Failed to enable VDD10 supply\n");
> >>>>>> -             goto vdd10_err;
> >>>>>> -     }
> >>>>>> +     ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regul=
ators), regulators);
> >>>>>> +     if (ret)
> >>>>>> +             return dev_err_probe(dev, ret, "Failed to enable reg=
ulators\n");
> >>>>>>
> >>>>>>         if (node) {
> >>>>>>                 ret =3D of_platform_populate(node, NULL, NULL, dev=
);
> >>>>>> @@ -115,10 +95,6 @@ static int dwc3_exynos_probe(struct platform_d=
evice *pdev)
> >>>>>>         return 0;
> >>>>>>
> >>>>>>     populate_err:
> >>>>>> -     regulator_disable(exynos->vdd10);
> >>>>>> -vdd10_err:
> >>>>>> -     regulator_disable(exynos->vdd33);
> >>>>>> -vdd33_err:
> >>>>>>         for (i =3D exynos->num_clks - 1; i >=3D 0; i--)
> >>>>>>                 clk_disable_unprepare(exynos->clks[i]);
> >>>>>>
> >>>>>> @@ -140,9 +116,6 @@ static void dwc3_exynos_remove(struct platform=
_device *pdev)
> >>>>>>
> >>>>>>         if (exynos->suspend_clk_idx >=3D 0)
> >>>>>>                 clk_disable_unprepare(exynos->clks[exynos->suspend=
_clk_idx]);
> >>>>>> -
> >>>>>> -     regulator_disable(exynos->vdd33);
> >>>>>> -     regulator_disable(exynos->vdd10);
> >>>>>>     }
> >>>>>>
> >>>>>>     static const struct dwc3_exynos_driverdata exynos5250_drvdata =
=3D {
> >>>>>> @@ -196,9 +169,6 @@ static int dwc3_exynos_suspend(struct device *=
dev)
> >>>>>>         for (i =3D exynos->num_clks - 1; i >=3D 0; i--)
> >>>>>>                 clk_disable_unprepare(exynos->clks[i]);
> >>>>>>
> >>>>>> -     regulator_disable(exynos->vdd33);
> >>>>>> -     regulator_disable(exynos->vdd10);
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> Same here, I don't think that removing regulator_[en|dis]able from =
the
> >>>>> suspend and resume function is correct.
> >>>>>
> >>>>> The goal is to stop some hardware when the system is suspended, in =
order
> >>>>> to save some power.
> >>>> Ok,
> >>>>>
> >>>>> Why did you removed it?
> >>>>
> >>>> As per the description of the function  devm_regulator_bulk_get_enab=
le
> >>>>
> >>>> * This helper function allows drivers to get several regulator
> >>>>    * consumers in one operation with management, the regulators will
> >>>>    * automatically be freed when the device is unbound.  If any of t=
he
> >>>>    * regulators cannot be acquired then any regulators that were
> >>>>    * allocated will be freed before returning to the caller.
> >>>
> >>> The code in suspend/resume is not about freeing some resources. It is
> >>> about enabling/disabling some hardware to save some power.
> >>>
> >>> Think to the probe/remove functions as the software in the kernel tha=
t
> >>> knows how to handle some hardawre, and the suspend/resume as the on/o=
ff
> >>> button to power-on and off the electrical chips.
> >>>
> >>> When the system is suspended, the software is still around. But some
> >>> hardware can be set in a low consumption mode to save some power.
> >>>
> >>> IMHO, part of the code you removed changed this behaviour and increas=
e
> >>> the power consumption when the system is suspended.
> >>>
> >>
> >> You are correct, I have changed the regulator API from
> >> devm_regulator_get_enable to devm_regulator_bulk_get_enable
> >> which changes this behavior.
> >> I will fix it in the next version.
> >>
> >>> CJ
> >
> > I could not find any example in the kernel to support
> > devm_regulator_bulk_disable
> > but here is my modified file.
> >
> > If you have any suggestions for this plz let me know.
>
> I don't think that your approach is correct, and I don't think that the
> proposed patch does what you expect it to do.
>
> Calling a devm_ function in suspend/resume functions looks really
> strange to me and is likely broken.
>
> Especially here, devm_regulator_bulk_get_enable() in the resume function
> allocates some memory that is not freed in
> devm_regulator_bulk_disable(), because the API is not designed to work
> like that. So this could generate a kind of memory leak.
>
>
> *I think that the code is good enough as-is*, but if you really want to
> change something, maybe:
>     - devm_regulator_get()+regulator_enable() in the probe could be
> changed to devm_regulator_get_enable()
>     - the resume/suspend function should be left as-is with
> regulator_disable()/regulator_ensable()
>     - remove regulator_disable() from the error handling path of the
> probe and from the remove function.
>
> I *think* it would work.
>
No devm_regulator_get_enable use the same logic as
devm_regulator_bulk_get_enable
to enable the regulator.

[0] https://elixir.bootlin.com/linux/latest/source/drivers/regulator/devres=
c#L126

So as of now I am dropping the changes on the regulator in this patch serie=
s.

> CJ
>
Thanks for your inputs.

Thanks

-Anand

