Return-Path: <linux-kernel+bounces-92876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4988C872754
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8251F25FFB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0D424B29;
	Tue,  5 Mar 2024 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Bgz3QteW"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B461C2BD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665890; cv=none; b=srt+JsOeojB8vHFmVOzpXqnvYirqrrEXlQirnrcC1KxKfKVgHKMCMmj05Z9nuwG4NZ+gLrCAUgmmbaPA+RA3yGIUUAiIuMj+aA9eLupJCUsQSBhffqzq4YKWxttj9IDqX5xbphkYqyEONfN56X/n7H7IA4bDCkkIrOhKrbE8ulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665890; c=relaxed/simple;
	bh=EmazSDYJNF/9+QGKc0N0wE9a8wCKrzuioeOJExzJZiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2VbC5sz7RGMrikPBtPA6VnTKKwO+9LGNSu9AAlIMrOMteZT7LHz4tpzpZWPEn1f4/3Oa3jsyY795rbrQ3o7krainh/iHvf3fwKO+gE+gpF+C/EyLem/NAoSeqk/n1t2VxrsqXzsSYfENz2R2hKsVJcgRQ5duhbmsC0KRYe40DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Bgz3QteW; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7dad83f225cso33086241.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 11:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709665888; x=1710270688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWII9KL0aIa47qOshj6cnyrnk4IdQFQfKpUZL8v8Yz0=;
        b=Bgz3QteWITe0FMHwt4rXl34mdez8c5wynCZdBMNiVd1X9O1IGvvHYI9I1g1pOo1LrT
         aajD0w+lNpo/U073GZN3/UCuqEWAo7YdolTZqkwNU/P82WmWaD9TU71w+KwcZYdujLnj
         5slbDTKE8P0XR2GjthSmT8nXZG+Ni7K09I3QQW4hf2nwwBypqBAAkAlE70fiZwUSVDyz
         6Gh9VWU6yko5etBIcngA/8xn8EdFuA/NyeNbuMw6HeGbaUyGUcL86ZwXaX2bt5ZKzdy+
         s+V6ieoI9A1d0wsi/OYLHy3uhmYZDEjWylR0qDNnLETuEUUxXCm/Jx9o5sEp7SXBSks1
         CUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665888; x=1710270688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWII9KL0aIa47qOshj6cnyrnk4IdQFQfKpUZL8v8Yz0=;
        b=HTFKlIqOaeqJeTm4gs2AmnoMJkiC2I8YmKKzc6cpn+c91vTvC5znZH/H2v38KpXCvT
         zfuDsMYbellM968mkwDKY+MKQHNZCMnW7448Q1+0cOuk9Kt5wJrpf+IyZ0o1BfN4/JEX
         v1ad1H9lSKdFQq3UQJNKAUxsNrCi0IxXV5Mc0KUTbubZLc3ZLdulT+ZNL9QSX9LiLF65
         dzCIgfbz+XV/EByYw4fh2QVosEhu9j2ZX3cbIelRnJpuwUiW8vAHWKDMc9bUOlSN8FuU
         3RCl2K1iX1Z6GUDDj4lTIMsmGObHVWab/XZktw6tD0MtYeR8tEjMned5GKG6uAI0xy/E
         Eq/A==
X-Forwarded-Encrypted: i=1; AJvYcCXdldbUu/xrH3Mh08OaybdKKTRN4awbLVUpov5dfn4uddZ6xMkE2Fx1GxNGMqHExK11hiMipDxfZLKWdOEtQFoVut9ScSwE0imDSABQ
X-Gm-Message-State: AOJu0Yzs64rFPUX0aOJaPBrcd+G3GXtQvHNDAr9IrUQlOpNgwRIjdwu4
	M06BiGLACaUDoivTWLke8KPYD/okpcXb7LQVOd1P7MI5srvrXmFavkkssvE124JKlwTc8gCbjY5
	g37K9sz9qTFvxS1Xz1WmHMiUe2CWZhGAkMsSNCKfujUzj4AcDw2Q=
X-Google-Smtp-Source: AGHT+IH8rdsznZi8Kx7lSx7e9c+/zJt25fYd74gaX/zf7NZQhXeC6fq+bOz5mcO4LnimWrk7SNgva16p6F5Wz+UnIig=
X-Received: by 2002:a05:6122:e46:b0:4c0:7756:547c with SMTP id
 bj6-20020a0561220e4600b004c07756547cmr2101976vkb.6.1709665887732; Tue, 05 Mar
 2024 11:11:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-multi_waitq-v1-0-ccb096419af0@quicinc.com> <20240228-multi_waitq-v1-1-ccb096419af0@quicinc.com>
In-Reply-To: <20240228-multi_waitq-v1-1-ccb096419af0@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 5 Mar 2024 20:11:17 +0100
Message-ID: <CAMRc=McSbTmActdZ_JR+sFuW65TT=mfM+xgBFFs_31dMAO+4kA@mail.gmail.com>
Subject: Re: [PATCH 1/3] firmware: qcom-scm: Initialize waitq before setting
 global __scm
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com, 
	Prasad Sodagudi <quic_psdoagud@quicinc.com>, Murali Nalajala <quic_mnalajal@quicinc.com>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 7:50=E2=80=AFPM Unnathi Chalicheemala
<quic_uchalich@quicinc.com> wrote:
>
> Suppose there's another device probing at the same time as SCM driver.
> It calls into SCM and triggers WAITQ sleep but waitq completion
> structure may not be initialized yet.
> Fix this by moving initialization of waitq before setting global __scm.
>
> Fixes: 6bf325992236 ("firmware: qcom: scm: Add wait-queue handling logic"=
)
> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qco=
m_scm.c
> index 520de9b5633a..c1be8270ead1 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1854,11 +1854,11 @@ static int qcom_scm_probe(struct platform_device =
*pdev)
>         if (ret)
>                 return ret;
>
> +       init_completion(&scm->waitq_comp);
> +
>         __scm =3D scm;
>         __scm->dev =3D &pdev->dev;

If another driver can actually probe at the same time then this needs
to be moved to the end of this function, the `__scm->dev` assignment
must be done before the `__scm =3D scm` one and it must use
WRITE_ONCE().

Bart

>
> -       init_completion(&__scm->waitq_comp);
> -
>         irq =3D platform_get_irq_optional(pdev, 0);
>         if (irq < 0) {
>                 if (irq !=3D -ENXIO)
>
> --
> 2.25.1
>
>

