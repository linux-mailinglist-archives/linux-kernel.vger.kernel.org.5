Return-Path: <linux-kernel+bounces-134533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64F989B2A1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95181C21361
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CED39FF2;
	Sun,  7 Apr 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAFjbKcz"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F412E48
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712502551; cv=none; b=hRDgHFTnwDJu3qcIx97FMW6Uic/+EZ5D379gut0Gnet1uxrR//jrfosF7sCy0AZEhC/BUUvb3L1MvP8E9jpvi09ROM/rrnkTZLHbJjK6wG9oDAHGGgB8f5aRvtxgL8qI9O3KGcbVKpOQ3zhUs1i36xLIYV89sQ/zE4hkH9QwOXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712502551; c=relaxed/simple;
	bh=iUxqaM6MR7NPSOUp7RbkZ53KE0WV7vGgjJc9JHEZzfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubDtu1EA+6VfnL5f7Ep67OR7Yk7uLH/1n7hyXJWRtPeqxO32Vavm46mUuXylHlSxf01+QRPsIpFr5UwDoIayu1xFMyghEI1ZfEdJgp+1PIKPEzNTUEGQee2RUOwASlyxXclmL0TYa4FlQHoOsG7rGB2zEQdriH983eShT6zLixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OAFjbKcz; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so3597176276.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712502549; x=1713107349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UiThJZ9quBZAC6tZgqqMHQLgUFf72M0kmjrWzyDbsqQ=;
        b=OAFjbKcz5ZBpvpHKCfrM/pz1om3tTIhW15f0B0YKr0mdz6CQiyVs54aW8twmGrdjR6
         99U5ep2Wzgv3rhie/MfSFLX7HAUUlpeVS8fXbvsNJMXndMAHFfGrrhdn2C7JrqbzaO85
         tcZepmT5ArY+GIhtDGZaq/cGS5k4qO5PpMTZq6Uq8Wmu0eoon/GorLdPTxCTltpmfxNi
         CdTpfu5taePZo3cE1Zu8yfjbpH1BCDRSQgbP7wsHQ1Qr6IWp9y0FVf6AfgLlJihG+sYy
         2eWo36hMnEHMxpjdOMqRiWnAhjUh7hGdWQ3icm6l0DYq03Exualgyj9+QgQKFwtI1Ht0
         ORJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712502549; x=1713107349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiThJZ9quBZAC6tZgqqMHQLgUFf72M0kmjrWzyDbsqQ=;
        b=FsyY+cqDdvvHo8meeqHWTGac4l8PdicbQHRxAgHu+S/onPpKFfa3gqW1oy07JxRcQi
         4PS6BsxeZXiu0RFNI/m645hkVimHP11xk/7uQ2Jd5OcSDjTAKw6PfmnpyLP2RbMIAHkz
         IEhDEiQuFQpKwVXNSuIy21y7bGonox5MI4xn59RycqrxT5+88ncbN1f+rBrO3sF8Wqnj
         6Xn2eBczdXrs65+vlyM/N/xBSyoGD5csL+4iiTTuZSymmlEhPkgt+NQUVG7pUOAeXVfO
         bOjbIlRpKOVB4XoSZ0eb0TiLxc8OBUse2AyYXF+tdSLK0MZy0aymTLMJJcSHUWOMz9R9
         YJCg==
X-Forwarded-Encrypted: i=1; AJvYcCW7a0SahIQ4rc3rLVUDOc+YJLpPBIwHCPMbruwI6AZTHeBOU0hbHTud4f2mCWuxD16wAnAu4d7NxzvWZw/t3U4YQeDRnC2V00I9OVk6
X-Gm-Message-State: AOJu0YznplFPAbEHHPUxuJ9qov7DURJaz1tRqd1aTg95PT7smUy/HTkL
	eCxilPKrJOI+o3k9JLZ+KTr3n61UC2mf5Vwa8EbQ17OmBuJ7852eEJ5mTvg8ZQF0+DgMpWP/kjk
	dVHwFIKG7F/poPJ+hGDTRcI7UVi+nB60zXMDKfw==
X-Google-Smtp-Source: AGHT+IERRrJsadsmRk28TwxGBHZ3cASLrwHOlRTfai2hIFWFmlJHW0fNKBGLZ1Hcs+ICqwqOs5FREpDOIfh+pi/RylU=
X-Received: by 2002:a5b:441:0:b0:dcb:fa70:c09 with SMTP id s1-20020a5b0441000000b00dcbfa700c09mr4766483ybp.28.1712502547217;
 Sun, 07 Apr 2024 08:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405-qc-pmic-typec-hpd-split-v1-1-363daafb3c36@linaro.org> <c1899fae-8669-485a-95bd-0e76738a1187@linaro.org>
In-Reply-To: <c1899fae-8669-485a-95bd-0e76738a1187@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 7 Apr 2024 18:08:55 +0300
Message-ID: <CAA8EJppBE8xdmc6zQ2VLLPSzmtNq-+03H5skqbnLmLZ8AqSBfw@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: qcom-pmic-typec: split HPD bridge alloc and registration
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Caleb Connolly <caleb.connolly@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Apr 2024 at 01:03, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 05/04/2024 19:11, Dmitry Baryshkov wrote:
> > If a probe function returns -EPROBE_DEFER after creating another device
> > there is a change of ening up in a probe deferral loop, (see commit
>
> *ending
>
> > fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER").
> >
> > In order to prevent such probe-defer loops caused by qcom-pmic-typec
> > driver, use the API added by Johan Hoval and move HPD bridge
>
> *Hovold
>
> > registeration to the end of the probe function.
>
> registration
>
> >
> > Reported-by: Caleb Connolly <caleb.connolly@linaro.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> > index e48412cdcb0f..96b41efae318 100644
> > --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> > +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> > @@ -41,7 +41,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
> >       struct device_node *np = dev->of_node;
> >       const struct pmic_typec_resources *res;
> >       struct regmap *regmap;
> > -     struct device *bridge_dev;
> > +     struct auxiliary_device *bridge_dev;
> >       u32 base;
> >       int ret;
> >
> > @@ -92,7 +92,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
> >       if (!tcpm->tcpc.fwnode)
> >               return -EINVAL;
> >
> > -     bridge_dev = drm_dp_hpd_bridge_register(tcpm->dev, to_of_node(tcpm->tcpc.fwnode));
> > +     bridge_dev = devm_drm_dp_hpd_bridge_alloc(tcpm->dev, to_of_node(tcpm->tcpc.fwnode));
> >       if (IS_ERR(bridge_dev))
> >               return PTR_ERR(bridge_dev);
> >
> > @@ -110,6 +110,10 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
> >       if (ret)
> >               goto fwnode_remove;
> >
> > +     ret = devm_drm_dp_hpd_bridge_add(tcpm->dev, bridge_dev);
> > +     if (ret)
> > +             goto fwnode_remove;
> > +
>
> Is there any reason this call comes after port_start/pdphy_start ?
>
> I think the bridge add should go before starting the typec port and
> pdphy since after the start calls IRQs are enabled.

The bridge-add just registers a device. Actual bridge is added by the
aux-hpd-bridge device driver.
I moved it to the end to prevent possible use-after-free issues like
we had in the PMIC Glink case.
Basically, if for some reason (e.g. because the TCPM returns an error
to one of the start functions) the drm_bridge is destroyed, the DRM
driver isn't notified about the event. It still keeps the pointer to
the bridge pointer and can access freed memory afterwards.

>
> With those minor points addressed
>
> Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>
> ---
> bod



-- 
With best wishes
Dmitry

