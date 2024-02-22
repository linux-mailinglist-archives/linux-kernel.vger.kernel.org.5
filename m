Return-Path: <linux-kernel+bounces-76644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EF085FA69
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C24D289F48
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB01135403;
	Thu, 22 Feb 2024 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="erADxNE/"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DAF133981
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610076; cv=none; b=IHhbi0CTrWUNqFVXWB2LkO8agUGlbs6QqZ+P+gzNOYY7JEmDtZ15p+4H6rYH9KlvgFc9txq8iFxmCIOfsqV8fmXp5ipgdVQsGCfeXtl8N1bwaNi0rLprp0T9Vx122QXXLKeM6ReoMepHe4BSRo0ySUkidpWBn8h/WDRhOlbDOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610076; c=relaxed/simple;
	bh=PXI1clNCyNU5/408UJ9wrb59OAo5xi/EPQc4XTjmvQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1Oap8zpC7fwjk1WVqWBFsQyOv5WSCccrI+9oNy01kgy+PSTMbv0EKuipCnZkt8lB365OPukkGBdcg2jCrac5SQnvMwNaKMMzZPikoD6ibCh8sZ2OD2nBuYDHyuqB4rScEv+rGvbTG3PBaME58B0sXzFBjUSX+Gqs6lcemTVojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=erADxNE/; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d5c890c67fso3899520241.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708610074; x=1709214874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4wody7AEosg/imFqwwzzZCILtL+8Y4lbZUS3vTJ0Eo=;
        b=erADxNE/Xr5mVSiwKJY+Tv1qpHmmoO4kJaGfI67zpsa725bUGRwL/vZl7j9S05xBsQ
         kTHoP68lzoSRlEa26GuVxHgVGmZBo8rmz/Ii3WNpfmlWr/tcnaNUubVr7yVuCpPTuM28
         r13vi96oyXq8w8cJVu63rw17VdWpc+Vl2SNS9T3otpRE0a412h3P2/Y83wcdqz9DrGZQ
         QNKoQBPhYprAc+VgJaMBr6yapx7bDs+DhI66DMCpNf1C7V5Usw7Ls1nWMvtJ+2hQIZ4e
         zJvk7Ui+Jbv7YE3bid086md4I67Fpko5E+w+XlUIr2fNqMSvfe2ynouT8265kmgCxX7k
         e/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708610074; x=1709214874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4wody7AEosg/imFqwwzzZCILtL+8Y4lbZUS3vTJ0Eo=;
        b=UtruUGHUQCjsEJtAgPy1YapLaHvfekdvu8h4sL3fdt3ZScE7u0KGMijmyYMqjJqQRC
         m+0Lm5xv4NSEvLbBN0PSrBlu8CfIVKUf91iUJ5I7RE1k9e+u4hBdxJiFGG7klBe6xA8Q
         q6xj4rfnqK3Fq6lshq1CJ+bxlBOnKObYbJATMXKKbFmw4mtMdl66/Y0ybKM293xRjEfB
         ZmaXtcQU1HKW8c5OmJ4b1HDuoxgn+/mUL3hr8R+Mh4maA+FAvXdsyT6BZRxLDIxKioOS
         JXkg65JAFCGl9C3u0zzEu1va3ppV5t0h40NfwSsBsNL2rd2uha2InxxrN50qz+EJ0T6W
         hOHw==
X-Forwarded-Encrypted: i=1; AJvYcCWiUPbXVqgIUs5gfaPeJ5auya/Ti4jAE4BTdCmIBmXVtpFY0Xctcs7gXKy8WRgNDWq8RXHIiIGMoEmi544pjiWoZFgIYLd8yNWSOt6i
X-Gm-Message-State: AOJu0YxLQB1iveDU8fXZUrhNnUy8bfPlRbUt6svdZ/kENpiJjdmF9Uny
	r+8zFkrZ5RUpqsToQ06YLSgUzi6wcdbGNNBX07449pq4It5mW0AzAHJ05rRHdISO0TbiNAnj71i
	xad7f/ZWfE8+YF9yFEGrNfUkjYMw0kupEiUMD8g==
X-Google-Smtp-Source: AGHT+IEFZVcSb6EpSmuHI0WYX0cdApu6B/RLs7NdqNRViBgXup/2PE0P1x2U47NasBSgdBEzOwZELJpztQ8QpNsEY34=
X-Received: by 2002:a05:6102:31a:b0:470:430b:154d with SMTP id
 26-20020a056102031a00b00470430b154dmr11777688vsa.33.1708610073985; Thu, 22
 Feb 2024 05:54:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182810.58382-1-brgl@bgdev.pl> <20240205182810.58382-3-brgl@bgdev.pl>
 <tnylagkmj36lve2ub5voumtkqjdy6j3hr6yyk4mqkaabvc3gdv@voaiu2oqi73o> <CAMRc=McmfufqqEvouRCjY1ukVB_ie1r5QEocqRUK0VBheEq5Hg@mail.gmail.com>
