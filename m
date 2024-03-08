Return-Path: <linux-kernel+bounces-96785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A437D876165
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437211F228A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972545380E;
	Fri,  8 Mar 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmIoS585"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB68C535BA;
	Fri,  8 Mar 2024 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891809; cv=none; b=FCvv4HmZ2IBhR4nx73Nf873Alm7phE4PBlCmm8s9+fizh4zgW6zQA9ZvnbaZ9R1KM40DQSCl+nGhOqLQlbVjFaQyAsCiPJwn2j5KvCSWgmf+Yr+IB7mgOO1zOdjYMIqL711Jt9E33sG8fmylqnaZIkSVtSRgmo5wFPnULO4yVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891809; c=relaxed/simple;
	bh=55ZsZsM23dDpjtV/FwUzKlyNeM4KZjQdEa/eD7xqQ1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mr3g8CWSAvcKL2e/wjPRFKpmYdrUftwYtNBY25hW5bBK/baWQWxCRfltsbfH6DvMRABi10EOFuyVX2z5atet0KNYpDED6YyMAjFmcW/K4zX+f1LyAuRGKRSsX2i8/JsCK+kMn6GEv6wCbr4SHbXWhOm1JXcrtEU8EQKHxmRteMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmIoS585; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5683093ffbbso386798a12.1;
        Fri, 08 Mar 2024 01:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709891806; x=1710496606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55ZsZsM23dDpjtV/FwUzKlyNeM4KZjQdEa/eD7xqQ1s=;
        b=VmIoS5850U2l1YXcE15Bthw0XNfQBCNAlskUSOQ7xJT4/hK94Oo185ol694Tpv/CZH
         3sMDLpezp4OYjTRG17KAqmoUsPrHF3JbZOlwk+KX7PcSz7nFcGkKSsjxAL/dCEq5GHeW
         WOaLIvWCo0Dwk1h5njl5MneoVlJ0fNXlpyxEfjY9Q0Keb3ExZV/EBSSnn8Dq+NUDGIQC
         hpBUxpF/XbeUk20tjJLAGlX6eAI9OxyyFLCkQIZebpDDeOWCSz2e9x+UhuErsDTUenwp
         wLwqk92e72MF1aU7QT9ICUO1jRQpCt+40qyiNW6TrtvF4vzFqfVSxZ7/86X+YmhPHx1A
         OTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709891806; x=1710496606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55ZsZsM23dDpjtV/FwUzKlyNeM4KZjQdEa/eD7xqQ1s=;
        b=F/GG0ZIDERyj8F+LcZGRC3FZ+RDCrLT3WpSlNs1p3eKmjYepy8GyVJC5YEwPBuNdmE
         z0/wBt8eEpLIUBwbXnY8GHtBgdplWr7e2tC1tQmMXh5cPhDpPThVDKJdzQa0oAlxRg7v
         qnF3gjn9zWjcdx7Y8P5gxR/OivqlFN1l9OtwdzaHwtXcYXu2cpygFolQExEgm36jEej8
         TRmffNDE3ukXsFlYRyEnwmQRwgPRBjrLOvVz427KzZuQa3Qtqc4q0Ibs7jhHHTWQnj9n
         xksP6hRubD9ODMzBznA33s+c6TB/UZd1RJBtJ0DOQ2RMURgSriBDJZKpq8/TtWBf07KG
         4x7w==
X-Forwarded-Encrypted: i=1; AJvYcCVBHzBeCFWMGsHQIl1Ekorb7YwzCwaxhnQjtM/s1FMIU29NNW/pCGW/5eRTnCZcgDJUShcntCGYlkG7qSKTus1VX6OUyKQByTZNfh9i0bCDN8ocst9iMjqUxlwjFCJAH9E64jrB3SEnOOnsn9Q/hkwRFSXvp64wNQZ+WLtznq9INr7bJpI=
X-Gm-Message-State: AOJu0YzVEJqL1fLncu+uGRW6sys5d5JFIXQXzfVrq2HOIq89NhDMmh38
	BgbYrwe3vKYTg5OHlR9W0I6kjqkb7xbrUCKQEYHx2wG5a7yDpfWrcd6/+Ioc4Nn64R0odb8Xef8
	kz+LQ/26ZHcDqv276KRptHmTwg9U=
X-Google-Smtp-Source: AGHT+IFxrb/Hq8yGxAFksIU8xvoZYxKDmP4t21NJlafgwJOZ5O729ZO1fWabxK/Qr2q+/DyOC/+KljCWh48RD29qoIE=
X-Received: by 2002:a17:907:8b8b:b0:a45:f5e0:a539 with SMTP id
 tb11-20020a1709078b8b00b00a45f5e0a539mr250323ejc.25.1709891805926; Fri, 08
 Mar 2024 01:56:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
 <20240306235021.976083-4-chris.packham@alliedtelesis.co.nz> <87edclgoon.fsf@BL-laptop>
In-Reply-To: <87edclgoon.fsf@BL-laptop>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Mar 2024 11:56:09 +0200
Message-ID: <CAHp75VfmSWH3FWEHU+bGYDuo-nt1DJhY5Fvs83A-RGrtrsgWTw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] ARM: dts: marvell: Add 7-segment LED display on x530
To: Gregory CLEMENT <gregory.clement@bootlin.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, andy@kernel.org, 
	geert@linux-m68k.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, andrew@lunn.ch, sebastian.hesselbarth@gmail.com, 
	lee@kernel.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 9:36=E2=80=AFAM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> Chris Packham <chris.packham@alliedtelesis.co.nz> writes:
>
> > The Allied Telesis x530 products have a 7-segment LED display which is
> > used for node identification when the devices are stacked. Represent
> > this as a gpio-7-segment device.
> >
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>
> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>
> Normally, this patch should be taken in mvebu and then merged by
> arm-soc. However, I haven't seen any other patch touching this file (so
> no risk of merge conflict) and I think it's too late for me to make a
> new pull request to arm-soc. So I'm not against it being taken with the
> rest of the patches. However, I think it would be a good idea to see
> what Arnd thinks about it.

Arnd wasn't Cc'ed, now I added him.

--=20
With Best Regards,
Andy Shevchenko

