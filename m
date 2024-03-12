Return-Path: <linux-kernel+bounces-100240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C88F8793E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE811C216B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625047A14A;
	Tue, 12 Mar 2024 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nuQU3m+A"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8007A145
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245686; cv=none; b=WOCVdF0XqVdWOPKQAb4z68dH6c94wYxD/2GvgU1hvhmaM6BSfttVc70PWm5gGazFHguxDMFmuBXsUnsU1iXva4rRnZ7ZW797+KdfpyoGWlK1N974MwcqqDHWSvmPAMfaiaeNIbrT9NF8siil3mCYt95ZdOe806Zg0sZ5zqzoNFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245686; c=relaxed/simple;
	bh=duOeKCS6bveowPG54FKvXNovbWkIKFNUj3Vc2HDZcO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aa5llCD8mJLvhoXL1+A5oXfBHG/ybR64Rup5KrynLWlDXizuFdPD6tO0PS81Rd/xKNBR2OG1VUmR0JWWDQvK1bdB9CNcDQ9OjYSBBlu0INeyDFb7IsWRe79EXw3VWd4dpHllCqJ484frMdiRuuVTIGeYmcoOmktXZZCE5m9UMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nuQU3m+A; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4727b9d7b1fso763247137.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 05:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1710245684; x=1710850484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZC0o0r2wFDW28FPKH9Tb5iKiJa9D3c2T5RaNX1TwfI=;
        b=nuQU3m+AQmfF4KSfY2hHxbJ0RugcJEwPmyY4stpNsvgAkKRw/EGRk/6P0iVrzdQwXm
         zPm/Z5as16PYXpuIVzM0jT4WueGxMunEAJNqLXroV9VKovIHiYLX53yth+fqZfbcaRq+
         DWenlwJl+x5Wh7p8+foQVNzU8zkFcB8a471UDbqVZl64SUKUBW1fcgVXkjX6LE9ICRp3
         BS2MOOzGpNCdvIM0ChddM1D7Zrx3H/acYKsxTfpv7wMXARoyYTd+cq22PPCyJ3Jrg8jq
         CtIfAKZRTft2TMmhUodPs7NYwLjYnSC30ppJyjBuffNiTbHHEWtBQTxAYdVhh0CO8lif
         UATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710245684; x=1710850484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZC0o0r2wFDW28FPKH9Tb5iKiJa9D3c2T5RaNX1TwfI=;
        b=HtcWwV+DJtCqOdR1wbj7TuqNNC6w+hiTxuJCQxOcixk76YwJJqZYiOdkS205iI70fe
         2MNnu38lrinqKaXM0yfWLl8tFQk9rjx0jnXclXA59udWHsD1xOz7QeYLy3EeaZ6yoAC6
         tT5V2HQG1x3pphuke4Ni9NsmfPk/ZPJZU/WLOmLZdVoc/Z8S27dKUkeVHwZE6FzBVZjv
         0MV3iGt91K/4SB5WLqOr0UEFcljBf/ldcEHogCi5P5CIOTIvoukh4KU/wzffUsJBdGfE
         3sR51HTw3bRGH+hhZXpilPsDPWmxih6iFcbawOgn6IKHzpfueegYtEXCYXUHIVT/p9qF
         tcEg==
X-Forwarded-Encrypted: i=1; AJvYcCW0ldPPmgBGDXmMKyLU+twSzYb2JO4uZj6rOjGNzbQoetQWYfGO0Dx0cSkdU2pPN0tacDZeo5X0ldOVa5o9+igOsPDUuXSJp2DBV2X6
X-Gm-Message-State: AOJu0YzGxI0LT/49jWK2+JdlQ57QcYqeiyx43XmJPBcJJHurGazy/7x0
	wAbmCR/uDt4ySoq64+c6pB2SZowujdqpZWqeZDdwJ9dvGZI+GLDip/vb/MjYFGVZjB+zVQ681o8
	gquxXis7kaS4x+WzElKP/wTQ2zUvn3w5e7eUCEQ==
X-Google-Smtp-Source: AGHT+IGC6GWeZ2uR1cZhuSX5z92E2OTDgg+XTAjGxI/njmH7eNlkIR7bUmLNMi0nRjdzhJz6htsK6DVHtdg4w43ul40=
X-Received: by 2002:a67:f492:0:b0:474:c602:f4d3 with SMTP id
 o18-20020a67f492000000b00474c602f4d3mr380845vsn.21.1710245683902; Tue, 12 Mar
 2024 05:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ae643df0-3a3e-4270-8dbf-be390ee4b478@moroto.mountain> <CACRpkdYtiyHgvtPJYxq2BNb9UxthwPQPHyUddQ5Q1eat1NY4XQ@mail.gmail.com>
In-Reply-To: <CACRpkdYtiyHgvtPJYxq2BNb9UxthwPQPHyUddQ5Q1eat1NY4XQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Mar 2024 13:14:32 +0100
Message-ID: <CAMRc=MfvKy=0d3mrE5NaZMdVoG1P5s8AakrrQy+D+9a5Ua3Uqw@mail.gmail.com>
Subject: Re: [PATCH] gpio: nomadik: remove BUG_ON() in nmk_gpio_populate_chip()
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 12:52=E2=80=AFPM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Mon, Mar 11, 2024 at 12:00=E2=80=AFPM Dan Carpenter <dan.carpenter@lin=
aro.org> wrote:
>
> > Using BUG_ON() is discouraged and also the check wasn't done early
> > enough to prevent an out of bounds access.  Check earlier and return
> > an error instead of calling BUG().
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>
> Thanks Dan, I applied the patch to the pin control tree since the
> rest of the stuff is resting there and Bartosz already sent his pull
> request.
>

Yes I did. There were no conflicts in next with nomadik updates so I
figured you'll just send it yourself. Let me know if you need anything
from my side.

Bart

