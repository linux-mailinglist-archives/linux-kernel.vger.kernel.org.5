Return-Path: <linux-kernel+bounces-56732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A07384CE4B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3CAB2302A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747980024;
	Wed,  7 Feb 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f72ZL+19"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AC37FBC9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320553; cv=none; b=LnI0BwkP4+lMvJWS+9VNMGIABFkmpFs1wkfcba2ZYJojZg9y8hckCyaJdKRTuz6dFWkPjOQKd0JihxfNN8/Df1M0OXYq1csmq2E7Hrqpn7sepTqGTThEEWnaDHWDa7BwZYpldwViv/QKHuUiztn/3pbHAZXfiFROD8CJ5fyk+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320553; c=relaxed/simple;
	bh=6SHPMjNP8YDT15Iij7ixZFtooCnxVqeUcWFZiDatm2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkQXFf8XgL787tLPNANaUdlLlw+L043BypOxWaEqPghL7MnMg7emEnG3TX/B5Lny3ovH0QuaZEz8R6loBf3+3id2DyFFVL8wIU3SdVM07b+TPj4xEo2Xi21QuvHkv01Jeb/PeNvGN332geOIW+3yPlOnVE00yRFfLsBGcCA29NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f72ZL+19; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8df2edd29so506954a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707320551; x=1707925351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1k6l9VsJqCh+RqlLUdVe9MZtp+zPDCT1Q+6Pwca5BQ=;
        b=f72ZL+19RKp/8pv1MeD3DGZTuv3EIHZ20hZ3sV4chavUcxoC34N5W6gE2E981dOuLE
         2WfXE/z+dFoKxA2Vf9NOrBMQIJCv/Ild5c4Go31tnXsWt7GRdZMgc3ZIRFkwq4ty1vcX
         L/b+sZBuGk8ixkBuhw8tXoMp1ROAZrhDg5x7tI6YduoZ6uKTwRws+lhTbbj8ljGhnkv1
         4eCJAmydXrDc26POIxSPgY54xjM4UpvsgPQJpGdOcOMTasoDoEf7ouYu8D0LzV6SKpjl
         BVq5Ts+idnVRAvypfKeMEgBO3b+MXKUqwcJ3MMAY1j6rn5gGt7RdvStLtaWCsrfBoF9A
         d7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707320551; x=1707925351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1k6l9VsJqCh+RqlLUdVe9MZtp+zPDCT1Q+6Pwca5BQ=;
        b=d9WeAejg1oaT/OK2zrT8W1OtUWmhtUI0VdErlO968JXf2DG+8e2tmZqVJnh0kaPxPd
         DPUUcSWQVtdjYx5M6jN3b937DkW8uPya8p+Ao9wKxbHKOfaAuubx/DuBwxCvVnF6undn
         tuJxbZ4SldfWc3gPaAfpstprQHJpN6GlxVD7RNwb9QPa/hG4TWViY/gWUiR9eM4jHsgM
         aOUXTcZ9tGVqTsz2iF042OhggM7/J8xjfV7oVEFv1mor6lwBQKnUq98Oux/WOF4MvRKg
         fahcNVfMt+inLZxm7cYoJVm+TV1T79IWgPfgUBqvcn20xH3MgvZQJVPkVm/txx1gtpZ7
         82+w==
X-Forwarded-Encrypted: i=1; AJvYcCUsMXgGf3XBvkvYgLA8Znv3C+Lgbb+Fm6gXFlofPvlNcLMlgz1LmP8iYuF21xShS3yLp3lKJ5oOG7Ev3AHiB2tA/VXDFvDZwBIiEM11
X-Gm-Message-State: AOJu0YyFqLLKxMapVCZ8Of1gLJFRZ8F9mfOF408ogRhK4+QZhSzURzWr
	5L/I6aGlznwy+djtG3uTwxcGcbVb8dY/u6ZijKhW98MHRnGnH/WNZXlJQr1JK58XmFOQXov3OpG
	Krh699iKFnRhR3AWlzQsIt3rPStcTmbBfLKTIzA==
X-Google-Smtp-Source: AGHT+IHoo4XR4AOXdM1Xi2DWyc3VAXdtc9F/OIyCgMe01EYezQtt37cphv12SPLoNwfrzSk+idTwfQsKhr3rHYJ1sig=
X-Received: by 2002:a17:90a:d48f:b0:296:c695:4962 with SMTP id
 s15-20020a17090ad48f00b00296c6954962mr2669545pju.41.1707320551601; Wed, 07
 Feb 2024 07:42:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org>
 <20240206085238.1208256-2-tudor.ambarus@linaro.org> <CAPLW+4=Xd+B=ZncqPgU4qaJ8zY8JJvJZApdUW_v0w6yr2cy9Sg@mail.gmail.com>
 <16a5e423-1111-49ff-ad6c-b0bb89a4879a@linaro.org>
In-Reply-To: <16a5e423-1111-49ff-ad6c-b0bb89a4879a@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 7 Feb 2024 09:42:20 -0600
Message-ID: <CAPLW+4n_1yBOuzW3Ke2DKh_0EBZMUrd3nyGd=U0TeOML_2dXuw@mail.gmail.com>
Subject: Re: [PATCH 1/4] spi: s3c64xx: explicitly include <linux/types.h>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, broonie@kernel.org, andi.shyti@kernel.org, 
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com, robh+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 12:21=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
>
>
> On 2/6/24 18:02, Sam Protsenko wrote:
> > On Tue, Feb 6, 2024 at 2:52=E2=80=AFAM Tudor Ambarus <tudor.ambarus@lin=
aro.org> wrote:
> >>
> >> The driver uses u32 and relies on an implicit inclusion of
> >> <linux/types.h>.
> >>
> >> It is good practice to directly include all headers used, it avoids
> >> implicit dependencies and spurious breakage if someone rearranges
> >> headers and causes the implicit include to vanish.
> >>
> >> Include the missing header.
> >>
> >> Fixes: 230d42d422e7 ("spi: Add s3c64xx SPI Controller driver")
> >
> > Not sure if Fixes tag is needed here.
>
> We have already talked about this. If a patch that causes the implicit
> include to vanish is backported to stable, it will reveal the missing
> header here and will result in backporting this patch as well. So, as a
> good practice let's allow this patch to be queued to stable, it will
> avoid possible compilation errors.
>
> I guess Mark has to break the tie again. Or Greg if he cares, I added
> him in To:.
>
> >
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> >> ---
> >>  drivers/spi/spi-s3c64xx.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> >> index 72c35dbe53b2..c15ca6a910dc 100644
> >> --- a/drivers/spi/spi-s3c64xx.c
> >> +++ b/drivers/spi/spi-s3c64xx.c
> >> @@ -17,6 +17,7 @@
> >>  #include <linux/platform_device.h>
> >>  #include <linux/pm_runtime.h>
> >>  #include <linux/spi/spi.h>
> >> +#include <linux/types.h>
> >
> > Is this really needed for the further patches in this series?
> >
>
> Yes, because in patch 3/4 I use u8 and u16 and I don't want to use those
> without having the header included. Do you find this wrong?
>

I'd say if this header is really needed for your patch 3/4 to have a
successful build, just merge this patch into the patch 3/4 then.

> >>
> >>  #define MAX_SPI_PORTS          12
> >>  #define S3C64XX_SPI_QUIRK_CS_AUTO      (1 << 1)
> >> --
> >> 2.43.0.594.gd9cf4e227d-goog
> >>

