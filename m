Return-Path: <linux-kernel+bounces-72641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7035285B697
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25293289F86
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AAA60DF2;
	Tue, 20 Feb 2024 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L4gpQ8Gh"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EEA60BBB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419798; cv=none; b=mqeHbWBRZV3yu+rKsE/8P5xE+s64GPqKdQGpTLe3gCd8wv14I0Rfqp8+OIU+Ok5Pff89TzNj2WzE+cKoZufCaDiSL7EuYoyx1PQ3ZqGWkyvmwdctAONyrHdXEOrtPf1f76msWCNXDafOTlGnkQlg0a+qweLLn06Lp37BDl7Ybe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419798; c=relaxed/simple;
	bh=uY3svUHWUub7nR3FLXjSvI6L3yObQUxfv1yWYIzPr1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4aPhwaLFQ0/dYQMkx8FWZAEN1JFcCT4GWUNDG+uibU+iKGOx011wJOKWYAll8sZU0MsUi77Sb2umSEDm7PBZqLyprOagLXdil68LGVobz5xphCZT/S2K/guXD8rXEAaGIQTKr11+Px5fFnIt3ZNAKF/diwEjEREcUGT7iqTPPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L4gpQ8Gh; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d228a132acso39176851fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708419794; x=1709024594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4iT5ETvYJMsi5q/HB6faKSI8PkV3OtFKN0qmQ5ivP4=;
        b=L4gpQ8Ghh9xzWgxXWRZdQ/G9AkzfYgA0kZSWU2tmcH6jIEyePinWdEEAIiuM2b8UxV
         rVxGfWL9mKZufRUnHrzkhxYFeZwTuqFD75gPCafT7GlX7OV+uCMltsobeXBe+Bs+hsF+
         vGk9AQAUrjsaznyLkIafRLo7qoYALJ/p0H38Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708419794; x=1709024594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4iT5ETvYJMsi5q/HB6faKSI8PkV3OtFKN0qmQ5ivP4=;
        b=dVVrLp/bYRa/AOFm/TsvCIvUFdR5VvYsK4t8wQMu6XqUKpokcSl4LivWNkFVKwhrGI
         Cg+S0zHgiG0qwdAr4mUQDtIHnqOGGy8EZGBl6mWZfWWECLDDsKQssC/YPQZhmyXnSLkv
         jly0CKWuM8zhFMBUvO9Ltp2g6n4lm6jeXYSbAVuRU4k3XTBnornHIbnP9aazDqva2EJp
         HYmL+FVjtpmxd/OMrNtFF693c2ylgH9kTM1fhqWLkVovIHDZi7TZbElZwFj1HGQ9/HsI
         SVJDqk4cHHTthWCD7truGgwqVvRc1pnXmw3/+LT6UAnNt6FPDVk8j4rv6OBC16/4izDM
         c8Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVOrksGwew043sFXQAvOztspshx4KvIBpcYGoiosrkrBlcyeJn0VaActQ6vqIg3sVsjPBSP2vfSWteekKS28zpY53H8gxEivMl9be9l
X-Gm-Message-State: AOJu0Yxoj49Fhv7SoV/LHCjC7sNWWqpskmJC6LVf1iKkWobvuvVtUthN
	OrZkufshhs/1nuEn0N92+/tu1E1tEdr7eEjCdVQQ2s8dYpdJDtbWiiPsViDuNK50S27ieCxGlQ7
	vYY0J4wZrz66ZaxFcFtqk8C4NbsJcJjLHC8ps
X-Google-Smtp-Source: AGHT+IGoUwt6VSMd/dOjGOl0b2TERUUu8zmaj8e7XgFEns+bkkahzHjMnNw6K0ZDdL0dT7DZxQOQvViK5UEn40pteiQ=
X-Received: by 2002:a05:651c:b1f:b0:2d2:36ae:46a0 with SMTP id
 b31-20020a05651c0b1f00b002d236ae46a0mr4748236ljr.53.1708419794100; Tue, 20
 Feb 2024 01:03:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc8f7f7da5bdccce514a320e0ae7468659cf7346.1707327680.git.daniel@makrotopia.org>
 <CAGXv+5EKCrvsvZwc2zYiMWAeT9vqvU0JnDrz=WBoebBBbcgp0g@mail.gmail.com> <f1fc67d4-f979-4c3e-988f-a803b7b11c46@collabora.com>
In-Reply-To: <f1fc67d4-f979-4c3e-988f-a803b7b11c46@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 20 Feb 2024 17:03:02 +0800
Message-ID: <CAGXv+5Gxc3OP8nE681C6YQbDMUNmFDf21BfSvJZPBFgoncve=A@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: depends on CONFIG_SOC_BUS
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	William-tw Lin <william-tw.lin@mediatek.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 4:56=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 20/02/24 07:40, Chen-Yu Tsai ha scritto:
> > On Thu, Feb 8, 2024 at 1:43=E2=80=AFAM Daniel Golle <daniel@makrotopia.=
org> wrote:
> >>
> >> The mtk-socinfo driver uses symbols 'soc_device_register' and
> >> 'soc_device_unregister' which are part of the bus driver for
> >> System-on-Chip devices.
> >>
> >> Select SOC_BUS to make sure that driver is built and the symbols are
> >> available.
> >>
> >> Fixes: 423a54da3c7e ("soc: mediatek: mtk-socinfo: Add driver for getti=
ng chip information")
> >> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> >
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> >
> > Angelo, I believe this should be picked up for -next?
> >
>
> I'll pick this up for fixes, as I've already sent the PRs for v6.9.

The socinfo driver is in -next, so I guess you could pick it up as a fix
for v6.9.

ChenYu

> > Also, mediatek/v6.8-next/soc is missing from mediatek/for-next in today=
's
> > linux-next.
> >
>
> Fixing immediately.
>
> >> ---
> >>   drivers/soc/mediatek/Kconfig | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconf=
ig
> >> index 50c664b65f4d4..1b7afb19ccd63 100644
> >> --- a/drivers/soc/mediatek/Kconfig
> >> +++ b/drivers/soc/mediatek/Kconfig
> >> @@ -72,6 +72,7 @@ config MTK_SOCINFO
> >>          tristate "MediaTek SoC Information"
> >>          default y
> >>          depends on NVMEM_MTK_EFUSE
> >> +       select SOC_BUS
> >>          help
> >>            The MediaTek SoC Information (mtk-socinfo) driver provides
> >>            information about the SoC to the userspace including the
> >> --
> >> 2.43.0
> >>
> >>
>
>

