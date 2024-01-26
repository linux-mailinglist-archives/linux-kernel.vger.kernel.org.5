Return-Path: <linux-kernel+bounces-40619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CD383E346
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C33B25F13
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE3B22EF9;
	Fri, 26 Jan 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJO7+fDa"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63095224C6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300428; cv=none; b=H5nfqU4483FVesnlq4yw4Ia+S7/xqh8D8CLMv8KWAiilfi1iLk4C+TPFEF+cRwBlkJGlfSZ8tfoDoH+wPfN3EKzgjYZy4+o8+u5MjrtkarukwNHgO5ekvtnLI/ZRrVSSQ1FO8lJeAMNWRky0DpWORxME0PhW+7jtVQpMQNK8PsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300428; c=relaxed/simple;
	bh=0QVr6e1yVP4AXNZ8tCNd7LlzE2EAoRSXZyqFZuyYf9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRvZ7VzQA9jaKF2YqURMfAW9NSYDQ5zjOt9v98ilh/ZaCLJ5O2ts/0Qy4ebN0je2AMnCcrvdkNd0+RZgSShUH+OJZllKo8Uk9bb/vsAlCGmAAZuxQjOlzft9nuDzcJsFc8m92q5v9nL25a51BfXktDnvL/5rSlyiWNywXiBjYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iJO7+fDa; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso856758a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706300427; x=1706905227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hngwMmw0CMu+aQzeJ/vJLKSkYpVp3nABDQUuqcSnNU=;
        b=iJO7+fDaB2+tjU4NWl1dW7T9ov2qtfX8xcOLQMPxHdDQQCO+9/LGMRdv2iKR7yqLCG
         njCiGdolwo2DZDsRaP3YN+8fpHSh2eYbIYUai9Uukg5gTrVc24xC39P0OTukjxolYhXv
         WeXpH7cn9u1/3ZZITRLUwqKKSZ932AaBLG6BzXquXcJxIVSZYogCPwjdUH56OONLgnfM
         QsD1ZuSfdyZuRsQStjrbkvZc8bHVnEni+l9wbqyzxG7lCHNIYDnIsm2tVQKOauj+N2wQ
         /LRNhMD4KbwDsfhyO3+HShQ9C+Fh7l8jLpVEef7gwWA6p0C6UIuPfzD1Bf77bZusaYlp
         tkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706300427; x=1706905227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hngwMmw0CMu+aQzeJ/vJLKSkYpVp3nABDQUuqcSnNU=;
        b=YDa7RoWi2FMwE1ig42RDNY9ecbZiXJYCmgiLxMNEpuPgs+bWMG0zPoU6rn5KTQVxI7
         7xOiyWn/hm9jjisa11qamfyG38yT8VkXwo36HphwR1dCEtGAQBe71+668C/O5zIOEb3v
         g0ZcLnJOskvWSezELNet0IlRTrUYUERlXtBmA4PeG2MDBUjgs3Qbjx54l1KGlgsVET75
         Q8pTY8sXJPRsW7XDrWrg3I42sjf9y7yrs40T+CdGoovbPIR8PP3bMppsXVg4cc9Usm9Q
         9MEAsQQYmDLB9OqCmC6WfLTjfBnJeKKNYxYekuYrgl6ei49lrCAVA9JQKEHi/l3C9x0w
         Fwtg==
X-Gm-Message-State: AOJu0Yyak2fJ8z8UOIWLqtKv0kxnuitYqvhZq+9+SXIx5ejMURpR9LqW
	jMAVcWbK+dJfaZfXg6nq7MQ7ersQ0G2shUNwrz89OhuLKG1UpLDDVtGg72UdkT3w/1mvkun6k9g
	etnFV+SQ5EdFbZNHoxiO1jDWIOrCoQAvs85fPCQ==
X-Google-Smtp-Source: AGHT+IHcz6HGHceI+yFT0bDUAkcnfVNGde9xTcM6zAAeHQb2U7iCDEfNKGd9p/lSNLeIa69wjDe5wOQrwrB9217TK/M=
X-Received: by 2002:a17:90a:5784:b0:290:bd97:aa6 with SMTP id
 g4-20020a17090a578400b00290bd970aa6mr418048pji.48.1706300426762; Fri, 26 Jan
 2024 12:20:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-24-tudor.ambarus@linaro.org> <1e117c5c-1e82-47ae-82f4-cdcf0a087f5f@sirena.org.uk>
 <CAPLW+4kTUmG=uPQadJC5pyfDvydvr1dKnJY6UxQva2Ch-x7v3g@mail.gmail.com> <e4b76c3d-f710-4b32-aa30-23cb54346d15@app.fastmail.com>
In-Reply-To: <e4b76c3d-f710-4b32-aa30-23cb54346d15@app.fastmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 14:20:15 -0600
Message-ID: <CAPLW+4mQ=q1c061Zv=dxnHwMJtjH5sbQsvg25x5uzxL3UCAuTA@mail.gmail.com>
Subject: Re: [PATCH v2 23/28] spi: s3c64xx: retrieve the FIFO size from the
 device tree
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	krzysztof.kozlowski+dt@linaro.org, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Peter Griffin <peter.griffin@linaro.org>, kernel-team@android.com, 
	William McVicker <willmcvicker@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 2:17=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Fri, Jan 26, 2024, at 20:23, Sam Protsenko wrote:
> > On Thu, Jan 25, 2024 at 11:33=E2=80=AFAM Mark Brown <broonie@kernel.org=
> wrote:
> >>
> >> On Thu, Jan 25, 2024 at 02:50:01PM +0000, Tudor Ambarus wrote:
> >>
> >> > Allow SoCs that have multiple instances of the SPI IP with different
> >> > FIFO sizes to specify their FIFO size via the "samsung,spi-fifosize"
> >> > device tree property. With this we can break the dependency between =
the
> >> > SPI alias, the fifo_lvl_mask and the FIFO size.
> >>
> >> OK, so we do actually have SoCs with multiple instances of the IP with
> >> different FIFO depths (and who knows what else other differences)?
> >
> > I think that's why we can see .fifo_lvl_mask[] with different values
> > for different IP instances. For example, ExynosAutoV9 has this (in
> > upstream driver, yes):
> >
> >     .fifo_lvl_mask =3D { 0x1ff, 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff,
> > 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
> >
>
> That sounds like the same bug as in the serial port driver,
> by assuming that the alias values in the devicetree have
> a particular meaning in identifying instances. This immediately
> breaks when there is a dtb file that does not use the same
> alias values, e.g. because it only needs some of the SPI
> ports.
>

Exactly. I guess that's exactly what Tudor mentioned in his commit
message, and he's trying to fix that very problem by relying on
corresponding dts property (in his patch series) rather than on
fifo_lvl_mask.

>       Arnd

