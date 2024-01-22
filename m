Return-Path: <linux-kernel+bounces-32529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DD9835CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BB71C21E04
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6BB21350;
	Mon, 22 Jan 2024 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9Wi7kHO"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F98210E0;
	Mon, 22 Jan 2024 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912453; cv=none; b=RwhA5yDKY5FGddVo9JEkBmyOFL77nI3Wk08ILEaNDe4Nisy6s1eMdmUGuQ+QoVPoYBEb2sptx7jba8rOgUIwfDLU+01XJi/XILHjn7ToVnD9IeN18NV1EKKIp4w9gI/1OmM47svdF0qWIjXCDqWPCHUFF8BwJ70SlG3BGwM6ZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912453; c=relaxed/simple;
	bh=zkwnvGLbqFItCCRb578zOlJjANzoAer2/ivLxkfy9/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpCnOfGVXyUrSb8OphCcn6U5AHIwfbgz8TjxDd3iipedbbio2h4T4RKXW3kaaZBOP55ftzYP8j258bCtAh2hYzE3+15Xft6MmEVMJW6pNSuQ4CcFxjIyYdEfFL+43Cbh7TWTSL+W2CDyhxAeH1DP22QR4VqGC1yfjXfH7D7Dx+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9Wi7kHO; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bba50cd318so3346930b6e.0;
        Mon, 22 Jan 2024 00:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705912451; x=1706517251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkwnvGLbqFItCCRb578zOlJjANzoAer2/ivLxkfy9/8=;
        b=g9Wi7kHOsGPpc1pGhcynsHRjFIYivRW1rXqB1UENSYD2rGJLSAJMr8MHvBnNzd6vnG
         MXgVq3ytt4GK1vmpFuSZyhv2oKZQBjPUiU0i3rKonvl6Ob23OJ1dsAE61u4fep8LmLl0
         lRIXJTXemfyTZGHu2Wnst9NNURlv7cZOKlLFRgN1+3DDzrKG5ghLlwZL9jBpMvUHBK+P
         9cllRpHWwpKKe8z7xCYpd2Ws73TjhFAKpf9RjUqy+2b0kauDzvbxIEa6GJklm0qvidDL
         G6HR19LQK16NthfEzii9zj6+yutsnAUlebtQb6d3bZ6fK1Rtv002iytqGBSEmdk7ZCCy
         Jc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912451; x=1706517251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkwnvGLbqFItCCRb578zOlJjANzoAer2/ivLxkfy9/8=;
        b=IOWpYZHAmjgErh152k+EsT2z2Frj6dgyyOdJi6fkSvl9QnhNgY3/JfDjNWV+5FM3Yi
         gX6/IZYLgS891qgR1D81pXmzUNkme2TO/+F9ifYDpMBmvmxxbjDFANgt/UDaBOA9bjux
         eFtJeZl4UxYC9S1Ad68Wq7HzqsBN//+rJtrU5BmRbgXuaSXvGJOVFt0rGVwiEnuSVOwH
         LYhUkH/fHSoGb/sigsz3u1V/tR5bS2ECAwovgNetZJLchgkRSAfDaNdIiB5FkcHSjwmu
         uDicJJFs+kEHYIkdGbzm5AhPaeJ0cgCa+KwR07Iv0epL8aWbHjT1B/841I3duPTunVg0
         kTjw==
X-Gm-Message-State: AOJu0YxJe4cDVDuHZS5sviloGtu9KcWCDAJpmp42uxVcWI8td/nZs32D
	uoVuizR7q6Q1SkZqpQfIWHkVwPMcAmeZXT0Vy9KFu1qi1FQMVL1IivdzrEu1vE6B97e7QMutb4R
	Q0dGncz8IQHPkwwgynuu/UrDBYLY23g8ms94=
X-Google-Smtp-Source: AGHT+IG0io7o6XQcMrNeVFyA5PaNM0P8uNlw0Diun23kc9f7dbCBaju58RK0zmyPDtcdlrZAzZ5TzBTnGyXVyuK2x30=
X-Received: by 2002:a05:6871:549:b0:210:d1b9:dda2 with SMTP id
 t9-20020a056871054900b00210d1b9dda2mr4790038oal.3.1705912450867; Mon, 22 Jan
 2024 00:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122080631.2880-1-qiujingbao.dlmu@gmail.com> <20240122081722868bdda5@mail.local>
In-Reply-To: <20240122081722868bdda5@mail.local>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 22 Jan 2024 16:34:00 +0800
Message-ID: <CAJRtX8QU8iHY1oQJ1uDN3YOmCeN7SH+vPC8nD29WS5+2DT1oKQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	chao.wei@sophgo.com, unicorn_wang@outlook.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dlan@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 4:17=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 22/01/2024 16:06:30+0800, Jingbao Qiu wrote:
> > Implement the RTC driver for CV1800, which able to provide time alarm
> > and calibrate functionality.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >
> > Depends on https://lore.kernel.org/all/IA1PR20MB4953C774D41EDF1EADB6EC1=
8BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com/
>
> What is the dependency?
>

Thank you, this driver requires support from the CLK driver.
I will add an explanation in the next version.

>
> Also, please fix the checkpatch.pl --strict warnings

I will use the -- strict option for testing.

>
> > +/**
> > + * cv1800_rtc_32k_coarse_val_calib() - Using an external
> > + * clock to coarse calibrate the crystal oscillator
> > + * @info: the device of calibrated
> > + *
> > + * @return 0 on success, or -1 on fail
> > + *
> > + * This RTC has an independent 32KHz oscillator. However,
> > + * the accuracy of this oscillator is easily affected by
> > + * external environmental interference,resulting in lower
> > + * accuracy than the internal oscillator.Therefore, a 25M
> > + * crystal oscillator is used as a reference source to
> > + * calibrate the RTC and improve its accuracy.Calibration
> > + * is completed through two steps, namely rough calibration
> > + * and fine calibration.
> > + */
> > +static int cv1800_rtc_32k_coarse_val_calib(struct cv1800_rtc_priv *inf=
o)
>
> This is still not working as well as you think it is. You should
> Implement the offset callbacks instead.
>
I'm sorry, I don't quite understand offset callbacks.
Do you mean that this function needs to be executed periodically.

Best regards,
Jingbao Qiu

