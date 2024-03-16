Return-Path: <linux-kernel+bounces-105110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C068C87D939
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68843281647
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 07:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D97EADA;
	Sat, 16 Mar 2024 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0psW86V"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2F11CBA;
	Sat, 16 Mar 2024 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710574944; cv=none; b=hbqA5PpMstk3ZumJQCF+BAw1H05c2B31wA9tVKhaewCR8A2KKkm0jNQYaHXat7QYxf0nRSI8ZIbmxJMZ9ZENw6/fo6eQyb3TOubVLKBXgcbLNDvEIu95To/SaBKoC/5id3jWCl7VIUaOhX52s2zipBSksoCylvkD7NsZzlFtUMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710574944; c=relaxed/simple;
	bh=56JqIBcIZt2kuj5bkWl7JtIP0/zRXh6D3VTqXoclOtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BA5M/L/z+btxTk6Om30RGOwjwEnBBS/xtMQGD6VMXchIW6qyK6gzKuyo5+XlRu4mbrDc1ZOo55OsQkPUAjXkedrHgt5waRG4QZENp2DLQPcyc72YKacVx7lR05y2DynG1efvqiBvINEPlWhy2gowbCiwFMFAuLHGa6pr0NPStNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0psW86V; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ddf26eba3cso1895940a34.0;
        Sat, 16 Mar 2024 00:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710574941; x=1711179741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBPpCGPm72Cb2qGJkp1BJBbjbsRni3kHlr8127B2i6Q=;
        b=V0psW86V7xVIs1L3uO8AV1C+AbMqsRifzAEXehuVDuWEK/uUztjz3eHboBarOv7evZ
         umjLttYIufffqmeq9d/+tkR0JUPIllasIK1outpNYzxtp7ORMGCysSuz1QCdTjYnI/2Y
         q+aymYdpyk1mYdCA3qF/H65zo1/XsbnhqWDymquRQq2lOSjZHb7ancMEkTRBwoM4gUJk
         vDM6kTm1Hli1+QYfbbsrTtn5XcnuOjD2VFFM3Y+LN6dG20kJXnIPbWWSNrH/tZ/9oIdC
         12z5P8462sJiPJ6fZBGgcAtvja3XWqgHNjDvLZFCDcdoCFOoK2p/Plh44IjuvUkLlXxn
         7aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710574941; x=1711179741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBPpCGPm72Cb2qGJkp1BJBbjbsRni3kHlr8127B2i6Q=;
        b=fBuYgylIAk9z/e3MaxHy+218pnvLcJ/p4rrZ5QL5cg2iR/xP1mCq6cSvZFB20MwOiI
         9lYCUMynXhKT3RM9QHjfAfES2eAj8ZB54HYbGQ0PwlvC2fP1m6HRx5CRSy1VRr/Kl53i
         ZeELdkIXSPS1qUsTLm+AXa+pjQvjozg0CdI+L6YpBGOcAPb2xJk6Kg/kRvJfrvblWDpx
         PjEFqSs0SVVnm48WJ4knnu/Ctn3KK9hGTez6CphJByCDOo9i+/9BYl+mhPb6Px2cMjFk
         rxbzjPwz8TQsmNuW/CmnnWNhKxyUdtUnIlEfdbob0wiqzqQlMysaBW5w2MuPKx78PlDf
         9LJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUENjXAcDm0nQMPYnqNXtQoczNp40+ek4a7cZLPLR43lRqbTU8+Hd9G74449GIDQpJ70uXB74pcusbtU3Lw6keRPm5vgWKDDjSqBIxjKv7BF9Yqblbk7x6MJZnSrpmDJfhIPy/OndLN98kH7pPnlwk3OkLfmzf/1tlwSXSd3aqurgM10A==
X-Gm-Message-State: AOJu0Yy1KqCKcksrwrAKJKh9DQWyj6kwQr7BVIG+wroWlPuxx42Yg7Zk
	Qeh8ZDBK8NKCEvTB7X+r+eak9m/PT1Vo2wnXtLg/d8rdlmVQn0P3cQkGtdZYtho0Jv4vpWi/psg
	ohuaxEqBIjhJx4ceUuIhv1o2mv6Q=
X-Google-Smtp-Source: AGHT+IHFNWlMLUEZGtMU5YFLrS1fjFOJ1VLXDJxxjl14Ouo+4V1Hu0pW2Hgiyq5Bpke3rnCc4Mt1Lm0rTUKZ3zYrE1c=
X-Received: by 2002:a05:6820:20f:b0:5a4:93b6:9a5 with SMTP id
 bw15-20020a056820020f00b005a493b609a5mr297421oob.4.1710574940386; Sat, 16 Mar
 2024 00:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314100131.323540-1-qiujingbao.dlmu@gmail.com>
 <20240314100131.323540-3-qiujingbao.dlmu@gmail.com> <ZfT42gzJhVd1NQzd@xhacker>
 <jtqqbpr4qeo4m5oetmmusf2hy2wy6hnpstl344p2hu62vbbqrk@tefqeoqf37jh>
In-Reply-To: <jtqqbpr4qeo4m5oetmmusf2hy2wy6hnpstl344p2hu62vbbqrk@tefqeoqf37jh>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Sat, 16 Mar 2024 15:42:09 +0800
Message-ID: <CAJRtX8TV7AEC7_owA819X_NzTS9Y6WdbHED1NQZWWfTK_zYcww@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jisheng Zhang <jszhang@kernel.org>, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 3:22=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Sat, Mar 16, 2024 at 09:41:46AM +0800, Jisheng Zhang wrote:
> > On Thu, Mar 14, 2024 at 06:01:31PM +0800, Jingbao Qiu wrote:
> > > +static void cv1800_pwm_set_oe(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> > > +                         u32 mode)
> >
> > Did you get any information about the capture support pwm controller?
>
> Instead of adding capture support to this pwm driver, I'd rather see
> support added to the counter subsystem. That's more versatile.
>
> See https://lore.kernel.org/linux-pwm/Y3aze3B6%2Fe5uWS%2FH@fedora for
> some more context.
>

Thank you for your suggestion. I will add support for the counter subsystem
after communicating with the hardware designer about the input function of =
PWM.
Do you have any suggestions for this patch?

Best regards
Jingbao Qiu

