Return-Path: <linux-kernel+bounces-75320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 612F285E67C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8486E1C24E62
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319888593D;
	Wed, 21 Feb 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="r8oIrkJy"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EBC82D97
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540774; cv=none; b=W5f/hA3C9IC6S7pt4aZNO7iZQlvqVRjf1sS0tLWRzp2kYeCDfdxhjYUR6JhkSaQ8n4B1c7XYpsn/hSYsJSZw+5h2Xkm666+hiDRPT3N7tyF63i9YMtp+AeemVbKKbnko9lpzjmLHFozVVg2y+EOEKQQK9v1qkk9/Uesw6WuOOdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540774; c=relaxed/simple;
	bh=ltCLerzsny1Mf/3etibB5mXyU8baMLxo3QojaxcO5q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPin1Hwtlx0mixiQdpR8XQGPOwo/cCG4VU8JyaiQFquDFGaMhqzDBOHOn/02seMtsygVlIp6YWRx0mbHt1yH/xtQqLBIDQA27wNHEeX0iiJcE39vxxGFBFmcpyMvULh1z3J3uc4SEVb01YQhwlhtr5ougVjUI/qbtW/BP4gPigs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=r8oIrkJy; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-47050fd33f5so562499137.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708540770; x=1709145570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr4IUMnYmNnkEtsozLmsyunjWbfVFxd6vy9GXcYNIEQ=;
        b=r8oIrkJyHaWr8XhJLfEQPt8izKBGUM6LFUa8XbPVZT0v77+KMhB47wg+Go9i0wz0Bc
         HTOAKv6agbZHZh5bwKY1nDe6lfNoVPwgmrWvUEJUWy75Tp1cJAV8m9UYyOp4ZCzvY19C
         9LXHI3Z+iYtg9xqcQrW3OHd28m+CokM/CZT585Cl3Mu7JopChb+6N128tyaYN1iVnW5O
         wMSIQW2zoUGSS9G+It/q+F9MzVnvfdg4GHwDr9BPV7UySBUDqdSXwAc/MboElL5e2iGs
         fmQfhLd8wYXP3QNcs3+Hd23rmZ4UMpsl0oMu5Bao4EO17RwiGJ2KlE0XYh6qu/3XOdXs
         98wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708540770; x=1709145570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lr4IUMnYmNnkEtsozLmsyunjWbfVFxd6vy9GXcYNIEQ=;
        b=uYnKMe+4TvkM92MFB+QpSJ76GAsCXbR0lhkGVgj3WukA0p6yCLeNMpnPKQpSjrZWDF
         wvlSGTIsgBHN0BGc2/tvPIa0NkrW6+ew0b1Uiv6o3DS1hvvnlG1VOgFgP8EP6bJ8Bmow
         SWN1ILprRFjHzXXR/hgnfDL6lRV9Fxo5ciiGaS1ff0X2ZZ2JDLAWMIjKXQ1KpJmbWV7l
         ax0EP6W4R96FZ8ztmgqQxW0uTKwT8zLngZjosaS+7EJngfB8G/FOIx/VyFiUKOKO99HP
         xeq5yUfUrJ7XDc6051h09QaOcgL+7yqF2U5w6drWAdVfYfbU2q0gvHRY6Bra3baQMSUk
         iHZA==
X-Forwarded-Encrypted: i=1; AJvYcCXc4ftFX8U+pAYHdJKLfdxqPOVlOQTZF5r/eyMLoSKxBTS5Zh9AsVM58sBVfgp2vlQiaXVBmYZJ8/zpisq1seFAATxeR/QwXAbTVSVz
X-Gm-Message-State: AOJu0YzkHYCxBOcCVhcGA6kGuC65ptcOZQSDpzoRFnEZzBgPt4fxjVsK
	Cqmgk+EvQO1SMsZEk5AHMjlSx4R4SCmjDvPTD/EyrFt34mYL8J7P8TdOU7VQw7q3hvhHp2KKZkm
	ucICD8BlGm6pCwYNngS8HAsoPWP+sGm+OkuXhPw==
X-Google-Smtp-Source: AGHT+IG2ipXt9OnxmfKd/LCnEEhoOhjocNBwR5gMMmYQiXx9HtJ4a5t2aa542TfW1o+iPUXCGhlTlsgBTdSGbf2UnXU=
X-Received: by 2002:a67:e8cf:0:b0:470:4744:704a with SMTP id
 y15-20020a67e8cf000000b004704744704amr6823220vsn.9.1708540770337; Wed, 21 Feb
 2024 10:39:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182810.58382-1-brgl@bgdev.pl> <20240205182810.58382-3-brgl@bgdev.pl>
 <tnylagkmj36lve2ub5voumtkqjdy6j3hr6yyk4mqkaabvc3gdv@voaiu2oqi73o>