In-Reply-To: <CAMRc=McmfufqqEvouRCjY1ukVB_ie1r5QEocqRUK0VBheEq5Hg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 14:54:23 +0100
Message-ID: <CAMRc=Mc_iwMzKznfUknm+RwS3jN_GimpirdTDVCPtnYYS_1PNg@mail.gmail.com>
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

On Wed, Feb 21, 2024 at 7:39=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Sun, Feb 18, 2024 at 4:25=E2=80=AFAM Bjorn Andersson <andersson@kernel=
org> wrote:
> >
> > On Mon, Feb 05, 2024 at 07:28:00PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Select the TrustZone memory allocator in Kconfig and create a pool of
> > > memory shareable with the TrustZone when probing the SCM driver.
> > >
> > > This will allow a gradual conversion of all relevant SCM calls to usi=
ng
> > > the dedicated allocator.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> > > Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thi=
nkpad-x13s
> > > Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
> > > Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> > > ---
> > >  drivers/firmware/qcom/Kconfig    |  1 +
> > >  drivers/firmware/qcom/qcom_scm.c | 16 ++++++++++++++++
> > >  2 files changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kc=
onfig
> > > index f18686edf415..d24d83223867 100644
> > > --- a/drivers/firmware/qcom/Kconfig
> > > +++ b/drivers/firmware/qcom/Kconfig
> > > @@ -7,6 +7,7 @@
> > >  menu "Qualcomm firmware drivers"
> > >
> > >  config QCOM_SCM
> > > +     select QCOM_TZMEM
> > >       tristate
> > >
> > >  config QCOM_TZMEM
> > > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom=
/qcom_scm.c
> > > index 520de9b5633a..0d4c028be0c1 100644
> > > --- a/drivers/firmware/qcom/qcom_scm.c
> > > +++ b/drivers/firmware/qcom/qcom_scm.c
> > > @@ -8,8 +8,10 @@
> > >  #include <linux/completion.h>
> > >  #include <linux/cpumask.h>
> > >  #include <linux/dma-mapping.h>
> > > +#include <linux/err.h>
> > >  #include <linux/export.h>
> > >  #include <linux/firmware/qcom/qcom_scm.h>
> > > +#include <linux/firmware/qcom/qcom_tzmem.h>
> > >  #include <linux/init.h>
> > >  #include <linux/interconnect.h>
> > >  #include <linux/interrupt.h>
> > > @@ -20,9 +22,11 @@
> > >  #include <linux/of_platform.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/reset-controller.h>
> > > +#include <linux/sizes.h>
> > >  #include <linux/types.h>
> > >
> > >  #include "qcom_scm.h"
> > > +#include "qcom_tzmem.h"
> > >
> > >  static bool download_mode =3D IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MO=
DE_DEFAULT);
> > >  module_param(download_mode, bool, 0);
> > > @@ -41,6 +45,8 @@ struct qcom_scm {
> > >       int scm_vote_count;
> > >
> > >       u64 dload_mode_addr;
> > > +
> > > +     struct qcom_tzmem_pool *mempool;
> > >  };
> > >
> > >  struct qcom_scm_current_perm_info {
> > > @@ -1887,6 +1893,16 @@ static int qcom_scm_probe(struct platform_devi=
ce *pdev)
> > >       if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled"=
))
> > >               qcom_scm_disable_sdi();
> > >
> > > +     ret =3D qcom_tzmem_enable(__scm->dev);
> > > +     if (ret)
> > > +             return dev_err_probe(__scm->dev, ret,
> > > +                                  "Failed to enable the TrustZone me=
mory allocator\n");
> > > +
> > > +     __scm->mempool =3D devm_qcom_tzmem_pool_new(__scm->dev, SZ_256K=
);
> >
> > As we're not moving from the callers freely allocating what they need,
> > to a fixed sized pool of 256kb. Please document why 256kb was choosen,
> > so that we have something to fall back on when someone runs out of this
> > space, or wonders "why not 128kb?".
> >
>
> If you worry about these pools being taken out of the total memory and
> prefer to have a way to avoid it, I was thinking about another
> build-time mode for the allocator - one where there's no pool but it
> just allocates chunks using dma_alloc_coherent() like before and pool
> size is ignored. Does it sound good?
>

Or we could even have an argument for the initial size of the pool and
then once it's exhausted, we'd add a new chunk (maybe twice the size?)
and so on.

Bart

> Bart
>
> > Regards,
> > Bjorn
> >
> > > +     if (IS_ERR(__scm->mempool))
> > > +             return dev_err_probe(__scm->dev, PTR_ERR(__scm->mempool=
),
> > > +                                  "Failed to create the SCM memory p=
ool\n");
> > > +
> > >       /*
> > >        * Initialize the QSEECOM interface.
> > >        *
> > > --
> > > 2.40.1
> > >