In-Reply-To: <tnylagkmj36lve2ub5voumtkqjdy6j3hr6yyk4mqkaabvc3gdv@voaiu2oqi73o>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 21 Feb 2024 19:39:19 +0100
Message-ID: <CAMRc=McmfufqqEvouRCjY1ukVB_ie1r5QEocqRUK0VBheEq5Hg@mail.gmail.com>
Subject: Re: [PATCH v7 02/12] firmware: qcom: scm: enable the TZ mem allocator
To: Bjorn Andersson <andersson@kernel.org>
Cc: Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Guru Das Srinagesh <quic_gurus@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Deepti Jaggi <quic_djaggi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 4:25=E2=80=AFAM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Mon, Feb 05, 2024 at 07:28:00PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Select the TrustZone memory allocator in Kconfig and create a pool of
> > memory shareable with the TrustZone when probing the SCM driver.
> >
> > This will allow a gradual conversion of all relevant SCM calls to using
> > the dedicated allocator.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> > Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-think=
pad-x13s
> > Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
> > Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> > ---
> >  drivers/firmware/qcom/Kconfig    |  1 +
> >  drivers/firmware/qcom/qcom_scm.c | 16 ++++++++++++++++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kcon=
fig
> > index f18686edf415..d24d83223867 100644
> > --- a/drivers/firmware/qcom/Kconfig
> > +++ b/drivers/firmware/qcom/Kconfig
> > @@ -7,6 +7,7 @@
> >  menu "Qualcomm firmware drivers"
> >
> >  config QCOM_SCM
> > +     select QCOM_TZMEM
> >       tristate
> >
> >  config QCOM_TZMEM
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/q=
com_scm.c
> > index 520de9b5633a..0d4c028be0c1 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -8,8 +8,10 @@
> >  #include <linux/completion.h>
> >  #include <linux/cpumask.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/err.h>
> >  #include <linux/export.h>
> >  #include <linux/firmware/qcom/qcom_scm.h>
> > +#include <linux/firmware/qcom/qcom_tzmem.h>
> >  #include <linux/init.h>
> >  #include <linux/interconnect.h>
> >  #include <linux/interrupt.h>
> > @@ -20,9 +22,11 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/reset-controller.h>
> > +#include <linux/sizes.h>
> >  #include <linux/types.h>
> >
> >  #include "qcom_scm.h"
> > +#include "qcom_tzmem.h"
> >
> >  static bool download_mode =3D IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE=
_DEFAULT);
> >  module_param(download_mode, bool, 0);
> > @@ -41,6 +45,8 @@ struct qcom_scm {
> >       int scm_vote_count;
> >
> >       u64 dload_mode_addr;
> > +
> > +     struct qcom_tzmem_pool *mempool;
> >  };
> >
> >  struct qcom_scm_current_perm_info {
> > @@ -1887,6 +1893,16 @@ static int qcom_scm_probe(struct platform_device=
 *pdev)
> >       if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled"))
> >               qcom_scm_disable_sdi();
> >
> > +     ret =3D qcom_tzmem_enable(__scm->dev);
> > +     if (ret)
> > +             return dev_err_probe(__scm->dev, ret,
> > +                                  "Failed to enable the TrustZone memo=
ry allocator\n");
> > +
> > +     __scm->mempool =3D devm_qcom_tzmem_pool_new(__scm->dev, SZ_256K);
>
> As we're not moving from the callers freely allocating what they need,
> to a fixed sized pool of 256kb. Please document why 256kb was choosen,
> so that we have something to fall back on when someone runs out of this
> space, or wonders "why not 128kb?".
>

If you worry about these pools being taken out of the total memory and
prefer to have a way to avoid it, I was thinking about another
build-time mode for the allocator - one where there's no pool but it
just allocates chunks using dma_alloc_coherent() like before and pool
size is ignored. Does it sound good?

Bart

> Regards,
> Bjorn
>
> > +     if (IS_ERR(__scm->mempool))
> > +             return dev_err_probe(__scm->dev, PTR_ERR(__scm->mempool),
> > +                                  "Failed to create the SCM memory poo=
l\n");
> > +
> >       /*
> >        * Initialize the QSEECOM interface.
> >        *
> > --
> > 2.40.1
> >

